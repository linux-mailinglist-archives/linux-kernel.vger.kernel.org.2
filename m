Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C5041DC50
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351943AbhI3OdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351924AbhI3OdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:33:12 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6A7C061775
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:25 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id q125so5928749qkd.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8cW/IVlTGR5Obb7nU8rBJjg2uf8tpcGiOc+9iw339z8=;
        b=LGZ+V3ieH2k3Ak86m2WgJk69Yb4/UpPLxocU8YOxOu6VywnSRkV5tG6QX1CZAFVkjH
         IdxIVertagbOxiCikHfXeI+gyRxyIK4n4WNp1gD2dM3hVmXHeWY/0MZVIVU7p16dt0EE
         kQyfCpW5wHlohwk4aa6PjA7uPCBnCZ3aqzRo52eBJjEIs/y+7yHsylM6P6A0lmWxLvdl
         W4ughsB3UmWmnmLbk1MTeuaS/nugc+CYzDd6T7qr/a1d7xhATy3542wZgxbkBlmDuy4P
         Vz0qwo0+V3u7WtKUnsS7vgeAv3YUSK4CE8SJAitCqTQ88TYgfnftSHQblwWyCxVgwAFj
         5hNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8cW/IVlTGR5Obb7nU8rBJjg2uf8tpcGiOc+9iw339z8=;
        b=LTsMjwoVoYlRLMrFo1LPWHwOa4Xzqo2mTXoMYoYbdqk6fvNPz6Rkiqi4ItdREmV5qi
         BeNLhelZVpuWPAKNEKDwqVGXm3GxIsPWwLSNl+8STYysxYXYfgiQSW97XI5cW/MFWXJN
         E5whG+3iQy9Dis2SLGYzoARoiq/Ee+08Wa/wvgCDiSvMyj58vHfzcqN7GtfpyTwsPAbL
         kssRy7WQ481hq4TZcUL65uPR5glEOPN00WccWLY9ljP12PuOGVLzAbUdiSXGndLtxv4H
         LUvXx1f19kBLbXG3E1GOzJLWS97Za7pOoAnGC+Ame4MR4Z9Xh2R6zZPBgivB1OvHre6u
         tBgg==
X-Gm-Message-State: AOAM533q37Zni439h5kPNAB3Qh/f0Bxngdjnf7FJ8Xxpcqa+xq+ga/qg
        pyDVSyxGI959J9v+Wy9bga1hzA==
X-Google-Smtp-Source: ABdhPJyVmacE1sVXxqp5kGQ3RLtcUFdTcFqDSjNppAD3P445XkdfyacytvCYjB45IVcqvbFv/tXoJQ==
X-Received: by 2002:a37:9e8d:: with SMTP id h135mr5202679qke.189.1633012284930;
        Thu, 30 Sep 2021 07:31:24 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id l195sm1528731qke.98.2021.09.30.07.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:31:24 -0700 (PDT)
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
Subject: [PATCH v18 09/15] arm64: kexec: relocate in EL1 mode
Date:   Thu, 30 Sep 2021 14:31:07 +0000
Message-Id: <20210930143113.1502553-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
References: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are going to keep MMU enabled during relocation, we need to
keep EL1 mode throughout the relocation.

Keep EL1 enabled, and switch EL2 only before entering the new world.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/cpu-reset.h       |  3 +--
 arch/arm64/kernel/machine_kexec.c   |  4 ++--
 arch/arm64/kernel/relocate_kernel.S | 13 +++++++++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index 81b3d0fe7a63..296abbac7192 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -20,11 +20,10 @@ static inline void __noreturn __nocfi cpu_soft_restart(unsigned long entry,
 {
 	typeof(__cpu_soft_restart) *restart;
 
-	unsigned long el2_switch = is_hyp_nvhe();
 	restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
 
 	cpu_install_idmap();
-	restart(el2_switch, entry, arg0, arg1, arg2);
+	restart(0, entry, arg0, arg1, arg2);
 	unreachable();
 }
 
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 59a4b4172b68..cf5d6f22a041 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -240,8 +240,8 @@ void machine_kexec(struct kimage *kimage)
 	} else {
 		if (is_hyp_nvhe())
 			__hyp_set_vectors(kimage->arch.el2_vectors);
-		cpu_soft_restart(kimage->arch.kern_reloc, virt_to_phys(kimage),
-				 0, 0);
+		cpu_soft_restart(kimage->arch.kern_reloc,
+				 virt_to_phys(kimage), 0, 0);
 	}
 
 	BUG(); /* Should never get here. */
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 63ea19868f63..b4fb97312a80 100644
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
2.33.0.800.g4c38ced690-goog

