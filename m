Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E40B3E48BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbhHIPZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbhHIPZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:37 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7FCC061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:25:16 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id e17-20020a0562141511b029034f8146604fso5465885qvy.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4CFmU9uB5cuxc2lPCoWChXDNr9f3K+SqIKdnjLv1P4s=;
        b=rZmm2VKnjSmuiIf5p19o76FrNYszuOISRqkab3N4YFD95ogVFJvhagSQdpHXMeyhyj
         c3A82CuZtPTSFGFh2BXtGtUxrxi+jv2tB4LAp9D4hIFry+Hza8zHQht3NLujuVS1Ibus
         92eAwBDgemHLSymFMTKMs6lCfK4aAEP3jvkHWkXoLKMUSzIQUgc1+A9Ex2PaRj+rpOb9
         rxDag7IKYRu/MIgk/849635PQ18cH9sGG+H1T5zF/KKhXHTs5KpPyb2wXNjdavHHI1KM
         y/oFj0sH5zDEHl5qt/kGTjIthWR1z2MGqphl5V8yT7U28ZnIoRYxuG0VWw9zZDJSn9wM
         UdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4CFmU9uB5cuxc2lPCoWChXDNr9f3K+SqIKdnjLv1P4s=;
        b=Ph2sg22jHBbzCtNXLrFB3+eOcciJascFd2vrf2lyoXWARFMS6hOxTVG4LX8hp77ACC
         xJUEwbin0MrlxZxDgSTiPxmwoi2Vm7/OROYs4uC1NUr5ZMnToVWYzZWmVPL3xySUkEuG
         Jcec+y5Pxpe3NCF/8H0mGl0fiI0RPHVyTznrv6aqL347anZzqKSWuqDmJ1QrASHkEPhV
         KRQTPBVE9jLN9aw6JbHmlts42Sso7rBXX83MdG2cn5UqQnP29oxMuQUppryza+2XA9xz
         LkM6Qp84qTyyHQveXxkd8Kh7YjW34ngxOltn4cpOMVe0civUjbZt8FuVwHH0F+J7ra4B
         l65A==
X-Gm-Message-State: AOAM532MVBURxI2wzSufQwLIu03EBmVLaRenaU7DiZ9m0uIdYj6hZRBp
        lx0qWV7BqHffLZvRWwXA/ejvcjDgYBuK
X-Google-Smtp-Source: ABdhPJxlnJqrt/Vc6kgjycoOm+7KHQ8sxsdJFc8/TA+ubWDblTmiAVGwH3I7qjBHoAKuZruQygdEooL2YeNk
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a05:6214:10c8:: with SMTP id
 r8mr24109684qvs.28.1628522715621; Mon, 09 Aug 2021 08:25:15 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:38 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-12-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 11/21] KVM: arm64: Allow populating software bits
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

Introduce infrastructure allowing to manipulate software bits in stage-1
and stage-2 page-tables using additional entries in the kvm_pgtable_prot
enum.

This is heavily inspired by Marc's implementation of a similar feature
in the NV patch series, but adapted to allow stage-1 changes as well:

  https://lore.kernel.org/kvmarm/20210510165920.1913477-56-maz@kernel.org/

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 12 +++++++++++-
 arch/arm64/kvm/hyp/pgtable.c         |  5 +++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 2c090b0eee77..ff9d52f8073a 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -121,6 +121,10 @@ enum kvm_pgtable_stage2_flags {
  * @KVM_PGTABLE_PROT_W:		Write permission.
  * @KVM_PGTABLE_PROT_R:		Read permission.
  * @KVM_PGTABLE_PROT_DEVICE:	Device attributes.
+ * @KVM_PGTABLE_PROT_SW0:	Software bit 0.
+ * @KVM_PGTABLE_PROT_SW1:	Software bit 1.
+ * @KVM_PGTABLE_PROT_SW2:	Software bit 2.
+ * @KVM_PGTABLE_PROT_SW3:	Software bit 3.
  */
 enum kvm_pgtable_prot {
 	KVM_PGTABLE_PROT_X			= BIT(0),
@@ -128,6 +132,11 @@ enum kvm_pgtable_prot {
 	KVM_PGTABLE_PROT_R			= BIT(2),
 
 	KVM_PGTABLE_PROT_DEVICE			= BIT(3),
+
+	KVM_PGTABLE_PROT_SW0			= BIT(55),
+	KVM_PGTABLE_PROT_SW1			= BIT(56),
+	KVM_PGTABLE_PROT_SW2			= BIT(57),
+	KVM_PGTABLE_PROT_SW3			= BIT(58),
 };
 
 #define KVM_PGTABLE_PROT_RW	(KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W)
@@ -420,7 +429,8 @@ kvm_pte_t kvm_pgtable_stage2_mkold(struct kvm_pgtable *pgt, u64 addr);
  * If there is a valid, leaf page-table entry used to translate @addr, then
  * relax the permissions in that entry according to the read, write and
  * execute permissions specified by @prot. No permissions are removed, and
- * TLB invalidation is performed after updating the entry.
+ * TLB invalidation is performed after updating the entry. Software bits cannot
+ * be set or cleared using kvm_pgtable_stage2_relax_perms().
  *
  * Return: 0 on success, negative error code on failure.
  */
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index e25d829587b9..cff744136044 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -357,6 +357,7 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_AP, ap);
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_SH, sh);
 	attr |= KVM_PTE_LEAF_ATTR_LO_S1_AF;
+	attr |= prot & KVM_PTE_LEAF_ATTR_HI_SW;
 	*ptep = attr;
 
 	return 0;
@@ -558,6 +559,7 @@ static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot p
 
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S2_SH, sh);
 	attr |= KVM_PTE_LEAF_ATTR_LO_S2_AF;
+	attr |= prot & KVM_PTE_LEAF_ATTR_HI_SW;
 	*ptep = attr;
 
 	return 0;
@@ -1025,6 +1027,9 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
 	u32 level;
 	kvm_pte_t set = 0, clr = 0;
 
+	if (prot & KVM_PTE_LEAF_ATTR_HI_SW)
+		return -EINVAL;
+
 	if (prot & KVM_PGTABLE_PROT_R)
 		set |= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R;
 
-- 
2.32.0.605.g8dce9f2422-goog

