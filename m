Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58543508F7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhCaVKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhCaVJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:09:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C6FC0613D7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:09:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w7so3646021ybq.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b52JDbJCQ0WWnStpBK4r+Ue/B9wKBNJL13KbqXYmGYg=;
        b=VBh/zpM0UblBio97G9OLhp5ZW9nq+0UT6vMkJslIRHEWu0AczvOramp6CqciEKTbNr
         c715S9mhEe5cbxZU9ZKbk1c1CG5XtzwwOhk6j1LwoDVLVCyuMpu+TIsXYpJteyUEGVHZ
         r//H3my+d7NQTcNRv5sL8ewSOPRhIiz1Px5cmQ1rpZatblglnNTdxIuuC8j5oiWrsU7z
         kOVnAcDmNTrthQF2PGanzEe2RmfNCgzGlvG/1CO304wIIbZVHFpASCsdKZA4q1e3tATH
         0TVS8ieoNq7rVJ1WEHQzrcU13869pfdhF6H29zvvOHkoH6Q/lLNec28NDz88L14aTLKD
         wxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b52JDbJCQ0WWnStpBK4r+Ue/B9wKBNJL13KbqXYmGYg=;
        b=AtDHpGsn6c5eMpWj132X5T90PhrQ2/enLjEG0yb8f/VGFRT6NeusOJBffKs+6Tm+mG
         byY0l00Ja6s1RzSiPIivVw1MrrA3c+ebdclLweeex7tpO0O3lSKadw743Q4B6EDxOZue
         zRzm2gahlwYoGvItN8h9cMepat0FLNR3HOcAsu3KqrIFx4/wtY7010+uL6elfN0m+Lcf
         wask3vNEPL4pMs7slJaJ95Mk6d0S54rtvyTf/xPykNHVLgkiCNEcsCo5rStACoBjw83r
         Rtrdz4dWS9wI9TVo3jdClHO8rEH5DaU/owHCQOTc6vkBMno70Kb0td/WY0Uv1J4k5jfu
         l/YQ==
X-Gm-Message-State: AOAM533WOCVrLkTIIFHqbSSuyGD85rWW+R6HIJ2xjs/ElM29KeiHEClN
        JbhxAzGcSwC5IfjPHX2JwJkifg4DiqCMaYDGIDYH+0pr2pMVh3Nw3CUl1VlFGomgjvxSHGdbtLH
        2kjJy26ThmJvFiRX4JWlDPV+DXdHPk+2L3bcVQ+KLsGF0PqzWST6ifSo7+BJSrb69N1yGtW0E
X-Google-Smtp-Source: ABdhPJz6rrYZkH/v2aljBcBdIGyDW54b6cdwjWQo702TbKhTmeLYyssCI4/6m0kUoFgKEZMQdNNjyMP//c+z
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:8026:6888:3d55:3842])
 (user=bgardon job=sendgmr) by 2002:a25:aa48:: with SMTP id
 s66mr7884275ybi.121.1617224978610; Wed, 31 Mar 2021 14:09:38 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:08:41 -0700
In-Reply-To: <20210331210841.3996155-1-bgardon@google.com>
Message-Id: <20210331210841.3996155-14-bgardon@google.com>
Mime-Version: 1.0
References: <20210331210841.3996155-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 13/13] KVM: x86/mmu: Tear down roots in fast invalidation thread
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

To avoid saddling a vCPU thread with the work of tearing down an entire
paging structure, take a reference on each root before they become
obsolete, so that the thread initiating the fast invalidation can tear
down the paging structure and (most likely) release the last reference.
As a bonus, this teardown can happen under the MMU lock in read mode so
as not to block the progress of vCPU threads.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c     |  6 ++++
 arch/x86/kvm/mmu/tdp_mmu.c | 74 +++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/mmu/tdp_mmu.h |  1 +
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 49b7097fb55b..22742619698d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5455,6 +5455,12 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 	kvm_zap_obsolete_pages(kvm);
 
 	write_unlock(&kvm->mmu_lock);
