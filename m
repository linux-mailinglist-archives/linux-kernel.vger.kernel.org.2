Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25B33AB534
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhFQNx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:53:59 -0400
Received: from foss.arm.com ([217.140.110.172]:53888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231299AbhFQNx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:53:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4E4D106F;
        Thu, 17 Jun 2021 06:51:49 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D9043F719;
        Thu, 17 Jun 2021 06:51:47 -0700 (PDT)
Date:   Thu, 17 Jun 2021 14:51:33 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Message-ID: <20210617135133.GA86101@C02TD0UTHF1T.local>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <20210617103524.GA82133@C02TD0UTHF1T.local>
 <20210617112305.GK22278@shell.armlinux.org.uk>
 <20210617113349.GB82133@C02TD0UTHF1T.local>
 <394219d4-36a6-4e7f-a03c-8590551b099a@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <394219d4-36a6-4e7f-a03c-8590551b099a@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 06:41:41AM -0700, Andy Lutomirski wrote:
> 
> 
> On Thu, Jun 17, 2021, at 4:33 AM, Mark Rutland wrote:
> > On Thu, Jun 17, 2021 at 12:23:05PM +0100, Russell King (Oracle) wrote:
> > > On Thu, Jun 17, 2021 at 11:40:46AM +0100, Mark Rutland wrote:
> > > > On Tue, Jun 15, 2021 at 08:21:12PM -0700, Andy Lutomirski wrote:
> > > > > On arm32, the only way to safely flush icache from usermode is to call
> > > > > cacheflush(2).  This also handles any required pipeline flushes, so
> > > > > membarrier's SYNC_CORE feature is useless on arm.  Remove it.
> > > > 
> > > > Unfortunately, it's a bit more complicated than that, and these days
> > > > SYNC_CORE is equally necessary on arm as on arm64. This is something
> > > > that changed in the architecture over time, but since ARMv7 we generally
> > > > need both the cache maintenance *and* a context synchronization event
> > > > (the latter must occur on the CPU which will execute the instructions).
> > > > 
> > > > If you look at the latest ARMv7-AR manual (ARM DDI 406C.d), section
> > > > A3.5.4 "Concurrent modification and execution of instructions" covers
> > > > this. That manual can be found at:
> > > > 
> > > > 	https://developer.arm.com/documentation/ddi0406/latest/
> > > 
> > > Looking at that, sys_cacheflush() meets this. The manual details a
> > > series of cache maintenance calls in "step 1" that the modifying thread
> > > must issue - this is exactly what sys_cacheflush() does. The same is
> > > true for ARMv6, except the "ISB" terminology is replaced by a
> > > "PrefetchFlush" terminology. (I checked DDI0100I).
> > > 
> > > "step 2" requires an ISB on the "other CPU" prior to executing that
> > > code. As I understand it, in ARMv7, userspace can issue an ISB itself.
> > > 
> > > For ARMv6K, it doesn't have ISB, but instead has a CP15 instruction
> > > for this that isn't availble to userspace. This is where we come to
> > > the situation about ARM 11MPCore, and whether we continue to support
> > > it or not.
> > > 
> > > So, I think we're completely fine with ARMv7 under 32-bit ARM kernels
> > > as userspace has everything that's required. ARMv6K is a different
> > > matter as we've already identified for several reasons.
> > 
> > Sure, and I agree we should not change cacheflush().
> > 
> > The point of membarrier(SYNC_CORE) is that you can move the cost of that
> > ISB out of the fast-path in the executing thread(s) and into the
> > slow-path on the thread which generated the code.
> > 
> > So e.g. rather than an executing thread always having to do:
> > 
> > 	LDR	<reg>, [<funcptr>]
> > 	ISB	// in case funcptr was just updated
> > 	BLR	<reg>
> > 
> > ... you have the thread generating the code use membarrier(SYNC_CORE)
> > prior to plublishing the funcptr, and the fast-path on all the executing
> > threads can be:
> > 
> > 	LDR	<reg> [<funcptr>]
> > 	BLR	<reg>
> > 
> > ... and thus I think we still want membarrier(SYNC_CORE) so that people
> > can do this, even if there are other means to achieve the same
> > functionality.
> 
> I had the impression that sys_cacheflush() did that.  Am I wrong?

Currently sys_cacheflush() doesn't do this, and IIUC it has never done
remote context synchronization even for architectures that need that
(e.g. x86 requiring a serializing instruction).

> In any event, I’m even more convinced that no new SYNC_CORE arches
> should be added. We need a new API that just does the right thing. 

My intuition is the other way around, and that this is a gnereally
useful thing for architectures that require context synchronization.

It's not clear to me what "the right thing" would mean specifically, and
on architectures with userspace cache maintenance JITs can usually do
the most optimal maintenance, and only need help for the context
synchronization.

Thanks,
Mark.
