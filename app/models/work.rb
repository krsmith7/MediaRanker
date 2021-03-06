class Work < ApplicationRecord

  WORK_CATEGORIES = %w(album movie book)

  has_many :votes, dependent: :destroy
  validates :title, presence: true, uniqueness: true
  validates :category, presence: true, inclusion: { in: WORK_CATEGORIES}


  def votes_count
    return self.votes.count
  end

  def self.get_category_media(category)
    works = Work.where(category: category).to_a
    # return works
    return works.sort_by{|item| item.votes_count}.reverse
  end

  def self.get_top_list(category)
    category_works = Work.get_category_media(category).to_a
    # sorted = category_works.sort_by{|item| item.votes_count}.reverse
    # return sorted[0..9]
    return category_works[0..9]
    end

  def self.get_top_work
    works = Work.all.to_a
    highest= works.sort_by{|item| item.votes_count}.reverse
    return highest.first
  end

end
