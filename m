Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B96034E8EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhC3NXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbhC3NXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:23:24 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A93C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 06:23:23 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id q18so5009080uas.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 06:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnRPvrLCFh9Rb5V7QOjNedJzmRFaTUrJgJXfMYyI5Ko=;
        b=E/C1YMyhQ5bGfLGjoTtO9P3h+LjgtbU1N51MgwaBx8X4/FRUH6BxTN7PhGdGy/Ljex
         0lcXkZFzYcWCDebWfawSA8L3O+0SuUDwUr9jO1p1CAjTHiac0ZOwFpDzdpR6O86b8iYY
         YsRogn+2yksvtjQX12V3f+PuKznSamEiBpHFHzbLWYBW4fGePtAtNr3CQ2LfeIWuQChj
         f4DQk6GVUJ0FDJ3QwLxTvFAEkyztz66YuZ9KM2ZUlikl2wBQy2Si2v4WuoVh19d070xg
         yq0dEdVe4Wz4hOtGCFSFINTr3MJs1OHol+m6ASqCA5RDvWzH/z0S1rPhWsrbTdar8XM3
         EZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnRPvrLCFh9Rb5V7QOjNedJzmRFaTUrJgJXfMYyI5Ko=;
        b=aaEy/Ea5bOv9tMKVoP6AdE9QC7yk4xWPY7CL3Ocs0VwnMYyAA9u4gZT/ttjJkDulHK
         63NlrGmuCPsor9K1KnAxh7CIxQGi+MosFI6OOssEJwxRxUB8KEb7Gny/QtI0wHIUCml1
         EAfYQyqaZZGukDChdIcNfFUG+tCbn31EVA3gCEO67qwqpNYfs+/X2odd5qKFMQC49TbP
         du9wBIG43k1wuJmYUG2iUTINvFpKsyl2hSXoAHuFujfUSDARDVvB2DgPfm2iJdVl5ywu
         y1wC+STBLGBa3KEpOPLH2xYUIak+9upMQ0cvcsaSg4saMUboeR1xpkt5fQY9BkRG624H
         8wrg==
X-Gm-Message-State: AOAM533FPwwOamCxTOMzMAylKjZKwWfV0SQYc67C6Uomp5L3dOSIKiFt
        kWGZkl5iRPgfHkO+s2oWMAfbKQB7Ap9xZm+fgWA=
X-Google-Smtp-Source: ABdhPJwnwS1Lq8gZtQKsdgDXFU4spd7UomuUbTHxDeul2pvsdmEOPdT5gTQNlPKNunGP1rB+Lb8hhADyqEdDoXgEIq8=
X-Received: by 2002:ab0:7406:: with SMTP id r6mr16750423uap.28.1617110602595;
 Tue, 30 Mar 2021 06:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAGgoGu77PEEAJped5bnw4q8rFeDMebL92YWGDGFfNp_ZAnpJ8Q@mail.gmail.com>
 <YGFeQUuAaKgeaqCA@kroah.com> <CAGgoGu76FOJd74oVgnu5Sa3GKaHHyLTH+=hP+mLGzS+79Z26fA@mail.gmail.com>
 <CAK8P3a24aFvCUeZiDE6jCTKm0hrPVc34sNYOPpZJkh_5HpgDSw@mail.gmail.com>
In-Reply-To: <CAK8P3a24aFvCUeZiDE6jCTKm0hrPVc34sNYOPpZJkh_5HpgDSw@mail.gmail.com>
From:   Fawad Lateef <fawadlateef@gmail.com>
Date:   Tue, 30 Mar 2021 15:23:10 +0200
Message-ID: <CAGgoGu5xT6sADCpj7J7tJMfsw1WU4BA=3YB8SGS-+kf+P4xyNw@mail.gmail.com>
Subject: Re: Compiling kernel-3.4.xxx with gcc-9.x. Need some help.
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Greg KH <greg@kroah.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,


On Mon, 29 Mar 2021 at 22:06, Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Mar 29, 2021 at 9:23 PM Fawad Lateef <fawadlateef@gmail.com> wrote:
> >
> > On Mon, 29 Mar 2021 at 06:57, Greg KH <greg@kroah.com> wrote:
> > >
> > > On Sun, Mar 28, 2021 at 10:20:50PM +0200, Fawad Lateef wrote:
> > > > Hi
> > > >
> > > > I am using an Olimex A20 SOM with NAND and due to some binary blob for
> > > > NAND driver, I am stuck with the sunxi kernel 3.4.xxx version. (Repo
> > > > here: https://github.com/linux-sunxi/linux-sunxi)
> > >
> > > Please work with the vendor that is forcing you to use this obsolete and
> > > insecure kernel version.  You are paying for that support, and they are
> > > the only ones that can support you.
> > >
> >
> > The problem is vendor Olimex now have eMMC based SOM which is
> > supported by mainline kernel _but_ they still selling NAND SOM and
> > only supporting 3.4 kernel (as this is the only latest version from
> > sunxi with NAND support, after that sunxi is now moved away from NAND
> > too).
>
> From a very quick look at the git history, I can tell that A20 NAND driver
> support was added in linux-4.8. Have you actually tried a modern kernel?
>

I tried compiling and booting kernel v4.4 (from sunxi repo on github)
but unable to make it boot. Stuck at "Starting kernel". By the way I
am booting from RAM (using the sunxi usbboot/usb-otg option).

You mentioned that it's supported from linux-4.8 (from your quick look
at git history); can you tell me which driver/files? As I was able to
see some sort of sunxi NAND driver even in v4.4 kernel
(https://lxr.missinglinkelectronics.com/linux+v4.4/drivers/mtd/nand/sunxi_nand.c).

When I tried to compare with the sunxi-3.4 kernel code, I found that
the kernel has code for "nfc" but no reference to "nfd" (I don't know
what they are referring to).
The sunxi 3.4 kernel NAND driver at quick look seems quite different.
(https://github.com/linux-sunxi/linux-sunxi/tree/sunxi-3.4/drivers/block/sunxi_nand)

I will try the v4.8 or above kernel.


> There is also a howto document at
> https://linux-sunxi.org/Mainline_NAND_Howto
>

I somehow missed this earlier :(  And the prerequisite says kernel
4.10 above and some extra patch set). Will look into it too. Thanks
for the link

> The olimex board specific dts files seem to be missing the entry for
> the nand controller. If you have trouble figuring out how to enable that
> from the howto above, Olimex should be able to prove a small patch
> for it.
>

Will see. As above link have some details regarding this which might be helpful.

> > > > I am currently using buildroot-2016 and gcc-5.5 for building the
> > > > kernel and every other package needed.
> > > >
> > > > Now the requirement is to move to the latest version of gcc-9.x, so
> > > > that we can have glibc++ provided by the gcc-9.1 toolchain.
> > > >
> > > > Main problem for moving to later versions of buildroot is the kernel
> > > > 3.4 which we couldn't to work with gcc-6 a few years ago _but_ now the
> > > > gcc-9.1 requirement is mandatory so now have to look into compiling
> > > > linux-3.4 with gcc-9.1 or above.
>
> There is no need to compile user space and kernel with the same compiler.
>

So can I still use kernel-3.4 compiled with gcc-5.5, and boot full
user-space with gcc-9.1?
I was expecting it to be possible but might not work due to
incompatibility? As I know that when I tried to compile buildroot-2019
(with latest version of openssl and others) it needs kernel headers
and then I likely can't use 3.4 kernel.

I will still give it a try. Thanks again

>         Arnd
