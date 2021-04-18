Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533BD3636FE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 19:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhDRRZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 13:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhDRRZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 13:25:52 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2573C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 10:25:21 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id i9so1547903vsb.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 10:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4m9H5rbd0Mtg5kZhpTF+t95XIg2YArKMffn0TP0UtbA=;
        b=uM5scnEmn3BHKWfBLPG37Jv0IWgQrmZMvcDbcRIedbqAci38mK3VNaI9jZM3OnWDXJ
         6iMCtJZhhYZYM7h596sm6KiKE7E02d88izaxTUzlLKjvgiVLPWz6av9MBShLmLmIDZRY
         TSTP3xKxLYCbHecURfRj5zIcaFYkXAQs4FzC/2M0bs3Zzv6JS7SrYZhzQSg8iokzb8ki
         17WYy1iAnxnueyE6Qcyb11ltrrPKs3GO6KJnxd0g4m9xvMHsX2becJKWmPiX/wW5xAJG
         CvZN5u0yJPzBfK7Ix5HwmLuS2eyBGT9XkmZoP75RnWO9ao3NPe+rW6osac2TIWWXaqQc
         xm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4m9H5rbd0Mtg5kZhpTF+t95XIg2YArKMffn0TP0UtbA=;
        b=L53m0TWLMXj9mv7hGYQTDe+Kkguqzygls2+Ma4YW2QDIp006svUrsF+F6zxF367J8W
         LycKi2+yaMrkPTvtDCdeK1GsGPkayj5/l/C/KaTrBJGGY6UVaTaerg+qCbVFNoV/g+q8
         xe9oho5yQdfNg3q+bOIk6SfmdPFoJ3yaAZLWYhtFg9A9OQMjlCquxtuA9UmWHzEGdJpw
         iAcz2NA1tgjRdXFftiTwdiwYh7rmm64pFwNBNtO5RFnYZp1YLtQ+Ju91oMPbqKJiZvy1
         XLZDbRler/4JcXiiDCjvfELaMlEftbeNBWtDCvzj4Ii5sHaIY4LF2eGiYN16IsBCT5ns
         5S+Q==
X-Gm-Message-State: AOAM5307/tax19pCP818Igp1jg83NxWR+98y4F+bA5P5SfWVlavCeE5w
        LoyaLZLBiJDO+Fk6W8PN1sIX+GtVoU+vBAPNNvg=
X-Google-Smtp-Source: ABdhPJx1wnQ1ZQpHq0OItZUQKwpo3b8QhPnoEjQKYnuQ6/G99aCVt9MepJ6M68+nNTt/XmRXRVPz0g1EKvCxq0D0Qxs=
X-Received: by 2002:a67:7d02:: with SMTP id y2mr13064613vsc.18.1618766720979;
 Sun, 18 Apr 2021 10:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAGgoGu77PEEAJped5bnw4q8rFeDMebL92YWGDGFfNp_ZAnpJ8Q@mail.gmail.com>
 <YGFeQUuAaKgeaqCA@kroah.com> <CAGgoGu76FOJd74oVgnu5Sa3GKaHHyLTH+=hP+mLGzS+79Z26fA@mail.gmail.com>
 <CAK8P3a24aFvCUeZiDE6jCTKm0hrPVc34sNYOPpZJkh_5HpgDSw@mail.gmail.com>
 <CAGgoGu5xT6sADCpj7J7tJMfsw1WU4BA=3YB8SGS-+kf+P4xyNw@mail.gmail.com> <YGMqVc+DyVyT9DtW@kroah.com>
In-Reply-To: <YGMqVc+DyVyT9DtW@kroah.com>
From:   Fawad Lateef <fawadlateef@gmail.com>
Date:   Sun, 18 Apr 2021 19:25:08 +0200
Message-ID: <CAGgoGu4EzSKE68pva74Pdhdf+ssZddhFLzFTOFxMKiJOBaW8aw@mail.gmail.com>
Subject: Re: Compiling kernel-3.4.xxx with gcc-9.x. Need some help.
To:     Greg KH <greg@kroah.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

(Sending again as seems like I had rich-text available by mistake, so
likely my message is rejected)


