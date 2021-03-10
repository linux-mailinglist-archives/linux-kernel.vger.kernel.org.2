Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC113332B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 02:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhCJBXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 20:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCJBWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 20:22:46 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A57C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 17:22:46 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id a8so1134916plp.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 17:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=/0T9Q/3VYJdpmRDY2Zb62s1teTncsS5cl8cP6z35CcM=;
        b=bzYrsE8ab+hzvJInwNOsFN4tTFMxA3qcocbvzHxjAO+IZcW33em6ESOnW76SumDCG2
         4F4fPJgaw/SirzDK/hcDZd3An6x3E4pjnWpvEv3XQ5OU62l3Q5p0L77dekVecVmuT86C
         7Iiig07OyeyjTTiQ5d8+bZGuqLuQ03Aa8jg0SAQxiWEGhIBwsT6iM4vte8IznTM7Tz68
         05WuF8Oxpiv33TLgJ/8QaDhquImZIqHbXSsNxVpRGMzKHXKFX1XQVQcek5sp12oZRDfp
         EJHup+icXOeseFDB5S0sriXGqfrWYGDvMMoBE9AN/2RwlMnlgVbC8mx3Tlkq28YJZG4v
         gabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=/0T9Q/3VYJdpmRDY2Zb62s1teTncsS5cl8cP6z35CcM=;
        b=QjljD/GVr0Qm8O6HP16F44P5JabUAYCv3Lrzolo5nTTTYapA0g4knqJGpMADx6D5J1
         D7SQqmknC6L10IgEOvLXuZWtywZmT4elRFSuYoGJhtRmWej93lTNmqe5FnSFWwjs/p5P
         OvgnotJ9IpfQ438mvkyklwnwl0VX1DheXV6Fny154aaPAnXloLGLI0n1qyY99Ew/bWXX
         al9syPmBAOcd6LOrgfOGTtEI9iz5j8zBXTrYQYxLZFmQGa9mODu5L1hj4BCg3gsLFCnW
         oue78OjalM2QssHh5zIf4AK4Q6dWNPTtpY+x9m+ocyRGS7w4kglI8vh14dQ1tzVg4itO
         r6OA==
X-Gm-Message-State: AOAM532knV7i6TYEeFavNJ5MAY4ceFPV1l81v16od+Enkd3QtdvS19gN
        UmqOelgdO+XDMAyZIrB4L3awlIzOGUg=
X-Google-Smtp-Source: ABdhPJxTOZjEHZ9m10YEdhbBRQMe0zJEDNi/G7r+9KpnfEzOCSm9nbO3D39CGUHblwkoYfJoKT+e+A==
X-Received: by 2002:a17:90a:bf04:: with SMTP id c4mr766670pjs.170.1615339365730;
        Tue, 09 Mar 2021 17:22:45 -0800 (PST)
Received: from localhost (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id s194sm14297397pfs.57.2021.03.09.17.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 17:22:45 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:22:40 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 02/43] powerpc/traps: Declare unrecoverable_exception()
 as __noreturn
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
        <f097a1071254e8f6875588f8fb9771467824a569.1615291471.git.christophe.leroy@csgroup.eu>
In-Reply-To: <f097a1071254e8f6875588f8fb9771467824a569.1615291471.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1615339022.cb2m6h66vl.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of March 9, 2021 10:09 pm:
> unrecoverable_exception() is never expected to return, most callers
> have an infiniteloop in case it returns.
>=20
> Ensure it really never returns by terminating it with a BUG(), and
> declare it __no_return.
>=20
> It always GCC to really simplify functions calling it. In the exemple
> below, it avoids the stack frame in the likely fast path and avoids
> code duplication for the exit.
>=20
> With this patch:

[snip]

Nice.

> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index a44a30b0688c..d5c9d9ddd186 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -2170,11 +2170,15 @@ DEFINE_INTERRUPT_HANDLER(SPEFloatingPointRoundExc=
eption)
>   * in the MSR is 0.  This indicates that SRR0/1 are live, and that
>   * we therefore lost state by taking this exception.
>   */
> -void unrecoverable_exception(struct pt_regs *regs)
> +void __noreturn unrecoverable_exception(struct pt_regs *regs)
>  {
>  	pr_emerg("Unrecoverable exception %lx at %lx (msr=3D%lx)\n",
>  		 regs->trap, regs->nip, regs->msr);
>  	die("Unrecoverable exception", regs, SIGABRT);
> +	/* die() should not return */
> +	WARN(true, "die() unexpectedly returned");
> +	for (;;)
> +		;
>  }

I don't think the WARN should be added because that will cause another
interrupt after something is already badly wrong, so this might just
make it harder to debug.

For example if die() is falling through for some reason, we warn and
cause a program check here, and that might also be unrecoverable so it
might come through here and fall through again and warn again, etc.

Putting the infinite loop is good enough I think (and better than there=20
was previously).

Otherwise

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick
