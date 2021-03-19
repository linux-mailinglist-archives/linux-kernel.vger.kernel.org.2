Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2112C341952
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhCSKC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhCSKCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:24 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22280C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:23 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id y9so4398156wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lQIT7boSH7VaErqDHVKDpxnX/gbqPaNn5BvEtRgavP4=;
        b=R1/pDoZJyieTAINWUHqJoxtobG4lEwFQR3LiF39XqzeO2APFzvrm447dISZFMa5jN7
         ralzLICmmDoKTbqiXrdoIhH3YbSQfHVyHM7gyVJXnMeiXw4sVkkOvXLy5DiPTO4FJjlr
         jluGERC+t2g6RW11lAmE1IcXrWoIXzwtaUaebUn0887cdfteVkcof7S7fA8ddF5RjJP4
         4a5lvx2Sh1FoITa/6m/lBQxTdh/ixJnn1kcXkU0r0/VXeMbhuQ2xZNT8yXrBaZ+8F9QG
         4RlDO8lK+Rih1F9KEBbIiEspgKm/W414x3ejf9UHiT42ojTLirs1UKNSsx2FJ84umEh3
         YNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lQIT7boSH7VaErqDHVKDpxnX/gbqPaNn5BvEtRgavP4=;
        b=D6RAUNCs6RWbjR/vxkX6OJ/+EULTpOm+ZujIxPP81lgqXT8ymbIrb1WN1MrUU7PtnO
         nPcLAQUF32Q3QHWWbVW1Sp3BiCQU2KWpEBg08B+Sb6j5yZPv2nHymD6a/FW1dMb0PqZc
         vRZdHdiArcnNAzFHGg4NGWxyuki9tkHx7AwSuZ41OUIXvkxlTDYiTQxGtTHbBu8s31Qw
         ut0q8Qmz8k8eeRsN+P1URP0u7coq7Sp9oD64VyUJpQYwNmGwxGe/ochFWyw+FbLy7XsW
         i7198e/nuJQ00QBk9fwPMc0uSrXEZ1qk7FHE8zPIlSn8isyOjXIg07dcWTry9HLHGAtQ
         0Uag==
X-Gm-Message-State: AOAM530NMV77xoLGLgf6gvZ2AY3VpnLYBr88ILhBz0fBylMHY7TFgApn
        rJtPQ6T79a4rIYc1MZhXOC5jpG7vb3za
X-Google-Smtp-Source: ABdhPJyQMa86XBPHTBxCw2e2CfDITisuclXMKQ6iyrl3usqkGpaB9PrWjBHq73sQDPJD4lcQRuD2rBE8WJiW
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:7210:: with SMTP id
 n16mr2895100wmc.13.1616148141857; Fri, 19 Mar 2021 03:02:21 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:23 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-16-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 15/38] KVM: arm64: Factor out vector address calculation
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

In order to re-map the guest vectors at EL2 when pKVM is enabled,
refactor __kvm_vector_slot2idx() and kvm_init_vector_slot() to move all
the address calculation logic in a static inline function.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 8 ++++++++
 arch/arm64/kvm/arm.c             | 9 +--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 90873851f677..5c42ec023cc7 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -168,6 +168,14 @@ phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
 int kvm_mmu_init(void);
 
+static inline void *__kvm_vector_slot2addr(void *base,
+					   enum arm64_hyp_spectre_vector slot)
+{
+	int idx = slot - (slot != HYP_VECTOR_DIRECT);
+
+	return base + (idx * SZ_2K);
+}
+
 struct kvm;
 
 #define kvm_flush_dcache_to_poc(a,l)	__flush_dcache_area((a), (l))
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 22d6df525254..e2c471117bff 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1350,16 +1350,9 @@ static unsigned long nvhe_percpu_order(void)
 /* A lookup table holding the hypervisor VA for each vector slot */
 static void *hyp_spectre_vector_selector[BP_HARDEN_EL2_SLOTS];
 
-static int __kvm_vector_slot2idx(enum arm64_hyp_spectre_vector slot)
-{
-	return slot - (slot != HYP_VECTOR_DIRECT);
-}
-
 static void kvm_init_vector_slot(void *base, enum arm64_hyp_spectre_vector slot)
 {
-	int idx = __kvm_vector_slot2idx(slot);
-
-	hyp_spectre_vector_selector[slot] = base + (idx * SZ_2K);
+	hyp_spectre_vector_selector[slot] = __kvm_vector_slot2addr(base, slot);
 }
 
 static int kvm_init_vector_slots(void)
-- 
2.31.0.rc2.261.g7f71774620-goog

