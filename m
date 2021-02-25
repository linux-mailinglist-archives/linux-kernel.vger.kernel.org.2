Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766B6324E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 11:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhBYKzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 05:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbhBYKxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 05:53:13 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C53BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 02:52:32 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u11so2963356plg.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 02:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=D9ceHkRWopAfZY+M1nz75DyCbP32W8Pm3rrNwuMcCQQ=;
        b=JaY4tBNYjtKmCwBirMFUEBxaE7utPSyyL2dIFC9TM1sCLcbGTSqi4h9mviUPq9XvnZ
         VYjKfW5wcvqU+UJow9jioiDvmeyGXcLlaDG6LjNpA6pRH14qVrD49fW5Tozrv94qoBXm
         cdh7n9yFCo6BlrwZ1CSqx1v7ogEi6mcXfYKIE411pUN5n+KGT8jjX4OsNUhMEAySxCRG
         75cBLSmL7QotBIIIDHeZudbW9GHjHywLWE8DgtgX4jIMySN/Xi3foVnYsaU1hJTr7Wql
         AgWasVfJN2o+ZRJEe4H7NsQY7pOGbOnDRP/KEWlseJYc2yVAOULMVmT2+Av36Xoxc2/t
         tc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=D9ceHkRWopAfZY+M1nz75DyCbP32W8Pm3rrNwuMcCQQ=;
        b=nP8dlW7smpdP/trJwTEKNZuoPnnnD35Tvvo4Owu77BEhy6mOu7oErSTIW6cePuLsGa
         +QEneDU9VtTRjw7SCIdnjzmGeauefIDUZGAJfwofrQ0QcfbF3KMAyZt+E8sLztrOaYva
         ty/++2tp23p6m2Jfn0yWQi8DfoKCbgmBsRZNKgfEbBZy7CJt6qHmCh9ysJQCJoTqd/R8
         Cl1YP6JoLlAkynZhoAHx2w7WRcRwpyan2RnQKvKtdg2xlQk7ipo2Teimkn+VUT3LuIQ0
         D92LkBVtG1qzvUSy/BveIpKw+hpdM7Q7DI8Pde9MllNL8dE0eN3kwftN087XP8FCDV0P
         pHUw==
X-Gm-Message-State: AOAM532pXdoTPkmjJTLg6+vHDGfAaJSMOcXPgh1ZbjS2vgqKh5+7HmML
        O+Y5SN0un+dUgoDAw5c/7ibajYte0YJwrA==
X-Google-Smtp-Source: ABdhPJz2SpAMWHJwuwceLTjQOTEJerL2MfQ7sD1wVgIxUmkxwbmrwXrAjBKcLZ6Y9KUSxfUBP3oLSA==
X-Received: by 2002:a17:902:e551:b029:de:8dba:84a3 with SMTP id n17-20020a170902e551b02900de8dba84a3mr2637711plf.8.1614250352254;
        Thu, 25 Feb 2021 02:52:32 -0800 (PST)
Received: from localhost (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id j1sm5858952pjf.26.2021.02.25.02.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 02:52:31 -0800 (PST)
Date:   Thu, 25 Feb 2021 20:52:26 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/syscall: Force inlining of
 __prep_irq_for_enabled_exit()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <53f3a1f719441761000c41154602bf097d4350b5.1614148356.git.christophe.leroy@csgroup.eu>
In-Reply-To: <53f3a1f719441761000c41154602bf097d4350b5.1614148356.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1614250330.9u6pqclx87.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 24, 2021 4:34 pm:
> As reported by kernel test robot, a randconfig with high amount of
> debuging options can lead to build failure for undefined reference
> to replay_soft_interrupts() on ppc32.
>=20
> This is due to gcc not seeing that __prep_irq_for_enabled_exit()
> always returns true on ppc32 because it doesn't inline it for
> some reason.
>=20
> Force inlining of __prep_irq_for_enabled_exit() to fix the build.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> Fixes: 344bb20b159d ("powerpc/syscall: Make interrupt.c buildable on PPC3=
2")
> ---
>  arch/powerpc/kernel/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 398cd86b6ada..2ef3c4051bb9 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -149,7 +149,7 @@ notrace long system_call_exception(long r3, long r4, =
long r5,
>   * enabled when the interrupt handler returns (indicating a process-cont=
ext /
>   * synchronous interrupt) then irqs_enabled should be true.
>   */
> -static notrace inline bool __prep_irq_for_enabled_exit(bool clear_ri)
> +static notrace __always_inline bool __prep_irq_for_enabled_exit(bool cle=
ar_ri)
>  {
>  	/* This must be done with RI=3D1 because tracing may touch vmaps */
>  	trace_hardirqs_on();
> --=20
> 2.25.0
>=20
>=20
