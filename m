Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4DD3A0885
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhFIAqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbhFIAqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:46:30 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1912AC061787
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 17:44:24 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t17so16719078qta.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gWxay37gJuUJcx+nxRsc6EljZGbCG+r7QOiRM4oSXXw=;
        b=XVTcMoxKQNpHAERlWFtpAWIkpNZdrKfflATOF4mJVjZ28fHCHXALrlRZKavWPEu/T4
         F7rPyv0tFMiwq5YDEuNhRpmMxfXTtMrvxs9Uw7ZJhVRfssebxr9BrJIPhEcOVRmmTI8U
         sl62Z/+mIL4M2AC9o0ZMC/nj4a1udl7Qs6wM1kkgMmVvCApnCJBmSS1SJHjhs2ScpdXV
         7A3Qe/Hs3AtbOFDmrbaym/wcQ10LG5aVf43LkrUVamE0ldR7HN/v1QUOgAsD6qAkKC/7
         JzYTXc0mMucVZfhRyf6Qglt3tT+VeDNLE7o5/g3BtEPK7m+NwtIi2r2sWspJut84Gwlm
         ex2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gWxay37gJuUJcx+nxRsc6EljZGbCG+r7QOiRM4oSXXw=;
        b=g+RRm7SD1Q/geZt08Fmi/Bd2gUuxQefqCtLeqlMWXFTLWvL9Z6zMmmVJwbas81RFhC
         2hl691y6oxNpDAoKN1cIVHMU3NN45BsDj+shNMzL1ZSunvPJD76Fy/ptlYAe+/nZZyKj
         5Eq/zzVBQKk4fBEZwroZbrKmkbCfQYuniIKPe710oj3Vjiq0CnSE+9k6MrGY0AmuWV/B
         MDBikXdXGTCy1xA/ApTMwnO2+5ZvswkeVvWElrMtLpemxr2RxCoPAp0A6fTzTEo8d4Ku
         OQp2gWdSbDTdGEBKetjDy6+z7ANrrQsI9GM7S7pcivNxdQzRZ3LurtACw9IxQ14Y4zjH
         PJTw==
X-Gm-Message-State: AOAM533QRrbZeotA0OcnI5PnK7rEKwOyH1d3BOC2DRsmtcVCkHBefdky
        WdKIhIztmPRUPmsU940+IHtw7g==
X-Google-Smtp-Source: ABdhPJzeGFOwUM6YKiMqoMb6gKBWjIc1V8rc2G8wqLoy7ugeIsvgOGfXCBZV0ZKPy+a1WBOPcxSuAQ==
X-Received: by 2002:ac8:684:: with SMTP id f4mr23920164qth.79.1623199463270;
        Tue, 08 Jun 2021 17:44:23 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n194sm12869011qka.66.2021.06.08.17.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 17:44:22 -0700 (PDT)
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
Subject: [PATCH v15 01/15] arm64: kernel: add helper for booted at EL2 and not VHE
Date:   Tue,  8 Jun 2021 20:44:05 -0400
Message-Id: <20210609004419.936873-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609004419.936873-1-pasha.tatashin@soleen.com>
References: <20210609004419.936873-1-pasha.tatashin@soleen.com>
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
index b1cef371df2b..42b5d8105ab9 100644
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
index 2c7ca449dd51..cf06929c44e3 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -200,7 +200,7 @@ unsigned long sdei_arch_get_entry_point(int conduit)
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

