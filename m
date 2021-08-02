Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0473DE1F1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhHBVyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhHBVyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:54:23 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54318C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 14:54:13 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c18so18143137qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 14:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gpKUHaMAwkHB+q+UElCl69jZKnxiURz6Ucy0xkR2ELY=;
        b=mmGBEfnF9oZBlRuZblnuO8IgGciEd2V3OTlp4jdC//Y9f0WVpenL/OBOeVgveoRMwK
         wGT90RC7SKYswp9xlxMNjNoEZxUXiYv1oApAYHpcxpWe8tf6N4lQTVgE2Rl8MF1Jhwak
         IwElBw5j6ZSZWrGaDF64dNenVk8adI9vzpmEdI1vCNgmblGrXwAif7ZQ8wWR87WigxCn
         MN3qDKfl2RADG4h1zeg2WiGTzf7ZyIXlFU6DWq3NQO/zuQkkRfp581JDmFTlPmXrnmFP
         zxFEB75mCaToQgA6HJeeqdFJTs3x8N1jTVfZxqyMvfo/U22dsK/mdxKjhxQpuWjj5f6V
         Sjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpKUHaMAwkHB+q+UElCl69jZKnxiURz6Ucy0xkR2ELY=;
        b=fcuHiP3Coe/pr4L636Bq3mJGNIHDDp3+D+2zSLo7nE27KWTqCFM4chAxwFWDQwUAR1
         64d4PpE+tBv/Ja5tKm7t1vyuHKsuTfa+mrwLM19bDbTyhUWVied1CbLHmNZSKnDUaAY4
         5Pbl2uUlvN5gNW16edHzc9rrKYBoCBo6jvKy86oFUHhsA8wf9FdE2lpIScUAOnfrUmDC
         7LWqYLaVFSeKbNccWMeLqu0JNodeimiVwGwBEEReS0j2V9i+AD5J/rirqznE7ozU92fN
         bkv08xgS5SgHSLAzmDZihSfsPtIQEtuLFtvsNrPJJ0I4HxRYCGukbjK/JG/cXqAzSzDt
         8pSw==
X-Gm-Message-State: AOAM531SmRtg8/YkdLPp0Jge+ey84Cf2luxsvKg+v2EJzkO/FttOMKhu
        AnjlXM9qPntHH4vXuukBYR+7eA==
X-Google-Smtp-Source: ABdhPJxUfhb3Dku9KW46dPB118JL9YX+skltVkhp7xJNLax/VRpKXlKrybwlyB5FLGyYAGhSLrA6sQ==
X-Received: by 2002:a37:a058:: with SMTP id j85mr12147273qke.471.1627941252530;
        Mon, 02 Aug 2021 14:54:12 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id v11sm5479216qtc.0.2021.08.02.14.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:54:12 -0700 (PDT)
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
Subject: [PATCH v16 01/15] arm64: kernel: add helper for booted at EL2 and not VHE
Date:   Mon,  2 Aug 2021 17:53:54 -0400
Message-Id: <20210802215408.804942-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802215408.804942-1-pasha.tatashin@soleen.com>
References: <20210802215408.804942-1-pasha.tatashin@soleen.com>
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
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
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

