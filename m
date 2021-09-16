Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C5140EDC4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 01:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241524AbhIPXPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 19:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241544AbhIPXPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 19:15:03 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C41C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:42 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id p4so11669254qki.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NWsMjir7JLvcnjD8xhnB6n3wImzlZNO2jGCGH+AGQL4=;
        b=cB/9gAHcI9xMOZMGhUHMmoaZ4eX9ZrPDip4z8OjM0AZioqvYvr8GL+MRm6GnudDDNx
         G5BDmCaZBnOmiXHQZk8ZBd932wVBTMnFyT8sauWkYq6K9u/7xeWnNj8UhO7OJYvjYftR
         uc/o15lKpVu1WgNZg5Qm9ouL/178MWWpFwiC+fHOfQy1x4IVEQBtoEaqHHBM516RKyYH
         RSsyXSosIpPE7JwRtT7ENWoaill1to/kSd/F+/gXXDAlRgQqU32S8HRHng/VS5zAm+1S
         TT4vhAi8GfrQabgkyNPRnNTMUNO/wj4iLrCQ2E8RZ6KTRgbOVjA1adfYyHqkmFYaTIde
         K33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NWsMjir7JLvcnjD8xhnB6n3wImzlZNO2jGCGH+AGQL4=;
        b=ka2YcMFgpdgk1+M/cGDZsnzO4qW6WEFTqzxCvrR1vHXmLB3amOL/8u8LMpJgo9Px+V
         cSyaPChXXWUh04ni787w0puKevXBDwBHUryOxlCtfgTVk8U4Dgq654c35mT/KiksoKEe
         xRhUlZVjUsdoK8W75menGDnXXMUUG4Ieawp7qky5UaBffP5iprqnVt7pUneOn7uf1zh+
         +dfsOtmnyDNjOMMD2NIHNTTj8R2oo+wJaesFwhs1mwWWJIvipUnm58vhzZ9d6GQheth4
         VWmyA9BVrUXnXI7aim4kofSqvuFmwg6HavfjpvUnuybMwO5UTyE7ThnPLGtLaN6PyFju
         05yA==
X-Gm-Message-State: AOAM5311xAtv6ETK2AEmKpJXMB3U+U9aj/kHJBlPpj287shxPLaDLN/x
        FrfvJLGnfIKVgHNgcj+HomiSLg==
X-Google-Smtp-Source: ABdhPJyr/w2wgeq1H7NcfK32k0qrGhT2vhypkOOkKoRwzsQC6ihtdXUgyVzeBL/bHBxHZgee8ex8RA==
X-Received: by 2002:a05:620a:4404:: with SMTP id v4mr7806522qkp.344.1631834021164;
        Thu, 16 Sep 2021 16:13:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id az6sm3312891qkb.70.2021.09.16.16.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 16:13:40 -0700 (PDT)
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
Subject: [PATCH v17 09/15] arm64: kexec: relocate in EL1 mode
Date:   Thu, 16 Sep 2021 19:13:19 -0400
Message-Id: <20210916231325.125533-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916231325.125533-1-pasha.tatashin@soleen.com>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
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

