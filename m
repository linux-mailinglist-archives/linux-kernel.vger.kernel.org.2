Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2294A42DFB2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 18:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhJNQxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 12:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhJNQxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 12:53:48 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37511C061755
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 09:51:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z11so28485882lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ra1p1AyrmgIfN1LhOPTR9YCOWFcOoaktP+SupTcX5Os=;
        b=kgwFN9+P42p59iUyH1bgxB5EOUt6yXyKLFe9dafbkr8/oRhl4xCcK+7FvJdgXPps5i
         5nS03roZT1sJ/0EMdUn3EyHAUOOyU9dgAQlVUhVKxrCqubUKB7LGcL1Cf1ty90DFVzxi
         tEJHXClQ0xj8pwmQXW8rRS4e89L5juTlh58QtT8o3rQNaeytlR8T4qwNS04L9fOqxNEp
         AiVUFHJHWNeTz60OUnEWI0yFIOs83SWbgK/pzceNLm5AJ6jBREMxUVaL+7Mg/8fxni+z
         Z/3B4lDye299Y1XMv+pv2RIsv7V7jP3GzozfBxfP/U9dJjsnbw1b/RBv1X+v/2hXe8M3
         kxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ra1p1AyrmgIfN1LhOPTR9YCOWFcOoaktP+SupTcX5Os=;
        b=saBJ8FqcbxldVNsXY0FabhAOjuXAtNMZlQMD2dyW9KRpXpyxpECsBkF6WSyIZQxogF
         tEsdJmBHPDDChGhQQOn7yoPt10gDIu+p9pCrvA993VBiFfnTGZPRg2KO9gwA1A1r0+36
         yU/Xx8JuRY+AbzM9drXkZTST4U51UXHU1B0f7tLUlX/RhVLVqT7K/XMWF15YsRdBdmc+
         mDGnDjZXWxDbHMQkmu6yhBbsCywV1dA95oLVprlODViNPNu8qwIf5QvCi1PZRGR8R6Lw
         YdYTG74kEqREsTmXHyX5o0+dRp+0ibDdBSTbIH9QCaepjCX0M233wuIesTUJlexeP0qV
         HhmA==
X-Gm-Message-State: AOAM533la03yFC+ddFJNta2jd0sz6cWAaEFwuNzTb4aUE4SfyMhAH8Uj
        H9GdbXmZxaGRGWVDlxcDXbp7ygFZO4INWXqfQ+WIPQ==
X-Google-Smtp-Source: ABdhPJy3jyeJ9514AUAE8389Xe37alzmco+h23EIxO+L8YCB/rVbaoTP0zJZ2ahD03wZDQMX1eu8JIQFxfrP6oJzESM=
X-Received: by 2002:a19:c10d:: with SMTP id r13mr6405229lff.339.1634230301515;
 Thu, 14 Oct 2021 09:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211014110437.64764-1-shreeya.patel@collabora.com>
In-Reply-To: <20211014110437.64764-1-shreeya.patel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Oct 2021 18:51:30 +0200
Message-ID: <CACRpkdbwx+6xB0=rwm60=2jM4OfyDKxkwAEZMgU=10LuijsW1A@mail.gmail.com>
Subject: Re: [PATCH] gpio: Return EPROBE_DEFER if gc->to_irq is NULL
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 1:05 PM Shreeya Patel
<shreeya.patel@collabora.com> wrote:

> We are racing the registering of .to_irq when probing the
> i2c driver. This results in random failure of touchscreen
> devices.
>
> Following errors could be seen in dmesg logs when gc->to_irq is NULL
>
> [2.101857] i2c_hid i2c-FTS3528:00: HID over i2c has not been provided an Int IRQ
> [2.101953] i2c_hid: probe of i2c-FTS3528:00 failed with error -22
>
> To avoid this situation, defer probing until to_irq is registered.
>
> This issue has been reported many times in past and people have been
> using workarounds like changing the pinctrl_amd to built-in instead
> of loading it as a module or by adding a softdep for pinctrl_amd into
> the config file.
>
> References :-
> https://bugzilla.kernel.org/show_bug.cgi?id=209413
> https://github.com/Syniurge/i2c-amd-mp2/issues/3
>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>

I understand the issue.

There is one problem.

> @@ -3084,7 +3084,7 @@ int gpiod_to_irq(const struct gpio_desc *desc)
>
>                 return retirq;
>         }
> -       return -ENXIO;
> +       return -EPROBE_DEFER;

If you after five minutes plug in a USB FTDI or similar UART thing
with a GPIO expander, and someone request an IRQ from
one of those lines (they do not support interrupts), why should
it return -EPROBE_DEFER?

The point is that I think this will in certain circumstances return
a bogus error.

We cannot merge this other than with a fat comment above:

/*
 * This is semantically WRONG because the -EPROBE_DEFER
 * is really just applicable during system bring-up.
 */
return -EPROBE_DEFER;

Can we use some kind of late_initcall() to just switch this over
to -ENXIO after a while?

Yours,
Linus Walleij
