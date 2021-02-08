Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998F131357D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhBHOqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhBHO3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:29:43 -0500
Received: from mail-out-3.itc.rwth-aachen.de (mail-out-3.itc.rwth-aachen.de [IPv6:2a00:8a60:1:e501::5:48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27686C0617AB
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 06:29:01 -0800 (PST)
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CqBwBZSiFg/5oagoZiHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQGCD4FTgiZplW8InG4LAQEBAQEBAQEBCAEtAgQBAYRLggQCJTgTAhA?=
 =?us-ascii?q?BAQYBAQEBAQYEhl+GH1IbgSMBDQWDJoMHAa9yM4kdgUQJAYEuiF6FC4FcP4E4D?=
 =?us-ascii?q?AOCNS4+ijcEgkctYZM4qHkHgWuBEpt3BSmTL49zlDKdMYRFAgICAgkCFoFtgXp?=
 =?us-ascii?q?NJFwJglNQFwINji0XjWsBPEEyNwIGCgEBAwlPLYscAQE?=
X-IPAS-Result: =?us-ascii?q?A2CqBwBZSiFg/5oagoZiHAEBAQEBAQcBARIBAQQEAQGCD4F?=
 =?us-ascii?q?TgiZplW8InG4LAQEBAQEBAQEBCAEtAgQBAYRLggQCJTgTAhABAQYBAQEBAQYEh?=
 =?us-ascii?q?l+GH1IbgSMBDQWDJoMHAa9yM4kdgUQJAYEuiF6FC4FcP4E4DAOCNS4+ijcEgkc?=
 =?us-ascii?q?tYZM4qHkHgWuBEpt3BSmTL49zlDKdMYRFAgICAgkCFoFtgXpNJFwJglNQFwINj?=
 =?us-ascii?q?i0XjWsBPEEyNwIGCgEBAwlPLYscAQE?=
X-IronPort-AV: E=Sophos;i="5.81,162,1610406000"; 
   d="scan'208";a="113311174"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
  by mail-in-3.itc.rwth-aachen.de with ESMTP; 08 Feb 2021 15:28:50 +0100
Received: from io.fritz.box (2a02:908:1089:e060:794d:ff8:62d5:f86c) by
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2044.4; Mon, 8 Feb 2021 15:28:46 +0100
From:   Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
To:     <geert@linux-m68k.org>, <jonas@southpole.se>,
        <stefan.kristiansson@saunalahti.fi>, <shorne@gmail.com>,
        <openrisc@lists.librecores.org>, <linux-kernel@vger.kernel.org>
CC:     Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Subject: Re: [PATCH v2] Use devicetree to determine present cpus (v2)
Date:   Mon, 8 Feb 2021 15:28:32 +0100
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2a02:908:1089:e060:794d:ff8:62d5:f86c]
X-ClientProxiedBy: rwthex-w3-b.rwth-ad.de (2a00:8a60:1:e500::26:163) To
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154)
Message-ID: <9dc6c716-c5da-4214-96d8-e088db29d403@rwthex-s2-a.rwth-ad.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
---
 arch/openrisc/kernel/smp.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 75be7e34f..83cbf43d4 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -61,32 +61,31 @@ void __init smp_prepare_boot_cpu(void)
 
 void __init smp_init_cpus(void)
 {
-	int i;
+	struct device_node* cpu;
+	u32 cpu_id;
+
+	for_each_of_cpu_node(cpu) {
+		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
+			pr_warn("%s missing reg property", cpu->full_name);
+			continue;
+		}
 
-	for (i = 0; i < NR_CPUS; i++)
-		set_cpu_possible(i, true);
+		if (cpu_id < NR_CPUS)
+			set_cpu_possible(cpu_id, true);
+	}
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	u32 cpu_id;
-	struct device_node *cpu, *cpus;
+	unsigned int cpu;
 
 	/*
 	 * Initialise the present map, which describes the set of CPUs
 	 * actually populated at the present time.
 	 */
-	cpus = of_find_node_by_path("/cpus");
-	for_each_child_of_node(cpus, cpu) {
-		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
-			pr_warn("%s missing reg property", cpu->full_name);
-			continue;
-		}
-
-		if (cpu_id >= max_cpus)
-			continue;
-
-		set_cpu_present(cpu_id, true);
+	for_each_possible_cpu(cpu) {
+		if (cpu < max_cpus)
+			set_cpu_present(cpu, true);
 	}
 }
 
-- 
2.17.1

