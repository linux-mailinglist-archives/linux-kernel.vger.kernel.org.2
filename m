Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAAA3CD2BA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbhGSKHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbhGSKHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:07:25 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69D4C061767
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:56:01 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id a4-20020a0560001884b02901401e436a18so8632111wri.21
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CdbaQ8ErF1YpwqlK/5v4bHdri/rt0mg1VAsqwWTr/Tw=;
        b=aS8jkLkK2wa4INhA28hZzPjEUZaTZKmwenqCsFfJQTdAz0UFabdJsQo6ri3VfTWEFw
         RGYXatDhYnjA27xu0fDx7wkypb2FYIlxvf85tFl8oYsJq2rHaR4IgkQpa+q4+FwBsWna
         y/5f6F8ckCQplGSacvD6+H8TPidKSuTLdk1aFl3aPp9BvtHNW1S7YV6XGANf94XI+K92
         wG0tzBduwioFtmG8ODCJFZhpzoP2jF27+9hOe1r+E4fg0ujsayMVKVG7rMKfXMgeAsAF
         CGBfReNZE1y1Up6lw+wxGzVUgnz28Z7y6A7GjkAKvbDoo8/B1qcvnhtx5JDqVDbCH60+
         RlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CdbaQ8ErF1YpwqlK/5v4bHdri/rt0mg1VAsqwWTr/Tw=;
        b=WOQdBwsictlEV7i4zdO6Hydb0mQbo5rYMTouk4UYm2Dvg5QTy5jroUbugA8f06QM8F
         xF7aSmQN+kTkbxNyJk1Pd/em9tOhK5PyMMKgthNgZcf1OOXKRWXlI/zGm7g568fEAXdG
         /M/RZxDEjLafzQhYbJ6ElsA8gZU9F1iDw4y13whMV18jCbcecK+egMjs72Pg0stGT/KH
         P7L1mBvu9jv+EWBdkrHh2PVoXmr9Mrf0ZPyEhv9qP+wDa2ekLO2ZqFBlNvDgRqSHnyMu
         ZSklVeolphKMLmV6qQDYxaMQNPl0BJ4gKfIqtR6H+DdYTT9E+3gD5JRf2KuubErUzx6e
         8R1A==
X-Gm-Message-State: AOAM531XCCncAWnnXzELrYF1S5/X9ljDevI85uVlOOD+2kIWa+jTldem
        LmjMoliHZvrRFM+ja+aV5hxfgmrvSIR2
X-Google-Smtp-Source: ABdhPJznScsyUNWBAsIAI2Jzd/ytZ2sHt95anHYybQcNiWFSnjuNiVNyg44CFTl1PSMEfVjtqavG8Cwof0vY
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1a96:a43f:6c2e:bb5a])
 (user=qperret job=sendgmr) by 2002:a7b:ca50:: with SMTP id
 m16mr31242327wml.140.1626691683897; Mon, 19 Jul 2021 03:48:03 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:47:31 +0100
In-Reply-To: <20210719104735.3681732-1-qperret@google.com>
Message-Id: <20210719104735.3681732-11-qperret@google.com>
Mime-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 10/14] KVM: arm64: Enable retrieving protections attributes of PTEs
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
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
 arch/arm64/include/asm/kvm_pgtable.h | 20 ++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 49 ++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index f6d3d5c8910d..1aa49d6aabb7 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -467,4 +467,24 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
  */
 int kvm_pgtable_stage2_find_range(struct kvm_pgtable *pgt, u64 addr,
 				  int owner, struct kvm_mem_range *range);
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
index 51598b79dafc..c7120797404a 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -234,6 +234,20 @@ static kvm_pte_t pte_ignored_bit_prot(enum kvm_pgtable_prot prot)
 	return FIELD_PREP(KVM_PTE_LEAF_ATTR_IGNORED, ignored_bits);
 }
 
+static enum kvm_pgtable_prot pte_read_ignored_bits_prot(kvm_pte_t pte)
+{
+	enum kvm_pgtable_prot prot = 0;
+	kvm_pte_t ignored_bits = 0;
+
+	ignored_bits = FIELD_GET(KVM_PTE_LEAF_ATTR_IGNORED, pte);
+	if (ignored_bits & BIT(1))
+		prot |= KVM_PGTABLE_STATE_BORROWED | KVM_PGTABLE_STATE_SHARED;
+	if (ignored_bits & BIT(0))
+		prot |= KVM_PGTABLE_STATE_SHARED;
+
+	return prot;
+}
+
 static int kvm_pgtable_visitor_cb(struct kvm_pgtable_walk_data *data, u64 addr,
 				  u32 level, kvm_pte_t *ptep,
 				  enum kvm_pgtable_walk_flags flag)
@@ -386,6 +400,25 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
 	return 0;
 }
 
+enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte)
+{
+	enum kvm_pgtable_prot prot = 0;
+	u32 ap;
+
+	if (!(pte & KVM_PTE_LEAF_ATTR_HI_S1_XN))
+		prot |= KVM_PGTABLE_PROT_X;
+
+	ap = FIELD_GET(KVM_PTE_LEAF_ATTR_LO_S1_AP, pte);
+	if (ap == KVM_PTE_LEAF_ATTR_LO_S1_AP_RO)
+		prot |= KVM_PGTABLE_PROT_R;
+	else if (ap == KVM_PTE_LEAF_ATTR_LO_S1_AP_RW)
+		prot |= KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
+
+	prot |= pte_read_ignored_bits_prot(pte);
+
+	return prot;
+}
+
 static bool hyp_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
 {
 	if (old == new)
@@ -588,6 +621,22 @@ static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot p
 	return 0;
 }
 
+enum kvm_pgtable_prot kvm_pgtable_stage2_pte_prot(kvm_pte_t pte)
+{
+	enum kvm_pgtable_prot prot = 0;
+
+	if (pte & KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R)
+		prot |= KVM_PGTABLE_PROT_R;
+	if (pte & KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W)
+		prot |= KVM_PGTABLE_PROT_W;
+	if (!(pte & KVM_PTE_LEAF_ATTR_HI_S2_XN))
+		prot |= KVM_PGTABLE_PROT_X;
+
+	prot |= pte_read_ignored_bits_prot(pte);
+
+	return prot;
+}
+
 static bool stage2_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
 {
 	if (!kvm_pte_valid(old) || !kvm_pte_valid(new))
-- 
2.32.0.402.g57bb445576-goog

