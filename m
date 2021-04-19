Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153CC363988
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhDSC4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhDSC4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:56:20 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCC7C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 19:55:51 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a5so641134ljk.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 19:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qd/yXQAnNmWhACo+8fVhgtz40BtwSFB9zrVnZViVRO8=;
        b=gtjr8gcNr26kZ1CsfgkVIw3RTMLODTi9h87JQUJJVFZkSHETRuQelo7d6XQbZdAmmi
         o8SDHJQ93LDtFoP2Rm/A5DlRrcygdr/TJOnch8FNRimOVvn/a4YUHCyJlqUBr+DV5e9h
         Dx8A/h8akMoB2kPWiEvzZuirIbc8A/SFypJmMp38q1iBfOl8iKgJXVItvQ1lb9zh8uWy
         4HXNuPpo47Gz5ilPj+ZMJFnb02hy4xULoIKYg3Jpv/jZHS0nWB5vKcn+zS0deHZbmmI8
         Lxo/0fafzBmvtPOQQWp1YmZiPowFpGhqsIv1tW6uukuvb9VGbcbx2zeEjNwHV3uxeScK
         NqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qd/yXQAnNmWhACo+8fVhgtz40BtwSFB9zrVnZViVRO8=;
        b=LRRyAFP44Yo5j4u1/mWVbTkfHXo0Qj11rDfpzCaUwDofcF2lhCvK9jPPxnt0ZijZEM
         MhXXipugumlh8MOYoP2eZ0mRVh8xlInZeWlvk5uj7e/z2MPRA6AlznntiAktcnSiDX7l
         3hg2jnqum5Y9zzTs48dfgkgloUvTjzmT23A0XZzAHhiFotSn6DbxLOAA3hoIx5l4tA43
         bFxA/UrA/iznZpX+URoMSF0zVrBSeAjIbc7NRYxio59w9cHdORMp27XMAO/ODLZSNuhg
         WzFlenqeRnEdpJb92urNI9FLSPwVk7N2vvH/FGBBObW5xgNiy4hsq/c77jVuuLtdJh2u
         JswQ==
X-Gm-Message-State: AOAM532qpJeA47eSpwwTR1FacxP9gvkGZ2LYTgudbSmtNKHee61RsS/+
        yivVyzb6zvYowHNtPOa7oKfJHtRftFbTGNaiw7o=
X-Google-Smtp-Source: ABdhPJxlpL6k3l3ULS+LH3sJREWlKCdtG0CsGJHRecaAhcq+5zmQ0OCLwYzEsEJXNkWeZFqcqfcKE9ELVfwgLVAr6f4=
X-Received: by 2002:a2e:b4f2:: with SMTP id s18mr10048751ljm.138.1618800949482;
 Sun, 18 Apr 2021 19:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210414122326.5255-1-ruifeng.zhang0110@gmail.com>
 <8735vrmnc7.mognet@arm.com> <b7a76995-f6c3-67c5-b14e-d40587495d7e@arm.com>
 <CAG7+-3Nv=m0pd8t0eQEUv5zSeg86hfkKcs_VLzsbzWFabYbTTQ@mail.gmail.com>
 <87wnt2lglo.mognet@arm.com> <44ab835f-3456-6bd9-97e9-5936cf5372da@arm.com>
 <CAG7+-3OgN4Kx3Md1tOmqHDLs94DSv2puh=kA0oFMw+aZGnb3iw@mail.gmail.com> <2a4efeea-cc70-ca0a-81fd-84d8b54586c0@arm.com>
In-Reply-To: <2a4efeea-cc70-ca0a-81fd-84d8b54586c0@arm.com>
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Date:   Mon, 19 Apr 2021 10:55:14 +0800
Message-ID: <CAG7+-3MX8Ntzh-fiTFZq-d9EO4GNpY2b3AuAOZPxVmxA=jNtNg@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] arm: topology: parse the topology from the dt
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux@armlinux.org.uk, sudeep.holla@arm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, a.p.zijlstra@chello.nl,
        mingo@kernel.org, ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dietmar Eggemann <dietmar.eggemann@arm.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=
