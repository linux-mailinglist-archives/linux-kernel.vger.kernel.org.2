Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922413508E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhCaVJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhCaVJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:09:12 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A31C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:09:12 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id p18so1748442plf.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z3AbaY4xF3wQFCjsVJEwWTj55cgDBbY2/T0t16utnJU=;
        b=fgtZ82EtNR11qrofu03windXUy6V5FdhrMvsF3mlN+GAZUIOxBF0412xBrvJk0+k2x
         0Xd2bc03KqB+Mo+Y3rkcTzUw1bXy6//l2ZP0yZFksLiMxQHSrl74X1mn9DwCED9cG0I/
         A1KW4Q7FN6bv8r8OOsoqd5fu3afEYQKORs3Pzj3YIBWud1aTYFf8PGVW78Au3ctaqKHm
         HVinDB40pVjkio6kQodAAt3re3pGfI2t6CEpiAcrVpNVCvACzrOmW896Zqqzaxjj8Smi
         Xn96V8NU1Z/gXfYFG1rkcy8J+AgSCBCFgn6XJLus/Kt+c1eMn4UK49h6536qzNxLNs9Z
         1FcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z3AbaY4xF3wQFCjsVJEwWTj55cgDBbY2/T0t16utnJU=;
        b=KTZxm9ujTugsM9s9fMnO4txQbSY10OOerLyWBskZqt3WXI6pFFROemG/mqUmjNlI7b
         DRIiK9IYnCe28Ay/nR0QEMeF5k4uAq27ZoB6W072G3DZwW9uGf+iZjCL05wD/ZEL/iDh
         6zCajCfI5fiHyjpDXLVs/XUlfKLaL98GfxPZkYOrMWyYuqAVgYoum9vO2Z2PZUICatDZ
         uUZ96zoneAH81fXMWirey0LY9d9th6SBKKC9swzYO8/3XOvrbRjAPL5vRiYCpw2iL2Mr
         SZZcps75JYNdE5QpuCMp+NFq0jTxc5wmgPklkfxp16Tm5eksrzPGTfkwY+wfWvw8nH7J
         9wPQ==
X-Gm-Message-State: AOAM533kHMGb/0HLBoD6eIU56uNwxfIwbxAxJMU3wxtHHPsArDz+ZYWg
        U+FPPPVwaiELw89YQWVKZVofO+ldv3lSaF398XEnI7p74EeNYkKPNN4YkC3PlocrLbVtNJKFcrG
        V4ECbCrcb27v1C0BJ5LOGriMCRzezOPktRALyZhhGZocIFrRpLUvjAhqMK3L02+TWxZT7C8aO
X-Google-Smtp-Source: ABdhPJxr6gqhQZp6FxXpXS+z256GvgNPXTus2sGi1j6yS0QopdYhTS2M2JlUPrKDWH+G+mMddS5biyeVT5P2
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:8026:6888:3d55:3842])
 (user=bgardon job=sendgmr) by 2002:a17:90b:fcb:: with SMTP id
 gd11mr39565pjb.0.1617224950491; Wed, 31 Mar 2021 14:09:10 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:08:32 -0700
In-Reply-To: <20210331210841.3996155-1-bgardon@google.com>
Message-Id: <20210331210841.3996155-5-bgardon@google.com>
Mime-Version: 1.0
References: <20210331210841.3996155-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 04/13] KVM: x86/mmu: Merge TDP MMU put and free root
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

kvm_tdp_mmu_put_root and kvm_tdp_mmu_free_root are always called
together, so merge the functions to simplify TDP MMU root refcounting /
freeing.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c     |  4 +--
 arch/x86/kvm/mmu/tdp_mmu.c | 54 ++++++++++++++++++--------------------
 arch/x86/kvm/mmu/tdp_mmu.h | 10 +------
 3 files changed, 28 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 618cc011f446..667d64daa82c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3154,8 +3154,8 @@ static void mmu_free_root_page(struct kvm *kvm, hpa_t *root_hpa,
 
 	sp = to_shadow_page(*root_hpa & PT64_BASE_ADDR_MASK);
 
-	if (is_tdp_mmu_page(sp) && kvm_tdp_mmu_put_root(kvm, sp))
-		kvm_tdp_mmu_free_root(kvm, sp);
+	if (is_tdp_mmu_page(sp))
+		kvm_tdp_mmu_put_root(kvm, sp);
 	else if (!--sp->root_count && sp->role.invalid)
 		kvm_mmu_prepare_zap_page(kvm, sp, invalid_list);
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 5a2698d64957..368091adab09 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -41,10 +41,31 @@ void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm)
 	rcu_barrier();
 }
 
