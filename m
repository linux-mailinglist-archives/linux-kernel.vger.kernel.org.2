Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453884018C5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241218AbhIFJZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241099AbhIFJZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:25:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C59C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 02:24:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d6so8182556wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 02:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=0WNNi3JNxBLCd82GRC70DvYt/axOC47YXAp+RlwhHeY=;
        b=08Bj6eC4ymjS6BQEmD39Bxg8GqwQjVRphNrAAz2pbdcobvVRWsM2moSuk6e6r1CExl
         d8JBygGvoiIXCb7cQTlPOmenxB6Ps8MX3Zz88iSJxc8eaNTKxihqI9JX5UHZiEcbhCKL
         DSDHHrmVX1tCwGCT2K15Iqug+1rdYAwfZAhsMmRw6Gj8zUFxyIH5inry3Pi8VGO+QUzF
         ArCtDa3bhcPmlk01uo9jZhVbBE6n3UkCBIoKcudr//oDkM6pwOdHXkeOE31+ndeRQzeZ
         o5KQskQTmaqrlZ5m9fAc9ZcTOptqgS7ghqXArsbdEi4b1eubE2KVzP6O3/R0VKw2J/ZH
         W/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=0WNNi3JNxBLCd82GRC70DvYt/axOC47YXAp+RlwhHeY=;
        b=WZCqVnIFErqjpywgY4mOxy1QodCjJjKO0qyCAEF13mK67NC/IaJDKul1qMIy15SP9S
         sExvUVe2yjVLjugrA9Ln/aDzEFK+tzT1X30r5iveWqiwp8DRuyeajI5skqozxf/PpC4O
         5WDBOdROJ6sq5gdvzc5dHzaFqLzAHxb1Kg0JNpjwbqfEXCdDnICD1Wh9lbd8VVO25vUm
         f0Vm63EgjmL2/CPOG3vW0nuQs+RsfSCiIZKoEaRyHiD9i/oZ5hYwWGTgdLKaMf1r46ly
         bYnC3vMA138+dqJTh2ey6hJkUOILzoFKTh85uLjp30UhR58w9FveA/4DjnikOVofy+ay
         k/5Q==
X-Gm-Message-State: AOAM533fi9T+jQYxPCoQEGD/srITx5BS0v4Ib//K9cJ+icIV6GbnS++O
        ifWrQcKEN1o+EUG0c8P2yAN04tOMVoGWBA==
X-Google-Smtp-Source: ABdhPJygv4V2vzMRJKeYwz2DtxRgrK4Ik7kDwnaK7Jy9eAlz9GIf435+5UWz63EZSc7/ftnISFsUkg==
X-Received: by 2002:a05:6000:22d:: with SMTP id l13mr12081955wrz.410.1630920283228;
        Mon, 06 Sep 2021 02:24:43 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x11sm7361820wro.83.2021.09.06.02.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 02:24:42 -0700 (PDT)
References: <20210812051059.1103641-1-art@khadas.com>
 <247c746b-621c-5db0-25c0-1ef0d0a0d77e@baylibre.com>
User-agent: mu4e 1.6.6; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com, art@khadas.com, nick@khadas.com,
        gouwa@khadas.com, Artem Lapkin <email2tema@gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: sm1-khadas-vim3l use one sound node
 configuration with VIM3
Date:   Mon, 06 Sep 2021 11:18:36 +0200
In-reply-to: <247c746b-621c-5db0-25c0-1ef0d0a0d77e@baylibre.com>
Message-ID: <1jpmtmys2t.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 02 Sep 2021 at 15:31, Neil Armstrong <narmstrong@baylibre.com> wrote:

> Hi,
>
> On 12/08/2021 07:10, Artem Lapkin wrote:
>> Khadas VIM3L board sound configuration same as Khadas VIM3, its already
>> defined in meson-khadas-vim3.dtsi and no need overwrite it with different
>> card names and routing configurations.
>> 
>> Signed-off-by: Artem Lapkin <art@khadas.com>
>> ---
>>  .../boot/dts/amlogic/meson-sm1-khadas-vim3l.dts     | 13 -------------
>>  1 file changed, 13 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
>> index f2c098143..06de0b1ce 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
>> @@ -32,19 +32,6 @@ vddcpu: regulator-vddcpu {
>>  		regulator-boot-on;
>>  		regulator-always-on;
>>  	};
>> -
>> -	sound {
>> -		model = "G12B-KHADAS-VIM3L";
>> -		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
>> -				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
>> -				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
>> -				"TDM_A Playback", "TDMOUT_A OUT",
>> -				"TDMIN_A IN 0", "TDM_A Capture",
>> -				"TDMIN_A IN 13", "TDM_A Loopback",
>> -				"TODDR_A IN 0", "TDMIN_A OUT",
>> -				"TODDR_B IN 0", "TDMIN_A OUT",
>> -				"TODDR_C IN 0", "TDMIN_A OUT";
>> -	};
>>  };
>>  
>>  &cpu0 {
>> 
>
> Jerome could you quickly review this ?

Removing that is wrong.
Take a look at the Loopback sink - it is different between the sm1 based
vim3 and the g12b one ... this is simply because the audio block is
different on these SoCs

So audio-routing property can't go way, Because of that, the cards are
slightly different and should have different model.

However the model name here is
a) probably too long
b) misleading :/ 

>
> Thanks,
> Neil

