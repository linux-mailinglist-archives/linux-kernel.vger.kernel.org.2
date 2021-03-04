Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F27B32C222
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387780AbhCCTdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbhCCTRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:17:47 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6167DC061756;
        Wed,  3 Mar 2021 11:16:51 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id s16so14584711plr.9;
        Wed, 03 Mar 2021 11:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MlE2vcnSz5aAFaBINYsxATASDETWRPpzxC+hNJ++ef0=;
        b=Oacmpm1N8tnR5rzthD8jKuOec25c9+fnMHHNEGh+Be/lFxO+AF9fT4ms1kyCgc+SIt
         68y68trpgxyNM+5iCtAug82FQ2slIAnBDjnQBBJw9mTF3aokf4OW8ShkOwmu59QDgiM6
         kcl4ryPy1WgJMfTcC173hAl/ffE3mNkYyFbw6F0hJQRYtMU0W9/RBmm8mICkXcjG0wxx
         P9o9Qdu6ie5fvT/Uc4LNsejYjK1RA7FV31SdGhwkGZO55Odc9ucZkLQLwZGeURlIpVCI
         z9Do6Vbllyj2YFxZkK3qqSMmc3OoG2WIQgEB6FGs0apqsWD3qSAdaWMCyZFRH6yRzLYV
         HTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MlE2vcnSz5aAFaBINYsxATASDETWRPpzxC+hNJ++ef0=;
        b=gpU2zfGGJKpUZ+bCtgsO0YQ8ZN0Q9MmdFeTToWA1/avCLYItVCW1u6BUKgKU08ldvg
         ra+9e8qw7f3LocUBmyF1hrADHzJCCGqurW/3nl789y9wtSb2J9EfkeYEU0LSAhBc/xoP
         D+VDGJtI7loTW7zBY1AraQxWPg4Evt78YsP5wAEUhPSC1lnBboscJrPzpxnetUgFHsy5
         G+89dhKphcIBedXcSLLh5KtUyaqzVKeRu+uA8tkHQgwg53iPWx7Ww43MDftsbdky6nMa
         MAJLdIxnNVnluEqwIo8Mi0OaphkX6PA6+szPhN1vRsVZ8bnL+gIvm5s62TIZqW42s0GV
         yTGA==
X-Gm-Message-State: AOAM533eq5U7Fv3HaO6kDxCJ3lvzSi3unJO/KI3rHyaAYih3OG79QD5q
        KirbV+5ArTm4crAKKAng3uJe65ah/8w=
X-Google-Smtp-Source: ABdhPJy3G62kgKD4N+/VlHC0eJtKDLPILiHCejFw3nBGZzJpnKZMZ8pUOcMjYIyxwt4p5cuV4f4ICQ==
X-Received: by 2002:a17:90b:806:: with SMTP id bk6mr622476pjb.16.1614799009973;
        Wed, 03 Mar 2021 11:16:49 -0800 (PST)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q21sm3429431pfh.189.2021.03.03.11.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 11:16:49 -0800 (PST)
Subject: Re: [PATCH v4 2/2] hwrng: bcm2835: add reset support
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@protonmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-crypto@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210223160131.29053-1-noltari@gmail.com>
 <20210224082230.29015-1-noltari@gmail.com>
 <20210224082230.29015-3-noltari@gmail.com>
 <cb7e29012e15ff10916374f911c74430fc3f5b32.camel@pengutronix.de>
 <7B6F49A9-A31D-4126-8CB1-11EE3B2B7950@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3e90b354-cae3-50d4-601b-9c6c5ca60cb1@gmail.com>
Date:   Wed, 3 Mar 2021 11:16:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7B6F49A9-A31D-4126-8CB1-11EE3B2B7950@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/21 6:06 AM, Álvaro Fernández Rojas wrote:
> Hi Philipp,
> 
>> El 3 mar 2021, a las 14:52, Philipp Zabel <p.zabel@pengutronix.de> escribió:
>>
>> Hi Álvaro,
>>
>> On Wed, 2021-02-24 at 09:22 +0100, Álvaro Fernández Rojas wrote:
>> [...]
>>> @@ -115,6 +121,8 @@ static void bcm2835_rng_cleanup(struct hwrng *rng)
>>> 	/* disable rng hardware */
>>> 	rng_writel(priv, 0, RNG_CTRL);
>>>
>>> +	reset_control_rearm(priv->reset);
>>> +
>>> 	if (!IS_ERR(priv->clk))
>>> 		clk_disable_unprepare(priv->clk);
>>> }
>>> @@ -159,6 +167,10 @@ static int bcm2835_rng_probe(struct platform_device *pdev)
>>> 	if (PTR_ERR(priv->clk) == -EPROBE_DEFER)
>>> 		return -EPROBE_DEFER;
>>>
>>> +	priv->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
>>> +	if (IS_ERR(priv->reset))
>>> +		return PTR_ERR(priv->reset);
>>> +
>>> 	priv->rng.name = pdev->name;
>>> 	priv->rng.init = bcm2835_rng_init;
>>> 	priv->rng.read = bcm2835_rng_read;
>>
>> That doesn't seem right. reset_control_rearm() doesn't do anything if
>> the reset control is exclusive. Either the reset control should be
>> requested as shared, or the _rearm should be removed.
> 
> In only added reset_control_rearm() because Florian requested it…
> I think it’s not needed, so we can use v3, since it was the only change between v3 and v4...

Not the first time I am confused by the reset API not sure if I will
ever get it one day, so apologies for suggesting something incorrect here.
-- 
Florian
