Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AD9314605
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhBICDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 21:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhBICDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:03:17 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE35C061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 18:02:37 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id b145so10926184pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 18:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=utXHPcgvm9Y8ZwC4DuYoSqZra3dkj+8uEXyKJK77MuM=;
        b=n2kVSQ1XlJX6xUt/1m2yXy+XedXCXDvoOAa1zzTkBmgiUEn/AWSkU+NLDGSkqgrmmX
         ViwTenSuk6hs2X6eou1rCXLEuV7j89e3DPN+E2yhAIvBRZNd0rMBd0f2eToxAAdWgyby
         0MwZltwqg/OaRiWmqvqZfrRjVntRB2LyDqX9maj0UUyc3E2AqF7BIebDlzA7pOy7EX09
         9Qhz9umMzOXQ1xdIqrm5Iayyaz38/Xu+DnJ2m1OBdkwiZK/B6m9uOU3xlD4E7aPkVtNX
         u3SWi/C7AdB7M3L+AGRNGmyqyGCyeLEAGJ1jIkTDF8cgNU7LKMvDUyfOoxVIJs27Rm5O
         TRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=utXHPcgvm9Y8ZwC4DuYoSqZra3dkj+8uEXyKJK77MuM=;
        b=geECI1oC+CnzElKVbgC6ACkPhmZgYJxgdP37yosKSuSsyBQ2uQbtmV1q7xpLrHMRVY
         xM7R5LmjySs7awFL6+kUV6q0pYCF3wZsX64Okq4q/eL4oiufjtcZwPhLHsEFzH6DIAIU
         xeGJ6IJ4jvTDzkwU9R86dQzGjrEKPcD88RW0uT1ZxrOVQzk4B8NSKatftU//s4TZ+0Tr
         QvvZ7HQMpNFmx7DpH/EbzgDvpxV0Z1e0msL+ZZjWsEhyFesY5NdXtr7GxoVLlVccRMMm
         7G8742uCaqi6uZkBSs32SVODKAajmRJ2V/zUOIGvIfaL5IQVKjQ9OB3Wj3185Zb3wOiH
         O+Jw==
X-Gm-Message-State: AOAM532IN4fJxd+4QiRHJp4lviH0ehAG3gUXWydeJ9mNN7H2VCSz8aZt
        +7XFdPxkofeWbSeJ5SZbe9U=
X-Google-Smtp-Source: ABdhPJzuY8MD5OC5cvECJcPWzH/iIf6UjSZt7cny9SeK3VphHxxRpE48XhJHGnrzAOnUZgSXJJjn8w==
X-Received: by 2002:a65:6207:: with SMTP id d7mr20641495pgv.92.1612836156934;
        Mon, 08 Feb 2021 18:02:36 -0800 (PST)
Received: from localhost ([220.240.226.199])
        by smtp.gmail.com with ESMTPSA id y20sm19944613pfo.210.2021.02.08.18.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 18:02:36 -0800 (PST)
Date:   Tue, 09 Feb 2021 12:02:30 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 18/22] powerpc/syscall: Remove FULL_REGS verification
 in system_call_exception
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
        <6bef4d9ba0cba50160d13e344ee4627ebdf801dc.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <6bef4d9ba0cba50160d13e344ee4627ebdf801dc.1612796617.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612836023.l122pe2n2b.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
> For book3s/64, FULL_REGS() is 'true' at all time, so the test voids.
> For others, non volatile registers are saved inconditionally.
>=20
> So the verification is pointless.
>=20
> Should one fail to do it, it would anyway be caught by the
> CHECK_FULL_REGS() in copy_thread() as we have removed the
> special versions ppc_fork() and friends.
>=20
> null_syscall benchmark reduction 4 cycles (332 =3D> 328 cycles)

I wonder if we rather make a CONFIG option for a bunch of these simpler
debug checks here (and also in interrupt exit, wrappers, etc) rather
than remove them entirely.

Thanks,
Nick

>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/interrupt.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 8fafca727b8b..55e1aa18cdb9 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -42,7 +42,6 @@ notrace long system_call_exception(long r3, long r4, lo=
ng r5,
>  	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x))
>  		BUG_ON(!(regs->msr & MSR_RI));
>  	BUG_ON(!(regs->msr & MSR_PR));
> -	BUG_ON(!FULL_REGS(regs));
>  	BUG_ON(arch_irq_disabled_regs(regs));
> =20
>  #ifdef CONFIG_PPC_PKEY
> --=20
> 2.25.0
>=20
>=20
