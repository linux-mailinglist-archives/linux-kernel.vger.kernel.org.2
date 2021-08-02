Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19053DE1F9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhHBVzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbhHBVye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:54:34 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E75C0613D5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 14:54:24 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id t66so18180691qkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 14:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Wj2NAixWvJ4nO1FkxHbUkwp7sIToaWThfISCCFg6+8g=;
        b=GscCSfNwt44SsxAiPP7NgcgGNAXIbZIzPwC6/zqeK9kfqT8QLhkAwdkgkT2aZY087m
         5KxwAVR12ZBJ/ZeCQcNoNKBBF9L+Ds0Hj+DcneIUI8ImzTrkqH9HxKuMPLFmwQsIL2XK
         bwuxoBK+4RmtzMm5BflhOQZqEsmZxQ0o70Zz2BcWeFPjp8YlBy4MF8vqjY80xbZLZ2jR
         T/2CwFLk0SR/DPY1g0sIDtYy50PCkJHFZYvSBfOmijbPnYSoHafv4h7czA+iRWjP/ZpV
         B1cOUnKsTAIUEMluLV/clockW2VvJCE1ndGhTSzVJhSqYABRu+HrJeFpQnkXSVhM/GCk
         O37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wj2NAixWvJ4nO1FkxHbUkwp7sIToaWThfISCCFg6+8g=;
        b=Plui3lwrqJRJkx+pjBsy3DKYRD48Tmmgc/Dx+br/oBjYPymhZcBmURpRZvSXz6FXtT
         0nrbyPaTIzSB3bTrGEvHCxL/IfILNeM13aa7QZ6FUDtozJh18WDlTAKy+at3tvCWgVUq
         0Hb+wnSyxT+75FcHbnlM/TzheGdk9naVMEt08fHzgLC05zguAbBbCQIIOdhdnl+npLFO
         ZEDlU1XjfUq5WgujcCXYA9za6OpcxFuHD5EKRAXRsGCXcWbNuODCeVcoQ0MiofGUB3+w
         rCm/4AwBKHmTQcHqW3+ikefs6MmIwuh+OVdrBMxLvjxVOzkRVdVTJnlaPwukZ2leSWhg
         GBmg==
X-Gm-Message-State: AOAM531SJapTMIKUtbvQ+i7Y5B7QSw1sdqvjSRV6MPTesvxY9WoHwd5v
        KCYqdidF0RstbhqxDxbJno4Rhg==
X-Google-Smtp-Source: ABdhPJwzqgDG63F1SdAX7UqdvA9CoqJlGcLHTWFM7eFYSkHjmR9g6tQlWW8DN/xg+wexZixuMpniZg==
X-Received: by 2002:a05:620a:a8f:: with SMTP id v15mr17503007qkg.257.1627941263546;
        Mon, 02 Aug 2021 14:54:23 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id v11sm5479216qtc.0.2021.08.02.14.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:54:23 -0700 (PDT)
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
Subject: [PATCH v16 09/15] arm64: kexec: relocate in EL1 mode
Date:   Mon,  2 Aug 2021 17:54:02 -0400
Message-Id: <20210802215408.804942-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802215408.804942-1-pasha.tatashin@soleen.com>
References: <20210802215408.804942-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are going to keep MMU enabled during relocation, we need to
keep EL1 mode throughout the relocation.

Keep EL1 enabled, and switch EL2 only before entering the new world.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
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
2.25.1

