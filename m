Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F290F38F64C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhEXXj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEXXjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:39:55 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077A1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 16:38:26 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id j30so26507327ila.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 16:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2YKrWGrNRhpKB7nbC+pa0pby1lLy9Of2lysL0djOLk=;
        b=O3nsE6E8dgqr1wZZ/sIpvjSGnuUc50HnZupw5P0IGyrnOqFDvZQIYh0q3FFLzPHD2o
         vD8yZqdyRbqlXfEVZ/KOIGzb+UHW6phkAm0CVJ40Pe59VO8zxV0aFrMrWg3rG5tMKM4M
         xNmMw2fqJ2tYZ8zCauidfFKYnukl3CGKszg7XpdXYtA6oKSKmNONOfRmsVVpdYnt8xlq
         PIicCeSlyjEZkVcnL3KdMl/m3sccySmQkfpAxl4lXZOmyiheR1RzsV1jHfhFAGTkXSS+
         q1b9v3tGsvtTbRn7hj6kdcXoYrPGVJJsirPxJg5XxhefRyN4C898vrp2+38nHAIPjc1F
         KHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2YKrWGrNRhpKB7nbC+pa0pby1lLy9Of2lysL0djOLk=;
        b=k48jo9qXVB7YzozM2dTI1lSSDSxOXiH+fkcLd8PaGB1oVc1EFrBw9xFVGZnSEAOCCm
         fEQgrWLs+CKqZB9csTFzCcTpI0uxWEAUcNs2XEZ2jOIPPNVDx6uH7oE/CkRDNATOR1bw
         y+eC0zxfd14CXbhQMnr87oR30AT78TUFvr/qrIPfY3wStgSRBorB3U9YVHNJDaOl9nT/
         yQT0Ti/8V8YV1wD0q17chk9pu3K+fGQcTvYpWWhGflbJqgUSsoSIhByIczLvT0WNStIk
         c0nBc87HwWk5zsR23VCRuu1gkgzslBxz3tIbCef2iFkhEzhMFg8gEiA05olojSgXJdDH
         bsmQ==
X-Gm-Message-State: AOAM5305+L5uI/96efXlxPqgb1hCDCTemlPK91BqBKJz/jCY0Tv7CZTm
        0bHAun9FA61FDBi7vjrptHUb4sNigDelOduUohex1w==
X-Google-Smtp-Source: ABdhPJwPnS5nSShfq26PfDeqyE7An+gQpZNnWds1Nq8ETmfP6WUUeMYWy8oti+8Kr3qNNofM+69QuhAHu/Oe213SjQE=
X-Received: by 2002:a05:6e02:1067:: with SMTP id q7mr17629801ilj.75.1621899504965;
 Mon, 24 May 2021 16:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210523001806.3927609-1-tpiepho@gmail.com> <YKuFPeH0sIFqrBt6@smile.fi.intel.com>
 <CAGS_qxoKTyNBxoezkEVVrACGsFuzJwteepVpDzp+4KH+CgbMsw@mail.gmail.com>
 <b5511f68-814b-1f8c-08d2-a7dbddce4e8d@infradead.org> <CAGS_qxrZAxvRD5Scvd-dMahnf-27npMjbzKKjG-+Bk7hZgZj5g@mail.gmail.com>
 <bd3fceb3-4d49-befb-ee3b-bc01ef5d6827@infradead.org>
