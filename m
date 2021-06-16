Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D753A9E83
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhFPPHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:07:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234416AbhFPPHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:07:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5519F600EF;
        Wed, 16 Jun 2021 15:04:59 +0000 (UTC)
Date:   Wed, 16 Jun 2021 16:04:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Message-ID: <20210616150456.GC22433@arm.com>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <YMnPezLs6vb418Wz@hirez.programming.kicks-ass.net>
 <YMnQVoKvM5G34Yan@hirez.programming.kicks-ass.net>
 <20210616103446.GC22278@shell.armlinux.org.uk>
 <YMncQv1uT5QyQ84w@hirez.programming.kicks-ass.net>
 <20210616132226.GD22278@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616132226.GD22278@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 02:22:27PM +0100, Russell King wrote:
> On Wed, Jun 16, 2021 at 01:10:58PM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 16, 2021 at 11:34:46AM +0100, Russell King (Oracle) wrote:
> > > On Wed, Jun 16, 2021 at 12:20:06PM +0200, Peter Zijlstra wrote:
> > > > On Wed, Jun 16, 2021 at 12:16:27PM +0200, Peter Zijlstra wrote:
> > > > > On Tue, Jun 15, 2021 at 08:21:12PM -0700, Andy Lutomirski wrote:
> > > > > > On arm32, the only way to safely flush icache from usermode is to call
> > > > > > cacheflush(2).  This also handles any required pipeline flushes, so
> > > > > > membarrier's SYNC_CORE feature is useless on arm.  Remove it.
> > > > > 
> > > > > So SYNC_CORE is there to help an architecture that needs to do something
> > > > > per CPU. If I$ invalidation is broadcast and I$ invalidation also
> > > > > triggers the flush of any uarch caches derived from it (if there are
> > > > > any).
> > > > 
> > > > Incomplete sentence there: + then we don't need SYNC_CORE.
> > > > 
> > > > > Now arm_syscall() NR(cacheflush) seems to do flush_icache_user_range(),
> > > > > which, if I read things right, end up in arch/arm/mm/*.S, but that
> > > > > doesn't consider cache_ops_need_broadcast().
> > > > > 
> > > > > Will suggests that perhaps ARM 11MPCore might need this due to their I$
> > > > > flush maybe not being broadcast
> > > 
> > > If it leaves other cores with incoherent I cache, then that's already
> > > a problem for SMP cores, since there could be no guarantee that the
> > > modifications made by one core will be visible to some other core that
> > > ends up running that code - and there is little option for userspace to
> > > work around that except by pinning the thread making the modifications
> > > and subsequently executing the code to a core.
> > 
> > That's where SYNC_CORE can help. Or you make sys_cacheflush() do a
> > system wide IPI.
> 
> If it's a problem, then it needs fixing. sys_cacheflush() is used to
> implement GCC's __builtin___clear_cache(). I'm not sure who added this
> to gcc.

I'm surprised that it works. I guess it's just luck that the thread
doing the code writing doesn't migrate before the sys_cacheflush() call.

> > > The same is also true of flush_icache_range() - which is used when
> > > loading a kernel module. In the case Will is referring to, these alias
> > > to the same code.
> > 
> > Yes, cache_ops_need_broadcast() seems to be missing in more places.
> 
> Likely only in places where we care about I/D coherency - as the data
> cache is required to be PIPT on these SMP platforms.

We had similar issue with the cache maintenance for DMA. The hack we
employed (in cache.S) is relying on the MESI protocol internals and
forcing a read/write for ownership before the D-cache maintenance.
Luckily ARM11MPCore doesn't do speculative data loads to trigger some
migration back.

The simpler fix for flush_icache_range() is to disable preemption, read
a word in a cacheline to force any dirty lines on another CPU to be
evicted and then issue the D-cache maintenance (for those cache lines
which are still dirty on the current CPU).

It's a hack that only works on ARM11MPCore. Newer MP cores are saner.

-- 
Catalin
