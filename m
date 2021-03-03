Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ABE32B73B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442888AbhCCKvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbhCCA0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:26:20 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BB2C0611BE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:22:55 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id j3so578371qtj.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 16:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xvI3SX7JlP3yoyw6A9a93CvHYXbBacBuW7cN/tDXEXM=;
        b=oPIjUKZfKiJwU7NlOxCWJ5OPY57CbXoshRc624GxpBnFgpup2P/nV58n0kK9/w2XTx
         brLP+1+u8lqb56VBhBgco7Y8J95WM0noHIV2xeYo4P7naJMOF8jyTmpN1bSO7ZzqBYkf
         wLnTE9IuEPsdQ9DhW53OsI8CGals1KWGCUuu9oUKLerRbT0Eefa0xtN6bNdQt8IR07uA
         2nsXk3Z0vFKr1jZmw1N75kg8R6bKWnQATRIxJn4n7gJcwpld3SrUrVk/3xub3eHr43iP
         T9Uf5ZzJh8r4nx+VCew3/uiDHEi1lSTdW1/r3/oOd9UBCwABx/E9DzUpEJ1T7iG2PJER
         ybYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xvI3SX7JlP3yoyw6A9a93CvHYXbBacBuW7cN/tDXEXM=;
        b=cxVdTL1dHj4IVkOi2mJPEdJIwamP/yFq0Wbk1lnEvnojIoJaGlrfuOPdK27ldBKsay
         3t9mzDug84IpgEWZ62tTRCVOkSUQ7qEYV55RBN0D8EPhkvWDeourePODTPe3IQ3j9J73
         aNkzPh0eEhRKmcm+M17CVsO9qkADIf4xV1v6NbjLRc4uddKl9DwsBc+fPic6oy8xOGTR
         Ki6SgdMw6HWX+nEKVgasbMg5Y7o4RAlmz67Hzv1JDl77JOT+Wnn/a+uIY1lQNy1NpNWM
         8kLxmknVSCXDSWRSi5iuuas3tNQnGtGokfwHxNo0DlDFArUB4wq/04hTmo4CeIcLSpAr
         jevw==
X-Gm-Message-State: AOAM533DSe9aqYQRIjqTtWcWghngnuvt+PEuWpaSwvHhYkwYtRN1j4KY
        Qkah+aQvIY8d0yh+zaY5/4NPyQ==
X-Google-Smtp-Source: ABdhPJx5815Pblab/QccqNxqmgkFadcK+ZfVV2aeyidjFjH4QiHxtUtFGn8129DzTiPluIgZh9HpDw==
X-Received: by 2002:ac8:64c:: with SMTP id e12mr20040140qth.103.1614730975050;
        Tue, 02 Mar 2021 16:22:55 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r3sm16690512qkm.129.2021.03.02.16.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 16:22:54 -0800 (PST)
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
Subject: [PATCH v12 17/17] arm64: kexec: Remove cpu-reset.h
Date:   Tue,  2 Mar 2021 19:22:30 -0500
Message-Id: <20210303002230.1083176-18-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
References: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header contains only cpu_soft_restart() which is never used directly
anymore. So, remove this header, and rename the helper to be
cpu_soft_restart().

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h    |  6 ++++++
 arch/arm64/kernel/cpu-reset.S     |  7 +++----
 arch/arm64/kernel/cpu-reset.h     | 30 ------------------------------
 arch/arm64/kernel/machine_kexec.c |  6 ++----
 4 files changed, 11 insertions(+), 38 deletions(-)
 delete mode 100644 arch/arm64/kernel/cpu-reset.h

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 5fc87b51f8a9..ee71ae3b93ed 100644
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
index 37721eb6f9a1..5d47d6c92634 100644
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
 	/* Clear sctlr_el1 flags. */
 	mrs	x12, sctlr_el1
 	mov_q	x13, SCTLR_ELx_FLAGS
@@ -51,6 +50,6 @@ SYM_CODE_START(__cpu_soft_restart)
 	mov	x1, x3				// arg1
 	mov	x2, x4				// arg2
 	br	x8
-SYM_CODE_END(__cpu_soft_restart)
+SYM_CODE_END(cpu_soft_restart)
 
 .popsection
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
deleted file mode 100644
index f6d95512fec6..000000000000
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
-static inline void __noreturn cpu_soft_restart(unsigned long entry,
-					       unsigned long arg0,
-					       unsigned long arg1,
-					       unsigned long arg2)
-{
-	typeof(__cpu_soft_restart) *restart;
-
-	restart = (void *)__pa_symbol(__cpu_soft_restart);
-
-	cpu_install_idmap();
-	restart(0, entry, arg0, arg1, arg2);
-	unreachable();
-}
-
-#endif
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index a1c9bee0cddd..ef7ba93f2bd6 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -23,8 +23,6 @@
 #include <asm/sections.h>
 #include <asm/trans_pgd.h>
 
-#include "cpu-reset.h"
-
 /**
  * kexec_image_info - For debugging output.
  */
@@ -197,10 +195,10 @@ void machine_kexec(struct kimage *kimage)
 	 * In kexec_file case, the kernel starts directly without purgatory.
 	 */
 	if (kimage->head & IND_DONE) {
-		typeof(__cpu_soft_restart) *restart;
+		typeof(cpu_soft_restart) *restart;
 
 		cpu_install_idmap();
-		restart = (void *)__pa_symbol(__cpu_soft_restart);
+		restart = (void *)__pa_symbol(cpu_soft_restart);
 		restart(is_hyp_callable(), kimage->start, kimage->arch.dtb_mem,
 			0, 0);
 	} else {
-- 
2.25.1

