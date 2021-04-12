Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9036435BA9C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbhDLHJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhDLHJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:09:55 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B654DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:09:37 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h25so8657045pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/ph01kM4PWjZsNE/rbaBIH3YGPhmJQG3FuiaOlMSyCo=;
        b=jK5RUnX42zgJjLNikI7e+vNrhPN9HJG4hbwCh2/EpHIsH/elrrmR+KNEbOWWefvafV
         QXnLF8zzyVElGc9OY1QyyoRNtxBdqSZE4kl5lKhDt2g8upNbIjIMFTBX2EPvtunZNUuk
         hwYPryC0OgNVx+90Sd0JPAsGddQ4qjmLmUFoNAJNa7gXRij1TLTJ0U1mt2e8mlTYeYMm
         DLBAU7me8v/JaeZcLIlbU+zY/+s+g0po+fqEqxiPU3glyMheEXmlrXu7MwDVzBxNOd5w
         d+fMZSp+VBuWWhg/kkULSX8kibXWPUXQVcoPf36EAa+ZXtH0ZMQ+QH21y3ga8MiCTCux
         7l3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/ph01kM4PWjZsNE/rbaBIH3YGPhmJQG3FuiaOlMSyCo=;
        b=o0CmpcvvCecm2eCAacwSpcRHpV1aWDdVchU2HBK4Ld0kzsUF9eQqooW7jB5HEVMLAp
         EJxUkovqEiqajCib+i0qhQMh/kXDWgUYiI9WYxLm8vRxjsPZsk0dRrAoiZq9rosDm/J/
         yT8jfcK0PrHyQlzAa4qFgosOC/W3QP2GC+gsbx8VrpE/wcZ2/8ZsXOieDPywwxGQpsuL
         4pTnPToCrJPheOes44Bpa0SDsCY45cS9dw1u3JDlmaY4PJACCays8asolB2YkP971Wr1
         Exmct/42viUi1GFg4+TGwCaVYhD7QL2QtLC/ln32DiTuZP2MqUPkaSkrbPoVvrDvNxlm
         QvBQ==
X-Gm-Message-State: AOAM531GGhinBBcNBY88uJcGlWJEo0RJZflszr/ckI01HuJV/6O714aH
        BUjYs88+spnOx32CpgWtWqk=
X-Google-Smtp-Source: ABdhPJyjy8Zbo9RxKy55JtU5S/xqVWByY91PBQ2hMSQ4sNDywKLtRcFZevsofvBx92wWY/xy7owDhQ==
X-Received: by 2002:a62:cf46:0:b029:246:19c3:524b with SMTP id b67-20020a62cf460000b029024619c3524bmr16223522pfg.43.1618211377344;
        Mon, 12 Apr 2021 00:09:37 -0700 (PDT)
Received: from Ruifeng.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l18sm10638922pgh.70.2021.04.12.00.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 00:09:36 -0700 (PDT)
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
To:     linux@armlinux.org.uk, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        a.p.zijlstra@chello.nl, dietmar.eggemann@arm.com, mingo@kernel.org,
        valentin.schneider@arm.com, ruifeng.zhang1@unisoc.com,
        nianfu.bai@unisoc.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm: topology: parse the topology from the dt
Date:   Mon, 12 Apr 2021 15:08:19 +0800
Message-Id: <20210412070819.23493-1-ruifeng.zhang0110@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>

The arm topology still parse from the MPIDR, but it is incomplete.  When
the armv8.3 cpu runs in aarch32 mode, it will parse out the wrong topology.

armv7 (A7) mpidr is:
[11:8]      [7:2]       [1:0]
cluster     reserved    cpu

armv8.3 (A55) mpidr is:
[23:16]     [15:8]      [7:0]
cluster     cpu         thread

For compatibility to keep the function of get capacity from default
cputype, renamed arm parse_dt_topology to get_cputype_capacity and delete
related logic of parse from dt.
Arm using the same parse_dt_topology function as arm64.

The arm device boot step is to look for the default cputype and get cpu
capacity firstly. Then parse the topology and capacity from dt to replace
default values.

Signed-off-by: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
---
 arch/arm/kernel/topology.c    | 18 ++++--------------
 drivers/base/arch_topology.c  |  4 ++--
 include/linux/arch_topology.h |  1 +
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ef0058de432b..7a4217367c7e 100644
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
+static inline void parse_dt_capacity(void) {}
 static inline void update_cpu_capacity(unsigned int cpuid) {}
 #endif
 
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

