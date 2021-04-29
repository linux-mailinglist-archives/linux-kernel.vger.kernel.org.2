Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2890336F1DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbhD2VTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbhD2VTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:19:38 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9CFC06138D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:18:50 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id o7-20020a0cf4c70000b02901a53a28706fso26308876qvm.19
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1wV27xnqMavGvIltGDlIu2K+7OVnrSqNChCOIi4TNS4=;
        b=jvknsd1iliMtr4R8A/dMkmpsg9lN29BvOtTtwdjUo3Pa2giCRJxUwhmEV6cDaxID4L
         /h+UxqoKiAa4UDtUIQhN8YogWmlGs4GTmkDd3f52tHXv9mHOHHcDMBEWc2QzfuAztd6i
         N5uO1J8zMpM8hHsI22gb5JIRYENVMalPPKejZJ+Zmxg+2L5N2kq+namxp0woSkyLY1KI
         vseeOyb9NmfVoW1k2dqo8MOXSgBBDGlnoE9j/GsZ8XD9yVKShb9uk9mEL1cHKLq6Ieoj
         Wkxw8LcorWTx0weBpHFHeD+6vxlNe94YZzcUVi355ABkpBrl7xxqP9gAfbxLzoy24HUj
         i/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1wV27xnqMavGvIltGDlIu2K+7OVnrSqNChCOIi4TNS4=;
        b=H60Hbg90JEwmof1DsSXo6TLakeHpQOVPuoppV04yIcDw55D2KvcWpL2XHRLutWYEx7
         rTUD+4HT5w5+WzbMMEVLFoiYRkku0yDx2jjnj/hHIPgRSNU5TbTsQyKC4hCxHphcVilb
         9VTbGwnZG2l4ZTxxPOML5WBl7YVgrYfnvGQMoX+EQ5NduVdmtAeRbQDnpJAB8moTOTzm
         u2Dpg1iciT1R1rJ5kMrLxHvTTxw59LMDtOpAw8Gq4aFc8yizPg0kKsE3P5zt+8Ix8uYN
         zAFnPxe/4r32UWoT55f93TjircB+f3OeOwNFvH+w8Plh/eqxBl4PKbwH8puZjZcFB+Ef
         D/tg==
X-Gm-Message-State: AOAM5335yFWb4fBSqKZ/V6wMmgFqAxmjc8vEIgFdLVxoPGTzFCqgyXff
        LLBJ+CUnenDt76doTrcAJmwGuMVq4rQBnZhBB+gJwGm6rjZyewZoH2R18czOu/onJS1cBrH8PJP
        DPFt3/ZHgzBkUXtfx3ZWFidmxf0AjoCiqCz0YnaU/ku3DVy0CIPTLCbgccJCrUDD9PQoku+uH
X-Google-Smtp-Source: ABdhPJyY7Bg2F/dVUQmrpChxTdjTp6lJBGHFvWu78QERBqCawGmLq2EKPh/Rlez8bBdb3LyylM8lYUZYlKwO
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:1a18:9719:a02:56fb])
 (user=bgardon job=sendgmr) by 2002:a0c:ba1a:: with SMTP id
 w26mr2046434qvf.27.1619731129504; Thu, 29 Apr 2021 14:18:49 -0700 (PDT)
Date:   Thu, 29 Apr 2021 14:18:27 -0700
In-Reply-To: <20210429211833.3361994-1-bgardon@google.com>
Message-Id: <20210429211833.3361994-2-bgardon@google.com>
Mime-Version: 1.0
References: <20210429211833.3361994-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v2 1/7] KVM: x86/mmu: Track if shadow MMU active
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
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

Add a field to each VM to track if the shadow / legacy MMU is actually
in use. If the shadow MMU is not in use, then that knowledge opens the
door to other optimizations which will be added in future patches.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/mmu/mmu.c          | 10 +++++++++-
 arch/x86/kvm/mmu/mmu_internal.h |  2 ++
 arch/x86/kvm/mmu/tdp_mmu.c      |  6 ++++--
 arch/x86/kvm/mmu/tdp_mmu.h      |  4 ++--
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ad22d4839bcc..3900dcf2439e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1122,6 +1122,8 @@ struct kvm_arch {
 	 */
 	spinlock_t tdp_mmu_pages_lock;
 #endif /* CONFIG_X86_64 */
+
+	bool shadow_mmu_active;
 };
 
 struct kvm_vm_stat {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 930ac8a7e7c9..3975272321d0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3110,6 +3110,11 @@ static int fast_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	return ret;
 }
 
