Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8A6452879
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 04:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbhKPDUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 22:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238968AbhKPDSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 22:18:09 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C22BC125D69
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:46:35 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id q2-20020a056a00084200b004a2582fcec1so7481156pfk.15
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bYB0Frpqgq4a9NUDlxvo/lp43pZWFoSQ8nRPnBtD0cE=;
        b=Y3uEfQ4qdN/MW6wyOA1SBXTNb7fxPkPA51UQ0JGqP8UKNnikesEn8bD2t1yaalrc8r
         5Rbc8Ih5HzvQsN34ap2ytRDWucDss1XeVYmG1C1MEFaqp5w6FxmN5SBDOhFjBE8FTHvG
         nJPcEH+Ukd6BUOwF3vPs4plTdvREalHUafnhHfSwVsjmMuaGEis++HMDkUYE5yQ7gst3
         x1XthBkH8lcDvCiFAu9c9QI+FLWDxAgq+EU+MV70hr+ODDtVeq8suQurcyPXaNHO7JPH
         dTIS44ctV3Fu5EUiwS/4qa0g45UgzDA6uoPBI2mxE6DUBTEnhyfxXhibamdUOTYs/1mr
         AUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bYB0Frpqgq4a9NUDlxvo/lp43pZWFoSQ8nRPnBtD0cE=;
        b=lqYpLQJpCUnaLXtsRqejGhUx5K//zqqXTD9BS7fO+p15acmpXr24FzY9cxIq4gU/ib
         Aqh6cTy4+qp2vVbMaWs2YXMOL57zl9vCe8mp41KN6Ab1zJVw4b7I91p7+gFBrYkiASPg
         Zk86jeCatVT6OTlGB2cwEDWrwOPWONabKblzRKAyXJUYh6+s3Qk2OlkT4fu0mj5Jyu/h
         xgYiCgX/HpqqL8Xvam41NptnMbQg6T58LWw7GgVr9fASpq7+Z/NOehGdhEprHps+aWzj
         iNuIrhC2htTchfKrsv11ZBE/ijl7a4vvWUgaVjVCRmewjuR9eWDZXcD/JkLg1XPGNs9y
         Njfw==
X-Gm-Message-State: AOAM533TWhSUiRRdh1OcONRWWOTvTayJZxbCXn240Zved9wugbjEP/YN
        pjELtZ/OwXmL408exnIviFbiNjh87DyXOraf8+EVdYktW1Eh+trIXGyC5wUWD74LDrDTF01TSQh
        eAeFiC2a8xF1WqQi6jkiMudklmu2H1EM9vQWIAICP+mEbWoy3Cv8QzO/59rfKFwBgQqc7HyWW
X-Google-Smtp-Source: ABdhPJy1jTOodcUWrB2s9eN8S9v5ypDiz6UXWEZRvh6J0jgZ4nSz4s2XF54h5kwMFoX8A5QHcgUANCgCLZ/b
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:916d:2253:5849:9965])
 (user=bgardon job=sendgmr) by 2002:a17:90a:909:: with SMTP id
 n9mr3107782pjn.1.1637019994545; Mon, 15 Nov 2021 15:46:34 -0800 (PST)
Date:   Mon, 15 Nov 2021 15:46:03 -0800
In-Reply-To: <20211115234603.2908381-1-bgardon@google.com>
Message-Id: <20211115234603.2908381-16-bgardon@google.com>
Mime-Version: 1.0
References: <20211115234603.2908381-1-bgardon@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH 15/15] KVM: x86/mmu: Promote pages in-place when disabling
 dirty logging
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When disabling dirty logging, the TDP MMU currently zaps each leaf entry
mapping memory in the relevant memslot. This is very slow. Doing the zaps
under the mmu read lock requires a TLB flush for every zap and the
zapping causes a storm of ETP/NPT violations.

Instead of zapping, replace the split large pages with large page
mappings directly. While this sort of operation has historically only
been done in the vCPU page fault handler context, refactorings earlier
in this series and the relative simplicity of the TDP MMU make it
possible here as well.

Running the dirty_log_perf_test on an Intel Skylake with 96 vCPUs and 1G
of memory per vCPU, this reduces the time required to disable dirty
logging from over 45 seconds to just over 1 second. It also avoids
provoking page faults, improving vCPU performance while disabling
dirty logging.


Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c          |  2 +-
 arch/x86/kvm/mmu/mmu_internal.h |  4 ++
 arch/x86/kvm/mmu/tdp_mmu.c      | 69 ++++++++++++++++++++++++++++++++-
 3 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ef7a84422463..add724aa9e8c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4449,7 +4449,7 @@ static inline bool boot_cpu_is_amd(void)
  * the direct page table on host, use as much mmu features as
  * possible, however, kvm currently does not do execution-protection.
  */
