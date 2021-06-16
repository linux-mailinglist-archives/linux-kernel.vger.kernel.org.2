Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E1C3A90AE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 06:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhFPEit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 00:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhFPEis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 00:38:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B33C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:36:43 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so3205142pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=4m2dd+0KAlT5LpJaa+DedRGeManljjf9yOejn/TMdrY=;
        b=fcUjWSTdc1OF7h+LKvI+SW6XJPSEsYQUhjK6rqUeBjvHrKv9YNmGsUopO5TZH80snW
         jFtbGvGb2ErVoYoRfoG2Dxd7lHMyIkge9uLP8l2Hx97lhT1AJRgy3KowUeCk2dytmrZx
         yP9m/eV6hIOs/GKDtgEjah421cGpPhRdA2pq8dyjuLT3Eb3Og49eMMbje2aiW1Ow+oo9
         WYTQfrsrzqyOzARIPJESXlPm/CdVLXWFenjA6pQg5AwJoCzxmH6hiBIf15FW+roxx75c
         Avb6eJMVU1gKPZewBK3TP3ZMTuL6s+Kp/G7VHb6mLuQavmRcVPKkdftjr92xnbCuSxOe
         tHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=4m2dd+0KAlT5LpJaa+DedRGeManljjf9yOejn/TMdrY=;
        b=gIW/2zF0Hry3syLfm7x8nkmoP7f5tnsDy3PIX5Kxc0E4ZVbeIK5qaBT7J8WuvMZ8xF
         icwHjgtJLZYXFN+/PJSyGx8Hg0BEkf0BRpC4AFQ+5VSBOgTTGPLTAQtbmtwUEcFBTFHX
         8H0PJOiyuR0RR6n2zNwggJ4tM/w0BC4xzMiWFTlFnSCW8/O0tTWNa/PkY/GnhXJqldLt
         CVuA33CdH4vBSPsSNR9XJTfukewZ6Vdj0enEjGvYrNbjUxbyaHVCVgwbGly2Vd1hpl7h
         1LrsCslELET2VQw0uYX6C5u8bF4PzC7tydSxmX47A4ZWoI15n4AS5J+YCIpAkJMBvoqX
         uUeQ==
X-Gm-Message-State: AOAM532BOe+UoOOkxmFqqOCQ+VJQl0jzGgTUg2G/mSmKUk2i1bTWnebT
        uF1ElP8nT3Fh/kS+JF2//Lc=
X-Google-Smtp-Source: ABdhPJzqLenEbcG/d7dt/tltfloS9RqI+xRkYpJkS9mZPlBqv4i9E5MBf7wHTBBXcmjQjNLhVJztXA==
X-Received: by 2002:a17:902:6b09:b029:112:1e7a:a227 with SMTP id o9-20020a1709026b09b02901121e7aa227mr7516516plk.31.1623818203022;
        Tue, 15 Jun 2021 21:36:43 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id i2sm3908261pjj.25.2021.06.15.21.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 21:36:42 -0700 (PDT)
Date:   Wed, 16 Jun 2021 14:36:37 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 6/8] powerpc/membarrier: Remove special barrier on mm
 switch
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1623813516.git.luto@kernel.org>
        <d9034f951329830b766feb08099c15b714e08e8f.1623813516.git.luto@kernel.org>
In-Reply-To: <d9034f951329830b766feb08099c15b714e08e8f.1623813516.git.luto@kernel.org>
MIME-Version: 1.0
Message-Id: <1623817894.lsnlb539ub.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm:
> powerpc did the following on some, but not all, paths through
> switch_mm_irqs_off():
>=20
>        /*
>         * Only need the full barrier when switching between processes.
>         * Barrier when switching from kernel to userspace is not
>         * required here, given that it is implied by mmdrop(). Barrier
>         * when switching from userspace to kernel is not needed after
>         * store to rq->curr.
>         */
>        if (likely(!(atomic_read(&next->membarrier_state) &
>                     (MEMBARRIER_STATE_PRIVATE_EXPEDITED |
>                      MEMBARRIER_STATE_GLOBAL_EXPEDITED)) || !prev))
>                return;
>=20
> This is puzzling: if !prev, then one might expect that we are switching
> from kernel to user, not user to kernel, which is inconsistent with the
> comment.  But this is all nonsense, because the one and only caller would
> never have prev =3D=3D NULL and would, in fact, OOPS if prev =3D=3D NULL.

Yeah that's strange, code definitely doesn't match comment. Good catch.

>=20
> In any event, this code is unnecessary, since the new generic
> membarrier_finish_switch_mm() provides the same barrier without arch help=
.

If that's merged then I think this could be too. I'll do a bit more=20
digging into this too.

Thanks,
Nick

>=20
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/powerpc/include/asm/membarrier.h | 27 ---------------------------
>  arch/powerpc/mm/mmu_context.c         |  2 --
>  2 files changed, 29 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/membarrier.h
>=20
> diff --git a/arch/powerpc/include/asm/membarrier.h b/arch/powerpc/include=
/asm/membarrier.h
> deleted file mode 100644
> index 6e20bb5c74ea..000000000000
> --- a/arch/powerpc/include/asm/membarrier.h
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -#ifndef _ASM_POWERPC_MEMBARRIER_H
> -#define _ASM_POWERPC_MEMBARRIER_H
> -
> -static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
> -					     struct mm_struct *next,
> -					     struct task_struct *tsk)
> -{
> -	/*
> -	 * Only need the full barrier when switching between processes.
> -	 * Barrier when switching from kernel to userspace is not
> -	 * required here, given that it is implied by mmdrop(). Barrier
> -	 * when switching from userspace to kernel is not needed after
> -	 * store to rq->curr.
> -	 */
> -	if (likely(!(atomic_read(&next->membarrier_state) &
> -		     (MEMBARRIER_STATE_PRIVATE_EXPEDITED |
> -		      MEMBARRIER_STATE_GLOBAL_EXPEDITED)) || !prev))
> -		return;
> -
> -	/*
> -	 * The membarrier system call requires a full memory barrier
> -	 * after storing to rq->curr, before going back to user-space.
> -	 */
> -	smp_mb();
> -}
> -
> -#endif /* _ASM_POWERPC_MEMBARRIER_H */
> diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.=
c
> index a857af401738..8daa95b3162b 100644
> --- a/arch/powerpc/mm/mmu_context.c
> +++ b/arch/powerpc/mm/mmu_context.c
> @@ -85,8 +85,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct =
mm_struct *next,
> =20
>  	if (new_on_cpu)
>  		radix_kvm_prefetch_workaround(next);
> -	else
> -		membarrier_arch_switch_mm(prev, next, tsk);
> =20
>  	/*
>  	 * The actual HW switching method differs between the various
> --=20
> 2.31.1
>=20
>=20
