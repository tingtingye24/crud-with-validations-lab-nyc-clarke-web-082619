class Song < ApplicationRecord
    validates :title, :artist_name, :genre, presence: true
    # validates :release_year, numericality: { only_integer: true, greater_than: Date.current.year}
    validates :title, uniqueness: {
        scope: %i[release_year artist_name],
        messasge: "can't be same artist in the same year"
    }
    with_options if: :isReleased? do |song|
        song.validates :release_year, presence: true
        song.validates :release_year, numericality: {
            less_than_or_equal_to: Date.current.year
        }
    end
    def isReleased?
        released 
    end


end
