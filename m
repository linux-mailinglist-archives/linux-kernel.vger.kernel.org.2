Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D7D3AB2A6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhFQLgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:36:04 -0400
Received: from foss.arm.com ([217.140.110.172]:52256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231250AbhFQLgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:36:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9912D113E;
        Thu, 17 Jun 2021 04:33:54 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 088573F719;
        Thu, 17 Jun 2021 04:33:51 -0700 (PDT)
Date:   Thu, 17 Jun 2021 12:33:49 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Message-ID: <20210617113349.GB82133@C02TD0UTHF1T.local>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <20210617103524.GA82133@C02TD0UTHF1T.local>
 <20210617112305.GK22278@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617112305.GK22278@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 12:23:05PM +0100, Russell King (Oracle) wrote:
> On Thu, Jun 17, 2021 at 11:40:46AM +0100, Mark Rutland wrote:
> > On Tue, Jun 15, 2021 at 08:21:12PM -0700, Andy Lutomirski wrote:
> > > On arm32, the only way to safely flush icache from usermode is to call
> > > cacheflush(2).  This also handles any required pipeline flushes, so
> > > membarrier's SYNC_CORE feature is useless on arm.  Remove it.
> > 
> > Unfortunately, it's a bit more complicated than that, and these days
> > SYNC_CORE is equally necessary on arm as on arm64. This is something
> > that changed in the architecture over time, but since ARMv7 we generally
> > need both the cache maintenance *and* a context synchronization event
> > (the latter must occur on the CPU which will execute the instructions).
> > 
> > If you look at the latest ARMv7-AR manual (ARM DDI 406C.d), section
> > A3.5.4 "Concurrent modification and execution of instructions" covers
> > this. That manual can be found at:
> > 
> > 	https://developer.arm.com/documentation/ddi0406/latest/
> 
> Looking at that, sys_cacheflush() meets this. The manual details a
> series of cache maintenance calls in "step 1" that the modifying thread
> must issue - this is exactly what sys_cacheflush() does. The same is
> true for ARMv6, except the "ISB" terminology is replaced by a
> "PrefetchFlush" terminology. (I checked DDI0100I).
> 
> "step 2" requires an ISB on the "other CPU" prior to executing that
> code. As I understand it, in ARMv7, userspace can issue an ISB itself.
> 
> For ARMv6K, it doesn't have ISB, but instead has a CP15 instruction
> for this that isn't availble to userspace. This is where we come to
> the situation about ARM 11MPCore, and whether we continue to support
> it or not.
> 
> So, I think we're completely fine with ARMv7 under 32-bit ARM kernels
> as userspace has everything that's required. ARMv6K is a different
> matter as we've already identified for several reasons.

Sure, and I agree we should not change cacheflush().

The point of membarrier(SYNC_CORE) is that you can move the cost of that
ISB out of the fast-path in the executing thread(s) and into the
slow-path on the thread which generated the code.

So e.g. rather than an executing thread always having to do:

	LDR	<reg>, [<funcptr>]
	ISB	// in case funcptr was just updated
	BLR	<reg>

... you have the thread generating the code use membarrier(SYNC_CORE)
prior to plublishing the funcptr, and the fast-path on all the executing
threads can be:

	LDR	<reg> [<funcptr>]
	BLR	<reg>

... and thus I think we still want membarrier(SYNC_CORE) so that people
can do this, even if there are other means to achieve the same
functionality.

Thanks,
Mark.

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
