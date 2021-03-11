Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61A33378ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhCKQNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbhCKQNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:13:21 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0912C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:13:20 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id y1so2854133ljm.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQqJbfAYtz5Jhxh+kW0jsH0W6pnu5XQBNj3WuYw2Xtc=;
        b=cosIYzxp+AQBWf4DjdHUHtwN1fxUlfumsi7VjMoDLhQ+83JP/MK0vudESRREjie/UR
         iMFQ2WhYk0gYumKFgFwcJ+soUMaNAUNC/iwGkkuzK7MQjdtdV2GONF2nIoNBC/6JU1hA
         f/Vt+q5/77cnv4RXTnDYNck5pmNL0pbqtcZY8YDoWeDk2cPDKa1ZBaDTjUuUUnQ6yKAm
         M4RHw//gbUbOfpCchlPFPlp+v9xN/xMzXnih2fprdBgo67IorYJDhWu88pp68rzE+Rnq
         Nru/8aaNPUUyT3pU3FikSeGRWEicSYMnvWWUVf0iOOMusjQRxe4mbpoQavpt/Xm0IeA6
         HeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQqJbfAYtz5Jhxh+kW0jsH0W6pnu5XQBNj3WuYw2Xtc=;
        b=oCgpzdg/A+eBFwe1NYhaGmecw16iDiga+VzoaXeBzk7J9sZ4ASPLE8uIeUz5lPl0It
         uaVv+JE7rsNBEweJshcLfuaO+4X37WziuOANi+e8Ug4qYPEwON812/KXbNFuLQH5oluW
         K0kxFtObCChb1o9WqDznSi+ZZ/f36qh7z93vZJjOAUdh9wIF+wrRtJ6Bktpz8HVuQ4Ug
         fUQogg4MHfXRSmP/2+25tdnj/gEnp79SXOPTzrjcMsYSpXaOW/DKACIWRNKb51EHC+KD
         WbaE8EFn5o/6pYZko2dKRt2W62sC7IIzAmBFYCGQcZxpZaP+64lKnMOGnQ71uLFtoX9Q
         RcRQ==
X-Gm-Message-State: AOAM531g84ROGNQcdixTtBHWukc+kFB/YqKxKwiaq8mnjDnmTCVgnmse
        QANE20rM+ZOcm/tIhnuoFpA6VzAH89EmXCYluMKmLA==
X-Google-Smtp-Source: ABdhPJyCRD3HazyOgncwD1yTs3xl5dw5MMFa1OC940N21HVZaWtg/1LKhzgfIrBGJvld4DMc2wg3oEgkkD5l5WOCsYc=
X-Received: by 2002:a2e:7001:: with SMTP id l1mr5244023ljc.200.1615479199200;
 Thu, 11 Mar 2021 08:13:19 -0800 (PST)
MIME-Version: 1.0
References: <20210310125504.31886-1-noltari@gmail.com> <20210310125504.31886-4-noltari@gmail.com>
 <CAL_JsqKZA-j2iXvVTXWtiuyKPOWeOUP0r+x-bV6QP6=_moy2VA@mail.gmail.com>
 <CACRpkda=isBSW8BwYJ2pCaPcByRoo2GFNVoZCxhaCbEKk9iNsg@mail.gmail.com> <CAL_Jsq+FfYE2SrzwB_A=d-LMut-JrqdivKz6x8EQhkc3Zh5NAA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+FfYE2SrzwB_A=d-LMut-JrqdivKz6x8EQhkc3Zh5NAA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Mar 2021 17:13:07 +0100
Message-ID: <CACRpkdaMYy_Z34i+0uRgciC=xBtoeNsWViHU9ZysvxqrFXB5+w@mail.gmail.com>
Subject: Re: [PATCH v6 03/15] pinctrl: bcm: add bcm63xx base code
To:     Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 3:58 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Wed, Mar 10, 2021 at 6:09 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Wed, Mar 10, 2021 at 6:51 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > > > +static const struct of_device_id bcm63xx_gpio_of_match[] = {
> > > > +       { .compatible = "brcm,bcm6318-gpio", },
> > > > +       { .compatible = "brcm,bcm6328-gpio", },
> > > > +       { .compatible = "brcm,bcm6358-gpio", },
> > > > +       { .compatible = "brcm,bcm6362-gpio", },
> > > > +       { .compatible = "brcm,bcm6368-gpio", },
> > > > +       { .compatible = "brcm,bcm63268-gpio", },
> > >
> > > All these would be moved to gpio-mmio.c (or maybe that can have a
> > > fallback compatible?).
> >
> > This is gpio-regmap.c and it can only be used as a library
> > by a certain driver. gpio-mmio.c can be used stand-alone
> > for certain really simple hardware (though most use that
> > as a library as well).
>
> I don't really care which one is used, but the problem is that this
> choice is leaking into the binding design.

Aha I guess I misunderstood your comment.

>The primary problem here is
> once someone uses regmap, then they think they must have a syscon and
> can abandon using 'reg' and normal address properties as Linux happens
> to not use them (currently). I think we really need some better regmap
> vs. mmio handling to eliminate this duplication of foo-mmio and
> foo-regmap drivers and difference in binding design. Not sure exactly
> what that looks like, but basically some sort of 'reg' property to
> regmap creation.

I see the problem. Yeah we should try to be more strict around
these things. To me there are syscons and "other regmaps",
where syscon is a real hurdle of registers while "other regmaps"
are just regmaps by convenience.

Documentation/devicetree/bindings/mfd/syscon.yaml
describes what a syscon really is so if everyone could
just read the documentation that would be great ...

> Given we already have a Broadcom GPIO binding for what looks to be
> similar to this one, I'm left wondering what's the real difference
> here?

Which one is similar? I can take a look.

We currently have four Broadcom GPIO bindings,
which are stand alone GPIO blocks and eight Broadcom
pin controllers that all do GPIO as well.

This family of pin controllers are (as per subject) is
the bcm63xx series which is a MIPS-based family of SoCs
found in routers, top bindings in
Documentation/devicetree/bindings/mips/brcm/soc.txt
These all have a GPIO block as part of the pin controller
and the GPIO block is a distinct sub-function of the
pin controller, and it has up to 32 GPIOs per block,
hence it has its own subnode inside the pin controller.

This driver follows the pattern of the Ingenic
pin controller, another MIPS SoC:
Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.yaml

Another SoC with several GPIO blocks inside the pin
controller is SparX5 and that also follows this pattern:
Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
(This has an example with more than one GPIO block
inside the pin controller.)

Yours,
Linus Walleij