+void activate_shadow_mmu(struct kvm *kvm)
+{
+	kvm->arch.shadow_mmu_active = true;
+}
+
 static void mmu_free_root_page(struct kvm *kvm, hpa_t *root_hpa,
 			       struct list_head *invalid_list)
 {
@@ -3280,6 +3285,8 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 		}
 	}
 
+	activate_shadow_mmu(vcpu->kvm);
+
 	write_lock(&vcpu->kvm->mmu_lock);
 	r = make_mmu_pages_available(vcpu);
 	if (r < 0)
@@ -5467,7 +5474,8 @@ void kvm_mmu_init_vm(struct kvm *kvm)
 {
 	struct kvm_page_track_notifier_node *node = &kvm->arch.mmu_sp_tracker;
 
-	kvm_mmu_init_tdp_mmu(kvm);
+	if (!kvm_mmu_init_tdp_mmu(kvm))
+		activate_shadow_mmu(kvm);
 
 	node->track_write = kvm_mmu_pte_write;
 	node->track_flush_slot = kvm_mmu_invalidate_zap_pages_in_memslot;
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index f2546d6d390c..297a911c018c 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -165,4 +165,6 @@ void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
 void account_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp);
 void unaccount_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp);
 
+void activate_shadow_mmu(struct kvm *kvm);
+
 #endif /* __KVM_X86_MMU_INTERNAL_H */
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 83cbdbe5de5a..5342aca2c8e0 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -14,10 +14,10 @@ static bool __read_mostly tdp_mmu_enabled = false;
 module_param_named(tdp_mmu, tdp_mmu_enabled, bool, 0644);
 
 /* Initializes the TDP MMU for the VM, if enabled. */
-void kvm_mmu_init_tdp_mmu(struct kvm *kvm)
+bool kvm_mmu_init_tdp_mmu(struct kvm *kvm)
 {
 	if (!tdp_enabled || !READ_ONCE(tdp_mmu_enabled))
-		return;
+		return false;
 
 	/* This should not be changed for the lifetime of the VM. */
 	kvm->arch.tdp_mmu_enabled = true;
@@ -25,6 +25,8 @@ void kvm_mmu_init_tdp_mmu(struct kvm *kvm)
 	INIT_LIST_HEAD(&kvm->arch.tdp_mmu_roots);
 	spin_lock_init(&kvm->arch.tdp_mmu_pages_lock);
 	INIT_LIST_HEAD(&kvm->arch.tdp_mmu_pages);
+
+	return true;
 }
 
 static __always_inline void kvm_lockdep_assert_mmu_lock_held(struct kvm *kvm,
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index 5fdf63090451..b046ab5137a1 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -80,12 +80,12 @@ int kvm_tdp_mmu_get_walk(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes,
 			 int *root_level);
 
 #ifdef CONFIG_X86_64
-void kvm_mmu_init_tdp_mmu(struct kvm *kvm);
+bool kvm_mmu_init_tdp_mmu(struct kvm *kvm);
 void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm);
 static inline bool is_tdp_mmu_enabled(struct kvm *kvm) { return kvm->arch.tdp_mmu_enabled; }
 static inline bool is_tdp_mmu_page(struct kvm_mmu_page *sp) { return sp->tdp_mmu_page; }
 #else
-static inline void kvm_mmu_init_tdp_mmu(struct kvm *kvm) {}
+static inline bool kvm_mmu_init_tdp_mmu(struct kvm *kvm) { return false; }
 static inline void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm) {}
 static inline bool is_tdp_mmu_enabled(struct kvm *kvm) { return false; }
 static inline bool is_tdp_mmu_page(struct kvm_mmu_page *sp) { return false; }
-- 
2.31.1.527.g47e6f16901-goog

