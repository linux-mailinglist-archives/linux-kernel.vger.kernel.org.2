Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34613A39BC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 04:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhFKC2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 22:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhFKC2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 22:28:47 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99A2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 19:26:50 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id z1so1254658pgj.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 19:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=lASTtq1Plgoc+ovhi4JOG1rfLsoGZjNrlYTsEEjYDG0=;
        b=K61ueDjSmueJf2vK4kFVHQCzp0Dvw8cjL2wfSEmQyqBUPzXDee40g1LkClHwz1mP6d
         0AhqiPiRi1Ho6DVPEthY60ui8J3uLjmtzs7HRtAjG3KNtSKGw2VyjD69nIvppeooF8QN
         VgWQmCwGNWdWHSsZq+0bPwqsSb8RGGHG92h+PFYiFzWPFFuWyzOrJDvANwNb4PKQoV3l
         ZbmWGT5vdBHOvmpQ3yGzTNmk7afgFkrcYUMOdTyRhwRPmgJ4NbFaIfXqcBXCSikAao9t
         Ot88l7OrYPbTVwpim6V4Ju+NxUdsqS2Fy3MMJgC4h9BjFpyXycH5PAlOZRlBUJb1zh4E
         7hRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=lASTtq1Plgoc+ovhi4JOG1rfLsoGZjNrlYTsEEjYDG0=;
        b=T6+lltV4FpGXEAdUes8gbgruF9HN7/YZ3yeMTILmwITKFOSh9n4EbT+sQTfEF/23Nm
         iDuzj4Bx9UF+QZxKFjQ4XVEiScssvTBfaVu2md0UZf9+YnaQ3RZkndFq/iBFUKYjokUG
         NpuArlTuzc5F6kfJKuESpBLcnM6kc/sYTGUZWgPayoqfT+H3NpYj9Dk6Mh2V8ptMHnqs
         4VSb5dSZMQESPULUHGsjE3RASEn86egy/yAE5pRUX3v7oVaGAojEhom2YPbdn48dZ6H+
         YbBFTHw072H+uO/gOgBYgrOm90FFpkOgSZaw6d/gmJVuI6SGNNl2TFuwztMfNzQkz6tw
         7oXg==
X-Gm-Message-State: AOAM531FF45FS2Yq6OThj+WxbOMkNtqeMZCpwcGUgUtWDa8ZulLvMwdB
        ivDlvqBgcGsP86Evlgqj6HRIohGxMEk=
X-Google-Smtp-Source: ABdhPJz2tV0ph+NxM9/a/7THrV3jaVL5c9vIoPxWJJOJm9S4gqc245s1G+wsmXH5V0BLXDlr2QPUzA==
X-Received: by 2002:a63:1a0e:: with SMTP id a14mr1312701pga.294.1623378410394;
        Thu, 10 Jun 2021 19:26:50 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id f3sm8237202pjo.3.2021.06.10.19.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 19:26:49 -0700 (PDT)
Date:   Fri, 11 Jun 2021 12:26:44 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/4] powerpc/interrupt: Interchange
 prep_irq_for_{kernel_enabled/user}_exit()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <809d316bf5f1a81acdd69e220c13e716dac24f53.1622818556.git.christophe.leroy@csgroup.eu>
In-Reply-To: <809d316bf5f1a81acdd69e220c13e716dac24f53.1622818556.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1623378363.09q00gd3lj.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of June 5, 2021 12:56 am:
> prep_irq_for_user_exit() is a superset of
> prep_irq_for_kernel_enabled_exit(). In order to allow refactoring in
> following patch, interchange the two as prep_irq_for_user_exit() will
> call prep_irq_for_kernel_enabled_exit().
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> This series applies on top of Nic's series to speed up interrupt return o=
n 64s

Thanks for rebasing it.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>=20
>  arch/powerpc/kernel/interrupt.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 74c995a42399..539455c62c5b 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -40,33 +40,27 @@ static inline bool exit_must_hard_disable(void)
>  #endif
> =20
>  /*
> - * local irqs must be disabled. Returns false if the caller must re-enab=
le
> - * them, check for new work, and try again.
> - *
> - * This should be called with local irqs disabled, but if they were prev=
iously
> - * enabled when the interrupt handler returns (indicating a process-cont=
ext /
> - * synchronous interrupt) then irqs_enabled should be true.
> + * restartable is true then EE/RI can be left on because interrupts are =
handled
> + * with a restart sequence.
>   */
> -static notrace __always_inline bool prep_irq_for_user_exit(void)
> +static notrace __always_inline bool prep_irq_for_kernel_enabled_exit(boo=
l restartable)
>  {
> -	user_enter_irqoff();
>  	/* This must be done with RI=3D1 because tracing may touch vmaps */
>  	trace_hardirqs_on();
> =20
>  #ifdef CONFIG_PPC32
>  	__hard_EE_RI_disable();
>  #else
> -	if (exit_must_hard_disable())
> +	if (exit_must_hard_disable() || !restartable)
>  		__hard_EE_RI_disable();
> =20
>  	/* This pattern matches prep_irq_for_idle */
>  	if (unlikely(lazy_irq_pending_nocheck())) {
> -		if (exit_must_hard_disable()) {
> +		if (exit_must_hard_disable() || !restartable) {
>  			local_paca->irq_happened |=3D PACA_IRQ_HARD_DIS;
>  			__hard_RI_enable();
>  		}
>  		trace_hardirqs_off();
> -		user_exit_irqoff();
> =20
>  		return false;
>  	}
> @@ -75,27 +69,33 @@ static notrace __always_inline bool prep_irq_for_user=
_exit(void)
>  }
> =20
>  /*
> - * restartable is true then EE/RI can be left on because interrupts are =
handled
> - * with a restart sequence.
> + * local irqs must be disabled. Returns false if the caller must re-enab=
le
> + * them, check for new work, and try again.
> + *
> + * This should be called with local irqs disabled, but if they were prev=
iously
> + * enabled when the interrupt handler returns (indicating a process-cont=
ext /
> + * synchronous interrupt) then irqs_enabled should be true.
>   */
> -static notrace __always_inline bool prep_irq_for_kernel_enabled_exit(boo=
l restartable)
> +static notrace __always_inline bool prep_irq_for_user_exit(void)
>  {
> +	user_enter_irqoff();
>  	/* This must be done with RI=3D1 because tracing may touch vmaps */
>  	trace_hardirqs_on();
> =20
>  #ifdef CONFIG_PPC32
>  	__hard_EE_RI_disable();
>  #else
> -	if (exit_must_hard_disable() || !restartable)
> +	if (exit_must_hard_disable())
>  		__hard_EE_RI_disable();
> =20
>  	/* This pattern matches prep_irq_for_idle */
>  	if (unlikely(lazy_irq_pending_nocheck())) {
> -		if (exit_must_hard_disable() || !restartable) {
> +		if (exit_must_hard_disable()) {
>  			local_paca->irq_happened |=3D PACA_IRQ_HARD_DIS;
>  			__hard_RI_enable();
>  		}
>  		trace_hardirqs_off();
> +		user_exit_irqoff();
> =20
>  		return false;
>  	}
> --=20
> 2.25.0
>=20
>=20
