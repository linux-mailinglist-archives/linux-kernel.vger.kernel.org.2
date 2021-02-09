Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6893145BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBIBjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBIBh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:37:29 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEC1C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 17:36:49 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id j11so8824853plt.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 17:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=k3xVH4Zf+SGPyF1+qimuYcY1j2NUQvV4+U6ixsrmmks=;
        b=uTze7O0GYArJLC7W8Zkrcp8ykioQ9iDzCecKSMXiKyWzl9Sz+m+oLQOsDHa5yyf9N6
         +LZukihtC8/sd+PCzNlnSX/Ly6zpxylQ9/Df7siV5Xw5hb48kyrXsxSx5mbrca/6BLPM
         RDXTP6JHJNQTih4cFf7XHTPi9tnCbm4D2fy5r8pif4oqELK43nmAq1YMTGTgpRpGiHku
         SuvRmIcKojTbfURY19Xty76HPDY9vXIQuieDS5QSgmcxPdVMK5uhpmYaC0x9hFu1ZBpz
         rPw2nvUXzsThsDHL9I3434y9pYbBCakRfQ2/rd0VL02+kYz20EAKt99zQi8F2qXoYrAD
         PYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=k3xVH4Zf+SGPyF1+qimuYcY1j2NUQvV4+U6ixsrmmks=;
        b=e0qtLy99bLlDdEmWBkv9TgQACNQFFSmkI4b8hFsTJjXUqy3Y3GVrVhF1Buq6MiqRQB
         UBXFGbJHkeS/0c1uZhM1zKwj9xFfQ328XsaulKU5trUViLrEqHpdFew5zcdoXB2HT5Gj
         o7/JKEyh8rv4Z39LXscyiJNrnkNugwS/N+Y7ql3eUxH8Uz42ZILPVfm98ijohqIELmLC
         9FwRqc//oDJoRxKuBPN7g7TQAtIbo6oTONcq3Vu3B3Vj8kSolidlh7M5Qo/QvIXlQA0V
         DtvHcWw/ReoFYAv/o6JL0iDWgPwBoMzNqdkkneZOtiGM/OPqFSSOvDNksfWuj1FKwSUx
         Xqew==
X-Gm-Message-State: AOAM531e/ZRFPtau11q4Mx1HUOFkSGmRpzHYKYAZ45JaswSJq6eIi6bb
        VtDMuAZU82HBcW8+Zs4B8FU=
X-Google-Smtp-Source: ABdhPJzofX2hr0z0krmZbUaLCq+gAfmL06ugTwSrbvT6VDdNO/wiv3TeROuGdFwlNoHO/3clJ73yow==
X-Received: by 2002:a17:90a:5287:: with SMTP id w7mr1670682pjh.52.1612834609161;
        Mon, 08 Feb 2021 17:36:49 -0800 (PST)
Received: from localhost ([220.240.226.199])
        by smtp.gmail.com with ESMTPSA id o1sm19501986pgq.1.2021.02.08.17.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 17:36:48 -0800 (PST)
Date:   Tue, 09 Feb 2021 11:36:43 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 12/22] powerpc/syscall: Change condition to check
 MSR_RI
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
        <67820fada8dd6a8fe9d7b666f175d4cc9d8de87e.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <67820fada8dd6a8fe9d7b666f175d4cc9d8de87e.1612796617.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612834209.4lzq8y2p6t.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
> In system_call_exception(), MSR_RI also needs to be checked on 8xx.
> Only booke and 40x doesn't have MSR_RI.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

...
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v5: Also in interrupt exit prepare
> ---
>  arch/powerpc/kernel/interrupt.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 1a2dec49f811..107ec39f05cb 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -39,7 +39,7 @@ notrace long system_call_exception(long r3, long r4, lo=
ng r5,
> =20
>  	trace_hardirqs_off(); /* finish reconciling */
> =20
> -	if (IS_ENABLED(CONFIG_PPC_BOOK3S))
> +	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x))
>  		BUG_ON(!(regs->msr & MSR_RI));
>  	BUG_ON(!(regs->msr & MSR_PR));
>  	BUG_ON(!FULL_REGS(regs));
> @@ -338,7 +338,7 @@ notrace unsigned long interrupt_exit_user_prepare(str=
uct pt_regs *regs, unsigned
>  	unsigned long flags;
>  	unsigned long ret =3D 0;
> =20
> -	if (IS_ENABLED(CONFIG_PPC_BOOK3S))
> +	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x))
>  		BUG_ON(!(regs->msr & MSR_RI));
>  	BUG_ON(!(regs->msr & MSR_PR));
>  	BUG_ON(!FULL_REGS(regs));
> @@ -436,7 +436,8 @@ notrace unsigned long interrupt_exit_kernel_prepare(s=
truct pt_regs *regs, unsign
>  	unsigned long amr;
>  #endif
> =20
> -	if (IS_ENABLED(CONFIG_PPC_BOOK3S) && unlikely(!(regs->msr & MSR_RI)))
> +	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x) &&
> +	    unlikely(!(regs->msr & MSR_RI)))
>  		unrecoverable_exception(regs);
>  	BUG_ON(regs->msr & MSR_PR);
>  	BUG_ON(!FULL_REGS(regs));
> --=20
> 2.25.0
>=20
>=20
