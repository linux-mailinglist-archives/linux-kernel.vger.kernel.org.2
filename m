Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC99043B0A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbhJZK6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235288AbhJZK6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:58:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0382B61057
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635245782;
        bh=bHEangHscPHEDpQmdZ382qrx5zo6GEWR0uEpI3hNTX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pyHubQDHDEQzntrtaQe3b1Y0xwYV7HAqPS0sJb794Ts1M/hueN30v3GgWrw3ikaME
         EzL3XjycnJthE7OQgJUeX98RU6c9v4TbL80Emfae9i8GxcMwrHu8Usi64LFibYR7JE
         c7A/tMjA24pPP0oZPHyINn5eAgkakbw41jPnHcUknog0zd8nUWCFkG2rbs3WuTjDXs
         zD95SQ7fif89vBYVzTwuxDEGKN6RC2OQhkjlwUgKYWIhy2xrc4KinaRoHBo6IIJfh7
         7t3a8NAr0+FJs0RcRmlkuhaEZXNFHR2wK0GNOIg/HAagnfm4aLEs7h/98tigrcA2jD
         aPCNEt1kQXDXw==
Received: by mail-ot1-f47.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so19247812ott.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 03:56:21 -0700 (PDT)
X-Gm-Message-State: AOAM531bY47AGBnHyu2bPQe6Vwe1ScCYrP+Rqvtw2kOXZQ1BeFEWxBCv
        Co2nFpDtN9QUavptjglndPMC0ntEVz2+BFJtvv8=
X-Google-Smtp-Source: ABdhPJzh7yapKBzSGgUZc3gpTT1GqXPADJZRcTC6IWoT/JNuWVX/lpkcyh39Rzb6lf6b/jjsvJLhPdH0LxUgTSePS+g=
X-Received: by 2002:a9d:5911:: with SMTP id t17mr18903898oth.30.1635245781230;
 Tue, 26 Oct 2021 03:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211020054942.1608637-1-quanyang.wang@windriver.com>
 <CACRpkdYxMDp4FRGP=EOt8oTMxs_YuskbvMx5wXBDjUWz6hD=gQ@mail.gmail.com>
 <YXfDdmrCynZk/QW8@shell.armlinux.org.uk> <cddc3cd6-a36d-e02f-4cd8-26ff15e72d13@windriver.com>
 <CAMj1kXEyc0S6A_OQRQOTtTFxev=Kj55Zhn2dRDaZ6FP+Ek=17w@mail.gmail.com>
 <8905597e-49a9-c898-c78d-3d2f51180133@windriver.com> <YXfegIP+Xamfcnfp@shell.armlinux.org.uk>
In-Reply-To: <YXfegIP+Xamfcnfp@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 26 Oct 2021 12:56:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH+PZsSkCQSxWck-AuqkmRxyKy=4i5Xst8J+dqy_G92uQ@mail.gmail.com>
Message-ID: <CAMj1kXH+PZsSkCQSxWck-AuqkmRxyKy=4i5Xst8J+dqy_G92uQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: add BUILD_BUG_ON to check if fixmap range spans
 multiple pmds
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Quanyang Wang <quanyang.wang@windriver.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 at 12:55, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Oct 26, 2021 at 06:38:16PM +0800, Quanyang Wang wrote:
> > Hi Ard,
> >
> > On 10/26/21 6:12 PM, Ard Biesheuvel wrote:
> > > On Tue, 26 Oct 2021 at 11:53, Quanyang Wang <quanyang.wang@windriver.com> wrote:
> > > >
> > > > Hi,
> > > > Sorry for the inconvenience.
> > > >
> > > > On 10/26/21 4:59 PM, Russell King (Oracle) wrote:
> > > > > On Sun, Oct 24, 2021 at 11:44:31PM +0200, Linus Walleij wrote:
> > > > > > On Wed, Oct 20, 2021 at 7:50 AM <quanyang.wang@windriver.com> wrote:
> > > > > >
> > > > > > > From: Quanyang Wang <quanyang.wang@windriver.com>
> > > > > > >
> > > > > > > Not only the early fixmap range, but also the fixmap range should be
> > > > > > > checked if it spans multiple pmds. When enabling CONFIG_DEBUG_HIGHMEM,
> > > > > > > some systems which contain up to 16 CPUs will crash.
> > > > > > >
> > > > > > > Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> > > > > >
> > > > > > Looks reasonable to me.
> > > > > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > > > >
> > > > > > Please submit this patch into Russell's patch tracker.
> > > > >
> > > > > ... and has totally broken what looks like _all_ ARM kernel builds.
> > > > This patch is intended to trigger build error when it check the value of
> > > > __end_of_fixmap_region is equal or larger than 256.
> > >
> > > Why? The fixmap region is larger than one PMD, so why do we need to cap it?
> > In __kmap_local_pfn_prot, arch_kmap_local_set_pte(&init_mm, vaddr, kmap_pte
> > - idx, pteval) is used to set pteval.
> > But the ptep is calculated by "kmap_pte - idx", which means all ptes must be
> > placed next to each other and no gaps. But for ARM, the ptes for the range
> > "0xffe00000~0xfff00000" is not next to the ptes for the range
> > "0xffc80000~0xffdfffff".
> >
> > When the idx is larger than 256, virtual address is in 0xffdxxxxx, access
> > this address will crash since its pteval isn't set correctly.
>
> Thanks for the explanation.
>
> Sadly, this does seem to be correct. Even if the PTE tables are
> located next to each other in memory, they _still_ won't be a
> contiguous array of entries due to being interleaved with the Linux
> PTE table and the hardware PTE table.
>
> Since the address range 0xffe00000-0xfff00000 is already half of one
> PTE table containing 512 contiguous entries, we are limited to 256
> fixmap PTEs maximum. If we have more than that we will start trampling
> over memory below the PTE table _and_ we will start corrupting Linux
> PTE entries in the 0xfff00000-0xffffffff range.
>
> I suspect this hasn't been seen because of a general lack of ARM
> systems with more than 4 CPUs.
>

But doesn't that make it a kmap_local regression? Or do you think this
issue existed before that as well?
