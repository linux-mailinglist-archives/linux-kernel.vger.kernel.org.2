Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53DA3332AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 02:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhCJBRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 20:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhCJBQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 20:16:56 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ADCC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 17:16:56 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id m6so10951406pfk.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 17:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=DjidbrwyCx3lORD3j61lhIQB01qhNRAIbQn71N/GNnc=;
        b=NFP/fOl8BCAapNo/2gaBvjw/pa0scQdoJA9QjrWcRvb09sWIwzFqlBHXFWGc36E/95
         lQhvzcVswpo7zSr/0EUho7lqZ7jPW5xGstl5gQj2nd/pGygE5rKok0egs5SR6QsKo01Q
         04IfXWwGSN3Yevzkp6UBSFQeeOniDjlIGWn8TBMt6VL+jDGvS9xviXckbCZk2P7jWT/N
         Fw8UMGb9YulUI3EEyF4f9+41kqMs2J0ieXJB/POmvPyCsij24EB7Oyouzlezu/hVrxBK
         7Y0BQqxsfT0mZvVf9LxwMqqakPMIxLFHB6QMvis8iP7YVAv0SCxH+d0VCe8fdxuh+jeD
         ldNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=DjidbrwyCx3lORD3j61lhIQB01qhNRAIbQn71N/GNnc=;
        b=HEaO/2jn/akIl7AdRWSuyQTgfKapLwTJTmAplbO53VO6WYWlKOULU29+jbS7+/y8On
         qIXZ4u8hEoR+DNgeuCDV16jkNMLPwJYffkYYwLek09b8NmKxbTCo1mjvU539p1+eqzsq
         Cy0fa/SEMciKr9py9b8CTonVvcYpnPAjgKpuVUmFuhviqMr4vcZ10ZyRb/BnOcBfyVRc
         /BMNdrVhztoWTe80pckVuJrLP6vlwqwKxNSDE3QCo9Dgdh809KSUOZSf7uGYIWfeHnuu
         IZx52y8owYZVW1u2z89gjpuu8eMsaKp9kM9ViCeqT3ycLZ/3pXBhebDi/lSrv6V0F22e
         qJ/A==
X-Gm-Message-State: AOAM532brv9144X7ndei3SbBygDrn3wKFsi60AwNJ5ugGNNDBu5gFvvR
        tXdzJ4ImZU/rD+yVgnFg+8Hlz1JR1+o=
X-Google-Smtp-Source: ABdhPJyQq4Lc5AFbI42oqK1tMmOp5ZBN1pH2tB5VAev9LMJErHXAaM0Qxhs1H9CMlazf7jv+S5A8eg==
X-Received: by 2002:a63:40c5:: with SMTP id n188mr516700pga.255.1615339015898;
        Tue, 09 Mar 2021 17:16:55 -0800 (PST)
Received: from localhost (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id a204sm3162989pfd.106.2021.03.09.17.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 17:16:54 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:16:49 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 01/43] powerpc/traps: unrecoverable_exception() is not
 an interrupt handler
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
        <ae96c59fa2cb7f24a8929c58cfa2c909cb8ff1f1.1615291471.git.christophe.leroy@csgroup.eu>
In-Reply-To: <ae96c59fa2cb7f24a8929c58cfa2c909cb8ff1f1.1615291471.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1615338957.9ydlqjl817.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of March 9, 2021 10:09 pm:
> unrecoverable_exception() is called from interrupt handlers or
> after an interrupt handler has failed.
>=20
> Make it a standard function to avoid doubling the actions
> performed on interrupt entry (e.g.: user time accounting).
>=20
> Fixes: 3a96570ffceb ("powerpc: convert interrupt handlers to use wrappers=
")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

This should go in as a fix for this release I think.

> ---
>  arch/powerpc/include/asm/interrupt.h | 3 ++-
>  arch/powerpc/kernel/interrupt.c      | 1 -
>  arch/powerpc/kernel/traps.c          | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/=
asm/interrupt.h
> index aedfba29e43a..e8d09a841373 100644
> --- a/arch/powerpc/include/asm/interrupt.h
> +++ b/arch/powerpc/include/asm/interrupt.h
> @@ -410,7 +410,6 @@ DECLARE_INTERRUPT_HANDLER(altivec_assist_exception);
>  DECLARE_INTERRUPT_HANDLER(CacheLockingException);
>  DECLARE_INTERRUPT_HANDLER(SPEFloatingPointException);
>  DECLARE_INTERRUPT_HANDLER(SPEFloatingPointRoundException);
> -DECLARE_INTERRUPT_HANDLER(unrecoverable_exception);
>  DECLARE_INTERRUPT_HANDLER(WatchdogException);
>  DECLARE_INTERRUPT_HANDLER(kernel_bad_stack);
> =20
> @@ -437,6 +436,8 @@ DECLARE_INTERRUPT_HANDLER_NMI(hmi_exception_realmode)=
;
> =20
>  DECLARE_INTERRUPT_HANDLER_ASYNC(TAUException);
> =20
> +void unrecoverable_exception(struct pt_regs *regs);
> +
>  void replay_system_reset(void);
>  void replay_soft_interrupts(void);
> =20
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 398cd86b6ada..b8e7d25be31b 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -436,7 +436,6 @@ notrace unsigned long interrupt_exit_user_prepare(str=
uct pt_regs *regs, unsigned
>  	return ret;
>  }
> =20
> -void unrecoverable_exception(struct pt_regs *regs);
>  void preempt_schedule_irq(void);
> =20
>  notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs=
, unsigned long msr)
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 1583fd1c6010..a44a30b0688c 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -2170,7 +2170,7 @@ DEFINE_INTERRUPT_HANDLER(SPEFloatingPointRoundExcep=
tion)
>   * in the MSR is 0.  This indicates that SRR0/1 are live, and that
>   * we therefore lost state by taking this exception.
>   */
> -DEFINE_INTERRUPT_HANDLER(unrecoverable_exception)
> +void unrecoverable_exception(struct pt_regs *regs)
>  {
>  	pr_emerg("Unrecoverable exception %lx at %lx (msr=3D%lx)\n",
>  		 regs->trap, regs->nip, regs->msr);
> --=20
> 2.25.0
>=20
>=20
