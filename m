Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E13039719C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhFAKj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhFAKj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:39:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71354C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 03:38:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x38so20994193lfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 03:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yN5uiFBkkTeT2+j1gnjicofSI0ZU0aW0s8cvIPMUB5c=;
        b=Yp4g9qfAZ2U4RijeC/9A/sXt0dNmQH8B2qgnGaUsUALb9c0wdcbuwpoelkQx97gpJ7
         g1q1rUo6V/D+UN0Xy7n9Wwkh+MlP/n5z3hm41lYLlHgL+aB4y+PEHQ7/stAQvwxqoMdd
         KsVE/QJlsIt0BZTMveHgGG9V4wkx8m9LMjZTiY8qklY58VAkq7gXoONJ+GzdZGmtKu5f
         US1s4g+gA9pgtUUoc3GFG2mMLabhCX3JtI/1lwAtbqD5MjUa/nnwM/Bx3TUkeVDFis3i
         MgBiwJCASB7dQyqwmQH+j+6UeHjCZKrSn+ticL0q6+9zcP0gELkMRAvgr6qFvzPpuiad
         no8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yN5uiFBkkTeT2+j1gnjicofSI0ZU0aW0s8cvIPMUB5c=;
        b=WJs+d96JfVJ7lrr+dnjYuXkpGimI8u0xu7pjAwSeVkExnG+iOHTJgJDDmBTlkiiGnc
         0Wl4isEFNsGE+xaW4vJjqu+HWx+qZ2D8rwyWgX65Wp4IEZrXSyu5/obdt0mFSd5q7lYF
         kmy/7EtL5FwQh+u+g2zsm4Q9qfadspd9oIRvsrajkCssxjMGzA4UuzsDMBsEcnph2PUt
         wJHLkfO2G2qI19MC0C32eWGK7hw0A0h1SzSyIoXxQu3PrTgV/3xX0lj+WlE3OgoxYyLf
         hfEzreyzG5j1qYRKR8h7hKKRKtux+zMaDOPfvNs/pappUOY2MukIbzOP+SQpgkba75Ms
         owtA==
X-Gm-Message-State: AOAM530SNpLbhZNA/Ra8dnxRDFwFnAyKCnfPstyX2nqtVc+8tfk82WZW
        e4Vnvil7a9gyBpHr8vWoWHdRlJxFz+HQQZ0vhsQVbw==
X-Google-Smtp-Source: ABdhPJyrNY1gdF74/aahJD6WWpvmsfypMnfesq4IK/NIfeVwSBC8cYbo6kOwQ59ZGcFwYnmhMPCTSa5bqu3fh/F7YJ4=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr18182416lfn.465.1622543892812;
 Tue, 01 Jun 2021 03:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210325122832.119147-1-sandberg@mailfence.com>
 <20210530161333.3996-1-maukka@ext.kapsi.fi> <20210530161333.3996-3-maukka@ext.kapsi.fi>
In-Reply-To: <20210530161333.3996-3-maukka@ext.kapsi.fi>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 1 Jun 2021 12:38:01 +0200
Message-ID: <CACRpkdYf06W2QDY6EN0OG3RjOnJ+AVE+Wd4M6Z9=B7aZ9rGfwA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] gpio: gpio-mux-input: add generic gpio input multiplexer
To:     Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     Mauri Sandberg <sandberg@mailfence.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Drew Fustini <drew@beagleboard.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 6:16 PM Mauri Sandberg <maukka@ext.kapsi.fi> wrote:

> Adds support for a generic GPIO multiplexer. To drive the multiplexer a
> mux-controller is needed. The output pin of the multiplexer is a GPIO
> pin.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
> Tested-by: Drew Fustini <drew@beagleboard.org>
> Reviewed-by: Drew Fustini <drew@beagleboard.org>

The commit message and part of the driver becomes hard to
read and understand because the word pin is overused.
Switch to talk about "gpio lines" rather than pins.

Draw a simple ASCII image like this:

               /|---- Cascaded GPIO line 0
              |M|---- Cascaded GPIO line 1
GPIO line ----+U| .
              |X| .
           \|---- Cascaded GPIO line n

Maybe also as illustration in the driver and in the bindings.
Make things easy to understand.

Explain exactly why only input lines can be multiplexed.

I'm not sure it should be restricted to just input
in theory, but since that is all we can test, restrict it to
input in practice.

> +config GPIO_MUX_INPUT
> +       tristate "General GPIO input multiplexer"

Rename it just GPIO_MUX
  "General GPIO multiplexer"

Then clarify in the help description that it currently can only
handle input lines.

> +       depends on OF_GPIO
> +       select MULTIPLEXER
> +       select MUX_GPIO
> +       help
> +         Say yes here to enable support for generic GPIO input multiplexer.
> +
> +         This driver uses a mux-controller to drive the multiplexer and has a
> +         single output pin for reading the inputs to the mux. The driver can
> +         be used in situations when GPIO pins are used to select what
> +         multiplexer pin should be used for reading input and the output pin
> +         of the multiplexer is connected to a GPIO input pin.

Input output etc, this gets very hard to understand.

Switch terminology from "pin" to "GPIO lines", (or "GPIO rails").

Use the word "routing" as the GPIO line is routed through the
multiplexer. Maybe spell out multiplexer for clarity.

Explain why, for electrical reasons, output lines are harder
to multiplex like this, as the output will not maintain
state. Notice that "using open drain constructions, output
multiplexing may be possible, but it is currently not implemented."

> +static int gpio_mux_input_get_direction(struct gpio_chip *gc,
> +                                       unsigned int offset)
> +{
> +       return GPIO_LINE_DIRECTION_IN;
> +}

Explain why this is a restriction with a comment in the code.
Add comment that in the future we might be able to handle
also output.

> +static int gpio_mux_input_get_value(struct gpio_chip *gc, unsigned int offset)

This looks very nice!

We might have to extend this driver at some point.

Intuitively I'd say it takes some time and then someone
comes along and say "actually we have done this
for output as well, using some open drain and stuff"
but this is a good starting point anyway we need no
big upfront designs.

Yours,
Linus Walleij
