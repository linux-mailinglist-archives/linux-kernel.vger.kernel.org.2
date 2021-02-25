Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CA2324C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 09:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhBYIlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 03:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbhBYIlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 03:41:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31386C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 00:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G+01GQRHgNms4G9fglToOhULoGDVmmEVkT36Qkg4cjs=; b=Eu00hKiDI9mkbFIMX4dmRTBmKk
        AWdU7kS2sSAqOk/5jU/4o/Zmi4EqQSOYu1M1hQVfWmm1aGvkUlFlI1QOBqd1QgefOnW8SJ2rTZC+I
        e72DwUBXXsrhqMgLGFekDfcSbXI07vqx4Bv58iyCA2P9mk3Otsi98kTkWo5ABk9Tqn6qkPbYCjU/T
        A+/8sJVpnIzFNhiTzyFR1iTdksTBz4gvgNUwhNn48F2NU090qeHDiAtzhInXMEnXmXmuodzAJKGPS
        kZKL2IXYsVHOnlfQ82holow3Sl7HEKnzGIl8is5MfjUM/ZB65Wc4zZwY4ymyUyD2mFSgWvPpT8c+D
        bTl0/ElA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lFCBt-00ATfr-Ge; Thu, 25 Feb 2021 08:40:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1AAF73010C8;
        Thu, 25 Feb 2021 09:40:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 08EA82023FDE4; Thu, 25 Feb 2021 09:40:08 +0100 (CET)
Date:   Thu, 25 Feb 2021 09:40:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Nadav Amit <namit@vmware.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: Re: [RFC 0/6] x86: prefetch_page() vDSO call
Message-ID: <YDdiZ1SFRrvRPhkR@hirez.programming.kicks-ass.net>
References: <20210225072910.2811795-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225072910.2811795-1-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 11:29:04PM -0800, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Just as applications can use prefetch instructions to overlap
> computations and memory accesses, applications may want to overlap the
> page-faults and compute or overlap the I/O accesses that are required
> for page-faults of different pages.
> 
> Applications can use multiple threads and cores for this matter, by
> running one thread that prefetches the data (i.e., faults in the data)
> and another that does the compute, but this scheme is inefficient. Using
> mincore() can tell whether a page is mapped, but might not tell whether
> the page is in the page-cache and does not fault in the data.
> 
> Introduce prefetch_page() vDSO-call to prefetch, i.e. fault-in memory
> asynchronously. The semantic of this call is: try to prefetch a page of
> in a given address and return zero if the page is accessible following
> the call. Start I/O operations to retrieve the page if such operations
> are required and there is no high memory pressure that might introduce
> slowdowns.
> 
> Note that as usual the page might be paged-out at any point and
> therefore, similarly to mincore(), there is no guarantee that the page
> will be present at the time that the user application uses the data that
> resides on the page. Nevertheless, it is expected that in the vast
> majority of the cases this would not happen, since prefetch_page()
> accesses the page and therefore sets the PTE access-bit (if it is
> clear). 
> 
> The implementation is as follows. The vDSO code accesses the data,
> triggering a page-fault it is not present. The handler detects based on
> the instruction pointer that this is an asynchronous-#PF, using the
> recently introduce vDSO exception tables. If the page can be brought
> without waiting (e.g., the page is already in the page-cache), the
> kernel handles the fault and returns success (zero). If there is memory
> pressure that prevents the proper handling of the fault (i.e., requires
> heavy-weight reclamation) it returns a failure. Otherwise, it starts an
> I/O to bring the page and returns failure.
> 
> Compilers can be extended to issue the prefetch_page() calls when
> needed.

Interesting, but given we've been removing explicit prefetch from some
parts of the kernel how useful is this in actual use? I'm thinking there
should at least be a real user and performance numbers with this before
merging.
