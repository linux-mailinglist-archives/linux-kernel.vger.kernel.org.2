Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB5D3A39CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 04:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhFKCdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 22:33:47 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:50924 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhFKCdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 22:33:46 -0400
Received: by mail-pj1-f41.google.com with SMTP id g4so4850796pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 19:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=e5K1WutpQ4ryjeQEihlJkVsIbkqUeWrgN2WO92sXGZM=;
        b=DpdK8nFit9zJKc3vGDOsEhXvWZneuG0L6UNjz9r3fmVqhTLU4dnCqJI6xxbnq8MKHI
         tVyWV97fRO7s2J2S+U1Yc+6TRH4+8wRl+g0UqNmG5K2W04pojtCFKuKJMzSeelwCUJv3
         KgE5zrTItICTaeUSUe/vbGSZ2EetRqp3QPaxF5hT1pmlYG7mfR3kLDnbr+CHf0NmhcX/
         kqlqsTvbZwGDeqjUbKKLPQenUSLAkEm0MZsvVpZ0yiRT6JqcEAwrYPs6YDzsK45JdUQd
         H9inz2DX3Hf72c0Chfz9tiALQQrqqtyxqtU0ZoOMgXGnK/7xSTn2YputnZ9bJEcSOTZ/
         c6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=e5K1WutpQ4ryjeQEihlJkVsIbkqUeWrgN2WO92sXGZM=;
        b=sUbOSklQzwJ2rMdLCKnO3w9DztZIWDHfyFxQGwVJJl2jCGyYY72pxjFsyZilo9ZLSo
         0mjISIqYaQzrI+k/LY9JwpRzlfpLv6SZ4zKBNRN7Wv8Encpe99bdX77Bzzmu74HHR9D+
         hYjv/i9LkgADX24kdNVr8+rbkiaY7+/cqT1XyiitfwRUo2VdskQ7gUkrPHR4wwSpfeyu
         xrr1SdZN/OY6t0B/eEL33Iyhaa01fAb16PUUeskS44ylOfYRyFhCQn+9LpVrEbaYzYOP
         uIhx9DjBWVk+VBpPVOlwEFjzx4aIcn03Ke4E9Jvtr3nmMI+Vsf7AQHVBzzW0UIg73w6t
         W87Q==
X-Gm-Message-State: AOAM531Lk1ZXRXKc4c2ZHGVKdqxAa4z9xYzSuM4oh8szj8uCW4a3HYxt
        yvVlRgnGZCBuamYymgmBC74I2EfpgC0=
X-Google-Smtp-Source: ABdhPJxaL9tsPBJ3ab510EBcjK/c2Pq5L6EHhqrAf9vODjJkZ852MryO6R/xO90ntmz424S6Wxx8Cg==
X-Received: by 2002:a17:90b:503:: with SMTP id r3mr1975950pjz.195.1623378636861;
        Thu, 10 Jun 2021 19:30:36 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id k136sm3593681pfd.87.2021.06.10.19.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 19:30:36 -0700 (PDT)
Date:   Fri, 11 Jun 2021 12:30:31 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 2/4] powerpc/interrupt: Refactor
 prep_irq_for_user_exit()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <809d316bf5f1a81acdd69e220c13e716dac24f53.1622818556.git.christophe.leroy@csgroup.eu>
        <3fbef68e1cffc0ebbbad1893e4fb9426b0915039.1622818556.git.christophe.leroy@csgroup.eu>
In-Reply-To: <3fbef68e1cffc0ebbbad1893e4fb9426b0915039.1622818556.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1623378421.ayihg84s3a.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of June 5, 2021 12:56 am:
> prep_irq_for_user_exit() is a superset of
> prep_irq_for_kernel_enabled_exit().
>=20
> Refactor it.

I like the refactoring, but now prep_irq_for_user_exit() is calling=20
prep_irq_for_kernel_enabled_exit(), which seems like the wrong naming.

You could re-name prep_irq_for_kernel_enabled_exit() to
prep_irq_for_enabled_exit() maybe? Or it could be=20
__prep_irq_for_enabled_exit() then prep_irq_for_kernel_enabled_exit()
and prep_irq_for_user_exit() would both call it.

Otherwise

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/interrupt.c | 25 +++++--------------------
>  1 file changed, 5 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 539455c62c5b..b6aa80930733 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -78,29 +78,14 @@ static notrace __always_inline bool prep_irq_for_kern=
el_enabled_exit(bool restar
>   */
>  static notrace __always_inline bool prep_irq_for_user_exit(void)
>  {
> -	user_enter_irqoff();
> -	/* This must be done with RI=3D1 because tracing may touch vmaps */
> -	trace_hardirqs_on();
> -
> -#ifdef CONFIG_PPC32
> -	__hard_EE_RI_disable();
> -#else
> -	if (exit_must_hard_disable())
> -		__hard_EE_RI_disable();
> +	bool ret;
> =20
> -	/* This pattern matches prep_irq_for_idle */
> -	if (unlikely(lazy_irq_pending_nocheck())) {
> -		if (exit_must_hard_disable()) {
> -			local_paca->irq_happened |=3D PACA_IRQ_HARD_DIS;
> -			__hard_RI_enable();
> -		}
> -		trace_hardirqs_off();
> +	user_enter_irqoff();
> +	ret =3D prep_irq_for_kernel_enabled_exit(true);
> +	if (!ret)
>  		user_exit_irqoff();
> =20
> -		return false;
> -	}
> -#endif
> -	return true;
> +	return ret;
>  }
> =20
>  /* Has to run notrace because it is entered not completely "reconciled" =
*/
> --=20
> 2.25.0
>=20
>=20
