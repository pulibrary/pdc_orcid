# frozen_string_literal: true
require "rails_helper"

describe "accessibility", type: :system, js: true do
  context "homepage" do
    it "complies with WCAG 2.0 AA and Section 508" do
      visit "/"
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa, :section508)
        .skipping(:'color-contrast') # false positives
    end

    # Re-enable this after the orcid auth feature is working
    xit "prompts the user to register with orcid if they do not have an orcid on file" do
      visit "/orcid"
      expect(page).to be_axe_clean
        .according_to(:wcag2a, :wcag2aa, :wcag21a, :wcag21aa, :section508)
        .skipping(:'color-contrast') # false positives
    end
  end
end
