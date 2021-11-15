Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E2E452875
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 04:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbhKPDUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 22:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238973AbhKPDSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 22:18:04 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F45C125D5F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:46:26 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 70-20020a630149000000b002da385ceffaso9885008pgb.17
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+OKOVpu+rqKFCqXdsvqkypiAF8JDNqlIsCpMpjb8VLA=;
        b=WxJ0KprsO1Mp/EhTFoXcCLjjKauA8lxq37bsHlwfjPMreMOtBfVZJ9OndfvBRtccbD
         2CIcrXt8tppOWKQbEiNksJDQacp2mwxBRQtNrriyDsiL3IQDaJQ2yadv7ijKQWiFMLoz
         whGc+1COWgy/2nG/6R2dw2hsfWtdrLQ6EtseVeIKkB2e5ynMJPASYnIToIVWkylQB8/g
         aL1hNH2eNDFOR/pnvQqPm/j7mN3USgEp/wA2Hj4LGr3qh+4Cw+az0QLgM6wvDeUQIQJZ
         c9Ov6oY7TLd7InF6MDRR8GIr16P3STwdRWxtfdx53bHZbSZ9UtllyqtE/d78BYs9DC6j
         gSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+OKOVpu+rqKFCqXdsvqkypiAF8JDNqlIsCpMpjb8VLA=;
        b=a6idY9Ed7MS8AXM6c6j0fmAQpLukwl/Ic65khXjfoWhakycMN/fUTIajErWuJxc9UD
         SfgrJ+YdlW6lhZTkqjMyPYhaSUR+5wv/S6PRIJlw0ef840PvmCHw8unasKPQ/GYVz7rj
         5/7nNEPemNaNX+qpbqzVhezjZO5FU22OVMTSS6PH4MNA9IyGeJ+5x64xnBpiHbS65Oud
         rlOKDOMXm8mW6kM3d0bBLYO0/Wt5zz6bE+7Sb51AyKCFECgyuL4yOfd96us/0BGeWg/5
         vTMcp6D6kLioLaDlT8Lo+/EeMg6NO93Ppo+7ZmuXAHBTDJmttdv0q32RKyAMnFt9ZQkI
         xe6Q==
X-Gm-Message-State: AOAM531+XeZal9pF/F7bSqYo/zsRZ4EykLrOEeXXjoD9aV6T0cxhzZ12
        RdlrkLOPOxgldktSHLqlrcX+y0Lf+TkWvIZtaHQnYmRcj6+yO19WxQV/OdoFK9Myffgf1lNh9Sd
        AzGVTMtTYM/QL8EdSMerDabcwZGirEgwvxWxhqSwYGw6u7isretC4BVdoiMmp6MeNtxyExhvY
X-Google-Smtp-Source: ABdhPJxOhmPP2Kns1hVgSK4SgG30TWor9gDWzgUZRJolzYH+LUA73qqn+Xsj8rF2l7Wc2HeZdTRZ7ZddbCLV
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:916d:2253:5849:9965])
 (user=bgardon job=sendgmr) by 2002:a17:90a:3b02:: with SMTP id
 d2mr3018851pjc.159.1637019985502; Mon, 15 Nov 2021 15:46:25 -0800 (PST)
Date:   Mon, 15 Nov 2021 15:45:58 -0800
In-Reply-To: <20211115234603.2908381-1-bgardon@google.com>
Message-Id: <20211115234603.2908381-11-bgardon@google.com>
Mime-Version: 1.0
References: <20211115234603.2908381-1-bgardon@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH 10/15] KVM: x86/mmu: Propagate memslot const qualifier
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

In preparation for implementing in-place hugepage promotion, various
functions will need to be called from zap_collapsible_spte_range, which
has the const qualifier on its memslot argument. Propagate the const
qualifier to the various functions which will be needed. This just serves
to simplify the following patch.

No functional change intended.


Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/include/asm/kvm_page_track.h |  4 ++--
 arch/x86/kvm/mmu/mmu.c                |  2 +-
 arch/x86/kvm/mmu/mmu_internal.h       |  2 +-
 arch/x86/kvm/mmu/page_track.c         |  4 ++--
 arch/x86/kvm/mmu/spte.c               |  2 +-
 arch/x86/kvm/mmu/spte.h               |  2 +-
 include/linux/kvm_host.h              | 10 +++++-----
 virt/kvm/kvm_main.c                   | 12 ++++++------
 8 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/kvm_page_track.h b/arch/x86/include/asm/kvm_page_track.h
