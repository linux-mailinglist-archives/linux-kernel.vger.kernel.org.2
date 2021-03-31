Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFFE3508E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhCaVJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbhCaVJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:09:04 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FFDC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:09:04 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id u15so2067975qvo.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=shAgYfqF+cypy0/KRQK7wirhgcU0wHOuMRYUsNPex7o=;
        b=rQ0sJ7kmvyis0+Nu0wXg39UJkTyoKd5AR460peD4kAaJQY7hv028MU+6T3yUeV7aGY
         KsRRnH4PJIN6B5U2WoY/utuUlgrCKLdnBY/0FLbP34F2KCXkwWEj3Wsdh+BNM/mMvZXF
         mLLiV4x/eZ1tdOxm3ODWvVGalustQiSQfcgDLGrt67EVJ9Zm1xzN/oyNlrWxw2jfTHTo
         O42JEKWWBMt6c6guXYYqM9G4eFUP4Qbx0lwB87CRa8ggm/QvwDgbb2fQERyrE4x1jgkL
         oGO++kcbGEYdFbrjkgFIKt10dEKK5q+ZSrMX7qDX3gp+7nV6/syHZSQYlSpaOt2jWu8N
         1eBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=shAgYfqF+cypy0/KRQK7wirhgcU0wHOuMRYUsNPex7o=;
        b=uIxEe7ndxwffSNRG9HyT3cVU+YE22wUOrhc2sskNAnjPaU8O/a5/pSbJ4pucJMoV32
         SigZruEuMRAf9tqi6Og66xZXt/87HvpnXptJYUBAca+n6Yg7gACfWU33VXjkgv9/bzRl
         iZLrQ/ORqCqPHgxkBES7bUcnBq86qxZhtE0cy71pokaQ7OLT5OLi5e8AWPuLVoPKQQjN
         GuTdBGYk7h03Z0d3REYzSTbaSNJ4H6OgWCO6PTzYJTwVYTh3wgxGAvGliPh6r3LlvHL+
         YPSZXG73BD+WE39LDnl84M0B92yFRS6QzFELnbz7A/NSZTvZgoWmto9DzDBDp7R7Amno
         I5Iw==
X-Gm-Message-State: AOAM532mKZmvTP9F9KVchtx6tgzmOcImjVehDCjRJ7vhFfCrFs31zVYj
        GUqOW4ot/w4k3UwHGyogND8T0NNQq4fNlKpNJLv0kco6O/ikw/PHQBJGP6620W/5Wz5jz14PSBH
        PvUHbdtKXhCdOPdrCqK0jyaTufQn3pahIwfynqnfXec3/S5rosQSDXjNz3IU68XCPVTuAnWm4
X-Google-Smtp-Source: ABdhPJzHLA2UAcsevKJygjkqztrpxd2hRINkIpoVNWxeuBp/FZPAb45lJOMhylWdILYORIDxrpW7yvxIyNEH
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:8026:6888:3d55:3842])
 (user=bgardon job=sendgmr) by 2002:ad4:5a14:: with SMTP id
 ei20mr4994453qvb.1.1617224942887; Wed, 31 Mar 2021 14:09:02 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:08:29 -0700
In-Reply-To: <20210331210841.3996155-1-bgardon@google.com>
Message-Id: <20210331210841.3996155-2-bgardon@google.com>
Mime-Version: 1.0
References: <20210331210841.3996155-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 01/13] KVM: x86/mmu: Re-add const qualifier in kvm_tdp_mmu_zap_collapsible_sptes
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_tdp_mmu_zap_collapsible_sptes unnecessarily removes the const
qualifier from its memlsot argument, leading to a compiler warning. Add
the const annotation and pass it to subsequent functions.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 10 +++++-----
 arch/x86/kvm/mmu/mmu_internal.h |  5 +++--
 arch/x86/kvm/mmu/tdp_mmu.c      |  4 ++--
 arch/x86/kvm/mmu/tdp_mmu.h      |  2 +-
 include/linux/kvm_host.h        |  2 +-
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c6ed633594a2..f75cbb0fcc9c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -715,8 +715,7 @@ static void kvm_mmu_page_set_gfn(struct kvm_mmu_page *sp, int index, gfn_t gfn)
  * handling slots that are not large page aligned.
  */
 static struct kvm_lpage_info *lpage_info_slot(gfn_t gfn,
-					      struct kvm_memory_slot *slot,
-					      int level)
+		const struct kvm_memory_slot *slot, int level)
 {
 	unsigned long idx;
 
@@ -2736,7 +2735,7 @@ static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
 }
 
 static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
