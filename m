Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5A443C0C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 05:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbhJ0Dbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 23:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237933AbhJ0Dbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 23:31:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D37C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 20:29:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n18so1037763plc.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 20:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=NXckBatBmWTSXNXn03oaE/p+PJTLMJ+R30YiT9U+OEM=;
        b=ocaWQhMqVkYOQcl3SA4dEewUp9B7B3qBGmhZQ9CoV5RuyRQi9pnVEyDXRZhG3YczZu
         nucYIzbE5pW58fspVIJQ5lmxCVn+aKqJgdup4DVBM8p2m7sfY5Q/QGgJTK/h4UUV3ghc
         9HfpqnFHCFIMz5UUkS4s/qkznW/NCRkl3b1rKxyBBifAyFmwbB+4UwpCsIzveQ3/5DT4
         +XidmvVDoyq4voUCUKz7IWXot8XO5eijDnppeZ43HQeby7j3e/CiO+z3Mm0mvgUlHjXu
         VtYj3rhgeMFZ4f80JnUAU/5Dz5tl48LlxXJnHPlusOr8zFcFtwqxsLAntOMgcmKlvIFn
         XTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=NXckBatBmWTSXNXn03oaE/p+PJTLMJ+R30YiT9U+OEM=;
        b=cechkztcMK/Th4USKGqhurSik4eEbWSLWFpTB7UtSznU6DR2l7aXVRQi1ojdHGD/hO
         ld+OTi/pQ1hmyGAcbchUNEugmtzRLtAAdJKBsCh3YsFsYl1liA5AbG9p2m4BFVi9Tu/J
         WQPj1jKoa3YobdzPxD9LaKJ/o0/5rnFdyjkS0fng9uGFmo6aUW/WggsmRXu/0GjNip/z
         S+6sg7JKg7y5FrSbBeXqzJ4IycSl3oe0vk4HVzR9CRP2X6B8EVyxBAu/2MZ7mtVsEBzd
         ofUGjCQ+9DjUw6def6enMtt9IIwumF3RMhBQNmtUrZHtawh137YHaCJb8WKgUnFEqb6Y
         ZJhQ==
X-Gm-Message-State: AOAM5329jyKpNvHRXBtOb6FLSIHUi4bvMyoYI96Dh8kNlohMumlPGq3B
        fVsv3/7ZMiqKa8xw91xKT1BvSS+9ZJA=
X-Google-Smtp-Source: ABdhPJwYvxE3YBrvq0yjV4xfpWcMLt9txmaD9H6pzbnOOqYTHOIALXW3GVtOoY0vZfPN8l/SQ+2sGw==
X-Received: by 2002:a17:90a:488d:: with SMTP id b13mr3133186pjh.152.1635305355452;
        Tue, 26 Oct 2021 20:29:15 -0700 (PDT)
Received: from localhost ([118.208.159.180])
        by smtp.gmail.com with ESMTPSA id m2sm20384044pgd.70.2021.10.26.20.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 20:29:15 -0700 (PDT)
Date:   Wed, 27 Oct 2021 13:29:10 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/watchdog: prevent printk and send IPI while
 holding the wd lock
To:     benh@kernel.crashing.org, Laurent Dufour <ldufour@linux.ibm.com>,
        mpe@ellerman.id.au, paulus@samba.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20211026162740.16283-1-ldufour@linux.ibm.com>
        <20211026162740.16283-2-ldufour@linux.ibm.com>
In-Reply-To: <20211026162740.16283-2-ldufour@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1635303699.wgz87uxy4c.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Laurent Dufour's message of October 27, 2021 2:27 am:
> When handling the Watchdog interrupt, long processing should not be done
> while holding the __wd_smp_lock. This prevents the other CPUs to grab it
> and to process Watchdog timer interrupts. Furhtermore, this could lead to
> the following situation:
>=20
> CPU x detect lockup on CPU y and grab the __wd_smp_lock
>       in watchdog_smp_panic()
> CPU y caught the watchdog interrupt and try to grab the __wd_smp_lock
>       in soft_nmi_interrupt()
> CPU x wait for CPU y to catch the IPI for 1s in __smp_send_nmi_ipi()

CPU y should get the IPI here if it's a NMI IPI (which will be true for=20
>=3D POWER9 64s).

That said, not all platforms support it and the console lock problem
seems real, so okay.

> CPU x will timeout and so has spent 1s waiting while holding the
>       __wd_smp_lock.
>=20
> A deadlock may also happen between the __wd_smp_lock and the console_owne=
r
> 'lock' this way:
> CPU x grab the console_owner
> CPU y grab the __wd_smp_lock
> CPU x catch the watchdog timer interrupt and needs to grab __wd_smp_lock
> CPU y wants to print something and wait for console_owner
> -> deadlock
>=20
> Doing all the long processing without holding the _wd_smp_lock prevents
> these situations.

