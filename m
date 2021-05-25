Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D938F7C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 03:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhEYB7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 21:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhEYB7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 21:59:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22609C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 18:58:10 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so2589617wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 18:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9Vod4jvxokK9VdEVv9QbhmBpS7aCdhUUhHJ3yymm+s=;
        b=I8+KYs61OaiJOPwxmunC06w7DyvSPZsRqWTTPv3iVx3kF3guF8NbEMG5+0s4ACgBSs
         6nQ0beSnDxVqW79FbpaMaa46XVS4JwD30bFqVYa7OlFdxE+EPWGAGKTPHnPkSiQxeZVi
         SnPB5CUkT8J2SoVwhPqQIYewJVyaLDdrnYDYhJ7dXAyX0kef3+FAbafaSPs25JAwe3Nz
         jed0ObuvIxqTL2DQfxmeFaMxh5wl0B+1eR9KMeSy7zWNxqa/WZywhOv37SyxjGk2RJ41
         +we8gbjjwuoSQ0UtSoQcoG0SivISyYI6furHZUXiZ0qr3iC40Cj+a6qG+kPhhSVyI9PT
         5zoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9Vod4jvxokK9VdEVv9QbhmBpS7aCdhUUhHJ3yymm+s=;
        b=P0DTWlxNVD7D1fLaS2zHQ4kcltscD6Oeu/MP2AZGeonFyY9q4K6gI7QTNg1yanDA0R
         niuXVTVt+oMP/IIvpupU8jBMbf8gQndHHT9FbJ1RhwULbAc9PXnTy9Y82nX5Vg059gg3
         9AUTsUbwjmeCcqJ+ZiGT2s56EpcM0oDZDjMH5McN2/o7ZbZxpfhyB7JPBjS42vULynPr
         J48CX51u1fW/crMTt3xvMyUYvqL4sJcQnNV3SsrzXaBfHxV9o8Jl9khphkyr9q5KkXlI
         y3eKt+PQECKIHASFriUVtYxECfrQcCxImpavLpCMbPhK68xsOzfKWT1ViL8tWi+czL5n
         JUUg==
X-Gm-Message-State: AOAM533YEBkp0XY7Vgz4X7gLtFxRE7PqAP9DJJHta6WHbq3akJU9ip5Q
        l+6q2fuGSLxjMLxMrpAbEAtE034uwYNtjPa0pukjoQ==
X-Google-Smtp-Source: ABdhPJwyBNY6gxgr0BStEz0IHLGbsOoxI0c13AzPX8tmaxOjommyDeFuiOvhYNL2DIleg4ePPAPHK7maZQgO2TOT5GI=
X-Received: by 2002:a1c:cc17:: with SMTP id h23mr21285858wmb.129.1621907888471;
 Mon, 24 May 2021 18:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210523001806.3927609-1-tpiepho@gmail.com> <YKuFPeH0sIFqrBt6@smile.fi.intel.com>
 <CAGS_qxoKTyNBxoezkEVVrACGsFuzJwteepVpDzp+4KH+CgbMsw@mail.gmail.com>
 <b5511f68-814b-1f8c-08d2-a7dbddce4e8d@infradead.org> <CAGS_qxrZAxvRD5Scvd-dMahnf-27npMjbzKKjG-+Bk7hZgZj5g@mail.gmail.com>
 <bd3fceb3-4d49-befb-ee3b-bc01ef5d6827@infradead.org> <CAGS_qxrUGW4uyMUQtEYWX710LxPs23B=uOJfhZSvMV1yaVa6jA@mail.gmail.com>
 <CABVgOSnB2_WVtedhE+EPMM9v+ePOp2KMFze84oxGS9Pgf31HxA@mail.gmail.com> <caaab2dd-b1b6-b105-6b2f-9a2bc8438a82@infradead.org>
