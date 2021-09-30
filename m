Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C4441DC4B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350093AbhI3OdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349929AbhI3OdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:33:00 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACBDC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:17 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id x9so5902261qtv.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZgbetCXmU2I4AxLznQ7nGzSUyVlFTduK3mMsOCeyR2E=;
        b=NvUabrPKnpzcu5TeS9l5XS+8SzQvkmleB8d/hakxdXIDBVUCJ9US6MWCXxhdTzzOig
         rr/9DOSe6KjgBFl4joofHr//byFKjS0nSWBIndIorTah/fBqaOu/+2XRbb7FbH0UuTwv
         Qs+9FnH6mov9SV8ogh3PfFtbpic6oXECOAXGs49oQpo/gRXLDCIhgwUHOgU2toON5fDa
         ZxNRn+d1qmt4sgmUbA+DVxfghB99G1F4g68Ox7xXTW6zqsK4O3qyumJD+UElSbXa4FRJ
         ayCH2de8a5bJEypbyBdzpWcQ30ht6ipCMWAJuJAaNNHEDZVYI6LaWbsuZo+3w/8KAA/g
         cSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZgbetCXmU2I4AxLznQ7nGzSUyVlFTduK3mMsOCeyR2E=;
        b=oekFf+TuRUCokVlUL0w1waVW+zNx6hMM75Agrj9T0r7GHnLptKw3cdiuYOdCAzk+su
         9IBaS+vNaVw+Axl0Uik9MUMKD+BIfozcmn5TQRp06WaZyzVFwKCm1QDneTFDIg1Ov5mw
         M4UCpbrQ6CCvoeREMLXGM+y8Afi/a79qR4x0x1kbMry+hWhS00nQnVbqWQytfr9FPTbE
         w8u0SBkKw2zwv+2ND+VgDcAI5HNxkOmfOAl68iCAPseEWJju54nRVbDbwhE2DxTAppx3
         W4lodIuWONdLd7VV8EbbOEjkEA6L4i3c719rZc0YqODuVgdRBlHzL58tgJZVzbCXuDhf
         RQcQ==
X-Gm-Message-State: AOAM532ffzXupAkFTltucRtt9TNJ8tzzHRLoOzHtsf0g4gC2PEilqSlL
        E3yHCrEOjUMomrUxkYKiGu/M1A==
X-Google-Smtp-Source: ABdhPJxvgW9/FtyJRraTI54gn/Z60LChe52Uu0d4MLes/qY0mj18LYUViK9I0CDtWXyZAWETFAM8yw==
X-Received: by 2002:ac8:4c84:: with SMTP id j4mr6839446qtv.411.1633012276760;
        Thu, 30 Sep 2021 07:31:16 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id l195sm1528731qke.98.2021.09.30.07.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:31:16 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, kernelfans@gmail.com, akpm@linux-foundation.org
Subject: [PATCH v18 01/15] arm64: kernel: add helper for booted at EL2 and not VHE
Date:   Thu, 30 Sep 2021 14:30:59 +0000
Message-Id: <20210930143113.1502553-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
References: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
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
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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
2.33.0.800.g4c38ced690-goog

