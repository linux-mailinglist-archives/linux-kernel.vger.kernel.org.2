Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE5B32B73D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443771AbhCCKvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238020AbhCCA0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:26:20 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522C0C0611C1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:22:49 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id s15so16291585qtq.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 16:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ATHDsIlQRij0i8p3z1/oZchje9DfRT1VSEQgV22ghC4=;
        b=FBdyqZaIcDyDYLlxElrZkuvpRkRku/nV1NAZj9UA7Kl0fuBORRQply+OelppUmA5/X
         YdOr7jgb6xCxZMVvxMAcCH+UB76E2UqPr8+Unv7yNzOfN0g/mRQJU850K0bipeneaRdC
         0WfXYfl0XdrewOTEEVkNkr4Lc/IGmFcluOa3uHtSXXXbq7gKZ5vwgyBe/7c9xGU1wiFK
         Q38hSdvjT0G2vbcJ1e+1tLkWB8lGsOtC1XnvGT+Bg/yC/a1whgpNW0yKjwt/kUY1FC93
         zcHgH6K4aNPWKbx2D1PifjppE8zXUC4vlX60NN8LCSNtkLWhJOCrvpiJkGwJyeoZ6GOV
         CuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATHDsIlQRij0i8p3z1/oZchje9DfRT1VSEQgV22ghC4=;
        b=jiJGH7fg+rzVeR4X93URMx9Cuucy5Q7zGU2rPC9n+eYRYNuou8IQkXh2G17X31d7uL
         Wj3Q2h3bizumCWQ4aNHt2WcgK16ykT91G9A9YVOD/RgUIks/BrFXXmpOXbhQYhfhFOsY
         2WbiHmdwP0Ai1Ui6LuGYgQjUNUcS9m+uOHag6wQoyvn021zdf6UYyRsODtK10WqJHSzG
         FIM+l0TGWt+4d6ScvETmfO+sEjy5V6re8zYf2DbGneGRtLWun9S47uci2mCMJLzc+lZa
         2ckxioYNCv5XhDaJliQ0IbhoJChcX5Gn9qIs/rJkG8+IsAO4Ge8MXIf1hBWtlEw/9p/T
         J8GA==
X-Gm-Message-State: AOAM5314EPUQZ1p64leUqFkTkI3NDn6ss3rWpLBvMOaW/C2ZYhIIdMIX
        sVfuFIbWm0KEen1c6mtpBWMFDg==
X-Google-Smtp-Source: ABdhPJyyN8JxnvqauMS4QIYOtU4flOLUY/VfPIcIZzPJfu3L3JbZXHRoVShtyq5YtQyvU4C/7Kg4+A==
X-Received: by 2002:ac8:5953:: with SMTP id 19mr20290245qtz.263.1614730968594;
        Tue, 02 Mar 2021 16:22:48 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r3sm16690512qkm.129.2021.03.02.16.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 16:22:48 -0800 (PST)
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
Subject: [PATCH v12 12/17] arm64: kexec: relocate in EL1 mode
Date:   Tue,  2 Mar 2021 19:22:25 -0500
Message-Id: <20210303002230.1083176-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
References: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are going to keep MMU enabled during relocation, we need to
keep EL1 mode throughout the relocation.

Keep EL1 enabled, and switch EL2 only before enterying the new world.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/cpu-reset.h       |  3 +--
 arch/arm64/kernel/machine_kexec.c   |  4 ++--
 arch/arm64/kernel/relocate_kernel.S | 13 +++++++++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index 1922e7a690f8..f6d95512fec6 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -20,11 +20,10 @@ static inline void __noreturn cpu_soft_restart(unsigned long entry,
 {
 	typeof(__cpu_soft_restart) *restart;
 
-	unsigned long el2_switch = is_hyp_callable();
 	restart = (void *)__pa_symbol(__cpu_soft_restart);
 
 	cpu_install_idmap();
-	restart(el2_switch, entry, arg0, arg1, arg2);
+	restart(0, entry, arg0, arg1, arg2);
 	unreachable();
 }
 
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index fb03b6676fb9..d5940b7889f8 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -231,8 +231,8 @@ void machine_kexec(struct kimage *kimage)
 	} else {
 		if (is_hyp_callable())
 			__hyp_set_vectors(kimage->arch.el2_vectors);
-		cpu_soft_restart(kimage->arch.kern_reloc, virt_to_phys(kimage),
-				 0, 0);
+		cpu_soft_restart(kimage->arch.kern_reloc,
+				 virt_to_phys(kimage), 0, 0);
 	}
 
 	BUG(); /* Should never get here. */
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 36b4496524c3..df023b82544b 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -13,6 +13,7 @@
 #include <asm/kexec.h>
 #include <asm/page.h>
 #include <asm/sysreg.h>
+#include <asm/virt.h>
 
 /*
  * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
@@ -61,12 +62,20 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	isb
 
 	/* Start new image. */
+	ldr	x1, [x0, #KIMAGE_ARCH_EL2_VECTORS]	/* relocation start */
+	cbz	x1, .Lel1
+	ldr	x1, [x0, #KIMAGE_START]		/* relocation start */
+	ldr	x2, [x0, #KIMAGE_ARCH_DTB_MEM]	/* dtb address */
+	mov	x3, xzr
+	mov	x4, xzr
+	mov     x0, #HVC_SOFT_RESTART
+	hvc	#0				/* Jumps from el2 */
+.Lel1:
 	ldr	x4, [x0, #KIMAGE_START]		/* relocation start */
 	ldr	x0, [x0, #KIMAGE_ARCH_DTB_MEM]	/* dtb address */
-	mov	x1, xzr
 	mov	x2, xzr
 	mov	x3, xzr
-	br	x4
+	br	x4				/* Jumps from el1 */
 SYM_CODE_END(arm64_relocate_new_kernel)
 
 .align 3	/* To keep the 64-bit values below naturally aligned. */
-- 
2.25.1