In-Reply-To: <caaab2dd-b1b6-b105-6b2f-9a2bc8438a82@infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Tue, 25 May 2021 09:57:57 +0800
Message-ID: <CABVgOSmTq37kVdvq0f1xmA-BVJ5k_z=QqZRE6DTkRZk-PaLJtg@mail.gmail.com>
Subject: Re: [PATCH] lib/math/rational.c: Fix divide by zero
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Trent Piepho <tpiepho@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Oskar Schirmer <oskar@scara.com>, Yiyuan Guo <yguoaz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 9:49 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 5/24/21 5:42 PM, David Gow wrote:
> > On Tue, May 25, 2021 at 7:38 AM Daniel Latypov <dlatypov@google.com> wrote:
> >>
> >> On Mon, May 24, 2021 at 4:30 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>>
> >>> On 5/24/21 3:56 PM, Daniel Latypov wrote:
> >>>> On Mon, May 24, 2021 at 3:04 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>>>>
> >>>>> On 5/24/21 9:55 AM, Daniel Latypov wrote:
> >>>>>> diff --git a/lib/math/Kconfig b/lib/math/Kconfig
> >>>>>> index f19bc9734fa7..20460b567493 100644
> >>>>>> --- a/lib/math/Kconfig
> >>>>>> +++ b/lib/math/Kconfig
> >>>>>> @@ -15,3 +15,14 @@ config PRIME_NUMBERS
> >>>>>>
> >>>>>>  config RATIONAL
> >>>>>>         bool
> >>>>>> +
> >>>>>> +config RATIONAL_KUNIT_TEST
> >>>>>> +       tristate "KUnit test for rational number support" if !KUNIT_ALL_TESTS
> >>>>>> +       # depends on KUNIT && RATIONAL  # this is how it should work, but
> >>>>>> +       depends on KUNIT
> >>>>>> +       select RATIONAL # I don't grok kconfig enough to know why this
> >>>>>
> >>>>> Only to set the symbol CONFIG_RATIONAL.
> >>>>> Then when 'make' descends into the lib/math/ subdir and looks at its Makefile,
> >>>>> it will decide to build the binary rational.o.
> >>>>>
> >>>>> obj-$(CONFIG_RATIONAL)          += rational.o
> >>>>>
> >>>>
> >>>> Ack, I understand that much.
> >>>
> >>> Oh! Clearly I misunderstood the problem.
> >>>
> >>> I had to look thru 60 config files before I found one where CONFIG_RATIONAL
> >>> was not set.
> >>>
> >>> And I'm still not sure, but I believe that it's because it has to be set
> >>> by some other Kconfig entry doing a 'select' on it.
> >>>
> >>> Here are the kconfigs that select it (on i386, where I found it not set):
> >>>
> >>> - COMMON_CLK [=n] && !HAVE_LEGACY_CLK [=n]
> >>> - SERIAL_8250_LPSS [=n] && TTY [=n] && HAS_IOMEM [=y] && SERIAL_8250 [=n] && PCI [=n] && (X86 [=y] || COMPILE_TEST [=y])
> >>> - SERIAL_8250_MID [=n] && TTY [=n] && HAS_IOMEM [=y] && SERIAL_8250 [=n] && PCI [=n] && (X86 [=y] || COMPILE_TEST [=y])
> >>> - SERIAL_IMX [=n] && TTY [=n] && HAS_IOMEM [=y] && (ARCH_MXC || COMPILE_TEST [=y])
> >>> - VIDEO_V4L2 [=n] && MEDIA_SUPPORT [=n] && (I2C [=y] || I2C [=y]=n) && VIDEO_DEV [=n]
> >>> - SND_SOC_ROCKCHIP_PDM [=n] && SOUND [=n] && !UML && SND [=n] && SND_SOC [=n] && CLKDEV_LOOKUP [=n] && SND_SOC_ROCKCHIP [=n]
> >>> - COMMON_CLK_QCOM [=n] && COMMON_CLK [=n] && OF [=y] && (ARCH_QCOM || COMPILE_TEST [=y])
> >>>
> >>> but my test config has none of those enabled, so I cannot set RATIONAL.
> >>>
> >>> I guess the easiest solution is to have KUNIT or some sub-KUNIT test
> >>> just select RATIONAL.
> >>
> >> Yeah, the easiest thing would be to keep the `select RATIONAL` that I
> >> showed in the example patch.
> >>
> >> +David Gow +Brendan Higgins as they both particularly wanted to avoid
> >> having any tests `select` their dependencies, however.
> >>
> >
> > This came from a thread[1], and one of the causes behind it was not
> > wanting to have KUNIT_ALL_TESTS enable things like filesystems and
> > drivers which wouldn't otherwise be built.
>
> Ah yes, I recognize that thread.
>
> > Personally, I think that RATIONAL is probably an okay thing to select
> > here: it's not as heavyweight as drivers/filesystems/etc, and our
> > general guidance here is "avoid select where sensible to do so", not
> > "don't use it under any circumstances".
>
> RATIONAL does not have a prompt string, so depending on it would not
> be reliable.  I.e., it is meant to be selected.

Yeah: let's just select it then.

It's better to have KUNIT_ALL_TESTS pull in something extra than to
have tests we've no reliable way of enabling, IMHO.

> > The other option would be to have a separate config entry which just
> > selected RATIONAL, but even I think that's probably uglier, however
> > nice it is for guaranteeing flexibility.
>
> Yes, that's even worse.
>
> > [1]: https://lore.kernel.org/linux-ext4/52959e99-4105-3de9-730c-c46894b82bdd@infradead.org/T/#t
> >
> >>>
> >>>> My confusion is why this doesn't work:
> >>>>
> >>>> $ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
> >>>> CONFIG_KUNIT=y
> >>>> CONFIG_RATIONAL=y
> >>>> EOF
> >>>> ...
> >>>> ERROR:root:Provided Kconfig is not contained in validated .config.
> >>>> Following fields found in kunitconfig, but not in .config:
> >>>> CONFIG_RATIONAL=y
> >>>>
> >>>> What it's complaining about is that `make  ARCH=um olddefconfig` is
> >>>> leaving CONFIG_RATIONAL=y unset.
> >>>>
> >>>> Stripping out kunit.py, it's this:
> >>>>
> >>>> $ echo -e 'CONFIG_KUNIT=y\nCONFIG_RATIONAL=y' > .kunit/.config
> >>>> $ make ARCH=um olddefconfig O=.kunit
> >>>> $ grep RATIONAL .kunit/.config
> >>>>
> >>>> I'm not versed in Kconfig enough to know why CONFIG_RATIONAL=y is
> >>>> getting removed.
> >>>>
> >>>>>
> >>>>>> is necessary
> >>>>>> +       default KUNIT_ALL_TESTS
> >>>>>> +       help
> >>>>>> +               This builds unit tests for the rational number support.
> >>>>>> +
> >>>>>> +               If unsure, say N.
>
>
> --
> ~Randy
>
