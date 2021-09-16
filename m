Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876DC40D716
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbhIPKJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbhIPKJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:09:11 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF118C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 03:07:50 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i25so16413369lfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jUO5tSYLVRile5AWlAafA8DmhpHLLp7fGg/YtJNAKkA=;
        b=kb18yEmDjFeTISL5Cj3f+OE1reEAL0nH5XmyNUxp+vvOyzUcj+l9m5OworF15vyOXF
         b8YVBrLmGwq/u0XPPb8fk3JaoNhQe+7Ho6ZKojUxfMsvVZB1S+AXaj2bjkGQpTH2BDMF
         RFKGzdZkL5STdbXuztAsLUi82lROJaEFce1QQBJQFnJ6BNDzh73ydU6twoHnOf/LFIT6
         m36gdukOrXppQsBrmuso+yADYfJZDVaWVxIsFzYI2GyA9+KlNEDbRQnmoxutZH37cusb
         kMvPFWujPGOtbzPt0qbQ8UKq9xhYrz+jKKgOqdrQtVAmzqRwqbisq3ed603uxeTFFJJ1
         7TrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jUO5tSYLVRile5AWlAafA8DmhpHLLp7fGg/YtJNAKkA=;
        b=5bJ822Er5d82ZeMrTC8tLGyzXYO+/eLlL9lJt6qN4xeGFyN8Vf1KP45/UNkY8NvycG
         PnQUSpgC5/D3HXqPv436hHwBddOB6hYkAbjtgq6oFrKaAIvuCzROanLu4E95EvPPy31b
         sQrTC587miD9fXwiXf/3Rxneyua4BplgfDa/O9UszRUWpb0l+KM5sWDXfPIW8u1Pa3dy
         32t8rOTJFfXq0Gk4nJUle69UPLlAdw0tfb7RYPOg50uiu3IrWI3G18P0W4A8lHgcu6YU
         /EBSgWmCt9DYrLn/MX9boF+goInFgTBldOgm262xHtqoV4ToZzGQ3eva/E5i00+w93f6
         +QGQ==
X-Gm-Message-State: AOAM533W1HbGfzMG+abQ3W1YEvtByZ5wnmU92IOzeifyb5/LErbIfGJa
        WNclAXEYvCcSRrStzRJApEnUy+W6arwf832KW/09xQ==
X-Google-Smtp-Source: ABdhPJytweAIsY0sxsinkWN7FPbeTdhVCteGXtpk0WGBS/7V1nIDt7Ry+vbrBBnhe783d+4wyWb3AQdWBV5/FDYn/9Q=
X-Received: by 2002:a05:6512:3096:: with SMTP id z22mr3486963lfd.584.1631786869054;
 Thu, 16 Sep 2021 03:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210914085137.31761-1-sam.shih@mediatek.com> <20210914085137.31761-5-sam.shih@mediatek.com>
In-Reply-To: <20210914085137.31761-5-sam.shih@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Sep 2021 12:07:38 +0200
Message-ID: <CACRpkdYkvBS5+MHSGBDhNQtvCxRquef1kPHmCSfzruz2N=VCyw@mail.gmail.com>
Subject: Re: [RESEND,v3,4/9] pinctrl: mediatek: moore: check if pin_desc is
 valid before use
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        John Crispin <john@phrozen.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 10:52 AM Sam Shih <sam.shih@mediatek.com> wrote:

> Certain SoC are missing the middle part gpios in consecutive pins,
> it's better to check if mtk_pin_desc is a valid pin for the extensibility
>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Acked-by: Sean Wang <sean.wang@mediatek.com>

This patch applied for v5.16 so we get some stuff merged.

Yours,
Linus Walleij
