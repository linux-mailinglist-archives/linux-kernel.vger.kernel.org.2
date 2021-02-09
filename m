Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B6C31459D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhBIB2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhBIB2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:28:02 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69762C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 17:27:20 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id s15so8818001plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 17:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=8siXkPNiMTROtHFK2LJRHz+zINwsqI9MUnwtYtjz9jg=;
        b=epTn12OQFyWhFY4VwnBH6Rkih8sMWPqUgPi37ev5YCZLe7IsqI2zmHAxtgnCdmdeZz
         Uru1dTCIj91f8C1ZkPSzrZP+e+nPVJoYiRg4UzrekwGaQz60ulEZ5YxkbeKb0AFycFZg
         sNTZGuJBc2787VbRLMNXblR43GxveKq+nAcFEXdJ+hcj8oAHU+q+ZpZMs2zYYI/1/pIM
         r6xCzqegHdGz02f/S3i6RQNFlrvJzVSt7rPg0aw2UzTSVY2mfM4tIoKGjewDyD92zsBO
         Owa+M8ozNKVpzHuAEEClZPAarzQZEWxnEIlks81RQ+peIOoG03P4IWZ2m/HinBau48/X
         UN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=8siXkPNiMTROtHFK2LJRHz+zINwsqI9MUnwtYtjz9jg=;
        b=h7TAB7OXznN6bbL7VPeJyQVMz+ycsuHhZ0atZKGEB2esDB7UWXUdq+zUeVtaAUQ+ZG
         WV6pSulxVHIlJX4omVWTV8l1wuHcCkL3QPQ0u42+rsja6We2rVEEE/oc51hdaDgBP4eh
         ZY3LoWRhkyY+g1Q8JNfIP/NUrNkI/WwlqMEpQ87Oh7jhuZKkCj16OTy+Em88/TmfmLqk
         aNOUlVINpDcFb/1G957/xbDZN9YBM3gtIXTL8Ag6GygCysNbMWq7W1ByGURHh5mhV9Rj
         uU6C4LagIagYR3vfAF0zmLATm69VoYWDmPoh6TSVxXqATnfBWnYbSayj+tqMvlq1a9oQ
         iOHA==
X-Gm-Message-State: AOAM5337bFile5zmxZ/PcV43PTxBQ7AnoTZ9nJ/nNe4KhAo+M5CBgIJW
        e6SRd3GON27FVq1x9FbhILQ=
X-Google-Smtp-Source: ABdhPJwU3vnjfzvZCnATLnhIDpanZsM9xc+K/63rxnxz9ta6gXuqShI0eYSxeuv0hoqacKhIHX9/2w==
X-Received: by 2002:a17:90a:701:: with SMTP id l1mr1587483pjl.154.1612834039933;
        Mon, 08 Feb 2021 17:27:19 -0800 (PST)
Received: from localhost ([220.240.226.199])
        by smtp.gmail.com with ESMTPSA id f13sm614210pjj.1.2021.02.08.17.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 17:27:19 -0800 (PST)
Date:   Tue, 09 Feb 2021 11:27:13 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 09/22] powerpc/syscall: Make interrupt.c buildable on
 PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
        <ba073ad67bd971a88ce331b65d6655523b54c794.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <ba073ad67bd971a88ce331b65d6655523b54c794.1612796617.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612833796.dl9doe6njg.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