+
+	if (is_tdp_mmu_enabled(kvm)) {
+		read_lock(&kvm->mmu_lock);
+		kvm_tdp_mmu_zap_all_fast(kvm);
+		read_unlock(&kvm->mmu_lock);
+	}
 }
 
 static bool kvm_has_zapped_obsolete_pages(struct kvm *kvm)
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 428ff6778426..5498df7e2e1f 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -794,13 +794,85 @@ void kvm_tdp_mmu_zap_all(struct kvm *kvm)
  * kvm_reload_remote_mmus. Since this is in the same critical section, no new
  * roots will be created between this function and the MMU reload signals
  * being sent.
+ * Take a reference on all roots so that this thread can do the bulk of
+ * the work required to free the roots once they are invalidated. Without
+ * this reference, a vCPU thread might drop the last reference to a root
+ * and get stuck with tearing down the entire paging structure.
  */
 void kvm_tdp_mmu_invalidate_roots(struct kvm *kvm)
 {
 	struct kvm_mmu_page *root;
 
 	for_each_tdp_mmu_root(kvm, root)
-		root->role.invalid = true;
+		if (refcount_inc_not_zero(&root->tdp_mmu_root_count))
+			root->role.invalid = true;
+}
+
+static struct kvm_mmu_page *next_invalidated_root(struct kvm *kvm,
+						  struct kvm_mmu_page *prev_root)
+{
+	struct kvm_mmu_page *next_root;
+
+	if (prev_root)
+		next_root = list_next_or_null_rcu(&kvm->arch.tdp_mmu_roots,
+						  &prev_root->link,
+						  typeof(*prev_root), link);
+	else
+		next_root = list_first_or_null_rcu(&kvm->arch.tdp_mmu_roots,
+						   typeof(*next_root), link);
+
+	while (next_root && !(next_root->role.invalid &&
+			      refcount_read(&next_root->tdp_mmu_root_count)))
+		next_root = list_next_or_null_rcu(&kvm->arch.tdp_mmu_roots,
+						  &next_root->link,
+						  typeof(*next_root), link);
+
+	return next_root;
+}
+
+/*
+ * Since kvm_tdp_mmu_invalidate_roots has acquired a reference to each
+ * invalidated root, they will not be freed until this function drops the
+ * reference. Before dropping that reference, tear down the paging
+ * structure so that whichever thread does drop the last reference
+ * only has to do a trivial ammount of work. Since the roots are invalid,
+ * no new SPTEs should be created under them.
+ */
+void kvm_tdp_mmu_zap_all_fast(struct kvm *kvm)
+{
+	gfn_t max_gfn = 1ULL << (shadow_phys_bits - PAGE_SHIFT);
+	struct kvm_mmu_page *next_root;
+	struct kvm_mmu_page *root;
+	bool flush = false;
+
+	lockdep_assert_held_read(&kvm->mmu_lock);
+
+	rcu_read_lock();
+
+	root = next_invalidated_root(kvm, NULL);
+
+	while (root) {
+		next_root = next_invalidated_root(kvm, root);
+
+		rcu_read_unlock();
+
+		flush |= zap_gfn_range(kvm, root, 0, max_gfn, true, true);
+
+		/*
+		 * Put the reference acquired in
+		 * kvm_tdp_mmu_invalidate_roots
+		 */
+		kvm_tdp_mmu_put_root(kvm, root, true);
+
+		root = next_root;
+
+		rcu_read_lock();
+	}
+
+	rcu_read_unlock();
+
+	if (flush)
+		kvm_flush_remote_tlbs(kvm);
 }
 
 /*
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index ff4978817fb8..d6d98f9047cd 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -24,6 +24,7 @@ bool kvm_tdp_mmu_zap_gfn_range(struct kvm *kvm, gfn_t start, gfn_t end,
 void kvm_tdp_mmu_zap_all(struct kvm *kvm);
 
 void kvm_tdp_mmu_invalidate_roots(struct kvm *kvm);
+void kvm_tdp_mmu_zap_all_fast(struct kvm *kvm);
 
 int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 		    int map_writable, int max_level, kvm_pfn_t pfn,
-- 
2.31.0.291.g576ba9dcdaf-goog

