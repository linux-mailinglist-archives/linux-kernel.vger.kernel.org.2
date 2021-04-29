Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867C436E822
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhD2Jqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhD2Jqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:46:32 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BC5C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:45:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id j28so13760928edy.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=aNf26sUMiRwJBKQH/Hf8TYhehmA4Zm+XIsMUwKiuMyQ=;
        b=iFQnzJcpCFbrQ4rZP6nCuYXPQwNrLKblQh2GcD2tO49KIxKybUwu/C95NtgQLiNjEn
         Utem+Lk41XU4ZOv1WKA3H/KFr2Z9y3RC9oSCvOIkoLxbrJInMLERtLjpkdr3pU8FHD2d
         FG//yFR0sfrX6C+knGQhZ/ktDFxqvAIkUW0W0cDdQaK4z/VYF5tV9Tj8kMAXLqdP0Vjp
         N+qfSUbnMxRGYWXV1ARJR3gogiVF7FlGebSjzqSUZSIci+BDxh9E5XFK+KTxS0piR+Mq
         oDkP1I70Q1BGwZKptf7W11zfE1u2Fxjee5k4EplOo59kmtRZU7SBymlgLj7ZyoVEs3TD
         u7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=aNf26sUMiRwJBKQH/Hf8TYhehmA4Zm+XIsMUwKiuMyQ=;
        b=aT9qK9zP1DjKbPexc96+k7WMC3rSopPQ124Lgey/mfsHtsilN82L2d5u+DJK3qY5nr
         8mf5bc3XsdfcyJATnvysIv7uo9L9pLGk9CQZGXkt7cJ/1nlnSJFTQv5k8BBQkukVRnCD
         X2bmNVTwIo4WdOkUVr6vAvTbhIMbBGJSKfdNxvEgdp6mmtAumtr2+YBtoJOJY6kbo6lF
         GKCtfcBMXhx5aqrAZLH5H8OIcDG+QMtW9GVXocn73hn3uYUWWRGfXT55h2DI35vUxDVB
         E07/u5SPKsz0C1bJ0UpHU6ig9+DJ4hSyrP/yVjD0F4ujxrrfciSfjASPojckI3WMF8uB
         mYhA==
X-Gm-Message-State: AOAM532v7Pg8+e/h3AQaJzxvVeu3W8mE0QgnKFxOk8KWe5lRZ816kbQ2
        FSBvJ/cF1voV5rcR9kIMf89UxQ==
X-Google-Smtp-Source: ABdhPJyBmbHnL2J4IIvJHV8eZFiZeGIaxve23EUNHu8okuLO7wRyLTAWhhlI0wR+0AcC5tBYFh7lIg==
X-Received: by 2002:a05:6402:254f:: with SMTP id l15mr17186114edb.189.1619689544467;
        Thu, 29 Apr 2021 02:45:44 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id z17sm1492469ejc.69.2021.04.29.02.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 02:45:44 -0700 (PDT)
References: <20210429090325.60970-1-jbrunet@baylibre.com>
 <979eb290-6fc2-38df-0596-867b82d22226@baylibre.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson: g12a: fix gp0 and hifi ranges
In-reply-to: <979eb290-6fc2-38df-0596-867b82d22226@baylibre.com>
Message-ID: <1jim45juf1.fsf@starbuckisacylon.baylibre.com>
Date:   Thu, 29 Apr 2021 11:45:38 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 29 Apr 2021 at 11:20, Neil Armstrong <narmstrong@baylibre.com> wrote:

> On 29/04/2021 11:03, Jerome Brunet wrote:
>> While some SoC samples are able to lock with a PLL factor of 55, others
>> samples can't. ATM, a minimum of 60 appears to work on all the samples
>> I have tried.
>> 
>> Even with 60, it sometimes takes a long time for the PLL to eventually
>> lock. The documentation says that the minimum rate of these PLLs DCO
>> should be 3GHz, a factor of 125. Let's use that to be on the safe side.
>> 
>> With factor range changed, the PLL seems to lock quickly (enough) so far.
>> It is still unclear if the range was the only reason for the delay.
>> 
>> Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/clk/meson/g12a.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
>> index b080359b4645..a805bac93c11 100644
>> --- a/drivers/clk/meson/g12a.c
>> +++ b/drivers/clk/meson/g12a.c
>> @@ -1603,7 +1603,7 @@ static struct clk_regmap g12b_cpub_clk_trace = {
>>  };
>>  
>>  static const struct pll_mult_range g12a_gp0_pll_mult_range = {
>> -	.min = 55,
>> +	.min = 125,
>>  	.max = 255,
>>  };
>>  
>> 
>
> I got other issues with GP0 when trying to use it for DSI on VIM3 & VIM3L.
>
> I had to do change the following to have it lock correctly and achieve rates usable for MIPI-DSI requested bandwidth:
>
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index cde07f7ebad6..897cd6db5c0f 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -391,9 +391,9 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>                 meson_parm_write(clk->map, &pll->frac, frac);
>         }
>
> -       /* If the pll is stopped, bail out now */
> +       /* If the pll is stopped, bail out now * /
>         if (!enabled)
> -               return 0;
> +               return 0;*/

This enables the PLL everytime set_rate() is called :/

>
>         if (meson_clk_pll_enable(hw)) {
>                 pr_warn("%s: pll did not lock, trying to restore old rate %lu\n",
>
> This one is tricky, for DSI the clock rate is set with assigned-clock-rates in DT, but
> then the GP0 is seen as stopped and then the rate is never set.

Audio does the same - PLL is set and enabled afterward. This has been
working so far.

>
> When afterwards we enable the PLL, the rate set in the registers is invalid and never locks,
> this permits setting the rate in the registers even if the PLL is
> stopped.

There something to be explained here cause the register have been set
before bailing out. What is happening ? The pokes before have no effect
or are the value being reset at another point ?

I understand this need to address this concern but it does not seems
related to this particular patch.

>
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 1b0167b8de3b..08174724a115 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -1602,8 +1602,8 @@ static struct clk_regmap g12b_cpub_clk_trace = {
>  };
>
>  static const struct pll_mult_range g12a_gp0_pll_mult_range = {
> -       .min = 55,
> -       .max = 255,
> +       .min = 120,
> +       .max = 168,
>  };
>
> I had to change the min/max to achieve a stable and functional rate of 720MHz after the ODs.
>

How about the range provided in here ? This is range documented by AML
(3GHz < DCO < 6GHz). 168 limits would limit the rate to ~4GHz which is
way below spec and would negatively impact audio clocks.

> Neil

