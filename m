Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C0B452863
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 04:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245392AbhKPDTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 22:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbhKPDSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 22:18:00 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1323C03AA02
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:46:10 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id b11-20020a17090acc0b00b001a9179dc89fso348271pju.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CrzbjrscULj4Dg1fX5nLFO7ahCBMSKg0nQziJBU00js=;
        b=RK3viodQvs2MBG+iV942VqiKjAzlEyYpVczlVa9BP/a4aBKi29lpfBZfx9H9/jeaCD
         uteQxO5FLk+uC0FX+8j2+XWx2xMIlkBFpOgmdWDT+EIfa+MDSZHRAKXPtdFuSSycPNiD
         g/IscGCEOV4nSRXT6e2FWOLQ5PIxHF6AuzcpkcXO6GHtyPKhCmGz2g+sK8dPU1ciN2n2
         xhnoc5MGIGcaz2GCm5isat9SyT9EeQuuNFV7nh9jVdrsA7TP1/5ebvz+O4kqGD6SkhAy
         2dEZg/Qgb/QnMn8wsNq/mv+03SvQpR2ggu3Spbm+FcW9P2pROIdIdcfpfqke0TEZc5nW
         GlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CrzbjrscULj4Dg1fX5nLFO7ahCBMSKg0nQziJBU00js=;
        b=Bsh/WWQP4f2CF8ObN6oJGuQ9jQBa9Qa4nC8aj/IibaQ2+QTR3Zt8rQwdHEd9S1mq8W
         J6REma/FqpYjMWj+U8TLsKGWInItuwH0CyluwmNyFs1IUiLE5vgNWch5EDrspBnemYrk
         G+FrI9UaR0PukEFldoBVBtcmDTAVdzTGVV9uebgXUACpwt4h/vTkNsxgfXIYB2R9B/IH
         PcYThtpetqfSX98gZh5rI6BBrX/wO7DeBcu4WLJWcJQxzcCMP6P9NKI9DoPTg40fyKZU
         zGvLEyl+UbobvNa8Txff7+1KGI21VfzRvAqlVXQIpZa6oTIJ9kf8Qo2rww8ac5jfVvBd
         Kl4g==
X-Gm-Message-State: AOAM5302XHD9X9TPmeEqE9KfekSUI7TEhi222x5+N7SaB9HOmpJ+2c2c
        oZ5gQ56VULaSENPhhfeCCAJUNc5n1Ii7VkkOt/LjRuKIxGJDmycNS4exsXX2ctJ+bAKEcjHHVio
        VMwvA0MGIzX8qcGfHjrzLo0Wdl7CSbCVKaX23ILshMoYsPdwMs8EUvO4W+zsnXFZUyrgnOnhg
X-Google-Smtp-Source: ABdhPJzInLL2Tp8AmTKtaUk8NgsD6eRTMx8aQqk+UjES9ao9u2Kr2nWwYtamHV/chMSUqFhO1MeM/GCWz0KS
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:916d:2253:5849:9965])
 (user=bgardon job=sendgmr) by 2002:a17:90b:17cf:: with SMTP id
 me15mr3038244pjb.125.1637019970413; Mon, 15 Nov 2021 15:46:10 -0800 (PST)
Date:   Mon, 15 Nov 2021 15:45:50 -0800
In-Reply-To: <20211115234603.2908381-1-bgardon@google.com>
Message-Id: <20211115234603.2908381-3-bgardon@google.com>
Mime-Version: 1.0
References: <20211115234603.2908381-1-bgardon@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH 02/15] KVM: x86/mmu: Introduce vcpu_make_spte
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

Add a wrapper around make_spte which conveys the vCPU-specific context of
the function. This will facilitate factoring out all uses of the vCPU
pointer from make_spte in subsequent commits.

No functional change intended.


Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c         |  2 +-
 arch/x86/kvm/mmu/paging_tmpl.h |  6 +++---
 arch/x86/kvm/mmu/spte.c        | 17 +++++++++++++----
 arch/x86/kvm/mmu/spte.h        | 12 ++++++++----
 arch/x86/kvm/mmu/tdp_mmu.c     |  7 ++++---
 5 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index baa94acab516..2ada6dee920a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2723,7 +2723,7 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 			was_rmapped = 1;
 	}
 
