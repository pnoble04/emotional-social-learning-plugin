(function() {
  var addSlidersToEmotionContainers, fillAllEmotionContainers, getTwoCorrespondingTextsOfSlider, setSizeOfEmotionTexts, setupSlidersToChangeTextOnChange;

  console.log($('.emotionContainer'));

  fillAllEmotionContainers = function() {
    var emotionContainerHTML;
    emotionContainerHTML = "<div class='oneEmotion'>            <div class='emotionTexts'>                <span class='negative'>bored</span>                <span class='positive'>fascinated</span>            </div>        <div class='emotionSlider'></div>        </div>        <div class='oneEmotion'>            <div class='emotionTexts'>                <span class='negative'>overwhelmed</span>                <span class='positive'>unchallenged</span>            </div>            <div class='emotionSlider'></div>        </div>        ";
    return $('.emotionContainer').html(emotionContainerHTML);
  };

  addSlidersToEmotionContainers = function() {
    return $('.emotionSlider').slider({
      min: 8,
      max: 28
    });
  };

  setupSlidersToChangeTextOnChange = function() {
    $(".emotionSlider").on("slide slidechange", function(event, ui) {
      var emotionTextElements;
      emotionTextElements = getTwoCorrespondingTextsOfSlider(ui.handle);
      console.log("emotext", emotionTextElements);
      setSizeOfEmotionTexts(emotionTextElements, ui.value);
      console.log("slider changed!:) to " + ui.value);
      return console.log(ui.handle);
    });
    return $('.emotionSlider').slider("option", "value", 18);
  };

  getTwoCorrespondingTextsOfSlider = function(sliderElement) {
    return $(sliderElement).parent().parent().find('.emotionTexts span');
  };

  setSizeOfEmotionTexts = function(emotionTextElements, sliderValue) {
    var negativeTextSize, positiveTextSize;
    positiveTextSize = sliderValue;
    negativeTextSize = 28 - sliderValue + 8;
    $(emotionTextElements).filter('.positive').css('font-size', positiveTextSize);
    return $(emotionTextElements).filter('.negative').css('font-size', negativeTextSize);
  };

  fillAllEmotionContainers();

  addSlidersToEmotionContainers();

  setupSlidersToChangeTextOnChange();

}).call(this);
