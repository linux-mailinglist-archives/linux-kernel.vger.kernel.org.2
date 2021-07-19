Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF983CD2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbhGSKHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbhGSKHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:07:20 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:55:56 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id z127-20020a1c7e850000b02901e46e4d52c0so3813095wmc.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jCVZUl7mrKXhOgc92CUwmjy/8GLL8qBZeqvKPdsULBo=;
        b=Iv6HLotZSYKnqU+lUooERsXuSEAWx3VwKrcAVoV7fvzbOe+NzdG1VEHTwtAWje0rIB
         FBjobDwaueZrOJExzeI7sdg7O2/F4Y5IOMh136apaQCyUSWAEPqaYj8KLp39ymbgQFzN
         AyCeCZTZKejh/1vxFoUB+cZ5GImkWfPknL6py9BFxSeKNLh1bEqTIwkkWL6/9QrqiZhx
         bufScWZMa+3N64Gm/bfzeL1huLY0dIepVZRrRZvKUeSf1CMleCvkwSbfE+lOV7YzkSqj
         LXRGJqpFmm/qRenArrM8tK3lx0xGKtC867Gs8dXTkq9S3SqJLJMrrTHmRgHEhXRK2f7q
         F7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jCVZUl7mrKXhOgc92CUwmjy/8GLL8qBZeqvKPdsULBo=;
        b=A30IYn/8SzTjoePmot+h718IaM3vCLCDj6GUWD73k6T5VUbVIcpTRUnQvTbUNYxQQd
         yuvt5ycn+1YOEbAPaXzWiy1sgHZINv6PEC4Uc+1V10ThRyx2HL+GtxQ4bRfkW6jm1fiZ
         OoZyxe9RLwvQXEaqnos6Qu311Rs1xigTKxXURDP9ycCme9h8gR+m1N0svq2ZPWgVsScf
         cJ6CopRA1X1W40bzJ34J48pLFJWGIz5gzIXp1Q85h2ugZBsYj77q5NqgaOmjqhh8ZzSa
         MY8qZH5SE23681DrXextGMYKbC20+mR8dE1ysR3iCkEPNv6lQxW+hMwKgIW6jWn14bOw
         tA6g==
X-Gm-Message-State: AOAM531+22opVYbxh12aDO54F/QaY9JEcmc8iTxgBuwwuggF9LJCFQyb
        RJlY7HKmxqo5TE9s7e5ePtJttLonHlsq
X-Google-Smtp-Source: ABdhPJzWhrN0PU3u2TAQJIPoHRtvJQ+RMyNfI8W8ip/YuHiS+H6N8RNCyCq0QLT9GDqXoBSdi1WyWB01xUsv
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1a96:a43f:6c2e:bb5a])
 (user=qperret job=sendgmr) by 2002:a05:600c:287:: with SMTP id
 7mr25592126wmk.1.1626691679361; Mon, 19 Jul 2021 03:47:59 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:47:29 +0100
In-Reply-To: <20210719104735.3681732-1-qperret@google.com>
Message-Id: <20210719104735.3681732-9-qperret@google.com>
Mime-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 08/14] KVM: arm64: Add support for tagging shared pages in page-table
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

The hypervisor will soon be in charge of tracking ownership of all
memory pages in the system. The current page-tracking infrastructure at
EL2 only allows binary states: a page is either owned or not by an
entity. But a number of use-cases will require more complex states for
pages that are shared between two entities (host, hypervisor, or guests).

In preparation for supporting these use-cases, introduce in the KVM
page-table library some infrastructure allowing to tag shared pages
using ignored bits (a.k.a. software bits) in PTEs.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h |  5 +++++
 arch/arm64/kvm/hyp/pgtable.c         | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index dd72653314c7..f6d3d5c8910d 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -81,6 +81,8 @@ enum kvm_pgtable_stage2_flags {
  * @KVM_PGTABLE_PROT_W:		Write permission.
  * @KVM_PGTABLE_PROT_R:		Read permission.
  * @KVM_PGTABLE_PROT_DEVICE:	Device attributes.
+ * @KVM_PGTABLE_STATE_SHARED:	Page shared with another entity.
+ * @KVM_PGTABLE_STATE_BORROWED:	Page borrowed from another entity.
  */
 enum kvm_pgtable_prot {
 	KVM_PGTABLE_PROT_X			= BIT(0),
@@ -88,6 +90,9 @@ enum kvm_pgtable_prot {
 	KVM_PGTABLE_PROT_R			= BIT(2),
 
 	KVM_PGTABLE_PROT_DEVICE			= BIT(3),
+
+	KVM_PGTABLE_STATE_SHARED		= BIT(4),
+	KVM_PGTABLE_STATE_BORROWED		= BIT(5),
 };
 
 #define KVM_PGTABLE_PROT_RW	(KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W)
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 5bdbe7a31551..51598b79dafc 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -211,6 +211,29 @@ static kvm_pte_t kvm_init_invalid_leaf_owner(u8 owner_id)
 	return FIELD_PREP(KVM_INVALID_PTE_OWNER_MASK, owner_id);
 }
 
+static kvm_pte_t pte_ignored_bit_prot(enum kvm_pgtable_prot prot)
+{
+	kvm_pte_t ignored_bits = 0;
+
+	/*
+	 * Ignored bits 0 and 1 are reserved to track the memory ownership
+	 * state of each page:
+	 *   00: The page is owned solely by the page-table owner.
+	 *   01: The page is owned by the page-table owner, but is shared
+	 *       with another entity.
+	 *   10: The page is shared with, but not owned by the page-table owner.
+	 *   11: Reserved for future use (lending).
+	 */
+	if (prot & KVM_PGTABLE_STATE_SHARED) {
+		if (prot & KVM_PGTABLE_STATE_BORROWED)
+			ignored_bits |= BIT(1);
+		else
+			ignored_bits |= BIT(0);
+	}
+
+	return FIELD_PREP(KVM_PTE_LEAF_ATTR_IGNORED, ignored_bits);
+}
+
 static int kvm_pgtable_visitor_cb(struct kvm_pgtable_walk_data *data, u64 addr,
 				  u32 level, kvm_pte_t *ptep,
 				  enum kvm_pgtable_walk_flags flag)
@@ -357,6 +380,7 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_AP, ap);
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_SH, sh);
 	attr |= KVM_PTE_LEAF_ATTR_LO_S1_AF;
+	attr |= pte_ignored_bit_prot(prot);
 	*ptep = attr;
 
 	return 0;
@@ -558,6 +582,7 @@ static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot p
 
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S2_SH, sh);
 	attr |= KVM_PTE_LEAF_ATTR_LO_S2_AF;
+	attr |= pte_ignored_bit_prot(prot);
 	*ptep = attr;
 
 	return 0;
-- 
2.32.0.402.g57bb445576-goog

