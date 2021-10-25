Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA07439400
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 12:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhJYKxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 06:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhJYKxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 06:53:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6221EC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 03:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AtflKn9bp06brgCugEneui+etGBY4mbNQIR0pbDmQoY=; b=BnDJsnSzS7C40GT2l6lSw1Flly
        dTvjtMOemG5ilFsrGuWDohzFH2TRnexni/NDH3DN5j3iYzZb+lhGzKofzOLMv+JOFRL6+rasUc5kV
        q2qR1exopNlvVINuc/xpDbPGPwqgT5GpVsOBALhcBAT05KfXK5rhCQpqb3zlWqKxVPscYne8XWZ59
        ImtU+ciA0EJxWAbOikC/GQ5w0VYMkAcio4X/M22pAcPBCix8HDtKKbZQI44d30Mu1Lz00EJuhW4Ja
        Jnyi6QGA0VmX8MFTefItBSdLqagwJ6NpZr7ItN+P5XJkv5TUQMKz9ZE5vcPVgVkb4U8joTt7CyU19
        x26Hge3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mexYI-00C83t-8s; Mon, 25 Oct 2021 10:50:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D8289300095;
        Mon, 25 Oct 2021 12:50:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB14F26642EE9; Mon, 25 Oct 2021 12:50:00 +0200 (CEST)
Date:   Mon, 25 Oct 2021 12:50:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [PATCH v2 0/5] mm/mprotect: avoid unnecessary TLB flushes
Message-ID: <YXaL2Cq7XI/gQNCZ@hirez.programming.kicks-ass.net>
References: <20211021122112.592634-1-namit@vmware.com>
 <20211021200450.b13499c379a27dbfefe9f5e3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021200450.b13499c379a27dbfefe9f5e3@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 08:04:50PM -0700, Andrew Morton wrote:
> On Thu, 21 Oct 2021 05:21:07 -0700 Nadav Amit <nadav.amit@gmail.com> wrote:
> 
> > This patch-set is intended to remove unnecessary TLB flushes. It is
> > based on feedback from v1 and several bugs I found in v1 myself.
> > 
> > Basically, there are 3 optimizations in this patch-set:
> > 1. Avoiding TLB flushes on change_huge_pmd() that are only needed to
> >    prevent the A/D bits from changing.
> > 2. Use TLB batching infrastructure to batch flushes across VMAs and
> >    do better/fewer flushes.
> > 3. Avoid TLB flushes on permission demotion.
> > 
> > Andrea asked for the aforementioned (2) to come after (3), but this
> > is not simple (specifically since change_prot_numa() needs the number
> > of pages affected).
> 
> [1/5] appears to be a significant fix which should probably be
> backported into -stable kernels.  If you agree with this then I suggest
> it be prepared as a standalone patch, separate from the other four
> patches.  With a cc:stable.

I am confused, 1/5 doesn't actually do *anything*. I also cannot find
any further usage of the introduced X86_BUG_PTE_LEAK.

I'm thinking patch #2 means to have something like:

	if (cpu_feature_enabled(X86_BUG_PTE_LEAK))
		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);

In the newly minted: pmdp_invalidate_ad(), but alas, nothing there.
