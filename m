Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DAE34195F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhCSKDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhCSKCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:52 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7165CC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:51 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id m9so21616546wrx.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uBuSDgADlVyxIdI3BmsAIPCPmlM7WqeZ0Oeo6QVFLts=;
        b=qCWraLZ0Tszd8AH74n5bMJc2ZNxpli+5BtX1Qu0TYtfObzVU7M02pQnddE7gvCf0iN
         pxmN8wb8E3OkHG0yFhoGSKXtXucoyZgOukVOd9KIzkfTZ/qis1gqdYkYBY6SgONRydNY
         KY5mRl/bU+IaXK3gVCVIou3kiMKprdEqZ7Fs1tKl1gCFYmPlEuuIQYwaYZS+QSHTyqNY
         47eTUx6l0G5XKkzF68I0V5R/05uQim6YGk9NHHdWAPWlBjSiZ4pqQy1/gCTdPSfuywh9
         Pg0WV+45hM8j8NIgdxeyB2hzRuAj3f9jXw1V3wXA8TEq7M0aKy6iE4YGWe1j2bPyM4Xy
         etHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uBuSDgADlVyxIdI3BmsAIPCPmlM7WqeZ0Oeo6QVFLts=;
        b=HumV7fkuqnkEM7jCmLiIYSqpuhA4AtCKsd49O8MRV9RyciB7SqNzIXyYxvfW4AAHDe
         gQCiIOcS+8WqQuO2puiZPSzxXMBBGOM6p4G5ACOIBL+RUlVnHY1xLA3UjSHYBqObZnpC
         E+Bm4tlnX6OpTCFDDp5/JBCGVlHgjSsA+qMrP5AzqH/1dZxpg71WrY9YxmclvG3Y1kiW
         GpVp7Gl42BeHxsINJUOgE9HqoS23vrgNf58sIARjzZmduukRJKo9hXqTV+r7M0X+8w0w
         oRa+PRUBeb7FhPpSce0N0G/sC67+QfutPRoNK9xrOU0/z7g356GQwInVcNfvsjed4K62
         MOig==
X-Gm-Message-State: AOAM531TQaiweBKVVd4k1mF1Q1MiMwFOvLgh6iBKW9NXmfyjpd1Ay8Wk
        jp9M0RniHVmWSkCVPCIm1oDPy6yD5gZ5
X-Google-Smtp-Source: ABdhPJy7gzoGDveYEOxbSnLDlDyWEZkPizO1OQME7oNr7V9YSTxgGFBprzpO+9yJFS/BuMsKlUSbA1VxNmbB
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:4ed1:: with SMTP id
 g17mr2965040wmq.67.1616148170085; Fri, 19 Mar 2021 03:02:50 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:36 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-29-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 28/38] KVM: arm64: Always zero invalid PTEs
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

kvm_set_invalid_pte() currently only clears bit 0 from a PTE because
stage2_map_walk_table_post() needs to be able to follow the anchor. In
preparation for re-using bits 63-01 from invalid PTEs, make sure to zero
it entirely by ensuring to cache the anchor's child upfront.

Acked-by: Will Deacon <will@kernel.org>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 15de1708cfcd..0a674010afb6 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -156,10 +156,9 @@ static kvm_pte_t *kvm_pte_follow(kvm_pte_t pte, struct kvm_pgtable_mm_ops *mm_op
 	return mm_ops->phys_to_virt(kvm_pte_to_phys(pte));
 }
 
-static void kvm_set_invalid_pte(kvm_pte_t *ptep)
+static void kvm_clear_pte(kvm_pte_t *ptep)
 {
-	kvm_pte_t pte = *ptep;
-	WRITE_ONCE(*ptep, pte & ~KVM_PTE_VALID);
+	WRITE_ONCE(*ptep, 0);
 }
 
 static void kvm_set_table_pte(kvm_pte_t *ptep, kvm_pte_t *childp,
@@ -444,6 +443,7 @@ struct stage2_map_data {
 	kvm_pte_t			attr;
 
 	kvm_pte_t			*anchor;
+	kvm_pte_t			*childp;
 
 	struct kvm_s2_mmu		*mmu;
 	void				*memcache;
@@ -533,7 +533,7 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 		 * There's an existing different valid leaf entry, so perform
 		 * break-before-make.
 		 */
-		kvm_set_invalid_pte(ptep);
+		kvm_clear_pte(ptep);
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
 		mm_ops->put_page(ptep);
 	}
@@ -554,7 +554,8 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
 	if (!kvm_block_mapping_supported(addr, end, data->phys, level))
 		return 0;
 
-	kvm_set_invalid_pte(ptep);
+	data->childp = kvm_pte_follow(*ptep, data->mm_ops);
+	kvm_clear_pte(ptep);
 
 	/*
 	 * Invalidate the whole stage-2, as we may have numerous leaf
@@ -600,7 +601,7 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	 * will be mapped lazily.
 	 */
 	if (kvm_pte_valid(pte)) {
-		kvm_set_invalid_pte(ptep);
+		kvm_clear_pte(ptep);
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
 		mm_ops->put_page(ptep);
 	}
@@ -616,19 +617,24 @@ static int stage2_map_walk_table_post(u64 addr, u64 end, u32 level,
 				      struct stage2_map_data *data)
 {
 	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
+	kvm_pte_t *childp;
 	int ret = 0;
 
 	if (!data->anchor)
 		return 0;
 
-	mm_ops->put_page(kvm_pte_follow(*ptep, mm_ops));
-	mm_ops->put_page(ptep);
-
 	if (data->anchor == ptep) {
+		childp = data->childp;
 		data->anchor = NULL;
+		data->childp = NULL;
 		ret = stage2_map_walk_leaf(addr, end, level, ptep, data);
+	} else {
+		childp = kvm_pte_follow(*ptep, mm_ops);
 	}
 
+	mm_ops->put_page(childp);
+	mm_ops->put_page(ptep);
+
 	return ret;
 }
 
@@ -737,7 +743,7 @@ static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	 * block entry and rely on the remaining portions being faulted
 	 * back lazily.
 	 */
-	kvm_set_invalid_pte(ptep);
+	kvm_clear_pte(ptep);
 	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu, addr, level);
 	mm_ops->put_page(ptep);
 
-- 
2.31.0.rc2.261.g7f71774620-goog

