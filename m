Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64093B9A08
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 02:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhGBA1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 20:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhGBA1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 20:27:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8AEC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 17:25:04 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bq39so2396466lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 17:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wo3mWrRVfLnTDuSZE7ztXLSWtF8MkIqUkDyG5RURRQ0=;
        b=C2EWWE37L+OoBPu7eLnLqGK4cSpRHCv2jln1B74h06OXV8Gyb310jNJwfks6YbE9eM
         fhN0o1OfEzdYFmidGABOG+WGVZw0KgD1pv1uxqZXlt+/8UtzEZxwI0hSM0bNnO8X4y6Z
         wEpbTZSvip8RmeIS4/A2I9oANvm5NKlFkcEBYHDxk2ty/9UMrYCAY+DvR3mHyO6Ty+I/
         xgn5CElsWykMw6oxdRVzgXkuxUtTmMzR3eWir4Wl0tvVulNKy0tb31JhKw06XHDNEH4c
         tERqyC41sAtntKuFYA0VZ58s74kGL/gDkqI0T4O1xe4aIfZ/bV2YMFq+DwljLZxZAqnk
         btjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wo3mWrRVfLnTDuSZE7ztXLSWtF8MkIqUkDyG5RURRQ0=;
        b=lPfRimfpLmMlgxJ7C4K/aVAVy8GXkMXGgOmY1nw1VUiNoUceJY5cqvNXR8GQEydi47
         dhXxbeYy2bmlrxwTaCmON33gtlSK+kkxs5eFmcMmJ2A+Nvvfn+9ztSnCO93eA2V3qS6z
         e33Mlr2p4F9YiAE2qQRPpOb+anmAj8ffqYeJliftJ25acca8WJLLIwGehTFlKlDrV3hE
         E21aZLk0muTjRg07MYc3mYdzhXLOJkQIrrzC1W2URRdxYDWNBwaDPPb9LEFCEXk9mHwf
         sufo+/yrxUg6Ci5BzrYtdsfo/K51RIsa4Tac51yH8bPQ740Qk7puaudoOQhV9kNO2kG+
         nPnw==
X-Gm-Message-State: AOAM5306SPa4WUsOGfzT0IcQ8dSY3hPvapj0FFtEuyibRGuhR8Rx5ZTk
        7V4NJ3eNtjv1EPmdR5X8gJYJcb25A4XU1RyKqHy7ew==
X-Google-Smtp-Source: ABdhPJxq5/SOnkLpkiqYXRJ5O5zWGrv0y3PynYICvDZh8trNSob31ysDF+HDTEGcYf5nTE68A0CF7qluLYN11g0N9eg=
X-Received: by 2002:a05:6512:3c9f:: with SMTP id h31mr1664410lfv.465.1625185502545;
 Thu, 01 Jul 2021 17:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAF78GY0jB_oeKgfZc4SHWBVusGnNfxKk5jTC4UBDsteSEVEzTw@mail.gmail.com>
 <CAHp75VeZwUiK2v8HZ=MLGSkK8wLudDEJFhBSm--Wu9gzABhmSg@mail.gmail.com>
 <CAHp75Vd6M6D9baiGi8fU8a=pfXnSKtEgQ4+eMiwPh6P9cg1ojA@mail.gmail.com> <CAF78GY1PO3YwYHgQkEhYF1_FRQ=HVOOWFtECcHen9PFCR1=JOA@mail.gmail.com>
In-Reply-To: <CAF78GY1PO3YwYHgQkEhYF1_FRQ=HVOOWFtECcHen9PFCR1=JOA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 2 Jul 2021 02:24:51 +0200
Message-ID: <CACRpkdbU2hs9VVH+sCNVi2hoB53WJ6LmUdndOvbjk9wVvyf4kQ@mail.gmail.com>
Subject: Re: gpiochip_lock_as_irq on pins without FLAG_REQUESTED: bug or
 feature ?
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 12:52 AM Vincent Pelletier
<plr.vincent@gmail.com> wrote:

> While on this topic, there is a bullet point in
> Documentation/driver-api/gpio/driver.rst which I fail to understand:
>
> | - Nominally set all handlers to handle_bad_irq() in the setup call and pass
> |   handle_bad_irq() as flow handler parameter in
> gpiochip_irqchip_add() if it is
> |   expected for GPIO driver that irqchip .set_type() callback will be called
> |   before using/enabling each GPIO IRQ. Then set the handler to
> |   handle_level_irq() and/or handle_edge_irq() in the irqchip .set_type()
> |   callback depending on what your controller supports and what is requested
> |   by the consumer.
>
> - why the plural in "set all handlers to handle_bad_irq()" ? Isn't
>   there only a single handler in struct gpio_irq_chip ?

girq->handler will be applied (inside gpiolib) successively to
all the irq lines on the irqchip, as many as you have GPIO lines.
It will then be set to something usable when we get
to ->set_type() when an IRQ is being requested.

> - I do not find a function named gpiochip_irqchip_add(), only
>   gpiochip_irqchip_add_domain()

This refers to the old API that didn't add the irqchip with the
gpiochip. Needs updating. Patches welcome ;)

> - "Then set the handler to [...] in the irqchip .set_type() callback"
>   Isn't set_type per-pin, and isn't the interrupt handler chip-level ?

Those are two different things. The ->set_type() callback is
per-line (call it lines, not pins, because terminology can be
confusing otherwise), these are the interrupt handlers per-line
apart from of course the handler the consumer provides in
e.g. request_[threaded_]irq().

There is usually another cascading interrupt handler for the GPIO
irqchip itself, usually what is passed in girq->parent_handler
*BUT* you are looking at an hierarchical interrupt controller with
one line per gpio line to the next level of irq controller, so
you do not see this. You don't have a chip-level interrupt
handler in the sifive driver, all falls through upward in the
hierarchy to the next overarching interrupt controller.

Yours,
Linus Walleij
