Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A87540EDBB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 01:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241455AbhIPXOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 19:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241445AbhIPXOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 19:14:51 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39EFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:30 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id gs10so5268028qvb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=izAVFpEvWmgGrg5dDdCTfojtmVMYt432wfvBnpESnjE=;
        b=GAeeTsTiMWgZ/mrEbLarF+Ykm+dqSe+pmGVZ0WDN8xE7kyy69Iebgu6cvmgXJVOXLm
         OGd58KGOD9rxyk1SsSDQJgtTAkcl6mqQQwubDE/olaD+l/gSVM2Wnvx6NobhbR5cGsCl
         CUv0H3cFXUKMbB3hSV4cpYfzViaySxUwAJhOlc61BhZYlJgBhcEqcGJ7KUf2Eq20YCH7
         ui60w/IyJvPR7AEBxxUAqRAzMaJ5cTHKnGzHeP37FdyFBv9Q21yICC48ly/GiELsytCC
         jRkHtnnUDubxibZXVu3V6xMFzbfqa/xPs4N0smZdPjhJcrI83zk4WG7Kfskl7omyw6/M
         FJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=izAVFpEvWmgGrg5dDdCTfojtmVMYt432wfvBnpESnjE=;
        b=N3JugQO+wM1ygQVQiZ2O5XWQlFO1BLPLZOuxMwYEKpePdhcMxEb9E/eI6nze2d8Exw
         jOES1LkKbTgUg2vBhFM1AYQJT6Q8HuH0pX3d89mlzS+JjR4xiFlqhDIs2SMS+0FmIoUn
         uZBPGSwMA/2j7mRhz2NeYL7HkpH7BL/9ZgiIPYqWsHAIjXP2+f63VYwLhW/R4g6w3P3T
         /Xcj7y/YTAxpF98ZVnVifmN+TkMVi4B/yIrKLbBw1ZC68t5TUe0So1209C3+GScHbgb0
         XWJBr3wewDRJ3vRKdICSnBLIy04TTiNJ3PsrHlEqIFr++tL8MsiMKxmwzvOpTdgemsCe
         sQQA==
X-Gm-Message-State: AOAM530n/b1KhbozYQx/WsCt57laTYdtODNs8uDPQmkplSq2r388x3TD
        UZW+UENDuzQvcPflABzkI2OIDw==
X-Google-Smtp-Source: ABdhPJxDA+gY3OZD9CV/MvCWYphxLHZFgApqCPwPjnAgRNs7iMjwV+PWgCoWyHRjGBLVUarVMeiG2A==
X-Received: by 2002:ad4:466a:: with SMTP id z10mr8048091qvv.7.1631834009592;
        Thu, 16 Sep 2021 16:13:29 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id az6sm3312891qkb.70.2021.09.16.16.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 16:13:29 -0700 (PDT)
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
Subject: [PATCH v17 01/15] arm64: kernel: add helper for booted at EL2 and not VHE
Date:   Thu, 16 Sep 2021 19:13:11 -0400
Message-Id: <20210916231325.125533-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916231325.125533-1-pasha.tatashin@soleen.com>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace places that contain logic like this:
	is_hyp_mode_available() && !is_kernel_in_hyp_mode()

With a dedicated boolean function  is_hyp_nvhe(). This will be needed
later in kexec in order to sooner switch back to EL2.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/virt.h | 5 +++++
 arch/arm64/kernel/cpu-reset.h | 3 +--
 arch/arm64/kernel/hibernate.c | 2 +-
 arch/arm64/kernel/sdei.c      | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 7379f35ae2c6..a9457e96203c 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -128,6 +128,11 @@ static __always_inline bool is_protected_kvm_enabled(void)
 		return cpus_have_final_cap(ARM64_KVM_PROTECTED_MODE);
 }
 
+static inline bool is_hyp_nvhe(void)
+{
+	return is_hyp_mode_available() && !is_kernel_in_hyp_mode();
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* ! __ASM__VIRT_H */
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index 9a7b1262ef17..81b3d0fe7a63 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -20,8 +20,7 @@ static inline void __noreturn __nocfi cpu_soft_restart(unsigned long entry,
 {
 	typeof(__cpu_soft_restart) *restart;
 
-	unsigned long el2_switch = !is_kernel_in_hyp_mode() &&
-		is_hyp_mode_available();
+	unsigned long el2_switch = is_hyp_nvhe();
 	restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
 
 	cpu_install_idmap();
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 46a0b4d6e251..4c9533f4c0c4 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -49,7 +49,7 @@
 extern int in_suspend;
 
 /* Do we need to reset el2? */
-#define el2_reset_needed() (is_hyp_mode_available() && !is_kernel_in_hyp_mode())
+#define el2_reset_needed() (is_hyp_nvhe())
 
 /* temporary el2 vectors in the __hibernate_exit_text section. */
 extern char hibernate_el2_vectors[];
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 47f77d1234cb..d20620a1c51a 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -202,7 +202,7 @@ unsigned long sdei_arch_get_entry_point(int conduit)
 	 * dropped to EL1 because we don't support VHE, then we can't support
 	 * SDEI.
 	 */
-	if (is_hyp_mode_available() && !is_kernel_in_hyp_mode()) {
+	if (is_hyp_nvhe()) {
 		pr_err("Not supported on this hardware/boot configuration\n");
 		goto out_err;
 	}
-- 
2.25.1

