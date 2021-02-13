Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9FC31A90A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 01:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhBMAwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 19:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbhBMAwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 19:52:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94136C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 16:50:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i2so1539383ybl.16
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 16:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=+te5vGqQ5mfKNQSufhmqpYAsxPiqcN/tujlZYmMYYVw=;
        b=VjSddAkEPcauk0zGfQvzxdrdIOG7KG4YcmZKKPvj0nqqVta/CYkoAnlYAVP7NGhDkm
         VdZBTa51S4/hpyxd0ThLgJG8f/dEZ0AlJ1CVOPolFsNR0OyUFNvc91z9e1NRtqqgw5sr
         /gf/SrL62hwp+M62aEA9Et5BWfTJb6BO7DKeaqZ3mk4dohhHJsioMM4q2xFhiRsJyQWd
         K1p7uqg/r1oLyvNHeQFTE6hz8gNo7buXmcu9K0UC+9uM+DbZfGTVyUtveDcU0HYaFaB7
         7T1xNQuzSzf3R/90eBeZf4uTBH5HOsvIZT0fNO7TU9GLNZ0vLeA72aJs4zeY8urzInzv
         x9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=+te5vGqQ5mfKNQSufhmqpYAsxPiqcN/tujlZYmMYYVw=;
        b=HYNK22Pi+iGtrNkF56bZ5+WzA0PtroGerueatHq9+gyhfHtEDxSoK+rXd7Te1voM4J
         XM0VUbaZC+Pxll3NMOsgSwtb1ORoZYr8hl+OakKIDcR65kJRpW9tZzgXhsjuYQH2SMOY
         P1OCvtYULje4309FA4gW1TXuSzjKtwYxxB5NqrYOHtXpMd2/dRnXwxJKKVET3cs0qFGW
         g99oMIVBl1qJF3Ak34dzdMB+6uv5Oj6ERbCm4G2Xs9zex5HoVBIZ8NryYTywOPtCJQDK
         RvaVOo5sAavAVDw2cmWlmcUF7VzA+tIfox/l588Kv/9Mu02oM2BAsuF+qdDSfPywwAJ4
         28Eg==
X-Gm-Message-State: AOAM5337swFsfnRZBMG2CATGwqu6JbBTeT8CsLGK93MmWvVhs9u4+rQH
        LMKSVoXEzLeqb0xDkw5kOKEcCcM93BQ=
X-Google-Smtp-Source: ABdhPJxhavZBuKuUkKtaiyn3oAiDTSshrMq+lKxR+qNEpsbs/3dJju2omzfy+anN6gfXHZXppW95DqorLbE=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:b407:1780:13d2:b27])
 (user=seanjc job=sendgmr) by 2002:a25:cbc8:: with SMTP id b191mr7818312ybg.61.1613177432884;
 Fri, 12 Feb 2021 16:50:32 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 Feb 2021 16:50:06 -0800
In-Reply-To: <20210213005015.1651772-1-seanjc@google.com>
Message-Id: <20210213005015.1651772-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210213005015.1651772-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 05/14] KVM: x86/mmu: Consult max mapping level when zapping
 collapsible SPTEs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Makarand Sonare <makarandsonare@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When zapping SPTEs in order to rebuild them as huge pages, use the new
helper that computes the max mapping level to detect whether or not a
SPTE should be zapped.  Doing so avoids zapping SPTEs that can't
possibly be rebuilt as huge pages, e.g. due to hardware constraints,
memslot alignment, etc...

This also avoids zapping SPTEs that are still large, e.g. if migration
was canceled before write-protected huge pages were shattered to enable
dirty logging.  Note, such pages are still write-protected at this time,
i.e. a page fault VM-Exit will still occur.  This will hopefully be
addressed in a future patch.

