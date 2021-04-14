Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C3B35F402
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347143AbhDNMjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhDNMjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:39:01 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCC3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:38:39 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id e14so20153758lfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xk9yfgt5au3oiQeaHeiiQ0sm0RDhLfKHT6Kyoh92eO0=;
        b=Mu1zJni/GZKiT6gUu/Ugg/8avCOsHctBstaDXco24dbxfkEaEwkNzS8pm13WDfbWHI
         WJXLfEN31TNMtgMf6i9/HK5TV0y2CRZHJaUOqpjpUxPPZ14Z2TLcg6j8vySDGbxf27kL
         mT8J9w7dWlkgo+o/poo9whdUnrwTzx4NcSDKOBOgkCSlasA9iuxc67+piZvCg1X07U3w
         2X9fPzvb2XYWzG0ZKQOyvML1jDLMezfQbqoBGbQ+G1FyR8AL9dyKf/MtskR8bDGQ9Pz8
         qnE11Xgl1yM+uSOH5lDLJPbmf6E0XrsgYQXjDFAVDo0Tn+jbCU9izPml8/uLR/lkMTL+
         OFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xk9yfgt5au3oiQeaHeiiQ0sm0RDhLfKHT6Kyoh92eO0=;
        b=qwuOtD+FTLVuY5txfVXrCflilcnnZ01VjiWlONWz1d0qaVYiIWtZvNfAUlTcvBY9YM
         cqhu5GvIeMYAB9o7Nq2UcyrHolWcOzY6bXYzTNjmiDluLk/vZLEHdncQxGML2wEn/El5
         UEROBaavA9Zr1OTTGAnPvKO6U/ivUSbAxZEk97ZL7jyz7/HS08VPxV0rH6sx8ta6SUaa
         wtJuJSccyYVryO8+JyJcm0doiynyP6uBi5Wa6AJ1bxu1tYwIoc4XNLW1NQIjvJuUtZNs
         KYA1IKtc19i0FCRY4xBFZRcY9BSXkou6y/7mjuqMJ6T+ocMTQ6wExhplvq7zi2Q90EFT
         yqSg==
X-Gm-Message-State: AOAM530wxQoR7MvZmoWKrM6JtD7o2fn+ECEcqbWUxp1vnBEft6l6hper
        iPX0rx8/JpPqn6PjaajfwnOmDRnSRd+lyXI3t4A=
X-Google-Smtp-Source: ABdhPJyr20Zo2gumoxespfxEIHWLgNAmKT5X2P3KtWY+TzQEwsIUpAos7kEQrJPC3Zy/pdTdAICRVEaHLo5aq1PD05Y=
X-Received: by 2002:ac2:46c1:: with SMTP id p1mr15308522lfo.210.1618403918282;
 Wed, 14 Apr 2021 05:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210414122326.5255-1-ruifeng.zhang0110@gmail.com> <20210414122326.5255-2-ruifeng.zhang0110@gmail.com>
In-Reply-To: <20210414122326.5255-2-ruifeng.zhang0110@gmail.com>
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Date:   Wed, 14 Apr 2021 20:38:07 +0800
Message-ID: <CAG7+-3OiFQDrZAasnFyJaYobgXMN8S9MTtHjzOB+_W9DAMeFwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm: topology: parse the topology from the dt
To:     linux@armlinux.org.uk, sudeep.holla@arm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, a.p.zijlstra@chello.nl,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com
Cc:     linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Dietmar,

In the last, update_cpu_capacity(cpuid) must be called in
store_cpu_topology because the cpuid_topo->package_id is always be the
initialization value.

Because of added the DT parsing logic, the cpuid_topo->package_id will
be parse in driver/base/arch_topology and the update_cpu_capacity
can't be called if DT has cpu-map.

Update cpu capacity isn't related with cpu topology, so move it to the
beginning of this function.

Please help to review and test the new patch, thanks.

