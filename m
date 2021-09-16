Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082A740EDBD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 01:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241500AbhIPXO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 19:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241461AbhIPXOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 19:14:54 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E09C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:33 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id r21so7138516qtw.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vATAyacEN1RBZ4iY9UvfQznDv8XKXbprxPlso1XrO3s=;
        b=gZB9fgDcFd48xLYIrxyh+JGpbXTeFbm0ji1GBX7tm82vd7HFkYtLoMTXTT4IhnMlZ6
         5bLx5mqq+ycUoQPIfP+lE4fs9sQqeYiIx3OdOmj1BVHNmMoSVaFjRhoDV9x7oDyQH0Ly
         EcUgOsZW+ExaRa+Ifjsyu9ljpRI7YFva8jH4Y/B14osyeDOz1EojnubioGqn4HrfXVmN
         QQ1EoGD+L/mRut1G/X5rQcThsMTcwmlq9t87oSm8rHbaGaEq0T6MgYJQ2PXCCfnE4KBC
         EzalqM8ViXMhxDwIfHp2282OL0rNPf1h1YEXmGPzTHQS7OWvI6nbW/Ow5/taEGoYgX5P
         jbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vATAyacEN1RBZ4iY9UvfQznDv8XKXbprxPlso1XrO3s=;
        b=VLj5/pV0R/7GRGiXKWli0JT9xDb4I9hhzjAH8/UP21OVxYt3iViHQvhZPDct2T3DvD
         2rphyN6J7Of71dai2fP7XjYGs39VFdLPtQEzbJ93Auc1jZQozAwqgbpvohOZiQb1VXwo
         xqsTqZLn0XzVkpTeuMms/O6kWTS+Zgl96cgHYjG63FYpaTaWdOI6NOR+ILOxdeiNORGe
         YsPpvXqZr7EKE1XDNmTy/JmydtRiE5zleRTo/rgoPm4vMo9jfSjRuzslcWWw71XsvLVu
         TTUD2D5ZDDaFtU/daFgS86bt9bORkPa2GfxO4YPdyySWOPgINhbx9t+gjtzXUtqNeRjJ
         FJGA==
X-Gm-Message-State: AOAM5336XEI+q6M2lV+0NvnhffB6x81vUOTosGPkvAoKCQ7eNj9LgAah
        aL4FVrei7eplSVxZphZdmiTmsQ==
X-Google-Smtp-Source: ABdhPJysMPROcVY9uVmXIYZZutZ8Tz1xrsOad/eRErKKPAsu10LVzfxhmRCZ46+JETnnHyeGrvmtDQ==
X-Received: by 2002:a05:622a:199d:: with SMTP id u29mr7515959qtc.357.1631834012463;
        Thu, 16 Sep 2021 16:13:32 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id az6sm3312891qkb.70.2021.09.16.16.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 16:13:32 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com,
        kernelfans@gmail.com, akpm@linux-foundation.org,
        madvenka@linux.microsoft.com
Subject: [PATCH v17 03/15] arm64: hibernate: abstract ttrb0 setup function
Date:   Thu, 16 Sep 2021 19:13:13 -0400
Message-Id: <20210916231325.125533-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916231325.125533-1-pasha.tatashin@soleen.com>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only hibernate sets custom ttbr0 with safe idmaped function.
Kexec, is also going to be using this functionality when relocation code
is going to be idmapped.

Move the setup sequence to a dedicated cpu_install_ttbr0() for custom
ttbr0.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/mmu_context.h | 24 ++++++++++++++++++++++++
 arch/arm64/kernel/hibernate.c        | 21 +--------------------
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index f4ba93d4ffeb..6770667b34a3 100644
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
index b96ef9060e4c..2758f75d6809 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -212,26 +212,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
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

