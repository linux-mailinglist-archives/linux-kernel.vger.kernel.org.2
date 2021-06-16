Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBE03A9098
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 06:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhFPE1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 00:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhFPE1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 00:27:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3684C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:25:29 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g4so974266pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=HtWhjzSvrGczulS7njWtHTVAA/C4zqynOF1OpJITXB4=;
        b=elawqkLzfUDMLeB3W/HKJDr59N+knoEjPUHuLuelZINUzcN6T318A9WX/gcXhoMHVD
         Zj0xJ+/PB60HipeHNHctaSD4hsgxg0PdPK7YCsAL786kvi17RcbHvBFugTTt8ze8iewd
         fdQrs5DQ7ryajd7Aaow2ZUthr1KIkMRHkwhY1bzfkp0eICCzVS6jWzRiDYfr63fYpSae
         IZl6gt7L8Z+pAzgLfwU/caWvgsTH7xx/OZdDfcd4L52V8bGvpQuW6304HfZbCGm0ZLAr
         WueQr9lYlJ5j/5vx6dnKcYE7ZdiMJI4pE/IBEJa/KfbWaM3n1SF2FYUvTJy9qwF4CTGt
         botg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=HtWhjzSvrGczulS7njWtHTVAA/C4zqynOF1OpJITXB4=;
        b=aZlSD+mcFEW1Y3MC9n8Kltt397KXnUDR4tab8cXVHZXmqm+EwnIhr40Fyl4Bd7CQ3O
         EG1Dd0AniqJJJkmeK+P/TYjrwGB4IXyqdDCazxML1PtwKch7A9sap/DhMZPOoAAkauhm
         OvsQtnsWEltFcOvnA73QJJmvAcElyH7/G8QUxb7NhXZ1zCKktyOpwEDL7JGF6l7wENQ8
         7y42k0CGNiMGlV2Qtka995qNRYLUQp8lvXNbLGdPzA/tH4M//Jux7akcbD1ozNfSIUhQ
         CYJty8Gnk+OpBB9A9YlqXAIdO9UGWTyj3poAu1yKcRT7uVwHw+nqGjh4kxmQKrJZuSZm
         3MtA==
X-Gm-Message-State: AOAM531VsCMnOfn/3ErDLx6SCaDS++Lmx/VocALpbmqEYO9hagIIhCTR
        koctmg9O2fbpBNEd0R5Xzk4=
X-Google-Smtp-Source: ABdhPJxLw1PC3bHfnCb/Csy5XyrtoqVaxQF4vgGjD0qviJ0XKxSywZwLQ9smb/VDBDSJ1hpk3jcO+A==
X-Received: by 2002:a17:90a:2ac7:: with SMTP id i7mr2932447pjg.139.1623817529118;
        Tue, 15 Jun 2021 21:25:29 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id q4sm629637pfg.3.2021.06.15.21.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 21:25:28 -0700 (PDT)
Date:   Wed, 16 Jun 2021 14:25:23 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/8] x86/mm: Handle unlazying membarrier core sync in the
 arch code
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1623813516.git.luto@kernel.org>
        <571b7e6b6a907e8a1ffc541c3f0005d347406fd0.1623813516.git.luto@kernel.org>
In-Reply-To: <571b7e6b6a907e8a1ffc541c3f0005d347406fd0.1623813516.git.luto@kernel.org>
MIME-Version: 1.0
Message-Id: <1623817261.p1mg6dm2ud.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm:
> The core scheduler isn't a great place for
> membarrier_mm_sync_core_before_usermode() -- the core scheduler
> doesn't actually know whether we are lazy.  With the old code, if a
> CPU is running a membarrier-registered task, goes idle, gets unlazied
> via a TLB shootdown IPI, and switches back to the
> membarrier-registered task, it will do an unnecessary core sync.

I don't really mind, but ARM64 at least hints they might need it
at some point. They can always add it back then, but let's check.

> Conveniently, x86 is the only architecture that does anything in this
> sync_core_before_usermode(), so membarrier_mm_sync_core_before_usermode()
> is a no-op on all other architectures and we can just move the code.

If ARM64 does want it (now or later adds it back), x86 can always make=20
the membarrier_mm_sync_core_before_usermode() a nop with comment=20
explaining where it executes the serializing instruction.

I'm fine with the patch though, except I would leave the comment in the
core sched code saying any arch specific sequence to deal with
SYNC_CORE is required for that case.

Thanks,
Nick