On Tue, 30 Mar 2021 at 15:40, Greg KH <greg@kroah.com> wrote:
>
> On Tue, Mar 30, 2021 at 03:23:10PM +0200, Fawad Lateef wrote:
> > So can I still use kernel-3.4 compiled with gcc-5.5, and boot full
> > user-space with gcc-9.1?
>
> Yes, of course.
>
> > I was expecting it to be possible but might not work due to
> > incompatibility? As I know that when I tried to compile buildroot-2019
> > (with latest version of openssl and others) it needs kernel headers
> > and then I likely can't use 3.4 kernel.
>
> buildroot might be different, as that is how you are building your whole
> system, but there is no dependency on the kernel and userspace to use
> the same version of the compiler.  Otherwise everyone would have to
> rebuild the world for every time they updated their kernel, this isn't
> the BSDs :)
>

I tried booting the userspace compiled with gcc-9.1 and kernel
compiled with gcc-5.5. But seems like the kernel 3.4.111 is not
compatible with user-space compiled with gcc-9.1.
During boot getting error: "FATAL: kernel too old." (from init I
believe) and then kernel Panics. Log (part) below:

------
[   26.242878] registered taskstats version 1
[   26.247522] axp20_buck3: incomplete constraints, leaving on
[   26.253314] axp20_buck2: incomplete constraints, leaving on
[   26.259161] axp20_ldo4: incomplete constraints, leaving on
[   26.264877] axp20_ldo3: incomplete constraints, leaving on
[   26.270581] axp20_ldo2: incomplete constraints, leaving on
[   26.276299] axp20_ldo1: incomplete constraints, leaving on
[   26.282059] sunxi-rtc sunxi-rtc: setting system clock to 2010-01-01
00:00:00 UTC (1262304000)
[   26.291136] Freeing init memory: 160K
FATAL: kernel too old
[   26.308118] usb 3-1.1: New USB device found, idVendor=148f, idProduct=5572
[   26.315022] usb 3-1.1: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[   26.322322] usb 3-1.1: Product: 802.11 n WLAN
[   26.326730] usb 3-1.1: Manufacturer: Ralink
[   26.330908] usb 3-1.1: SerialNumber: 1.0
[   26.335055] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x00007f00
[   26.335061]
[   26.344221] [<c0011285>] (unwind_backtrace+0x1/0x90) from
[<c02bdc4f>] (panic+0x6f/0x15c)
[   26.352400] [<c02bdc4f>] (panic+0x6f/0x15c) from [<c0031fc7>]
(do_exit+0x5ff/0x600)
[   26.360057] [<c0031fc7>] (do_exit+0x5ff/0x600) from [<c0032009>]
(do_group_exit+0x25/0x78)
[   26.368318] [<c0032009>] (do_group_exit+0x25/0x78) from
[<c0032069>] (__wake_up_parent+0x1/0x18)
[   26.377101] [<c0032069>] (__wake_up_parent+0x1/0x18) from
[<c000ca81>] (ret_fast_syscall+0x1/0x44)
[   26.386064] CPU1: stopping
[   26.388781] [<c0011285>] (unwind_backtrace+0x1/0x90) from
[<c0010707>] (handle_IPI+0x157/0x170)
[   26.397477] [<c0010707>] (handle_IPI+0x157/0x170) from [<c0008393>]
(gic_handle_irq+0x3f/0x40)
[   26.406085] [<c0008393>] (gic_handle_irq+0x3f/0x40) from
[<c000c65b>] (__irq_svc+0x3b/0x5c)
[   26.414427] Exception stack(0xef065f88 to 0xef065fd0)
[   26.419476] 5f80:                   ffffffed 00000001 1037d000
00000000 ef064000 c04d3c08
[   26.427648] 5fa0: ef064000 ef064000 c04a9a10 ef064018 00000000
00000000 3b9aca00 ef065fd0
[   26.435817] 5fc0: c000d469 c000d46a 60000033 ffffffff
[   26.440870] [<c000c65b>] (__irq_svc+0x3b/0x5c) from [<c000d46a>]
(default_idle+0x1a/0x1c)
[   26.449048] [<c000d46a>] (default_idle+0x1a/0x1c) from [<c000d6c1>]
(cpu_idle+0x91/0x98)
[   26.457135] [<c000d6c1>] (cpu_idle+0x91/0x98) from [<40480bd9>] (0x40480bd9)
[   26.464181] Rebooting in 10 seconds..
[   36.444472] Restarting Linux version 3.4.113
(flateef@flateef-XPS-13-9360) (gcc version 5.5.0 (Buildroot
2016.02-00152-g83a8d925e-dirty) ) #1 SMP Wed Mar 24 00:29:58 CET 2021
[   36.444482]

-----------------------------------------------------

Can I do something to make them work together?

Thanks

Fawad Lateef

> thanks,
>
> greg k-h
