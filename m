Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CCD334620
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhCJR7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhCJR6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:43 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B5FC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:42 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id o70so13367238qke.16
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4oxp+YpplIoIB69u+tbsX2FMX4bca6h5fwiDtQ6/a1E=;
        b=vfNvL6VYP4cIvis4RUMqKQm+EjWb6Qdd5uxQRDjzD2jvaui8luwSb3kbZaVs7Cun3c
         I70CqF0WoKxquNq8GHLfoqZouqHwob9jrTw3fol8OJSK/TwkWGztOcvr42WqszU0moEe
         H1A8F/B1Tfh3dsLtou0ZuncYrXXuZK625m0AzBYrpPpIlL1jDNEpm3fusVFyhxTSEQLr
         9SrqgMAJKv566vQ7PZQQcfFufCHMyYUsTWwpbZFUcqzB38QgZf896YlSPDkat+pg+eei
         OL16OP7Oedq8fTKRKJjFfbS+wpyjBA5hZtamumQ0v6fBmoQZrRQdY6ofweJTdrk80kOH
         KjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4oxp+YpplIoIB69u+tbsX2FMX4bca6h5fwiDtQ6/a1E=;
        b=XkYN8aZ5b6OBL0U0MG/GMgRgw2QX9ChF4WQWta40rY4aZErK404TkpAZOMnouhaAFT
         3EBu87cObvI2L0Bini7jbOPGwtTcEghYdvhlCYtpAw94fvYDYDARjlnWwE5MeW8DFi+D
         BF2CQe/g/Qrs5UIsS0wv8bzBej1MbpsONOpYhPMnOoC3B3auEqTdLONH0N9JTc8B7a98
         qFbnbdyxnG2v8MyHGkHDM9niJXTXBrBvin9oIiCQ5S3Vj6MkK54FhcQrQHs148h3O+HB
         XPPoo+7XOjoGI/mZJqjZrmMzzRiB/IYMrWdiSUbi2Ip+Us4bIl4n1s8ME7kK8z7wBD8L
         YMtA==
X-Gm-Message-State: AOAM532j6PEKPQrwd+jybPDNZZ7TdekCcjAh9GTPqmV+CcGch+7Xr9r0
        RAwwIO+RpWyOSlKaPrAdbA/oNQfdHqF8
X-Google-Smtp-Source: ABdhPJysjBX02XgOxXRd70RHGblWwl/bjhm+VVsnnUsNEc3jBBZ20r71lSy0Vi2+2+6+nm09mj60syhCGiEY
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:f9cc:: with SMTP id
 j12mr3939245qvo.15.1615399122003; Wed, 10 Mar 2021 09:58:42 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:39 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-23-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 22/34] KVM: arm64: Refactor __load_guest_stage2()
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
2.30.1.766.gb4fecdf3b7-goog

