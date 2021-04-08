Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63470357B12
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhDHEGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhDHEF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:05:58 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52DFC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:05:47 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id y2so442577qtw.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 21:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3ttZQ3gfSf54pfSUBx1LDfQsXE0pAbLQUWMLzhdR74s=;
        b=WNp1gMdsw3Tm4wv5ofO098L7+rqsXN0+xuPMLvxyhfRqO2E2ZKhDEGaGLLpQQCVLp6
         kRWKAxhxmJ30NKIqBld7gTpjAwpz32kIBNExJ2Et0HZWEE+ivhSVeMWtXqp7UcIZyBCs
         X/LNtk7ga4MpNqn+3v94T7MU9nnrxtlJ/zYiq0277ls+/aEP16FB1VizUFYUquLa7aw9
         GiGHeJD31iKWwANH8mQHHBOHgqAlwmaUPPJC5gCo6msF/l+C4Y8nVRzmZMqDdNYh/mJM
         69+TMIvHTm4pme+kPif1x+MlMxbSFgJaabSY0wDQ4Fxs8xJDRaaUL9ndnx4mfcqONRfT
         nELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ttZQ3gfSf54pfSUBx1LDfQsXE0pAbLQUWMLzhdR74s=;
        b=otCroZJr9XMbWMLVTrahbzonGqIF4QS5Mwgqao2wp2phXQAZYr3A+g/A6Rb1cIbtrO
         mbNOvzgizlwWZUazyleSfqcp09DAv5Fskwo1Auy7tGWtyTXmC5QMm1e0AAzZpIY//yUv
         WHWnKL0yxihYosV04PpAGjLJS+dz/n6XBq4nMO3oFWELO9aNj2NEFSCujIKCGmtCNWey
         llN9oqyF0Fk727A+NfiAJYFjIMGxV8f8jJcLztyBVhHrAEGLYEB82eBy8u/YfCicUJX5
         QG4Io+HqEaNPsWbnp74Ui9jiUgQQ/w3TMsVNns6+E17YQoZYysFL1jtSLn+M06XT1CN2
         VSHg==
X-Gm-Message-State: AOAM530A+ztz+9S5M1D97VAfglXCQr6i9uhFTigRaQgjBmZehvpY3ODi
        GRmahmfS+af2sdNF/Um6NV06v0nVfwvIDw==
X-Google-Smtp-Source: ABdhPJzXmtqxtUQTEJT0lxRGeT3Nceyt+CBZeKYInLcPaN+AnmjXc07TTgCf3AOXx1AjM6gvwPz9Hw==
X-Received: by 2002:ac8:6684:: with SMTP id d4mr5596938qtp.34.1617854747044;
        Wed, 07 Apr 2021 21:05:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 207sm18177874qkl.125.2021.04.07.21.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 21:05:46 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com,
        kernelfans@gmail.com
Subject: [PATCH v13 06/18] arm64: hibernate: abstract ttrb0 setup function
Date:   Thu,  8 Apr 2021 00:05:25 -0400
Message-Id: <20210408040537.2703241-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
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
index bd02e99b1a4c..f64d0d5e1b1f 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -115,6 +115,30 @@ static inline void cpu_install_idmap(void)
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

