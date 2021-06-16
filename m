Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACD83AA0A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhFPQDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:03:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230515AbhFPQDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:03:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4233661159;
        Wed, 16 Jun 2021 16:00:54 +0000 (UTC)
Date:   Wed, 16 Jun 2021 17:00:51 +0100
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
Message-ID: <20210616160050.GE22433@arm.com>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <YMnPezLs6vb418Wz@hirez.programming.kicks-ass.net>
 <YMnQVoKvM5G34Yan@hirez.programming.kicks-ass.net>
 <20210616103446.GC22278@shell.armlinux.org.uk>
 <YMncQv1uT5QyQ84w@hirez.programming.kicks-ass.net>
 <20210616132226.GD22278@shell.armlinux.org.uk>
 <20210616150456.GC22433@arm.com>
 <20210616152326.GG22278@shell.armlinux.org.uk>
 <20210616154529.GD22433@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616154529.GD22433@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 04:45:29PM +0100, Catalin Marinas wrote:
> On Wed, Jun 16, 2021 at 04:23:26PM +0100, Russell King wrote:
> > On Wed, Jun 16, 2021 at 04:04:56PM +0100, Catalin Marinas wrote:
> > > The simpler fix for flush_icache_range() is to disable preemption, read
> > > a word in a cacheline to force any dirty lines on another CPU to be
> > > evicted and then issue the D-cache maintenance (for those cache lines
> > > which are still dirty on the current CPU).
> > 
> > Is just reading sufficient? If so, why do we do a read-then-write in
> > the MPCore DMA cache ops? Don't we need the write to force exclusive
> > ownership? If we don't have exclusive ownership of the dirty line,
> > how can we be sure to write it out of the caches?
> 
> For cleaning (which is the case for I/D coherency), we only need reading
> since we are fine with clean lines being left in the D-cache on other
> CPUs. For invalidation, we indeed need to force the exclusive ownership,
> hence the write.

Ah, I'm not sure the I-cache is broadcast in hardware on ARM11MPCore
either. So fixing the D side won't be sufficient.

-- 
Catalin
