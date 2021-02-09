Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1611314603
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBICB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 21:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhBICAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:00:49 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893D6C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 18:00:09 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g3so8878963plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 18:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=mtED8wSjvvAU6+8X8TiuYPoLw4AzXIhEOTIHAu3f3sk=;
        b=a1L02L+q3yIDpCsxERkUJRdJhkiQH9xqfBWAwPs1hd/P0XjZFPdX+AHwlhRuhgkZER
         Hke7fRYulgFxtcOB5OSbJFluSOrN1unBWmAa8DqUA9xPQZei6y8OAN9so2uIRNF23zrX
         LSAXrxrR4dP2gVo4tlZ29wRetRPD7pO54/P2W3vS5fM5IoStx9biUYTQ5Cqxs/YTxET+
         Qr57kcn52qcZ7jbfvlL9GzJUVJmczQasEeu+FCwfXfjgbP1Ml4BkUzt226ab78+KsLaz
         7VmICabJt0kdiiHEvhV1A6f5Mv2PRrEAtDwphVrbvtMZcEJJBG7vFUP+lJlzGUc4AgjQ
         wobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=mtED8wSjvvAU6+8X8TiuYPoLw4AzXIhEOTIHAu3f3sk=;
        b=kV3Vd4xfZIeJru/leqpt/n0mHLRRjz2eBtQu/lYGNK78Zou5iLTryfdx3tUPax2ASx
         n3/m/GCibOs7Lwr6MATabuFcT6PeIhz6k/pE6VNa3hagdPswjzwdk5HvSl4t0ryRWTc8
         sroweFY/+isJ7/om1RmFnYKCN2bad6J+8prUcE74+5z54Y1yslwTLLI8I9YS3nW/J6k/
         vlqaJEiBuoiAdMz6p3Briy5zugVHRxOWH6KHO2UzlRFlgP7ZhSmPzIHfyXSQ86LNZeE2
         REDAwMUOyBGpSbx/HQ7McclmgIGkIJ1AJ4KzNg5DBDDpo2EgIgdiNDS2WmbWmbTXaiH0
         geag==
X-Gm-Message-State: AOAM532Mbk/FSgtsXbJMtFBFXH64WG7Unfw1xV9/0Zff95F4lrolKuS4
        1BZZPLQlngvDWBSKbSYthUo=
X-Google-Smtp-Source: ABdhPJyE+Avxm3jI2T4xn3mJX8LsTXv6lP2r8lAe55ndar5RTDvBKqgNTVCIkpRZvzcrtXP6bLBVDg==
X-Received: by 2002:a17:902:6b43:b029:df:fb48:aecf with SMTP id g3-20020a1709026b43b02900dffb48aecfmr18665295plt.67.1612836009095;
        Mon, 08 Feb 2021 18:00:09 -0800 (PST)
Received: from localhost ([220.240.226.199])
        by smtp.gmail.com with ESMTPSA id j2sm6148167pgq.34.2021.02.08.18.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 18:00:08 -0800 (PST)
Date:   Tue, 09 Feb 2021 12:00:03 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 17/22] powerpc/syscall: Do not check unsupported scv
 vector on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
        <fc3afe1870f943b2010805fcb045b718a638b3c6.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <fc3afe1870f943b2010805fcb045b718a638b3c6.1612796617.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612835741.qmlhg8iwmj.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
> Only PPC64 has scv. No need to check the 0x7ff0 trap on PPC32.
> For that, add a helper trap_is_unsupported_scv() similar to
> trap_is_scv().
>=20
> And ignore the scv parameter in syscall_exit_prepare (Save 14 cycles
> 346 =3D> 332 cycles)
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v5: Added a helper trap_is_unsupported_scv()
> ---
>  arch/powerpc/include/asm/ptrace.h | 5 +++++
>  arch/powerpc/kernel/entry_32.S    | 1 -
>  arch/powerpc/kernel/interrupt.c   | 7 +++++--
>  3 files changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm=
/ptrace.h
> index 58f9dc060a7b..2c842b11a924 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -229,6 +229,11 @@ static inline bool trap_is_scv(struct pt_regs *regs)
>  	return (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && TRAP(regs) =3D=3D 0x3000);
>  }
> =20
> +static inline bool trap_is_unsupported_scv(struct pt_regs *regs)
> +{
> +	return (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && TRAP(regs) =3D=3D 0x7ff0);
> +}

This change is good.

> +
>  static inline bool trap_is_syscall(struct pt_regs *regs)
>  {
>  	return (trap_is_scv(regs) || TRAP(regs) =3D=3D 0xc00);
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_3=
2.S
> index cffe58e63356..7c824e8928d0 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -344,7 +344,6 @@ transfer_to_syscall:
> =20
>  ret_from_syscall:
>  	addi    r4,r1,STACK_FRAME_OVERHEAD
> -	li	r5,0
>  	bl	syscall_exit_prepare

For this one, I think it would be nice to do the "right" thing and make=20
the function prototypes different on !64S. They could then declare a
local const bool scv =3D 0.

We could have syscall_exit_prepare and syscall_exit_prepare_maybe_scv
or something like that, 64s can use the latter one and the former can be
a wrapper that passes constant 0 for scv. Then we don't have different
prototypes for the same function, but you just have to make the 32-bit
version static inline and the 64-bit version exported to asm.

Thanks,
Nick

>  #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
>  	/* If the process has its own DBCR0 value, load it up.  The internal
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 205902052112..8fafca727b8b 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -88,7 +88,7 @@ notrace long system_call_exception(long r3, long r4, lo=
ng r5,
>  	local_irq_enable();
> =20
>  	if (unlikely(current_thread_info()->flags & _TIF_SYSCALL_DOTRACE)) {
> -		if (unlikely(regs->trap =3D=3D 0x7ff0)) {
> +		if (unlikely(trap_is_unsupported_scv(regs))) {
>  			/* Unsupported scv vector */
>  			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
>  			return regs->gpr[3];
> @@ -111,7 +111,7 @@ notrace long system_call_exception(long r3, long r4, =
long r5,
>  		r8 =3D regs->gpr[8];
> =20
>  	} else if (unlikely(r0 >=3D NR_syscalls)) {
> -		if (unlikely(regs->trap =3D=3D 0x7ff0)) {
> +		if (unlikely(trap_is_unsupported_scv(regs))) {
>  			/* Unsupported scv vector */
>  			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
>  			return regs->gpr[3];
> @@ -224,6 +224,9 @@ notrace unsigned long syscall_exit_prepare(unsigned l=
ong r3,
>  	unsigned long ti_flags;
>  	unsigned long ret =3D 0;
> =20
> +	if (IS_ENABLED(CONFIG_PPC32))
> +		scv =3D 0;
> +
>  	CT_WARN_ON(ct_state() =3D=3D CONTEXT_USER);
> =20
>  #ifdef CONFIG_PPC64
> --=20
> 2.25.0
>=20
>=20
