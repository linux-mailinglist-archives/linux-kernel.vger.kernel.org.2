Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF63B3141FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbhBHVh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbhBHUyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:54:09 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACCDC061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 12:53:28 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w18so10480276pfu.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 12:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aUVp9y2kbcCD3w0xMPNOVcdPDPsJuo8ux3a0lIWVKEM=;
        b=p14p7HLTvwUQxkszIWy1D0jXzdQ7Jv/1M8//23UsBMWdxYmR8W9Oa9pFEeUQ/pN+c8
         FC73ALf4od9D9ewMLxOqDXH0e5s/GOvT1ecqSLjB2jJO6RKpDS7cLq8NfA4z3gu9/PIM
         izuXziI0Z0oNgWW4Q5J+uAGEYS6kIAGldZnGec1okq+S5dvNYwn2Lu42MO1cudNquxgi
         02J18w2m/NajoLm0QcPqTAbnu+JOJEE7F1Q5wL1QeMcdMHpqpFRWsFliZhWhPWQpibyu
         L4t0+MIIY36yCPd/rhg1tRY3zUk/pvtsfHYmffGfHC5jAeTPi4qf1tTNZrPubbnSxQG7
         AwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aUVp9y2kbcCD3w0xMPNOVcdPDPsJuo8ux3a0lIWVKEM=;
        b=SYq7yd/zorglr/nt/fM3F96cmAd/JMh44O0RIgE9FkXNAERm/DpKDNYbEHeyzsEr5j
         LwikCa7rm2F7WSQUk7Im9TYGgc0O2O6CGhbSw6uJl/jMQ8J+MjPTsbNwNb/LnSR6poI9
         1zRmjD/sA4I5w/7NTnvQ3oA0npry9+TGpydI9/SPS8wT5hxHZsgr3HcR2sQAxEE1+OMY
         wwU+iXuTSQydKku/K8ViS4D6gvbJ9l+EpdVMzAKpXTmDP2+zJhwvVgV/JW2sXlicXm6t
         5F4UBt5xalvM+nOxYKonCQoBlBr2BSfxH4CXRw4t9K6lLGHw/dRoDxpd/CD17ambsdjQ
         LjlA==
X-Gm-Message-State: AOAM53375lSrRAkdSMUzWd/82CJw/VFjl//VnWso7V5mKDA8tfqJWPPF
        BeUSUs2RRmjHsPTVHmjKwID83BS0O8k=
X-Google-Smtp-Source: ABdhPJwtcdW1MR2LxB05C2ZmVapCPAleU1aPDxNKcwrWU8hTfYn7f5zcw2HSw/Yw/HXvBDI/5ZfZGQ==
X-Received: by 2002:a65:4c43:: with SMTP id l3mr18529836pgr.327.1612817604629;
        Mon, 08 Feb 2021 12:53:24 -0800 (PST)
Received: from localhost (g186.222-224-165.ppp.wakwak.ne.jp. [222.224.165.186])
        by smtp.gmail.com with ESMTPSA id d1sm3018455pgl.17.2021.02.08.12.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 12:53:23 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH v3] openrisc: Use devicetree to determine present cpus
Date:   Tue,  9 Feb 2021 05:53:05 +0900
Message-Id: <20210208205307.4169579-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>

Use the device tree to determine the present cpus instead of assuming
all CONFIG_NRCPUS are actually present in the system.

Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
[shorne: Squashed 2 email commits and added summary from email]
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/smp.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 29c82ef2e207..48e1092a64de 100644
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
@@ -60,22 +61,32 @@ void __init smp_prepare_boot_cpu(void)
 
 void __init smp_init_cpus(void)
 {
-	int i;
+	struct device_node *cpu;
+	u32 cpu_id;
 
-	for (i = 0; i < NR_CPUS; i++)
-		set_cpu_possible(i, true);
+	for_each_of_cpu_node(cpu) {
+		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
+			pr_warn("%s missing reg property", cpu->full_name);
+			continue;
+		}
+
+		if (cpu_id < NR_CPUS)
+			set_cpu_possible(cpu_id, true);
+	}
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	int i;
+	unsigned int cpu;
 
 	/*
 	 * Initialise the present map, which describes the set of CPUs
 	 * actually populated at the present time.
 	 */
-	for (i = 0; i < max_cpus; i++)
-		set_cpu_present(i, true);
+	for_each_possible_cpu(cpu) {
+		if (cpu < max_cpus)
+			set_cpu_present(cpu, true);
+	}
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
-- 
2.26.2

