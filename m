Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6809633BEFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbhCOOwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237232AbhCOOgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:49 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC0FC0613E9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:39 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id a65so2913248wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J1uZIE4CatR8RJ2mwUZGBIvYuAMTy17ux6AGbOX5tFk=;
        b=quH1WWPr+L1SVwBqv31K38Go2mHpdC6nZ0w0GUgWu8lifd6IDz7tnxeCHBvwfxXcid
         s/cfv6PNBlw7Tv1DYVDfMOsXnBOEXJFlXhMZyBMoZVhKnghB6bZBQ7RXezVsiD4bljVh
         lJBqoO4Or/KxawhVR2OPnIGrxhVyjXNvg07Fc+ZEFDUsWiUlW9oHKY+QEXLr9k42aYSH
         d2Cae4A8DBkXpZvxeLTGbGBr2odV4gqnrZpx31EngUzons5PvcQ6ycsc99xvdaHgxaKm
         V/XOC0HOZ3lOrer8gP70svjqgVCAXPSm6Ym7SYFjCDsB/ZmUMa2sDLVxAtskeXAdYfBu
         oHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J1uZIE4CatR8RJ2mwUZGBIvYuAMTy17ux6AGbOX5tFk=;
        b=XTZlJgDDC4H5jpxUgTvJsASWUZVTadAQB6WhFh21VwUQJVTaFztxKBlYZWBLssWtHp
         rp1M3YWnQnl/PsilKNoJ37oUhY6wDP3Z/oZxk9FRXqGZvaqKTHv6n9PHe/2VjWuky5Sk
         nyndgzGOWQZRLUJYtNoJxqLdxfB4w1+pBMlzonxm3N7s8zJc9+8ZxiiqG6eX1sUDV8x9
         RqwKkxh61Qjjk9yyMFCDABwGI987Q0QfkFQ11EU4UPq79UDRnozgRcQUnF4dWgtmCjar
         B9WV9w+/pUk+NJ/K9WJ8iHHgkLgjm3rt4rhw2ZqspsCwmvy4D3y+fcFpRSv4VyCS7Csw
         eHAw==
X-Gm-Message-State: AOAM533Ir5QrQb/6Te1qG7o6ZPE0GrjOLbESaBT6pVSLU//mbXtxFCsx
        MObsxirqbPqtud7jWZ4SSJOIRT8h9tiM
X-Google-Smtp-Source: ABdhPJxe4+QHHGpZyqH28YWZv8YfJrDVsBARhsCBGZiD6vsppmOxHGv9C0FMe9dp3bfpi8X+Fs4PaGFGP24s
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:2053:: with SMTP id
 p19mr26380067wmg.87.1615818997861; Mon, 15 Mar 2021 07:36:37 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:28 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-29-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 28/36] KVM: arm64: Always zero invalid PTEs
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
2.31.0.rc2.261.g7f71774620-goog

