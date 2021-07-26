Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FDA3D58EC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 13:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhGZLRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbhGZLRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:17:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD73C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 04:57:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id p5so5641388wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 04:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=htaXzjXr1R1uLPbQq9RhoEI7mGdy3KtmApdzCJwiSm4=;
        b=AIaOAvAY3zzOmD9Ns/oLKfj4TePr7zULRDR9BtS9wRO5CWowKH3SRjvXkRy583KSyN
         YYaa1Q+TePjCjPf+H5wcmlWxfTnHrxfohaK2Yo1u8h8b8Q6xB2FfFOuC302Cgi/0Yo9L
         3VjbJMQK6uY3gJc2kkBqGqXs4c99yEe3Z9+wB5U4LPpMEDQYg68qNAVWB5++/wlkp2Dj
         KPHZtMyMxS0oMCGmWdCkSIu85mqzfUjGp8jBn1ZrrqCSvU2UHwm5FbITY1cAR55XAL4m
         MAuW+h0YXkHjhkgc9jbhMzZ8pjQ28lIQDaYUJA7m1SOk6BvFRIvylt+mmXP8R1EheX5P
         hfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=htaXzjXr1R1uLPbQq9RhoEI7mGdy3KtmApdzCJwiSm4=;
        b=KxeIpxqj0fvflfN/2ncebJXquQ1FtmD+NEAMZM3pI77acUOYkBodIKhCttUm+W7bPZ
         jjOvFU9Thsi2SFjS+UoJuyUphzt+yfa/0OTTVGcCa81RmIEIa15fKVABKeXnPZsf5dC7
         SIF+q47sXHbztqV9a+KwCOM7dwLTIVJQwVbwjWbI2CpSRDDcINXMuqpMaivDlrjCxcB3
         /bHb7/LGqPkS21fELJA70aA5fY2YkkxYvgxYUIXy5rwn//n2akytZGNOSAIjj73e7NM0
         Lkx5P9j6ZZM4pId0el7vTdFong8fvM7tlQQVxJDEXZA6b4e3/BTRvblnlu78gYndtMEl
         NEEA==
X-Gm-Message-State: AOAM531SY9/9EBIcWbZoXid4ncml1H30s1RslGkmf+A+u+zm1xXIYMeq
        5TpsAGbn/xzMTrIC9NUjqgw=
X-Google-Smtp-Source: ABdhPJwReuIBBbNL5AeIHRrE0lsDQ9CvnyqVVn4IS069WCi7Zzyobx8tPizOdwkAOG9e0fisWwH5vQ==
X-Received: by 2002:a5d:4d07:: with SMTP id z7mr19971357wrt.244.1627300657551;
        Mon, 26 Jul 2021 04:57:37 -0700 (PDT)
Received: from [192.168.1.21] ([195.245.23.224])
        by smtp.gmail.com with ESMTPSA id j2sm6972487wrd.14.2021.07.26.04.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 04:57:37 -0700 (PDT)
Message-ID: <b654b4c123013cd6c8987edb2ea0fdcb5d970bd1.camel@gmail.com>
Subject: Re: [PATCH 8/8] ep93xx: clock: convert in-place to COMMON_CLK
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mike Rapoport <rppt@kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 26 Jul 2021 13:57:36 +0200
In-Reply-To: <20210726115058.23729-9-nikita.shubin@maquefel.me>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
         <20210726115058.23729-9-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nikita!

Thanks for posting the combined series!

On Mon, 2021-07-26 at 14:50 +0300, Nikita Shubin wrote:
> Converted in-place without moving file to drivers/clk.
> 
> tested on ts7250 (EP9302).
> 
> Only setting rate and change parent tested for, as they
> are missing on ts7250:
> - video
> - I2S
> - ADC/KEYPAD

I've been testing I2S and ADC with your original patch
(and so had to prepare the fixes in the drivers), therefore...

> - PWM
> 
> Only video and I2S clock are interesting, as they are
> GATE + double DIV + MUX, all other are pretty much
> common but require ep93xx_syscon_swlocked_write to set
> registers.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>  arch/arm/Kconfig             |   2 +-
>  arch/arm/mach-ep93xx/clock.c | 975 ++++++++++++++++++++---------------
>  arch/arm/mach-ep93xx/core.c  |   2 +-
>  arch/arm/mach-ep93xx/soc.h   |  42 +-
>  4 files changed, 581 insertions(+), 440 deletions(-)

-- 
Alexander Sverdlin.


