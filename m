Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFFE3988A7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFBL4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhFBL4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:56:12 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05324C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 04:54:30 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id f84so3525841ybg.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 04:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yg+v5/kXrzHYvX0Jw+7F773cEOq2rwIlZqjbglsclKE=;
        b=UmNEJw6Nr0gpzWivO1xV/PjQKAM5QEpkxO4PIWKdvqnVFtdgmN2aovcHDwnTBERh7z
         4t+EsYtXq4JQSY11zALaw3jYg6yLyTqwMbO0HX8RT2u26GAQzMBMrlUSoju/2pFeGGba
         VttsmK8ffaSnEyYT9lLwIwFLroLHWLNR2qOx68fh9ItdNTA1bcrNpRI89B+m9WgTX0Eb
         rutmtKlxgkL4s1hWfEGp/5L2VUu2enP7NrAvWbIz1tPyKf4fd1KrHDLlJg46xfdWggfq
         p64Bfkeq4Tiv/7fJcnTwM6gCzOjxW1QykND+ElnBrzSDoTThKomwrOgWdD/bPG8P//6J
         mUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yg+v5/kXrzHYvX0Jw+7F773cEOq2rwIlZqjbglsclKE=;
        b=j/saWsfM8ZnyRjSOn5gDl8LLTLZ6gFdFBZID9Wi8GN/XAVAff6SPFcjFA/8/A+Fp+H
         TkRFLbYm0U2DcCelMTDfx41qjYWiGaRpb8jPp2EXlKzxUpVBL9eQ8NHK4XiWErjTvnGv
         dol7e9T1o5pxqlz/c/BP2W8iPHiaZ+KP2X8TkkOvt98wweQYVUbrO92dk3SwyF+HIoK0
         rqHmAAIeQ2BU483A6AoM7LryHKWMI/akY6qLi/6I4Ck2rHt1pYzh7RIX3dFGGBo5gN4f
         +D96B9rgRbjQRUlgSJ1E8UGXSIFC4sACgg4HsWJWgb8SFdztxM0JFzK2eZESSlXJXcrU
         T0AQ==
X-Gm-Message-State: AOAM530PKqsgw7YUNyCaN/yfUnqKcqylR1H8JU3G0A3LqwnOo6oPoMoy
        lgelXXM/V+oEZfvkZeF4U14e+cbGPxsZkAjgiIucMw==
X-Google-Smtp-Source: ABdhPJw7bRhoYK3Ux5ni1GXhoeIH3eF72GV4KTg37uWDy3Ygzg/e/Jfol28vMdjJzcXgSmBy2djug+FawUB9D8iKn2w=
X-Received: by 2002:a25:1ec2:: with SMTP id e185mr2000202ybe.23.1622634869238;
 Wed, 02 Jun 2021 04:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622008846.git.matti.vaittinen@fi.rohmeurope.com>
 <cf34b0268bf298314392b0ed8831a4d9cd14efca.1622008846.git.matti.vaittinen@fi.rohmeurope.com>
 <8c1f817e48bce8a4cb730d79c1ef0330@walle.cc>
In-Reply-To: <8c1f817e48bce8a4cb730d79c1ef0330@walle.cc>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 2 Jun 2021 13:54:18 +0200
Message-ID: <CAMpxmJWmmB1tuYS-zy-n165WFnAmz12-7+3LDQxxh+jvk=QD_Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] gpio: gpio-regmap: Use devm_add_action_or_reset()
To:     Michael Walle <michael@walle.cc>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jonas Gorski <jonas.gorski@gmail.com>,
        =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 7:17 PM Michael Walle <michael@walle.cc> wrote:
>
> Am 2021-05-26 08:10, schrieb Matti Vaittinen:
> > Slightly simplify the devm_gpio_regmap_register() by using the
> > devm_add_action_or_reset().
>
> Reviewed-by: Michael Walle <michael@walle.cc>
>
> -michael

This doesn't apply on its own - looks like it depends on patch 1/3.
Would you mind sending it separately rebased on top of my for-next
branch at https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git/?

Bart
