Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B85743B08F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbhJZK53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhJZK52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:57:28 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDE6C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 03:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BgAzzl6wRqxUxzR+IGdueyRkHJqVdMrKxqLgk3s7/Nk=; b=zUwYgeHSs3+mVr3lx1lL3YyPko
        OT9n0I9lxvCPg3zq9XyRSG41pqEYZ5bv1L9QBCUbegw0iMyjnCgFv6PgJXHk1ThkKy6KUD093mKnR
        2fBAp9WaipMXhKVEYfrgokR2goJKaa45EYGKSW5T4ph8pdefRUts0D7QctufIHAy7rxQdIZrQTjkI
        +8c9c4bNlT7JInm9LkY2M3bxNTY0IZhY9Q/GkLwJaCSbeG12pAclzFUZvjL0MvYCEKMNh5p7hIN8b
        h5hy4D2859lQP61E8Fzw7/UcV7Qm4Wysk/sS7lvdYCa8znDp+FyvHvCMbfKWsKcZXCmlY5iDR+x+p
        +bcQfTpg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55310)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mfK6c-0005HY-A6; Tue, 26 Oct 2021 11:54:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mfK6a-0006h0-Su; Tue, 26 Oct 2021 11:54:56 +0100
Date:   Tue, 26 Oct 2021 11:54:56 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Quanyang Wang <quanyang.wang@windriver.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: add BUILD_BUG_ON to check if fixmap range spans
 multiple pmds
Message-ID: <YXfegIP+Xamfcnfp@shell.armlinux.org.uk>
References: <20211020054942.1608637-1-quanyang.wang@windriver.com>
 <CACRpkdYxMDp4FRGP=EOt8oTMxs_YuskbvMx5wXBDjUWz6hD=gQ@mail.gmail.com>
 <YXfDdmrCynZk/QW8@shell.armlinux.org.uk>
 <cddc3cd6-a36d-e02f-4cd8-26ff15e72d13@windriver.com>
 <CAMj1kXEyc0S6A_OQRQOTtTFxev=Kj55Zhn2dRDaZ6FP+Ek=17w@mail.gmail.com>
 <8905597e-49a9-c898-c78d-3d2f51180133@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8905597e-49a9-c898-c78d-3d2f51180133@windriver.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 06:38:16PM +0800, Quanyang Wang wrote:
> Hi Ard,
> 
> On 10/26/21 6:12 PM, Ard Biesheuvel wrote:
> > On Tue, 26 Oct 2021 at 11:53, Quanyang Wang <quanyang.wang@windriver.com> wrote:
> > > 
> > > Hi,
> > > Sorry for the inconvenience.
> > > 
> > > On 10/26/21 4:59 PM, Russell King (Oracle) wrote:
> > > > On Sun, Oct 24, 2021 at 11:44:31PM +0200, Linus Walleij wrote:
> > > > > On Wed, Oct 20, 2021 at 7:50 AM <quanyang.wang@windriver.com> wrote:
> > > > > 
> > > > > > From: Quanyang Wang <quanyang.wang@windriver.com>
> > > > > > 
> > > > > > Not only the early fixmap range, but also the fixmap range should be
> > > > > > checked if it spans multiple pmds. When enabling CONFIG_DEBUG_HIGHMEM,
> > > > > > some systems which contain up to 16 CPUs will crash.
> > > > > > 
> > > > > > Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> > > > > 
> > > > > Looks reasonable to me.
> > > > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > > > 
> > > > > Please submit this patch into Russell's patch tracker.
> > > > 
> > > > ... and has totally broken what looks like _all_ ARM kernel builds.
> > > This patch is intended to trigger build error when it check the value of
> > > __end_of_fixmap_region is equal or larger than 256.
> > 
> > Why? The fixmap region is larger than one PMD, so why do we need to cap it?
> In __kmap_local_pfn_prot, arch_kmap_local_set_pte(&init_mm, vaddr, kmap_pte
> - idx, pteval) is used to set pteval.
> But the ptep is calculated by "kmap_pte - idx", which means all ptes must be
> placed next to each other and no gaps. But for ARM, the ptes for the range
> "0xffe00000~0xfff00000" is not next to the ptes for the range
> "0xffc80000~0xffdfffff".
> 
> When the idx is larger than 256, virtual address is in 0xffdxxxxx, access
> this address will crash since its pteval isn't set correctly.

Thanks for the explanation.

Sadly, this does seem to be correct. Even if the PTE tables are
located next to each other in memory, they _still_ won't be a
contiguous array of entries due to being interleaved with the Linux
PTE table and the hardware PTE table.

Since the address range 0xffe00000-0xfff00000 is already half of one
PTE table containing 512 contiguous entries, we are limited to 256
fixmap PTEs maximum. If we have more than that we will start trampling
over memory below the PTE table _and_ we will start corrupting Linux
PTE entries in the 0xfff00000-0xffffffff range.

I suspect this hasn't been seen because of a general lack of ARM
systems with more than 4 CPUs.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
