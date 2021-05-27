Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C71E3931BD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbhE0PHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbhE0PHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:07:10 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DCDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:35 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id i5so903867qkf.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Wg7p4vPv2NoAb+n17TZqII3/Mw2eE/iFM20fouMRLwI=;
        b=XrzMTNI74leC845PoHu6NBtRzlE8xBimsUOjXLlm0vqEuD994Nb3Pc9xZT4gWtpHt8
         6lnP0+AaY2h28uSAyDh1nu4Z+LTcUlllsx5eiqqj5bxu/ktF78lPtnAclLwfIv9SbkiD
         mxf6ado+CHp4f52cHMoGtOEQ1QFmpN1GY3q5Su+KiQuZ3j8z40XlQF1SLQjKkxpoYSe4
         Qoc1WTi0P9N2l1MX2xW5Que69zUhDpRgbA6a0ISuCBIqhTg95a8x65rSXLfqzWFsJIpb
         sP6Fsxt+vD5yqAz7mf4NLYOIOZlfCeWr0fuDyYPEX6c3bseja8qsl/UQYn1elCzeeUQ0
         b/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wg7p4vPv2NoAb+n17TZqII3/Mw2eE/iFM20fouMRLwI=;
        b=cv/eDABbw8BO9XerCqKT432XKo0BGrubPW+P1vtsYTE9qjYOHkyNvheE3RbLjDDoRz
         kD3RrFv28zw//juaiWI/hEqPe8vIr7Q5x6dByUC8Kb4YRf7TwQX0QA45otPIv1+SVnR4
         jXEcVmnbT1aA3tYfUGC+NPppqi+N4ApRVLPw0hooQmQPdOUqvbLjVx/v6DqTw8PNvoP0
         HDJ7v5JgNK2tSfM9nvfzFfHpwFfcknrUTJOHFg0Tv91m03ibZ4iZQ7Jebj48cT8dV9oS
         KDp3NZwxFiUIs6DHkNv4JUedUdfAnyp1WCd1dlIcuApFGMKzYOpArq9e3HO6ti4W6jMF
         g8BQ==
X-Gm-Message-State: AOAM533LvlNgebDHplR39ys+Lo91nSHW8DEwf5XBQ70iObnh2tSr57GS
        IJ9OJz4BRe7H2KqOvGAdrBIl/g==
X-Google-Smtp-Source: ABdhPJycl8DRfGqs/GI/GT6NLoLRwo6sDRsMxgXrzg8L64wopg0OcAVe2PjXq4CFxxycTq8ansLW+g==
X-Received: by 2002:a05:620a:14b9:: with SMTP id x25mr3931435qkj.460.1622127935134;
        Thu, 27 May 2021 08:05:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x10sm1447468qkh.124.2021.05.27.08.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:05:34 -0700 (PDT)
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
Subject: [PATCH 04/18] arm64: kernel: add helper for booted at EL2 and not VHE
Date:   Thu, 27 May 2021 11:05:12 -0400
Message-Id: <20210527150526.271941-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
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

[Fixed merging issues]

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
index 9a7b1262ef17..48d0ed48c147 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -20,8 +20,7 @@ static inline void __noreturn __nocfi cpu_soft_restart(unsigned long entry,
 {
 	typeof(__cpu_soft_restart) *restart;
 
-	unsigned long el2_switch = !is_kernel_in_hyp_mode() &&
-		is_hyp_mode_available();
+	unsigned long el2_switch = is_hyp_callable();
 	restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
 
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

