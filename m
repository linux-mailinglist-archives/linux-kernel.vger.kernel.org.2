Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9453A9721
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhFPKXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhFPKXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:23:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C02C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cy5WDEDJoCifDNXZBFXkP+HYSey95Q3SWFI+OtZhevA=; b=LdAxykxUBy1mTWLpEJKa13we03
        phPq39iI1GERziQK6xOwMuLoG1DH7H3Ih2PMfYggHNzEPZJPIwoOkvkfTha/Flb7re2IsVq/n/wQU
        WQBTOw+RBSBHUcQrKC2Wzy/SQ2W4SHZMnyv+n1GJ2Mzpg/BHPpzrsVH5JiG4mwy5pmkivmM9S3D0t
        q2SIvpSb19H35LDLpBbxgf8JdKsPW1+cx9wA86blx2p3I/hnyAHGoNjr6xxTuX7GSI9VjdeLQiw2W
        dz6nobQ5wc+pBHgdJG5aCTkF5y2/ArxAU+Lu4ZBwAZdmLG6YcC0FtPUV0nLf7KCwj9nk0Nr8T9EaK
        fa/d+2eQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltSeU-007u7x-Pt; Wed, 16 Jun 2021 10:20:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B544300269;
        Wed, 16 Jun 2021 12:20:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5263420C169EA; Wed, 16 Jun 2021 12:20:06 +0200 (CEST)
Date:   Wed, 16 Jun 2021 12:20:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Message-ID: <YMnQVoKvM5G34Yan@hirez.programming.kicks-ass.net>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <YMnPezLs6vb418Wz@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMnPezLs6vb418Wz@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 12:16:27PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 15, 2021 at 08:21:12PM -0700, Andy Lutomirski wrote:
> > On arm32, the only way to safely flush icache from usermode is to call
> > cacheflush(2).  This also handles any required pipeline flushes, so
> > membarrier's SYNC_CORE feature is useless on arm.  Remove it.
> 
> So SYNC_CORE is there to help an architecture that needs to do something
> per CPU. If I$ invalidation is broadcast and I$ invalidation also
> triggers the flush of any uarch caches derived from it (if there are
> any).

Incomplete sentence there: + then we don't need SYNC_CORE.

> Now arm_syscall() NR(cacheflush) seems to do flush_icache_user_range(),
> which, if I read things right, end up in arch/arm/mm/*.S, but that
> doesn't consider cache_ops_need_broadcast().
> 
> Will suggests that perhaps ARM 11MPCore might need this due to their I$
> flush maybe not being broadcast

