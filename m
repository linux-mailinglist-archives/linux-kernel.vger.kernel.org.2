Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB29738FBA0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhEYH1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhEYH1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:27:19 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AB1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:25:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o127so16132069wmo.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=ZEZhCSQ9uc7mF8AHjrZUH5gfKrJ3JXJlTrw+y889SUA=;
        b=0MtyI7ORZHyejQpBMbsmoHZs4a7igABp5xlbXJ9baaWTVC2DyPgURrJDuABUhyO1F0
         QeSG6jO1PIjsd3vAxfJahaXy76ghL9BrSWozCdgQK2RgiG5QwhAnJd6ffE+f6Fh/Ko2o
         3Fko/k8V+OIxpE/AWWpbLSDFCdJGqYZlDrLrQK1s6SuedlKz2MJXHbWRUclWsHyI0TsK
         u3v1ofn/4HF5ZwOR7I/eMwT6u5HLl+pnrBSvRcwPVdN6bdqDq7XDeSiifo1LlC1p92ig
         WmhSUo5liTi98NUerQXsn0Po4b6i9TYi/7w7YPMnwYkwq6gZrUmOn97vkc2m+pBgQO3Q
         JlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=ZEZhCSQ9uc7mF8AHjrZUH5gfKrJ3JXJlTrw+y889SUA=;
        b=HjKyjqQUJexrKXKDudjkPi0ibtq+sEuKkNoRp53kb+fdk6Z8OvVfMjDBOJa09gSSwO
         RxYz2V6QJT1tQ0vZUd8rU/S9SQ1erqhlcuYRtG8siFWF9IQ7gHGfnus87hzOH0ZmhRsA
         8xJoW1iDh1iRHw7Ejb8s7LftueQZJTYVgk1dbTGXyseLmGdV4Fmt3+dJHIFOzqvRnju5
         lH23k6sea76cYtQl23MgnBgqAV+BZCHfRrxaTSEOO462y2KTvsVI+yiGXUKHFiRDtcBk
         oCyrOF01Fev/ft0zF8LHfAW5I9E4HnvQvNJ2pL56X0/dHW8PxC03NI4DiEsGqp2svUQw
         Au6Q==
X-Gm-Message-State: AOAM530iKS79Wtj/WPoJZSQIzfAoKzyM/ZW0x7zhvxFzju3TT0CiNdp/
        uafzt6RjKXdqLEvuQUdpUS/yNg==
X-Google-Smtp-Source: ABdhPJxhlteZuQ+HUmsDQzMPYu1gVw/NLhbHKMk2/ryWg5lxPizaWGte9GeVZfA7ZL9JogTA3irSYg==
X-Received: by 2002:a1c:e40b:: with SMTP id b11mr2468708wmh.123.1621927548149;
        Tue, 25 May 2021 00:25:48 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id d141sm10158766wmd.21.2021.05.25.00.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 00:25:47 -0700 (PDT)
References: <20210524165136.400702-1-jbrunet@baylibre.com>
 <9f21272719a3983bda647147e8460615159875b1.camel@perches.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Joe Perches <joe@perches.com>, Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] ASoC: meson: use dev_err_probe
In-reply-to: <9f21272719a3983bda647147e8460615159875b1.camel@perches.com>
Message-ID: <1jh7irb7gk.fsf@starbuckisacylon.baylibre.com>
Date:   Tue, 25 May 2021 09:25:47 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 25 May 2021 at 02:07, Joe Perches <joe@perches.com> wrote:

> On Mon, 2021-05-24 at 18:51 +0200, Jerome Brunet wrote:
>> Use dev_err_probe() helper function to handle probe deferral.
>> It removes the open coded test for -EPROBE_DEFER but more importantly, it
>> sets the deferral reason in debugfs which is great for debugging.
>
> trivia:
>
> It seems that the use of %ld, PTR_ERR(<foo>) isn't particularly
> useful now as dev_err_probe already uses %pe to emit descriptive
> error messages.

Indeed. I'll update. Thx for pointing this out.

>
>
>> diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
> []
>> @@ -352,17 +352,16 @@ int axg_fifo_probe(struct platform_device *pdev)
>>  
>> 
>>  	fifo->pclk = devm_clk_get(dev, NULL);
>>  	if (IS_ERR(fifo->pclk)) {
>> -		if (PTR_ERR(fifo->pclk) != -EPROBE_DEFER)
>> -			dev_err(dev, "failed to get pclk: %ld\n",
>> -				PTR_ERR(fifo->pclk));
>> +		dev_err_probe(dev, PTR_ERR(fifo->pclk),
>> +			      "failed to get pclk: %ld\n", PTR_ERR(fifo->pclk));
>
> here.
>
>>  		return PTR_ERR(fifo->pclk);
>>  	}
>>  
>> 
>>  	fifo->arb = devm_reset_control_get_exclusive(dev, NULL);
>>  	if (IS_ERR(fifo->arb)) {
>> -		if (PTR_ERR(fifo->arb) != -EPROBE_DEFER)
>> -			dev_err(dev, "failed to get arb reset: %ld\n",
>> -				PTR_ERR(fifo->arb));
>> +		dev_err_probe(dev, PTR_ERR(fifo->arb),
>> +			      "failed to get arb reset: %ld\n",
>> +			      PTR_ERR(fifo->arb));
>
> etc...

