Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAB63A9066
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 06:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhFPEWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 00:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhFPEWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 00:22:01 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B319EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:19:55 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x10so462061plg.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=i6/PtZk/Q02uZ3gR5du7msxxbz/2Mw3VFz8bjOuvYtE=;
        b=mL9z5AWIDtUmQatHsFlpG7uy5j/pVKMKSKE5MTcl2uwzGZGKrEfk/BFAIVCPogPwdA
         1Gy/PN5xn6sFdVb9iLTlf/ddfbgupPq1Jo3umG6aT8NJr5QNTA7ONMVZTJhHnZ4nur5J
         DIb2dgdK4XfSsIP7yxlts3GGcn+LcN2AcIpkTmp9SZB1Le35qnZtQvNT6/UZKffubT3M
         FW/Fk91fkQVYg0Nw+iXfgzPMYvy2piawBfS3HMfOmxZNZ1f+oE5sa9O4H+78W6edMwxh
         wZmfDGCewUT4pUh1uqusP0cGzHv6N7El2nSOq6Hz3ypinnQC+a3/cAj0rpK/v1DgD/pi
         +dUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=i6/PtZk/Q02uZ3gR5du7msxxbz/2Mw3VFz8bjOuvYtE=;
        b=PWvYrfR3AaX18ESgwVX0bmo4tHbx0KDZZbDUmCRaHOlCqCac4SvsUhslHbEG1pw6LD
         R6DQvp2w4gX8zorm7JsJSV+Sb/Q78i2TH4RU9NAUciLjwMnwln0g80oQkKuXUtXd5cco
         DukMTPoIVsfJOmHRWrLc0u8GP6ZvEnm8wPZcSBcH9VwCuQyGYPIb8fWLK/eTSp/UAAV4
         yP/ZFR70CEcJiHPi4+TTz8Smel/DImMe9sXof1q1x0xsLQ75KZ1MOd6d0jdo2ILoJo3d
         S7zDqNXTldtP44YPt4/e+pI4A9n42GaoGNBF39vEq3MxVh6rPK4G3zyCnN4Yh2VGOSgW
         8I2w==
X-Gm-Message-State: AOAM533J/JUx7g+ojjvebKcFnt9/3Aju2Yk/efilvIou/WLL4KRPHrAL
        bLRE8v2Lt4jZrOLoL2AAO4potTaD3as=
X-Google-Smtp-Source: ABdhPJzHI/uZP16lXwCvdWuTEGcYDWlz8hmc92rq/Vq/02mJ9eIDtYbv+iTEjRTYG/Igt2bxethxtA==
X-Received: by 2002:a17:902:eb09:b029:11e:c84d:5f53 with SMTP id l9-20020a170902eb09b029011ec84d5f53mr1080196plb.29.1623817195247;
        Tue, 15 Jun 2021 21:19:55 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id b21sm606663pfp.134.2021.06.15.21.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 21:19:54 -0700 (PDT)
Date:   Wed, 16 Jun 2021 14:19:49 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4/8] membarrier: Make the post-switch-mm barrier explicit
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1623813516.git.luto@kernel.org>
        <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
In-Reply-To: <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
MIME-Version: 1.0
Message-Id: <1623816595.myt8wbkcar.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm:
> membarrier() needs a barrier after any CPU changes mm.  There is currentl=
y
> a comment explaining why this barrier probably exists in all cases.  This
> is very fragile -- any change to the relevant parts of the scheduler
> might get rid of these barriers, and it's not really clear to me that
> the barrier actually exists in all necessary cases.

The comments and barriers in the mmdrop() hunks? I don't see what is=20
fragile or maybe-buggy about this. The barrier definitely exists.

And any change can change anything, that doesn't make it fragile. My
lazy tlb refcounting change avoids the mmdrop in some cases, but it
replaces it with smp_mb for example.

If you have some later changes that require this, can you post them
or move this patch to them?

>=20
> Simplify the logic by adding an explicit barrier, and allow architectures
> to override it as an optimization if they want to.
>=20
> One of the deleted comments in this patch said "It is therefore
> possible to schedule between user->kernel->user threads without
> passing through switch_mm()".  It is possible to do this without, say,
> writing to CR3 on x86, but the core scheduler indeed calls
> switch_mm_irqs_off() to tell the arch code to go back from lazy mode
> to no-lazy mode.

Context switching threads provides a barrier as well, so that comment at=20
least probably stands to be improved.

Thanks,
Nick

