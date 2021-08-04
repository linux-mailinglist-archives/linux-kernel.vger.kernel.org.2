Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928BC3DFC79
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbhHDIIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbhHDIIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:08:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FA4C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 01:08:21 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d17so2130588plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 01:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=iF8GqUw3fJkSuKkM1TDURToz/fDqSBL3RQMnD7NkKi4=;
        b=soV5H8Iaxlk13Zsqs/hVkR+nh/fQ+droSHbxWuKIwOf/yzzy9YzHm5qGn9Pld7ekHR
         Zle8+Ikp4lSC2Q6X4IgF4ktAwCDEKcB/BtF5gYxik/DpNXWJXqu0cHVHRvwH07fzeHCK
         EDEUHZCk+GgCP00JIkDa8C7NLzZUbJrmjWKIHpBVo+Zd6NlaJ3nhBINpBwUgRgWr4F9A
         v2oLTpGT67CgWpTpZv+Zci1E5QMBgP7dzQ0BMpyRdLrO7t7GODl0XfaZ2GzRruXDpGIb
         Qflmjn7ajBMMJcVk8uSsYjSZ1Zb4aNTaaaygAfe6EwPCM9X5WyPI8MrO+Jtx/7OaBmrp
         dljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=iF8GqUw3fJkSuKkM1TDURToz/fDqSBL3RQMnD7NkKi4=;
        b=OrLXqpUIWzMqt7HT2xPV9W7ARs4ex/z+c0mGbl2DHAT+mv9FK/1NlAz1gvqU4iStjq
         aqnT46GecFsbGkbtWDcmDmls/+/wFk1VflZSklEjf3NXqAu5zUXS02vkqO7IIPisrfvk
         ai0fEGirxEbIKECgEg3P4KBpFRIA0E1I3EfUD0mTCQBWdPAUELOj/LgKgLKef4eJIvqV
         HICT6H49hErpsmytzkIYkhtwjvveS2veQvnlV4fDAXuRwzdoVnOF291zijJo1spjt7nW
         8+C15tRl+XjnMaLR5NXDkryV18196/EHnkSXrZsMLg4GawJSocj3/aKIObgzQRksrlzC
         GyfA==
X-Gm-Message-State: AOAM530gLTW/+CF/usyD6zYf5Vtk6g8RwFc5EuU/6qlco+1pe07e9aWy
        EPvGSOn/xVLFC2+y8Pmi6wIF2ldBmAQ=
X-Google-Smtp-Source: ABdhPJzBcxvudp/M5au72pgDSSu33yGC2Lt+KJhqCRM8D6bWhoyw/dh6MAN471eUedhDYAR6imgz3g==
X-Received: by 2002:a62:e416:0:b029:3c5:f084:7212 with SMTP id r22-20020a62e4160000b02903c5f0847212mr343016pfh.76.1628064501299;
        Wed, 04 Aug 2021 01:08:21 -0700 (PDT)
Received: from localhost (60-242-181-102.static.tpgi.com.au. [60.242.181.102])
        by smtp.gmail.com with ESMTPSA id j19sm1662743pfr.82.2021.08.04.01.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 01:08:20 -0700 (PDT)
Date:   Wed, 04 Aug 2021 18:08:16 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: Remove MSR_PR check in
 interrupt_exit_{user/kernel}_prepare()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <b36623df00ef3d2296f928487b6e23f93a217afa.1628054802.git.christophe.leroy@csgroup.eu>
In-Reply-To: <b36623df00ef3d2296f928487b6e23f93a217afa.1628054802.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1628064412.48kzr1eula.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of August 4, 2021 3:27 pm:
> In those hot functions that are called at every interrupt, any saved
> cycle is worth it.
>=20
> interrupt_exit_user_prepare() and interrupt_exit_kernel_prepare() are
> called from three places:
> - From entry_32.S
> - From interrupt_64.S
> - From interrupt_exit_user_restart() and interrupt_exit_kernel_restart()
>=20
> In entry_32.S, there are inambiguously called based on MSR_PR:
>=20
> 	interrupt_return:
> 		lwz	r4,_MSR(r1)
> 		addi	r3,r1,STACK_FRAME_OVERHEAD
> 		andi.	r0,r4,MSR_PR
> 		beq	.Lkernel_interrupt_return
> 		bl	interrupt_exit_user_prepare
> 	...
> 	.Lkernel_interrupt_return:
> 		bl	interrupt_exit_kernel_prepare
>=20
> In interrupt_64.S, that's similar:
>=20
> 	interrupt_return_\srr\():
> 		ld	r4,_MSR(r1)
> 		andi.	r0,r4,MSR_PR
> 		beq	interrupt_return_\srr\()_kernel
> 	interrupt_return_\srr\()_user: /* make backtraces match the _kernel vari=
ant */
> 		addi	r3,r1,STACK_FRAME_OVERHEAD
> 		bl	interrupt_exit_user_prepare
> 	...
> 	interrupt_return_\srr\()_kernel:
> 		addi	r3,r1,STACK_FRAME_OVERHEAD
> 		bl	interrupt_exit_kernel_prepare
>=20
> In interrupt_exit_user_restart() and interrupt_exit_kernel_restart(),
> MSR_PR is verified respectively by BUG_ON(!user_mode(regs)) and
> BUG_ON(user_mode(regs)) prior to calling interrupt_exit_user_prepare()
> and interrupt_exit_kernel_prepare().
>=20
> The verification in interrupt_exit_user_prepare() and
> interrupt_exit_kernel_prepare() are therefore useless and can be removed.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Probably okay to do now things are ironing out.

Unless we want to make a new define for interrupt handler debug and put=20
a bunch of these asserts under it. There's quite a lot more here, and
in asm/interrupt.h, etc.

Thanks,
Nick

> ---
>  arch/powerpc/kernel/interrupt.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 21bbd615ca41..f26caf911ab5 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -465,7 +465,6 @@ notrace unsigned long interrupt_exit_user_prepare(str=
uct pt_regs *regs)
> =20
>  	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x))
>  		BUG_ON(!(regs->msr & MSR_RI));
> -	BUG_ON(!(regs->msr & MSR_PR));
>  	BUG_ON(arch_irq_disabled_regs(regs));
>  	CT_WARN_ON(ct_state() =3D=3D CONTEXT_USER);
> =20
> @@ -499,7 +498,6 @@ notrace unsigned long interrupt_exit_kernel_prepare(s=
truct pt_regs *regs)
>  	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x) &&
>  	    unlikely(!(regs->msr & MSR_RI)))
>  		unrecoverable_exception(regs);
> -	BUG_ON(regs->msr & MSR_PR);
>  	/*
>  	 * CT_WARN_ON comes here via program_check_exception,
>  	 * so avoid recursion.
> --=20
> 2.25.0
>=20
>=20
