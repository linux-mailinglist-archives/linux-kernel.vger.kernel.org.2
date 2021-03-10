Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44EB334621
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhCJR7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhCJR6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:47 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D56C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:46 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id j3so13296185qvo.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mOohSeaIfwaEz8hEwSDUNnz+PysLBU9WmW/RUHzGWms=;
        b=UpCuP2JVMuI2+hVj+HMC9GepoPsIZM85HpFVq86MfaLWQfpLNX0CKray2/cYIx3hap
         FulboVVX/ZHpVWShTcu4rkz5liv323G1IaAkq/Q7XxYW+eVy3QOYbeogjkUE553M3PKX
         biChA2Ckr+PQ2tq4vQH2hsa+yxoCKi4mutHQoucMaEC1c1zTEb4ltW/vBP3L7OdS8mx1
         Z+aDeD8BxzSyaR4xMCs8dlEBcK/zLbGW9ng687rwEBkWedmJU5x5I8x5pTDkDJfsOGr3
         gh9NFs7XMGoW4QhnPBTufa45Fj4aVoY9kvDtdX6Mm9AoCMnRhBRJtiXHkfmQanMbjAOo
         Fiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mOohSeaIfwaEz8hEwSDUNnz+PysLBU9WmW/RUHzGWms=;
        b=lXtq93Lo35cO1yY9b+SamnFbA+Wb3zQ89BqhYebegpVSbFTxH5o2VyU3xBvybxzEGr
         7wzXvK6E8wcZktcznPl9VB5IP1uYNtrZM7wtbu47HrVcDQhH3xAjaUPmedAH9foIQ3DV
         AhIfWZJBDr9ts+9lrQJR4QT3hQ2SXfQO4yFe1Nz0LN8Xv/ooKl0N3+n52Gj1BLYHrEYs
         /TjL8sbgFR3FmrwQOLoLBeUpDWrdF2CZXJuHzyR4E2jcWaTYAz6bShStDH3Z4pCnnt3V
         Zrw/+CxHHMKKnxzP7u3E/KDKcfEfiJ58igEQJv3y5Z5jECnBA8PxVUCbiRh2I8UjxIUl
         /aow==
X-Gm-Message-State: AOAM532k+PQ0n3Jki1J8E7+n0R6B7n8PGLR85dd6sky74meO4c+MhbrT
        aTqElFJOb1Jj+LZgIqI2ZSYxcuU+bfmY
X-Google-Smtp-Source: ABdhPJwx7QrSBh2ptN4PQ7VNEdb7G5Onq4cJuMCN82nqpZk0yWXTQDUEtyuol5HOBBtLBr8L8iuseENS5Fk+
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:b894:: with SMTP id
 y20mr4097294qvf.43.1615399125954; Wed, 10 Mar 2021 09:58:45 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:40 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-24-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 23/34] KVM: arm64: Refactor __populate_fault_info()
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org,
        ardb@kernel.org
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
2.30.1.766.gb4fecdf3b7-goog

