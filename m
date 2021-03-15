Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1919833BEFA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbhCOOwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhCOOgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:49 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC346C0613E5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:30 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id bt20so14221884qvb.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4Rx7gWcwKaPhXLY5lvXa6du15Qxy17H39RlntOQF/eE=;
        b=JtSiHC2TC4X/MGPjI48Y4GobrRWomFGcriDZR5/63bf/t4F9faT8FZfr//6DW2bCqE
         vFrQ3UF8RHabwi5h1YoRFY7n7t3sRGh5jsoMOeRAZOTld0V4I9tXFZLeV1n0EmHbt8Kb
         RJaPzGu5/a3hf3sPxQSFikbVhfHl+o+9mr4BIvN0aficfCWF3qeZU7/UQ9aeFDZktDAq
         uZIWaIDSFqM8dyvJAQnJIDGmp1gIm1sZkCyULLN1PQl7hmCNtGUWwFnz2nmJG25iGfTE
         WPCsobnVYUH3ALp6t8+NG+2cPnRt01bGC8tR03xb8jzGrpRIPpD70ypkrxqa11f85FB1
         55JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4Rx7gWcwKaPhXLY5lvXa6du15Qxy17H39RlntOQF/eE=;
        b=W6dwQm8/QFgCdYGrW6AtFQp5CMLG0FkZd/LgzGrnQ0PibQQH6hFhqU5sfQEA7W7bbi
         KGDlpI9T2DjUsVd8Ar61SZEQQUCPmeZ5/HKBvSbUc9PxBBSExjDKuzC4yAZTvCT9SIwU
         l5NZGmTn0MGplXy7eVcm03qGprgK4Hc2M1u5khi3Miherohj67k/Nn+R2yuc0tHX1gBU
         XNufMUg+twkFiMcG0kooli8daxenbXvVZtt6AV9uFlvAAqUnLP/P7AkZT4vkz2/N1c7S
         VWrpbYZzCZsqx5HuULLwlzRIFOb3Y01K1ZPM8+xWXjDPiIo+WKvg0x9BDO+T5SrTRgbF
         87Wg==
X-Gm-Message-State: AOAM533m6yFzbZxt+ToxEA+VrmNfttkEy74lXTKqVsxO9ithQSTDQ2Sa
        IxpKUxKS0lqqeweLKOF9NoO5/kW77zPx
X-Google-Smtp-Source: ABdhPJwDuWrOGL4ZNg/gQX5rsFfklI3IYwIn1ywA0KCJ73UhqJaMFBFoK5+FmaaLDaHwrFinuC9riTG6A1yy
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:262a:: with SMTP id
 gv10mr11184211qvb.50.1615818989939; Mon, 15 Mar 2021 07:36:29 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:24 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-25-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 24/36] KVM: arm64: Refactor __populate_fault_info()
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor __populate_fault_info() to introduce __get_fault_info() which
will be used once the host is wrapped in a stage 2.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/hyp/switch.h | 34 +++++++++++++------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 6c1f51f25eb3..40c274da5a7c 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -160,19 +160,9 @@ static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
 	return true;
 }
 
-static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
+static inline bool __get_fault_info(u64 esr, struct kvm_vcpu_fault_info *fault)
 {
-	u8 ec;
-	u64 esr;
-	u64 hpfar, far;
-
-	esr = vcpu->arch.fault.esr_el2;
-	ec = ESR_ELx_EC(esr);
-
-	if (ec != ESR_ELx_EC_DABT_LOW && ec != ESR_ELx_EC_IABT_LOW)
-		return true;
-
-	far = read_sysreg_el2(SYS_FAR);
+	fault->far_el2 = read_sysreg_el2(SYS_FAR);
 
 	/*
 	 * The HPFAR can be invalid if the stage 2 fault did not
@@ -188,17 +178,29 @@ static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
 	if (!(esr & ESR_ELx_S1PTW) &&
 	    (cpus_have_final_cap(ARM64_WORKAROUND_834220) ||
 	     (esr & ESR_ELx_FSC_TYPE) == FSC_PERM)) {
-		if (!__translate_far_to_hpfar(far, &hpfar))
+		if (!__translate_far_to_hpfar(fault->far_el2, &fault->hpfar_el2))
 			return false;
 	} else {
-		hpfar = read_sysreg(hpfar_el2);
+		fault->hpfar_el2 = read_sysreg(hpfar_el2);
 	}
 
-	vcpu->arch.fault.far_el2 = far;
-	vcpu->arch.fault.hpfar_el2 = hpfar;
 	return true;
 }
 
+static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
+{
+	u8 ec;
+	u64 esr;
+
+	esr = vcpu->arch.fault.esr_el2;
+	ec = ESR_ELx_EC(esr);
+
+	if (ec != ESR_ELx_EC_DABT_LOW && ec != ESR_ELx_EC_IABT_LOW)
+		return true;
+
+	return __get_fault_info(esr, &vcpu->arch.fault);
+}
+
 /* Check for an FPSIMD/SVE trap and handle as appropriate */
 static inline bool __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
 {
-- 
2.31.0.rc2.261.g7f71774620-goog

