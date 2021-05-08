Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12419377422
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 23:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhEHVLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 17:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhEHVLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 17:11:11 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A07AC06175F
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 14:10:08 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id e11so2445619ljn.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m9+3noXngizjhhrRMZhk48zpVxasYuaz+6Rq3HmU5os=;
        b=t7yafSULJecEnKd2MYd23rEXI4UL7T3aYFjfUq+3PyWNhrGe3FQHVQlJmql5r9M26J
         ZB9uJ8Y14duaNd6UgXwfGpOEs1ZusTgSZFNTF3M/2l0a24T7wTs2kZofzSszfecq2+ba
         yPD9RVXrM9lZIr4rvmAc54o4pvDtUMxWC22vZbPE6Om5EPgbYy95KmyfGW2M87VWGG6h
         uIRx+ZM1OuehsFMec/kaHnNRnBqhzNK7zY4fEhopiRGuvTTywTGBZvgnt+df2me3+HTL
         +YB1tO1T6EgmyluAq7qiTDVMK46/xMpBjfrxC06SRnRL/rPx6xI32N7DQe50E+XB6XqU
         7M7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9+3noXngizjhhrRMZhk48zpVxasYuaz+6Rq3HmU5os=;
        b=fMGHwp+/IXZwJFL8M0nN/b7F/Q0gPrqymrQZg3sLDF56wIhmNcF6ZeZtwNeDKXb+SS
         ahj8BLhATq1vdsZNEcwLoD66/QgnFkIk0sCkTUsC7Z2IKMPptwhQSmwRLu6F+/KHL6w4
         RnEq+DvoSlBEKFFgfGqgaqI/Pi+9KakTRwUBfpURbugyeK+QpaO+aA5eH3Ouc522A+Ed
         sD3rRI7ngERvtj1pcTiBA5wJFmx73zFKkyrN61BLRFTb3Qyq+rF99z1JXaYtXlL/TD3I
         sKABqGATVT8Kp38bSyXtc63TJXZ3OX0PuyLsOjkine5l6D2/Tt0c20twayo17vpEbQdU
         /eTg==
X-Gm-Message-State: AOAM532m6UPuR75091+k/xDm0WlisDYbYiXxc5GE1G1nA8FRC2iy+8s+
        elV14o9tqReMQ/XB9uQniisyoCKmqjJ/CZv3GIImnQ==
X-Google-Smtp-Source: ABdhPJx9fIpLuRXp6oykG1yO2k3sQMgNWt3rSDIbUp+Ot6stAgiAWOrwYZwqXeakE3J8GDLZmLs4ZF3jjOzuA8DAp7k=
X-Received: by 2002:a2e:2e12:: with SMTP id u18mr13206972lju.200.1620508206995;
 Sat, 08 May 2021 14:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210508142000.85116-1-kettenis@openbsd.org> <20210508142000.85116-2-kettenis@openbsd.org>
In-Reply-To: <20210508142000.85116-2-kettenis@openbsd.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 May 2021 23:09:55 +0200
Message-ID: <CACRpkdbUNs_FFv9RteWKUrxBdRuiXU2Fkt-oY4=Phke4gNBoaQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: Add DT bindings for apple,pinctrl
To:     kettenis@openbsd.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hector Martin <marcan@marcan.st>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 8, 2021 at 4:20 PM Mark Kettenis <kettenis@openbsd.org> wrote:

> The Apple GPIO controller is a simple combined pin and GPIO conroller
> present on Apple ARM SoC platforms, including various iPhone and iPad
> devices and the "Apple Silicon" Macs.
>
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>

I knew this was coming! I saw an earlier version of the Linux
pin control driver in some tree somewhere.

I see we're only discussing bindings right now, but it would be
great to also take a look at the U-Boot driver and scratch Linux
driver (which I bet both exist) for a deeper understanding.
Git tree web links are fine.

> +description: |
> +  The Apple GPIO controller is a simple combined pin and GPIO controller

spelling

> +  present on Apple ARM SoC platforms, including various iPhone and iPad
> +  devices and the "Apple Silicon" Macs.

> +properties:
> +  compatible:
> +    items:
> +      - const: apple,t8103-pinctrl
> +      - const: apple,pinctrl

So is this an entirely Apple thing now, and not based on some Samsung
block from S3C like what we have seen before?

It'd be great if Krzysztof or Tomasz who have experience with the
Samsung hardware could have a look at the registers etc in the
drivers and confirm or clear any relationship to Samsung hardware.

This would partly involve trying to keep the pin control bindings
similar to Samsungs if there is a relationship.

If there is no relationship, then we invent something new.

All looks pretty good, but I am suspicious about this:

> +  interrupts:
> +    minItems: 1
> +    maxItems: 7

Which is used like that.

> +        interrupt-controller;
> +        interrupt-parent = <&aic>;
> +        interrupts = <AIC_IRQ 16 IRQ_TYPE_LEVEL_HIGH>,
> +                     <AIC_IRQ 17 IRQ_TYPE_LEVEL_HIGH>,
> +                     <AIC_IRQ 18 IRQ_TYPE_LEVEL_HIGH>,
> +                     <AIC_IRQ 19 IRQ_TYPE_LEVEL_HIGH>,
> +                     <AIC_IRQ 20 IRQ_TYPE_LEVEL_HIGH>,
> +                     <AIC_IRQ 21 IRQ_TYPE_LEVEL_HIGH>,
> +                     <AIC_IRQ 22 IRQ_TYPE_LEVEL_HIGH>;

First it is really odd with 7 of something as in all computer
science but I guess there is some explanation for that.

What I am really wondering is if these interrupts are hierarchical,
i.e. that they match 1-to-1 to a GPIO line.

We only (ideally) define the interrupts when it is used by the
GPIO block itself, such as when it spawns a cascaded interrupt
controller (i.e. you need to read status bits inside the GPIO
controller to figure out which line was fired).

If the interrupt has a 1-to-1 mapping between GPIO lines and
the parent interrupt controller we usually do not define these
interrupts in the device tree at all.

In those cases the interrupt is considered hierarchical and we
rely on the compatible for the block to define how the
interrupt lines are routed to the parent interrupt controller
(in this case AIC).

In the Linux case, the GPIO driver has a hardcoded table
of mappings from the GPIO irq line offset and the corresponding
index on the parent interrupt controller (AIC).

This is reflected in this IRQ routing information missing
from the bindings.

Marc Zyngier can probably tell the story of why it is handled
like this,

There is some info on hierarchical IRQ handling in the
Linux GPIO driver docs:
https://www.kernel.org/doc/html/latest/driver-api/gpio/driver.html
Section "GPIO drivers providing IRQs"

Yours,
Linus Walleij
