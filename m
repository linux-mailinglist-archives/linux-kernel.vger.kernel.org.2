Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE9F34195A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhCSKDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhCSKCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:40 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9595C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:39 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id n2so12709192wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GjgSG2oEX6Y5d63Q6T6vut7ZZTlqBxwi5efWbFs4G3E=;
        b=S5kKNL4tlI5dNGFANy/IKuIGybGzvQQU9/MM5a8BNQt6JXQzXKcanAZTG3b2U3Rg11
         p89/euA5ijDgm2QKH2zxFh7PKxAHgxRnzgvM0zHisClI7T7zyH2csKtmuiQZyMRbc95b
         tuYIhtSD2h8O1ocaqETwzOAnL5q7kEu/AQEXJSqUM3lmEbfL7/0ijhdQ+oU0KZ0pd1yc
         PiCVbcBPJqDwYpWqoHfzO3xahL1JQJNOnGBYhSAz+1yAfnfWHqoCPXn/jPBNEtMJ8EdA
         hmgHBrACLG/WZr4NArEaKqPZOs4d6LQAx3ETUgzruixnZL4gv7Irte5mIQ0Z0iMi0vra
         TzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GjgSG2oEX6Y5d63Q6T6vut7ZZTlqBxwi5efWbFs4G3E=;
        b=pSzGR8+YzjEmvbIZ0Yaq0To1l/QmjHP7Kehp/WaVFK1GuU1MvELjiHzzF6bzENFXOx
         EzBxCbqVHtaxtypQnFt9aFGhmcUTDzYeTgd/sbTsr0oAaCEhy9aT7Iqamlgampij7XLP
         +mabV9Kw1IAlWViu3J6AwpySwivMDvgitnf7OT1qt0Y96FCTCv8S/TD36baI4gGdugcd
         /qFK1Vyo/uOQfP0imKgqbtAWMdcgHMIC0gm8Fwu1CVkD5IjvngR3NN/fMiiES1WqDONK
         RxcoNSU6FA9YK28yUcDgdRCBiYuQHjs0TVeIu1mt1pTgMEKagHw80uaLFInSM1HsyEFl
         HivA==
X-Gm-Message-State: AOAM533Kse3SwyyAqZWwqKYlXRlwN/G4LHINC4F1WLOVfB7MXn4hXh8f
        QPIs0jGRZIns7DdTECVQn5RYbtN07/CW
X-Google-Smtp-Source: ABdhPJzVhIo8TziXOi/TrL7kQ6HeUWS2jzLLmQi9MnH0SGd7F0xBNRMVC4+tK89lWUsE4gqU/I6SxYi8CiF4
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:e388:: with SMTP id
 a130mr3009460wmh.187.1616148158391; Fri, 19 Mar 2021 03:02:38 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:31 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-24-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 23/38] KVM: arm64: Refactor __load_guest_stage2()
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

Refactor __load_guest_stage2() to introduce __load_stage2() which will
be re-used when loading the host stage 2.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 6f743e20cb06..9d64fa73ee67 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -270,9 +270,9 @@ static __always_inline u64 kvm_get_vttbr(struct kvm_s2_mmu *mmu)
  * Must be called from hyp code running at EL2 with an updated VTTBR
  * and interrupts disabled.
  */
-static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
+static __always_inline void __load_stage2(struct kvm_s2_mmu *mmu, unsigned long vtcr)
 {
-	write_sysreg(kern_hyp_va(mmu->arch)->vtcr, vtcr_el2);
+	write_sysreg(vtcr, vtcr_el2);
 	write_sysreg(kvm_get_vttbr(mmu), vttbr_el2);
 
 	/*
@@ -283,6 +283,11 @@ static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
 	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 }
 
+static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
+{
+	__load_stage2(mmu, kern_hyp_va(mmu->arch)->vtcr);
+}
+
 static inline struct kvm *kvm_s2_mmu_to_kvm(struct kvm_s2_mmu *mmu)
 {
 	return container_of(mmu->arch, struct kvm, arch);
-- 
2.31.0.rc2.261.g7f71774620-goog

