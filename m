Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4BF3DA446
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbhG2N3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbhG2N3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:29:04 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085E9C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:29:01 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id d12-20020a50fe8c0000b02903a4b519b413so2944186edt.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NSGLd5rP0jEwEBedGkOnIxS9bTOxpLrW9yksOtiI2rw=;
        b=V/JC2o+aGhrHJS4UXvEuNCHDiEoLg0Y9XUZ8DbpCYMVAaV4Qp4pzYEUbN0+dCmIvz7
         ug5TgqNXz91s47rFXRUdqwwXHw4JQuDC4YIRvTaES4qlC6IViW7MlohARYj5vvT0HcXy
         /5bS8SkpCABb135E8AaU/tE8brFIIdv5fpfYyBW71CPKxptU9BgZs+MYtCqgHg+dBstw
         duJUKwMMAPYhVeA9CtbAiKMEryWEmXgjNczXNbmQgmcV5olnAQbG+pcpqX2jyZgCv6/G
         2PpFBHLl2j4lLRIWTBQgzXUfNbOCBlsqYaTYIFoxKrvw8JAyP3M415pQ3MBK0SqcQDRG
         qZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NSGLd5rP0jEwEBedGkOnIxS9bTOxpLrW9yksOtiI2rw=;
        b=MAzHbhmR2UxJHrWr1W/CjhWgRzEruPKHGMiHj7/1+PCqqroIGIgyfX8A+q3SLJmyMZ
         KEQA+Cg1lOriGKfXBR1Q3nktVDOQxHN6MBgcLZ9NsoYl1f552KQY+JEO/KT7PY9HNBeH
         KSeBp/ZROCHrPLtFl7oJviQP4yGVtdYyFwzNJeXZB+doyC3MVvw71rhR22qxUKEIEAIe
         iW41Ad7nGdc8MwwICkkWcm3opEo1i/9R+UIoEsjiUbPej73127FMO2HQI9HuXj3Yml8k
         97Z/jnL9TxhHTfHR2W5tLyDKIhUA2u70TMdTlfo2M18M7hzQBaYBXNozrYOrMSIQZoVT
         VQgA==
X-Gm-Message-State: AOAM530b0QwB55ZVSAAD52CfwYb706oK4hBBO+ueSU3SZLtYxV29Yq1h
        7buRuBly1EKa5RII+wXmYKoISGaA1btU
X-Google-Smtp-Source: ABdhPJzB+o9pIY4nGwgIcOv53lmv+Ol4R2FzrR+UHxpEjNw7CJIBQCY1IdszSXZqu7HKk8gJv4G9waEPi+1Y
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a17:906:1701:: with SMTP id
 c1mr4576882eje.425.1627565339524; Thu, 29 Jul 2021 06:28:59 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:28:13 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-17-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 16/21] KVM: arm64: Enable retrieving protections attributes
 of PTEs
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
 arch/arm64/include/asm/kvm_pgtable.h | 20 +++++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 37 ++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index d5ca9b6ce241..7ff9f52239ba 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -505,4 +505,24 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
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
index 1915489bb127..a6eda8f23cb6 100644
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
+		prot |= KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
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
2.32.0.432.gabb21c7263-goog

