Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1089E3A9711
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhFPKT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhFPKT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:19:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0896CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wQe7EuPpNIEjNOyKMWIVWWnwyDkUKEff9D3B3wNK/4I=; b=RYUoVHchqZw2eca5irQjshssma
        u9j2VQ1iNaw4tx5lngEeFHvkBtzElTwtYS5VpEid958dE3OinqxvFaicI+hwC79VrAIKSQCLmaw76
        G4EVhj5SayCCg/SUU5GoRl1LEnXXxdwe14IoU90eXf9yYTU0W3faqaSREzRhgVBGet/IPnuoycSzz
        g+fWQbEGv+KxnLmleMhrNIdfw5Yri1crx09c6Ea9adrxGsQNAILjQ1VYwJ9asANbxTGaAdWNMwyZm
        I9h/IIoVvXW2GSTT+V0qHWiwXhanntMEQ/M0S7Y+oQAwuBxqC3rxjFhYXefq7tHJfjIYhCPCHhVHs
        mkUbeBHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltSay-007twI-UT; Wed, 16 Jun 2021 10:16:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CE8CA300269;
        Wed, 16 Jun 2021 12:16:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCA9020277F84; Wed, 16 Jun 2021 12:16:27 +0200 (CEST)
Date:   Wed, 16 Jun 2021 12:16:27 +0200
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
Message-ID: <YMnPezLs6vb418Wz@hirez.programming.kicks-ass.net>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 08:21:12PM -0700, Andy Lutomirski wrote:
> On arm32, the only way to safely flush icache from usermode is to call
> cacheflush(2).  This also handles any required pipeline flushes, so
> membarrier's SYNC_CORE feature is useless on arm.  Remove it.

So SYNC_CORE is there to help an architecture that needs to do something
per CPU. If I$ invalidation is broadcast and I$ invalidation also
triggers the flush of any uarch caches derived from it (if there are
any).

Now arm_syscall() NR(cacheflush) seems to do flush_icache_user_range(),
which, if I read things right, end up in arch/arm/mm/*.S, but that
doesn't consider cache_ops_need_broadcast().

Will suggests that perhaps ARM 11MPCore might need this due to their I$
flush maybe not being broadcast
