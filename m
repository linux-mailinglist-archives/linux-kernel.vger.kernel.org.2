Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA233D0F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbhGUMhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbhGUMht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:37:49 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FFAC061766
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:18:25 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id r135so205774ybc.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1rRa3phHTJWmbuCa9Ba7yDi4LWrl8+YODk9pdiOglY=;
        b=Gyv0aaXDH/IFhULwdSv6HQFnFAX7svUaaxi00pmF2amALPQgQwO9WU013kLXFcuo2I
         5aTlq9gfRsCp6WVrjQ4GA63N1E++ar7bG6zH0tLeVS2ke2DDJrMLzXMnGmKrzyjnK9kt
         /cwTndRguTHL3dwJGuFJhPi4yFmxhH3Tp2N8IRx8TUtOsaMtdztuejeNL0ZtCarhsfyG
         HEKzGM4CXveSYgwwmV9NB6qXYqHJuOm49bhR9Yuhpewkc0C/ibBpoRsH4baSssyPWByr
         kqkj5DCLmTZyMCiblmCi9JSbvjt56yBgQF8FDQNSMagccXnjj67E6uOb6xrpiwHJ9URU
         iE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1rRa3phHTJWmbuCa9Ba7yDi4LWrl8+YODk9pdiOglY=;
        b=IefIVCE51PX2DabsNBz32MlMZz8Mf239PJyAHQ4E55RIoG+uBRbzscGF2q9xsOfyj/
         I9CHzrZX8TiaWaxxA0SneJMdT2d+MwQG3Oz9OuAIcpoAci4i+o9JftaNvSLFcxO/2pTH
         OEGU8gkP94mw1vCidOi7RPp4jP8ug8FOiefqaW7kP8Gr7J8SeqgO5Hl7M7nkvAAgc9FA
         UUn8dD/rywmeYQx9SyjDrYaAzvh/fK8e0at8+YHLmzUTxuoqq2L882B+5nThryK1lTR9
         OJIKushuZKEsD8tN0C+VA2wDyWFDHp/3Gzbxe8cCgaQfFxwtQ5na3x1WC4IbeaOqJH0a
         Zsgw==
X-Gm-Message-State: AOAM532CFl8Qo8xfkTYtoImRgkSkaSc43o8uBy0YyWVVU9cf+98yRHDa
        g/AhiGtrcXPvbWBscn3IteN6GoEkwCcbe05gKWrvkQ==
X-Google-Smtp-Source: ABdhPJy1PounyikHq+KqbdeJm1FzIvQPgLEgmuaTn6HxAFMpGA8GZziNxOCNjkSgQAKm72hRdIAmqPpEZ7k606KEI6I=
X-Received: by 2002:a25:ca54:: with SMTP id a81mr26076620ybg.157.1626873504672;
 Wed, 21 Jul 2021 06:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <5d1823c503629694de74ccd2d823188507c54706.1625445811.git.plr.vincent@gmail.com>
In-Reply-To: <5d1823c503629694de74ccd2d823188507c54706.1625445811.git.plr.vincent@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 21 Jul 2021 15:18:14 +0200
Message-ID: <CAMpxmJVSSsRM1W957E-urQqbY1PB+wQ6sRCRnCaHVKg6ge13ZA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: driver.rst: Remove
 gpiochip_irqchip_add mention
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 2:44 AM Vincent Pelletier <plr.vincent@gmail.com> wrote:
>
> This function was removed in commit f1f37abbe6fc ("gpio: Retire the
> explicit gpio irqchip code") but this mention was left behind.
> Also, mention that .set_type() only has to set a line handler if the chip
> is cascaded, as opposed to hierarchical.
>
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> ---
>  Documentation/driver-api/gpio/driver.rst | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
> index d6b0d779859b..bbc53920d4dd 100644
> --- a/Documentation/driver-api/gpio/driver.rst
> +++ b/Documentation/driver-api/gpio/driver.rst
> @@ -547,13 +547,10 @@ To use the helpers please keep the following in mind:
>    the irqchip can initialize. E.g. .dev and .can_sleep shall be set up
>    properly.
>
> -- Nominally set all handlers to handle_bad_irq() in the setup call and pass
> -  handle_bad_irq() as flow handler parameter in gpiochip_irqchip_add() if it is
> -  expected for GPIO driver that irqchip .set_type() callback will be called
> -  before using/enabling each GPIO IRQ. Then set the handler to
> -  handle_level_irq() and/or handle_edge_irq() in the irqchip .set_type()
> -  callback depending on what your controller supports and what is requested
> -  by the consumer.
> +- Nominally set gpio_irq_chip.handler to handle_bad_irq. Then, if your irqchip
> +  is cascaded, set the handler to handle_level_irq() and/or handle_edge_irq()
> +  in the irqchip .set_type() callback depending on what your controller
> +  supports and what is requested by the consumer.
>
>
>  Locking IRQ usage
> --
> 2.32.0
>

Patch applied, thanks!

Bartosz
