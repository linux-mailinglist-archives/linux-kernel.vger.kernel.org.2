Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5469C3D56A0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhGZItb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbhGZItM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:49:12 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37644C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:41 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id b4-20020a3799040000b02903b899a4309cso8481346qke.14
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tkKuELagekwMv5lJ5KC16O2ECB7SNyEmk6kFSF/fHxM=;
        b=nk3MJc1TvlrOLzzIkiMf4rqf5hlIGKplrBy0rbLmw27uz1W6VBHL3ebA0vXPU5hqe/
         QoJ1dpPFJWYNA881TkoFyPstgtGjtstMfCXCBrv86MDx6OrlwzOGtjIAWJB+y8Ts/OF/
         uzElj+Fi5baAI3+Gd7/gAYFnufyRr/kcef4dno05tPLzPDrZFvZW5Zw4E6oA8mNnAsqz
         kmK+rxP55y6Q7IRGVH0DsjQTrpuBlDwMkGE8Q0sdJ2BOb5c9+MDQuNfFTrhqhDtnWWJT
         8Dkhb+jqs5SFv774P+xFvG/36uFaxoBLVLa+7H3VSPMzcE0DjbMAeNFWU0F9g6VrRrc8
         SSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tkKuELagekwMv5lJ5KC16O2ECB7SNyEmk6kFSF/fHxM=;
        b=AxEgpBw4kUOlXhi0bILQTwoD/mgV6o8ziOkeL1s3KJwChxzclV1mOXo88p7T3UlCpJ
         2NK7GMZCZEzzbHAqHS4Js6BV44HkagArRYKwJzRPwotDxTy4aEYi06FgHfRpy/2Yp+Pm
         UHa+UNWJYIQZ2dm/QP320I6+pIICRxbZC6Qui/O+wPwolPhQ3xIGOtXSFcZFqMAENuhA
         xK4S38J2xvW8RH46rwnM0pcO6abcPgo0QuuLnXwz/Pn5g0Kvk2UocX0zU0CPyE4a7VBf
         KRyYR4T83v7NqkxJGlI6WMi6v/ZpFnjxbnym/dVWHUKuNGvii6QHIJ0J+kth7rrkiCs6
         c5RQ==
X-Gm-Message-State: AOAM533sN7AwpeFS/2XO2tmeR3K/GqFWfaUhGK75tTnUKTySyjAzK1AZ
        JdJj85EJFY+4L2suzhmZcgp/I1WextuF
X-Google-Smtp-Source: ABdhPJw/Ly763xE6/tFkoek1tqopFddG61YOXzM273sCNQ1M4TAjeeg9umQGIef8D0FMW2bam9q3NSXPHFid
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:23a0:2f14:433:e6cb])
 (user=qperret job=sendgmr) by 2002:a05:6214:188c:: with SMTP id
 cx12mr16903787qvb.7.1627291780379; Mon, 26 Jul 2021 02:29:40 -0700 (PDT)
Date:   Mon, 26 Jul 2021 10:29:02 +0100
In-Reply-To: <20210726092905.2198501-1-qperret@google.com>
Message-Id: <20210726092905.2198501-14-qperret@google.com>
Mime-Version: 1.0
References: <20210726092905.2198501-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 13/16] KVM: arm64: Enable retrieving protections attributes
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
index 0be9f83974ad..f253fb5bcee2 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -492,4 +492,24 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
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
index bd409d524dea..fb80d3019cff 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -376,6 +376,26 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
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
@@ -578,6 +598,23 @@ static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot p
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