index e99a30a4d38b..eb186bc57f6a 100644
--- a/arch/x86/include/asm/kvm_page_track.h
+++ b/arch/x86/include/asm/kvm_page_track.h
@@ -64,8 +64,8 @@ void kvm_slot_page_track_remove_page(struct kvm *kvm,
 				     struct kvm_memory_slot *slot, gfn_t gfn,
 				     enum kvm_page_track_mode mode);
 bool kvm_slot_page_track_is_active(struct kvm *kvm,
-				   struct kvm_memory_slot *slot, gfn_t gfn,
-				   enum kvm_page_track_mode mode);
+				   const struct kvm_memory_slot *slot,
+				   gfn_t gfn, enum kvm_page_track_mode mode);
 
 void
 kvm_page_track_register_notifier(struct kvm *kvm,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index fdf0f15ab19d..ef7a84422463 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2576,7 +2576,7 @@ static void kvm_unsync_page(struct kvm *kvm, struct kvm_mmu_page *sp)
  * were marked unsync (or if there is no shadow page), -EPERM if the SPTE must
  * be write-protected.
  */
-int mmu_try_to_unsync_pages(struct kvm *kvm, struct kvm_memory_slot *slot,
+int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
 			    gfn_t gfn, bool can_unsync, bool prefetch)
 {
 	struct kvm_mmu_page *sp;
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 1073d10cce91..6563cce9c438 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -118,7 +118,7 @@ static inline bool kvm_vcpu_ad_need_write_protect(struct kvm_vcpu *vcpu)
 	       kvm_x86_ops.cpu_dirty_log_size;
 }
 
-int mmu_try_to_unsync_pages(struct kvm *kvm, struct kvm_memory_slot *slot,
+int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
 			    gfn_t gfn, bool can_unsync, bool prefetch);
 
 void kvm_mmu_gfn_disallow_lpage(const struct kvm_memory_slot *slot, gfn_t gfn);
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 35c221d5f6ce..68eb1fb548b6 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -174,8 +174,8 @@ EXPORT_SYMBOL_GPL(kvm_slot_page_track_remove_page);
  * check if the corresponding access on the specified guest page is tracked.
  */
 bool kvm_slot_page_track_is_active(struct kvm *kvm,
-				   struct kvm_memory_slot *slot, gfn_t gfn,
-				   enum kvm_page_track_mode mode)
+				   const struct kvm_memory_slot *slot,
+				   gfn_t gfn, enum kvm_page_track_mode mode)
 {
 	int index;
 
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index d98723b14cec..7be41d2dbb02 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -90,7 +90,7 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
 }
 
 bool make_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
-	       struct kvm_memory_slot *slot, unsigned int pte_access,
+	       const struct kvm_memory_slot *slot, unsigned int pte_access,
 	       gfn_t gfn, kvm_pfn_t pfn, u64 old_spte, bool prefetch,
 	       bool can_unsync, bool host_writable, bool ad_need_write_protect,
 	       u64 mt_mask, struct rsvd_bits_validate *shadow_zero_check,
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 5bb055688080..d7598506fbad 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -330,7 +330,7 @@ static inline u64 get_mmio_spte_generation(u64 spte)
 }
 
 bool make_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
-	       struct kvm_memory_slot *slot, unsigned int pte_access,
+	       const struct kvm_memory_slot *slot, unsigned int pte_access,
 	       gfn_t gfn, kvm_pfn_t pfn, u64 old_spte, bool prefetch,
 	       bool can_unsync, bool host_writable, bool ad_need_write_protect,
 	       u64 mt_mask, struct rsvd_bits_validate *shadow_zero_check,
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 60a35d9fe259..675da38fac7f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -435,7 +435,7 @@ struct kvm_memory_slot {
 	u16 as_id;
 };
 
-static inline bool kvm_slot_dirty_track_enabled(struct kvm_memory_slot *slot)
+static inline bool kvm_slot_dirty_track_enabled(const struct kvm_memory_slot *slot)
 {
 	return slot->flags & KVM_MEM_LOG_DIRTY_PAGES;
 }
