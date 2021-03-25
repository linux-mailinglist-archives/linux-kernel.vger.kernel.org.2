Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB895349ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 21:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhCYUB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 16:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCYUBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 16:01:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7BFC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 13:01:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a63so7351472yba.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 13:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=T08bEStNK367PEMClCqBYtUZXi5WflZ+LwVjY//7s8o=;
        b=VO9oLs8wnn1pLeC9vVubvn7jOcQswjOlmEjkTLeoIQtD0Pb0UhqzndgHUjWCxffyMi
         DtQSTDmFk16i6THk0oCrBBoywm2C7TwmFISRruej4DwFKPixFFsPjCQWWfjWqmDyHa27
         XGcOT9EMfphLFdYQL46A+i8/rQbrrP/vZPSFYjDMJuiw8UNKkWJxqfT20QII5krZ6q05
         g/rP47XIRODqVOC/60SgDLTyo/Tdd3RmJvxG1RxBxNeYDdxjKvoJJYk70nUFvnV9usQm
         fU2OVisJq7nO8UW0r/gpi96fEqSijG+XCM9GKVo+y8C3hf3zzoR1aNr/ziYiRlZheIoh
         dpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=T08bEStNK367PEMClCqBYtUZXi5WflZ+LwVjY//7s8o=;
        b=dVxdHuoG5I/JWp0NQUsByTcq2fWGdhZaDZcrLUKxQ+F6BCL2MMCQi/puDcUJ/ZXlnJ
         6KmJ99pokQ+61wz7Q0AgludUYgKT1TEhhtRgTs888O0ZEYSWpystEalX1PNXY1wXS+Hq
         VuvTP2kRUpOLaVDSsn9tn6iom0GKW2F5/ulE1xtFES1YebJ7Aulkh9fvhr9Omxh4cCiC
         hT2mh47+Wl2DQc1ZAIi+WKcoBUO/KcuXieK4ZAAUrfWO1XzIHN4BFcVe9Et2R/6N9rWr
         coc545Cm6Jz51tEy4Cm/qd18BhIGJaDDRtwmJdSIuCXgp91i+XxVcanXIjPRwE433TV1
         q2FQ==
X-Gm-Message-State: AOAM53262C2X7Vy+Cmw+S+G6NOO16rAVhTDlVAFOweegJQAlOz7Seyu4
        BSE0AK8Mc1+oUPtZOdHLMH8TQ22ydZY=
X-Google-Smtp-Source: ABdhPJx9PeZjgZYKJ7buXdOgUJywBQK1bJy+rGR8Q5GO0x/QzgUTd3BQ4RMNPgELdKHjvRX15sTLD1gBXmU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:b1bb:fab2:7ef5:fc7d])
 (user=seanjc job=sendgmr) by 2002:a5b:448:: with SMTP id s8mr13974182ybp.363.1616702489347;
 Thu, 25 Mar 2021 13:01:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 25 Mar 2021 13:01:19 -0700
In-Reply-To: <20210325200119.1359384-1-seanjc@google.com>
Message-Id: <20210325200119.1359384-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210325200119.1359384-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 3/3] KVM: x86/mmu: Don't allow TDP MMU to yield when
 recovering NX pages
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent the TDP MMU from yielding when zapping a gfn range during NX
page recovery.  If a flush is pending from a previous invocation of the
zapping helper, either in the TDP MMU or the legacy MMU, but the TDP MMU
has not accumulated a flush for the current invocation, then yielding
will release mmu_lock with stale TLB entriesr

That being said, this isn't technically a bug fix in the current code, as
the TDP MMU will never yield in this case.  tdp_mmu_iter_cond_resched()
will yield if and only if it has made forward progress, as defined by the
current gfn vs. the last yielded (or starting) gfn.  Because zapping a
single shadow page is guaranteed to (a) find that page and (b) step
sideways at the level of the shadow page, the TDP iter will break its loop
before getting a chance to yield.

