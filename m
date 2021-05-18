Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD16388292
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 00:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352692AbhERWEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 18:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352689AbhERWEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 18:04:05 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C832C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:02:46 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id e2so6917415ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bukPxpyO56mweVhakoskO20BYG2cAKYu78fBs3CA71E=;
        b=yJTscr3aj9kFIUy4Zjl6+3Fd+dckhYpCs6gKQHSOtSgoNsc2lQOz4bFUc8IfF8bRU1
         Bvu2IOu0SyvS5J62SLHQ9HeY/ngUVUPQQeCxMwz/8wcbwzW8a2O5JJ5pNoYB8OYyDEmv
         gJ8YKLcdf72R/aqFX87HL+ps+1mtoPSE7LgUMTBdxafxodG04mZLDmrUx163GJKl9yXu
         IkwXaX7UUeAnb9xafjPWJiAHLdx6zUas2gvX4hlb4psjvucTF/KFK2jyWMe0b8JbB/o9
         v2/4eCuZ86HXk6ACvpd08u/qcppk30sVmpcEX9tvoibZr/lLpbEp+D4UbHh4gMqnPbuR
         7jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bukPxpyO56mweVhakoskO20BYG2cAKYu78fBs3CA71E=;
        b=VvP/8P+qEQIaJ9cpxCePGswj2zf2Lcaz+wAT7gtcYe1sT6Na01kCXWxzWaK6RrpbHY
         slNrOiNPgtyIna98l/m/O2BcnOamTebgXVRigUsWi5aLPrtNbH36Qoo1N/fGb6ZVVwcJ
         Ouo6GDZPHg6rTOx4+PsA01K1dNU16pGarerK/D1eyiFsM/cTqSJzhMYcZk4kJBm4avDS
         sT1E7JQs5pBRYoETKdPs0fjCkcOWCISuPEJsFGoxGhNGsO08xEBuzJIQ5Cq4qRCP42O8
         2lUgbWszzOR/2yfRRCoxpDvOudCo/2YUCLZvT9t3mcI6BVPRU/Ci7oLkGTt+U/mEOCus
         qjWA==
X-Gm-Message-State: AOAM531WNPX8mjprTlwXmTTDIYmZliX48v7TKB/3C0etPI20sOElOykQ
        HZ1hQjJ36EfIcA90BK+VFsS2QIc2vUKWOGmmSRkAig==
X-Google-Smtp-Source: ABdhPJw5/m1RAiO5lFNheJXLUQ7h0SvYJwtWFEYb5fj57ODelKj2ZFnVxABFpsjarMmkjGwLkzXCoTqZUJjhwlFpxHA=
X-Received: by 2002:a2e:2e12:: with SMTP id u18mr5678438lju.200.1621375365055;
 Tue, 18 May 2021 15:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621279162.git.sander@svanheule.net> <a4af3c5fac5680d2540c54c0171d0c44d0a9ae53.1621279162.git.sander@svanheule.net>
In-Reply-To: <a4af3c5fac5680d2540c54c0171d0c44d0a9ae53.1621279162.git.sander@svanheule.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 May 2021 00:02:34 +0200
Message-ID: <CACRpkdZ543o5Xwk6pH7_wzSYKrQKsbD4+x9=9uUzrsYK5wFu=w@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] dt-bindings: mfd: Binding for RTL8231
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 9:28 PM Sander Vanheule <sander@svanheule.net> wrote:

> Add a binding description for the Realtek RTL8231, a GPIO and LED
> expander chip commonly used in ethernet switches based on a Realtek
> switch SoC. These chips can be addressed via an MDIO or SMI bus, or used
> as a plain 36-bit shift register.
>
> This binding only describes the feature set provided by the MDIO/SMI
> configuration, and covers the GPIO, PWM, and pin control properties. The
> LED properties are defined in a separate binding.
>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>

This looks correct from the GPIO side of things:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
