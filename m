Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C77334625
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhCJR72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhCJR6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:55 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF97C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:55 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id m35so3827124qtd.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KHg8GNHRWwdgHORBJFIM4n3Psw8hXYgV1Q7feze9Wwg=;
        b=r7hm1X+/A4HHjywquwAv8UbYAC4tXhZrRcjw5KRNMuRuugEIl9mZiVAY/05E4lCJ/r
         mJTLgUN7/+Hr2pV5bAsaKsvRidg2SEkD9/zXw+s5Ztk6sxyrU8HvKe+vTQLw3LG01fOE
         JHPpmFLbjbPAN+XwZHagqy2Ooi5//8Rg247YAx2wK+3j2Sft1b5cmSGrw/mSyOcP855p
         7UnlC90DSABtGbdUnuIuLTbD1MK9ZKjMlWgNcVtYWTqnnHZ+iLJIOXE53XyztiG7sCQz
         XkxrZ2zyGBLxkidgk/YANYRo9KEhtYj9pTuZiRLmeb68EDE+Dg9j77mf3Oj8CYFTC8Cy
         3qWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KHg8GNHRWwdgHORBJFIM4n3Psw8hXYgV1Q7feze9Wwg=;
        b=eCoY+opAXDQXE3dA7WJUYxWstxVdydaoVfU9a8v6JAAyNdfBhDYcvFlOTt0ZmbRBPY
         WhRdnQFNU6va5RZwwSJMqabsCzRlYZK9jpnqbyMuqOxycTp7UBXeU5x5FxjknGG/YdIF
         9cdMMv4umKj0GFtWLuZLBB84I6HIb85xKaW4VN1q2jCzAgybdchM3JSylxzPqhRkYS/l
         3tqn80onFIEoZ7JlZj2A1UATvk12pfgLR5WOQpIEXRUDSpfcZNLg6Ss9PBo5UcwAkTvu
         6BWv5+xP2cNHjOAL3Q04zGVcd/ThPzUKndv9SxWEQXWKzf90RrDGN0CbsWlult2xOJTU
         5/5A==
X-Gm-Message-State: AOAM5327mv8zrS31fLlvSHKUx3otH+cVDIzTFFSW4pNsMSWu3g+d39oq
        I52ug1qKuh8R+2oSa3K7fL9qOAsB8aNM
X-Google-Smtp-Source: ABdhPJxctmL0qh9AUqySqIh+J7wmsFSyJZCllX/E1sFQxbY+Rs5BdkUUA7jDJCdbb2ggAgOkd5NnOmpGsuXf
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:1305:: with SMTP id
 a5mr4160961qvv.42.1615399134545; Wed, 10 Mar 2021 09:58:54 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:44 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-28-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 27/34] KVM: arm64: Always zero invalid PTEs
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org,
        ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_set_invalid_pte() currently only clears bit 0 from a PTE because
stage2_map_walk_table_post() needs to be able to follow the anchor. In
preparation for re-using bits 63-02 from invalid PTEs, make sure to zero
it entirely by ensuring to cache the anchor's child upfront.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index bdd6e3d4eeb6..f37b4179b880 100644
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
@@ -443,6 +442,7 @@ struct stage2_map_data {
 	kvm_pte_t			attr;
 
 	kvm_pte_t			*anchor;
+	kvm_pte_t			*childp;
 
 	struct kvm_s2_mmu		*mmu;
 	void				*memcache;
@@ -532,7 +532,7 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 		 * There's an existing different valid leaf entry, so perform
 		 * break-before-make.
 		 */
-		kvm_set_invalid_pte(ptep);
+		kvm_clear_pte(ptep);
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
 		mm_ops->put_page(ptep);
 	}
@@ -553,7 +553,8 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
 	if (!kvm_block_mapping_supported(addr, end, data->phys, level))
 		return 0;
 
-	kvm_set_invalid_pte(ptep);
+	data->childp = kvm_pte_follow(*ptep, data->mm_ops);
+	kvm_clear_pte(ptep);
 
 	/*
 	 * Invalidate the whole stage-2, as we may have numerous leaf
@@ -599,7 +600,7 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	 * will be mapped lazily.
 	 */
 	if (kvm_pte_valid(pte)) {
-		kvm_set_invalid_pte(ptep);
+		kvm_clear_pte(ptep);
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
 		mm_ops->put_page(ptep);
 	}
@@ -615,19 +616,24 @@ static int stage2_map_walk_table_post(u64 addr, u64 end, u32 level,
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
 
@@ -736,7 +742,7 @@ static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	 * block entry and rely on the remaining portions being faulted
 	 * back lazily.
 	 */
-	kvm_set_invalid_pte(ptep);
+	kvm_clear_pte(ptep);
 	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu, addr, level);
 	mm_ops->put_page(ptep);
 
-- 
2.30.1.766.gb4fecdf3b7-goog

