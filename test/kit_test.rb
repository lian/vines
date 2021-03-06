# encoding: UTF-8

require 'vines'
require 'minitest/autorun'

class KitTest < MiniTest::Unit::TestCase
  def test_hmac
    assert_equal 128, Vines::Kit.hmac('secret', 'username').length
    assert_equal Vines::Kit.hmac('s1', 'u1'), Vines::Kit.hmac('s1', 'u1')
    refute_equal Vines::Kit.hmac('s1', 'u1'), Vines::Kit.hmac('s2', 'u1')
    refute_equal Vines::Kit.hmac('s1', 'u1'), Vines::Kit.hmac('s1', 'u2')
  end

  def test_uuid
    ids = Array.new(1000) { Vines::Kit.uuid }
    assert ids.all? {|id| !id.nil? }
    assert ids.all? {|id| id.length == 36 }
    assert ids.all? {|id| id.match(/\w{8}-\w{4}-[4]\w{3}-[89ab]\w{3}-\w{12}/) }
    assert_equal ids.length, ids.uniq.length
  end

  def test_auth_token
    refute_equal Vines::Kit.auth_token, Vines::Kit.auth_token
    assert_equal 128, Vines::Kit.auth_token.length
  end
end