But that is all very, very subtle, and will break at the slightest sneeze,
e.g. zapping while holding mmu_lock for read would break as the TDP MMU
wouldn't be guaranteed to see the present shadow page, and thus could step
sideways at a lower level.

Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c     |  4 +---
 arch/x86/kvm/mmu/tdp_mmu.c |  5 +++--
 arch/x86/kvm/mmu/tdp_mmu.h | 23 ++++++++++++++++++++++-
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5a53743b37bc..7a99e59c8c1c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5940,7 +5940,6 @@ static void kvm_recover_nx_lpages(struct kvm *kvm)
 	unsigned int ratio;
 	LIST_HEAD(invalid_list);
 	bool flush = false;
-	gfn_t gfn_end;
 	ulong to_zap;
 
 	rcu_idx = srcu_read_lock(&kvm->srcu);
@@ -5962,8 +5961,7 @@ static void kvm_recover_nx_lpages(struct kvm *kvm)
 				      lpage_disallowed_link);
 		WARN_ON_ONCE(!sp->lpage_disallowed);
 		if (is_tdp_mmu_page(sp)) {
-			gfn_end = sp->gfn + KVM_PAGES_PER_HPAGE(sp->role.level);
-			flush = kvm_tdp_mmu_zap_gfn_range(kvm, sp->gfn, gfn_end);
+			flush = kvm_tdp_mmu_zap_sp(kvm, sp);
 		} else {
 			kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
 			WARN_ON_ONCE(sp->lpage_disallowed);
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 6cf08c3c537f..08667e3cf091 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -709,13 +709,14 @@ static bool zap_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
  * SPTEs have been cleared and a TLB flush is needed before releasing the
  * MMU lock.
  */
-bool kvm_tdp_mmu_zap_gfn_range(struct kvm *kvm, gfn_t start, gfn_t end)
+bool __kvm_tdp_mmu_zap_gfn_range(struct kvm *kvm, gfn_t start, gfn_t end,
+				 bool can_yield)
 {
 	struct kvm_mmu_page *root;
 	bool flush = false;
 
 	for_each_tdp_mmu_root_yield_safe(kvm, root)
-		flush = zap_gfn_range(kvm, root, start, end, true, flush);
+		flush = zap_gfn_range(kvm, root, start, end, can_yield, flush);
 
 	return flush;
 }
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index 3b761c111bff..715aa4e0196d 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -8,7 +8,28 @@
 hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu);
 void kvm_tdp_mmu_free_root(struct kvm *kvm, struct kvm_mmu_page *root);
 
-bool kvm_tdp_mmu_zap_gfn_range(struct kvm *kvm, gfn_t start, gfn_t end);
+bool __kvm_tdp_mmu_zap_gfn_range(struct kvm *kvm, gfn_t start, gfn_t end,
+				 bool can_yield);
+static inline bool kvm_tdp_mmu_zap_gfn_range(struct kvm *kvm, gfn_t start,
+					     gfn_t end)
+{
+	return __kvm_tdp_mmu_zap_gfn_range(kvm, start, end, true);
+}
+static inline bool kvm_tdp_mmu_zap_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	gfn_t end = sp->gfn + KVM_PAGES_PER_HPAGE(sp->role.level);
+
+	/*
+	 * Don't allow yielding, as the caller may have a flush pending.  Note,
+	 * if mmu_lock is held for write, zapping will never yield in this case,
+	 * but explicitly disallow it for safety.  The TDP MMU does not yield
+	 * until it has made forward progress (steps sideways), and when zapping
+	 * a single shadow page that it's guaranteed to see (thus the mmu_lock
+	 * requirement), its "step sideways" will always step beyond the bounds
+	 * of the shadow page's gfn range and stop iterating before yielding.
+	 */
+	return __kvm_tdp_mmu_zap_gfn_range(kvm, sp->gfn, end, false);
+}
 void kvm_tdp_mmu_zap_all(struct kvm *kvm);
 
 int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
-- 
2.31.0.291.g576ba9dcdaf-goog

