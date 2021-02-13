Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4F731A906
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 01:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhBMAw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 19:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhBMAwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 19:52:00 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC79C061794
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 16:50:31 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id w3so1318850qti.17
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 16:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=/pgObbPbQ4Sej93TFL9Cnuu26Kb3Ki6jPLia3nFiTXA=;
        b=AIjpzv6+8htZQRayxywmziLjdvR/NzxH2IuQBza8yuJn07/odsujV31NpiUWeXOUTR
         TWWVdISqcXa5wxiCREFw94UIWTxqqN2Mw+LFesqMB4trjM0A1MRQ/ytXfmUOlg7PCjUs
         rZ1pVuSQWUaXIVj6k15m0/KxMQIJiVTLV26bPf7q/+qsbvAQMT+j4xsSA95gRnUeKkUM
         tzoXrFFDFRYy/oqZ5OuDDW7BdWQ0BQj3DMZJ7DewX6yfnuzQcuU1Bwg1bGGJHx9SDNt/
         NAbTAqW1brL5l30WBhFjQgOWD1AdFU9C5MUiM4/WzDDQ5l+hWQ2iFAdp/p+l4U6avkh1
         jxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=/pgObbPbQ4Sej93TFL9Cnuu26Kb3Ki6jPLia3nFiTXA=;
        b=VsIzsf5+Rd1bVABjKp+/KuK2kEw0mMPwbLZPqrXbz3J+3Rk+BGFdCE0iWVT6M8N09e
         r8e62LgNgsofT0NDa0dVO2Ncf9XkEBGopiKS4z20vZ4NUMeNwYtPU7HQNsFm65rtr+3/
         OS89ekxXHtQ0oCnD0KgLrJwdWzBNy03eEmIX8PeINm1qCo85b3YhGCEXWqJ/bxK0nj+l
         J+CQxS1+tz1YRa4+uM2lmuFBg5VUnwMw8MypLS8fEa97Y6zjYvtpSysFyNzzUqZAyhU3
         DB7bM02IfTaaA6HfwOD/UlYUl68AOuER1+HKsre2XGTmY4rdvBZMqrPiznGGw4s7rvEN
         /wuQ==
X-Gm-Message-State: AOAM531nmeAdix+Ajzr+bbWYOd9xNQPSu4auY5i7nb6h3tufmAQEhAYV
        W3C9lPH7p5/9sPPVZTIrsWM9t8keljU=
X-Google-Smtp-Source: ABdhPJzLCM67nkU5MoKMf58mtdWJl/IRwyhumZ+dwwpFdhfFlqR/KeLI9I3s95s5+hJtmi7nEYAAtpjwqTA=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:b407:1780:13d2:b27])
 (user=seanjc job=sendgmr) by 2002:ad4:55aa:: with SMTP id f10mr5145395qvx.46.1613177430549;
 Fri, 12 Feb 2021 16:50:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 Feb 2021 16:50:05 -0800
In-Reply-To: <20210213005015.1651772-1-seanjc@google.com>
Message-Id: <20210213005015.1651772-5-seanjc@google.com>
Mime-Version: 1.0
References: <20210213005015.1651772-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 04/14] KVM: x86/mmu: Pass the memslot to the rmap callbacks
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

Pass the memslot to the rmap callbacks, it will be used when zapping
collapsible SPTEs to verify the memslot is compatible with hugepages
before zapping its SPTEs.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 9be7fd474b2d..fb719e7a0cbb 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1165,7 +1165,8 @@ static bool spte_wrprot_for_clear_dirty(u64 *sptep)
  *	- W bit on ad-disabled SPTEs.
  * Returns true iff any D or W bits were cleared.
  */
-static bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+static bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			       struct kvm_memory_slot *slot)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1196,7 +1197,8 @@ static bool spte_set_dirty(u64 *sptep)
 	return mmu_spte_update(sptep, spte);
 }
 
-static bool __rmap_set_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+static bool __rmap_set_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			     struct kvm_memory_slot *slot)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1260,7 +1262,7 @@ void kvm_mmu_clear_dirty_pt_masked(struct kvm *kvm,
 	while (mask) {
 		rmap_head = __gfn_to_rmap(slot->base_gfn + gfn_offset + __ffs(mask),
 					  PG_LEVEL_4K, slot);
-		__rmap_clear_dirty(kvm, rmap_head);
+		__rmap_clear_dirty(kvm, rmap_head, slot);
 
 		/* clear the first set bit */
 		mask &= mask - 1;
@@ -1325,7 +1327,8 @@ static bool rmap_write_protect(struct kvm_vcpu *vcpu, u64 gfn)
 	return kvm_mmu_slot_gfn_write_protect(vcpu->kvm, slot, gfn);
 }
 
-static bool kvm_zap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+static bool kvm_zap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			  struct kvm_memory_slot *slot)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1345,7 +1348,7 @@ static int kvm_unmap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 			   struct kvm_memory_slot *slot, gfn_t gfn, int level,
 			   unsigned long data)
 {
-	return kvm_zap_rmapp(kvm, rmap_head);
+	return kvm_zap_rmapp(kvm, rmap_head, slot);
 }
 
 static int kvm_set_pte_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
@@ -5189,7 +5192,8 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_max_root_level,
 EXPORT_SYMBOL_GPL(kvm_configure_mmu);
 
 /* The return value indicates if tlb flush on all vcpus is needed. */
-typedef bool (*slot_level_handler) (struct kvm *kvm, struct kvm_rmap_head *rmap_head);
+typedef bool (*slot_level_handler) (struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+				    struct kvm_memory_slot *slot);
 
 /* The caller should hold mmu-lock before calling this function. */
 static __always_inline bool
@@ -5203,7 +5207,7 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	for_each_slot_rmap_range(memslot, start_level, end_level, start_gfn,
 			end_gfn, &iterator) {
 		if (iterator.rmap)
-			flush |= fn(kvm, iterator.rmap);
+			flush |= fn(kvm, iterator.rmap, memslot);
 
 		if (need_resched() || rwlock_needbreak(&kvm->mmu_lock)) {
 			if (flush && lock_flush_tlb) {
@@ -5492,7 +5496,8 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 }
 
 static bool slot_rmap_write_protect(struct kvm *kvm,
-				    struct kvm_rmap_head *rmap_head)
+				    struct kvm_rmap_head *rmap_head,
+				    struct kvm_memory_slot *slot)
 {
 	return __rmap_write_protect(kvm, rmap_head, false);
 }
@@ -5526,7 +5531,8 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
 }
 
 static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
-					 struct kvm_rmap_head *rmap_head)
+					 struct kvm_rmap_head *rmap_head,
+					 struct kvm_memory_slot *slot)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
-- 
2.30.0.478.g8a0d178c01-goog

