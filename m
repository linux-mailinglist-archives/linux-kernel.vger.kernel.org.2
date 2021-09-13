Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36A3408AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbhIMMWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239982AbhIMMWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:22:44 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66D7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 05:21:28 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id g11so5854051qvd.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 05:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=F0O/dDyFEM0m44GBFJa7tNSOXNRk6UxJDrE16DOJyOk=;
        b=KNMxA2VqA2UI2588M14DQiYnHum/F0mPCZ99iFPH+bCj9DgnqRoEjRtzjrPef6pY7o
         BJmIA2hM472cP6lWkG4n6x67g8Tv/GdE8xH1ldeD0HCx/OfC/4pWKbq7QN4EI22CYC91
         +oS+jjp8cOVvFfjlvGgkav4OZVE1nk+0ZPgqgI12R/dzwCLI/m8dx3Sf/FjGt7+SovpY
         mYYDeB0Oyy3yrj05yRuZN6nYOF1BM7nF+gvEj3EmU0gdm9L1Jpst4jbSYpD4n/gYsVb7
         4sey4eLc9r88tK2hkNniLBK4ZHa3Co2emd+Kowl4U392ka3HBTwjrOEITze+pdEhJ2hU
         EGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F0O/dDyFEM0m44GBFJa7tNSOXNRk6UxJDrE16DOJyOk=;
        b=o0HB2dkfExVVLCr7FXMX+c++N9q/mwXxwhNX+hJGWT5zGESorALOMctpm9r4D1dmC8
         PpvJ9UGzEk+wYttdF7x2edQkIQcic9j9F62PMuR+DjBrWCy28Je9bYyBewsOZSpnhbBy
         yrNeadOf5KmMNADi4pf+T8cTSwnF6SB9r1501Ysa5SbTzM4GhZeTMKKJWiiSHnoY1KLf
         5W5fyGkCf3AxPMyyYsVyVhhN0ugiqCTaFvspgZiK4D6ZVDTOh7zlhuFAMCWYszOv/Q83
         MYMgb89eJdFno/p1p+aOOJTy6S+pFJwv/iUoIbC5/zNSPjs0i4C2/sNBBuwmvZUQ/K25
         URdQ==
X-Gm-Message-State: AOAM5331vMgN2ZJdN+xiFD9d6DxFR8kHDmvi2fBZi1tJAJkStnvKAh64
        kJfAsAM4p8XV906SBKvj3Rjj
X-Google-Smtp-Source: ABdhPJwibDIAO0VsrQBvNim4iWNsvtJ8x7nuZ1A7wvIcLomCrDEk0Tb8FQgnxX4mKTeI03I46crvOA==
X-Received: by 2002:ad4:4aad:: with SMTP id i13mr8553928qvx.27.1631535687838;
        Mon, 13 Sep 2021 05:21:27 -0700 (PDT)
Received: from [10.28.168.66] ([154.3.44.94])
        by smtp.gmail.com with ESMTPSA id m8sm5019676qkk.130.2021.09.13.05.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 05:21:27 -0700 (PDT)
From:   Darius Rad <darius@bluespec.com>
Subject: Re: [RFC PATCH v8 09/21] riscv: Add task switch support for vector
To:     Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
References: <cover.1631121222.git.greentime.hu@sifive.com>
 <0e65c165e3d54a38cbba01603f325dca727274de.1631121222.git.greentime.hu@sifive.com>