In-Reply-To: <bd3fceb3-4d49-befb-ee3b-bc01ef5d6827@infradead.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 24 May 2021 16:38:13 -0700
Message-ID: <CAGS_qxrUGW4uyMUQtEYWX710LxPs23B=uOJfhZSvMV1yaVa6jA@mail.gmail.com>
Subject: Re: [PATCH] lib/math/rational.c: Fix divide by zero
To:     Randy Dunlap <rdunlap@infradead.org>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Trent Piepho <tpiepho@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Oskar Schirmer <oskar@scara.com>, Yiyuan Guo <yguoaz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 4:30 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 5/24/21 3:56 PM, Daniel Latypov wrote:
> > On Mon, May 24, 2021 at 3:04 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> On 5/24/21 9:55 AM, Daniel Latypov wrote:
> >>> diff --git a/lib/math/Kconfig b/lib/math/Kconfig
> >>> index f19bc9734fa7..20460b567493 100644
> >>> --- a/lib/math/Kconfig
> >>> +++ b/lib/math/Kconfig
> >>> @@ -15,3 +15,14 @@ config PRIME_NUMBERS
> >>>
> >>>  config RATIONAL
> >>>         bool
> >>> +
> >>> +config RATIONAL_KUNIT_TEST
> >>> +       tristate "KUnit test for rational number support" if !KUNIT_ALL_TESTS
> >>> +       # depends on KUNIT && RATIONAL  # this is how it should work, but
> >>> +       depends on KUNIT
> >>> +       select RATIONAL # I don't grok kconfig enough to know why this
> >>
> >> Only to set the symbol CONFIG_RATIONAL.
> >> Then when 'make' descends into the lib/math/ subdir and looks at its Makefile,
> >> it will decide to build the binary rational.o.
> >>
> >> obj-$(CONFIG_RATIONAL)          += rational.o
> >>
> >
> > Ack, I understand that much.
>
> Oh! Clearly I misunderstood the problem.
>
> I had to look thru 60 config files before I found one where CONFIG_RATIONAL
> was not set.
>
> And I'm still not sure, but I believe that it's because it has to be set
> by some other Kconfig entry doing a 'select' on it.
>
> Here are the kconfigs that select it (on i386, where I found it not set):
>
> - COMMON_CLK [=n] && !HAVE_LEGACY_CLK [=n]
> - SERIAL_8250_LPSS [=n] && TTY [=n] && HAS_IOMEM [=y] && SERIAL_8250 [=n] && PCI [=n] && (X86 [=y] || COMPILE_TEST [=y])
> - SERIAL_8250_MID [=n] && TTY [=n] && HAS_IOMEM [=y] && SERIAL_8250 [=n] && PCI [=n] && (X86 [=y] || COMPILE_TEST [=y])
> - SERIAL_IMX [=n] && TTY [=n] && HAS_IOMEM [=y] && (ARCH_MXC || COMPILE_TEST [=y])
> - VIDEO_V4L2 [=n] && MEDIA_SUPPORT [=n] && (I2C [=y] || I2C [=y]=n) && VIDEO_DEV [=n]
> - SND_SOC_ROCKCHIP_PDM [=n] && SOUND [=n] && !UML && SND [=n] && SND_SOC [=n] && CLKDEV_LOOKUP [=n] && SND_SOC_ROCKCHIP [=n]
> - COMMON_CLK_QCOM [=n] && COMMON_CLK [=n] && OF [=y] && (ARCH_QCOM || COMPILE_TEST [=y])
>
> but my test config has none of those enabled, so I cannot set RATIONAL.
>
> I guess the easiest solution is to have KUNIT or some sub-KUNIT test
> just select RATIONAL.

Yeah, the easiest thing would be to keep the `select RATIONAL` that I
showed in the example patch.

+David Gow +Brendan Higgins as they both particularly wanted to avoid
having any tests `select` their dependencies, however.

>
> > My confusion is why this doesn't work:
> >
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
> > CONFIG_KUNIT=y
> > CONFIG_RATIONAL=y
> > EOF
> > ...
> > ERROR:root:Provided Kconfig is not contained in validated .config.
> > Following fields found in kunitconfig, but not in .config:
> > CONFIG_RATIONAL=y
> >
> > What it's complaining about is that `make  ARCH=um olddefconfig` is
> > leaving CONFIG_RATIONAL=y unset.
> >
> > Stripping out kunit.py, it's this:
> >
> > $ echo -e 'CONFIG_KUNIT=y\nCONFIG_RATIONAL=y' > .kunit/.config
> > $ make ARCH=um olddefconfig O=.kunit
> > $ grep RATIONAL .kunit/.config
> >
> > I'm not versed in Kconfig enough to know why CONFIG_RATIONAL=y is
> > getting removed.
> >
> >>
> >>> is necessary
> >>> +       default KUNIT_ALL_TESTS
> >>> +       help
> >>> +               This builds unit tests for the rational number support.
> >>> +
> >>> +               If unsure, say N.
>
>
> --
> ~Randy
>
