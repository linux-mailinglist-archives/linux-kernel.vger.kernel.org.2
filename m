Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88D43931CD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhE0PI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbhE0PHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:07:31 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E014C061346
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:47 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id h20so911818qko.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=spq5ynnfnR8TM5XEPzllfdybPKsLwK1jYCVhSyBxi9M=;
        b=kEzFCK/OZq65q45023j25DBKIv6t/KPooiYfjWWPP3IJOjjHeRmCpQtuVLJkoQfk0m
         LLZVUvatSqsTefwkG844IqhjmqYz+eKjmIWMguCbE//G/PZilV1ovqWDnr3/kiQThoLe
         8J5fE0vuDmRoHMifm12gmszoCPbgL/6vKPWVbsXnCVp6POQBaG8mMnHIcVImT2bPCI1y
         BV/yFm5eIJfxxYVdS1bcl46gMJrIytDeVhMlnOV5TIYrxeOwAZcaQxROJ+GyKDP9GrtS
         PtTEcv1/j/uuZXYBfqEmqGTXfvUSywNUrIEs2IE6VveTwxDnHBc/1L6sfb2iuapuRDjs
         +mIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=spq5ynnfnR8TM5XEPzllfdybPKsLwK1jYCVhSyBxi9M=;
        b=U+EjF4KQ4anQD771ggpXHHNgo3pTaoSx7Ma+NEJksmoUGLS4PKaxI+gcff7OqLnxQO
         +GhWnZN0Ia1AfMxrhYwyIXdHE6PYEGwYXn2VZnccVY7vRx1HZoc3fxtNvw9iXb3rA9Bv
         eFxMq6dUNNO4mCCuTboNtk+MhQrMN79We/Uz/x1fBi0r/lOsWCVfFtGWg26cu6pW/t9I
         o4pp2SHdrOY6WQp39XjfDjVh37BmKNc1vAJy/CBX5fg4hAq3LnDFh3aK4/L2I+sHUNZu
         xgYdd7021FYkzLunI1y1tizpT/I4FdQ/s/a0mMDzT+xTYBHFD52GkOX5kk3w/jszfQfE
         Qx1Q==
X-Gm-Message-State: AOAM533I1M7gaCth5acI/8KO9heILeqT5RZW0CPR2xWaHgnpo04EIsyx
        3wK7NvpEgKIHHenT9w9k6eBqwA==
X-Google-Smtp-Source: ABdhPJwCPp5AbyvNOecFI+FqtUWaR34fdNcgOcCR3qCe2Y2zX902CBP0VehAshlb1076RC/1us6hfg==
X-Received: by 2002:a05:620a:2282:: with SMTP id o2mr3866648qkh.479.1622127946786;
        Thu, 27 May 2021 08:05:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x10sm1447468qkh.124.2021.05.27.08.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:05:46 -0700 (PDT)
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
Subject: [PATCH 12/18] arm64: kexec: relocate in EL1 mode
Date:   Thu, 27 May 2021 11:05:20 -0400
Message-Id: <20210527150526.271941-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
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
index 48d0ed48c147..296abbac7192 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -20,11 +20,10 @@ static inline void __noreturn __nocfi cpu_soft_restart(unsigned long entry,
 {
 	typeof(__cpu_soft_restart) *restart;
 
-	unsigned long el2_switch = is_hyp_callable();
 	restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
 
 	cpu_install_idmap();
-	restart(el2_switch, entry, arg0, arg1, arg2);
+	restart(0, entry, arg0, arg1, arg2);
 	unreachable();
 }
 
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 9f74791cb1d0..c9993f029262 100644
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

