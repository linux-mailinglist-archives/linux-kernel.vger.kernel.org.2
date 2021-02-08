Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F076B313577
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhBHOpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhBHO2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:28:32 -0500
Received: from mail-out-4.itc.rwth-aachen.de (mail-out-4.itc.rwth-aachen.de [IPv6:2a00:8a60:1:e501::5:49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDED7C0617AA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 06:27:48 -0800 (PST)
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CqBwBDSSFg/5oagoZiHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQGCD4FTgiZplXAInG4LAQEBAQEBAQEBCAEtAgQBAYRLggQCJTgTAhA?=
 =?us-ascii?q?BAQYBAQEBAQYEhl+GH1IbgSMBDQWDJoMHAa98M4kcgUQJAYEuiF6FC4FcP4E4D?=
 =?us-ascii?q?AOCNS4+ijcEgkctYYJduVQHgWuBEpt3BQkgky+Pc5QynTGERQICAgIJAhaBbYF?=
 =?us-ascii?q?6TSRcCYJTUBcCDY4tF41rATxBMjcCBgoBAQMJTy2LHAEB?=
X-IPAS-Result: =?us-ascii?q?A2CqBwBDSSFg/5oagoZiHAEBAQEBAQcBARIBAQQEAQGCD4F?=
 =?us-ascii?q?TgiZplXAInG4LAQEBAQEBAQEBCAEtAgQBAYRLggQCJTgTAhABAQYBAQEBAQYEh?=
 =?us-ascii?q?l+GH1IbgSMBDQWDJoMHAa98M4kcgUQJAYEuiF6FC4FcP4E4DAOCNS4+ijcEgkc?=
 =?us-ascii?q?tYYJduVQHgWuBEpt3BQkgky+Pc5QynTGERQICAgIJAhaBbYF6TSRcCYJTUBcCD?=
 =?us-ascii?q?Y4tF41rATxBMjcCBgoBAQMJTy2LHAEB?=
X-IronPort-AV: E=Sophos;i="5.81,162,1610406000"; 
   d="scan'208";a="98043057"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
  by mail-in-4.itc.rwth-aachen.de with ESMTP; 08 Feb 2021 15:27:44 +0100
Received: from io.fritz.box (2a02:908:1089:e060:794d:ff8:62d5:f86c) by
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2044.4; Mon, 8 Feb 2021 15:27:41 +0100
From:   Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
To:     <geert@linux-m68k.org>, <jonas@southpole.se>,
        <stefan.kristiansson@saunalahti.fi>, <shorne@gmail.com>,
        <openrisc@lists.librecores.org>, <linux-kernel@vger.kernel.org>
CC:     Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Subject: Re: [PATCH] Use devicetree to determine present cpus
Date:   Mon, 8 Feb 2021 15:27:16 +0100
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2a02:908:1089:e060:794d:ff8:62d5:f86c]
X-ClientProxiedBy: rwthex-s3-a.rwth-ad.de (2a00:8a60:1:e500::26:160) To
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154)
Message-ID: <84102952-2468-4616-b28c-cb5941de7e12@rwthex-s2-a.rwth-ad.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
---

Re-send patch with git sendmail

 arch/openrisc/kernel/smp.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 29c82ef2e..75be7e34f 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -16,6 +16,7 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/irq.h>
+#include <linux/of.h>
 #include <asm/cpuinfo.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -68,14 +69,25 @@ void __init smp_init_cpus(void)
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	int i;
+	u32 cpu_id;
+	struct device_node *cpu, *cpus;
 
 	/*
 	 * Initialise the present map, which describes the set of CPUs
 	 * actually populated at the present time.
 	 */
-	for (i = 0; i < max_cpus; i++)
-		set_cpu_present(i, true);
+	cpus = of_find_node_by_path("/cpus");
+	for_each_child_of_node(cpus, cpu) {
+		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
+			pr_warn("%s missing reg property", cpu->full_name);
+			continue;
+		}
+
+		if (cpu_id >= max_cpus)
+			continue;
+
+		set_cpu_present(cpu_id, true);
+	}
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
-- 
2.17.1

