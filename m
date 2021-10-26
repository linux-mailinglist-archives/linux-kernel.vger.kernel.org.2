Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8260643B0DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 13:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhJZLSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 07:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbhJZLSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 07:18:31 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625E9C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 04:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hW7xCt9vLH+8oGE8/i400C7AGzNwYQKEsJAnK9bLLTA=; b=1h0UuoHsLYWoa7/9uWDWBK2Ruu
        V3F0LqILns94O4FzgMygAibQDVxOUgKbpMzPn0UaCtF46IqAbpClgNIj6lRolQRH8Uw3pqagCSmt2
        mWdH6CfqOpMhX5EFolJ1NY735MyFFh3i1/HWl0CEgqaBPUdX3kv+5qtKKnTjI6bW0BMcwJCJuvcoC
        Gzc4XPxSocIRwQ9owPtQSMjpYDM0CZ3zzRRDtj1rk+8v5LMk69qRN1maKCgWNqu4J53ar5Fnf30S6
        y+wNNtzqyUQA0/ikndG0lXNPQ75eSAUgKCFxc7PjrjtpRw7bJNku1WFS8vtyWmWQ96vP+XQoEfq5m
        Iu1TJ3dQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55312)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mfKQz-0005JA-8J; Tue, 26 Oct 2021 12:16:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mfKQw-0006i2-MV; Tue, 26 Oct 2021 12:15:58 +0100
Date:   Tue, 26 Oct 2021 12:15:58 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Quanyang Wang <quanyang.wang@windriver.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: add BUILD_BUG_ON to check if fixmap range spans
 multiple pmds
Message-ID: <YXfjbteoVlZLFerq@shell.armlinux.org.uk>
References: <20211020054942.1608637-1-quanyang.wang@windriver.com>
 <CACRpkdYxMDp4FRGP=EOt8oTMxs_YuskbvMx5wXBDjUWz6hD=gQ@mail.gmail.com>
 <YXfDdmrCynZk/QW8@shell.armlinux.org.uk>
 <cddc3cd6-a36d-e02f-4cd8-26ff15e72d13@windriver.com>
 <CAMj1kXEyc0S6A_OQRQOTtTFxev=Kj55Zhn2dRDaZ6FP+Ek=17w@mail.gmail.com>
 <8905597e-49a9-c898-c78d-3d2f51180133@windriver.com>
 <YXfegIP+Xamfcnfp@shell.armlinux.org.uk>
 <CAMj1kXH+PZsSkCQSxWck-AuqkmRxyKy=4i5Xst8J+dqy_G92uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH+PZsSkCQSxWck-AuqkmRxyKy=4i5Xst8J+dqy_G92uQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 12:56:08PM +0200, Ard Biesheuvel wrote:
> On Tue, 26 Oct 2021 at 12:55, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Oct 26, 2021 at 06:38:16PM +0800, Quanyang Wang wrote:
> > > Hi Ard,
> > >
> > > On 10/26/21 6:12 PM, Ard Biesheuvel wrote:
> > > > On Tue, 26 Oct 2021 at 11:53, Quanyang Wang <quanyang.wang@windriver.com> wrote:
> > > > >
> > > > > Hi,
> > > > > Sorry for the inconvenience.
> > > > >
> > > > > On 10/26/21 4:59 PM, Russell King (Oracle) wrote:
> > > > > > On Sun, Oct 24, 2021 at 11:44:31PM +0200, Linus Walleij wrote:
> > > > > > > On Wed, Oct 20, 2021 at 7:50 AM <quanyang.wang@windriver.com> wrote:
> > > > > > >
> > > > > > > > From: Quanyang Wang <quanyang.wang@windriver.com>
> > > > > > > >
> > > > > > > > Not only the early fixmap range, but also the fixmap range should be
> > > > > > > > checked if it spans multiple pmds. When enabling CONFIG_DEBUG_HIGHMEM,
> > > > > > > > some systems which contain up to 16 CPUs will crash.
> > > > > > > >
> > > > > > > > Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> > > > > > >
> > > > > > > Looks reasonable to me.
> > > > > > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > > > > >
> > > > > > > Please submit this patch into Russell's patch tracker.
> > > > > >
> > > > > > ... and has totally broken what looks like _all_ ARM kernel builds.
> > > > > This patch is intended to trigger build error when it check the value of
> > > > > __end_of_fixmap_region is equal or larger than 256.
> > > >
> > > > Why? The fixmap region is larger than one PMD, so why do we need to cap it?
> > > In __kmap_local_pfn_prot, arch_kmap_local_set_pte(&init_mm, vaddr, kmap_pte
> > > - idx, pteval) is used to set pteval.
> > > But the ptep is calculated by "kmap_pte - idx", which means all ptes must be
> > > placed next to each other and no gaps. But for ARM, the ptes for the range
> > > "0xffe00000~0xfff00000" is not next to the ptes for the range
> > > "0xffc80000~0xffdfffff".
> > >
> > > When the idx is larger than 256, virtual address is in 0xffdxxxxx, access
> > > this address will crash since its pteval isn't set correctly.
> >
> > Thanks for the explanation.
> >
> > Sadly, this does seem to be correct. Even if the PTE tables are
> > located next to each other in memory, they _still_ won't be a
> > contiguous array of entries due to being interleaved with the Linux
> > PTE table and the hardware PTE table.
> >
> > Since the address range 0xffe00000-0xfff00000 is already half of one
> > PTE table containing 512 contiguous entries, we are limited to 256
> > fixmap PTEs maximum. If we have more than that we will start trampling
> > over memory below the PTE table _and_ we will start corrupting Linux
> > PTE entries in the 0xfff00000-0xffffffff range.
> >
> > I suspect this hasn't been seen because of a general lack of ARM
> > systems with more than 4 CPUs.
> >
> 
> But doesn't that make it a kmap_local regression? Or do you think this
> issue existed before that as well?

It definitely is a bug in tglx's kmap_local code, which assumes all
PTEs in the fixmap region are contiguously arranged.

Looking back further, when local kmaps were handled in arch code, this
bug did /not/ exist. We used to get the PTE entry to update via:

	unsigned long vaddr = __fix_to_virt(idx);
	pte_t *ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);

which later became:

	pte_t *ptep = virt_to_kpte(vaddr);

Both of which walk the page tables.

So in summary a regression caused by converting ARM to kmap_local.

I think we could fix it by providing our own arch_kmap_local_set_pte()
which ignores the ptep argument, and instead walks the page tables
using the vaddr argument.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
