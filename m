Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1DB32A85A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580206AbhCBRal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448574AbhCBPFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:05:53 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE4CC0698CA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:00:56 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id k10so12146613qte.17
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VoWvRhVqzXHkQ0OsvxSGeS/VJPiNA3/g3FAmYYygOdw=;
        b=AjUn7I37yjHmuqeaXLfgA7dtYSSQwwN/4mcAzk8HpWqk8XmE81BG8HC75qZhUGfls/
         M0UchiZU+6VwuNndrGxdk2BjIPU+8enIfuinKdzPQa6PWDKoVD3qVJDHHGjdE6lUFUFm
         xROrWqmqeI6LH01tc3+3KqZwIQDZDeWu20eRjLkzQT7gxd/alLd29IAr46KfDHDLfQcB
         r0h8AcNcvuZw2QoF5e09oSwkTD8PSMKtQa5NUUlkyhGhG24SVC+dv1fuFYkLXn2SaIp8
         jRsY6UXZUSmEu2kqopQE9vx8d5HAX6OtZIq9auAHd5qMkR6/zmg55RGtssFV8WLZh1QH
         eXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VoWvRhVqzXHkQ0OsvxSGeS/VJPiNA3/g3FAmYYygOdw=;
        b=lZAvkDNpF5U3zTFfufiT6eesV49oQLQBlyyyQewEuW55J2H+KLcbfFhR3rFz3O0MY6
         zAmTOV1Bs4ZAYwkO4ujX54EbeYT/MBlGBwbRRhcqxRWVNnB7TTzmAbp6PHdocxkhjwfg
         0x73kDXjY6qEV12RQxen1nVeFMNrG26HKpI9M8VANARXxfeMb2e1Rf7hL7+uX9GGiTdh
         cMEmCkFNbp+fz2UuQa9kdhZ1JghXmmw5tjSrRhT+bNhkHV4VsAvRU9dvjOizxoBldtXn
         /w4567qgfV7aP3Q5PICxx4umbL8YmApe4e7gasA2aebICYly1SZVQKddsFFeWzVgjO2J
         EOIg==
X-Gm-Message-State: AOAM532r8zqau4tx3sWLpIa5IOZ+9J8eJpudscHuor+/e1qDhbHviyo0
        dXn7TDvmzsIBk4xHXF4qxSmZ5kMyMnD0
X-Google-Smtp-Source: ABdhPJx8y0kZKpPj1sFhkhggFZKcZCCqwCconUOz/jXAArtDcupPU7deynqeh0MVM45/MhZGwK2ChR5h6DCc
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:5901:: with SMTP id
 ez1mr3999273qvb.38.1614697255713; Tue, 02 Mar 2021 07:00:55 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:52 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-23-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 22/32] KVM: arm64: Refactor __populate_fault_info()
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor __populate_fault_info() to introduce __get_fault_info() which
will be used once the host is wrapped in a stage 2.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/hyp/switch.h | 37 ++++++++++++++-----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 6c1f51f25eb3..1f017c9851bb 100644
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
@@ -188,14 +178,29 @@ static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
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
+	return true;
+}
+
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
+	if (!__get_fault_info(esr, &vcpu->arch.fault))
+		return false;
+
 	return true;
 }
 
-- 
2.30.1.766.gb4fecdf3b7-goog

