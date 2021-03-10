Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BC03332CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 02:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhCJBhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 20:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhCJBhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 20:37:25 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CBCC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 17:37:25 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so6571153pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 17:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=d34zYJWgTA8c5Ujr7dblIGWfKQ8pynSGIl67Hphzq54=;
        b=Og2RkqQiOEne1+Gi6J2O4Hjwwyiz1gKu6i/HaU63P6yngPcIvLsN05veNm3o9RNFAn
         qj7kRjjOin/0wLSLLZwRKzU3VnoUQslskUoFK50QstseVsZ5ljc/0Y39/pBdMt5wklvS
         ajWGEoYIaHXYjy1/22t0Ay227dDZz4FpSFyB1Ula67JHp1xGjlo61/bSsW60dIOhigTJ
         qYGrx94BmrM2NriCFIvgfba4866E12TEY1nAaUN+C+WwC+KJRYiQbE9M9FwIa7KnAN7r
         OdX4SjCGlmUEFTfLJGBeCTBTkUjAZ8+rH5QSYhRyFt1KXTNDrNtaYeLiAjZkhuT8JAGf
         I13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=d34zYJWgTA8c5Ujr7dblIGWfKQ8pynSGIl67Hphzq54=;
        b=DV70WfZZtemSKMqawDLSsuh2NqLzFARh8E9PiQGzQSPO5xE1uo5vWgre7Z/AYWeCnE
         IwyLckj8AIXjkddJyvkzsUC6RlkUE5Btf7pj/WHxRaGswTBi1Rh+cd17Ih++8Na0EKd3
         ch3z7n9qL7PwoigC8x3eC0fYsviRsaL2rYhUR6Dt47aDLdGT8WIz21FOWPOoFc7LYQhm
         WIBSzGjkBFow4XKSKcqved4Iuu5nM9njSCqrvbd3lXzeUcaKHNYoimogZYSY6MyFVkKF
         fToz7e8L84EhxC9eIMbp48pZ6jvr1OJYb2Jdr4PKcrn1Jilwg4nACKBJd92bRaXpGZ3f
         RF9Q==
X-Gm-Message-State: AOAM533X4NHBjm42EYVBOqGin4rWslyHKGGRsGivRSs6Sx7hqiU2MCb0
        XXRr5dqPoRKEUVqz/iC706Q=
X-Google-Smtp-Source: ABdhPJwe5UZ2T1wGyZQha2NcygpxsFF8QBaWQ2n+ZMxWbZ708LSjMbOf49G2004b3456bB5kUgPEsA==
X-Received: by 2002:a17:90b:305:: with SMTP id ay5mr856742pjb.74.1615340244654;
        Tue, 09 Mar 2021 17:37:24 -0800 (PST)
Received: from localhost (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id 9sm13858029pgy.79.2021.03.09.17.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 17:37:24 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:37:19 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 40/43] powerpc/64s: Make kuap_check_amr() and
 kuap_get_and_check_amr() generic
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
        <7167aef44fb816f6df17f65d540ac07ca98c4af9.1615291474.git.christophe.leroy@csgroup.eu>
In-Reply-To: <7167aef44fb816f6df17f65d540ac07ca98c4af9.1615291474.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1615340152.vcj9lsklbx.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of March 9, 2021 10:10 pm:
> In preparation of porting powerpc32 to C syscall entry/exit,
> rename kuap_check_amr() and kuap_get_and_check_amr() as kuap_check()
> and kuap_get_and_check(), and move in the generic asm/kup.h the stub
> for when CONFIG_PPC_KUAP is not selected.

Looks pretty straightforward to me.

