require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup 
  	@user = User.new(name: "Example Name" , email:"example@mail.com", password:"foobar" , password_confirmation: "foobar")
  end 

  test "should be valid" do 
  	assert @user.valid? 
  end 

  test "name should be present" do 
  	@user.name = "" 
  	assert_not @user.valid? 
  end 

  test "email should be present" do 
  	@user.email = ""
  	assert_not @user.valid? 
  end 

  test "email should not be too long" do 
  	@user.email = "a"*244 + "@example.com" 
  	assert_not @user.valid? 
  end 

  test "name should not be too long" do 
  	@user.name = "a"*51 
  	assert_not @user.valid? 
  end 

  test "email validation should accept valid addresses" do 
  	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
     valid_addresses.each do |va| 
     	@user.email = va 
     	assert @user.valid?, "#{va.inspect} should be valid"
     end 
 end 

 test "email validation should reject invalid email addresses" do 
 	 invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      invalid_addresses.each do |iva| 
     	@user.email = iva 
     	assert_not @user.valid?, "#{iva.inspect} should be invalid"
     end
 end 

 test "email addresses should be unique" do 
 	duplicate_user = @user.dup 
 	duplicate_user.email = @user.email.upcase
 	@user.save 
 	assert_not duplicate_user.valid? 
 end 


 test "email addresses should be saved as lower-case" do 
    mixed_case_email = "DDFDfefDFsfDSFfdds@fooBAR.com"
    @user.email = mixed_case_email 
    @user.save
    assert_equal @user.email, mixed_case_email.downcase
 end 

test "password should be present (nonblank)" do 
	@user.password = @user.password_confirmation = " "*6 
	assert_not @user.valid? 
end 

test "password should meet minimum requirement" do 
	@user.password = @user.password_confirmation = "a"*5 
	assert_not @user.valid? 
end 

 end