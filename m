Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA9391003
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 07:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhEZFeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 01:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhEZFdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 01:33:55 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61093C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 22:32:10 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f22so139755pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 22:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=qc3ScWmCNnasw4nROjWuKMgrAOjs/3VPUms2nMn4scQ=;
        b=XqmpLFtRqwdITCAzv0wYvQM9A5dzaPYw9F0mfoZpPxfht3fb8VVOHKkrZKfXwcCCEX
         xT+tpdiZWMw2kD8UIUa6gw5iAcEOr+WJFoGiGG/W4Sn/U7mZlpUOlmTG1P/uP05bbkUR
         UmPPvashiVGlqvicGCe/+xFxrT01g3L7rGLZRe7QFjNCuMwePfwvICMIXzewM0R+WV42
         8IiqL5INIEfItwhVaIgr9GMykcclEwTgj+bvmg69wyr0yIe90IbgLPQtr9rJ/KwwqxJ3
         HWJud6IYJA4A6xny254gSvobfmX978sXd5zgZVUdmDuhUN9es/UDJZOyakqI5SVVZ8xz
         vmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qc3ScWmCNnasw4nROjWuKMgrAOjs/3VPUms2nMn4scQ=;
        b=oPy1SRtkwRfux8fMsd4E0dhDlmlyx5Oa0r7f+zsoZzfrrrPgDcnVhxmdmjVThB4ZPB
         pPDEQQRIEK2oYgSLwYomM2U705tXfBaH+5Wa4Ho+FqhAmOsyxq+F1bTUA1vPOvpAMBid
         siA5LhU42pAKCovuV7CI1NF44SKqmDo2/urbGFM7sw3ekw+N19YGIR65yQlI2cIeG6Cc
         PBjIQN1r+5dhgDOHlH/9333mmI2jD4/5h5XGaGdjCrj6wjvKfx78A+VFR80amE5lZch5
         5qNcfsPWgf6GSyZgo1E9IiBg/RNQUyFktnvjRHkCFDvc15hF4Vt1Gr1H6T4QFIO3qAAs
         ZckA==
X-Gm-Message-State: AOAM531TvwJWwwicZES+7t7LUnezO8byiSuXGoCQW7LtpJOvEBdfPV5o
        n6utZXj5wmHLGYTgUFG80z7Qog==
X-Google-Smtp-Source: ABdhPJyhkNeQUGt+23cOlj65ptSKxKDlz580W3BDZBkGsjAFdckDp9WZfwF3sgzh6mVQrdBB8HPBQw==
X-Received: by 2002:a65:61a8:: with SMTP id i8mr22930126pgv.271.1622007129710;
        Tue, 25 May 2021 22:32:09 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t12sm3289150pjw.57.2021.05.25.22.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 22:32:09 -0700 (PDT)
Date:   Tue, 25 May 2021 22:32:09 -0700 (PDT)
X-Google-Original-Date: Tue, 25 May 2021 22:32:06 PDT (-0700)
Subject:     Re: [PATCH] riscv: Turn has_fpu into a static key if FPU
In-Reply-To: <20210512020152.200a182d@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-b76d372f-5cc3-409d-bbab-7b8cb9f9199e@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 11:01:52 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> The has_fpu check sits at hot code path: switch_to(). Currently, has_fpu
> is a bool variable if FPU, switch_to() checks it each time, we can
> optimize out this check by turning the has_fpu into a static key.
>
> Before the patch:
> 	...
> 	ccc7c783		lbu     a5,-820(a5) # ffffffff80cab098 <has_fpu>
> 	e3b5			bnez    a5,ffffffff8031a438 <__schedule+0x232>
> 	...
>
> After the patch:
> If FPU isn't supported:
> 	...
> 	00000013		nop
> 	...
>
> If FPU is supported:
> 	...
> 	0540006f                j       ffffffff8031a418 <__schedule+0x21a>
> 	...
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/switch_to.h | 11 ++++++++---
>  arch/riscv/kernel/cpufeature.c     |  4 ++--
>  arch/riscv/kernel/process.c        |  2 +-
>  arch/riscv/kernel/signal.c         |  4 ++--
>  4 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index 407bcc96a710..ea25ccb7785e 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -6,6 +6,7 @@
>  #ifndef _ASM_RISCV_SWITCH_TO_H
>  #define _ASM_RISCV_SWITCH_TO_H
>
> +#include <linux/jump_label.h>
>  #include <linux/sched/task_stack.h>
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
> @@ -55,9 +56,13 @@ static inline void __switch_to_aux(struct task_struct *prev,
>  	fstate_restore(next, task_pt_regs(next));
>  }
>
> -extern bool has_fpu;
> +extern struct static_key_false cpu_hwcap_fpu;
> +static __always_inline bool has_fpu(void)
> +{
> +	return static_branch_unlikely(&cpu_hwcap_fpu);
> +}
>  #else
> -#define has_fpu false
> +static __always_inline bool has_fpu(void) { return false; }
>  #define fstate_save(task, regs) do { } while (0)
>  #define fstate_restore(task, regs) do { } while (0)
>  #define __switch_to_aux(__prev, __next) do { } while (0)
> @@ -70,7 +75,7 @@ extern struct task_struct *__switch_to(struct task_struct *,
>  do {							\
>  	struct task_struct *__prev = (prev);		\
>  	struct task_struct *__next = (next);		\
> -	if (has_fpu)					\
> +	if (has_fpu())					\
>  		__switch_to_aux(__prev, __next);	\
>  	((last) = __switch_to(__prev, __next));		\
>  } while (0)
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index ac202f44a670..a2848dc36927 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -19,7 +19,7 @@ unsigned long elf_hwcap __read_mostly;
>  static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>
>  #ifdef CONFIG_FPU
> -bool has_fpu __read_mostly;
> +__ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
>  #endif
>
>  /**
> @@ -146,6 +146,6 @@ void riscv_fill_hwcap(void)
>
>  #ifdef CONFIG_FPU
>  	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
> -		has_fpu = true;
> +		static_branch_enable(&cpu_hwcap_fpu);
>  #endif
>  }
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index f9cd57c9c67d..03ac3aa611f5 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -87,7 +87,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
>  	unsigned long sp)
>  {
>  	regs->status = SR_PIE;
> -	if (has_fpu) {
> +	if (has_fpu()) {
>  		regs->status |= SR_FS_INITIAL;
>  		/*
>  		 * Restore the initial value to the FP register
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index 65942b3748b4..c2d5ecbe5526 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -90,7 +90,7 @@ static long restore_sigcontext(struct pt_regs *regs,
>  	/* sc_regs is structured the same as the start of pt_regs */
>  	err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
>  	/* Restore the floating-point state. */
> -	if (has_fpu)
> +	if (has_fpu())
>  		err |= restore_fp_state(regs, &sc->sc_fpregs);
>  	return err;
>  }
> @@ -143,7 +143,7 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
>  	/* sc_regs is structured the same as the start of pt_regs */
>  	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
>  	/* Save the floating-point state. */
> -	if (has_fpu)
> +	if (has_fpu())
>  		err |= save_fp_state(regs, &sc->sc_fpregs);
>  	return err;
>  }

Thanks, this is on for-next.
