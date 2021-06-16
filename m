Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF5A3A909F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 06:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhFPEbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 00:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhFPEbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 00:31:05 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8F0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:29:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id e22so901856pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=0VlXn6eNtJ2rv/9waXMUs/dR5ttTe7hDArinhwqlMyU=;
        b=LuXEXas8OkAoy841Vh6ey6b5g6z04AeA5ZUrboM9WGUDTnd7YMIha/6qLEIy7E+74s
         R11Nw5McnLP+us9UM03ZepRHFyXr4ceCUlm7dlrJ0bDqotPatc9ZZiBMENGbOpvtTe04
         pJ9REHZIPfxzyuppCk+QeZp2O47XwQX/Ak4HOxyA3RgR0UkxoAdndaJ/78XtsMeIIP7Q
         XdHWeHUmuUS/HtsKKiyamI8pUSZ+MbYdRIQ2KMSzPSJgdFz/VVLp17Wj5YCq6MdXRmr3
         7nOaHCPA5/1Geef85GRzpudSins/nRBu/jLgt/CwSVCQI+B051SLVKk5qhnoacUjzF20
         4vWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=0VlXn6eNtJ2rv/9waXMUs/dR5ttTe7hDArinhwqlMyU=;
        b=A93gK+n1NI07LNkKOUxDOYhEeS8zy9z/f505DfsHWVV0GC5fBDhv5EDaz1ALqGj2kF
         2WxI/D/xF3ne8hLDRRClsMBHQvTdxe2Doh2VJzS53a1ut2Hi28wZX5cu895+eN1sJtK2
         xtUWTFPqarWEkhKORk8EgOmhF4Dp72Mvr2cNgI4acO/9x1A92kDh9ObM7DgqOipe9791
         9u/hON6+fYkRJO9atAKUCbBdDFjrdYNsefo0li4rXDMIkTkwRuVAgqRQiAkxtohgSTwY
         YrJMEAp7btvgsL66nG9AOy950efULOVNscu6aDjyXOMIdKE2ayToYmsAZ+BuJ3j3K2Ac
         TDcQ==
X-Gm-Message-State: AOAM5328IpU90QO2grkfb/EGjLbEOtXwUmb/Q4kvmEUGPqgRZs9V4tSh
        lbzWK6jYJgR5uzEmsQOFxlk=
X-Google-Smtp-Source: ABdhPJwCYt2fZOdlxQrGb+wXR8l7zOMMVJHylHpB+Q77ybLHnhrz3I2zaktWMawRX3CLYErDiPRuww==
X-Received: by 2002:a63:ff1f:: with SMTP id k31mr2988191pgi.315.1623817739711;
        Tue, 15 Jun 2021 21:28:59 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id f28sm694974pgb.12.2021.06.15.21.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 21:28:59 -0700 (PDT)
Date:   Wed, 16 Jun 2021 14:28:54 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 5/8] membarrier, kthread: Use _ONCE accessors for task->mm
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1623813516.git.luto@kernel.org>
        <74ace142f48db7d0e71b05b5ace72bfe8e0a2652.1623813516.git.luto@kernel.org>
In-Reply-To: <74ace142f48db7d0e71b05b5ace72bfe8e0a2652.1623813516.git.luto@kernel.org>
MIME-Version: 1.0
Message-Id: <1623817648.jh19a97b5a.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm:
> membarrier reads cpu_rq(remote cpu)->curr->mm without locking.  Use
> READ_ONCE() and WRITE_ONCE() to remove the data races.
>=20
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  fs/exec.c                 | 2 +-
>  kernel/kthread.c          | 4 ++--
>  kernel/sched/membarrier.c | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/exec.c b/fs/exec.c
> index 18594f11c31f..2e63dea83411 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1007,7 +1007,7 @@ static int exec_mmap(struct mm_struct *mm)
>  	local_irq_disable();
>  	active_mm =3D tsk->active_mm;
>  	tsk->active_mm =3D mm;
> -	tsk->mm =3D mm;
> +	WRITE_ONCE(tsk->mm, mm);  /* membarrier reads this without locks */
>  	/*
>  	 * This prevents preemption while active_mm is being loaded and
>  	 * it and mm are being updated, which could cause problems for
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 8275b415acec..4962794e02d5 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -1322,7 +1322,7 @@ void kthread_use_mm(struct mm_struct *mm)
>  		mmgrab(mm);
>  		tsk->active_mm =3D mm;
>  	}
> -	tsk->mm =3D mm;
> +	WRITE_ONCE(tsk->mm, mm);  /* membarrier reads this without locks */
>  	membarrier_update_current_mm(mm);
>  	switch_mm_irqs_off(active_mm, mm, tsk);
>  	membarrier_finish_switch_mm(atomic_read(&mm->membarrier_state));
> @@ -1363,7 +1363,7 @@ void kthread_unuse_mm(struct mm_struct *mm)
>  	smp_mb__after_spinlock();
>  	sync_mm_rss(mm);
>  	local_irq_disable();
> -	tsk->mm =3D NULL;
> +	WRITE_ONCE(tsk->mm, NULL);  /* membarrier reads this without locks */
>  	membarrier_update_current_mm(NULL);
>  	/* active_mm is still 'mm' */
>  	enter_lazy_tlb(mm, tsk);
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index 3173b063d358..c32c32a2441e 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -410,7 +410,7 @@ static int membarrier_private_expedited(int flags, in=
t cpu_id)
>  			goto out;
>  		rcu_read_lock();
>  		p =3D rcu_dereference(cpu_rq(cpu_id)->curr);
> -		if (!p || p->mm !=3D mm) {
> +		if (!p || READ_ONCE(p->mm) !=3D mm) {
>  			rcu_read_unlock();
>  			goto out;
>  		}
> @@ -423,7 +423,7 @@ static int membarrier_private_expedited(int flags, in=
t cpu_id)
>  			struct task_struct *p;
> =20
>  			p =3D rcu_dereference(cpu_rq(cpu)->curr);
> -			if (p && p->mm =3D=3D mm)
> +			if (p && READ_ONCE(p->mm) =3D=3D mm)

/* exec, kthread_use_mm write this without locks */ ?

Seems good to me.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

>  				__cpumask_set_cpu(cpu, tmpmask);
>  		}
>  		rcu_read_unlock();
> @@ -521,7 +521,7 @@ static int sync_runqueues_membarrier_state(struct mm_=
struct *mm)
>  		struct task_struct *p;
> =20
>  		p =3D rcu_dereference(rq->curr);
> -		if (p && p->mm =3D=3D mm)
> +		if (p && READ_ONCE(p->mm) =3D=3D mm)
>  			__cpumask_set_cpu(cpu, tmpmask);
>  	}
>  	rcu_read_unlock();
> --=20
> 2.31.1
>=20
>=20
