Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6DD35F3A5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350866AbhDNMYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240304AbhDNMYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:40 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EA5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:24:18 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id z16so14273559pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/8Ypb0eFkqrp1uVYWIBgHxRw77zKCqZNzIEKNGbyGyY=;
        b=RVbp/Po2eBBrBBLfB5jZC1xuTsE+85nXysynXef5DLZlV3ISxq6sdAAd0DTJeUvdRd
         HNOsdrNgmcBL3ec328bUfwrQqkRnUFwBKxrnPnsEjHt2cHVXX7kwSABkMLbTQkNV+9sa
         +FZjV6hZbjS5o6cPaAuCP7kcqN6LbQ81EwGfE3yWpdhacvXcpMciDc6Kxb6V9DJHHMzi
         vbS9U87AkUrglJaQUa2T/XqF8uBzlvAJyuZ0SAT6uY23o3rV2WwgWXyFpwTpQoAtqArf
         SCHKivq7m17M+ef9LVSQ3prPluTv0YsKQRXhd9ZIBEGj5TBbJLEf3E4F/yWFDaxxyZTF
         8bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/8Ypb0eFkqrp1uVYWIBgHxRw77zKCqZNzIEKNGbyGyY=;
        b=NCcOwH/k6363M7iy5MDwx0wAj0RCZdMwATf/97MMs1ZC366BGlOsu5kBs5puuwlB+b
         ykLDPDHo6GeNFnf44SQ3AzohND/kPLsT8aWTk+MOcVmrm61+ceTTDSwiWlzq0+bWnASZ
         H6KdiKX5HMtBu8AC0I8VU1/D26xdqhx2nYFFieiUDodRA/pNRKNw6XNZaqvYuidKnzoS
         qlyhyPtTgI6k1tIWRW5Y2areDgxozBer2ueAE9QkLsH0EHHykUVyEIO29B8iNo9sjx/L
         rY9UTrZzXgRO19KfxXYojbdB4HcU9n8nAGwgwp4gXd0GIynjXW3jJ2pTLCmNADfPynQI
         i+hQ==
X-Gm-Message-State: AOAM532cL/YIY40Fi5wdWKUVZm2oDENcZbfgazp7s1OUdijh+XVnKxjG
        y2GvtPaTmZx40JWA6xs17LY=
X-Google-Smtp-Source: ABdhPJxH1GK9xJ6Q9+U7XRpvsdaWasnw7RVnzyWFHu9wlCgXL6bYI15yCI0oQlWNwMxyMDfvQUFOaA==
X-Received: by 2002:a63:150c:: with SMTP id v12mr874734pgl.344.1618403057609;
        Wed, 14 Apr 2021 05:24:17 -0700 (PDT)
Received: from Ruifeng.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id mz18sm4960413pjb.13.2021.04.14.05.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:24:17 -0700 (PDT)
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
To:     linux@armlinux.org.uk, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        a.p.zijlstra@chello.nl, dietmar.eggemann@arm.com, mingo@kernel.org,
        valentin.schneider@arm.com, ruifeng.zhang1@unisoc.com,
        nianfu.bai@unisoc.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] arm: topology: parse the topology from the dt
Date:   Wed, 14 Apr 2021 20:23:26 +0800
Message-Id: <20210414122326.5255-2-ruifeng.zhang0110@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210414122326.5255-1-ruifeng.zhang0110@gmail.com>
References: <20210414122326.5255-1-ruifeng.zhang0110@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>

The arm topology still parse from the MPIDR, but it is incomplete.  When
the armv8.2 or above cpu runs kernel in EL1 with aarch32 mode, it will
parse out the wrong topology.

Changed:
1) Arm using the same parse_dt_topology function as arm64.
2) For compatibility to keep the function of get capacity from default
   cputype, renamed arm parse_dt_topology to get_efficiency_capacity and
   delete related logic of parse from dt.
3) The update_cpu_capacity function should not depend on the topology, so
   it is moved to the beginning of store_cpu_topology.

The arm device boot step is to look for the efficiency_capacity firstly.
Then parse the topology and capacity from dt to replace efficiency value.