> To allow building interrupt.c on PPC32, ifdef out specific PPC64
> code or use helpers which are available on both PP32 and PPC64
>=20
> Modify Makefile to always build interrupt.o
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v5:
> - Also for interrupt exit preparation
> - Opted out kuap related code, ppc32 keeps it in ASM for the time being
> ---
>  arch/powerpc/kernel/Makefile    |  4 ++--
>  arch/powerpc/kernel/interrupt.c | 31 ++++++++++++++++++++++++-------
>  2 files changed, 26 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 26ff8c6e06b7..163755b1cef4 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -57,10 +57,10 @@ obj-y				:=3D cputable.o syscalls.o \
>  				   prom.o traps.o setup-common.o \
>  				   udbg.o misc.o io.o misc_$(BITS).o \
>  				   of_platform.o prom_parse.o firmware.o \
> -				   hw_breakpoint_constraints.o
> +				   hw_breakpoint_constraints.o interrupt.o
>  obj-y				+=3D ptrace/
>  obj-$(CONFIG_PPC64)		+=3D setup_64.o \
> -				   paca.o nvram_64.o note.o interrupt.o
> +				   paca.o nvram_64.o note.o
>  obj-$(CONFIG_COMPAT)		+=3D sys_ppc32.o signal_32.o
>  obj-$(CONFIG_VDSO32)		+=3D vdso32_wrapper.o
>  obj-$(CONFIG_PPC_WATCHDOG)	+=3D watchdog.o
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index d6be4f9a67e5..2dac4d2bb1cf 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -39,7 +39,7 @@ notrace long system_call_exception(long r3, long r4, lo=
ng r5,
>  		BUG_ON(!(regs->msr & MSR_RI));
>  	BUG_ON(!(regs->msr & MSR_PR));
>  	BUG_ON(!FULL_REGS(regs));
> -	BUG_ON(regs->softe !=3D IRQS_ENABLED);
> +	BUG_ON(arch_irq_disabled_regs(regs));
> =20
>  #ifdef CONFIG_PPC_PKEY
>  	if (mmu_has_feature(MMU_FTR_PKEY)) {
> @@ -65,7 +65,9 @@ notrace long system_call_exception(long r3, long r4, lo=
ng r5,
>  			isync();
>  	} else
>  #endif
> +#ifdef CONFIG_PPC64
>  		kuap_check_amr();
> +#endif

Wouldn't mind trying to get rid of these ifdefs at some point, but=20
there's some kuap / keys changes going on recently so I'm happy enough=20
to let this settle then look at whether we can refactor.

> =20
>  	account_cpu_user_entry();
> =20
> @@ -77,7 +79,7 @@ notrace long system_call_exception(long r3, long r4, lo=
ng r5,
>  	 * frame, or if the unwinder was taught the first stack frame always
>  	 * returns to user with IRQS_ENABLED, this store could be avoided!
>  	 */
> -	regs->softe =3D IRQS_ENABLED;
> +	irq_soft_mask_regs_set_state(regs, IRQS_ENABLED);
> =20
>  	local_irq_enable();
> =20
> @@ -151,6 +153,7 @@ static notrace inline bool __prep_irq_for_enabled_exi=
t(bool clear_ri)
>  		__hard_EE_RI_disable();
>  	else
>  		__hard_irq_disable();
> +#ifdef CONFIG_PPC64
>  	if (unlikely(lazy_irq_pending_nocheck())) {
>  		/* Took an interrupt, may have more exit work to do. */
>  		if (clear_ri)
> @@ -162,7 +165,7 @@ static notrace inline bool __prep_irq_for_enabled_exi=
t(bool clear_ri)
>  	}
>  	local_paca->irq_happened =3D 0;
>  	irq_soft_mask_set(IRQS_ENABLED);
> -
> +#endif
>  	return true;
>  }
> =20

Do we prefer space before return except in trivial cases?

> @@ -216,7 +219,9 @@ notrace unsigned long syscall_exit_prepare(unsigned l=
ong r3,
> =20
>  	CT_WARN_ON(ct_state() =3D=3D CONTEXT_USER);
> =20
> +#ifdef CONFIG_PPC64
>  	kuap_check_amr();
> +#endif
> =20
>  	regs->result =3D r3;
> =20
> @@ -309,7 +314,7 @@ notrace unsigned long syscall_exit_prepare(unsigned l=
ong r3,
> =20
>  	account_cpu_user_exit();
> =20
> -#ifdef CONFIG_PPC_BOOK3S /* BOOK3E not yet using this */
> +#ifdef CONFIG_PPC_BOOK3S_64 /* BOOK3E and ppc32 not using this */
>  	/*
>  	 * We do this at the end so that we do context switch with KERNEL AMR
>  	 */
> @@ -318,7 +323,7 @@ notrace unsigned long syscall_exit_prepare(unsigned l=
ong r3,
>  	return ret;
>  }
> =20
> -#ifdef CONFIG_PPC_BOOK3S /* BOOK3E not yet using this */
> +#ifndef CONFIG_PPC_BOOK3E_64 /* BOOK3E not yet using this */
>  notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs, =
unsigned long msr)
>  {
>  #ifdef CONFIG_PPC_BOOK3E

Why are you building this for 32? I don't mind if it's just to keep=20
things similar and make it build for now, but you're not using it yet,
right?
=20
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> @@ -333,14 +338,16 @@ notrace unsigned long interrupt_exit_user_prepare(s=
truct pt_regs *regs, unsigned
>  		BUG_ON(!(regs->msr & MSR_RI));
>  	BUG_ON(!(regs->msr & MSR_PR));
>  	BUG_ON(!FULL_REGS(regs));
> -	BUG_ON(regs->softe !=3D IRQS_ENABLED);
> +	BUG_ON(arch_irq_disabled_regs(regs));
>  	CT_WARN_ON(ct_state() =3D=3D CONTEXT_USER);
> =20
>  	/*
>  	 * We don't need to restore AMR on the way back to userspace for KUAP.
>  	 * AMR can only have been unlocked if we interrupted the kernel.
>  	 */
> +#ifdef CONFIG_PPC64
>  	kuap_check_amr();
> +#endif
> =20
>  	local_irq_save(flags);
> =20
> @@ -407,7 +414,9 @@ notrace unsigned long interrupt_exit_user_prepare(str=
uct pt_regs *regs, unsigned
>  	/*
>  	 * We do this at the end so that we do context switch with KERNEL AMR
>  	 */
> +#ifdef CONFIG_PPC64
>  	kuap_user_restore(regs);
> +#endif
>  	return ret;
>  }
> =20
> @@ -419,7 +428,9 @@ notrace unsigned long interrupt_exit_kernel_prepare(s=
truct pt_regs *regs, unsign
>  	unsigned long *ti_flagsp =3D &current_thread_info()->flags;
>  	unsigned long flags;
>  	unsigned long ret =3D 0;
> +#ifdef CONFIG_PPC64
>  	unsigned long amr;
> +#endif
> =20
>  	if (IS_ENABLED(CONFIG_PPC_BOOK3S) && unlikely(!(regs->msr & MSR_RI)))
>  		unrecoverable_exception(regs);
> @@ -432,7 +443,9 @@ notrace unsigned long interrupt_exit_kernel_prepare(s=
truct pt_regs *regs, unsign
>  	if (TRAP(regs) !=3D 0x700)
>  		CT_WARN_ON(ct_state() =3D=3D CONTEXT_USER);
> =20
> +#ifdef CONFIG_PPC64
>  	amr =3D kuap_get_and_check_amr();
> +#endif
> =20
>  	if (unlikely(*ti_flagsp & _TIF_EMULATE_STACK_STORE)) {
>  		clear_bits(_TIF_EMULATE_STACK_STORE, ti_flagsp);
> @@ -441,7 +454,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(s=
truct pt_regs *regs, unsign
> =20
>  	local_irq_save(flags);
> =20
> -	if (regs->softe =3D=3D IRQS_ENABLED) {
> +	if (!arch_irq_disabled_regs(regs)) {
>  		/* Returning to a kernel context with local irqs enabled. */
>  		WARN_ON_ONCE(!(regs->msr & MSR_EE));
>  again:
> @@ -458,8 +471,10 @@ notrace unsigned long interrupt_exit_kernel_prepare(=
struct pt_regs *regs, unsign
>  	} else {
>  		/* Returning to a kernel context with local irqs disabled. */
>  		__hard_EE_RI_disable();
> +#ifdef CONFIG_PPC64
>  		if (regs->msr & MSR_EE)
>  			local_paca->irq_happened &=3D ~PACA_IRQ_HARD_DIS;
> +#endif
>  	}
> =20
> =20
> @@ -472,7 +487,9 @@ notrace unsigned long interrupt_exit_kernel_prepare(s=
truct pt_regs *regs, unsign
>  	 * which would cause Read-After-Write stalls. Hence, we take the AMR
>  	 * value from the check above.
>  	 */
> +#ifdef CONFIG_PPC64
>  	kuap_kernel_restore(regs, amr);
> +#endif
> =20
>  	return ret;
>  }
> --=20
> 2.25.0
>=20
>=20