>=20
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  include/linux/sched/mm.h | 21 +++++++++++++++++++++
>  kernel/kthread.c         | 12 +-----------
>  kernel/sched/core.c      | 35 +++++++++--------------------------
>  3 files changed, 31 insertions(+), 37 deletions(-)
>=20
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 10aace21d25e..c6eebbafadb0 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -341,6 +341,27 @@ enum {
>  	MEMBARRIER_FLAG_RSEQ		=3D (1U << 1),
>  };
> =20
> +#ifdef CONFIG_MEMBARRIER
> +
> +/*
> + * Called by the core scheduler after calling switch_mm_irqs_off().
> + * Architectures that have implicit barriers when switching mms can
> + * override this as an optimization.
> + */
> +#ifndef membarrier_finish_switch_mm
> +static inline void membarrier_finish_switch_mm(int membarrier_state)
> +{
> +	if (membarrier_state & (MEMBARRIER_STATE_GLOBAL_EXPEDITED | MEMBARRIER_=
STATE_PRIVATE_EXPEDITED))
> +		smp_mb();
> +}
> +#endif
> +
> +#else
> +
> +static inline void membarrier_finish_switch_mm(int membarrier_state) {}
> +
> +#endif
> +
>  #ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
>  #include <asm/membarrier.h>
>  #endif
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index fe3f2a40d61e..8275b415acec 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -1325,25 +1325,15 @@ void kthread_use_mm(struct mm_struct *mm)
>  	tsk->mm =3D mm;
>  	membarrier_update_current_mm(mm);
>  	switch_mm_irqs_off(active_mm, mm, tsk);
> +	membarrier_finish_switch_mm(atomic_read(&mm->membarrier_state));
>  	local_irq_enable();
>  	task_unlock(tsk);
>  #ifdef finish_arch_post_lock_switch
>  	finish_arch_post_lock_switch();
>  #endif
> =20
> -	/*
> -	 * When a kthread starts operating on an address space, the loop
> -	 * in membarrier_{private,global}_expedited() may not observe
> -	 * that tsk->mm, and not issue an IPI. Membarrier requires a
> -	 * memory barrier after storing to tsk->mm, before accessing
> -	 * user-space memory. A full memory barrier for membarrier
> -	 * {PRIVATE,GLOBAL}_EXPEDITED is implicitly provided by
> -	 * mmdrop(), or explicitly with smp_mb().
> -	 */
>  	if (active_mm !=3D mm)
>  		mmdrop(active_mm);
> -	else
> -		smp_mb();
> =20
>  	to_kthread(tsk)->oldfs =3D force_uaccess_begin();
>  }
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e4c122f8bf21..329a6d2a4e13 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4221,15 +4221,6 @@ static struct rq *finish_task_switch(struct task_s=
truct *prev)
> =20
>  	fire_sched_in_preempt_notifiers(current);
> =20
> -	/*
> -	 * When switching through a kernel thread, the loop in
> -	 * membarrier_{private,global}_expedited() may have observed that
> -	 * kernel thread and not issued an IPI. It is therefore possible to
> -	 * schedule between user->kernel->user threads without passing though
> -	 * switch_mm(). Membarrier requires a barrier after storing to
> -	 * rq->curr, before returning to userspace, and mmdrop() provides
> -	 * this barrier.
> -	 */
>  	if (mm)
>  		mmdrop(mm);
> =20
> @@ -4311,15 +4302,14 @@ context_switch(struct rq *rq, struct task_struct =
*prev,
>  			prev->active_mm =3D NULL;
>  	} else {                                        // to user
>  		membarrier_switch_mm(rq, prev->active_mm, next->mm);
> +		switch_mm_irqs_off(prev->active_mm, next->mm, next);
> +
>  		/*
>  		 * sys_membarrier() requires an smp_mb() between setting
> -		 * rq->curr / membarrier_switch_mm() and returning to userspace.
> -		 *
> -		 * The below provides this either through switch_mm(), or in
> -		 * case 'prev->active_mm =3D=3D next->mm' through
> -		 * finish_task_switch()'s mmdrop().
> +		 * rq->curr->mm to a membarrier-enabled mm and returning
> +		 * to userspace.
>  		 */
> -		switch_mm_irqs_off(prev->active_mm, next->mm, next);
> +		membarrier_finish_switch_mm(rq->membarrier_state);
> =20
>  		if (!prev->mm) {                        // from kernel
>  			/* will mmdrop() in finish_task_switch(). */
> @@ -5121,17 +5111,10 @@ static void __sched notrace __schedule(bool preem=
pt)
>  		RCU_INIT_POINTER(rq->curr, next);
>  		/*
>  		 * The membarrier system call requires each architecture
> -		 * to have a full memory barrier after updating
> -		 * rq->curr, before returning to user-space.
> -		 *
> -		 * Here are the schemes providing that barrier on the
> -		 * various architectures:
> -		 * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, PowerPC.
> -		 *   switch_mm() rely on membarrier_arch_switch_mm() on PowerPC.
> -		 * - finish_lock_switch() for weakly-ordered
> -		 *   architectures where spin_unlock is a full barrier,
> -		 * - switch_to() for arm64 (weakly-ordered, spin_unlock
> -		 *   is a RELEASE barrier),
> +		 * to have a full memory barrier before and after updating
> +		 * rq->curr->mm, before returning to userspace.  This
> +		 * is provided by membarrier_finish_switch_mm().  Architectures
> +		 * that want to optimize this can override that function.
>  		 */
>  		++*switch_count;
> =20
> --=20
> 2.31.1
>=20
>=20