-				  struct kvm_memory_slot *slot)
+				  const struct kvm_memory_slot *slot)
 {
 	unsigned long hva;
 	pte_t *pte;
@@ -2762,8 +2761,9 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 	return level;
 }
 
-int kvm_mmu_max_mapping_level(struct kvm *kvm, struct kvm_memory_slot *slot,
-			      gfn_t gfn, kvm_pfn_t pfn, int max_level)
+int kvm_mmu_max_mapping_level(struct kvm *kvm,
+			      const struct kvm_memory_slot *slot, gfn_t gfn,
+			      kvm_pfn_t pfn, int max_level)
 {
 	struct kvm_lpage_info *linfo;
 
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index e03267e93459..fc88f62d7bd9 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -156,8 +156,9 @@ enum {
 #define SET_SPTE_NEED_REMOTE_TLB_FLUSH	BIT(1)
 #define SET_SPTE_SPURIOUS		BIT(2)
 
-int kvm_mmu_max_mapping_level(struct kvm *kvm, struct kvm_memory_slot *slot,
-			      gfn_t gfn, kvm_pfn_t pfn, int max_level);
+int kvm_mmu_max_mapping_level(struct kvm *kvm,
+			      const struct kvm_memory_slot *slot, gfn_t gfn,
+			      kvm_pfn_t pfn, int max_level);
 int kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, gfn_t gfn,
 			    int max_level, kvm_pfn_t *pfnp,
 			    bool huge_page_disallowed, int *req_level);
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index f2c335854afb..6d4f4e305163 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1268,7 +1268,7 @@ void kvm_tdp_mmu_clear_dirty_pt_masked(struct kvm *kvm,
  */
 static void zap_collapsible_spte_range(struct kvm *kvm,
 				       struct kvm_mmu_page *root,
-				       struct kvm_memory_slot *slot)
+				       const struct kvm_memory_slot *slot)
 {
 	gfn_t start = slot->base_gfn;
 	gfn_t end = start + slot->npages;
@@ -1309,7 +1309,7 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
  * be replaced by large mappings, for GFNs within the slot.
  */
 void kvm_tdp_mmu_zap_collapsible_sptes(struct kvm *kvm,
-				       struct kvm_memory_slot *slot)
+				       const struct kvm_memory_slot *slot)
 {
 	struct kvm_mmu_page *root;
 	int root_as_id;
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index 3b761c111bff..683d1d69c8c8 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -34,7 +34,7 @@ void kvm_tdp_mmu_clear_dirty_pt_masked(struct kvm *kvm,
 				       gfn_t gfn, unsigned long mask,
 				       bool wrprot);
 void kvm_tdp_mmu_zap_collapsible_sptes(struct kvm *kvm,
-				       struct kvm_memory_slot *slot);
+				       const struct kvm_memory_slot *slot);
 
 bool kvm_tdp_mmu_write_protect_gfn(struct kvm *kvm,
 				   struct kvm_memory_slot *slot, gfn_t gfn);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1b65e7204344..74e56e8673a6 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1116,7 +1116,7 @@ __gfn_to_memslot(struct kvm_memslots *slots, gfn_t gfn)
 }
 
 static inline unsigned long
-__gfn_to_hva_memslot(struct kvm_memory_slot *slot, gfn_t gfn)
+__gfn_to_hva_memslot(const struct kvm_memory_slot *slot, gfn_t gfn)
 {
 	return slot->userspace_addr + (gfn - slot->base_gfn) * PAGE_SIZE;
 }
-- 
2.31.0.291.g576ba9dcdaf-goog

