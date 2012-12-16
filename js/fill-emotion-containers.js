(function() {
  var addSlidersToEmotionContainers, fillAllEmotionContainers, fillCommunityEmotionContainers, fillInvididualEmotionContainers, getEmotionStateArray, getEmotionStateOfEverybodyAndShowIt, getTwoCorrespondingPicturesOfSlider, sendEmotionStateArray, sendEmotions, sendEmotionsOnSubmitButtonClick, setSizeOfEmotionPictures, setupSlidersToChangePicturesOnChange;

  fillAllEmotionContainers = function() {
    fillInvididualEmotionContainers();
    return fillCommunityEmotionContainers();
  };

  fillInvididualEmotionContainers = function() {
    var emotionContainerHTML;
    emotionContainerHTML = "<div class='oneEmotion'>            <div class='emotionPictures'>                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/frustrated.jpg' alt='frustated' class='firstEmotion' />                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/unchallenged.jpg' alt='unchallenged' class='secondEmotion' />            </div>            <select class='emotionSelect'>              <option value='extremely frustrated'>Extremely Frustrated</option>              <option value='very frustrated'>Very Frustrated</option>              <option value='frustrated'>Frustrated</option>              <option value='quite frustrated'>Quite Frustrated</option>              <option value='slightly frustrated'>Slightly Frustrated</option>              <option value='neutral' selected='selected'>Neutral</option>              <option value='slightly unchallenged'>Slightly Unchallenged</option>              <option value='quite unchallenged' >Quite Unchallenged</option>              <option value='unchallenged'>Unchallenged</option>              <option value='very unchallenged'>Very Unchallenged</option>              <option value='extremely unchallenged'>Extremely Unchallenged</option>            </select>        </div>        <div class='oneEmotion'>            <div class='emotionPictures'>                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/bored.jpg' alt='bored' class='firstEmotion' />                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/excited.jpg' alt='excited' class='secondEmotion' />            </div>                        <select class='emotionSelect'>              <option value='extremely bored'>Extremely Bored</option>              <option value='very bored'>Very Bored</option>              <option value='bored'>Bored</option>              <option value='quite bored'>Quite Bored</option>              <option value='slightly bored'>Slightly Bored</option>              <option value='neutral' selected='selected'>Neutral</option>              <option value='slightly excited'>Slightly Excited</option>              <option value='quite excited' >Quite Excited</option>              <option value='excited'>Excited</option>              <option value='very excited'>Very Excited</option>              <option value='extremely excited'>Extremely Excited</option>            </select>        </div>        ";
    return $('.emotionContainer').html(emotionContainerHTML);
  };

  fillCommunityEmotionContainers = function() {
    var emotionContainerHTML;
    emotionContainerHTML = "<div class='communityEmotion'>            <div class='emotionPictures'>                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/frustrated.jpg' alt='frustated' class='firstEmotion' />                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/unchallenged.jpg' alt='unchallenged' class='secondEmotion' />            </div>        </div>        <div class='communityEmotion'>            <div class='emotionPictures'>                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/bored.jpg' alt='bored' class='firstEmotion' />                <img src='http://dl.dropbox.com/u/34637013/uni/design-new-learning-environments/images/excited.jpg' alt='excited' class='secondEmotion' />            </div>        </div>        ";
    return $('.communityEmotionContainer').html(emotionContainerHTML);
  };

  addSlidersToEmotionContainers = function() {
    var selectForm, selectForms, _i, _len, _results;
    selectForms = $('select.emotionSelect');
    _results = [];
    for (_i = 0, _len = selectForms.length; _i < _len; _i++) {
      selectForm = selectForms[_i];
      _results.push($(selectForm).selectToUISlider({
        labels: 0
      }).hide());
    }
    return _results;
  };

  setupSlidersToChangePicturesOnChange = function() {
    $(".ui-slider").on("slide slidechange", function(event, ui) {
      var emotionPictures;
      emotionPictures = getTwoCorrespondingPicturesOfSlider(ui.handle);
      return setSizeOfEmotionPictures(emotionPictures, ui.value);
    });
    return $('.ui-slider').slider("option", "value", 5);
  };

  getTwoCorrespondingPicturesOfSlider = function(sliderElement) {
    return $(sliderElement).parent().parent().find('.emotionPictures img');
  };

  setSizeOfEmotionPictures = function(emotionPictures, sliderValue) {
    var firstOpacity, secondOpacity;
    firstOpacity = 1 - (sliderValue / 10);
    secondOpacity = sliderValue / 10;
    $(emotionPictures).filter('.firstEmotion').css('opacity', firstOpacity);
    return $(emotionPictures).filter('.secondEmotion').css('opacity', secondOpacity);
  };

  sendEmotionsOnSubmitButtonClick = function() {
    return $('#submitFeelings').click(sendEmotions);
  };

  sendEmotions = function() {
    var emotionStateArray;
    emotionStateArray = getEmotionStateArray();
    return sendEmotionStateArray(emotionStateArray);
  };

  getEmotionStateArray = function() {
    var emotionPicture, emotionPictures, opacityArray, _i, _len;
    emotionPictures = $('.oneEmotion .emotionPictures img.firstEmotion');
    opacityArray = [];
    for (_i = 0, _len = emotionPictures.length; _i < _len; _i++) {
      emotionPicture = emotionPictures[_i];
      opacityArray.push(parseFloat($(emotionPicture).css('opacity')));
    }
    return opacityArray;
  };

  sendEmotionStateArray = function(emotionStateArray) {
    return $.ajax({
      url: 'http://zukunfts-management.de/emotional-social-learning/php/submitEmotionState.php',
      data: {
        emotionState: JSON.stringify(emotionStateArray)
      },
      dataType: "jsonp"
    });
  };

  window.emotionStateUpdated = function(newEmotionState) {
    return window.showEmotionState(newEmotionState);
  };

  getEmotionStateOfEverybodyAndShowIt = function() {
    return $.ajax({
      url: 'http://zukunfts-management.de/emotional-social-learning/php/getEmotionState.php',
      dataType: "jsonp"
    });
  };

  window.showEmotionState = function(emotionStateObject) {
    var emotionPictures, emotionStateArray, numberOfSubmissions;
    emotionStateArray = emotionStateObject.emotionStateArray;
    numberOfSubmissions = emotionStateObject.numberOfSubmissions;
    emotionPictures = $('.communityEmotion img');
    return emotionPictures.each(function(index, element) {
      var firstEmotionOpacity, opacity;
      firstEmotionOpacity = emotionStateArray[Math.floor(index / 2)] / numberOfSubmissions;
      if ($(element).is('.firstEmotion')) {
        opacity = firstEmotionOpacity;
      } else {
        opacity = 1 - firstEmotionOpacity;
      }
      return $(element).css('opacity', opacity);
    });
  };

  fillAllEmotionContainers();

  addSlidersToEmotionContainers();

  setupSlidersToChangePicturesOnChange();

  sendEmotionsOnSubmitButtonClick();

  getEmotionStateOfEverybodyAndShowIt();

}).call(this);