=8817=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=881:00=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On 16/04/2021 13:04, Ruifeng Zhang wrote:
> > Dietmar Eggemann <dietmar.eggemann@arm.com> =E4=BA=8E2021=E5=B9=B44=E6=
=9C=8816=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:39=E5=86=99=E9=81=
=93=EF=BC=9A
> >>
> >> On 16/04/2021 11:32, Valentin Schneider wrote:
> >>> On 16/04/21 15:47, Ruifeng Zhang wrote:
>
> [...]
>
> >> I'm confused. Do you have the MT bit set to 1 then? So the issue that
> >> the mpidr handling in arm32's store_cpu_topology() is not correct does
> >> not exist?
> >
> > I have reconfirmed it, the MT bit has been set to 1. I am sorry for
> > the previous messages.
> > The mpidr parse by store_cpu_topology is correct, at least for the sc98=
63a.
>
> Nice! This is sorted then.
>
> [...]
>
> >> Is this what you need for your arm32 kernel system? Adding the
> >> possibility to parse cpu-map to create Phantom Domains?
> >
> > Yes, I need parse DT cpu-map to create different Phantom Domains.
> > With it, the dts should be change to:
> >                 cpu-map {
> >                         cluster0 {
> >                                 core0 {
> >                                         cpu =3D <&CPU0>;
> >                                 };
> >                                 core1 {
> >                                         cpu =3D <&CPU1>;
> >                                 };
> >                                 core2 {
> >                                         cpu =3D <&CPU2>;
> >                                 };
> >                                 core3 {
> >                                         cpu =3D <&CPU3>;
> >                                 };
> >                         };
> >
> >                         cluster1 {
> >                                 core0 {
> >                                         cpu =3D <&CPU4>;
> >                                 };
> >                                 core1 {
> >                                         cpu =3D <&CPU5>;
> >                                 };
> >                                 core2 {
> >                                         cpu =3D <&CPU6>;
> >                                 };
> >                                 core3 {
> >                                         cpu =3D <&CPU7>;
> >                                 };
> >                         };
> >                 };
> >
>
> I'm afraid that this is now a much weaker case to get this into
> mainline.

But it's still a problem and it's not break the original logic ( parse
topology from MPIDR or parse capacity ), only add the support for
parse topology from DT.
I think it should still be merged into the mainline. If don't, the
DynamIQ SoC has some issue in sched and cpufreq.
>
> I'm able to run with an extra cpu-map entry:

