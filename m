Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318ED4335A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbhJSMPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbhJSMPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:15:35 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DCDC061749
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:22 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id 128-20020a1c0486000000b0030dcd45476aso2489843wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lCXO97acIcTVNhdFrwlNIxSBr90mPvzDNoClgWHJCM0=;
        b=lLI82bpsEIkmjoY5bXVC+fOWz3tBbzQRnGXROzrfoL0Hsv0Kg91MrtueOcbv3Emc/D
         qaQT0oCkTvnG0PCKOTLDzY6v56OT7Xcsj19OR9UJSMXrfkR9x8ClnzTDgv+H6isG1hCM
         tFShnrWPTZoIA+XbRBnJGPdh49+d/LzmInXPzxoXDPmstwOFRmG/JKhXFV5i6uSWJVcI
         9RX4o1KhQiK2xrPYekIxETgAMU85Q52iJ43Rosf3Bg+xTnx67n6CpMqukh034pJa10wc
         wLC72mXLvthBUu7yCdluNZmPKe6Y6/szco4QpoMjuBJ3QODkWdoutMHmV/S4TRmiPCZY
         9ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lCXO97acIcTVNhdFrwlNIxSBr90mPvzDNoClgWHJCM0=;
        b=Wr9H07KDROyUp8BCPzDSDgIbOGbd1duB/LpBlX9pAJDPnXA1tWz/zSqITvCmupaNg/
         3IvG4tiTnjWg2sfM7IPhW+4ODTOBlpE8gB8ODmk+BTkPCngVZbO4J58qGSZpz1olKO6T
         ipkVyp/Ksyf5poiB6+7/QhPFTfW2DeFcYWqDZi4FeEV/X7dn5oSW/SapoKE1oC/ly6XP
         FGxBo4Y+mhfoYqCvYbTlMEcnL7qVjiLgUVMjEeokCqH052etQKA/QXaC6sFDf9B9GnBB
         Uuj+EPYiww+PCmo/EPdpameIeFNYMzcgQFAQJRgtU8gAw5aj51s0b817lSk8GQtqkJ7M
         Tr3w==
X-Gm-Message-State: AOAM531OCBOMzSts+4y17JmQYxX5RqlcgOAcAO6d7YfjlpL/bmUaPKVf
        5kFwBgNPUd6NtvhRtF+Br7RTeFVaBI3y
X-Google-Smtp-Source: ABdhPJye5OMqyc5G8hN4J/2112S8j3HbKdiZz7xBn4/qs578wVcSY9YucExD5V8rQ+B6hGbkCyayZWZROE/d
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:59ca:401f:83a8:de6d])
 (user=qperret job=sendgmr) by 2002:a1c:770b:: with SMTP id
 t11mr5737869wmi.19.1634645600892; Tue, 19 Oct 2021 05:13:20 -0700 (PDT)
Date:   Tue, 19 Oct 2021 13:12:55 +0100
In-Reply-To: <20211019121304.2732332-1-qperret@google.com>
Message-Id: <20211019121304.2732332-7-qperret@google.com>
Mime-Version: 1.0
References: <20211019121304.2732332-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 06/15] KVM: arm64: Implement kvm_pgtable_hyp_unmap() at EL2
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Andrew Walbran <qwandor@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

Implement kvm_pgtable_hyp_unmap() which can be used to remove hypervisor
stage-1 mappings at EL2.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 21 ++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 63 ++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 027783829584..9d076f36401d 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -251,6 +251,27 @@ void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt);
 int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
 			enum kvm_pgtable_prot prot);
 
+/**
+ * kvm_pgtable_hyp_unmap() - Remove a mapping from a hypervisor stage-1 page-table.
+ * @pgt:	Page-table structure initialised by kvm_pgtable_hyp_init().
+ * @addr:	Virtual address from which to remove the mapping.
+ * @size:	Size of the mapping.
+ *
+ * The offset of @addr within a page is ignored, @size is rounded-up to
+ * the next page boundary and @phys is rounded-down to the previous page
+ * boundary.
+ *
+ * TLB invalidation is performed for each page-table entry cleared during the
+ * unmapping operation and the reference count for the page-table page
+ * containing the cleared entry is decremented, with unreferenced pages being
+ * freed. The unmapping operation will stop early if it encounters either an
+ * invalid page-table entry or a valid block mapping which maps beyond the range
+ * being unmapped.
+ *
+ * Return: Number of bytes unmapped, which may be 0.
+ */
+u64 kvm_pgtable_hyp_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size);
+
 /**
  * kvm_get_vtcr() - Helper to construct VTCR_EL2
  * @mmfr0:	Sanitized value of SYS_ID_AA64MMFR0_EL1 register.
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 768a58835153..6ad4cb2d6947 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -463,6 +463,69 @@ int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
 	return ret;
 }
 
+struct hyp_unmap_data {
+	u64				unmapped;
+	struct kvm_pgtable_mm_ops	*mm_ops;
+};
+
+static int hyp_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
+			    enum kvm_pgtable_walk_flags flag, void * const arg)
+{
+	kvm_pte_t pte = *ptep, *childp = NULL;
+	u64 granule = kvm_granule_size(level);
+	struct hyp_unmap_data *data = arg;
+	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
+
+	if (!kvm_pte_valid(pte))
+		return -EINVAL;
+
+	if (kvm_pte_table(pte, level)) {
+		childp = kvm_pte_follow(pte, mm_ops);
+
+		if (mm_ops->page_count(childp) != 1)
+			return 0;
+
+		kvm_clear_pte(ptep);
+		dsb(ishst);
+		__tlbi_level(vae2is, __TLBI_VADDR(addr, 0), level);
+	} else {
+		if (end - addr < granule)
+			return -EINVAL;
+
+		kvm_clear_pte(ptep);
+		dsb(ishst);
+		__tlbi_level(vale2is, __TLBI_VADDR(addr, 0), level);
+		data->unmapped += granule;
+	}
+
+	dsb(ish);
+	isb();
+	mm_ops->put_page(ptep);
+
+	if (childp)
+		mm_ops->put_page(childp);
+
+	return 0;
+}
+
+u64 kvm_pgtable_hyp_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size)
+{
+	struct hyp_unmap_data unmap_data = {
+		.mm_ops	= pgt->mm_ops,
+	};
+	struct kvm_pgtable_walker walker = {
+		.cb	= hyp_unmap_walker,
+		.arg	= &unmap_data,
+		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
+	};
+
+	if (!pgt->mm_ops->page_count)
+		return 0;
+
+	kvm_pgtable_walk(pgt, addr, size, &walker);
+	return unmap_data.unmapped;
+}
+
 int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits,
 			 struct kvm_pgtable_mm_ops *mm_ops)
 {
-- 
2.33.0.1079.g6e70778dc9-goog