The intention was to avoid logs getting garbled e.g., if multiple=20
different CPUs fire at once.

I wonder if instead we could deal with that by protecting the IPI=20
sending and printing stuff with a trylock, and if you don't get the
trylock then just return, and you'll come back with the next timer
interrupt.

Thanks,
Nick

>=20
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  arch/powerpc/kernel/watchdog.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdo=
g.c
> index f9ea0e5357f9..bc7411327066 100644
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -149,6 +149,8 @@ static void set_cpu_stuck(int cpu, u64 tb)
> =20
>  static void watchdog_smp_panic(int cpu, u64 tb)
>  {
> +	cpumask_t cpus_pending_copy;
> +	u64 last_reset_tb_copy;
>  	unsigned long flags;
>  	int c;
> =20
> @@ -161,29 +163,32 @@ static void watchdog_smp_panic(int cpu, u64 tb)
>  	if (cpumask_weight(&wd_smp_cpus_pending) =3D=3D 0)
>  		goto out;
> =20
> +	cpumask_copy(&cpus_pending_copy, &wd_smp_cpus_pending);
> +	last_reset_tb_copy =3D wd_smp_last_reset_tb;
> +
> +	/* Take the stuck CPUs out of the watch group */
> +	set_cpumask_stuck(&wd_smp_cpus_pending, tb);
> +
> +	wd_smp_unlock(&flags);
> +
>  	pr_emerg("CPU %d detected hard LOCKUP on other CPUs %*pbl\n",
> -		 cpu, cpumask_pr_args(&wd_smp_cpus_pending));
> +		 cpu, cpumask_pr_args(&cpus_pending_copy));
>  	pr_emerg("CPU %d TB:%lld, last SMP heartbeat TB:%lld (%lldms ago)\n",
> -		 cpu, tb, wd_smp_last_reset_tb,
> -		 tb_to_ns(tb - wd_smp_last_reset_tb) / 1000000);
> +		 cpu, tb, last_reset_tb_copy,
> +		 tb_to_ns(tb - last_reset_tb_copy) / 1000000);
> =20
>  	if (!sysctl_hardlockup_all_cpu_backtrace) {
>  		/*
>  		 * Try to trigger the stuck CPUs, unless we are going to
>  		 * get a backtrace on all of them anyway.
>  		 */
> -		for_each_cpu(c, &wd_smp_cpus_pending) {
> +		for_each_cpu(c, &cpus_pending_copy) {
>  			if (c =3D=3D cpu)
>  				continue;
>  			smp_send_nmi_ipi(c, wd_lockup_ipi, 1000000);
>  		}
>  	}
> =20
> -	/* Take the stuck CPUs out of the watch group */
> -	set_cpumask_stuck(&wd_smp_cpus_pending, tb);
> -
> -	wd_smp_unlock(&flags);
> -
>  	if (sysctl_hardlockup_all_cpu_backtrace)
>  		trigger_allbutself_cpu_backtrace();
> =20
> @@ -204,6 +209,8 @@ static void wd_smp_clear_cpu_pending(int cpu, u64 tb)
>  			unsigned long flags;
> =20
>  			wd_smp_lock(&flags);
> +			cpumask_clear_cpu(cpu, &wd_smp_cpus_stuck);
> +			wd_smp_unlock(&flags);
> =20
>  			pr_emerg("CPU %d became unstuck TB:%lld\n",
>  				 cpu, tb);
> @@ -212,9 +219,6 @@ static void wd_smp_clear_cpu_pending(int cpu, u64 tb)
>  				show_regs(regs);
>  			else
>  				dump_stack();
> -
> -			cpumask_clear_cpu(cpu, &wd_smp_cpus_stuck);
> -			wd_smp_unlock(&flags);
>  		}
>  		return;
>  	}
> @@ -267,6 +271,7 @@ DEFINE_INTERRUPT_HANDLER_NMI(soft_nmi_interrupt)
>  			return 0;
>  		}
>  		set_cpu_stuck(cpu, tb);
> +		wd_smp_unlock(&flags);
> =20
>  		pr_emerg("CPU %d self-detected hard LOCKUP @ %pS\n",
>  			 cpu, (void *)regs->nip);
> @@ -277,8 +282,6 @@ DEFINE_INTERRUPT_HANDLER_NMI(soft_nmi_interrupt)
>  		print_irqtrace_events(current);
>  		show_regs(regs);
> =20
> -		wd_smp_unlock(&flags);
> -
>  		if (sysctl_hardlockup_all_cpu_backtrace)
>  			trigger_allbutself_cpu_backtrace();
> =20
> --=20
> 2.33.1
>=20
>=20
