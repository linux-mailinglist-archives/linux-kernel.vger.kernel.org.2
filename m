Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416B532A82F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349742AbhCBRUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448561AbhCBPFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:05:43 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA74C0698C9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:00:54 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id v13so10265132wrs.21
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4oxp+YpplIoIB69u+tbsX2FMX4bca6h5fwiDtQ6/a1E=;
        b=DVwV4PEk1sNj/JtjY53/uNRLb44IFXbqnfCgK0gXSCwMPvjRNvm9Fcb1TcjqwrCfku
         euCCdmLYqJP39qBt+5Bew9C6jJ+Q/bGJwemVcfgXRh3nQXn8NkcDAuaezl/nhpgkNrDK
         f94J8Xjfqwl7DDHczcWMPaseBthcz2iTf0vYl5mo3WKmn0nIsdDOVisnf0UEOT7gqpCd
         Bx4inz0gG/xCu+KGf1nv2v5uR5Hk3FOUX9Hn8r4v/5ujdvnBCU7lrahHnPK/nXuRosk1
         W9lQkbXQttUHawOFtS1GUul9l6p1xAhGprMNslTZTrXUK43WU14pnWI770t3Dfmxfred
         +t5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4oxp+YpplIoIB69u+tbsX2FMX4bca6h5fwiDtQ6/a1E=;
        b=TH8oOZznmihhzBhf4AiCF+gSA9zmQotiSK6NcmiPwNABNvlFTST+/v1N2liACy3+DU
         +xxBLsbKa3FElUvBbQZPH2BacEvwjuSRVgDoRteUdKrPryAEbOlRRNqm3RTJod2JdrLD
         8y7JVhkyiQUbYKUyu35qhDVlKLS+r4e5/uDA/l9Hk7wJx4jLD0oTvUmPFUCQ6eZc7k1B
         zNfgW/l6f+jdNGfv64p6mPUTFf8JblmlH5mBwlWwtkUCeCB2wN8qE9/VUSK8wpQgKePQ
         Lqk9BgrQbAHLFJh9xSmFsmlGxz/xzsP54M5o6PpsfQsDhYC25QSk5QpcwgPjRhvjzNql
         v+rQ==
X-Gm-Message-State: AOAM5330VbVkTCvqNIgCbebjnnUAUfYMbYSs44MhmN4eKZ7kySeORTI5
        t1hj/OP9bLN8B9yXFrTi8lGdcz/tmNAk
X-Google-Smtp-Source: ABdhPJwfPjt5pFKOfHuPj31XXVqR4/+bIz9+vX0UnJf2kL9ZXviOPHu8S3WCnbrQ6ZUfzWMvmubTRIE+eq90
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:b6d7:: with SMTP id
 g206mr4471661wmf.123.1614697253532; Tue, 02 Mar 2021 07:00:53 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:51 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-22-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 21/32] KVM: arm64: Refactor __load_guest_stage2()
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

