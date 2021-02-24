Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47584324074
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbhBXPFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:05:44 -0500
Received: from foss.arm.com ([217.140.110.172]:33000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232541AbhBXOIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:08:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7962731B;
        Wed, 24 Feb 2021 06:07:01 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.52.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 642C43F70D;
        Wed, 24 Feb 2021 06:06:59 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:06:56 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH 0/8] arm64: Support FIQ controller registration
Message-ID: <20210224140656.GG50741@C02TD0UTHF1T.local>
References: <20210219113904.41736-1-mark.rutland@arm.com>
 <87a6s0orm7.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6s0orm7.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 06:10:56PM +0000, Marc Zyngier wrote:
> Hi Mark,
> 
> On Fri, 19 Feb 2021 11:38:56 +0000,
> Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > Hector's M1 support series [1] shows that some platforms have critical
> > interrupts wired to FIQ, and to support these platforms we need to support
> > handling FIQ exceptions. Other contemporary platforms don't use FIQ (since e.g.
> > this is usually routed to EL3), and as we never expect to take an FIQ, we have
> > the FIQ vector cause a panic.
> > 
> > Since the use of FIQ is a platform integration detail (which can differ across
> > bare-metal and virtualized environments), we need be able to explicitly opt-in
> > to handling FIQs while retaining the existing behaviour otherwise. This series
> > adds a new set_handle_fiq() hook so that the FIQ controller can do so, and
> > where no controller is registered the default handler will panic(). For
> > consistency the set_handle_irq() code is made to do the same.
> > 
> > The first couple of patches are from Marc's irq/drop-generic_irq_multi_handler
> > branch [2] on kernel.org, and clean up CONFIG_GENERIC_IRQ_MULTI_HANDLER usage.
> > The next four patches move arm64 over to a local set_handle_irq()
> > implementation, which is written to share code with a set_handle_fiq() function
> > in the last two patches. The only functional difference here is that if an IRQ
> > is somehow taken prior to set_handle_irq() the default handler will directly
> > panic() rather than the vector branching to NULL.
> > 
> > The penultimate patch is cherry-picked from the v2 M1 series, and as per
> > discussion there [3] will need a few additional fixups. I've included it for
> > now as the DAIF.IF alignment is necessary for the FIQ exception handling added
> > in the final patch.
> > 
> > The final patch adds the low-level FIQ exception handling and registration
> > mechanism atop the prior rework.
> 
> Thanks for putting this together. I have an extra patch on top of this
> series[1] that prevents the kernel from catching fire if a FIQ fires
> whilst running a guest. Nothing urgent, we can queue it at a later time.
> 
> Thanks,
> 
> 	M.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/fiq

IIUC for that "invalid_vect" should be changed to "valid_vect", to match
the other valid vector entries, but otherwise that looks sane to me.

I guess we could take that as a prerequisite ahead of the rest?

Thanks,
Mark.
