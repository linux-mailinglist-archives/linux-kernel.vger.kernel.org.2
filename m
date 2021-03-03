Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADDB32B732
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383206AbhCCKuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbhCCAYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:24:31 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16238C06121E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:22:39 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id j8so516876qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 16:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=t5r+nQTDiOBjAcARZmxYD2C/XCnn3pF+1dbE/Rdt76g=;
        b=SwKTL4eCvkIvgxU6lGAV//PLN7/clkFuLLU3DXUzK1tQP8M45hnpri8l5cR3f1+Ylp
         sMpfdEfEz+Et5fTiJRblDRcFcdDME1BtQOImc3LBxmY2ee/EnHXeyesUtIl0vD64exx+
         VcRzv+DTWT/hDHKT9/XTJeTMiBflR4d/CWf1PPm9mvSFV7yUEEIVgbmppDsdR6CWOocz
         V0blw/3FCGwiuLgjQvSQ/B5NmZjurWUX6kzX83Lt5n0pSVAHFZPPAh+CUnOKE143JiH9
         EaWCHQ+48dXFnyzY6WGGo0svwQnyOB1kX9/+fl90p2Ln1YIFMmaJnFRL2kdEe5kov6l2
         jBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t5r+nQTDiOBjAcARZmxYD2C/XCnn3pF+1dbE/Rdt76g=;
        b=H9GZ8vtj29PBWSUxxL2/lIWzVCg39Szt3DReuqiTtc0mIBPXEt1ONxlTL0lN107Tsx
         HhLLXO7JYqkApLLs5UOk+xx5V22hG0Q9YmNEVcur9aDwYB6p/tkH1a1HP692D/ZY27KR
         DjLnyXz+frzK+Cz+UzJbvVpf1jfomc3pQPdAgJhx897EPQ3rSuvOO4hNlRwH9rVYsvcK
         7kMCLnaMPznUSoBbUqQK+xYxydwiSRme7JOM883BQDH92lhqcspRxViBbBBti24F92mO
         tqHke51cIw4gvqTAwgPFSl1GNQyi9VE6hItUHqLeAkiwUDlV1GJFzPNpyD5/O2HZG/Ey
         dpmA==
X-Gm-Message-State: AOAM532aN5fLqPzi3iqUcZ3f3B+JoQY/5XyYimNGFMFWBSExu2guToex
        YX+q3p9/jbVknE0UcUsenRyRJA==
X-Google-Smtp-Source: ABdhPJzO9otEd6iJTRYqtDhi+XwWHgyDvgnqwPpNWgOkK7byt0RQkwHr9BNXQF6YdGG3LDA/I4eZOQ==
X-Received: by 2002:ac8:d44:: with SMTP id r4mr19942609qti.7.1614730958326;
        Tue, 02 Mar 2021 16:22:38 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r3sm16690512qkm.129.2021.03.02.16.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 16:22:37 -0800 (PST)
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
Subject: [PATCH v12 04/17] arm64: kernel: add helper for booted at EL2 and not VHE
Date:   Tue,  2 Mar 2021 19:22:17 -0500
Message-Id: <20210303002230.1083176-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
References: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
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

