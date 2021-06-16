Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7B63A98EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhFPLNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhFPLNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:13:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D6DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XyMAqdzcY6+j3KeLnrTUviBISDYWLd3gDa93b1F9u2g=; b=DsObk91CK5kGbFl/8uFi5mInm9
        N59JXOouJ2WtushIn7Kdfp3ryM7nrEPpALT1JPVeLw+CMXxO0XJliHzLziX8dDDopX1L+zZspstm/
        4/uVt7lasiSvZMfKrkdkp9a9Pi5AWBWed/bQaxuoEntQ/K+e1bI5dghh6HBYcbRfzsNiE31LuNTL7
        5PE9AZyR68K7Q599y7LB8pIFQLhc0MH9foE52PmbrraQqPNaG9zpxHHf569NarOMujS3Rip/dt1Dc
        Sm0k/nOOytOPSbZiNv5tSUAMPDJlKL/yVoKipYrU+Vci2Sf+K02zAJzEXzImtaG3bSrdA/HzaW+M7
        rV2az/lA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltTRm-007xhs-B1; Wed, 16 Jun 2021 11:11:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BE979300252;
        Wed, 16 Jun 2021 13:10:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ADDA420C169EB; Wed, 16 Jun 2021 13:10:58 +0200 (CEST)
Date:   Wed, 16 Jun 2021 13:10:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Message-ID: <YMncQv1uT5QyQ84w@hirez.programming.kicks-ass.net>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <YMnPezLs6vb418Wz@hirez.programming.kicks-ass.net>
 <YMnQVoKvM5G34Yan@hirez.programming.kicks-ass.net>
 <20210616103446.GC22278@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616103446.GC22278@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:34:46AM +0100, Russell King (Oracle) wrote:
> On Wed, Jun 16, 2021 at 12:20:06PM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 16, 2021 at 12:16:27PM +0200, Peter Zijlstra wrote:
> > > On Tue, Jun 15, 2021 at 08:21:12PM -0700, Andy Lutomirski wrote:
> > > > On arm32, the only way to safely flush icache from usermode is to call
> > > > cacheflush(2).  This also handles any required pipeline flushes, so
> > > > membarrier's SYNC_CORE feature is useless on arm.  Remove it.
> > > 
> > > So SYNC_CORE is there to help an architecture that needs to do something
> > > per CPU. If I$ invalidation is broadcast and I$ invalidation also
> > > triggers the flush of any uarch caches derived from it (if there are
> > > any).
> > 
> > Incomplete sentence there: + then we don't need SYNC_CORE.
> > 
> > > Now arm_syscall() NR(cacheflush) seems to do flush_icache_user_range(),
> > > which, if I read things right, end up in arch/arm/mm/*.S, but that
> > > doesn't consider cache_ops_need_broadcast().
> > > 
> > > Will suggests that perhaps ARM 11MPCore might need this due to their I$
> > > flush maybe not being broadcast
> 
> If it leaves other cores with incoherent I cache, then that's already
> a problem for SMP cores, since there could be no guarantee that the
> modifications made by one core will be visible to some other core that
> ends up running that code - and there is little option for userspace to
> work around that except by pinning the thread making the modifications
> and subsequently executing the code to a core.

That's where SYNC_CORE can help. Or you make sys_cacheflush() do a
system wide IPI.

> The same is also true of flush_icache_range() - which is used when
> loading a kernel module. In the case Will is referring to, these alias
> to the same code.

Yes, cache_ops_need_broadcast() seems to be missing in more places.
