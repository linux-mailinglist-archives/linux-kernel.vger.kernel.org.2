Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7673C40C777
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbhIOOcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbhIOOcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:32:50 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93CECC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=klzs1tYjzupJFTbvmrtRCSiuF++kdvsrPO
        lrBmiB/64=; b=SkeyUn/gti302b1GIWy5aWgXIHOPHX+oEgUz4hOj/wokCIcd4y
        rPKN3RczNIreqog6hRSU1Y3NEarX5ycf8W2czyBh7wWdWc9T56if1qbjFaBJxv8l
        6a7m6ThnVvyslGQTKD6z8b5rdM0CNF7In9yqnGq1/umTpPsJLCBq42/kk=
Received: from xhacker (unknown [101.86.20.138])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygC38qm7A0JhjssBAA--.1007S2;
        Wed, 15 Sep 2021 22:31:23 +0800 (CST)
Date:   Wed, 15 Sep 2021 22:24:56 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: Re: [RFC PATCH v8 21/21] riscv: Turn has_vector into a static key
 if VECTOR=y
Message-ID: <20210915222456.1de541df@xhacker>
In-Reply-To: <56e2328d133045c79b420ecbcaf37cf9d0b2248c.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
        <56e2328d133045c79b420ecbcaf37cf9d0b2248c.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygC38qm7A0JhjssBAA--.1007S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF48Jr1fAFyfJFyfKrykZrb_yoWxGr47pr
        WqkFnxXrWUArs2ga43Janrur45J3s7Ww13Krn8Ja4rCrWrKr98J3WkXryjvF45WF1F9w1f
        CasFkr1Skw47JFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyIb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
        6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7eOJUUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Sep 2021 01:45:33 +0800
Greentime Hu <greentime.hu@sifive.com> wrote:

> Just like fpu, we can use static key for has_vector.
> The has_vector check sits at hot code path: switch_to(). Currently,
> has_vector is a bool variable if VECTOR=y, switch_to() checks it each time,
> we can optimize out this check by turning the has_vector into a static key.
> 

has_vector is newly introduced in this patch set so I believe this patch can
be folded into has_vector introducing patch, I.E patch 6


> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/include/asm/switch_to.h     | 10 +++++++---
>  arch/riscv/kernel/cpufeature.c         |  4 ++--
>  arch/riscv/kernel/kernel_mode_vector.c |  4 ++--
>  arch/riscv/kernel/process.c            |  8 ++++----
>  arch/riscv/kernel/signal.c             |  6 +++---
>  5 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index b48c9c974564..576204217e0f 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -71,7 +71,11 @@ static __always_inline bool has_fpu(void) { return false; }
>  #endif
>  
>  #ifdef CONFIG_VECTOR
> -extern bool has_vector;
> +extern struct static_key_false cpu_hwcap_vector;
> +static __always_inline bool has_vector(void)
> +{
> +	return static_branch_likely(&cpu_hwcap_vector);
> +}
>  extern unsigned long riscv_vsize;
>  extern void __vstate_save(struct __riscv_v_state *save_to, void *datap);
>  extern void __vstate_restore(struct __riscv_v_state *restore_from, void *datap);
> @@ -120,7 +124,7 @@ static inline void __switch_to_vector(struct task_struct *prev,
>  }
>  
>  #else
> -#define has_vector false
> +static __always_inline bool has_vector(void) { return false; }
>  #define riscv_vsize (0)
>  #define vstate_save(task, regs) do { } while (0)
>  #define vstate_restore(task, regs) do { } while (0)
> @@ -136,7 +140,7 @@ do {							\
>  	struct task_struct *__next = (next);		\
>  	if (has_fpu())					\
>  		__switch_to_fpu(__prev, __next);	\
> -	if (has_vector)					\
> +	if (has_vector())					\
>  		__switch_to_vector(__prev, __next);	\
>  	((last) = __switch_to(__prev, __next));		\
>  } while (0)
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index af984f875f60..0139ec20adce 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -23,7 +23,7 @@ __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
>  #endif
>  #ifdef CONFIG_VECTOR
>  #include <asm/vector.h>
> -bool has_vector __read_mostly;
> +__ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_vector);
>  unsigned long riscv_vsize __read_mostly;
>  #endif
>  
> @@ -157,7 +157,7 @@ void __init riscv_fill_hwcap(void)
>  
>  #ifdef CONFIG_VECTOR
>  	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
> -		has_vector = true;
> +		static_branch_enable(&cpu_hwcap_vector);
>  		/* There are 32 vector registers with vlenb length. */
>  		rvv_enable();
>  		riscv_vsize = csr_read(CSR_VLENB) * 32;
> diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
> index 0d990bd8b8dd..0d08954c30af 100644
> --- a/arch/riscv/kernel/kernel_mode_vector.c
> +++ b/arch/riscv/kernel/kernel_mode_vector.c
> @@ -110,7 +110,7 @@ static void vector_flush_cpu_state(void)
>   */
>  void kernel_rvv_begin(void)
>  {
> -	if (WARN_ON(!has_vector))
> +	if (WARN_ON(!has_vector()))
>  		return;
>  
>  	WARN_ON(!may_use_vector());
> @@ -140,7 +140,7 @@ EXPORT_SYMBOL(kernel_rvv_begin);
>   */
>  void kernel_rvv_end(void)
>  {
> -	if (WARN_ON(!has_vector))
> +	if (WARN_ON(!has_vector()))
>  		return;
>  
>  	/* Invalidate vector regs */
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 05ff5f934e7e..62540815ba1c 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -96,7 +96,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
>  		fstate_restore(current, regs);
>  	}
>  
> -	if (has_vector) {
> +	if (has_vector()) {
>  		struct __riscv_v_state *vstate = &(current->thread.vstate);
>  
>  		/* Enable vector and allocate memory for vector registers. */
> @@ -141,11 +141,11 @@ void flush_thread(void)
>  int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  {
>  	fstate_save(src, task_pt_regs(src));
> -	if (has_vector)
> +	if (has_vector())
>  		/* To make sure every dirty vector context is saved. */
>  		vstate_save(src, task_pt_regs(src));
>  	*dst = *src;
> -	if (has_vector) {
> +	if (has_vector()) {
>  		/* Copy vector context to the forked task from parent. */
>  		if ((task_pt_regs(src)->status & SR_VS) != SR_VS_OFF) {
>  			dst->thread.vstate.datap = kzalloc(riscv_vsize, GFP_KERNEL);
> @@ -164,7 +164,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  void arch_release_task_struct(struct task_struct *tsk)
>  {
>  	/* Free the vector context of datap. */
> -	if (has_vector)
> +	if (has_vector())
>  		kfree(tsk->thread.vstate.datap);
>  }
>  
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index d30a3b588156..6a19b4b7b206 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -192,7 +192,7 @@ static long restore_sigcontext(struct pt_regs *regs,
>  				goto invalid;
>  			goto done;
>  		case RVV_MAGIC:
> -			if (!has_vector)
> +			if (!has_vector())
>  				goto invalid;
>  			if (size != rvv_sc_size)
>  				goto invalid;
> @@ -221,7 +221,7 @@ static size_t cal_rt_frame_size(void)
>  
>  	frame_size = sizeof(*frame);
>  
> -	if (has_vector)
> +	if (has_vector())
>  		total_context_size += rvv_sc_size;
>  	/* Preserved a __riscv_ctx_hdr for END signal context header. */
>  	total_context_size += sizeof(struct __riscv_ctx_hdr);
> @@ -288,7 +288,7 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
>  	if (has_fpu())
>  		err |= save_fp_state(regs, &sc->sc_fpregs);
>  	/* Save the vector state. */
> -	if (has_vector)
> +	if (has_vector())
>  		err |= save_v_state(regs, &sc_reserved_free_ptr);
>  
>  	/* Put END __riscv_ctx_hdr at the end. */


