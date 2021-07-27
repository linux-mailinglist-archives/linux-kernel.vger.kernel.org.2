Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB813D742A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhG0LRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:17:33 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:35581 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbhG0LRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:17:31 -0400
Received: by mail-vs1-f44.google.com with SMTP id p13so6912679vsg.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6KUNJv2uoXrIO9Z94cPI6QCbRXnZyOGViaOY2yoHjk=;
        b=mAWlOa+Zl9akLbOaF18EijYQjEi8dMThsv26ABPeIDXQSX8qXlBxnWFF4sJMj1ib/q
         2zreO3Q+iqS47memtGjDbYbCJsgLIuX56B16OXhZlDBK+9JD2944ts7DnXpWmZOPccfe
         07Ub1+3kB1gq8xxOxoOoW/sZMpAI5lak8Jk8ZBi990Z5ilb0XukLQTz8bvqCvUD0/SOm
         JrcrojbnQBuRKvpEyiCDNjgqD2FFYnU5y9CVAKa2y9IrB46cvrhdAnU6UzGSo3FRfx4v
         EK4fxYnDZAwqTy3ya9SYnwZZeVuXO18gVp5lbub76pz8u1Rgu0JW6quSaNtE8TGU5+fN
         OGgA==
X-Gm-Message-State: AOAM5334Hzh3LvoOJz1mifEwL/rUja+P06dqyZcj14A8OuJE5zsrC9ao
        LeOsW7r5NSAt58BlUbd5aLgojv45mgJQWigmtXc=
X-Google-Smtp-Source: ABdhPJzdJc/SjKstfuXj+nsFalKzdo9cYKN9WJguuDhjSXSUMFsd/595b57U+p6vypuiCz2+dHf3+igq1LjTvgJflcc=
X-Received: by 2002:a05:6102:2828:: with SMTP id ba8mr15836833vsb.18.1627384650666;
 Tue, 27 Jul 2021 04:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210727093015.1225107-1-javierm@redhat.com> <CAMuHMdXXoHLO=jsjb+xtW7GDQsvu8Zuz=JmbaEXT49w5o4SJ9A@mail.gmail.com>
 <f9df82c9-1e1a-d657-d712-312f5f17cab0@redhat.com>
In-Reply-To: <f9df82c9-1e1a-d657-d712-312f5f17cab0@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Jul 2021 13:17:19 +0200
Message-ID: <CAMuHMdVh4XgXeaLXXTmPxMuWM4C1mTDnhSmDmff6T37PwNxupg@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/firmware: fix SYSFB depends to prevent build failures
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Tue, Jul 27, 2021 at 12:22 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 7/27/21 12:03 PM, Geert Uytterhoeven wrote:
> >> --- a/drivers/firmware/Kconfig
> >> +++ b/drivers/firmware/Kconfig
> >> @@ -254,7 +254,7 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
> >>  config SYSFB
> >>         bool
> >>         default y
> >> -       depends on X86 || ARM || ARM64 || RISCV || COMPILE_TEST
> >> +       depends on X86 || EFI
> >
> > Thanks, much better.
> > Still, now this worm is crawling out of the X86 can, I'm wondering
> > why this option is so important that it has to default to y?
> > It is not just a dependency for SYSFB_SIMPLEFB, but also causes the
> > inclusion of drivers/firmware/sysfb.c.
> >
>
> It defaults to yes because drivers/firmware/sysfb.c contains the logic
> to register a "simple-framebuffer" device (or "efi-framebuffer" if the
> CONFIG_SYSFB_SIMPLEFB Kconfig symbol is not enabled).
>
> Not enabling this, would mean that a platform device to match a driver
> supporting the EFI GOP framebuffer (e.g: simple{drm,fb} or efifb) will
> not be registered. Which will lead to not having an early framebuffer.

Do all (embedded) EFI systems have a frame buffer?

Perhaps SYSFB should be selected by SYSFB_SIMPLEFB, FB_VESA,
and FB_EFI?

> The logic used to be in drivers/firmware/efi/efi-init.c, that's built
> in if CONFIG_EFI is enabled. We just consolidated both X86 and EFI:
>
> https://cgit.freedesktop.org/drm/drm-misc/commit/?id=8633ef82f101

Thanks, I'm aware of that commit, as I was just about to reply to it,
when I saw the patch is this thread ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