Great.
>
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/d=
ts/vexpress-v2p-ca15_a7.dts
> index 012d40a7228c..f60d9b448253 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> @@ -35,6 +35,29 @@ cpus {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>
> +               cpu-map {
> +                       cluster0 {
> +                               core0 {
> +                                       cpu =3D <&cpu0>;
> +                               };
> +                               core1 {
> +                                       cpu =3D <&cpu1>;
> +                               };
> +                       };
> +
> +                       cluster1 {
> +                               core0 {
> +                                       cpu =3D <&cpu2>;
> +                               };
> +                               core1 {
> +                                       cpu =3D <&cpu3>;
> +                               };
> +                               core2 {
> +                                       cpu =3D <&cpu4>;
> +                               };
> +                       };
> +               };
> +
>                 cpu0: cpu@0 {
>
> a condensed version (see below) of your patch on my Arm32 TC2.
> The move of update_cpu_capacity() in store_cpu_topology() is only
> necessary when I use the old clock-frequency based cpu_efficiency
> approach for asymmetric CPU capacity (TC2 is a15/a7):
>
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/d=
ts/vexpress-v2p-ca15_a7.dts
> index f60d9b448253..e0679cca40ed 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> @@ -64,7 +64,7 @@ cpu0: cpu@0 {
>                         reg =3D <0>;
>                         cci-control-port =3D <&cci_control1>;
>                         cpu-idle-states =3D <&CLUSTER_SLEEP_BIG>;
> -                       capacity-dmips-mhz =3D <1024>;
> +                       clock-frequency =3D <1000000000>;
>                         dynamic-power-coefficient =3D <990>;
>                 };
>
> @@ -74,7 +74,7 @@ cpu1: cpu@1 {
>                         reg =3D <1>;
>                         cci-control-port =3D <&cci_control1>;
>                         cpu-idle-states =3D <&CLUSTER_SLEEP_BIG>;
> -                       capacity-dmips-mhz =3D <1024>;
> +                       clock-frequency =3D <1000000000>;
>                         dynamic-power-coefficient =3D <990>;
>                 };
>
> @@ -84,7 +84,7 @@ cpu2: cpu@2 {
>                         reg =3D <0x100>;
>                         cci-control-port =3D <&cci_control2>;
>                         cpu-idle-states =3D <&CLUSTER_SLEEP_LITTLE>;
> -                       capacity-dmips-mhz =3D <516>;
> +                       clock-frequency =3D <800000000>;
>                         dynamic-power-coefficient =3D <133>;
>                 };
>
> @@ -94,7 +94,7 @@ cpu3: cpu@3 {
>                         reg =3D <0x101>;
>                         cci-control-port =3D <&cci_control2>;
>                         cpu-idle-states =3D <&CLUSTER_SLEEP_LITTLE>;
> -                       capacity-dmips-mhz =3D <516>;
> +                       clock-frequency =3D <800000000>;
>                         dynamic-power-coefficient =3D <133>;
>                 };
>
> @@ -104,7 +104,7 @@ cpu4: cpu@4 {
>                         reg =3D <0x102>;
>                         cci-control-port =3D <&cci_control2>;
>                         cpu-idle-states =3D <&CLUSTER_SLEEP_LITTLE>;
> -                       capacity-dmips-mhz =3D <516>;
> +                       clock-frequency =3D <800000000>;
>                         dynamic-power-coefficient =3D <133>;
>                 };
>
>
>
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index ef0058de432b..bff56c12c3a6 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -82,7 +82,7 @@ static bool cap_from_dt =3D true;
>   * 'average' CPU is of middle capacity. Also see the comments near
>   * table_efficiency[] and update_cpu_capacity().
>   */
> -static void __init parse_dt_topology(void)
> +static void __init get_coretype_capacity(void)
>  {
>         const struct cpu_efficiency *cpu_eff;
>         struct device_node *cn =3D NULL;
> @@ -173,7 +173,7 @@ static void update_cpu_capacity(unsigned int cpu)
>  }
>
>  #else
> -static inline void parse_dt_topology(void) {}
> +static inline void get_coretype_capacity(void) {}
>  static inline void update_cpu_capacity(unsigned int cpuid) {}
>  #endif
>
> @@ -221,14 +221,13 @@ void store_cpu_topology(unsigned int cpuid)
>                 cpuid_topo->package_id =3D -1;
>         }
>
> -       update_cpu_capacity(cpuid);
> -
>         pr_info("CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
>                 cpuid, cpu_topology[cpuid].thread_id,
>                 cpu_topology[cpuid].core_id,
>                 cpu_topology[cpuid].package_id, mpidr);
>
>  topology_populated:
> +       update_cpu_capacity(cpuid);

Agree, it's more better than mine.
>         update_siblings_masks(cpuid);
>  }
>
> @@ -241,5 +240,6 @@ void __init init_cpu_topology(void)
>         reset_cpu_topology();
>         smp_wmb();
>
> +       get_coretype_capacity();
>         parse_dt_topology();
>  }
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index de8587cc119e..a2335da28f2a 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -295,7 +295,6 @@ static void parsing_done_workfn(struct work_struct *w=
ork)
>  core_initcall(free_raw_capacity);
>  #endif
>
> -#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)

It seems that the following functions are not defined on other CPU
architectures now, so I agree to remove it.
>  /*
>   * This function returns the logic cpu number of the node.
>   * There are basically three kinds of return values:
> @@ -441,7 +440,7 @@ static int __init parse_cluster(struct device_node *c=
luster, int depth)
>         return 0;
>  }
>
> -static int __init parse_dt_topology(void)
> +int __init parse_dt_topology(void)
>  {
>         struct device_node *cn, *map;
>         int ret =3D 0;
> @@ -481,7 +480,6 @@ static int __init parse_dt_topology(void)
>         of_node_put(cn);
>         return ret;
>  }
> -#endif
>
>  /*
>   * cpu topology table
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

Why do you keep the logic of topology_parse_cpu_capacity in arm
get_coretype_capacity function? The capacity-dmips-mhz will be parsed
by drivers/base/arch_topology.c as following:
parse_dt_topology
    parse_cluster
        parse_core
            get_cpu_for_node
                topology_parse_cpu_capacity
