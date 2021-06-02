Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB2C399028
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhFBQkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhFBQkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:40:09 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEA6C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xgBO7fdSr6YSsVQBLRDAGFaBV9JpUZ1T6Fnms/JHljk=; b=Zq5z+xhHzF1/WVUrMUxtHyrO2
        9/uMO4e+CR3AAO8dP6KevTOZ0IMUq7emOs+1aFKz/9yKmXXLovec7iGNoEnW9DGitAhlp50BYlYfL
        7+n6Q+VfJcv+yTZdgnRik/7PZkWtl2CAGku4kNtSIJdUswL3gE9nu2zBmA1q1o2K3qsKOlytgu4R0
        4mNDJoljSVvGcdrWmenY1JvMPN0nVgSCFraURpb7LXCQwIU2xYD9XWPriIOFmto0mT21+kHndg+Ea
        TJNeME+hK0Je+U0bLvF7EZlAUNAtk9GJwz1yDPjhGDPoF++OjeOdj/WhKhN3wFOQyzKrDLVzIXZvl
        m9ifRTCKw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44636)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1loTsq-0001YY-2E; Wed, 02 Jun 2021 17:38:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1loTsk-0001HG-6E; Wed, 02 Jun 2021 17:38:14 +0100
Date:   Wed, 2 Jun 2021 17:38:14 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "arm: mm: qsd8x50: Fix incorrect permission
 faults"
Message-ID: <20210602163814.GO30436@shell.armlinux.org.uk>
References: <20210528074444.17291-1-wangkefeng.wang@huawei.com>
 <248320ed-494b-937d-734c-c97e0c32038a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <248320ed-494b-937d-734c-c97e0c32038a@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefang,

On Wed, Jun 02, 2021 at 11:14:51PM +0800, Kefeng Wang wrote:
> Hi Russell, any comment about this patch, thanks.

I think it's fine - looking at the history, this was a change submitted
in 2009 for the MSM platform that has been dropped from the kernel. It
seems the option was never enabled, even when support for this platform
was present in the kernel.

So please send to the patch system and I'll merge it in due course.

Thanks.

> 
> On 2021/5/28 15:44, Kefeng Wang wrote:
> > This reverts commit e220ba60223a9d63e70217e5b112160df8c21cea.
> > 
> > The VERIFY_PERMISSION_FAULT is introduced since 2009 but no
> > one use it, just revert it and clean unused comment.
> > 
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > ---
> >   arch/arm/mm/Kconfig     |  2 --
> >   arch/arm/mm/abort-ev7.S | 26 --------------------------
> >   2 files changed, 28 deletions(-)
> > 
> > diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> > index 35f43d0aa056..8355c3895894 100644
> > --- a/arch/arm/mm/Kconfig
> > +++ b/arch/arm/mm/Kconfig
> > @@ -601,8 +601,6 @@ config CPU_TLB_V6
> >   config CPU_TLB_V7
> >   	bool
> > -config VERIFY_PERMISSION_FAULT
> > -	bool
> >   endif
> >   config CPU_HAS_ASID
> > diff --git a/arch/arm/mm/abort-ev7.S b/arch/arm/mm/abort-ev7.S
> > index f7cc5d68444b..f81bceacc660 100644
> > --- a/arch/arm/mm/abort-ev7.S
> > +++ b/arch/arm/mm/abort-ev7.S
> > @@ -17,31 +17,5 @@ ENTRY(v7_early_abort)
> >   	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
> >   	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
> >   	uaccess_disable ip			@ disable userspace access
> > -
> > -	/*
> > -	 * V6 code adjusts the returned DFSR.
> > -	 * New designs should not need to patch up faults.
> > -	 */
> > -
> > -#if defined(CONFIG_VERIFY_PERMISSION_FAULT)
> > -	/*
> > -	 * Detect erroneous permission failures and fix
> > -	 */
> > -	ldr	r3, =0x40d			@ On permission fault
> > -	and	r3, r1, r3
> > -	cmp	r3, #0x0d
> > -	bne	do_DataAbort
> > -
> > -	mcr	p15, 0, r0, c7, c8, 0   	@ Retranslate FAR
> > -	isb
> > -	mrc	p15, 0, ip, c7, c4, 0   	@ Read the PAR
> > -	and	r3, ip, #0x7b   		@ On translation fault
> > -	cmp	r3, #0x0b
> > -	bne	do_DataAbort
> > -	bic	r1, r1, #0xf			@ Fix up FSR FS[5:0]
> > -	and	ip, ip, #0x7e
> > -	orr	r1, r1, ip, LSR #1
> > -#endif
> > -
> >   	b	do_DataAbort
> >   ENDPROC(v7_early_abort)
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
