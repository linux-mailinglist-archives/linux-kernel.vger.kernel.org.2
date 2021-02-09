Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED3231460E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhBICGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 21:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhBICGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:06:51 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC206C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 18:06:11 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id e9so745395pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 18:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=5oVfKwxdMSPd4bzfTWlB2L73D+eDnMGGdqjT45jmcxY=;
        b=CJZgqG3fU0ze1LDxxjCcL4OidXvnO1PwEBOYVWUPTwEFeyF1W3L1ktYtEho5dm/aVV
         sk+R7iOCbdtXtWiYkIUksuwUeySkja5FP7soga6gViyrd+VqpyYktEC50Y3DmlbFU1bh
         bfeHow7e2Vl2IFopPd97sJHII6XZpCN+HCLzQtwt6YCnWKeMnwNMlFu/n00EYvBs5ihO
         vf9LUL1jm5GfKJno0kMTk4zd4Im7w+Fy8zNkCl6tfkuIpTaIzRwO8Oas3gavBFQJsIyP
         jQ6JmDhr910/0PPTaTokdsqEvF1ncyPNljg5StXlr6bDKoAmgF7TMOsr1gjSH6lbspld
         631Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=5oVfKwxdMSPd4bzfTWlB2L73D+eDnMGGdqjT45jmcxY=;
        b=DvQbMqQfXgRUR5CYp+yA72bv/PWgd1zfAj2tjCSrZW2+OcwGxO8doDcfBh7afSFuO7
         U9OPA0RIj/eZnTIW+hr4ToBr0ba9gldioHAY7cYGUzDXZBjwGVEgcvOub0E7cKVcpRAW
         ht4drORooUXH5Klet1LpP+CwAsfGa3nfWv0k0ZwukreZ3BTWattx9m175j74f4zsit0d
         nAY/AV+lGeisT5m/Z2Mb1gozJzTjHbrNqWoVsMu6M/5lC0sVcwnPk4ZV+uLr5okYVk+6
         bATQW6vpAa0xgpOXVbdI0X0/T4QAgQEyWcgiTkejbvzW2E36sfOKSy4ZVcXloO5QZVIH
         IPmg==
X-Gm-Message-State: AOAM530CvFi4s7u5Gw/n62Ok0eyF6l41hsUNwYae7RrSb9cdaEO6+6qs
        gRu076hSHvneOJZ9aMiCKyM=
X-Google-Smtp-Source: ABdhPJzGqPWpoRbGYGl/C3R89SBWGnvbM42KuAF3cB7mfsxUIui1WbJK14P31w9OaoHtp3cTz0DwaQ==
X-Received: by 2002:a17:902:c94d:b029:de:9b70:d886 with SMTP id i13-20020a170902c94db02900de9b70d886mr18475530pla.5.1612836371414;
        Mon, 08 Feb 2021 18:06:11 -0800 (PST)
Received: from localhost ([220.240.226.199])
        by smtp.gmail.com with ESMTPSA id x190sm5635792pfx.166.2021.02.08.18.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 18:06:10 -0800 (PST)
Date:   Tue, 09 Feb 2021 12:06:05 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 19/22] powerpc/syscall: Optimise checks in beginning of
 system_call_exception()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
        <3e48bb439357c6f72ae4343bf93bd29f0980eeb1.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <3e48bb439357c6f72ae4343bf93bd29f0980eeb1.1612796617.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612836170.502t0sssvi.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
> Combine all tests of regs->msr into a single logical one.

Okay by me unless we choose to do the config option and put these all=20
under it. I think I would prefer that because sometimes the registers
are in a state you can't easily see what the values in the expression
were. In this case it doesn't matter so much because they should be in
regs in the interrupt frame.

Thanks,
Nick

>=20
> Before the patch:
>=20
>    0:	81 6a 00 84 	lwz     r11,132(r10)
>    4:	90 6a 00 88 	stw     r3,136(r10)
>    8:	69 60 00 02 	xori    r0,r11,2
>    c:	54 00 ff fe 	rlwinm  r0,r0,31,31,31
>   10:	0f 00 00 00 	twnei   r0,0
>   14:	69 63 40 00 	xori    r3,r11,16384
>   18:	54 63 97 fe 	rlwinm  r3,r3,18,31,31
>   1c:	0f 03 00 00 	twnei   r3,0
>   20:	69 6b 80 00 	xori    r11,r11,32768
>   24:	55 6b 8f fe 	rlwinm  r11,r11,17,31,31
>   28:	0f 0b 00 00 	twnei   r11,0
>=20
> After the patch:
>=20
>    0:	81 6a 00 84 	lwz     r11,132(r10)
>    4:	90 6a 00 88 	stw     r3,136(r10)
>    8:	7d 6b 58 f8 	not     r11,r11
>    c:	71 6b c0 02 	andi.   r11,r11,49154
>   10:	0f 0b 00 00 	twnei   r11,0
>=20
> 6 cycles less on powerpc 8xx (328 =3D> 322 cycles).
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/interrupt.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 55e1aa18cdb9..8c38e8c95be2 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -28,6 +28,7 @@ notrace long system_call_exception(long r3, long r4, lo=
ng r5,
>  				   unsigned long r0, struct pt_regs *regs)
>  {
>  	syscall_fn f;
> +	unsigned long expected_msr;
> =20
>  	regs->orig_gpr3 =3D r3;
> =20
> @@ -39,10 +40,13 @@ notrace long system_call_exception(long r3, long r4, =
long r5,
> =20
>  	trace_hardirqs_off(); /* finish reconciling */
> =20
> +	expected_msr =3D MSR_PR;
>  	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x))
> -		BUG_ON(!(regs->msr & MSR_RI));
> -	BUG_ON(!(regs->msr & MSR_PR));
> -	BUG_ON(arch_irq_disabled_regs(regs));
> +		expected_msr |=3D MSR_RI;
> +	if (IS_ENABLED(CONFIG_PPC32))
> +		expected_msr |=3D MSR_EE;
> +	BUG_ON((regs->msr & expected_msr) ^ expected_msr);
> +	BUG_ON(IS_ENABLED(CONFIG_PPC64) && arch_irq_disabled_regs(regs));
> =20
>  #ifdef CONFIG_PPC_PKEY
>  	if (mmu_has_feature(MMU_FTR_PKEY)) {
> --=20
> 2.25.0
>=20
>=20
