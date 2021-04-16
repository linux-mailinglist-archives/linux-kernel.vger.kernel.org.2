Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A83F36263E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbhDPRBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:01:06 -0400
Received: from foss.arm.com ([217.140.110.172]:46232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234774AbhDPRBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:01:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D79F011B3;
        Fri, 16 Apr 2021 10:00:39 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1C4B3F99C;
        Fri, 16 Apr 2021 10:00:37 -0700 (PDT)
Subject: Re: [PATCH v2 0/1] arm: topology: parse the topology from the dt
To:     Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux@armlinux.org.uk, sudeep.holla@arm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, a.p.zijlstra@chello.nl,
        mingo@kernel.org, ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210414122326.5255-1-ruifeng.zhang0110@gmail.com>
 <8735vrmnc7.mognet@arm.com> <b7a76995-f6c3-67c5-b14e-d40587495d7e@arm.com>
 <CAG7+-3Nv=m0pd8t0eQEUv5zSeg86hfkKcs_VLzsbzWFabYbTTQ@mail.gmail.com>
 <87wnt2lglo.mognet@arm.com> <44ab835f-3456-6bd9-97e9-5936cf5372da@arm.com>
 <CAG7+-3OgN4Kx3Md1tOmqHDLs94DSv2puh=kA0oFMw+aZGnb3iw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2a4efeea-cc70-ca0a-81fd-84d8b54586c0@arm.com>
Date:   Fri, 16 Apr 2021 19:00:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAG7+-3OgN4Kx3Md1tOmqHDLs94DSv2puh=kA0oFMw+aZGnb3iw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2021 13:04, Ruifeng Zhang wrote:
> Dietmar Eggemann <dietmar.eggemann@arm.com> 于2021年4月16日周五 下午6:39写道：
>>
>> On 16/04/2021 11:32, Valentin Schneider wrote:
>>> On 16/04/21 15:47, Ruifeng Zhang wrote:

[...]

>> I'm confused. Do you have the MT bit set to 1 then? So the issue that
>> the mpidr handling in arm32's store_cpu_topology() is not correct does
>> not exist?
> 
> I have reconfirmed it, the MT bit has been set to 1. I am sorry for
> the previous messages.
> The mpidr parse by store_cpu_topology is correct, at least for the sc9863a.

Nice! This is sorted then.

[...]

>> Is this what you need for your arm32 kernel system? Adding the
>> possibility to parse cpu-map to create Phantom Domains?
> 
> Yes, I need parse DT cpu-map to create different Phantom Domains.
> With it, the dts should be change to:
>                 cpu-map {
>                         cluster0 {
>                                 core0 {
>                                         cpu = <&CPU0>;
>                                 };
>                                 core1 {
>                                         cpu = <&CPU1>;
>                                 };
>                                 core2 {
>                                         cpu = <&CPU2>;
>                                 };
>                                 core3 {
>                                         cpu = <&CPU3>;
>                                 };
>                         };
> 
>                         cluster1 {
>                                 core0 {
>                                         cpu = <&CPU4>;
>                                 };
>                                 core1 {
>                                         cpu = <&CPU5>;
>                                 };
>                                 core2 {
>                                         cpu = <&CPU6>;
>                                 };
>                                 core3 {
>                                         cpu = <&CPU7>;
>                                 };
>                         };
>                 };
> 

I'm afraid that this is now a much weaker case to get this into
mainline.

I'm able to run with an extra cpu-map entry:

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 012d40a7228c..f60d9b448253 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -35,6 +35,29 @@ cpus {
                #address-cells = <1>;
                #size-cells = <0>;
 
+               cpu-map {
+                       cluster0 {
+                               core0 {
+                                       cpu = <&cpu0>;
+                               };
+                               core1 {
+                                       cpu = <&cpu1>;
+                               };
+                       };
+
+                       cluster1 {
+                               core0 {
+                                       cpu = <&cpu2>;
+                               };
+                               core1 {
+                                       cpu = <&cpu3>;
+                               };
+                               core2 {
+                                       cpu = <&cpu4>;
+                               };
+                       };
+               };
+
                cpu0: cpu@0 {
 
a condensed version (see below) of your patch on my Arm32 TC2.
The move of update_cpu_capacity() in store_cpu_topology() is only
necessary when I use the old clock-frequency based cpu_efficiency
approach for asymmetric CPU capacity (TC2 is a15/a7):

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index f60d9b448253..e0679cca40ed 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -64,7 +64,7 @@ cpu0: cpu@0 {
                        reg = <0>;
                        cci-control-port = <&cci_control1>;
                        cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
-                       capacity-dmips-mhz = <1024>;
+                       clock-frequency = <1000000000>;
                        dynamic-power-coefficient = <990>;
                };
 
@@ -74,7 +74,7 @@ cpu1: cpu@1 {
                        reg = <1>;
                        cci-control-port = <&cci_control1>;
                        cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
-                       capacity-dmips-mhz = <1024>;
+                       clock-frequency = <1000000000>;
                        dynamic-power-coefficient = <990>;
                };
 
@@ -84,7 +84,7 @@ cpu2: cpu@2 {
                        reg = <0x100>;
                        cci-control-port = <&cci_control2>;
                        cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
-                       capacity-dmips-mhz = <516>;
+                       clock-frequency = <800000000>;
                        dynamic-power-coefficient = <133>;
                };
 
@@ -94,7 +94,7 @@ cpu3: cpu@3 {
                        reg = <0x101>;
                        cci-control-port = <&cci_control2>;
                        cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
-                       capacity-dmips-mhz = <516>;
+                       clock-frequency = <800000000>;
                        dynamic-power-coefficient = <133>;
                };
 
@@ -104,7 +104,7 @@ cpu4: cpu@4 {
                        reg = <0x102>;
                        cci-control-port = <&cci_control2>;
                        cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
-                       capacity-dmips-mhz = <516>;
+                       clock-frequency = <800000000>;
                        dynamic-power-coefficient = <133>;
                };



diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ef0058de432b..bff56c12c3a6 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -82,7 +82,7 @@ static bool cap_from_dt = true;
  * 'average' CPU is of middle capacity. Also see the comments near
  * table_efficiency[] and update_cpu_capacity().
  */
-static void __init parse_dt_topology(void)
+static void __init get_coretype_capacity(void)
 {
        const struct cpu_efficiency *cpu_eff;
        struct device_node *cn = NULL;
@@ -173,7 +173,7 @@ static void update_cpu_capacity(unsigned int cpu)
 }
 
 #else
-static inline void parse_dt_topology(void) {}
+static inline void get_coretype_capacity(void) {}
 static inline void update_cpu_capacity(unsigned int cpuid) {}
 #endif
 
@@ -221,14 +221,13 @@ void store_cpu_topology(unsigned int cpuid)
                cpuid_topo->package_id = -1;
        }
 
-       update_cpu_capacity(cpuid);
-
        pr_info("CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
                cpuid, cpu_topology[cpuid].thread_id,
                cpu_topology[cpuid].core_id,
                cpu_topology[cpuid].package_id, mpidr);
 
 topology_populated:
+       update_cpu_capacity(cpuid);
        update_siblings_masks(cpuid);
 }
 
@@ -241,5 +240,6 @@ void __init init_cpu_topology(void)
        reset_cpu_topology();
        smp_wmb();
 
+       get_coretype_capacity();
        parse_dt_topology();
 }
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index de8587cc119e..a2335da28f2a 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -295,7 +295,6 @@ static void parsing_done_workfn(struct work_struct *work)
 core_initcall(free_raw_capacity);
 #endif
 
-#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 /*
  * This function returns the logic cpu number of the node.
  * There are basically three kinds of return values:
@@ -441,7 +440,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
        return 0;
 }
 
-static int __init parse_dt_topology(void)
+int __init parse_dt_topology(void)
 {
        struct device_node *cn, *map;
        int ret = 0;
@@ -481,7 +480,6 @@ static int __init parse_dt_topology(void)
        of_node_put(cn);
        return ret;
 }
-#endif
 
 /*
  * cpu topology table
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 0f6cd6b73a61..cfa5a5072aa0 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -66,6 +66,7 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
 #define topology_llc_cpumask(cpu)      (&cpu_topology[cpu].llc_sibling)
 void init_cpu_topology(void);
 void store_cpu_topology(unsigned int cpuid);
+int __init parse_dt_topology(void);
 const struct cpumask *cpu_coregroup_mask(int cpu);
 void update_siblings_masks(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