Ruifeng Zhang <ruifeng.zhang0110@gmail.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=
=8814=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:24=E5=86=99=E9=81=93=
=EF=BC=9A
>
> From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
>
> The arm topology still parse from the MPIDR, but it is incomplete.  When
> the armv8.2 or above cpu runs kernel in EL1 with aarch32 mode, it will
> parse out the wrong topology.
>
> Changed:
> 1) Arm using the same parse_dt_topology function as arm64.
> 2) For compatibility to keep the function of get capacity from default
>    cputype, renamed arm parse_dt_topology to get_efficiency_capacity and
>    delete related logic of parse from dt.
> 3) The update_cpu_capacity function should not depend on the topology, so
>    it is moved to the beginning of store_cpu_topology.
>
> The arm device boot step is to look for the efficiency_capacity firstly.
> Then parse the topology and capacity from dt to replace efficiency value.
>
> Signed-off-by: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> Signed-off-by: Nianfu Bai <nianfu.bai@unisoc.com>
> ---
>  arch/arm/kernel/topology.c    | 22 ++++++----------------
>  drivers/base/arch_topology.c  |  4 ++--
>  include/linux/arch_topology.h |  1 +
>  3 files changed, 9 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index ef0058de432b..93d875320cc4 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -72,7 +72,6 @@ static unsigned long *__cpu_capacity;
>  #define cpu_capacity(cpu)      __cpu_capacity[cpu]
>
>  static unsigned long middle_capacity =3D 1;
> -static bool cap_from_dt =3D true;
>
>  /*
>   * Iterate all CPUs' descriptor in DT and compute the efficiency
> @@ -82,7 +81,7 @@ static bool cap_from_dt =3D true;
>   * 'average' CPU is of middle capacity. Also see the comments near
>   * table_efficiency[] and update_cpu_capacity().
>   */
> -static void __init parse_dt_topology(void)
> +static void __init get_coretype_capacity(void)
>  {
>         const struct cpu_efficiency *cpu_eff;
>         struct device_node *cn =3D NULL;
> @@ -105,13 +104,6 @@ static void __init parse_dt_topology(void)
>                         continue;
>                 }
>
> -               if (topology_parse_cpu_capacity(cn, cpu)) {
> -                       of_node_put(cn);
> -                       continue;
> -               }
> -
> -               cap_from_dt =3D false;
> -
>                 for (cpu_eff =3D table_efficiency; cpu_eff->compatible; c=
pu_eff++)
>                         if (of_device_is_compatible(cn, cpu_eff->compatib=
le))
>                                 break;
> @@ -151,9 +143,6 @@ static void __init parse_dt_topology(void)
>         else
>                 middle_capacity =3D ((max_capacity / 3)
>                                 >> (SCHED_CAPACITY_SHIFT-1)) + 1;
> -
> -       if (cap_from_dt)
> -               topology_normalize_cpu_scale();
>  }
>
>  /*
> @@ -163,7 +152,7 @@ static void __init parse_dt_topology(void)
>   */
>  static void update_cpu_capacity(unsigned int cpu)
>  {
> -       if (!cpu_capacity(cpu) || cap_from_dt)
> +       if (!cpu_capacity(cpu))
>                 return;
>
>         topology_set_cpu_scale(cpu, cpu_capacity(cpu) / middle_capacity);
> @@ -173,7 +162,7 @@ static void update_cpu_capacity(unsigned int cpu)
>  }
>
>  #else
> -static inline void parse_dt_topology(void) {}
> +static inline void get_cputype_capacity(void) {}
>  static inline void update_cpu_capacity(unsigned int cpuid) {}
>  #endif
>
> @@ -187,6 +176,8 @@ void store_cpu_topology(unsigned int cpuid)
>         struct cpu_topology *cpuid_topo =3D &cpu_topology[cpuid];
>         unsigned int mpidr;
>
> +       update_cpu_capacity(cpuid);
> +
>         if (cpuid_topo->package_id !=3D -1)
>                 goto topology_populated;
>
> @@ -221,8 +212,6 @@ void store_cpu_topology(unsigned int cpuid)
>                 cpuid_topo->package_id =3D -1;
>         }
>
> -       update_cpu_capacity(cpuid);
> -
>         pr_info("CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
>                 cpuid, cpu_topology[cpuid].thread_id,
>                 cpu_topology[cpuid].core_id,
> @@ -241,5 +230,6 @@ void __init init_cpu_topology(void)
>         reset_cpu_topology();
>         smp_wmb();
>
> +       get_coretype_capacity();
>         parse_dt_topology();
>  }
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index de8587cc119e..a45aec356ec4 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -295,7 +295,7 @@ static void parsing_done_workfn(struct work_struct *w=
ork)
>  core_initcall(free_raw_capacity);
>  #endif
>
> -#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV=
)
>  /*
>   * This function returns the logic cpu number of the node.
>   * There are basically three kinds of return values:
> @@ -441,7 +441,7 @@ static int __init parse_cluster(struct device_node *c=
luster, int depth)
>         return 0;
>  }
>
> -static int __init parse_dt_topology(void)
> +int __init parse_dt_topology(void)
>  {
>         struct device_node *cn, *map;
>         int ret =3D 0;
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.=
h
> index 0f6cd6b73a61..cfa5a5072aa0 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -66,6 +66,7 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
>  #define topology_llc_cpumask(cpu)      (&cpu_topology[cpu].llc_sibling)
>  void init_cpu_topology(void);
>  void store_cpu_topology(unsigned int cpuid);
> +int __init parse_dt_topology(void);
>  const struct cpumask *cpu_coregroup_mask(int cpu);
>  void update_siblings_masks(unsigned int cpu);
>  void remove_cpu_topology(unsigned int cpuid);
> --
> 2.17.1
>
