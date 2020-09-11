require 'test_helper'

class Madmin::Test < ActiveSupport::TestCase
  test "can figure out its model" do
    assert_equal UserResource.model, User
  end

  test "stores scopes" do
    assert_equal UserResource.scopes, [:active, :inactive]
  end

  test "stores attributes" do
    assert_equal UserResource.attributes.first[:name], :id
  end

  test "can infer attribute type" do
    assert_equal UserResource.send(:infer_type, :id), :integer
    assert_equal UserResource.send(:infer_type, :first_name), :string
    assert_equal UserResource.send(:infer_type, :created_at), :datetime
    assert_equal UserResource.send(:infer_type, :posts), :has_many

    assert_equal UserResource.send(:infer_type, :virtual_attribute), :string

    assert_equal PostResource.send(:infer_type, :user), :belongs_to
    assert_equal PostResource.send(:infer_type, :image), :file
    assert_equal PostResource.send(:infer_type, :attachments), :files

    assert_equal CommentResource.send(:infer_type, :commentable), :polymorphic
  end
end
