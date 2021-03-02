Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536F532A850
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580156AbhCBRaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444277AbhCBPG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:06:29 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543C1C0698CE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:01:06 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id k185so17009880qkb.17
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fnu4kZLmantAPLgmfgZ7PZzVHqXbW8DjkSliDC/e8I8=;
        b=uUNW1RSwz/PPPl1Ua1IuQ64hOM0R+lTodrWU3UbAefyenAEai8RA0+im6R8w77uKKJ
         g4DVj/KqEe1TwMkcz/Ygt9jjIn5f38pgXuncyWnVA/+aa/N++uGeKO34r+o678oP9Mq8
         67RAjq0NNwnf+jsn3QGIHhc250LRidVe1EfBP+5OIoO/7rtNLutaZrtEM1c24NPrdROO
         AFGrLf0EhJQzjScHxY2yPE6vMV/MjHb4X61lyzoWiVZ4RX2UG8RcNll2OE8OrY1N1eKg
         6/SG5RQNSa0TOnAV1pRMMAOGJJqvxbtGjwYBUsH85FOGQKa/2mvXOYVgOo4Aa+FxfQOa
         yteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fnu4kZLmantAPLgmfgZ7PZzVHqXbW8DjkSliDC/e8I8=;
        b=fveHV5coVWupwIgZsMnMaxTE8IEQu6k/wniyXUyvG2vR2kqbavho4Y1i1oZnSDFyZU
         d/1McMB6VLVFXejsiga7dffPKLrm/mG1tTGPxbULD804clhlovgE4cRUhH18H86jxukf
         1WxrkOTOoZrmOqH8g8a52jumx9Al/37rBHlBeWa7Cu3sLBM9KiZNoUheI0/F2B9SPpU+
         Fcde9UdNp5pd9sXmyzJKRrCZLC+T7pvk8RylDhseIRyZfNqxKy3kLgH/7Mf+pvGN8ppL
         kzEea8xGtVvYriyOnIiUj75+AoBhMovi5VFqIpAhY6XReArHO80oA5j3ASofg2OL0mRa
         UrdA==
X-Gm-Message-State: AOAM532X9p6MxTWKp2iBkPHds2mxD4ZcJVBdR+8TDIBwQO8HrmhJjGFu
        Dc7xo0YgChVUwnLtK3ng5+/AFPOmLP8N
X-Google-Smtp-Source: ABdhPJw8Dq6/V08jN1owoo4yABfxU5wp1FwJVtfeIaUa56rS2EjFaWfxxNpGQxARvmsP7DWrgv0nk/HKhje6
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:c78c:: with SMTP id
 k12mr3964748qvj.47.1614697265404; Tue, 02 Mar 2021 07:01:05 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:56 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-27-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 26/32] KVM: arm64: Introduce PROT_NONE mappings for stage 2
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

Once we start unmapping portions of memory from the host stage 2 (such
as e.g. the hypervisor memory sections, or pages that belong to
protected guests), we will need a way to track page ownership. And
given that all mappings in the host stage 2 will be identity-mapped, we
can use the host stage 2 page-table itself as a simplistic rmap.

As a first step towards this, introduce a new protection attribute
in the stage 2 page table code, called KVM_PGTABLE_PROT_NONE, which
allows to annotate portions of the IPA space as inaccessible. For
simplicity, PROT_NONE mappings are created as invalid mappings with a
software bit set.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h |  2 ++
 arch/arm64/kvm/hyp/pgtable.c         | 26 ++++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 9935dbae2cc1..c9f6ed76e0ad 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -80,6 +80,7 @@ struct kvm_pgtable {
  * @KVM_PGTABLE_PROT_W:		Write permission.
  * @KVM_PGTABLE_PROT_R:		Read permission.
  * @KVM_PGTABLE_PROT_DEVICE:	Device attributes.
+ * @KVM_PGTABLE_PROT_NONE:	No permission.
  */
 enum kvm_pgtable_prot {
 	KVM_PGTABLE_PROT_X			= BIT(0),
@@ -87,6 +88,7 @@ enum kvm_pgtable_prot {
 	KVM_PGTABLE_PROT_R			= BIT(2),
 
 	KVM_PGTABLE_PROT_DEVICE			= BIT(3),
+	KVM_PGTABLE_PROT_NONE			= BIT(4),
 };
 
 #define PAGE_HYP		(KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W)
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index bdd6e3d4eeb6..8e7059fcfd40 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -48,6 +48,8 @@
 					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
 					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
 
+#define KVM_PTE_LEAF_SW_BIT_PROT_NONE	BIT(55)
+
 struct kvm_pgtable_walk_data {
 	struct kvm_pgtable		*pgt;
 	struct kvm_pgtable_walker	*walker;
@@ -120,6 +122,16 @@ static bool kvm_pte_valid(kvm_pte_t pte)
 	return pte & KVM_PTE_VALID;
 }
 
+static bool kvm_pte_prot_none(kvm_pte_t pte)
+{
+	return pte & KVM_PTE_LEAF_SW_BIT_PROT_NONE;
+}
+
+static inline bool stage2_is_permanent_mapping(kvm_pte_t pte)
+{
+	return kvm_pte_prot_none(pte);
+}
+
 static bool kvm_pte_table(kvm_pte_t pte, u32 level)
 {
 	if (level == KVM_PGTABLE_MAX_LEVELS - 1)
@@ -182,7 +194,8 @@ static kvm_pte_t kvm_init_valid_leaf_pte(u64 pa, kvm_pte_t attr, u32 level)
 
 	pte |= attr & (KVM_PTE_LEAF_ATTR_LO | KVM_PTE_LEAF_ATTR_HI);
 	pte |= FIELD_PREP(KVM_PTE_TYPE, type);
-	pte |= KVM_PTE_VALID;
+	if (!kvm_pte_prot_none(pte))
+		pte |= KVM_PTE_VALID;
 
 	return pte;
 }
@@ -317,7 +330,7 @@ static int hyp_map_set_prot_attr(enum kvm_pgtable_prot prot,
 	u32 ap = (prot & KVM_PGTABLE_PROT_W) ? KVM_PTE_LEAF_ATTR_LO_S1_AP_RW :
 					       KVM_PTE_LEAF_ATTR_LO_S1_AP_RO;
 
-	if (!(prot & KVM_PGTABLE_PROT_R))
+	if (!(prot & KVM_PGTABLE_PROT_R) || (prot & KVM_PGTABLE_PROT_NONE))
 		return -EINVAL;
 
 	if (prot & KVM_PGTABLE_PROT_X) {
@@ -489,6 +502,13 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
 			    PAGE_S2_MEMATTR(NORMAL);
 	u32 sh = KVM_PTE_LEAF_ATTR_LO_S2_SH_IS;
 
+	if (prot & KVM_PGTABLE_PROT_NONE) {
+		if (prot != KVM_PGTABLE_PROT_NONE)
+			return -EINVAL;
+		attr |= KVM_PTE_LEAF_SW_BIT_PROT_NONE;
+		goto out;
+	}
+
 	if (!(prot & KVM_PGTABLE_PROT_X))
 		attr |= KVM_PTE_LEAF_ATTR_HI_S2_XN;
 	else if (device)
@@ -502,6 +522,8 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
 
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S2_SH, sh);
 	attr |= KVM_PTE_LEAF_ATTR_LO_S2_AF;
+
+out:
 	data->attr = attr;
 	return 0;
 }
-- 
2.30.1.766.gb4fecdf3b7-goog

