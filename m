Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C1831E80B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhBRJ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhBRIRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:17:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFF6C061786
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 00:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u5vWM62XM8rLK2sqe8M5iVEY7D5xM2DiSE3Ouqp2Hb0=; b=ZzGJkQIFkEhYQfLXiSgclkToCz
        mMZb0I8ZCvlplD9MvUQmRZC7jEIGMOoSwvKj9TrBxNFbs3mK+tTeCL/m5jXyKnXArFNvo1QXcrVI5
        TNLjvRoWldPAAo1Sau6EvvPsUGQiUvGC12qzDn002aMbYvTwdMO89v2zs74P9Qj0r+zeLBjj44LFn
        AZTmrR0glro3OwXCAC9h0qCOKaWLqRwpz7xMJzr0AODqzesvvLn7t9CNFl0+VlntEVKeQeFORhio2
        BFZzGBKh7Zto9iP2iR9bitFlXctyI6qJZ5v81CPv5i0Ar5Gwgpyl4sJTbIxAemZ8FCpyF3F+Mfeek
        Lhhm+8fA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCeU4-001Pqj-0x; Thu, 18 Feb 2021 08:16:24 +0000
Date:   Thu, 18 Feb 2021 08:16:24 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 3/8] x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
 tlb_is_not_lazy()
Message-ID: <20210218081624.GA337128@infradead.org>
References: <20210209221653.614098-1-namit@vmware.com>
 <20210209221653.614098-4-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209221653.614098-4-namit@vmware.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 02:16:48PM -0800, Nadav Amit wrote:
> +		/*
> +		 * Although we could have used on_each_cpu_cond_mask(),
> +		 * open-coding it has performance advantages, as it eliminates
> +		 * the need for indirect calls or retpolines. In addition, it
> +		 * allows to use a designated cpumask for evaluating the
> +		 * condition, instead of allocating one.
> +		 *
> +		 * This code works under the assumption that there are no nested
> +		 * TLB flushes, an assumption that is already made in
> +		 * flush_tlb_mm_range().
> +		 *
> +		 * cond_cpumask is logically a stack-local variable, but it is
> +		 * more efficient to have it off the stack and not to allocate
> +		 * it on demand. Preemption is disabled and this code is
> +		 * non-reentrant.
> +		 */
> +		struct cpumask *cond_cpumask = this_cpu_ptr(&flush_tlb_mask);
> +		int cpu;
> +
> +		cpumask_clear(cond_cpumask);
> +
> +		for_each_cpu(cpu, cpumask) {
> +			if (tlb_is_not_lazy(cpu))
> +				__cpumask_set_cpu(cpu, cond_cpumask);
> +		}
> +		smp_call_function_many(cond_cpumask, flush_tlb_func, (void *)info, 1);

No need for the cast here, which would also avoid the pointlessly
overly long line.