Sadly, TDP MMU loses its const on the memslot, but that's a pervasive
problem that's been around for quite some time.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c     | 11 ++++++-----
 arch/x86/kvm/mmu/tdp_mmu.c | 13 +++++++------
 arch/x86/kvm/mmu/tdp_mmu.h |  2 +-
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index fb719e7a0cbb..d5849a0e3de1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5553,8 +5553,8 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 		 * mapping if the indirect sp has level = 1.
 		 */
 		if (sp->role.direct && !kvm_is_reserved_pfn(pfn) &&
-		    (kvm_is_zone_device_pfn(pfn) ||
-		     PageCompound(pfn_to_page(pfn)))) {
+		    sp->role.level < kvm_mmu_max_mapping_level(kvm, slot, sp->gfn,
+							       pfn, PG_LEVEL_NUM)) {
 			pte_list_remove(rmap_head, sptep);
 
 			if (kvm_available_flush_tlb_with_range())
@@ -5574,12 +5574,13 @@ void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
 				   const struct kvm_memory_slot *memslot)
 {
 	/* FIXME: const-ify all uses of struct kvm_memory_slot.  */
+	struct kvm_memory_slot *slot = (struct kvm_memory_slot *)memslot;
+
 	write_lock(&kvm->mmu_lock);
-	slot_handle_leaf(kvm, (struct kvm_memory_slot *)memslot,
-			 kvm_mmu_zap_collapsible_spte, true);
+	slot_handle_leaf(kvm, slot, kvm_mmu_zap_collapsible_spte, true);
 
 	if (is_tdp_mmu_enabled(kvm))
-		kvm_tdp_mmu_zap_collapsible_sptes(kvm, memslot);
+		kvm_tdp_mmu_zap_collapsible_sptes(kvm, slot);
 	write_unlock(&kvm->mmu_lock);
 }
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 3cc332ed099d..f8fa1f64e10d 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1328,8 +1328,10 @@ bool kvm_tdp_mmu_slot_set_dirty(struct kvm *kvm, struct kvm_memory_slot *slot)
  */
 static void zap_collapsible_spte_range(struct kvm *kvm,
 				       struct kvm_mmu_page *root,
-				       gfn_t start, gfn_t end)
+				       struct kvm_memory_slot *slot)
 {
+	gfn_t start = slot->base_gfn;
+	gfn_t end = start + slot->npages;
 	struct tdp_iter iter;
 	kvm_pfn_t pfn;
 	bool spte_set = false;
@@ -1348,8 +1350,8 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
 
 		pfn = spte_to_pfn(iter.old_spte);
 		if (kvm_is_reserved_pfn(pfn) ||
-		    (!PageTransCompoundMap(pfn_to_page(pfn)) &&
-		     !kvm_is_zone_device_pfn(pfn)))
+		    iter.level >= kvm_mmu_max_mapping_level(kvm, slot, iter.gfn,
+							    pfn, PG_LEVEL_NUM))
 			continue;
 
 		tdp_mmu_set_spte(kvm, &iter, 0);
@@ -1367,7 +1369,7 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
  * be replaced by large mappings, for GFNs within the slot.
  */
 void kvm_tdp_mmu_zap_collapsible_sptes(struct kvm *kvm,
-				       const struct kvm_memory_slot *slot)
+				       struct kvm_memory_slot *slot)
 {
 	struct kvm_mmu_page *root;
 	int root_as_id;
@@ -1377,8 +1379,7 @@ void kvm_tdp_mmu_zap_collapsible_sptes(struct kvm *kvm,
 		if (root_as_id != slot->as_id)
 			continue;
 
-		zap_collapsible_spte_range(kvm, root, slot->base_gfn,
-					   slot->base_gfn + slot->npages);
+		zap_collapsible_spte_range(kvm, root, slot);
 	}
 }
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index b4b65e3699b3..d31c5ed81a18 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -35,7 +35,7 @@ void kvm_tdp_mmu_clear_dirty_pt_masked(struct kvm *kvm,
 				       bool wrprot);
 bool kvm_tdp_mmu_slot_set_dirty(struct kvm *kvm, struct kvm_memory_slot *slot);
 void kvm_tdp_mmu_zap_collapsible_sptes(struct kvm *kvm,
-				       const struct kvm_memory_slot *slot);
+				       struct kvm_memory_slot *slot);
 
 bool kvm_tdp_mmu_write_protect_gfn(struct kvm *kvm,
 				   struct kvm_memory_slot *slot, gfn_t gfn);
-- 
2.30.0.478.g8a0d178c01-goog

