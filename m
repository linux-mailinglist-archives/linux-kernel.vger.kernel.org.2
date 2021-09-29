Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1047141C43F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245570AbhI2MFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245233AbhI2MFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:05:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA7AC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 05:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nxuwC5keF0YAJ+9TMPm1V+6kgV73HkecEcFmN5syikc=; b=nMHFn74Swm87dMOfle191PVisj
        0Lh3EaxCXloFduk+daCTxkB9sWcSMm+jGZV7x7VbmkYMzwglq1YbL7oHd0XP9OWcO0z5h81ThRoe7
        dryaYuJThyza5xOFdHA7XCl2VEQHdOvSgLV0wONQQD35G0Pr0rZxceLZZsdUEb2PpQvON97a9dWm4
        OV0My/2pazSC20DOP9mVpRsPtn6hrXLdV6p7mouW8t8elc9SNzWptk7mSO5gr13aHqU1pT7olr4AQ
        a22cTBQwg4lNnLmclEIa5PuC1q6GSeec5LwJsLfMrEqegMxtEJobiWeMdYAX3sZqUoQgsEEJSPQy5
        fynIP/Qg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVYIE-00Bo62-WF; Wed, 29 Sep 2021 12:02:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EA8D30026F;
        Wed, 29 Sep 2021 14:02:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 320FA2DCC564E; Wed, 29 Sep 2021 14:02:34 +0200 (CEST)
Date:   Wed, 29 Sep 2021 14:02:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch 5/5] sched: Move mmdrop to RCU on RT
Message-ID: <YVRV2jhVIbGxd+JB@hirez.programming.kicks-ass.net>
References: <20210928122339.502270600@linutronix.de>
 <20210928122411.648582026@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928122411.648582026@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 02:24:32PM +0200, Thomas Gleixner wrote:

> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -49,6 +49,26 @@ static inline void mmdrop(struct mm_stru
>  		__mmdrop(mm);
>  }
>  
> +#ifdef CONFIG_PREEMPT_RT
> +extern void __mmdrop_delayed(struct rcu_head *rhp);
> +
> +/*
> + * Invoked from finish_task_switch(). Delegates the heavy lifting on RT
> + * kernels via RCU.
> + */
> +static inline void mmdrop_sched(struct mm_struct *mm)
> +{
> +	/* Provides a full memory barrier. See mmdrop() */
> +	if (atomic_dec_and_test(&mm->mm_count))
> +		call_rcu(&mm->delayed_drop, __mmdrop_delayed);
> +}
> +#else
> +static inline void mmdrop_sched(struct mm_struct *mm)
> +{
> +	mmdrop(mm);
> +}
> +#endif
> +
>  /**
>   * mmget() - Pin the address space associated with a &struct mm_struct.
>   * @mm: The address space to pin.
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -708,6 +708,19 @@ void __mmdrop(struct mm_struct *mm)
>  }
>  EXPORT_SYMBOL_GPL(__mmdrop);
>  
> +#ifdef CONFIG_PREEMPT_RT
> +/*
> + * RCU callback for delayed mm drop. Not strictly RCU, but call_rcu() is
> + * by far the least expensive way to do that.
> + */
> +void __mmdrop_delayed(struct rcu_head *rhp)
> +{
> +	struct mm_struct *mm = container_of(rhp, struct mm_struct, delayed_drop);
> +
> +	__mmdrop(mm);
> +}
> +#endif

Would you mind terribly if I fold this into mm.h as a static inline ?

The only risk that carries is that if mmdrop_sched() is called from
multiple translation units (it is not) we get multiple instances of this
function, but possibly even !LTO linkers can fix that for us.

