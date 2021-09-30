Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDE141DC55
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351920AbhI3Odf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351950AbhI3OdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:33:13 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D7DC06176E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:31 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 73so5975189qki.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+AOkYJOnQvYKR/38NvELzatiZDcWOHgVXKELSMlb5SM=;
        b=J5UQ7UZyfmWWA8PGgeNyC7jbgKspoR4nC8w8x68ivVY8HpNv+1af8uvYuEZzW7fTQT
         JW0pPONsRs0dngUFtIDqKg3T4bcpIwi6oVM+aCnbkzDE5Di4J7g/yTcWL7Gu2lQbh+Zm
         qg+s5ZIK4LCaICSgJO9NMMahZfisKm+U5Tzzbo2ep7S11va1mhIojJHfvKTJq4OocfLr
         XB80LgfKaKVLrEsgV+kcLXqnC35HNyCkz/OrUln0LzZBCP4N+1sG2ROW9TSujy+hUpJ5
         GVJv9mLRsSKM2ypF2prF1I1gIh9AnkvoN8SFFYqEfooatv7xr4Pv+NuWlrcZ5U4ihEAw
         A5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+AOkYJOnQvYKR/38NvELzatiZDcWOHgVXKELSMlb5SM=;
        b=blsRaf89bRFPT+03S87yWiQE/1+I2TYu/K6edn5SWMT6N/rEJm3dCV05uvSQrmIzJ5
         0/dkOA8OTl1nzro431Vc0nRU8jwQwDXyiXvLNdm4sz0hO4IqPWMj2MCXeMZbmmymB+fp
         xGEEGBMGHbE/cFj05kxy3MvJAMlpETYN9m4MTodBUY3Vl5A3B+y/TJKnOIbze30xDZW4
         sB9YwP1rvcofrQda3VLpLBJibRWVBfZKdxDdONIA/lognizahHlxxRDZyKhBiuBQFMFK
         HHZNLq4QnkIhnV25pys6PkhItqoK+NoC7J6YLBE1yFos66fYtpVXzo0b5fcWzTcn9hFA
         8+jA==
X-Gm-Message-State: AOAM53382kOgNS1B8v9EmjRZAvIufka+YNqU0uMYHjjAbNHPB/c86Zd6
        g32MGkyxWNUwTJDJu3p3LX2hYg==
X-Google-Smtp-Source: ABdhPJwcDK47/5GmWQlsLpv+of/CmJ8uJnwVzFmIbGlzIotuh9aCabUvIq/XQKbO0rOygE1OJAfqqg==
X-Received: by 2002:a37:8883:: with SMTP id k125mr4898086qkd.458.1633012290355;
        Thu, 30 Sep 2021 07:31:30 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id l195sm1528731qke.98.2021.09.30.07.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:31:29 -0700 (PDT)
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
Subject: [PATCH v18 14/15] arm64: kexec: remove cpu-reset.h
Date:   Thu, 30 Sep 2021 14:31:12 +0000
Message-Id: <20210930143113.1502553-15-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
References: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
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
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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
index 559d47a3c59c..1038494135c8 100644
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
2.33.0.800.g4c38ced690-goog

