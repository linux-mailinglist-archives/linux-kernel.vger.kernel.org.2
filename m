Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8182E3332C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 02:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhCJBdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 20:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhCJBdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 20:33:54 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1257EC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 17:33:54 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u18so7636474plc.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 17:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=bk2gbXj7lVPQspVhwjnWs8ssO+83Zc6YrCjiO0hiGow=;
        b=ZK7yoTO7YgUN2ikGdYvBBxnFHZlkxpq4eADMqVD4AZknTxG4DhR/6WXNzfVDudcqwZ
         F8jjnKdMoVDM7Neo/fOY5tGOXHRVMkaFlh5nZI91TiTJgkRZ8PJEj+AwXJFnEAsHA0P8
         SmT2+cJ9jGCj4Zl96a4JnxB8HHdFLK1H1x5ylKrfN19rVvHyCKYv+XGLo6PYHCFAo1Zy
         3PW9xT3GWIHFiaU0DLWA8AO43RPQ96ZRjnYb6I8clypkojZfem69/CNOmOI/GuaQ5oJN
         sT+0cQcPfPvfw0kSWgNa8W2KpTDw1XkyfuAiIHcrMKfh/m2xxUg+1DjQtds9BBlSBUEU
         FNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=bk2gbXj7lVPQspVhwjnWs8ssO+83Zc6YrCjiO0hiGow=;
        b=k2YSipTyNGzN6OyxSpT3LZRCDm9G5kE0RiZ293WwODo3G2NBjpVox1fsuqDBuf7RqU
         Tn3XMSrPAhg/kQATBVNMOElsTWa2HTkfOQYpH3xulxOISGxnJ9nlFPWX1KV4Qr6w6GMy
         W16LirCmmcpEvXy2ZbuJtAQFRB/clez6ZbZPiKkCXBzdAZn7uh07yeTzdq4X+J10jesX
         bDy6ElzH/jwfNCg4GHwP9m4+U8VRPYAeYQkELjxNJJytrpCnYiAffx07aMlHXI2Fyrc4
         jZouC7NHcdkhYHR63fj5pP4alTUggXVdrS+41Gu0cnWeVnB6PDSfMfMx98eKIc1nQuEK
         0YMw==
X-Gm-Message-State: AOAM533EspwJvX3Kh3qHK2q+ZGIU7qphPSxQXkrZ4AW5nX6HpQevLJu2
        IEu2FE5PFTTyVyWVypb/tgw=
X-Google-Smtp-Source: ABdhPJy2HN27jz4a5QTummRE+dZi2bKOXRGhtGb8kVTmwRdp+g5WgQtHEmb6K/7hPGkiu4ADl8Zt9w==
X-Received: by 2002:a17:90b:3550:: with SMTP id lt16mr802543pjb.47.1615340033713;
        Tue, 09 Mar 2021 17:33:53 -0800 (PST)
Received: from localhost (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id s10sm14061433pgl.90.2021.03.09.17.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 17:33:53 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:33:47 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 36/43] powerpc/32: Set current->thread.regs in C
 interrupt entry
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
        <8d523f9ecee1de0515cc31d43030c12ab171a670.1615291474.git.christophe.leroy@csgroup.eu>
In-Reply-To: <8d523f9ecee1de0515cc31d43030c12ab171a670.1615291474.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1615339900.vmbtzuirqw.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of March 9, 2021 10:10 pm:
> No need to do that is assembly, do it in C.

Hmm. No issues with the patch as such, but why does ppc32 need this but=20
not 64? AFAIKS 64 sets this when a thread is created.

Thanks,
Nick

>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/interrupt.h | 4 +++-
>  arch/powerpc/kernel/entry_32.S       | 3 +--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/=
asm/interrupt.h
> index 861e6eadc98c..e6d71c2e3aa2 100644
> --- a/arch/powerpc/include/asm/interrupt.h
> +++ b/arch/powerpc/include/asm/interrupt.h
> @@ -33,8 +33,10 @@ static inline void interrupt_enter_prepare(struct pt_r=
egs *regs, struct interrup
>  	if (!arch_irq_disabled_regs(regs))
>  		trace_hardirqs_off();
> =20
> -	if (user_mode(regs))
> +	if (user_mode(regs)) {
> +		current->thread.regs =3D regs;
>  		account_cpu_user_entry();
> +	}
>  #endif
>  	/*
>  	 * Book3E reconciles irq soft mask in asm
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_3=
2.S
> index 8fe1c3fdfa6e..815a4ff1ba76 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -52,8 +52,7 @@
>  prepare_transfer_to_handler:
>  	andi.	r0,r9,MSR_PR
>  	addi	r12, r2, THREAD
> -	beq	2f			/* if from user, fix up THREAD.regs */
> -	stw	r3,PT_REGS(r12)
> +	beq	2f
>  #ifdef CONFIG_PPC_BOOK3S_32
>  	kuep_lock r11, r12
>  #endif
> --=20
> 2.25.0
>=20
>=20
