Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231DE357B1D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhDHEGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhDHEGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:06:13 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7A5C061763
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:06:02 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id x11so901879qkp.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 21:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xvI3SX7JlP3yoyw6A9a93CvHYXbBacBuW7cN/tDXEXM=;
        b=PQZpDOWvV+YQX3+RRvSpQFtcUJedqJnM7spQTWj55AWeUxKM7SDx4kPAPVhIti6gUy
         voTZFJ0QpgeKNepc2Wsw2crxkyVzSebcYCpjVmhiUJHU0EF8Cp2eZYaXKcFetCaQ0nbO
         9sgz4EynwexL5fBFi5NdfqUX3KBkDnkUvWB2XRI6lXQ6AD58/hESTOEhAo/WhJJNVKKB
         XRS9V60S3C0yHEY1oJGn5dzDVLybPzxpWkBY5tt1iidF+UOGgqX3qTEnTHcav/dlpF1D
         5IWEsW8FOz8Ysa5jWkyRyxS4DJNl79APieTpJKpMGJjApk1t3Y7Drx2OLvk1ksW2Ww8R
         hdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xvI3SX7JlP3yoyw6A9a93CvHYXbBacBuW7cN/tDXEXM=;
        b=AYNkCSmuOP9rVC3Fn44ysfwsu1wT0OJZdH7eVOOnuEhlNkvxv/wgNQqfLlusz7+Uwi
         RFTXHn29vprRufsZGEziyE8BSCAX4Blx34Zem/AbMMG5zvNCu2LwauWXcqYf5IA/2ATN
         /JhR0f6R82CWrYpvocANeWtSYKx52IwXt9GWWspvjWYCwekI6g010sBFvDk6o6JLlseG
         nCbI8SLDIK4EunDOPV3WWxpiKFM+F2R/t29g4WGWdRraFV/fCqVwlJ9eCZLXM9t08La4
         dAuppsmt5ZOrIlEGFozA/owQ6Bl3p/9c7D+DqnDloXgJMAHaeGXivJACJV5XhECUWoAf
         mHCA==
X-Gm-Message-State: AOAM533HsTTizveOhDjpLNgESbcZBiRldI9Hh3dklFOzs0i8HoKfOGMG
        /Bcl03E+v0W+Gze9JwVfN6mtSw==
X-Google-Smtp-Source: ABdhPJyAhGZ8OdBbF6Xwq/FrEvRsf0ZaW/p58HnrVWenn+xQ4Ms5P4taI+EFYNUH/uxAa8e26zbECg==
X-Received: by 2002:a37:89c7:: with SMTP id l190mr7002416qkd.361.1617854761446;
        Wed, 07 Apr 2021 21:06:01 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 207sm18177874qkl.125.2021.04.07.21.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 21:06:01 -0700 (PDT)
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
Subject: [PATCH v13 17/18] arm64: kexec: Remove cpu-reset.h
Date:   Thu,  8 Apr 2021 00:05:36 -0400
Message-Id: <20210408040537.2703241-18-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
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

