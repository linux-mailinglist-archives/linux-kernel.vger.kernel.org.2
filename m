Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8F23DE1F3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhHBVye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbhHBVy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:54:27 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245A9C061798
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 14:54:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c9so18094718qkc.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=96Un8yzVfu7KwL+UKPbJdUfuiZIxSkwQ3ffVCXyGsJg=;
        b=fDKdvVvJFzZLoHCfTztgqUc8ghI0wc0uDmTwEByiClo9Fcrah9+JXI4wlANk0MLP0Z
         Baythc3XdKwhO6bqGBTm0LqWBDzhSfCqsmEOuAfGPKQbvlzFWkTHH8MV05CYMtSLUBFu
         5A4BPjNQfVh86B1fU1SpksUzRvwB4KyS8V1IXEJSxY4A/NqPTIfGZvTSvoApGAai4N+D
         40BkEUuNgNrDlgFfukt0M3Bu4OoAVKM1CuG4vnkAP7JypBRhYmitFffAs3WZCtDov+Kp
         IvrPNUTuRAk4TWlGmF2NZSw6CuXflGh3nUfgH6xcKGnBAyWnyq0R/Z6iB6Zw7gEswAFZ
         I/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=96Un8yzVfu7KwL+UKPbJdUfuiZIxSkwQ3ffVCXyGsJg=;
        b=Khftt+lNgFIl7BoM9wV2NXuxDeIr7jiiSh3d1FKXGMJgi3QalBiI5MLXn5qwQrtsgU
         PSMAyIqAeGSTyhKqphT85w2GMgRBSoxQAqPMoBvwxS4NH/6v2FnH8YQ82KznqnkDBm9l
         q6eaq13T9HmMFw0ysNsT/yj0BZb5S02jq1RcJT6m6w9+G88nIH05UkUjCTfaNqNohVi7
         mtflHzBB/KhN3TRGyt38CtXboGXlmM4ypu5ZKAXUnPX5veQaJWfVosKLUnY0X6oWSSU9
         oWG4UOp2c+w83t5CCzW5vMi+jAc0DYrGYp/UTMK0osKnInNYAaY9mt4ogj+ICbHjxaf1
         nF9w==
X-Gm-Message-State: AOAM533unHY0SGS+sLw5qn5P4iMQz/nFDmd9FNMcqulLwF1DDz33L9Eg
        rsHilC4HpuLK6hsSkO1BIxB+hw==
X-Google-Smtp-Source: ABdhPJxxBXqSP3qMfUR18poVpxw/DGnsuk4IsHc07cmFedVkC3VWV8old/VTOr1+C7JPN//f26ZF2A==
X-Received: by 2002:a05:620a:164b:: with SMTP id c11mr17543239qko.156.1627941255271;
        Mon, 02 Aug 2021 14:54:15 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id v11sm5479216qtc.0.2021.08.02.14.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:54:14 -0700 (PDT)
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
        kernelfans@gmail.com, akpm@linux-foundation.org,
        madvenka@linux.microsoft.com
Subject: [PATCH v16 03/15] arm64: hibernate: abstract ttrb0 setup function
Date:   Mon,  2 Aug 2021 17:53:56 -0400
Message-Id: <20210802215408.804942-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802215408.804942-1-pasha.tatashin@soleen.com>
References: <20210802215408.804942-1-pasha.tatashin@soleen.com>
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
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/mmu_context.h | 24 ++++++++++++++++++++++++
 arch/arm64/kernel/hibernate.c        | 21 +--------------------
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index eeb210997149..edb57e075abe 100644
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