>=20
> (I am not claiming that the SYNC_CORE code was correct before or after th=
is
>  change on any non-x86 architecture.  I merely claim that this change
>  improves readability, is correct on x86, and makes no change on any othe=
r
>  architecture.)
>=20
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/mm/tlb.c        | 53 +++++++++++++++++++++++++++++++---------
>  include/linux/sched/mm.h | 13 ----------
>  kernel/sched/core.c      | 13 ++++------
>  3 files changed, 46 insertions(+), 33 deletions(-)
>=20
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 78804680e923..59488d663e68 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -8,6 +8,7 @@
>  #include <linux/export.h>
>  #include <linux/cpu.h>
>  #include <linux/debugfs.h>
> +#include <linux/sched/mm.h>
> =20
>  #include <asm/tlbflush.h>
>  #include <asm/mmu_context.h>
> @@ -473,16 +474,24 @@ void switch_mm_irqs_off(struct mm_struct *prev, str=
uct mm_struct *next,
>  		this_cpu_write(cpu_tlbstate_shared.is_lazy, false);
> =20
>  	/*
> -	 * The membarrier system call requires a full memory barrier and
> -	 * core serialization before returning to user-space, after
> -	 * storing to rq->curr, when changing mm.  This is because
> -	 * membarrier() sends IPIs to all CPUs that are in the target mm
> -	 * to make them issue memory barriers.  However, if another CPU
> -	 * switches to/from the target mm concurrently with
> -	 * membarrier(), it can cause that CPU not to receive an IPI
> -	 * when it really should issue a memory barrier.  Writing to CR3
> -	 * provides that full memory barrier and core serializing
> -	 * instruction.
> +	 * membarrier() support requires that, when we change rq->curr->mm:
> +	 *
> +	 *  - If next->mm has membarrier registered, a full memory barrier
> +	 *    after writing rq->curr (or rq->curr->mm if we switched the mm
> +	 *    without switching tasks) and before returning to user mode.
> +	 *
> +	 *  - If next->mm has SYNC_CORE registered, then we sync core before
> +	 *    returning to user mode.
> +	 *
> +	 * In the case where prev->mm =3D=3D next->mm, membarrier() uses an IPI
> +	 * instead, and no particular barriers are needed while context
> +	 * switching.
> +	 *
> +	 * x86 gets all of this as a side-effect of writing to CR3 except
> +	 * in the case where we unlazy without flushing.
> +	 *
> +	 * All other architectures are civilized and do all of this implicitly
> +	 * when transitioning from kernel to user mode.
>  	 */
>  	if (real_prev =3D=3D next) {
>  		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=3D
> @@ -500,7 +509,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struc=
t mm_struct *next,
>  		/*
>  		 * If the CPU is not in lazy TLB mode, we are just switching
>  		 * from one thread in a process to another thread in the same
> -		 * process. No TLB flush required.
> +		 * process. No TLB flush or membarrier() synchronization
> +		 * is required.
>  		 */
>  		if (!was_lazy)
>  			return;
> @@ -510,16 +520,35 @@ void switch_mm_irqs_off(struct mm_struct *prev, str=
uct mm_struct *next,
>  		 * If the TLB is up to date, just use it.
>  		 * The barrier synchronizes with the tlb_gen increment in
>  		 * the TLB shootdown code.
> +		 *
> +		 * As a future optimization opportunity, it's plausible
> +		 * that the x86 memory model is strong enough that this
> +		 * smp_mb() isn't needed.
>  		 */
>  		smp_mb();
>  		next_tlb_gen =3D atomic64_read(&next->context.tlb_gen);
>  		if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) =3D=3D
> -				next_tlb_gen)
> +		    next_tlb_gen) {
> +#ifdef CONFIG_MEMBARRIER
> +			/*
> +			 * We switched logical mm but we're not going to
> +			 * write to CR3.  We already did smp_mb() above,
> +			 * but membarrier() might require a sync_core()
> +			 * as well.
> +			 */
> +			if (unlikely(atomic_read(&next->membarrier_state) &
> +				     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE))
> +				sync_core_before_usermode();
> +#endif
> +
>  			return;
> +		}
> =20
>  		/*
>  		 * TLB contents went out of date while we were in lazy
>  		 * mode. Fall through to the TLB switching code below.
> +		 * No need for an explicit membarrier invocation -- the CR3
> +		 * write will serialize.
>  		 */
>  		new_asid =3D prev_asid;
>  		need_flush =3D true;
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index e24b1fe348e3..24d97d1b6252 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -345,16 +345,6 @@ enum {
>  #include <asm/membarrier.h>
>  #endif
> =20
> -static inline void membarrier_mm_sync_core_before_usermode(struct mm_str=
uct *mm)
> -{
> -	if (current->mm !=3D mm)
> -		return;
> -	if (likely(!(atomic_read(&mm->membarrier_state) &
> -		     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE)))
> -		return;
> -	sync_core_before_usermode();
> -}
> -
>  extern void membarrier_exec_mmap(struct mm_struct *mm);
> =20
>  extern void membarrier_update_current_mm(struct mm_struct *next_mm);
> @@ -370,9 +360,6 @@ static inline void membarrier_arch_switch_mm(struct m=
m_struct *prev,
>  static inline void membarrier_exec_mmap(struct mm_struct *mm)
>  {
>  }
> -static inline void membarrier_mm_sync_core_before_usermode(struct mm_str=
uct *mm)
> -{
> -}
>  static inline void membarrier_update_current_mm(struct mm_struct *next_m=
m)
>  {
>  }
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5226cc26a095..e4c122f8bf21 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4220,22 +4220,19 @@ static struct rq *finish_task_switch(struct task_=
struct *prev)
>  	kmap_local_sched_in();
> =20
>  	fire_sched_in_preempt_notifiers(current);
> +
>  	/*
>  	 * When switching through a kernel thread, the loop in
>  	 * membarrier_{private,global}_expedited() may have observed that
>  	 * kernel thread and not issued an IPI. It is therefore possible to
>  	 * schedule between user->kernel->user threads without passing though
>  	 * switch_mm(). Membarrier requires a barrier after storing to
> -	 * rq->curr, before returning to userspace, so provide them here:
> -	 *
> -	 * - a full memory barrier for {PRIVATE,GLOBAL}_EXPEDITED, implicitly
> -	 *   provided by mmdrop(),
> -	 * - a sync_core for SYNC_CORE.
> +	 * rq->curr, before returning to userspace, and mmdrop() provides
> +	 * this barrier.
>  	 */
> -	if (mm) {
> -		membarrier_mm_sync_core_before_usermode(mm);
> +	if (mm)
>  		mmdrop(mm);
> -	}
> +
>  	if (unlikely(prev_state =3D=3D TASK_DEAD)) {
>  		if (prev->sched_class->task_dead)
>  			prev->sched_class->task_dead(prev);
> --=20
> 2.31.1
>=20
>=20