Message-ID: <c81267bc-4c91-3978-8c1f-78925c46c78b@bluespec.com>
Date:   Mon, 13 Sep 2021 08:21:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0e65c165e3d54a38cbba01603f325dca727274de.1631121222.git.greentime.hu@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/21 1:45 PM, Greentime Hu wrote:
> This patch adds task switch support for vector. It supports partial lazy
> save and restore mechanism. It also supports all lengths of vlen.
> 
> [guoren@linux.alibaba.com: First available porting to support vector
> context switching]
> [nick.knight@sifive.com: Rewrite vector.S to support dynamic vlen, xlen and
> code refine]
> [vincent.chen@sifive.co: Fix the might_sleep issue in vstate_save,
> vstate_restore]
> Co-developed-by: Nick Knight <nick.knight@sifive.com>
> Signed-off-by: Nick Knight <nick.knight@sifive.com>
> Co-developed-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>   arch/riscv/include/asm/switch_to.h | 66 +++++++++++++++++++++++
>   arch/riscv/kernel/Makefile         |  1 +
>   arch/riscv/kernel/process.c        | 38 ++++++++++++++
>   arch/riscv/kernel/vector.S         | 84 ++++++++++++++++++++++++++++++
>   4 files changed, 189 insertions(+)
>   create mode 100644 arch/riscv/kernel/vector.S
> 
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index ec83770b3d98..de0573dad78f 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -7,10 +7,12 @@
>   #define _ASM_RISCV_SWITCH_TO_H
>   
>   #include <linux/jump_label.h>
> +#include <linux/slab.h>
>   #include <linux/sched/task_stack.h>
>   #include <asm/processor.h>
>   #include <asm/ptrace.h>
>   #include <asm/csr.h>
> +#include <asm/asm-offsets.h>
>   
>   #ifdef CONFIG_FPU
>   extern void __fstate_save(struct task_struct *save_to);
> @@ -68,6 +70,68 @@ static __always_inline bool has_fpu(void) { return false; }
>   #define __switch_to_fpu(__prev, __next) do { } while (0)
>   #endif
>   
> +#ifdef CONFIG_VECTOR
> +extern bool has_vector;
> +extern unsigned long riscv_vsize;
> +extern void __vstate_save(struct __riscv_v_state *save_to, void *datap);
> +extern void __vstate_restore(struct __riscv_v_state *restore_from, void *datap);
> +
> +static inline void __vstate_clean(struct pt_regs *regs)
> +{
> +	regs->status = (regs->status & ~(SR_VS)) | SR_VS_CLEAN;
> +}
> +
> +static inline void vstate_off(struct task_struct *task,
> +			      struct pt_regs *regs)
> +{
> +	regs->status = (regs->status & ~SR_VS) | SR_VS_OFF;
> +}
> +
> +static inline void vstate_save(struct task_struct *task,
> +			       struct pt_regs *regs)
> +{
> +	if ((regs->status & SR_VS) == SR_VS_DIRTY) {
> +		struct __riscv_v_state *vstate = &(task->thread.vstate);
> +
> +		__vstate_save(vstate, vstate->datap);
> +		__vstate_clean(regs);
> +	}
> +}
> +
> +static inline void vstate_restore(struct task_struct *task,
> +				  struct pt_regs *regs)
> +{
> +	if ((regs->status & SR_VS) != SR_VS_OFF) {
> +		struct __riscv_v_state *vstate = &(task->thread.vstate);
> +
> +		/* Allocate space for vector registers. */
> +		if (!vstate->datap) {
> +			vstate->datap = kzalloc(riscv_vsize, GFP_ATOMIC);
> +			vstate->size = riscv_vsize;
> +		}
> +		__vstate_restore(vstate, vstate->datap);
> +		__vstate_clean(regs);
> +	}
> +}
> +
> +static inline void __switch_to_vector(struct task_struct *prev,
> +				   struct task_struct *next)
> +{
> +	struct pt_regs *regs;
> +
> +	regs = task_pt_regs(prev);
> +	if (unlikely(regs->status & SR_SD))
> +		vstate_save(prev, regs);
> +	vstate_restore(next, task_pt_regs(next));
> +}
> +
> +#else
> +#define has_vector false
> +#define vstate_save(task, regs) do { } while (0)
> +#define vstate_restore(task, regs) do { } while (0)
> +#define __switch_to_vector(__prev, __next) do { } while (0)
> +#endif
> +
>   extern struct task_struct *__switch_to(struct task_struct *,
>   				       struct task_struct *);
>   
> @@ -77,6 +141,8 @@ do {							\
>   	struct task_struct *__next = (next);		\
>   	if (has_fpu())					\
>   		__switch_to_fpu(__prev, __next);	\
> +	if (has_vector)					\
> +		__switch_to_vector(__prev, __next);	\
>   	((last) = __switch_to(__prev, __next));		\
>   } while (0)
>   
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 3397ddac1a30..344078080839 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
>   
>   obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
>   obj-$(CONFIG_FPU)		+= fpu.o
> +obj-$(CONFIG_VECTOR)		+= vector.o
>   obj-$(CONFIG_SMP)		+= smpboot.o
>   obj-$(CONFIG_SMP)		+= smp.o
>   obj-$(CONFIG_SMP)		+= cpu_ops.o
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 03ac3aa611f5..0b86e9e531c9 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -95,6 +95,16 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
>   		 */
>   		fstate_restore(current, regs);
>   	}
> +
> +	if (has_vector) {
> +		regs->status |= SR_VS_INITIAL;
> +		/*
> +		 * Restore the initial value to the vector register
> +		 * before starting the user program.
> +		 */
> +		vstate_restore(current, regs);
> +	}
> +

So this will unconditionally enable vector instructions, and allocate 
memory for vector state, for all processes, regardless of whether vector 
instructions are used?

Given the size of the vector state and potential power and performance 
implications of enabling the vector engine, it seems like this should 
treated similarly to Intel AMX on x86.  The full discussion of that is 
here:

https://lore.kernel.org/lkml/CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org/

The cover letter for recent Intel AMX patches has a summary of the x86 
implementation:

https://lore.kernel.org/lkml/20210825155413.19673-1-chang.seok.bae@intel.com/

If RISC-V were to adopt a similar approach, I think the significant 
points are:

  1. A process (or thread) must specifically request the desire to use
vector extensions (perhaps with some new arch_prctl() API),

  2. The kernel is free to deny permission, perhaps based on 
administrative rules or for other reasons, and

  3. If a process attempts to use vector extensions before doing the 
above, the process will die due to an illegal instruction.


