Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA78D39103A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 07:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhEZF6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 01:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbhEZF6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 01:58:16 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F55C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 22:56:45 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f22so23571pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 22:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=2FGHlrjOjpcAf7rkKfXMkdUxLlFSv85QWK25OpBoSRk=;
        b=invCuJh0K1iFVJOdksr323jEaAfu4iZPLHpc3Nf0IdXhodxl71ffFoGbFB+MvG933M
         sIP107sJyvt+Wc42aujofC2p1NewfceN2UM+xGHlAnqdsp1TGqCfZGCK1LdiRUsuLJEy
         sKgspd/2wVfHW9JoULMaOp3eho+95wiy6xpKV6Ho2xBs5dkrOvbOzezhaLkkwQoXGwr+
         ogxBt/rh/+vmNe6ZSqrZDXeLklF4f3ngxA8vfPTPe/JJ8r4ofvWGcBlG1obY7H6Y7IVo
         5uMUZzk7MAEclwNVMMHMBGUwMeoyd4J3QvgHv0/Ae4cytv4o7zX04NONM5HNgTgmahDk
         7Ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=2FGHlrjOjpcAf7rkKfXMkdUxLlFSv85QWK25OpBoSRk=;
        b=D3qUYa3j1gUSFm/50cgDMOXoEOVOkfMP0X/a+o2rFnPCfSmKMFuxTK7qQfiBmApwHB
         Y5tE2xAswTpcEB3sIfEiD6JXuxJ6zpB694LAziIAPYyc9nyfLl81dfMfzyKeGgPWbeE/
         nR3qGfW/w+jGt3dJCSk3yImnFKBjpg2JiC+Qzf2Pk30XLlRcMSW+6d4G6jttrQWRUpmy
         CpmFk9XwXGiQLzhdUMJ3+nbAW49c8WFDbMaeblg9/ECkrZG/+gfTf1uvy5GXsJ4Y0Yfx
         kFFLfj9jBZvQq5a8b816WdMupODCjXlWZj/rIDz+SYE4ZUvjw1xzIKqVcgcZ4zHVlKH5
         6Sfg==
X-Gm-Message-State: AOAM531Vt8jUuM50is2yOFyFTfjNo+U6l22odBI9vYbNTAuOZ3bcYm5g
        od18jXELPSPyziudwbSDiHXpyQ==
X-Google-Smtp-Source: ABdhPJzuxehRoTy2dENPawO5k9iKa7LywWedHDIrTNOvYNgT4ncWRG45MvjRVF3SyscH3X8uYdKPag==
X-Received: by 2002:a62:17cc:0:b029:2de:39c1:7eb7 with SMTP id 195-20020a6217cc0000b02902de39c17eb7mr33668871pfx.26.1622008604543;
        Tue, 25 May 2021 22:56:44 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n23sm15638580pff.93.2021.05.25.22.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 22:56:44 -0700 (PDT)
Date:   Tue, 25 May 2021 22:56:44 -0700 (PDT)
X-Google-Original-Date: Tue, 25 May 2021 22:56:42 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: Turn has_fpu into a static key if FPU=y
In-Reply-To: <20210512225545.6c23d51f@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-ce59aaab-ee8a-4c8f-a563-d3856ef3c35d@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 07:55:45 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> The has_fpu check sits at hot code path: switch_to(). Currently, has_fpu
> is a bool variable if FPU=y, switch_to() checks it each time, we can
> optimize out this check by turning the has_fpu into a static key.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> Since v1:
>  - use static_branch_likely()

Sorry, I missed this one.  I was actually considering pointing that out, 
but I wasn't sure likely was the way to go -- the old code had the save 
code out of line, and the unlikely one did too.

That said, I'm probably just over-thinking it: most machines have FPUs, 
so having the branch as likely seems reasonable.  I've taken this one 
instead.

>  - Improve the commit msg
>
>  arch/riscv/include/asm/switch_to.h | 11 ++++++++---
>  arch/riscv/kernel/cpufeature.c     |  4 ++--
>  arch/riscv/kernel/process.c        |  2 +-
>  arch/riscv/kernel/signal.c         |  4 ++--
>  4 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index 407bcc96a710..0a3f4f95c555 100644
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
> +	return static_branch_likely(&cpu_hwcap_fpu);
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
