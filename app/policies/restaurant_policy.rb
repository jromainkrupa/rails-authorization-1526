class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # scope.where(user: user)
      if user.client?
        # scope.all.select {|restaurant| restaurant.user.role == client }
        scope.joins(:user).where(user: {role: 'client'})
      else
        scope.joins(:user).where(user: {role: 'restaurant_client'})
      end

    end
  end

  def show?
    true
  end

  def new?
    create?
  end
  
  def create?
    true
  end

  def edit?
    update?
  end
  
  def update?
    record.user == user
  end
  
  def destroy?
    record.user == user
  end
end
