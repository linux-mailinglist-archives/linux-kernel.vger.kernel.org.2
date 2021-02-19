Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A362E31FEB3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 19:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhBSSUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 13:20:02 -0500
Received: from foss.arm.com ([217.140.110.172]:42058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229799AbhBSSTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 13:19:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A15F9ED1;
        Fri, 19 Feb 2021 10:18:46 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.45.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F76E3F73D;
        Fri, 19 Feb 2021 10:18:44 -0800 (PST)
Date:   Fri, 19 Feb 2021 18:18:34 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, marcan@marcan.st, james.morse@arm.com,
        maz@kernel.org, tglx@linutronix.de, will@kernel.org, nd@arm.com
Subject: Re: [PATCH 8/8] arm64: irq: allow FIQs to be handled
Message-ID: <20210219181825.GA84857@C02TD0UTHF1T.local>
References: <20210219113904.41736-1-mark.rutland@arm.com>
 <20210219113904.41736-9-mark.rutland@arm.com>
 <20210219153725.GA43917@e124191.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219153725.GA43917@e124191.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 03:37:25PM +0000, Joey Gouly wrote:
> Hi Mark,
> 
> On Fri, Feb 19, 2021 at 11:39:04AM +0000, Mark Rutland wrote:
> > On contemporary platforms we don't use FIQ, and treat any stray FIQ as a
> > fatal event. However, some platforms have an interrupt controller wired
> > to FIQ, and need to handle FIQ as part of regular operation.
> > 
> 
> [...]
> 
> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index 0474cca9f1a9..a8290bd87a49 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -586,23 +586,23 @@ SYM_CODE_START(vectors)
> >  
> >  	kernel_ventry	1, sync				// Synchronous EL1h
> >  	kernel_ventry	1, irq				// IRQ EL1h
> > -	kernel_ventry	1, fiq_invalid			// FIQ EL1h
> > +	kernel_ventry	1, fiq				// FIQ EL1h
> >  	kernel_ventry	1, error			// Error EL1h
> >  
> >  	kernel_ventry	0, sync				// Synchronous 64-bit EL0
> >  	kernel_ventry	0, irq				// IRQ 64-bit EL0
> > -	kernel_ventry	0, fiq_invalid			// FIQ 64-bit EL0
> > +	kernel_ventry	0, fiq				// FIQ 64-bit EL0
> >  	kernel_ventry	0, error			// Error 64-bit EL0
> >  
> >  #ifdef CONFIG_COMPAT
> >  	kernel_ventry	0, sync_compat, 32		// Synchronous 32-bit EL0
> >  	kernel_ventry	0, irq_compat, 32		// IRQ 32-bit EL0
> > -	kernel_ventry	0, fiq_invalid_compat, 32	// FIQ 32-bit EL0
> > +	kernel_ventry	0, fiq_compat, 32		// FIQ 32-bit EL0
> >  	kernel_ventry	0, error_compat, 32		// Error 32-bit EL0
> >  #else
> >  	kernel_ventry	0, sync_invalid, 32		// Synchronous 32-bit EL0
> >  	kernel_ventry	0, irq_invalid, 32		// IRQ 32-bit EL0
> > -	kernel_ventry	0, fiq_invalid, 32		// FIQ 32-bit EL0
> > +	kernel_ventry	0, fiq, 32			// FIQ 32-bit EL0
> >  	kernel_ventry	0, error_invalid, 32		// Error 32-bit EL0
> >  #endif
> >  SYM_CODE_END(vectors)
> 
> I believe you can now remove functions `el0_fiq_invalid` and `el0_fiq_invalid_compat`.
> `el1_fiq_invalid` is still used by Synchronous EL1t, so can't be removed.

Good spot; el0_fiq_invalid_compat can go. For the !CONFIG_COMPAT it was
wrong to move away from fiq_invalid as that vector should never
legimitately fire, so I'll revert back to fiq_invalid for that case and
match the rest of the !CONFIG_COMPAT AArch32 EL0 handlers.

Thanks,
Mark.
