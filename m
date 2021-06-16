Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F02C3A9EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhFPPZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbhFPPZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:25:44 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9020C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vztJ5SKsn2QWn9Ydt6vhChg/4PQAGt6omwb1vW9EjfA=; b=eGqtBpc1+Ez10Kt7iInfiZuGe
        Y4Jh9x1+V8tIEQxy7KxLt4m1nrLZzhNK4i8g+S89g4Yjd298ZY6dYX66OCaXQJyhFgrqHYHk6Dlr6
        JZZwkaZYCD2xrsQVzaHKJC5g9nH5kT2S+gt4RexAHxCc1z4yovEIG7/heeB1q4XVWnO/FXDT7QAM2
        mP8BDQTV7bLWaSNzNgu1+Vo+E2cAXfhwnPpFdvaW53M9heT13Kj+IqTR6La8+TZk9qYyoTbJT0miN
        S34CRzPk6udB9CNarZGqe0q0qcUFpb00MjkwpZBaBPJnRmiGTiC4pJUgAtYIUhw9R7Kh5lXLUFGEU
        SPNr1ui4w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45074)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ltXO5-0007US-Op; Wed, 16 Jun 2021 16:23:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ltXO2-00068y-HY; Wed, 16 Jun 2021 16:23:26 +0100
Date:   Wed, 16 Jun 2021 16:23:26 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Message-ID: <20210616152326.GG22278@shell.armlinux.org.uk>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <YMnPezLs6vb418Wz@hirez.programming.kicks-ass.net>
 <YMnQVoKvM5G34Yan@hirez.programming.kicks-ass.net>
 <20210616103446.GC22278@shell.armlinux.org.uk>
 <YMncQv1uT5QyQ84w@hirez.programming.kicks-ass.net>
 <20210616132226.GD22278@shell.armlinux.org.uk>
 <20210616150456.GC22433@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616150456.GC22433@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 04:04:56PM +0100, Catalin Marinas wrote:
> On Wed, Jun 16, 2021 at 02:22:27PM +0100, Russell King wrote:
> > If it's a problem, then it needs fixing. sys_cacheflush() is used to
> > implement GCC's __builtin___clear_cache(). I'm not sure who added this
> > to gcc.
> 
> I'm surprised that it works. I guess it's just luck that the thread
> doing the code writing doesn't migrate before the sys_cacheflush() call.

Maybe the platforms that use ARM MPCore avoid the issue somehow (maybe
by not using self-modifying code?)

> > Likely only in places where we care about I/D coherency - as the data
> > cache is required to be PIPT on these SMP platforms.
> 
> We had similar issue with the cache maintenance for DMA. The hack we
> employed (in cache.S) is relying on the MESI protocol internals and
> forcing a read/write for ownership before the D-cache maintenance.
> Luckily ARM11MPCore doesn't do speculative data loads to trigger some
> migration back.

That's very similar to the hack that was originally implemented for
MPCore DMA - see the DMA_CACHE_RWFO configuration option.

An interesting point here is that cache_ops_need_broadcast() reads
MMFR3 bits 12..15, which in the MPCore TRM has nothing to with cache
operation broadcasting - but luckily is documented as containing zero.
So, cache_ops_need_broadcast() returns correctly (true) here.

> The simpler fix for flush_icache_range() is to disable preemption, read
> a word in a cacheline to force any dirty lines on another CPU to be
> evicted and then issue the D-cache maintenance (for those cache lines
> which are still dirty on the current CPU).

Is just reading sufficient? If so, why do we do a read-then-write in
the MPCore DMA cache ops? Don't we need the write to force exclusive
ownership? If we don't have exclusive ownership of the dirty line,
how can we be sure to write it out of the caches?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