-static void
+void
 build_tdp_shadow_zero_bits_mask(struct rsvd_bits_validate *shadow_zero_check,
 				int shadow_root_level)
 {
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 6563cce9c438..84d439432acf 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -161,4 +161,8 @@ void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
 void account_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp);
 void unaccount_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp);
 
+void
+build_tdp_shadow_zero_bits_mask(struct rsvd_bits_validate *shadow_zero_check,
+				int shadow_root_level);
+
 #endif /* __KVM_X86_MMU_INTERNAL_H */
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 43c7834b4f0a..b15c8cd11cf9 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1361,6 +1361,66 @@ void kvm_tdp_mmu_clear_dirty_pt_masked(struct kvm *kvm,
 		clear_dirty_pt_masked(kvm, root, gfn, mask, wrprot);
 }
 
+static void try_promote_lpage(struct kvm *kvm,
+			      const struct kvm_memory_slot *slot,
+			      struct tdp_iter *iter)
+{
+	struct kvm_mmu_page *sp = sptep_to_sp(iter->sptep);
+	struct rsvd_bits_validate shadow_zero_check;
+	/*
+	 * Since the TDP  MMU doesn't manage nested PTs, there's no need to
+	 * write protect for a nested VM when PML is in use.
+	 */
+	bool ad_need_write_protect = false;
+	bool map_writable;
+	kvm_pfn_t pfn;
+	u64 new_spte;
+	u64 mt_mask;
+
+	/*
+	 * If addresses are being invalidated, don't do in-place promotion to
+	 * avoid accidentally mapping an invalidated address.
+	 */
+	if (unlikely(kvm->mmu_notifier_count))
+		return;
+
+	pfn = __gfn_to_pfn_memslot(slot, iter->gfn, true, NULL, true,
+				   &map_writable, NULL);
+
+	/*
+	 * Can't reconstitute an lpage if the consituent pages can't be
+	 * mapped higher.
+	 */
+	if (iter->level > kvm_mmu_max_mapping_level(kvm, slot, iter->gfn,
+						    pfn, PG_LEVEL_NUM))
+		return;
+
+	build_tdp_shadow_zero_bits_mask(&shadow_zero_check, iter->root_level);
+
+	/*
+	 * In some cases, a vCPU pointer is required to get the MT mask,
+	 * however in most cases it can be generated without one. If a
+	 * vCPU pointer is needed kvm_x86_try_get_mt_mask will fail.
+	 * In that case, bail on in-place promotion.
+	 */
+	if (unlikely(!static_call(kvm_x86_try_get_mt_mask)(kvm, iter->gfn,
+							   kvm_is_mmio_pfn(pfn),
+							   &mt_mask)))
+		return;
+
+	make_spte(kvm, sp, slot, ACC_ALL, iter->gfn, pfn, 0, false, true,
+		  map_writable, ad_need_write_protect, mt_mask,
+		  &shadow_zero_check, &new_spte);
+
+	tdp_mmu_set_spte_atomic(kvm, iter, new_spte);
+
+	/*
+	 * Re-read the SPTE to avoid recursing into one of the removed child
+	 * page tables.
+	 */
+	iter->old_spte = READ_ONCE(*rcu_dereference(iter->sptep));
+}
+
 /*
  * Clear leaf entries which could be replaced by large mappings, for
  * GFNs within the slot.
@@ -1381,9 +1441,14 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
 		if (tdp_mmu_iter_cond_resched(kvm, &iter, false, true))
 			continue;
 
-		if (!is_shadow_present_pte(iter.old_spte) ||
-		    !is_last_spte(iter.old_spte, iter.level))
+		if (!is_shadow_present_pte(iter.old_spte))
+			continue;
+
+		/* Try to promote the constitutent pages to an lpage. */
+		if (!is_last_spte(iter.old_spte, iter.level)) {
+			try_promote_lpage(kvm, slot, &iter);
 			continue;
+		}
 
 		pfn = spte_to_pfn(iter.old_spte);
 		if (kvm_is_reserved_pfn(pfn) ||
-- 
2.34.0.rc1.387.gb447b232ab-goog

