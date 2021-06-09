Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502843A0896
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbhFIAru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:47:50 -0400
Received: from mail-qv1-f53.google.com ([209.85.219.53]:38648 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbhFIArl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:47:41 -0400
Received: by mail-qv1-f53.google.com with SMTP id t6so6046618qvp.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZPSVbTnhn1kzrM4k6yG1hZdalcOX13NxNhzKc5GCg3M=;
        b=LGgj1DSeN2dBtzalXLyd/X7N/RCTiZa3EUru9uNeWdpVQJnvQ9bVsOe+hpBq10aBS+
         aY1IEnfFr3j+uNpDjtIRX15IWRmDkCAmORZVFue5KNHoK9ciqWHqDq8PCBfaG/bKQ9PX
         H4wnXAYOwb47RzvJL85RhAzTQ4swYnk5uLiqv1RevSgZBxDenYt+PNKEP6Xg8h9NdGQ/
         3DLpUIt2K7tm2CzWfhFt6+tTbTdPRHX38gq3dsPGJUfHALsxCr1UcjF9n5kDaIFRgbym
         rbYrqPpH4MczVux3IZZxQkckEORpurxOSkjx4dSeN6myWV528RbdrQVhFzdB/rchvYEp
         Mpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZPSVbTnhn1kzrM4k6yG1hZdalcOX13NxNhzKc5GCg3M=;
        b=DvZxS/K1YJ9hxfLrSFfIw9L0kZbW1Yb4WUb/N9SkrriquuABEwC3jVUm51RHeK4ms6
         d25awaaw+l8KgQs+g/ak20Zm44wSizY2An0X2FA8KajiQvT7P/D6k1/VnVa+T+PqixLg
         koBdLaRTxfIRB52qF6d5TvLLHozNMOzvkszlVpvozkuQUwpsFgGNRXdo9Bzy82mrWMVF
         d+9hVp5MFceAjBUReOFy1uotK02bWOE3EzRH1ofl9PievwBo50Md+bE5rLad7nTOP4pF
         vRws8kUANM24WlfurRdq7YPhQb5ZZXTwEGK0Xg0XBE60Bon7I+oVHDXZHXw/1m0H0d1f
         6Urw==
X-Gm-Message-State: AOAM5324rK6e2TqQ1pDNGmyDipPgmdY2uN0bBmZUokGWWK+NaoqfCYgs
        FnP0ywLdENuO6q/Sqe88HWxx1Q==
X-Google-Smtp-Source: ABdhPJx9mZ6UlFMdNKDraoLwthZ4OWu6MUyQRTHx+1rf8HWW0BNaBOPk307SDiklwhYTyx05MvoNSA==
X-Received: by 2002:ad4:4713:: with SMTP id k19mr3379354qvz.26.1623199474423;
        Tue, 08 Jun 2021 17:44:34 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n194sm12869011qka.66.2021.06.08.17.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 17:44:34 -0700 (PDT)
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
Subject: [PATCH v15 09/15] arm64: kexec: relocate in EL1 mode
Date:   Tue,  8 Jun 2021 20:44:13 -0400
Message-Id: <20210609004419.936873-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609004419.936873-1-pasha.tatashin@soleen.com>
References: <20210609004419.936873-1-pasha.tatashin@soleen.com>
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
index e0ef88cc57d2..152fb00bcccc 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -231,8 +231,8 @@ void machine_kexec(struct kimage *kimage)
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