While you're renaming things, could kuap_check_amr() be changed to
kuap_assert_locked() or similar? Otherwise,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/book3s/64/kup.h | 24 ++----------------------
>  arch/powerpc/include/asm/kup.h           | 10 +++++++++-
>  arch/powerpc/kernel/interrupt.c          | 12 ++++++------
>  arch/powerpc/kernel/irq.c                |  2 +-
>  4 files changed, 18 insertions(+), 30 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/incl=
ude/asm/book3s/64/kup.h
> index 8bd905050896..d9b07e9998be 100644
> --- a/arch/powerpc/include/asm/book3s/64/kup.h
> +++ b/arch/powerpc/include/asm/book3s/64/kup.h
> @@ -287,7 +287,7 @@ static inline void kuap_kernel_restore(struct pt_regs=
 *regs,
>  	 */
>  }
> =20
> -static inline unsigned long kuap_get_and_check_amr(void)
> +static inline unsigned long kuap_get_and_check(void)
>  {
>  	if (mmu_has_feature(MMU_FTR_BOOK3S_KUAP)) {
>  		unsigned long amr =3D mfspr(SPRN_AMR);
> @@ -298,27 +298,7 @@ static inline unsigned long kuap_get_and_check_amr(v=
oid)
>  	return 0;
>  }
> =20
> -#else /* CONFIG_PPC_PKEY */
> -
> -static inline void kuap_user_restore(struct pt_regs *regs)
> -{
> -}
> -
> -static inline void kuap_kernel_restore(struct pt_regs *regs, unsigned lo=
ng amr)
> -{
> -}
> -
> -static inline unsigned long kuap_get_and_check_amr(void)
> -{
> -	return 0;
> -}
> -
> -#endif /* CONFIG_PPC_PKEY */
> -
> -
> -#ifdef CONFIG_PPC_KUAP
> -
> -static inline void kuap_check_amr(void)
> +static inline void kuap_check(void)
>  {
>  	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG) && mmu_has_feature(MMU_FTR_BOOK3S=
_KUAP))
>  		WARN_ON_ONCE(mfspr(SPRN_AMR) !=3D AMR_KUAP_BLOCKED);
> diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/ku=
p.h
> index 25671f711ec2..b7efa46b3109 100644
> --- a/arch/powerpc/include/asm/kup.h
> +++ b/arch/powerpc/include/asm/kup.h
> @@ -74,7 +74,15 @@ bad_kuap_fault(struct pt_regs *regs, unsigned long add=
ress, bool is_write)
>  	return false;
>  }
> =20
> -static inline void kuap_check_amr(void) { }
> +static inline void kuap_check(void) { }
> +static inline void kuap_save_and_lock(struct pt_regs *regs) { }
> +static inline void kuap_user_restore(struct pt_regs *regs) { }
> +static inline void kuap_kernel_restore(struct pt_regs *regs, unsigned lo=
ng amr) { }
> +
> +static inline unsigned long kuap_get_and_check(void)
> +{
> +	return 0;
> +}
> =20
>  /*
>   * book3s/64/kup-radix.h defines these functions for the !KUAP case to f=
lush
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 727b7848c9cc..40ed55064e54 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -76,7 +76,7 @@ notrace long system_call_exception(long r3, long r4, lo=
ng r5,
>  	} else
>  #endif
>  #ifdef CONFIG_PPC64
> -		kuap_check_amr();
> +		kuap_check();
>  #endif
> =20
>  	booke_restore_dbcr0();
> @@ -254,7 +254,7 @@ notrace unsigned long syscall_exit_prepare(unsigned l=
ong r3,
>  	CT_WARN_ON(ct_state() =3D=3D CONTEXT_USER);
> =20
>  #ifdef CONFIG_PPC64
> -	kuap_check_amr();
> +	kuap_check();
>  #endif
> =20
>  	regs->result =3D r3;
> @@ -380,7 +380,7 @@ notrace unsigned long interrupt_exit_user_prepare(str=
uct pt_regs *regs, unsigned
>  	 * AMR can only have been unlocked if we interrupted the kernel.
>  	 */
>  #ifdef CONFIG_PPC64
> -	kuap_check_amr();
> +	kuap_check();
>  #endif
> =20
>  	local_irq_save(flags);
> @@ -451,7 +451,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(s=
truct pt_regs *regs, unsign
>  	unsigned long flags;
>  	unsigned long ret =3D 0;
>  #ifdef CONFIG_PPC64
> -	unsigned long amr;
> +	unsigned long kuap;
>  #endif
> =20
>  	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x) &&
> @@ -467,7 +467,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(s=
truct pt_regs *regs, unsign
>  		CT_WARN_ON(ct_state() =3D=3D CONTEXT_USER);
> =20
>  #ifdef CONFIG_PPC64
> -	amr =3D kuap_get_and_check_amr();
> +	kuap =3D kuap_get_and_check();
>  #endif
> =20
>  	if (unlikely(current_thread_info()->flags & _TIF_EMULATE_STACK_STORE)) =
{
> @@ -511,7 +511,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(s=
truct pt_regs *regs, unsign
>  	 * value from the check above.
>  	 */
>  #ifdef CONFIG_PPC64
> -	kuap_kernel_restore(regs, amr);
> +	kuap_kernel_restore(regs, kuap);
>  #endif
> =20
>  	return ret;
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index d71fd10a1dd4..3b18d2b2c702 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -282,7 +282,7 @@ static inline void replay_soft_interrupts_irqrestore(=
void)
>  	 * and re-locking AMR but we shouldn't get here in the first place,
>  	 * hence the warning.
>  	 */
> -	kuap_check_amr();
> +	kuap_check();
> =20
>  	if (kuap_state !=3D AMR_KUAP_BLOCKED)
>  		set_kuap(AMR_KUAP_BLOCKED);
> --=20
> 2.25.0
>=20
>=20
