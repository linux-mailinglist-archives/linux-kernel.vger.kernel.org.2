Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A566732B737
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442155AbhCCKvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237769AbhCCAZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:25:33 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADB6C061222
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:22:41 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id d20so21373684qkc.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 16:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PfFJiiZEssC2qRvy3KJXm7j/Y4Op5RWRizR2E1HngfE=;
        b=jMDvuz/Zgmq1B1MpVMXtPYeQ4yIQVYunhOd0cuqlnPu73G25rI6A8bbQBy7YIsq+XL
         QLFaC6VqVzMJKOhhn6eYQS9l2TbV/YMXjSMgRvzpw+kAe19ABWobfO0KCffKshahDMdI
         bUlq1RwNGtmC7j7E3GIqW51fgJ+qLsCRs7WDT07CRyQw/7RmxffV2qQ5/UKUDv4FWBAd
         rEakxu/EEIwCQfy3eqO5Nq7V6xiG538snw78opWM2Sc0e/ol/nnofnFY7H9ogH44hG/Y
         QWBHfv7b8Hjc3HJ2evECDpilQuTYVfBG/XhchNb4WN/jfozGm70uSgAosPcJBkyAtyS7
         tJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfFJiiZEssC2qRvy3KJXm7j/Y4Op5RWRizR2E1HngfE=;
        b=O/OQIxOCG5iYPAWdQ1qrMFw41we7I8ToF7LU1YSXFWetCd0LYn5HuarIJ7Z9iRYiU4
         5teTr6M/ITrQeUChQFA3Rr0K5XUahqeqWrwZEfrBwrh1dK+L1d1D5DAQfTUb0botlRgv
         V8Vc/y9eQ2q9jwWIpppnfVDuNSusK1qpa7xe1Clxrqvrpiq0QYVl5QM3pn1wQffRylHF
         iaMwcc1NFYRj1sYGPBajYT2Q9julCNy0OyJB1ovmuRmTAf8o2TWxpwA45F6409y29nRp
         rfM9nTsDYdsqFGqPsGgqATBpTqSrbQppj4T6TJ647g2CAHvuU3TD9r/XEDh1rsOLJ1Tc
         XVmA==
X-Gm-Message-State: AOAM530a/8kMMdx1coKTi9CGdDj3owjLUD9sblDc0pTpIjcQmbqNW+vU
        dAwwOEio4+z0M7NmcvEuEJGJJw==
X-Google-Smtp-Source: ABdhPJz+uVEaSRAvPV9aeu5i6C2Vj6mlXfoQyiLGMJfrnW+9tKudvptZdZIYZEjfRvwkDzISw2eE+Q==
X-Received: by 2002:a37:4e01:: with SMTP id c1mr10344514qkb.16.1614730960877;
        Tue, 02 Mar 2021 16:22:40 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r3sm16690512qkm.129.2021.03.02.16.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 16:22:40 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v12 06/17] arm64: hibernate: abstract ttrb0 setup function
Date:   Tue,  2 Mar 2021 19:22:19 -0500
Message-Id: <20210303002230.1083176-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
References: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only hibernate sets custom ttbr0 with safe idmaped function.
Kexec, is also going to be using this functinality when relocation code
is going to be idmapped.

Move the setup seqeuence to a dedicated cpu_install_ttbr0() for custom
ttbr0.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/mmu_context.h | 24 ++++++++++++++++++++++++
 arch/arm64/kernel/hibernate.c        | 21 +--------------------
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 70ce8c1d2b07..c6521c8c06ac 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -132,6 +132,30 @@ static inline void cpu_install_idmap(void)
 	cpu_switch_mm(lm_alias(idmap_pg_dir), &init_mm);
 }
 
+/*
+ * Load our new page tables. A strict BBM approach requires that we ensure that
+ * TLBs are free of any entries that may overlap with the global mappings we are
+ * about to install.
+ *
+ * For a real hibernate/resume/kexec cycle TTBR0 currently points to a zero
+ * page, but TLBs may contain stale ASID-tagged entries (e.g. for EFI runtime
+ * services), while for a userspace-driven test_resume cycle it points to
+ * userspace page tables (and we must point it at a zero page ourselves).
+ *
+ * We change T0SZ as part of installing the idmap. This is undone by
+ * cpu_uninstall_idmap() in __cpu_suspend_exit().
+ */
+static inline void cpu_install_ttbr0(phys_addr_t ttbr0, unsigned long t0sz)
+{
+	cpu_set_reserved_ttbr0();
+	local_flush_tlb_all();
+	__cpu_set_tcr_t0sz(t0sz);
+
+	/* avoid cpu_switch_mm() and its SW-PAN and CNP interactions */
+	write_sysreg(ttbr0, ttbr0_el1);
+	isb();
+}
+
 /*
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 0b8bad8bb6eb..ded5115bcb63 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -206,26 +206,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	if (rc)
 		return rc;
 
-	/*
-	 * Load our new page tables. A strict BBM approach requires that we
-	 * ensure that TLBs are free of any entries that may overlap with the
-	 * global mappings we are about to install.
-	 *
-	 * For a real hibernate/resume cycle TTBR0 currently points to a zero
-	 * page, but TLBs may contain stale ASID-tagged entries (e.g. for EFI
-	 * runtime services), while for a userspace-driven test_resume cycle it
-	 * points to userspace page tables (and we must point it at a zero page
-	 * ourselves).
-	 *
-	 * We change T0SZ as part of installing the idmap. This is undone by
-	 * cpu_uninstall_idmap() in __cpu_suspend_exit().
-	 */
-	cpu_set_reserved_ttbr0();
-	local_flush_tlb_all();
-	__cpu_set_tcr_t0sz(t0sz);
-	write_sysreg(trans_ttbr0, ttbr0_el1);
-	isb();
-
+	cpu_install_ttbr0(trans_ttbr0, t0sz);
 	*phys_dst_addr = virt_to_phys(page);
 
 	return 0;
-- 
2.25.1

