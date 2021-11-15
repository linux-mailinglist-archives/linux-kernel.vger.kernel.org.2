Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7469452868
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 04:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343512AbhKPDT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 22:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbhKPDSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 22:18:00 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B73C03AA04
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:46:12 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id x1-20020a17090a294100b001a6e7ba6b4eso672195pjf.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qcf2Eg0o3TvhzSJkWrvn5u1Le3k7H28bMccIScZI42Q=;
        b=R1f21uBhu2zkhQpwfilUK0yB4rzDBRwp3gLteA2bYINBMGeLzvLuE0mACNCuiyZ4f9
         lrfP3Y0+7uhtb1YYetVZQ+6nT9gYGh26Uc7jorYccvBq4+EaO+XQeFzXk/W0GG/FoSl4
         +E9XfsvZZ49aMcMs7aYHH6ASRma04+TRwVnpS+glHOP6gT14RZZbLOu4OWGWoG9QETFb
         GhTw28lSnP2nEnyzty+HNxnhUv+mGpfw3ackN3aiJf7JUPMnnhJluetBSW+M0K2Gm6Wz
         VtCtxZQgymuSjEXK0fCynCwuhAcnX/gLAWHFosCGqy+1496Yo3BrQXri4v+CaOx2/46m
         A1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qcf2Eg0o3TvhzSJkWrvn5u1Le3k7H28bMccIScZI42Q=;
        b=aswAbPLk/sa5eMZy667Gn1E/Amu4aqF+Ns5JJmNKui1MoeZsR/+CdiZWrOWuu6SGki
         y1crBm9WQR+ZBLayNHrmtu94MZ+TL4yN+M/NOAgggFjyquxYHzAjfUaqfy3/10ZATOXi
         ACBTGHanG+r1rGB7A6Idq+CahHyvOg0PpWKFdbcwLbBEmglbWIC9eHpTEL/PWtHb81Df
         CSZ7UMNZofVl+Z+6NRTUQmlgJgbPg0zTGQA2ro2fUtl9czutfvX1VzRB1cLc4gXwTJ5R
         hUz/FbMdbI3BJz0nmIs3n47Pmz4zvf6hiCcFSivLbx279YHbHcZSrtvOV/5/2uTRSume
         DuTw==
X-Gm-Message-State: AOAM532dDmxcph97HR/A3hXBbTjphWgv0cKHGB9Qs5k/gTZlRVY4kYpn
        Rx3JjP+AOyki1iMvv1xo5eUAudDnfLj44L2VurawjsZg339+8NnlXDVtW0Ei12d/Uh3qErGqx3g
        15yOl3hpnISIrnZ0Sn7XEtbHH/aYChYGhFrfoIAPlSEYXlSKoTaYSh3NxjVTz2TCTsN8nIUx7
X-Google-Smtp-Source: ABdhPJxO7hzN+85LFyrvqt+Vom8vQ6lHGRfbKSwvSNQmt4Rhs5Q7EHtYF2UwuFZzvGiinA9jezuFZOw+rmAN
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:916d:2253:5849:9965])
 (user=bgardon job=sendgmr) by 2002:a17:90b:4b85:: with SMTP id
 lr5mr3163913pjb.236.1637019971898; Mon, 15 Nov 2021 15:46:11 -0800 (PST)
Date:   Mon, 15 Nov 2021 15:45:51 -0800
In-Reply-To: <20211115234603.2908381-1-bgardon@google.com>
Message-Id: <20211115234603.2908381-4-bgardon@google.com>
Mime-Version: 1.0
References: <20211115234603.2908381-1-bgardon@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH 03/15] KVM: x86/mmu: Factor wrprot for nested PML out of make_spte
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

When running a nested VM, KVM write protects SPTEs in the EPT/NPT02
instead of using PML for dirty tracking. This avoids expensive
translation later, when emptying the Page Modification Log. In service
of removing the vCPU pointer from make_spte, factor the check for nested
PML out of the function.


Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/spte.c | 10 +++++++---
 arch/x86/kvm/mmu/spte.h |  3 ++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 04d26e913941..3cf08a534a16 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -92,7 +92,8 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
 bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	       struct kvm_memory_slot *slot, unsigned int pte_access,
 	       gfn_t gfn, kvm_pfn_t pfn, u64 old_spte, bool prefetch,
-	       bool can_unsync, bool host_writable, u64 *new_spte)
+	       bool can_unsync, bool host_writable, bool ad_need_write_protect,
+	       u64 *new_spte)
 {
 	int level = sp->role.level;
 	u64 spte = SPTE_MMU_PRESENT_MASK;
@@ -100,7 +101,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 
 	if (sp->role.ad_disabled)
 		spte |= SPTE_TDP_AD_DISABLED_MASK;
-	else if (kvm_vcpu_ad_need_write_protect(vcpu))
+	else if (ad_need_write_protect)
 		spte |= SPTE_TDP_AD_WRPROT_ONLY_MASK;
 
 	/*
@@ -195,8 +196,11 @@ bool vcpu_make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 		    gfn_t gfn, kvm_pfn_t pfn, u64 old_spte, bool prefetch,
 		    bool can_unsync, bool host_writable, u64 *new_spte)
 {
+	bool ad_need_write_protect = kvm_vcpu_ad_need_write_protect(vcpu);
+
 	return make_spte(vcpu, sp, slot, pte_access, gfn, pfn, old_spte,
-			 prefetch, can_unsync, host_writable, new_spte);
+			 prefetch, can_unsync, host_writable,
+			 ad_need_write_protect, new_spte);
 
 }
 
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 14f18082d505..bcf58602f224 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -332,7 +332,8 @@ static inline u64 get_mmio_spte_generation(u64 spte)
 bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	       struct kvm_memory_slot *slot, unsigned int pte_access,
 	       gfn_t gfn, kvm_pfn_t pfn, u64 old_spte, bool prefetch,
-	       bool can_unsync, bool host_writable, u64 *new_spte);
+	       bool can_unsync, bool host_writable, bool ad_need_write_protect,
+	       u64 *new_spte);
 bool vcpu_make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 		    struct kvm_memory_slot *slot,
 		    unsigned int pte_access, gfn_t gfn, kvm_pfn_t pfn,
-- 
2.34.0.rc1.387.gb447b232ab-goog