-static void tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root)
+static bool zap_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
+			  gfn_t start, gfn_t end, bool can_yield);
+
+static void tdp_mmu_free_sp(struct kvm_mmu_page *sp)
 {
-	if (kvm_tdp_mmu_put_root(kvm, root))
-		kvm_tdp_mmu_free_root(kvm, root);
+	free_page((unsigned long)sp->spt);
+	kmem_cache_free(mmu_page_header_cache, sp);
+}
+
+void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root)
+{
+	gfn_t max_gfn = 1ULL << (shadow_phys_bits - PAGE_SHIFT);
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	if (--root->root_count)
+		return;
+
+	WARN_ON(!root->tdp_mmu_page);
+
+	list_del(&root->link);
+
+	zap_gfn_range(kvm, root, 0, max_gfn, false);
+
+	tdp_mmu_free_sp(root);
 }
 
 static inline bool tdp_mmu_next_root_valid(struct kvm *kvm,
@@ -66,7 +87,7 @@ static inline struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
 	struct kvm_mmu_page *next_root;
 
 	next_root = list_next_entry(root, link);
-	tdp_mmu_put_root(kvm, root);
+	kvm_tdp_mmu_put_root(kvm, root);
 	return next_root;
 }
 
@@ -85,31 +106,6 @@ static inline struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
 #define for_each_tdp_mmu_root(_kvm, _root)				\
 	list_for_each_entry(_root, &_kvm->arch.tdp_mmu_roots, link)
 
-static bool zap_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
-			  gfn_t start, gfn_t end, bool can_yield);
-
-static void tdp_mmu_free_sp(struct kvm_mmu_page *sp)
-{
-	free_page((unsigned long)sp->spt);
-	kmem_cache_free(mmu_page_header_cache, sp);
-}
-
-void kvm_tdp_mmu_free_root(struct kvm *kvm, struct kvm_mmu_page *root)
-{
-	gfn_t max_gfn = 1ULL << (shadow_phys_bits - PAGE_SHIFT);
-
-	lockdep_assert_held_write(&kvm->mmu_lock);
-
-	WARN_ON(root->root_count);
-	WARN_ON(!root->tdp_mmu_page);
-
-	list_del(&root->link);
-
-	zap_gfn_range(kvm, root, 0, max_gfn, false);
-
-	tdp_mmu_free_sp(root);
-}
-
 static union kvm_mmu_page_role page_role_for_level(struct kvm_vcpu *vcpu,
 						   int level)
 {
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index 2dc3b3ba48fb..5d950e987fc7 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -6,7 +6,6 @@
 #include <linux/kvm_host.h>
 
 hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu);
-void kvm_tdp_mmu_free_root(struct kvm *kvm, struct kvm_mmu_page *root);
 
 static inline void kvm_tdp_mmu_get_root(struct kvm *kvm,
 					struct kvm_mmu_page *root)
@@ -17,14 +16,7 @@ static inline void kvm_tdp_mmu_get_root(struct kvm *kvm,
 	++root->root_count;
 }
 
-static inline bool kvm_tdp_mmu_put_root(struct kvm *kvm,
-					struct kvm_mmu_page *root)
-{
-	lockdep_assert_held(&kvm->mmu_lock);
-	--root->root_count;
-
-	return !root->root_count;
-}
+void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root);
 
 bool kvm_tdp_mmu_zap_gfn_range(struct kvm *kvm, gfn_t start, gfn_t end);
 void kvm_tdp_mmu_zap_all(struct kvm *kvm);
-- 
2.31.0.291.g576ba9dcdaf-goog

