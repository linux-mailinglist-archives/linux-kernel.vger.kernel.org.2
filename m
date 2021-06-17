Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4C23AAFB1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhFQJbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhFQJbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:31:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC57C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jlXDPomU3J80b7rZcVaqkAvYVsOqQvPD78Mqg6RhEJs=; b=hmoidzanKUPTg1SDOFE4/t1U3K
        NZdjSb6RhplGpaJ80TK5s6bME7s4mdCBynJ0FaNgFXjhXs5CPKufFZ4/gwMz1zHs2G73rZ8/0blMp
        m8hYHU+txOK0TVdEsKY8p8KgKeXratSilMtsOk5hG2AYMwzWsZWT+zU3/LQUvtc3a7H4ObN8yiSNT
        FNuZOHGU1SOFY/tomZD/Ii4gsyUUwUVcc/IjeuLkJ92+vqZZ3CUvCZRqixAJtEhDGOgDVvXSsDIJ8
        PHbyjkkJ20fU3/HR6kSCEKz1bE6KjPiBrslng20pb+y3cOFSgNEsfGJD3fiakN2jhul+XHb3K/Toz
        rxv+dCSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltoK9-008xx7-E8; Thu, 17 Jun 2021 09:28:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08F19300252;
        Thu, 17 Jun 2021 11:28:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D21F32BF4234C; Thu, 17 Jun 2021 11:28:30 +0200 (CEST)
Date:   Thu, 17 Jun 2021 11:28:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [RFC][PATCH] sched: Use lightweight hazard pointers to grab lazy
 mms
Message-ID: <YMsVvsMRJ2yKf1WM@hirez.programming.kicks-ass.net>
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
 <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
 <1623893358.bbty474jyy.astroid@bobo.none>
 <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
 <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
 <YMsQ82bzly2KAUsu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMsQ82bzly2KAUsu@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:08:03AM +0200, Peter Zijlstra wrote:

> diff --git a/kernel/fork.c b/kernel/fork.c
> index e595e77913eb..57415cca088c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1104,6 +1104,8 @@ static inline void __mmput(struct mm_struct *mm)
>  	}
>  	if (mm->binfmt)
>  		module_put(mm->binfmt->module);
> +
> +	mm_unlazy_mm_count(mm);
>  	mmdrop(mm);
>  }
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8ac693d542f6..e102ec53c2f6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -19,6 +19,7 @@

> +/*
> + * This converts all lazy_mm references to mm to mm_count refcounts.  Our
> + * caller holds an mm_count reference, so we don't need to worry about mm
> + * being freed out from under us.
> + */
> +void mm_unlazy_mm_count(struct mm_struct *mm)
> +{
> +	unsigned int drop_count = num_possible_cpus();
> +	int cpu;
> +
> +	/*
> +	 * mm_users is zero, so no cpu will set its rq->lazy_mm to mm.
> +	 */
> +	WARN_ON_ONCE(atomic_read(&mm->mm_users) != 0);
> +
> +	/* Grab enough references for the rest of this function. */
> +	atomic_add(drop_count, &mm->mm_count);

So that had me puzzled for a little while. Would something like this be
a better comment?

	/*
	 * Because this can race with mmdrop_lazy(), mm_count must be
	 * incremented before setting any rq->drop_mm value, otherwise
	 * it is possible to free mm early.
	 */

> +
> +	for_each_possible_lazymm_cpu(cpu, mm) {
> +		struct rq *rq = cpu_rq(cpu);
> +		struct mm_struct *old_mm;
> +
> +		if (smp_load_acquire(&rq->lazy_mm) != mm)
> +			continue;
> +
> +		drop_count--;	/* grab a reference; cpu will drop it later. */

Totally confusing comment that :-)

> +

And with that, we rely on xchg() here to be at at least RELEASE, such
that that mm_count increment must be visible when drop_mm is seen.

> +		old_mm = xchg(&rq->drop_mm, mm);

Similarly, we rely on it being at least ACQUIRE for the !NULL return
case I think.

> +
> +		/*
> +		 * We know that old_mm != mm: when we did the xchg(), we were
> +		 * the only cpu to be putting mm into any drop_mm variable.
> +		 */
> +		WARN_ON_ONCE(old_mm == mm);
> +		if (unlikely(old_mm)) {
> +			/*
> +			 * We just stole an mm reference from the target CPU.
> +			 *
> +			 * drop_mm was set to old by another call to
> +			 * mm_unlazy_mm_count().  After that call xchg'd old
> +			 * into drop_mm, the target CPU did:
> +			 *
> +			 *  smp_store_release(&rq->lazy_mm, mm);
> +			 *
> +			 * which synchronized with our smp_load_acquire()
> +			 * above, so we know that the target CPU is done with
> +			 * old. Drop old on its behalf.
> +			 */
> +			mmdrop(old_mm);
> +		}
> +	}
> +
> +	atomic_sub(drop_count, &mm->mm_count);
> +}



