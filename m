Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA6C34D8D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 22:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhC2UGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 16:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231772AbhC2UGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 16:06:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08E8A61981
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 20:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617048375;
        bh=lgDPeJMqjCmjbhaBvOeuRieB3PN5e/TDtj8+5tp48vo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uwi1QCJzG4Vp4YCRSv5W7XFGZLTpg6chpLx0soD1jzQmtYDTYxHw3cvN54ZTpi97R
         3XGWIbmgjRkvr8lvBF0ukwg5PPM1Ma9LboN0+/3OrIK+UZUzroAqJy/gNb1XItTr46
         U/aL0qcNLApt5GXZ672Qa72o9k9uAzGnCdVDUgXRSj7w8xmsRAePk4SRPJXFFGTW4A
         f5QRCcKqU5pepjD5irWP3kSoNv1Lwk9CYKzFoou2/aFgTHtarx0uagKPJndaEL8zhR
         kc2m//+bBYSaz2LYDeKLZRJe0dg2I/+eLS77mTeGyPNgja0yot1nU0++ETaeKi1CEy
         Xvb5AxIYnKY9A==
Received: by mail-oo1-f54.google.com with SMTP id x187-20020a4a41c40000b02901b664cf3220so3243620ooa.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 13:06:15 -0700 (PDT)
X-Gm-Message-State: AOAM530XRjmtv4KDnsbIAHaZv0DiN6yPO8tKPwstQ0Brd27snSSGoYRk
        mFyrhEV3o/45DWbGmVKyS9BwDW6aO7mqWnwW4WA=
X-Google-Smtp-Source: ABdhPJyQvabMoKjf8AEqY6tMhe2VJ3yx2jyDzz56QCFu1dRyBpkiE4j33XCtV/PH3UwLaLjHzgjbx3o4aO2aFW3BV+A=
X-Received: by 2002:a4a:e9a2:: with SMTP id t2mr22518548ood.15.1617048374402;
 Mon, 29 Mar 2021 13:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAGgoGu77PEEAJped5bnw4q8rFeDMebL92YWGDGFfNp_ZAnpJ8Q@mail.gmail.com>
 <YGFeQUuAaKgeaqCA@kroah.com> <CAGgoGu76FOJd74oVgnu5Sa3GKaHHyLTH+=hP+mLGzS+79Z26fA@mail.gmail.com>
In-Reply-To: <CAGgoGu76FOJd74oVgnu5Sa3GKaHHyLTH+=hP+mLGzS+79Z26fA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 29 Mar 2021 22:06:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a24aFvCUeZiDE6jCTKm0hrPVc34sNYOPpZJkh_5HpgDSw@mail.gmail.com>
Message-ID: <CAK8P3a24aFvCUeZiDE6jCTKm0hrPVc34sNYOPpZJkh_5HpgDSw@mail.gmail.com>
Subject: Re: Compiling kernel-3.4.xxx with gcc-9.x. Need some help.
To:     Fawad Lateef <fawadlateef@gmail.com>
Cc:     Greg KH <greg@kroah.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 9:23 PM Fawad Lateef <fawadlateef@gmail.com> wrote:
>
> On Mon, 29 Mar 2021 at 06:57, Greg KH <greg@kroah.com> wrote:
> >
> > On Sun, Mar 28, 2021 at 10:20:50PM +0200, Fawad Lateef wrote:
> > > Hi
> > >
> > > I am using an Olimex A20 SOM with NAND and due to some binary blob for
> > > NAND driver, I am stuck with the sunxi kernel 3.4.xxx version. (Repo
> > > here: https://github.com/linux-sunxi/linux-sunxi)
> >
> > Please work with the vendor that is forcing you to use this obsolete and
> > insecure kernel version.  You are paying for that support, and they are
> > the only ones that can support you.
> >
>
> The problem is vendor Olimex now have eMMC based SOM which is
> supported by mainline kernel _but_ they still selling NAND SOM and
> only supporting 3.4 kernel (as this is the only latest version from
> sunxi with NAND support, after that sunxi is now moved away from NAND
> too).

From a very quick look at the git history, I can tell that A20 NAND driver
support was added in linux-4.8. Have you actually tried a modern kernel?

There is also a howto document at
https://linux-sunxi.org/Mainline_NAND_Howto

The olimex board specific dts files seem to be missing the entry for
the nand controller. If you have trouble figuring out how to enable that
from the howto above, Olimex should be able to prove a small patch
for it.

> > > I am currently using buildroot-2016 and gcc-5.5 for building the
> > > kernel and every other package needed.
> > >
> > > Now the requirement is to move to the latest version of gcc-9.x, so
> > > that we can have glibc++ provided by the gcc-9.1 toolchain.
> > >
> > > Main problem for moving to later versions of buildroot is the kernel
> > > 3.4 which we couldn't to work with gcc-6 a few years ago _but_ now the
> > > gcc-9.1 requirement is mandatory so now have to look into compiling
> > > linux-3.4 with gcc-9.1 or above.

There is no need to compile user space and kernel with the same compiler.

        Arnd