-	wrprot = make_spte(vcpu, sp, slot, pte_access, gfn, pfn, *sptep, prefetch,
+	wrprot = vcpu_make_spte(vcpu, sp, slot, pte_access, gfn, pfn, *sptep, prefetch,
 			   true, host_writable, &spte);
 
 	if (*sptep == spte) {
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index f87d36898c44..edb8ebd1a775 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -1129,9 +1129,9 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 		spte = *sptep;
 		host_writable = spte & shadow_host_writable_mask;
 		slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
-		make_spte(vcpu, sp, slot, pte_access, gfn,
-			  spte_to_pfn(spte), spte, true, false,
-			  host_writable, &spte);
+		vcpu_make_spte(vcpu, sp, slot, pte_access, gfn,
+			       spte_to_pfn(spte), spte, true, false,
+			       host_writable, &spte);
 
 		flush |= mmu_spte_update(sptep, spte);
 	}
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 0c76c45fdb68..04d26e913941 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -90,10 +90,9 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
 }
 
 bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
-	       struct kvm_memory_slot *slot,
-	       unsigned int pte_access, gfn_t gfn, kvm_pfn_t pfn,
-	       u64 old_spte, bool prefetch, bool can_unsync,
-	       bool host_writable, u64 *new_spte)
+	       struct kvm_memory_slot *slot, unsigned int pte_access,
+	       gfn_t gfn, kvm_pfn_t pfn, u64 old_spte, bool prefetch,
+	       bool can_unsync, bool host_writable, u64 *new_spte)
 {
 	int level = sp->role.level;
 	u64 spte = SPTE_MMU_PRESENT_MASK;
@@ -191,6 +190,16 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	return wrprot;
 }
 
+bool vcpu_make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
+		    struct kvm_memory_slot *slot, unsigned int pte_access,
+		    gfn_t gfn, kvm_pfn_t pfn, u64 old_spte, bool prefetch,
+		    bool can_unsync, bool host_writable, u64 *new_spte)
+{
+	return make_spte(vcpu, sp, slot, pte_access, gfn, pfn, old_spte,
+			 prefetch, can_unsync, host_writable, new_spte);
+
+}
+
 u64 make_nonleaf_spte(u64 *child_pt, bool ad_disabled)
 {
 	u64 spte = SPTE_MMU_PRESENT_MASK;
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index cc432f9a966b..14f18082d505 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -330,10 +330,14 @@ static inline u64 get_mmio_spte_generation(u64 spte)
 }
 
 bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
-	       struct kvm_memory_slot *slot,
-	       unsigned int pte_access, gfn_t gfn, kvm_pfn_t pfn,
-	       u64 old_spte, bool prefetch, bool can_unsync,
-	       bool host_writable, u64 *new_spte);
+	       struct kvm_memory_slot *slot, unsigned int pte_access,
+	       gfn_t gfn, kvm_pfn_t pfn, u64 old_spte, bool prefetch,
+	       bool can_unsync, bool host_writable, u64 *new_spte);
+bool vcpu_make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
+		    struct kvm_memory_slot *slot,
+		    unsigned int pte_access, gfn_t gfn, kvm_pfn_t pfn,
+		    u64 old_spte, bool prefetch, bool can_unsync,
+		    bool host_writable, u64 *new_spte);
 u64 make_nonleaf_spte(u64 *child_pt, bool ad_disabled);
 u64 make_mmio_spte(struct kvm_vcpu *vcpu, u64 gfn, unsigned int access);
 u64 mark_spte_for_access_track(u64 spte);
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index b3c78568ae60..43c7834b4f0a 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -906,9 +906,10 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 	if (unlikely(!fault->slot))
 		new_spte = make_mmio_spte(vcpu, iter->gfn, ACC_ALL);
 	else
-		wrprot = make_spte(vcpu, sp, fault->slot, ACC_ALL, iter->gfn,
-					 fault->pfn, iter->old_spte, fault->prefetch, true,
-					 fault->map_writable, &new_spte);
+		wrprot = vcpu_make_spte(vcpu, sp, fault->slot, ACC_ALL,
+					iter->gfn, fault->pfn, iter->old_spte,
+					fault->prefetch, true,
+					fault->map_writable, &new_spte);
 
 	if (new_spte == iter->old_spte)
 		ret = RET_PF_SPURIOUS;
-- 
2.34.0.rc1.387.gb447b232ab-goog

