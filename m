Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDFC43C0FC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 05:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbhJ0Dus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 23:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbhJ0Dur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 23:50:47 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E575CC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 20:48:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f8so1022105plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 20:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=8gO91DsTavhJqg+CYd5KFooA/zGuCaWHtAcWOf032kA=;
        b=LpTkQdtnAJLNnc9BHs0YPYQXVvzbDou6KylaGUhLebpR/vfuO+aHeeuUdHrYRZ1Lak
         TfBuXYIAMKCiNFVdvhNSEwuT3fklOmKIYdsLutr4GVeVwP1W3wK/A+0L8ma/tRZORnX7
         hBRuDuuc1aBbEEgdTKX5IB1wx96Q+cU5goJWBwjQEZDnoht2k+rMWneY3Yo0E0U1sctQ
         fY+JcO6dw4PQoZ2/p/MMjzAzGBRqTSEbp/aKH6Iyhq1jzFPJQgfupUjUFdgeGKaCYxUM
         wLYJHfr7weuUTJTs4sYrJwH7a3P4OEwXsuN5BL7tBygrnVhAoDsZvrPm0MnO7rltXLK1
         dqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=8gO91DsTavhJqg+CYd5KFooA/zGuCaWHtAcWOf032kA=;
        b=Ekrds+7jBCZGnsaOOgLZoR+DRCIxSgDsy+sOeoZxKfIiEbNHZOuc+nbzCn8aLyBIHO
         pICtr4Ea+Nu/K5ett6Dz6HTat1n+DeO7e2Ae7KJqB96XKyvjHQupakUW2QdFn8og9Jpd
         7nU5BDTEvK2HRaBouB8E528Y+HJLUi35CX5mg1WJA4Z6IOmhvwMo7e+4BDDc8a1CcHoa
         C6U1iwylZEICGRBjxhpzXkZ7r9kHXmem2BaEGeXpzjsQs92FchGDWkUS7RsVx9QXlA++
         cdazcJjzXJQ+3NEHVZzWCgL+aGyghmQG1pXUOtVn8rdvh6NUgVeDB/f86T2tF8S7aUcx
         AaHQ==
X-Gm-Message-State: AOAM531BYk9+eOoipxU86DhiuNMgPoT20QZF2fNmoetZLW1rJ8HyNYi3
        bFp2cyG7lPwvNaiyKwUdx6w=
X-Google-Smtp-Source: ABdhPJx1T6hoLtsV11wC5cTC6hThzao44pBRWK+cjXq03BZPhVaqTlHydelAa64BLDUToZQqxlYXvQ==
X-Received: by 2002:a17:90b:4d0f:: with SMTP id mw15mr3113051pjb.207.1635306502443;
        Tue, 26 Oct 2021 20:48:22 -0700 (PDT)
Received: from localhost ([118.208.159.180])
        by smtp.gmail.com with ESMTPSA id bx1sm2267900pjb.41.2021.10.26.20.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 20:48:22 -0700 (PDT)
Date:   Wed, 27 Oct 2021 13:48:15 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/watchdog: ensure watchdog data accesses are
 protected
To:     benh@kernel.crashing.org, Laurent Dufour <ldufour@linux.ibm.com>,
        mpe@ellerman.id.au, paulus@samba.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20211026162740.16283-1-ldufour@linux.ibm.com>
        <20211026162740.16283-3-ldufour@linux.ibm.com>
In-Reply-To: <20211026162740.16283-3-ldufour@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1635305462.hbdpgat0vx.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Laurent Dufour's message of October 27, 2021 2:27 am:
> The wd_smp_cpus_pending CPU mask should be accessed under the protection =
of
> the __wd_smp_lock.
>=20
> This prevents false alarm to be raised when the system is under an heavy
> stress. This has been seen while doing LPM on large system with a big
> workload.
>=20
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  arch/powerpc/kernel/watchdog.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdo=
g.c
> index bc7411327066..8d7a1a86187e 100644
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -203,12 +203,13 @@ static void watchdog_smp_panic(int cpu, u64 tb)
> =20
>  static void wd_smp_clear_cpu_pending(int cpu, u64 tb)
>  {
> +	unsigned long flags;
> +
> +	wd_smp_lock(&flags);
>  	if (!cpumask_test_cpu(cpu, &wd_smp_cpus_pending)) {
>  		if (unlikely(cpumask_test_cpu(cpu, &wd_smp_cpus_stuck))) {
>  			struct pt_regs *regs =3D get_irq_regs();
> -			unsigned long flags;
> =20
> -			wd_smp_lock(&flags);
>  			cpumask_clear_cpu(cpu, &wd_smp_cpus_stuck);
>  			wd_smp_unlock(&flags);
> =20
> @@ -219,22 +220,23 @@ static void wd_smp_clear_cpu_pending(int cpu, u64 t=
b)
>  				show_regs(regs);
>  			else
>  				dump_stack();
> +			return;
>  		}
> +
> +		wd_smp_unlock(&flags);
>  		return;
>  	}
> +
>  	cpumask_clear_cpu(cpu, &wd_smp_cpus_pending);
>  	if (cpumask_empty(&wd_smp_cpus_pending)) {
> -		unsigned long flags;
> -
> -		wd_smp_lock(&flags);
>  		if (cpumask_empty(&wd_smp_cpus_pending)) {
>  			wd_smp_last_reset_tb =3D tb;
>  			cpumask_andnot(&wd_smp_cpus_pending,
>  					&wd_cpus_enabled,
>  					&wd_smp_cpus_stuck);
>  		}
> -		wd_smp_unlock(&flags);
>  	}
> +	wd_smp_unlock(&flags);

Hmm. I wanted to avoid the lock here because all CPUs will do it on=20
every heartbeat timer.

Although maybe when you look at the cacheline transfers required it=20
doesn't matter much (and the timer is only once every few seconds).

I guess it's always better to aovid lock free craziness unless it's
required... so where is the race coming from? I guess 2 CPUs can
clear wd_smp_cpus_pending but not see one another's update so they
both miss cpumask_empty =3D=3D true! Good catch.

We shouldn't strictly need the wd_smp_lock for the first test, but
that should be an uncommon case, so okay.

Can we clear wd_smp_cpus_pending with a non-atomic operation now?

Thanks,
Nick
