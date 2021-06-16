Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9C33AA04A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbhFPPsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235591AbhFPPrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:47:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F41A460FE3;
        Wed, 16 Jun 2021 15:45:31 +0000 (UTC)
Date:   Wed, 16 Jun 2021 16:45:29 +0100
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
Message-ID: <20210616154529.GD22433@arm.com>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <YMnPezLs6vb418Wz@hirez.programming.kicks-ass.net>
 <YMnQVoKvM5G34Yan@hirez.programming.kicks-ass.net>
 <20210616103446.GC22278@shell.armlinux.org.uk>
 <YMncQv1uT5QyQ84w@hirez.programming.kicks-ass.net>
 <20210616132226.GD22278@shell.armlinux.org.uk>
 <20210616150456.GC22433@arm.com>
 <20210616152326.GG22278@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616152326.GG22278@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 04:23:26PM +0100, Russell King wrote:
> On Wed, Jun 16, 2021 at 04:04:56PM +0100, Catalin Marinas wrote:
> > On Wed, Jun 16, 2021 at 02:22:27PM +0100, Russell King wrote:
> > > If it's a problem, then it needs fixing. sys_cacheflush() is used to
> > > implement GCC's __builtin___clear_cache(). I'm not sure who added this
> > > to gcc.
> > 
> > I'm surprised that it works. I guess it's just luck that the thread
> > doing the code writing doesn't migrate before the sys_cacheflush() call.
> 
> Maybe the platforms that use ARM MPCore avoid the issue somehow (maybe
> by not using self-modifying code?)

Not sure how widely it is/was used with JITs. In general, I think the
systems at the time were quite tolerant to missing I-cache maintenance
(maybe small caches?). We ran Linux for a while without 826cbdaff297
("[ARM] 5092/1: Fix the I-cache invalidation on ARMv6 and later CPUs").

> > > Likely only in places where we care about I/D coherency - as the data
> > > cache is required to be PIPT on these SMP platforms.
> > 
> > We had similar issue with the cache maintenance for DMA. The hack we
> > employed (in cache.S) is relying on the MESI protocol internals and
> > forcing a read/write for ownership before the D-cache maintenance.
> > Luckily ARM11MPCore doesn't do speculative data loads to trigger some
> > migration back.
> 
> That's very similar to the hack that was originally implemented for
> MPCore DMA - see the DMA_CACHE_RWFO configuration option.

Well, yes, that's what I wrote above ;) (I added the hack and config
option IIRC).

> An interesting point here is that cache_ops_need_broadcast() reads
> MMFR3 bits 12..15, which in the MPCore TRM has nothing to with cache
> operation broadcasting - but luckily is documented as containing zero.
> So, cache_ops_need_broadcast() returns correctly (true) here.

That's typical with any new feature. The 12..15 field was added in ARMv7
stating that cache maintenance is broadcast in hardware. Prior to this,
the field was read-as-zero. So it's not luck but we could have avoided
negating the meaning here, i.e. call it cache_ops_are_broadcast().

> > The simpler fix for flush_icache_range() is to disable preemption, read
> > a word in a cacheline to force any dirty lines on another CPU to be
> > evicted and then issue the D-cache maintenance (for those cache lines
> > which are still dirty on the current CPU).
> 
> Is just reading sufficient? If so, why do we do a read-then-write in
> the MPCore DMA cache ops? Don't we need the write to force exclusive
> ownership? If we don't have exclusive ownership of the dirty line,
> how can we be sure to write it out of the caches?

For cleaning (which is the case for I/D coherency), we only need reading
since we are fine with clean lines being left in the D-cache on other
CPUs. For invalidation, we indeed need to force the exclusive ownership,
hence the write.

-- 
Catalin
