Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E15636BA1A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 21:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbhDZTgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 15:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbhDZTf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:35:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB4CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:35:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i3so41436420edt.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=CQWUshTzpRmPn2kJI0awd5uuYv8OmvrDOIgcP4epbdo=;
        b=UgEJ4d6lj6QZe9Wb9lBm+Sehhc2qr51WrpP8QFbbM9d582S2l/LI9xlU7m3bqnZV+h
         YWzj9SXTma6HfNiA3yZNNiZHB1fHM64TBQJVV8r0RbJa6ODKehpCdz2Akhg9hNypvUvX
         UbN3SANLkszu/zz9p4k4rAiA/WO8ht1mTb2l9KGWGavhR+iOOkwURlkfKCr/SFHV+tsG
         /mhEjnHgjUUfaH4vMywpldGudvXfIzx4JOWXEzl/uLiPO2iAHwL79TSA4GuKIiWspdsy
         3FkCTfwkw9zRlOY/TVf5LCzZ1h1ChQgXrxrvWrKCwmpQhZuH7CScSbdoot+QkkBVHZ77
         prWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=CQWUshTzpRmPn2kJI0awd5uuYv8OmvrDOIgcP4epbdo=;
        b=AdPKr+uOXU1SE2jDXogNsBjcDbh5LZ5X6kE70MNCFp1w1M3QkQpOIWeC0Fk727TyIk
         kcvZllzpo++qzFV7HsyRy7bKGd7GZFZW55NFUPXO/SEIGFVPM8StKCSjzyXjaIT0wPrm
         jDnwsYS6I1mZjUH6+Pk/Zq1FhLxkxyFWY57a3OleZUPUgn+xokkmL2dpGwQWj45yFo9K
         S2DMg26yrbbW7RmXQjbaBMVM4XgM1zQMHB/DW+v8P4HFwvT5hw3KgZ5fc+reN3Wv4kK1
         snyX1vAK4u/s2uchhyTx/g9sBLA/vKGdSSTLilOa6KDDKOj5Cpp7jG+3X5fpUR4nRzEo
         S5jQ==
X-Gm-Message-State: AOAM530114fI86u1m1GVn2EWUQu+/Uom1FX+FGr7e9OIXr7N1yZZgraV
        8wndR144EEBvvzJy2Q0BNhyhNQ==
X-Google-Smtp-Source: ABdhPJxM0NPc0wTLTrpZQiQ9fEaasVr+Fn2nyt6rZifY1v4dPxvGYPoILKkyK9YLax7we0Yhx9f4HQ==
X-Received: by 2002:a50:9e4f:: with SMTP id z73mr294004ede.338.1619465715126;
        Mon, 26 Apr 2021 12:35:15 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id d24sm602306edp.31.2021.04.26.12.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 12:35:14 -0700 (PDT)
References: <20210421120512.413057-1-jbrunet@baylibre.com>
 <20210421120512.413057-6-jbrunet@baylibre.com>
 <69eaa840-ed77-fc01-2925-7e5e9998e80f@linux.intel.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ASoC: da7219: properly get clk from the provider
In-reply-to: <69eaa840-ed77-fc01-2925-7e5e9998e80f@linux.intel.com>
Message-ID: <1j7dkon8jy.fsf@starbuckisacylon.baylibre.com>
Date:   Mon, 26 Apr 2021 21:35:13 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 26 Apr 2021 at 20:10, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:

> On 4/21/21 7:05 AM, Jerome Brunet wrote:
>> Instead of using the clk embedded in the clk_hw (which is meant to go
>> away), a clock provider which need to interact with its own clock should
>> request clk reference through the clock provider API.
>> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>
> This patch seems to introduce a regression in our modprobe/rmmod tests

Really sorry about that :/

>
> https://github.com/thesofproject/linux/pull/2870
>
> RMMOD	snd_soc_da7219
> rmmod: ERROR: Module snd_soc_da7219 is in use
>
> Reverting this patch restores the ability to remove the module.
>
> Wondering if devm_ increases a module/device refcount somehow?

The driver is the provider and consumer, so it is consuming itself.
This was the intent, I think the patch should be correct like
this. Maybe I overlooked something on the clock side. I'll check.

I'm not sure the problem is devm_ variant, it might be 
clk_hw_get_clk() simpler variant which also plays with module ref counts.

I don't have this particular HW to check but I'll try to replicate the
test with a dummy module and report ASAP.

Of course, I suppose the same problem applies to PATCH 1 of the series

>
>> ---
>>   sound/soc/codecs/da7219.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
>> index 13009d08b09a..bd3c523a8617 100644
>> --- a/sound/soc/codecs/da7219.c
>> +++ b/sound/soc/codecs/da7219.c
>> @@ -2181,7 +2181,10 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
>>   				 ret);
>>   			goto err;
>>   		}
>> -		da7219->dai_clks[i] = dai_clk_hw->clk;
>> +
>> +		da7219->dai_clks[i] = devm_clk_hw_get_clk(dev, dai_clk_hw, NULL);
>> +		if (IS_ERR(da7219->dai_clks[i]))
>> +			return PTR_ERR(da7219->dai_clks[i]);
>>     		/* For DT setup onecell data, otherwise create lookup */
>>   		if (np) {
>> 