>   	regs->epc = pc;
>   	regs->sp = sp;
>   }
> @@ -110,15 +120,43 @@ void flush_thread(void)
>   	fstate_off(current, task_pt_regs(current));
>   	memset(&current->thread.fstate, 0, sizeof(current->thread.fstate));
>   #endif
> +#ifdef CONFIG_VECTOR
> +	/* Reset vector state */
> +	vstate_off(current, task_pt_regs(current));
> +	memset(&current->thread.vstate, 0, sizeof(current->thread.vstate));
> +#endif
>   }
>   
>   int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>   {
>   	fstate_save(src, task_pt_regs(src));
> +	if (has_vector)
> +		/* To make sure every dirty vector context is saved. */
> +		vstate_save(src, task_pt_regs(src));
>   	*dst = *src;
> +	if (has_vector) {
> +		/* Copy vector context to the forked task from parent. */
> +		if ((task_pt_regs(src)->status & SR_VS) != SR_VS_OFF) {
> +			dst->thread.vstate.datap = kzalloc(riscv_vsize, GFP_KERNEL);
> +			/* Failed to allocate memory. */
> +			if (!dst->thread.vstate.datap)
> +				return -ENOMEM;
> +			/* Copy the src vector context to dst. */
> +			memcpy(dst->thread.vstate.datap,
> +			       src->thread.vstate.datap, riscv_vsize);
> +		}
> +	}
> +
>   	return 0;
>   }
>   
> +void arch_release_task_struct(struct task_struct *tsk)
> +{
> +	/* Free the vector context of datap. */
> +	if (has_vector)
> +		kfree(tsk->thread.vstate.datap);
> +}
> +
>   int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
>   		struct task_struct *p, unsigned long tls)
>   {
> diff --git a/arch/riscv/kernel/vector.S b/arch/riscv/kernel/vector.S
> new file mode 100644
> index 000000000000..4c880b1c32aa
> --- /dev/null
> +++ b/arch/riscv/kernel/vector.S
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2012 Regents of the University of California
> + * Copyright (C) 2017 SiFive
> + * Copyright (C) 2019 Alibaba Group Holding Limited
> + *
> + *   This program is free software; you can redistribute it and/or
> + *   modify it under the terms of the GNU General Public License
> + *   as published by the Free Software Foundation, version 2.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *   GNU General Public License for more details.
> + */
> +
> +#include <linux/linkage.h>
> +
> +#include <asm/asm.h>
> +#include <asm/csr.h>
> +#include <asm/asm-offsets.h>
> +
> +#define vstatep  a0
> +#define datap    a1
> +#define x_vstart t0
> +#define x_vtype  t1
> +#define x_vl     t2
> +#define x_vcsr   t3
> +#define incr     t4
> +#define m_one    t5
> +#define status   t6
> +
> +ENTRY(__vstate_save)
> +	li      status, SR_VS
> +	csrs    sstatus, status
> +
> +	csrr    x_vstart, CSR_VSTART
> +	csrr    x_vtype, CSR_VTYPE
> +	csrr    x_vl, CSR_VL
> +	csrr    x_vcsr, CSR_VCSR
> +	li      m_one, -1
> +	vsetvli incr, m_one, e8, m8
> +	vse8.v   v0, (datap)
> +	add     datap, datap, incr
> +	vse8.v   v8, (datap)
> +	add     datap, datap, incr
> +	vse8.v   v16, (datap)
> +	add     datap, datap, incr
> +	vse8.v   v24, (datap)
> +
> +	REG_S   x_vstart, RISCV_V_STATE_VSTART(vstatep)
> +	REG_S   x_vtype, RISCV_V_STATE_VTYPE(vstatep)
> +	REG_S   x_vl, RISCV_V_STATE_VL(vstatep)
> +	REG_S   x_vcsr, RISCV_V_STATE_VCSR(vstatep)
> +
> +	csrc	sstatus, status
> +	ret
> +ENDPROC(__vstate_save)
> +
> +ENTRY(__vstate_restore)
> +	li      status, SR_VS
> +	csrs    sstatus, status
> +
> +	li      m_one, -1
> +	vsetvli incr, m_one, e8, m8
> +	vle8.v   v0, (datap)
> +	add     datap, datap, incr
> +	vle8.v   v8, (datap)
> +	add     datap, datap, incr
> +	vle8.v   v16, (datap)
> +	add     datap, datap, incr
> +	vle8.v   v24, (datap)
> +
> +	REG_L   x_vstart, RISCV_V_STATE_VSTART(vstatep)
> +	REG_L   x_vtype, RISCV_V_STATE_VTYPE(vstatep)
> +	REG_L   x_vl, RISCV_V_STATE_VL(vstatep)
> +	REG_L   x_vcsr, RISCV_V_STATE_VCSR(vstatep)
> +	vsetvl  x0, x_vl, x_vtype
> +	csrw    CSR_VSTART, x_vstart
> +	csrw    CSR_VCSR, x_vcsr
> +
> +	csrc	sstatus, status
> +	ret
> +ENDPROC(__vstate_restore)
> 
