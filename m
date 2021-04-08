Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CFE357B10
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhDHEGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhDHEFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:05:55 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C88FC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:05:45 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id y5so918378qkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 21:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=t5r+nQTDiOBjAcARZmxYD2C/XCnn3pF+1dbE/Rdt76g=;
        b=fNSvTQaCMuUW4WM7DW+/ylfwvq1Nd8GFZI5DXNtogEMS5GfxQgFo8HftVUvgQ2WW+L
         XjYfVrYBzVm7gymnWJVpRO+ECRA4CD2OPDTfrymbiIxKBrxQUd5XMEqjZ/iypUUsTFIQ
         6X50BQCwfYfbVyhawd2DSswD4JiqBLSqjvnv2Rwzd4aXRn5JR/NNKZikJ7Aegbs8viUH
         jv4Sndd4hZAC5D8ilmQK3HkGGnaU5EB21eHXJMc2E0f2wAioMpgG8cnLIMFcOM1pGRSF
         OFnz738dO1OxUG42H7ZbsgXsFE1Ly4cb5QLHOxHHiRFqW+fFwulj1I3sI5tzncrV63RB
         bWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t5r+nQTDiOBjAcARZmxYD2C/XCnn3pF+1dbE/Rdt76g=;
        b=SZvFhlLZvocc24U1SnYQuojHSpfSQc+FsLE8osA3z1s3YtSgUkDGNTIFz3uRZnbCNO
         +HAjnBLQ1gIilXBzMqB7IeRG56iKgaAGgmZic+HUTRd6WzosG78mMSaR1i5aor6isNAA
         2wOb54q6nfFoeQ6J2ZfSmAW20dcGIdPuh5ALNaM2sliO8Nlh0B/4qHeNzhJ879yL91s2
         Xn/YMa34ZxoBto+lS7ywb0eAxXjvDtUR99VkD+ON8NzlRSGRY4yRfxdEbrofjUZbG4is
         4hbYj+1+Z/dI4DQGsK7ccs57PKpskM0H7t5rNDCvTE99GYPXTkRM6JL61hSjice6Rfrh
         HNuw==
X-Gm-Message-State: AOAM531VSfW+3Gnh62U/zKZk0f0TF+3WUY9cqw49hL0jDlxxlOYfvira
        JLyXOb3F31GepYZR3Hp5HhBsSw==
X-Google-Smtp-Source: ABdhPJwdX428kgXB8v1FqFOp3RPgJRd9YNsFO19DyJ2SqHXbzbyljk/FZrQI44bhTtoFuQP0Gs4fUA==
X-Received: by 2002:a05:620a:1497:: with SMTP id w23mr6610916qkj.260.1617854744436;
        Wed, 07 Apr 2021 21:05:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 207sm18177874qkl.125.2021.04.07.21.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 21:05:44 -0700 (PDT)
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
Subject: [PATCH v13 04/18] arm64: kernel: add helper for booted at EL2 and not VHE
Date:   Thu,  8 Apr 2021 00:05:23 -0400
Message-Id: <20210408040537.2703241-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace places that contain logic like this:
	is_hyp_mode_available() && !is_kernel_in_hyp_mode()

With a dedicated boolean function  is_hyp_callable(). This will be needed
later in kexec in order to sooner switch back to EL2.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/virt.h | 5 +++++
 arch/arm64/kernel/cpu-reset.h | 3 +--
 arch/arm64/kernel/hibernate.c | 9 +++------
 arch/arm64/kernel/sdei.c      | 2 +-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 7379f35ae2c6..4216c8623538 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -128,6 +128,11 @@ static __always_inline bool is_protected_kvm_enabled(void)
 		return cpus_have_final_cap(ARM64_KVM_PROTECTED_MODE);
 }
 
+static inline bool is_hyp_callable(void)
+{
+	return is_hyp_mode_available() && !is_kernel_in_hyp_mode();
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* ! __ASM__VIRT_H */
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index ed50e9587ad8..1922e7a690f8 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -20,8 +20,7 @@ static inline void __noreturn cpu_soft_restart(unsigned long entry,
 {
 	typeof(__cpu_soft_restart) *restart;
 
-	unsigned long el2_switch = !is_kernel_in_hyp_mode() &&
-		is_hyp_mode_available();
+	unsigned long el2_switch = is_hyp_callable();
 	restart = (void *)__pa_symbol(__cpu_soft_restart);
 
 	cpu_install_idmap();
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index b1cef371df2b..c764574a1acb 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -48,9 +48,6 @@
  */
 extern int in_suspend;
 
-/* Do we need to reset el2? */
-#define el2_reset_needed() (is_hyp_mode_available() && !is_kernel_in_hyp_mode())
-
 /* temporary el2 vectors in the __hibernate_exit_text section. */
 extern char hibernate_el2_vectors[];
 
@@ -125,7 +122,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	hdr->reenter_kernel	= _cpu_resume;
 
 	/* We can't use __hyp_get_vectors() because kvm may still be loaded */
-	if (el2_reset_needed())
+	if (is_hyp_callable())
 		hdr->__hyp_stub_vectors = __pa_symbol(__hyp_stub_vectors);
 	else
 		hdr->__hyp_stub_vectors = 0;
@@ -387,7 +384,7 @@ int swsusp_arch_suspend(void)
 		dcache_clean_range(__idmap_text_start, __idmap_text_end);
 
 		/* Clean kvm setup code to PoC? */
-		if (el2_reset_needed()) {
+		if (is_hyp_callable()) {
 			dcache_clean_range(__hyp_idmap_text_start, __hyp_idmap_text_end);
 			dcache_clean_range(__hyp_text_start, __hyp_text_end);
 		}
@@ -482,7 +479,7 @@ int swsusp_arch_resume(void)
 	 *
 	 * We can skip this step if we booted at EL1, or are running with VHE.
 	 */
-	if (el2_reset_needed()) {
+	if (is_hyp_callable()) {
 		phys_addr_t el2_vectors = (phys_addr_t)hibernate_exit;
 		el2_vectors += hibernate_el2_vectors -
 			       __hibernate_exit_text_start;     /* offset */
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 2c7ca449dd51..af0ac2f920cf 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -200,7 +200,7 @@ unsigned long sdei_arch_get_entry_point(int conduit)
 	 * dropped to EL1 because we don't support VHE, then we can't support
 	 * SDEI.
 	 */
-	if (is_hyp_mode_available() && !is_kernel_in_hyp_mode()) {
+	if (is_hyp_callable()) {
 		pr_err("Not supported on this hardware/boot configuration\n");
 		goto out_err;
 	}
-- 
2.25.1