Signed-off-by: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
Signed-off-by: Nianfu Bai <nianfu.bai@unisoc.com>
---
 arch/arm/kernel/topology.c    | 22 ++++++----------------
 drivers/base/arch_topology.c  |  4 ++--
 include/linux/arch_topology.h |  1 +
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ef0058de432b..93d875320cc4 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -72,7 +72,6 @@ static unsigned long *__cpu_capacity;
 #define cpu_capacity(cpu)	__cpu_capacity[cpu]
 
 static unsigned long middle_capacity = 1;
-static bool cap_from_dt = true;
 
 /*
  * Iterate all CPUs' descriptor in DT and compute the efficiency
@@ -82,7 +81,7 @@ static bool cap_from_dt = true;
  * 'average' CPU is of middle capacity. Also see the comments near
  * table_efficiency[] and update_cpu_capacity().
  */
-static void __init parse_dt_topology(void)
+static void __init get_coretype_capacity(void)
 {
 	const struct cpu_efficiency *cpu_eff;
 	struct device_node *cn = NULL;
@@ -105,13 +104,6 @@ static void __init parse_dt_topology(void)
 			continue;
 		}
 
-		if (topology_parse_cpu_capacity(cn, cpu)) {
-			of_node_put(cn);
-			continue;
-		}
-
-		cap_from_dt = false;
-
 		for (cpu_eff = table_efficiency; cpu_eff->compatible; cpu_eff++)
 			if (of_device_is_compatible(cn, cpu_eff->compatible))
 				break;
@@ -151,9 +143,6 @@ static void __init parse_dt_topology(void)
 	else
 		middle_capacity = ((max_capacity / 3)
 				>> (SCHED_CAPACITY_SHIFT-1)) + 1;
-
-	if (cap_from_dt)
-		topology_normalize_cpu_scale();
 }
 
 /*
@@ -163,7 +152,7 @@ static void __init parse_dt_topology(void)
  */
 static void update_cpu_capacity(unsigned int cpu)
 {
-	if (!cpu_capacity(cpu) || cap_from_dt)
+	if (!cpu_capacity(cpu))
 		return;
 
 	topology_set_cpu_scale(cpu, cpu_capacity(cpu) / middle_capacity);
@@ -173,7 +162,7 @@ static void update_cpu_capacity(unsigned int cpu)
 }
 
 #else
-static inline void parse_dt_topology(void) {}
+static inline void get_cputype_capacity(void) {}
 static inline void update_cpu_capacity(unsigned int cpuid) {}
 #endif
 
@@ -187,6 +176,8 @@ void store_cpu_topology(unsigned int cpuid)
 	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
 	unsigned int mpidr;
 
+	update_cpu_capacity(cpuid);
+
 	if (cpuid_topo->package_id != -1)
 		goto topology_populated;
 
@@ -221,8 +212,6 @@ void store_cpu_topology(unsigned int cpuid)
 		cpuid_topo->package_id = -1;
 	}
 
-	update_cpu_capacity(cpuid);
-
 	pr_info("CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
 		cpuid, cpu_topology[cpuid].thread_id,
 		cpu_topology[cpuid].core_id,
@@ -241,5 +230,6 @@ void __init init_cpu_topology(void)
 	reset_cpu_topology();
 	smp_wmb();
 
+	get_coretype_capacity();
 	parse_dt_topology();
 }
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index de8587cc119e..a45aec356ec4 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -295,7 +295,7 @@ static void parsing_done_workfn(struct work_struct *work)
 core_initcall(free_raw_capacity);
 #endif
 
-#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 /*
  * This function returns the logic cpu number of the node.
  * There are basically three kinds of return values:
@@ -441,7 +441,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 	return 0;
 }
 
-static int __init parse_dt_topology(void)
+int __init parse_dt_topology(void)
 {
 	struct device_node *cn, *map;
 	int ret = 0;
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 0f6cd6b73a61..cfa5a5072aa0 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -66,6 +66,7 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
 #define topology_llc_cpumask(cpu)	(&cpu_topology[cpu].llc_sibling)
 void init_cpu_topology(void);
 void store_cpu_topology(unsigned int cpuid);
+int __init parse_dt_topology(void);
 const struct cpumask *cpu_coregroup_mask(int cpu);
 void update_siblings_masks(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
-- 
2.17.1

