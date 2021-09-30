Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4815A41DC4D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351904AbhI3OdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349929AbhI3OdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:33:02 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A89C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:19 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id o15so3705930qvq.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e39R8ZsIeIwklE8cpr9UY0qKnjifmGWiOSmlNRknozY=;
        b=Dvw31wgsS8G8oxRKiLY9AhC7vsIrGYUqnkg0rdzHudMErK/hqx/f2xKLuM+d+wFz94
         JUmD5np8vuwG2sGXNGsbm1qYTnL5SwmKk3BvG6nraqjwNtTgysYN2X6REwY/fvMqNdAz
         WLoSnNhuaCUYjqopKhwffkXgoe7lX17Re98nrYZngFujO2+9S5P4HTM+0zeBJdgd5nLG
         2YrkHbtNBlzYOOJByqwcPTwT9QKuRm31Mkw6DL6XZxRQc6JsHrc/vF3FUunfcRX4Tuxg
         zJNVbfpaez0v6k+uebd2NVVfyA93/+wABN7kKOsZMg78c45ftAn4QhH3QWl22IAt60Vj
         3CeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e39R8ZsIeIwklE8cpr9UY0qKnjifmGWiOSmlNRknozY=;
        b=rh2D8w9/+PNJiJZ60RY4cl770rnVqJlBAyoc1lS3jxohOLDKgidVttvTepkHOvVxT3
         /0fy7lQ2vHPotbPtNWoe8WyUYd/6yKYVpv2OUjUnvySokHLeHG7/350JvZr9OBKMswTc
         y+bmN4kXNOnz9qFsKOq/j9fnh6CrcniQvt86Jl9eEK1hHQP8zc+Q18qMGomLYah5E7BH
         MRuP73Fy8SYescm6tGxu45PtrKNGJNHq86BGzS1dzixDMQzpxupyno+CSMgP2u08aJNb
         +BU8U739FJTyMIYHzIf67zUSE1UqyM9LRjYM4gaF1F9LmrYuOJUJ5B2P46UtKDkmsnx3
         X+vQ==
X-Gm-Message-State: AOAM531WUNTO/Y51nvwdM1P1fany2i6qArLB5BY5h0VEveBJHdeA3y5f
        tIlROqhJqWRyhdSwakihKV8ySw==
X-Google-Smtp-Source: ABdhPJyKP/5js7mH/GPTqK5GuDttLVlJNJvbT8t4LfCfXnHZzGw54YFenib9JG+PlW6v9j7cikxMqQ==
X-Received: by 2002:a05:6214:2d1:: with SMTP id g17mr5468778qvu.63.1633012278962;
        Thu, 30 Sep 2021 07:31:18 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id l195sm1528731qke.98.2021.09.30.07.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:31:18 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, kernelfans@gmail.com, akpm@linux-foundation.org
Subject: [PATCH v18 03/15] arm64: hibernate: abstract ttrb0 setup function
Date:   Thu, 30 Sep 2021 14:31:01 +0000
Message-Id: <20210930143113.1502553-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
References: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
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
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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
2.33.0.800.g4c38ced690-goog

