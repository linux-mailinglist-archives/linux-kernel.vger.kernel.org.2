Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE76357B18
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhDHEGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhDHEGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:06:06 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B10C061763
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:05:55 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id j1so260780qvp.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 21:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ATHDsIlQRij0i8p3z1/oZchje9DfRT1VSEQgV22ghC4=;
        b=cZfP06UdFwUbDXzsBkl1RZmPvCxQFFD555CU5BZSd+vAYM+/Oe+q5LF6b+AeDb3hx2
         LFsT7XpzjiKY3Si2YsqeQ/IsmJpOiDmMG/HNxXKVtP9KTMFFrpTt/zWcuY6K4+nYd9LP
         9ZKSsnmvV+2+q+Pmt93pKHZ0lgdpVdpMXDll0Wv1hibDF4r0T45CgLAGXvLMQJPDkBFz
         9IzjdkP1g6YNXrx/gkwrI/Ofe/tf10DE04Grydz47vkZEbw+ldvrJuhINzXNy4tlgWG7
         P+aKh8JBXoF2aRQrMgr5pwbBamx/FerBKZ1ntwmSE4A+0xIGTTmKGW08lsKS3Z2H1qJG
         Decw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATHDsIlQRij0i8p3z1/oZchje9DfRT1VSEQgV22ghC4=;
        b=qxRvfubWUlReNoTnIzFTMFDrtq3nMncfSLF3SqkgvserxvMwzQtgjBqQ5QE7WzpWm8
         8MJ8td7kbCeqZHhxsJcbeRK3B8lfitdAVxXfaoaDACZ1QWqsQfnZhflOBBd+up6waEdD
         MnSbS4sw1Oj2O5QiaIG+thhU0TajkgHHJ0NaAORk9fVAUGiQ7HICicfiJz0GrHU+ynw8
         +vS3A+fX5n0dmKxwWrIHa4RgjcrfiOXXgZ7Q2xhNxCB5Djxr8ZsnMpmExpPvp/oLHH1K
         g+eRbiXuU3kcHO4Ubz3vSmKwL4APCjHpNo/x/XJKNHtDiP/YaMVszzPNVAWBgm3AghkF
         jdYw==
X-Gm-Message-State: AOAM531j9WmOp7mD7hoBAIPn+QmCqosriKWG7yIQZpvioJTe/IhRUly0
        8yeXjxDSbfVCeI6r7G0xJnZ8iA==
X-Google-Smtp-Source: ABdhPJyQo5a7wag6qg1KfAN2lYACfcQS04kFQ7QD+1uKAF30/6EW8kWHUAmbTGpYPmRfnaUQw+xfFQ==
X-Received: by 2002:a0c:e2cd:: with SMTP id t13mr7015227qvl.21.1617854754850;
        Wed, 07 Apr 2021 21:05:54 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 207sm18177874qkl.125.2021.04.07.21.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 21:05:54 -0700 (PDT)
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
Subject: [PATCH v13 12/18] arm64: kexec: relocate in EL1 mode
Date:   Thu,  8 Apr 2021 00:05:31 -0400
Message-Id: <20210408040537.2703241-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
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

