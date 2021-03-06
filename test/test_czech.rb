
require 'test_helper'

class TrutyCzechTest < Test::Unit::TestCase

  def test_one_character_words
    assert_equal 'S kluky v lese i u mostku a na dvoře. O prázdninách.', Truty.czech_prepositions('S kluky v lese i u mostku a na dvoře. O prázdninách.')
  end

  def test_long_czech_numbers
    assert_equal '1, 12, 123, 1234, 12 345, 123 456, 1 234 567, 12 345 678, 123 456 789, 0 123 456 789', Truty.czech_long_numbers('1, 12, 123, 1234, 12345, 123456, 1234567, 12345678, 123456789, 0123456789')
  end

  def test_czech_hyphenation_short_words
    words = 'Vstříc, FAMU, např., apod., oběd, éter, Ivan, .'
    assert_equal words, Truty.soft_hyphens(words, "cs")
  end

  def test_czech_hyphenation_long_words
    assert_not_equal 'jedenáctka, řeholník, slevnění, sardinka a typografie', Truty::soft_hyphens('jedenáctka, řeholník, slevnění, sardinka a typografie', 'cs')
  end

  def test_czech_abbreviations
    assert_equal 'Např. zimnice. MgA. František Nedoma, PhD. Zábava apod. Tzn. diskriminace. 1000 př. n. l.', Truty.czech_abbreviations('Např. zimnice. MgA. František Nedoma, PhD. Zábava apod. Tzn. diskriminace. 1000 př. n. l.')
  end

  def test_czech_dates
    assert_equal '23. března, 1. ledna, 23. 3. 2015, 6. ledna 2015', Truty.czech_dates('23. března, 1. ledna, 23. 3. 2015, 6. ledna 2015')
  end

  def test_czech
    paragraph = 'Kdybyste hledali ostrůvek Tana Masa na mapě, našli byste jej právě na rovníku kousek na západ od Sumatry; ale kdybyste se zeptali na palubě lodi Kandong Bandoeng kapitána J. van Tocha, co to je tahle Tana Masa, před kterou právě zakotvil, nadával by chvíli a pak by vám řekl, že to je ta nejšpinavější díra v celých Sundských ostrovech, ještě mizernější než Tana Bala a přinejmenším tak zatracená jako Pini nebo Banjak; že jediný s odpuštěním člověk, který tam žije – nepočítáme-li ovšem tyhle všivé Bataky –, je opilý obchodní agent, kříženec mezi Kubu a Portugalcem a ještě větší zloděj, pohan a prase než celý Kubu a celý běloch dohromady; a že je-li na světě něco zatraceného, pak je to zatracený život na téhle zatracené Tana Masa, pane. Načež byste se ho patrně zeptali, proč tu tedy spustil ty zatracené kotvy, jako by tu chtěl zůstat zatracené tři dny; i zafuněl by podrážděně a bručel by něco v tom smyslu, že Kandong Bandoeng by sem neplula jenom pro tu zatracenou kopru nebo palmový olej, to dá rozum, a ostatně po tom vám nic není, pane, já mám své zatracené rozkazy, pane, a vy buďte tak laskav, pane, a hleďte si svého. A nadával by tak rozsáhle a hojně, jak se sluší na staršího, ale na svůj věk stále ještě svěžího lodního kapitána.'
    assert_not_equal paragraph, Truty.czech(paragraph)
    assert_not_nil Truty.czech(paragraph)
  end

  def test_czech_text
    text = '"Sorry, Captain," řekl konečně kříženec mezi Kubu a Portugalcem, "ale tady, na Tana Masa, žádné mušle nerostou. Ti špinaví Batakové," děl s nesmírnou ošklivostí, "žerou i medúzy; jsou víc ve vodě než na zemi, ženské tu smrdí rybinou, to si nemůžete představit – co jsem to chtěl říci? Aha, vy jste se ptal na ženské."
"A není tu někde kousek břehu," ptal se kapitán, "kde tihle Batakové nelezou do vody?"
Kříženec mezi Kubu a Portugalcem vrtěl hlavou. "Není, pane. Leda Devil Bay, ale to pro vás nic není."
"Proč?"
"Protože… tam nikdo nesmí, pane. Mám vám nalít, kapitáne?"
"Thanks. Jsou tam žraloci?"
"Žraloci a vůbec," mumlal kříženec. "Špatné místo, pane. Batakové by neradi viděli, kdyby tam někdo lezl."'
    converted = Truty.fix(text, :czech)
    assert_not_equal text, converted
    assert_equal text.count("\n"), converted.count("\n")
  end

  def test_no
    assert_equal "je obklopeno 250 km", Truty.fix("je obklopeno 250 km")
  end

  def test_time
    assert_equal "32.15, 00.00", Truty.fix("32.15, 00.00")
  end

  def test_score
    assert_equal "23:15, 1:1", Truty.fix("23:15, 1:1")
  end

  def test_scale
    assert_equal "Měřítko je 10 : 1", Truty.fix("Měřítko je 10 : 1")
  end

end
