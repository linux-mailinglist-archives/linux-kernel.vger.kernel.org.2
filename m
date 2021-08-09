Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263B53E48C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbhHIP0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbhHIPZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:52 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0341C0617A2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:25:27 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id n17-20020a7bc5d10000b0290228d7e174f1so4147424wmk.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aj8MBR15jNb/eqSbuMjCVp1+vMaSCorP22m0gXjnWP4=;
        b=KglZAeR1qSe4Fux9NKVSqLH5ETyNyLwo5BwAI8rIRoar0U1eIzKsZBbQskglFPq/tl
         5wqV/Ut+gPY5oqueMzmWHR5oDZDZJeH0fiPF9GJU/HsJOHnSdK+3cGq7qAQUidtxQH/R
         7TVpr0n9seO4pWJOJIN2bYZ0Tx4rSBgKFVt4FjlPQyP6I0BU+Lww/FVIozy0ZUYBFzRr
         23ElyYL09R13mKCKacrpORmkccN37M4BnHPdt9fwA1QAK9rJOYlIOiqiUwwVUoAnbfkK
         INPA8y0/M0cYEr4FkzwW5r1AbfmtNKc81EiE4J3BrikgtA/oqRHJPLojwEKVnIbWh5de
         NQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aj8MBR15jNb/eqSbuMjCVp1+vMaSCorP22m0gXjnWP4=;
        b=r+Yrx08DTDe687P4wwszCTlMP7KOhrdmMYUB4EyVDGpcNMwV6j69q02lW1Y2zsIdrU
         QItw01lJULGkDv5QZAn9VcLklMwTBMMaOjoil4KmqAolluODECzt5j8IVVwL4pvxuVVC
         FAnZRUZ4UPnXrkJ3DCCSZElFscXtgiNByYesocVv5f3PJPlUmUu614+yrYTa3+vVvSiw
         iO2UJGBx5R7WEbrSqpsOY/LkQc4oGJTTbmKELzW3YazIrPhmc5XTLuU9H4Ig3SIAeGBw
         3Je86R0xKbSO7/CpSaP1RiDkspf1lX7F7SxPDQ1er0uhPpz2H7GUwDeHRSGGT4vsvmLY
         KS7Q==
X-Gm-Message-State: AOAM531tSFWaG7QWCLwfTRW5auNZq2AslDtXh4l62/a0E26VfzFOxHMw
        jnW4xZyjbaVzLP2Ve8rVfrKb74KbwyMy
X-Google-Smtp-Source: ABdhPJxO6Ief2rDrUHALAL2m66Q1K9ZTpGeNI4IRrYBo8N3BxkN9OXPutXcNR00+t/uvXxU7PCGCiVC7nza1
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a7b:cb09:: with SMTP id
 u9mr34069444wmj.63.1628522726484; Mon, 09 Aug 2021 08:25:26 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:43 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-17-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 16/21] KVM: arm64: Enable retrieving protections attributes
 of PTEs
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce helper functions in the KVM stage-2 and stage-1 page-table
manipulation library allowing to retrieve the enum kvm_pgtable_prot of a
PTE. This will be useful to implement custom walkers outside of
pgtable.c.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 20 +++++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 37 ++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index ff9d52f8073a..f1651e0153ad 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -506,4 +506,24 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
  */
 int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
 			 kvm_pte_t *ptep, u32 *level);
+
+/**
+ * kvm_pgtable_stage2_pte_prot() - Retrieve the protection attributes of a
+ *				   stage-2 Page-Table Entry.
+ * @pte:	Page-table entry
+ *
+ * Return: protection attributes of the page-table entry in the enum
+ *	   kvm_pgtable_prot format.
+ */
+enum kvm_pgtable_prot kvm_pgtable_stage2_pte_prot(kvm_pte_t pte);
+
+/**
+ * kvm_pgtable_hyp_pte_prot() - Retrieve the protection attributes of a stage-1
+ *				Page-Table Entry.
+ * @pte:	Page-table entry
+ *
+ * Return: protection attributes of the page-table entry in the enum
+ *	   kvm_pgtable_prot format.
+ */
+enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte);
 #endif	/* __ARM64_KVM_PGTABLE_H__ */
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index cff744136044..f8ceebe4982e 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -363,6 +363,26 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
 	return 0;
 }
 
+enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte)
+{
+	enum kvm_pgtable_prot prot = pte & KVM_PTE_LEAF_ATTR_HI_SW;
+	u32 ap;
+
+	if (!kvm_pte_valid(pte))
+		return prot;
+
+	if (!(pte & KVM_PTE_LEAF_ATTR_HI_S1_XN))
+		prot |= KVM_PGTABLE_PROT_X;
+
+	ap = FIELD_GET(KVM_PTE_LEAF_ATTR_LO_S1_AP, pte);
+	if (ap == KVM_PTE_LEAF_ATTR_LO_S1_AP_RO)
+		prot |= KVM_PGTABLE_PROT_R;
+	else if (ap == KVM_PTE_LEAF_ATTR_LO_S1_AP_RW)
+		prot |= KVM_PGTABLE_PROT_RW;
+
+	return prot;
+}
+
 static bool hyp_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
 {
 	/*
@@ -565,6 +585,23 @@ static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot p
 	return 0;
 }
 
+enum kvm_pgtable_prot kvm_pgtable_stage2_pte_prot(kvm_pte_t pte)
+{
+	enum kvm_pgtable_prot prot = pte & KVM_PTE_LEAF_ATTR_HI_SW;
+
+	if (!kvm_pte_valid(pte))
+		return prot;
+
+	if (pte & KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R)
+		prot |= KVM_PGTABLE_PROT_R;
+	if (pte & KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W)
+		prot |= KVM_PGTABLE_PROT_W;
+	if (!(pte & KVM_PTE_LEAF_ATTR_HI_S2_XN))
+		prot |= KVM_PGTABLE_PROT_X;
+
+	return prot;
+}
+
 static bool stage2_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
 {
 	if (!kvm_pte_valid(old) || !kvm_pte_valid(new))
-- 
2.32.0.605.g8dce9f2422-goog

