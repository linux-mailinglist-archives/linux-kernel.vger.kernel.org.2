Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7631545286D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 04:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346028AbhKPDTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 22:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239050AbhKPDSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 22:18:01 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C839C03AA06
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:46:14 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id x1-20020a17090a294100b001a6e7ba6b4eso672227pjf.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B/yg4WcNXvfhHh1ItPHcVenAMSlZWjYxNfghv1yYukI=;
        b=pl+Kd1oXJAVEjvB89dWXf6GXeIfvHIeV4eJcSVU0kFDOHJWJTzn94+ovzfXffsNmtb
         DEkH8bQWR4muIMVj9JNk/SuvruwmfpRhyZFj7KRqFcpp3IFQ/iOdzG3S742aeaUNeWgw
         L3tpR1k86b7ccfFzNDzkRkzXnXsUjjYgfn9JsMp62NLLNet3Y4N+afvfrhC/fioSZ4Rj
         hEr4B97NTyUtdFVrNTno4KsfypUPLVs2WlJ+U4bhVcYbjTE44CYxo56+/9q+nbk4W0BV
         aT/0CKNdaojgzkvkN16UURCgY/acGBgMPUrr1tNPBNuYTk+d6iwyyCsnofezOR6UWRsq
         tF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B/yg4WcNXvfhHh1ItPHcVenAMSlZWjYxNfghv1yYukI=;
        b=nquL531JbBTnHCTK6ReEXmfAj8rKETavDvV5tyCPiTHhbGm/tpfLva/HLDP9oUKayS
         alMC2jEd8ViTVofbtkeqmGimvV/mG1H7+nJAakdgSTs/eDXmN12TDDNGvtzqUa0bYBUl
         egtoRL1pzr8Aket4GNcoaYCbfarO8jDe3QtsKuEfarwL7j3bcVZQgqDA/2g76J6Ov5lF
         lL6NfPcDLbzynSRd8T9eRMaHgJUVR3TkJ4xoGsmX0Lq9HJRQuThQ8D6seF7dKXEBvo0n
         wSPcsPJBn6mhwcoZFhPlgQX6hSI3tRfhStb2y2XmowQBzUikOenjUmZgZ6AJq7WOFZMv
         NhTg==
X-Gm-Message-State: AOAM532hpbEQIQ8Mm51nk+uSCcDTo2xuL3rPQ8nnFvRsnme3PFY7m98q
        qw6S29n5UGqP9HhUPEtsl66x8AbU+u86sAqmZpzzw4MMCpjTqdiWd4IVxWuJ4twke6/bN+94mZ7
        +dL00Mpw98Txek96UT/IJkLOM060q+klZDgV5g5LnMMbI3Ey2eDBHr+GAiqiwBLOBxnSfh4jH
X-Google-Smtp-Source: ABdhPJzKz0bnR7QOIvhoClp4ndlo0iYuOIa1p8rhT2RjGuaxk3gPe8aZ6ANw6hW6MpROrMaC9IpJmFO0sRWS
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:916d:2253:5849:9965])
 (user=bgardon job=sendgmr) by 2002:a65:5bc8:: with SMTP id
 o8mr1967862pgr.92.1637019973706; Mon, 15 Nov 2021 15:46:13 -0800 (PST)
Date:   Mon, 15 Nov 2021 15:45:52 -0800
In-Reply-To: <20211115234603.2908381-1-bgardon@google.com>
Message-Id: <20211115234603.2908381-5-bgardon@google.com>
Mime-Version: 1.0
References: <20211115234603.2908381-1-bgardon@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH 04/15] KVM: x86/mmu: Factor mt_mask out of make_spte
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

In service of removing the vCPU pointer from make_spte, factor the memory
type mask calculation out of make_spte.


Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/spte.c | 9 +++++----
 arch/x86/kvm/mmu/spte.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 3cf08a534a16..75c666d3e7f1 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -93,7 +93,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	       struct kvm_memory_slot *slot, unsigned int pte_access,
 	       gfn_t gfn, kvm_pfn_t pfn, u64 old_spte, bool prefetch,
 	       bool can_unsync, bool host_writable, bool ad_need_write_protect,
-	       u64 *new_spte)
+	       u64 mt_mask, u64 *new_spte)
 {
 	int level = sp->role.level;
 	u64 spte = SPTE_MMU_PRESENT_MASK;
@@ -130,8 +130,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	if (level > PG_LEVEL_4K)
 		spte |= PT_PAGE_SIZE_MASK;
 	if (tdp_enabled)
-		spte |= static_call(kvm_x86_get_mt_mask)(vcpu, gfn,
-			kvm_is_mmio_pfn(pfn));
+		spte |= mt_mask;
 
 	if (host_writable)
 		spte |= shadow_host_writable_mask;
@@ -197,10 +196,12 @@ bool vcpu_make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 		    bool can_unsync, bool host_writable, u64 *new_spte)
 {
 	bool ad_need_write_protect = kvm_vcpu_ad_need_write_protect(vcpu);
+	u64 mt_mask = static_call(kvm_x86_get_mt_mask)(vcpu, gfn,
+						       kvm_is_mmio_pfn(pfn));
 
 	return make_spte(vcpu, sp, slot, pte_access, gfn, pfn, old_spte,
 			 prefetch, can_unsync, host_writable,
-			 ad_need_write_protect, new_spte);
+			 ad_need_write_protect, mt_mask, new_spte);
 
 }
 
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index bcf58602f224..e739f2ebf844 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -333,7 +333,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	       struct kvm_memory_slot *slot, unsigned int pte_access,
 	       gfn_t gfn, kvm_pfn_t pfn, u64 old_spte, bool prefetch,
 	       bool can_unsync, bool host_writable, bool ad_need_write_protect,
-	       u64 *new_spte);
+	       u64 mt_mask, u64 *new_spte);
 bool vcpu_make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 		    struct kvm_memory_slot *slot,
 		    unsigned int pte_access, gfn_t gfn, kvm_pfn_t pfn,
-- 
2.34.0.rc1.387.gb447b232ab-goog

