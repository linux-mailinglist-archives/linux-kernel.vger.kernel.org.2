Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E5640EDCA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 01:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbhIPXPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 19:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbhIPXPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 19:15:10 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B57AC0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:49 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id j13so2312998qtq.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7N5nVHzB6dwVIUX0EUd0g/YbIEPJbmQC1LjYPlojIKk=;
        b=mLpqe1KaYQMF0cLBRzJ45xIIqNHIVBadFlMTXXvcP/DL6J6XCYhX74U44EBDufy4ce
         oOPKIl0jWuW1B972+mQbVW2HKYLnhuAhozgdt9HJo3N8FWne8glStby4hooCqfP00nXI
         Bl2MSKg9JOu/Yo5Nu/D1S3uDZqwkKKm2I4bRQEHqCbttLbtiNn7fnjRHbSDW9wFOBBSU
         EpZkNHivP47/YGJ5UIUnfekArrWeqIRb2ShLmYRLM5agEzscVgXk/6bEyEgcQ0iNwapC
         yYPa5RjNJ1eCkZVuiwIRs3cBm2bo17ClU8EaAZjpXBNzS2zWCk2goeGXX9MtEHeHBZIg
         ntcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7N5nVHzB6dwVIUX0EUd0g/YbIEPJbmQC1LjYPlojIKk=;
        b=5wdFqIibuCX0PgwZ5KmSdfmBXJxlFiXycv07alBHGmpqam2OL2Ur3+lNzf4ch8D+Vw
         p9izxEr8IJtuSD4AnWaCMtJCPJv+gmGRfLDRNxBKSSDdP8zjgNYJ7nQivOtuR6wN4BjM
         YwAY0oO+5Xk3eoChn5Y9YhoI0gveCaKCmtUAMsEoiZQNrzkvuVMm0nfFINl1cdUXyHp9
         F0sKysJvgkuATqrXR0QJltKovpjx+fiiS45Og95jDWBY5AryTHVgPJP7KxMAsH9bnV41
         FfmvMRjT984V+JkbMmmmztDnoq1jOk17XChcvzMyNripUgqUjdIf1cg3kq2iuvO4xSea
         ddSQ==
X-Gm-Message-State: AOAM530q7Oaet5ugwwgBfBSZ4RorHCwHoy00rHBuZTTM0UOi7ZXQKBMx
        VfDH4DBCffoa80d3VnIBlWc5mQ==
X-Google-Smtp-Source: ABdhPJyIuGt330ZUOfC/l/iZXTFzzUZyl4ceVHMabmenoyk7fIVAEKa2yGLWG9gwg8yBpK8tkWOCBQ==
X-Received: by 2002:ac8:4818:: with SMTP id g24mr7438906qtq.328.1631834028420;
        Thu, 16 Sep 2021 16:13:48 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id az6sm3312891qkb.70.2021.09.16.16.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 16:13:48 -0700 (PDT)
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
Subject: [PATCH v17 14/15] arm64: kexec: remove cpu-reset.h
Date:   Thu, 16 Sep 2021 19:13:24 -0400
Message-Id: <20210916231325.125533-15-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916231325.125533-1-pasha.tatashin@soleen.com>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header contains only cpu_soft_restart() which is never used directly
anymore. So, remove this header, and rename the helper to be
cpu_soft_restart().

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h    |  6 ++++++
 arch/arm64/kernel/cpu-reset.S     |  7 +++----
 arch/arm64/kernel/cpu-reset.h     | 30 ------------------------------
 arch/arm64/kernel/machine_kexec.c |  6 ++----
 4 files changed, 11 insertions(+), 38 deletions(-)
 delete mode 100644 arch/arm64/kernel/cpu-reset.h

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index dca6dedc3b25..9839bfc163d7 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -90,6 +90,12 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#if defined(CONFIG_KEXEC_CORE)
+void cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
+		      unsigned long arg0, unsigned long arg1,
+		      unsigned long arg2);
+#endif
+
 #define ARCH_HAS_KIMAGE_ARCH
 
 struct kimage_arch {
diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index d47ff63a5b66..48a8af97faa9 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -16,8 +16,7 @@
 .pushsection    .idmap.text, "awx"
 
 /*
- * __cpu_soft_restart(el2_switch, entry, arg0, arg1, arg2) - Helper for
- * cpu_soft_restart.
+ * cpu_soft_restart(el2_switch, entry, arg0, arg1, arg2)
  *
  * @el2_switch: Flag to indicate a switch to EL2 is needed.
  * @entry: Location to jump to for soft reset.
@@ -29,7 +28,7 @@
  * branch to what would be the reset vector. It must be executed with the
  * flat identity mapping.
  */
-SYM_CODE_START(__cpu_soft_restart)
+SYM_CODE_START(cpu_soft_restart)
 	mov_q	x12, INIT_SCTLR_EL1_MMU_OFF
 	pre_disable_mmu_workaround
 	/*
@@ -48,6 +47,6 @@ SYM_CODE_START(__cpu_soft_restart)
 	mov	x1, x3				// arg1
 	mov	x2, x4				// arg2
 	br	x8
-SYM_CODE_END(__cpu_soft_restart)
+SYM_CODE_END(cpu_soft_restart)
 
 .popsection
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
deleted file mode 100644
index 296abbac7192..000000000000
--- a/arch/arm64/kernel/cpu-reset.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * CPU reset routines
- *
- * Copyright (C) 2015 Huawei Futurewei Technologies.
- */
-
-#ifndef _ARM64_CPU_RESET_H
-#define _ARM64_CPU_RESET_H
-
-#include <asm/virt.h>
-
-void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
-	unsigned long arg0, unsigned long arg1, unsigned long arg2);
-
-static inline void __noreturn __nocfi cpu_soft_restart(unsigned long entry,
-						       unsigned long arg0,
-						       unsigned long arg1,
-						       unsigned long arg2)
-{
-	typeof(__cpu_soft_restart) *restart;
-
-	restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
-
-	cpu_install_idmap();
-	restart(0, entry, arg0, arg1, arg2);
-	unreachable();
-}
-
-#endif
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index b1856f34cc51..6f1da3fd5320 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -24,8 +24,6 @@
 #include <asm/sections.h>
 #include <asm/trans_pgd.h>
 
-#include "cpu-reset.h"
-
 /**
  * kexec_image_info - For debugging output.
  */
@@ -201,10 +199,10 @@ void machine_kexec(struct kimage *kimage)
 	 * In kexec_file case, the kernel starts directly without purgatory.
 	 */
 	if (kimage->head & IND_DONE) {
-		typeof(__cpu_soft_restart) *restart;
+		typeof(cpu_soft_restart) *restart;
 
 		cpu_install_idmap();
-		restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
+		restart = (void *)__pa_symbol(function_nocfi(cpu_soft_restart));
 		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
 			0, 0);
 	} else {
-- 
2.25.1

