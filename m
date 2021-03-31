Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F453508EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhCaVJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbhCaVJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:09:20 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE6AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:09:20 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a9so2104936pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=msexY4B3tOucLNk9KoxMyLN7EdGWZ7JqHSS0HucxajQ=;
        b=acKLmz26/bohY9s+HwE4Mtg+wIKJx7wMoLjz4HKTGvLeTUOoaD7kUOAhslbonHdj5G
         45q2jRPEMZEAA+wh/ZsjURarkAtiMx4hBPcdSGRB0Ey0gCkQLGMAkayWVKizbTp56Tgb
         WjmJZLHLcbvSUt1dtj9hZSLKGRfmx2rYsq6RHQprvf5zUrmjjHkVrhuU7Z7kEA1Ryg7S
         QKz+1k3Tyx5nyuGLvp47XJNaqghN7hIUqynFeuAgtlOS3BT7ARLruwE3g6/WsA3rmIMK
         661HQsYgciOtwUGoBIZIxKErMRGms20WJj7rdB4B5mtd9xOyDFlsYtuNF//iO9VERdU5
         CKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=msexY4B3tOucLNk9KoxMyLN7EdGWZ7JqHSS0HucxajQ=;
        b=d4W4Sx55PADNyb/h0LC2SjSJNzwDnHRfyl4+vXSEdgYmHAiUoXGdb0VBeiygTxOKG9
         sepKFg+OML4pAvdZqLuMYhjWmCgixbisHkScgEk8BEP9JPFW+o0Ij39yh/9HganpNqvn
         /d/y2c9Y7frT4Fzf3kQ8lWFaUMrKLe/hmnUqi7Yh1A40OusUiAFVXdAfopCLKwOjXBar
         FUhphzhMrOn11urAingneRjvndVBS8oRZ/97EroDWPjSmc0X2pRzbtjyrDfTqthCZfxF
         9L0bjnmOp/QSQe8RTc+Lgt90BbpXAoC3Udk6SgCAtQg/eOUDT0zmN6iXnBLqFNTc1uS1
         F/BA==
X-Gm-Message-State: AOAM532is5d6a9Ga9tpIp8zwEPb9mhetBCUYHstQBUs23Fv9utgjPQUX
        p4EEKeKg/muJiw1qhrk5T6VyctdogVPMkj1I8V+l8Lyf1GQqinUE0GpEos+/7Htp75vibkDlfmr
        r4HHL3famds58Yr77faU3X/4r0Dml6fqAEnH0u2twmxIPPLDynzPW0cL0mmg+o1vvtOsUnhiM
X-Google-Smtp-Source: ABdhPJxtr+rqub+/A66p+DuiEZunTbojFitBctpExMsFyH8fHxUN9ZtDsNrxNBFMut3F/lxgTxD6O154aqNa
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:8026:6888:3d55:3842])
 (user=bgardon job=sendgmr) by 2002:a17:90b:4b87:: with SMTP id
 lr7mr5044303pjb.5.1617224959525; Wed, 31 Mar 2021 14:09:19 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:08:35 -0700
In-Reply-To: <20210331210841.3996155-1-bgardon@google.com>
Message-Id: <20210331210841.3996155-8-bgardon@google.com>
Mime-Version: 1.0
References: <20210331210841.3996155-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 07/13] KVM: x86/mmu: Make TDP MMU root refcount atomic
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

In order to parallelize more operations for the TDP MMU, make the
refcount on TDP MMU roots atomic, so that a future patch can allow
multiple threads to take a reference on the root concurrently, while
holding the MMU lock in read mode.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu_internal.h |  6 +++++-
 arch/x86/kvm/mmu/tdp_mmu.c      | 15 ++++++++-------
 arch/x86/kvm/mmu/tdp_mmu.h      |  9 +++------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 788dcf77c957..0a040d6a4f35 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -50,7 +50,11 @@ struct kvm_mmu_page {
 	u64 *spt;
 	/* hold the gfn of each spte inside spt */
 	gfn_t *gfns;
-	int root_count;          /* Currently serving as active root */
+	/* Currently serving as active root */
+	union {
+		int root_count;
+		refcount_t tdp_mmu_root_count;
+	};
 	unsigned int unsync_children;
 	struct kvm_rmap_head parent_ptes; /* rmap pointers to parent sptes */
 	DECLARE_BITMAP(unsync_child_bitmap, 512);
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index ab1d26b40164..1f0b2d6124a2 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -56,7 +56,7 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root)
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	if (--root->root_count)
+	if (!refcount_dec_and_test(&root->tdp_mmu_root_count))
 		return;
 
 	WARN_ON(!root->tdp_mmu_page);
@@ -88,10 +88,12 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
 		next_root = list_first_entry(&kvm->arch.tdp_mmu_roots,
 					     typeof(*next_root), link);
 
+	while (!list_entry_is_head(next_root, &kvm->arch.tdp_mmu_roots, link) &&
+	       !kvm_tdp_mmu_get_root(kvm, next_root))
+		next_root = list_next_entry(next_root, link);
+
 	if (list_entry_is_head(next_root, &kvm->arch.tdp_mmu_roots, link))
 		next_root = NULL;
-	else
-		kvm_tdp_mmu_get_root(kvm, next_root);
 
 	if (prev_root)
 		kvm_tdp_mmu_put_root(kvm, prev_root);
@@ -158,14 +160,13 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
 
 	/* Check for an existing root before allocating a new one. */
 	for_each_tdp_mmu_root(kvm, root) {
-		if (root->role.word == role.word) {
-			kvm_tdp_mmu_get_root(kvm, root);
+		if (root->role.word == role.word &&
+		    kvm_tdp_mmu_get_root(kvm, root))
 			goto out;
-		}
 	}
 
 	root = alloc_tdp_mmu_page(vcpu, 0, vcpu->arch.mmu->shadow_root_level);
-	root->root_count = 1;
+	refcount_set(&root->tdp_mmu_root_count, 1);
 
 	list_add(&root->link, &kvm->arch.tdp_mmu_roots);
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index 5d950e987fc7..9961df505067 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -7,13 +7,10 @@
 
 hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu);
 
-static inline void kvm_tdp_mmu_get_root(struct kvm *kvm,
-					struct kvm_mmu_page *root)
+__must_check static inline bool kvm_tdp_mmu_get_root(struct kvm *kvm,
+						     struct kvm_mmu_page *root)
 {
-	BUG_ON(!root->root_count);
-	lockdep_assert_held(&kvm->mmu_lock);
-
-	++root->root_count;
+	return refcount_inc_not_zero(&root->tdp_mmu_root_count);
 }
 
 void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root);
-- 
2.31.0.291.g576ba9dcdaf-goog