@@ -855,9 +855,9 @@ void kvm_set_page_accessed(struct page *page);
 kvm_pfn_t gfn_to_pfn(struct kvm *kvm, gfn_t gfn);
 kvm_pfn_t gfn_to_pfn_prot(struct kvm *kvm, gfn_t gfn, bool write_fault,
 		      bool *writable);
-kvm_pfn_t gfn_to_pfn_memslot(struct kvm_memory_slot *slot, gfn_t gfn);
-kvm_pfn_t gfn_to_pfn_memslot_atomic(struct kvm_memory_slot *slot, gfn_t gfn);
-kvm_pfn_t __gfn_to_pfn_memslot(struct kvm_memory_slot *slot, gfn_t gfn,
+kvm_pfn_t gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn);
+kvm_pfn_t gfn_to_pfn_memslot_atomic(const struct kvm_memory_slot *slot, gfn_t gfn);
+kvm_pfn_t __gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn,
 			       bool atomic, bool *async, bool write_fault,
 			       bool *writable, hva_t *hva);
 
@@ -934,7 +934,7 @@ struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn);
 bool kvm_is_visible_gfn(struct kvm *kvm, gfn_t gfn);
 bool kvm_vcpu_is_visible_gfn(struct kvm_vcpu *vcpu, gfn_t gfn);
 unsigned long kvm_host_page_size(struct kvm_vcpu *vcpu, gfn_t gfn);
-void mark_page_dirty_in_slot(struct kvm *kvm, struct kvm_memory_slot *memslot, gfn_t gfn);
+void mark_page_dirty_in_slot(struct kvm *kvm, const struct kvm_memory_slot *memslot, gfn_t gfn);
 void mark_page_dirty(struct kvm *kvm, gfn_t gfn);
 
 struct kvm_memslots *kvm_vcpu_memslots(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3f6d450355f0..6dbf8cba1900 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2138,12 +2138,12 @@ unsigned long kvm_host_page_size(struct kvm_vcpu *vcpu, gfn_t gfn)
 	return size;
 }
 
-static bool memslot_is_readonly(struct kvm_memory_slot *slot)
+static bool memslot_is_readonly(const struct kvm_memory_slot *slot)
 {
 	return slot->flags & KVM_MEM_READONLY;
 }
 
-static unsigned long __gfn_to_hva_many(struct kvm_memory_slot *slot, gfn_t gfn,
+static unsigned long __gfn_to_hva_many(const struct kvm_memory_slot *slot, gfn_t gfn,
 				       gfn_t *nr_pages, bool write)
 {
 	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
@@ -2438,7 +2438,7 @@ static kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool *async,
 	return pfn;
 }
 
-kvm_pfn_t __gfn_to_pfn_memslot(struct kvm_memory_slot *slot, gfn_t gfn,
+kvm_pfn_t __gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn,
 			       bool atomic, bool *async, bool write_fault,
 			       bool *writable, hva_t *hva)
 {
@@ -2478,13 +2478,13 @@ kvm_pfn_t gfn_to_pfn_prot(struct kvm *kvm, gfn_t gfn, bool write_fault,
 }
 EXPORT_SYMBOL_GPL(gfn_to_pfn_prot);
 
-kvm_pfn_t gfn_to_pfn_memslot(struct kvm_memory_slot *slot, gfn_t gfn)
+kvm_pfn_t gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn)
 {
 	return __gfn_to_pfn_memslot(slot, gfn, false, NULL, true, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(gfn_to_pfn_memslot);
 
-kvm_pfn_t gfn_to_pfn_memslot_atomic(struct kvm_memory_slot *slot, gfn_t gfn)
+kvm_pfn_t gfn_to_pfn_memslot_atomic(const struct kvm_memory_slot *slot, gfn_t gfn)
 {
 	return __gfn_to_pfn_memslot(slot, gfn, true, NULL, true, NULL, NULL);
 }
@@ -3079,7 +3079,7 @@ int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsigned long len)
 EXPORT_SYMBOL_GPL(kvm_clear_guest);
 
 void mark_page_dirty_in_slot(struct kvm *kvm,
-			     struct kvm_memory_slot *memslot,
+			     const struct kvm_memory_slot *memslot,
 		 	     gfn_t gfn)
 {
 	if (memslot && kvm_slot_dirty_track_enabled(memslot)) {
-- 
2.34.0.rc1.387.gb447b232ab-goog

