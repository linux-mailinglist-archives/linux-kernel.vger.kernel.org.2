Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D32368C60
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 06:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhDWEyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 00:54:52 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:33604 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWEyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 00:54:51 -0400
Received: by mail-lf1-f47.google.com with SMTP id j4so36103460lfp.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 21:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=oNpP1yn0jsOF4WqBd73vLMfKDwqGpqekATuoCYN7vtU=;
        b=JYcOmNO4znusDZLA73znmGu1iwZyzU2cR0K4IipY871ILMzi+PcmKEP132VG6aT75y
         4HN8zFb1TWxc5JsIo8aJtOkS9QOGsgmzRl57moQKaCaPf9dWlxTxWEi5/XnaIiR3PWwd
         nhjTxAq4HTuqhrxNXRpcK7V8wGbSiVrQfEcYP2bc9wILuu1BbE175dsL06GddfTdfgBr
         977R8muPwCAP8hu4TMlXNFqJbajQuRF5hx/6mVeLIJwcbHU34Lvqde5wLqYJtHwwUZoj
         s8PcRc5yipsDGDoruHZiztvQljWvYHj5rMOZ6OT4p+qxvYfDAR5O7lhsZQ4cDsc0KS2c
         bjog==
X-Gm-Message-State: AOAM53084GqKhpvRJIQMGJYeSclbn05xJQO6dun0U2m+whjs+zQUyv7m
        wOHfp58VduXhS8m7+Wx6bck=
X-Google-Smtp-Source: ABdhPJxaxJlW9K3GCghhd6Zw/eaS5uY7GoSxoWXzkfHXldG1iAjyooaOfRRXPvKVO7AO2VHE0m7Kig==
X-Received: by 2002:ac2:529b:: with SMTP id q27mr1259429lfm.519.1619153654787;
        Thu, 22 Apr 2021 21:54:14 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id i125sm459676lji.51.2021.04.22.21.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 21:54:14 -0700 (PDT)
Message-ID: <f0792d1d1f5596ad0256aa01d88eb5bd7ceff653.camel@fi.rohmeurope.com>
Subject: Re: [PATCH] regulator: bd71815: include <linux/of.h> and
 <linux/gpio/consumer.h>
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Arnd Bergmann <arnd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422133338.1734640-1-arnd@kernel.org>
References: <20210422133338.1734640-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Fri, 23 Apr 2021 07:54:00 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2021-04-22 at 15:33 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new driver causes a build failure because of a missing includes:

Odd that I never saw these errors. Thanks for the fix anyways! Much
appreciated.

> drivers/regulator/bd71815-regulator.c: In function
> 'buck12_set_hw_dvs_levels':
> drivers/regulator/bd71815-regulator.c:210:13: error: implicit
> declaration of function 'of_find_property' [-Werror=implicit-
> function-declaration]
>   210 |         if (of_find_property(np, "rohm,dvs-run-voltage",
> NULL) ||
>       |             ^~~~~~~~~~~~~~~~
> drivers/regulator/bd71815-regulator.c: At top level:
> drivers/regulator/bd71815-regulator.c:461:37: error: implicit
> declaration of function 'of_match_ptr' [-Werror=implicit-function-
> declaration]
>   461 |                         .of_match =
> of_match_ptr(#_name),               \
>       |                                     ^~~~~~~~~~~~
> drivers/regulator/bd71815-regulator.c: In function 'bd7181x_probe':
> drivers/regulator/bd71815-regulator.c:590:19: error: implicit
> declaration of function 'devm_gpiod_get_from_of_node' [-
> Werror=implicit-function-declaration]
>   590 |         ldo4_en = devm_gpiod_get_from_of_node(&pdev->dev,
>       |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/regulator/bd71815-regulator.c:593:50: error: 'GPIOD_ASIS'
> undeclared (first use in this function); did you mean 'GPIOF_IN'?
>   593 |                                                  GPIOD_ASIS,
> "ldo4-en");
>       |                                                  ^~~~~~~~~~
>       |                                                  GPIOF_IN
> 
> Fixes: 1aad39001e85 ("regulator: Support ROHM BD71815 regulators")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> As found yesterday with another patch I sent for this driver,
> it is apparently not part of the regulator tree but only merged
> through Lee's mfd tree.
> ---
>  drivers/regulator/bd71815-regulator.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/bd71815-regulator.c
> b/drivers/regulator/bd71815-regulator.c
> index a4e8d5e36b40..5be2b01632a0 100644
> --- a/drivers/regulator/bd71815-regulator.c
> +++ b/drivers/regulator/bd71815-regulator.c
> @@ -16,9 +16,10 @@
>  #include <linux/regulator/driver.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/mfd/rohm-generic.h>
>  #include <linux/mfd/rohm-bd71815.h>
> +#include <linux/of.h>
>  #include <linux/regulator/of_regulator.h>
>  
>  struct bd71815_regulator {


