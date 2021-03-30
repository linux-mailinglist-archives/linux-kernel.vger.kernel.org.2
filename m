Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D4B34EA51
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhC3OXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:23:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232004AbhC3OWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:22:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7E47619CB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 14:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617114155;
        bh=9SKmTqEFK1r5v1fz1CKjaNtXuwV6YyJw5e+rK8/Jr0M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M/uY+p862pkpbMcuBBRFozn9LPxozcKN07+wu1XlwKSzLchymmhxy96mC8I1Ct6iI
         3Hur5fYcTC/oNDWmRB35r4n/EriZyn5hGdYvU/4425iS+O0SZZ3ivMwLbNh0P2obB9
         m0eeH6y0RBLRQMF0pycPOLVH/ZMjOPrNMK3R54EY3K6+aG03YlV+llBEYUEPE6sK5Y
         RIxrhl2ppGp2GTldnEOlAmF6tN3Q6o4crBi9b7+mKflyfDO5xTjqzG95cjr6yt6xhz
         y+79AyYC3k/gbLahNvuEPatxtdQzVV84qGDJwEsQOOyhfxAKFG6wYYc6+lNxd4c+Lt
         DA1mJ5kyQF1Jg==
Received: by mail-ot1-f46.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so15694667otn.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 07:22:34 -0700 (PDT)
X-Gm-Message-State: AOAM530W5SKeb5ppiXhJmAiWw5EGxFvlxBzs1MRpBxzmvM/TnEBxVw1h
        bhC9y9cTDAOSzssXCdYly/RE25yvRTwS1FfUVrc=
X-Google-Smtp-Source: ABdhPJwv3cYOFY2XLUAktSyu5Dldv3DbingZUxFzpVeQpQLJehDALUA6VOeyeu9u9k76TgIB3y0ABQxaMoWECJchzB8=
X-Received: by 2002:a9d:758b:: with SMTP id s11mr4011779otk.305.1617114154260;
 Tue, 30 Mar 2021 07:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAGgoGu77PEEAJped5bnw4q8rFeDMebL92YWGDGFfNp_ZAnpJ8Q@mail.gmail.com>
 <YGFeQUuAaKgeaqCA@kroah.com> <CAGgoGu76FOJd74oVgnu5Sa3GKaHHyLTH+=hP+mLGzS+79Z26fA@mail.gmail.com>
 <CAK8P3a24aFvCUeZiDE6jCTKm0hrPVc34sNYOPpZJkh_5HpgDSw@mail.gmail.com> <CAGgoGu5xT6sADCpj7J7tJMfsw1WU4BA=3YB8SGS-+kf+P4xyNw@mail.gmail.com>
In-Reply-To: <CAGgoGu5xT6sADCpj7J7tJMfsw1WU4BA=3YB8SGS-+kf+P4xyNw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 30 Mar 2021 16:22:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0HMx9K8igSfWgsUztFkSyvWLf5xdGBxNf8-ufGr7UkSQ@mail.gmail.com>
Message-ID: <CAK8P3a0HMx9K8igSfWgsUztFkSyvWLf5xdGBxNf8-ufGr7UkSQ@mail.gmail.com>
Subject: Re: Compiling kernel-3.4.xxx with gcc-9.x. Need some help.
To:     Fawad Lateef <fawadlateef@gmail.com>
Cc:     Greg KH <greg@kroah.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 3:23 PM Fawad Lateef <fawadlateef@gmail.com> wrote:
> On Mon, 29 Mar 2021 at 22:06, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Mon, Mar 29, 2021 at 9:23 PM Fawad Lateef <fawadlateef@gmail.com> wrote:
> > >
> > > On Mon, 29 Mar 2021 at 06:57, Greg KH <greg@kroah.com> wrote:
> > > >
> > > > On Sun, Mar 28, 2021 at 10:20:50PM +0200, Fawad Lateef wrote:
> > > > > Hi
> > > > >
> > > > > I am using an Olimex A20 SOM with NAND and due to some binary blob for
> > > > > NAND driver, I am stuck with the sunxi kernel 3.4.xxx version. (Repo
> > > > > here: https://github.com/linux-sunxi/linux-sunxi)
> > > >
> > > > Please work with the vendor that is forcing you to use this obsolete and
> > > > insecure kernel version.  You are paying for that support, and they are
> > > > the only ones that can support you.
> > > >
> > >
> > > The problem is vendor Olimex now have eMMC based SOM which is
> > > supported by mainline kernel _but_ they still selling NAND SOM and
> > > only supporting 3.4 kernel (as this is the only latest version from
> > > sunxi with NAND support, after that sunxi is now moved away from NAND
> > > too).
> >
> > From a very quick look at the git history, I can tell that A20 NAND driver
> > support was added in linux-4.8. Have you actually tried a modern kernel?
> >
>
> I tried compiling and booting kernel v4.4 (from sunxi repo on github)
> but unable to make it boot. Stuck at "Starting kernel". By the way I
> am booting from RAM (using the sunxi usbboot/usb-otg option).
>
> You mentioned that it's supported from linux-4.8 (from your quick look
> at git history); can you tell me which driver/files? As I was able to
> see some sort of sunxi NAND driver even in v4.4 kernel
> (https://lxr.missinglinkelectronics.com/linux+v4.4/drivers/mtd/nand/sunxi_nand.c).

The nand flash controller node for a20 was added in commit
b2a83ad217b8 ("ARM: dts: sun7i: Add NFC node to Allwinner A20 SoC")
The driver was merged first but not hooked up in the dt.
For the specific board file, you need to still need to either enable the
device and add a partition map in the dts (as described in the howto),
or have a boot loader that fills out that information.

> When I tried to compare with the sunxi-3.4 kernel code, I found that
> the kernel has code for "nfc" but no reference to "nfd" (I don't know
> what they are referring to).
> The sunxi 3.4 kernel NAND driver at quick look seems quite different.
> (https://github.com/linux-sunxi/linux-sunxi/tree/sunxi-3.4/drivers/block/sunxi_nand)
>
> I will try the v4.8 or above kernel.

I think the custom nand driver in that tree was trying to avoid the
patents for nand flash by using an independently developed implementation,
but that of course leads to copyright issues with incompatible licenses.

The new driver is a regular mtd driver. I don't know whether the layout
of the data is compatible at all, so it's possible that you have to backup
all the data using the old kernel and write back the file system using a
new kernel.

       Arnd
