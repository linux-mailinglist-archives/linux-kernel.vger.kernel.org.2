Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE42933BF77
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhCOPKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbhCOPKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:10:40 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3707BC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 08:10:40 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a1so16648429ljp.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZKKaLOkrBz3/GtouDwoCOZ4KdSWppOkZ3d+IwHT4siU=;
        b=c6eKxW5xWF2yHUtA3SSpLusB0wRtKknAR/Nh5Tr2gXXnW44RK0sLvd+3h6Pz93DHNY
         w19hFNTgapAFNIKubbphTkJRAE6WEsngPV47qDO9cFouoUxk5Tvp9BGFJdOdZrmzON24
         f3CoJSaBbg5BKn3HlofWSf/wJP5Q5X7y0oc9OVlbSrPzs+TZfazUn9F1N9s5lEpQ6Rk9
         IxOin93qBmQgRxpjBvYq6CseUksefDrn58hpWGxrdLPXBrMLlb5BtCMtewlqhlgnNFld
         77tzY1zS2wC0OoUy/or1jzRZzd0YBL+GYzvpbNGCH0VMuiivv3yqPkmII7SAsUDPaUdx
         UGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZKKaLOkrBz3/GtouDwoCOZ4KdSWppOkZ3d+IwHT4siU=;
        b=PXCpxHPON/UUPqIIc2AK2iZsEwef9lnEv/OON8tSo0xUmM71M6ijPxPklkjZrccczC
         /s3TZK9a6hqYVLcUkpNBS6ZhrH3Vy7Eq8+wRlR7kk0JhH0x6EhR5cRTR2CQbtLz6KFNV
         a2R2sJO+8CZrAYu3Opce0KxK5A0gAhUZ6h+sJGe27FUz7iFOuBpoZSifbjI/xaCB/l/o
         H0WJ2RAdqM+bcVtJd0Gtr9NdLn4YuMirSEieQgpVM7o1uCjKDXasQ6IdF0feP8J1TcV1
         G6DZvSZ8fbxiNKm2T27ckwxHjZlgEI022BvXeFAtAnI4qyvX9T/NmarA00pMWTad79oN
         WeMA==
X-Gm-Message-State: AOAM533pe0dDDvpCEWtUQeMm+Tp+i6kT1hzAnELhIDzr3VzRE6Zf1SE9
        u3cVkm6cxjGYyJb4fRiqdOhZqB/WgRFVCCYEiOARgQ==
X-Google-Smtp-Source: ABdhPJzFKvnw8E5Zqkbhku2Z16o1dIIxQeveiTHejHx5D5hme652oeKJbanFEjDTx3Ueaw0f3mDtMGe8gxtiixlajpU=
X-Received: by 2002:a2e:864a:: with SMTP id i10mr10417943ljj.467.1615821038699;
 Mon, 15 Mar 2021 08:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210315082339.9787-1-sander@svanheule.net> <20210315082339.9787-3-sander@svanheule.net>
In-Reply-To: <20210315082339.9787-3-sander@svanheule.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 15 Mar 2021 16:10:27 +0100
Message-ID: <CACRpkdZ7zWQPBgQ+AjFM7up8x8HJES2EDfBKGmPU9LJwWzB8EA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: Add Realtek Otto GPIO support
To:     Sander Vanheule <sander@svanheule.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bert Vermeulen <bert@biot.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 9:26 AM Sander Vanheule <sander@svanheule.net> wrote:

> Realtek MIPS SoCs (platform name Otto) have GPIO controllers with up to
> 64 GPIOs, divided over two banks. Each bank has a set of registers for
> 32 GPIOs, with support for edge-triggered interrupts.
>
> Each GPIO bank consists of four 8-bit GPIO ports (ABCD and EFGH). Most
> registers pack one bit per GPIO, except for the IMR register, which
> packs two bits per GPIO (AB-CD).
>
> Although the byte order is currently assumed to have port A..D at offset
> 0x0..0x3, this has been observed to be reversed on other, Lexra-based,
> SoCs (e.g. RTL8196E/97D/97F).
>
> Interrupt support is disabled for the fallback devicetree-compatible
> 'realtek,otto-gpio'. This allows for quick support of GPIO banks in
> which the byte order would be unknown. In this case, the port ordering
> in the IMR registers may not match the reversed order in the other
> registers (DCBA, and BA-DC or DC-BA).
>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>

Overall this is a beautiful driver and it makes use of all the generic
frameworks I can think of. I don't see any reason not to merge
it so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

The following is some notes and nitpicks, nothing blocking any
merge, more like discussion.

> +enum realtek_gpio_flags {
> +       GPIO_INTERRUPTS = BIT(0),
> +};

I suppose this looks like this because more flags will be introduced
when you add more functionality to the driver. Otherwise it seems
like overkill so a bool would suffice.

I would add a comment /* TODO: this will be expanded */

> +static inline u32 realtek_gpio_imr_bits(unsigned int pin, u32 value)
> +{
> +       return ((value & 0x3) << 2*(pin % 16));
> +}

I would explain a bit about this, obviouslt it is two bit per
line, but it took me some time to parse, so a comment
about the bit layout would be nice.

> +       unsigned int offset = pin/16;

Here that number appears again.

The use of GPIO_GENERIC and GPIO irqchip is flawless
and first class.

Thanks!
Linus Walleij
