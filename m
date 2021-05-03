Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C00371882
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhECPyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhECPyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:54:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EB2C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 08:53:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id b25so8616753eju.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 08:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYI/2ah7JvMucDSue7SPKjYm0sw5/1few+c9gAtWPDo=;
        b=Jfl41ILUGA3qDyj+Gpt2YVFBF1d0fIKWUoKVxWvDKYCa1yxUV1P3vTFqczSFBdJqHY
         NBUGuqwSV6Ms8BftAABAXVdmqEDU0KSsK2XDjLG3HazyiVQrvmb5Wmy4uF6JEDHXdTWQ
         ZLUvNJTcg16RddN2DshMvJ4P8fGk5eFao26rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYI/2ah7JvMucDSue7SPKjYm0sw5/1few+c9gAtWPDo=;
        b=NaILIu2moQFkXfXLOvFBOdlebSGZJyGsUhpyZlZY1jRzVMDWMSZALv8CqGK79ahP9F
         iR5Mn5Vli4HhR4U9HiIJ1zvBQUeJjL/3UukdfMXTMv0ce3wyBmGJTbao6+10a+6DdLqa
         IXYoG19FLfmzD3BKwAMwZvM317B1rjovoD7H0EL1PKPSROSHcYKQc4DjfoYazcekVIDC
         HnNWZebBP4PsC/UHEHGh3v3srtpB0JKY5UZnfCVK4/n2q/XEng1WrSxDz0Hm6nf/ncYL
         +PM+0a8jFfXrLZPDOkbbaaR6lLyixFqm7C9qxCKzkxiYdtoLeD8bgtVQ6NddQ78g12Bu
         vzFA==
X-Gm-Message-State: AOAM531NA5CmHDy+4IoyPd1bWF1msat+6SxpDH+AhMQGnYoWO653aDml
        DW8JbHVKKcoLHl2Mt8W8QRh1kWCkuBnr1g==
X-Google-Smtp-Source: ABdhPJyvoz57kv0MTEjuTLvum86hUO9q1k8QbzoYBYVxoqrHdmjZOdnNCkz6Tl4oG6b9ojmwlgN2qw==
X-Received: by 2002:a17:906:cd27:: with SMTP id oz39mr13684953ejb.129.1620057219585;
        Mon, 03 May 2021 08:53:39 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id l11sm12502094edw.42.2021.05.03.08.53.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 08:53:38 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id g14so6831880edy.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 08:53:38 -0700 (PDT)
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr20986933eds.291.1620057217782;
 Mon, 03 May 2021 08:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210429163341.1.I7631534622233689dd81410525e0dd617b9b2012@changeid>
 <CAHp75Vfvknn6O2cc4XYUuo4U_C1nguMHjJPxmRQapf8h0QjGFw@mail.gmail.com>
In-Reply-To: <CAHp75Vfvknn6O2cc4XYUuo4U_C1nguMHjJPxmRQapf8h0QjGFw@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 3 May 2021 09:53:26 -0600
X-Gmail-Original-Message-ID: <CAHQZ30B7-0EJst0h26JzRKb15n+RKnv=FSpkngLTAcU4UChDjg@mail.gmail.com>
Message-ID: <CAHQZ30B7-0EJst0h26JzRKb15n+RKnv=FSpkngLTAcU4UChDjg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: amd: Implement irq_set_wake
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kramasub@chromium.org, Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 3:22 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Apr 30, 2021 at 1:34 AM Raul E Rangel <rrangel@chromium.org> wrote:
> >
> > This allows the OS to control which devices produce wake events.
> >
> > $ grep enabled /sys/kernel/irq/*/wakeup
> > /sys/kernel/irq/24/wakeup:enabled
>
> Is it a bug fix of [1]?
>
> If so, add a BugLink: tag here.

No bug, just implementing a missing feature. This allows the use of
the ACPI _AEI object.
>
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
>
> [1]:
>
> ...
>
> irq_hw_number_t hw = irqd_to_hwirq(d);
>
> > +       pin_reg = readl(gpio_dev->base + (d->hwirq)*4);
>
> > +       writel(pin_reg, gpio_dev->base + (d->hwirq)*4);
>
> Too many parentheses and missed spaces

I copy/pasted the exact format used in all the other functions:
amd_gpio_irq_{enable,disable,mask,unmask}. I can send a CL to reformat
everything if you want. Or I can just change this specific function.
Let me know.

>
>
> --
> With Best Regards,
> Andy Shevchenko

Thanks for the review!
