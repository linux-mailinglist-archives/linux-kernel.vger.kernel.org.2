Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CAC3B0C15
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhFVSCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbhFVSBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:01:25 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FFFC06124C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:58:38 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 44-20020aed30af0000b029024e8ccfcd07so70863qtf.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=HZb8OLBJZDPapTr8/JRwbfQg/ysQN+FOOKZXN2ZmDnI=;
        b=c7dMyoiY/YzDEAKBg8tlk7JQ02rmJ1AdEoobUEXudHruDHKI/JkxZ9CR8dfiJc8Rhi
         NXSnzi6uOe1DgGKrWhdalFNfWnVpZzsrLSCKsuS/98veGOHM+XAIP4/84MkyewEBCKCO
         2SDdrwYfZHSCjnkHyTRrKHVD8PWZBYxbu/0V7dvsp98iUFy2N4isELd0FrREpRkEJomA
         eiPjwTryx8lkmRcQaBcc3HAcyFfGq8Ncn3Sb83lkHKPRSTUdHXPkiw/9hKrZyNY66MFm
         f3GneBwdKCJdi5m763xtRYqXeJKQDTWVTVqsW5BmwEdXRaGs6rGUOnPZaCIlHG82esui
         mhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=HZb8OLBJZDPapTr8/JRwbfQg/ysQN+FOOKZXN2ZmDnI=;
        b=N1nQzThBVbF4KnyOPhbEGUG+i/iPSUwUxQTLUOovlUSNAl2oWER1LGpjfQ4n7ULYLk
         1wpLjWdlu5g9f5hxwvtrkMyyLnALR6Sly+us0CaOxgfbDkCWbDLeKTknipo3izwMrPna
         7mkWYfD6KSCy8QNZ3f1Nlgw/+i28gZ2I0ucYc13aPrURVuOlmjZBH0Ju6/dMN1c+Ng+U
         GVvKVZSWi7fF0uG1T46oxCHTXMeKMc50ky4JQkKdHfAZsPmzguB4ygs4/Oj95EnhEeeM
         dJU7UU5tH6B3OPJTapiMrmhuhSVc3A690XLvpUJ6v9mKxFIuN0LYQqbjC6/JJk5lzwX0
         By5A==
X-Gm-Message-State: AOAM530pNqYFDbqmWPW/CUGDXTsxbThigCaL6G9d/f4tJzwQsQcFy318
        LKFIHrj2U75hJlOAlYeCZPRwlYxzRbE=
X-Google-Smtp-Source: ABdhPJyjOS840Dh66sh9kYKMVYAWYWMwlpDlLvqiyp18elHTQEQDjLfdQVgO9tcRkn3CX4oLl9ZARYaeIsQ=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:5722:92ce:361f:3832])
 (user=seanjc job=sendgmr) by 2002:a25:df82:: with SMTP id w124mr6162687ybg.425.1624384717363;
 Tue, 22 Jun 2021 10:58:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 10:57:03 -0700
In-Reply-To: <20210622175739.3610207-1-seanjc@google.com>
Message-Id: <20210622175739.3610207-19-seanjc@google.com>
Mime-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 18/54] KVM: x86/mmu: Move nested NPT reserved bit calculation
 into MMU proper
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move nested NPT's invocation of reset_shadow_zero_bits_mask() into the
MMU proper and unexport said function.  Aside from dropping an export,
this is a baby step toward eliminating the call entirely by fixing the
shadow_root_level confusion.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu.h        |  3 ---
 arch/x86/kvm/mmu/mmu.c    | 11 ++++++++---
 arch/x86/kvm/svm/nested.c |  1 -
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 4e926f4935b0..62844bacd13f 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -68,9 +68,6 @@ static __always_inline u64 rsvd_bits(int s, int e)
 void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 mmio_mask, u64 access_mask);
 void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_exec_only);
 
-void
-reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu, struct kvm_mmu *context);
-
 void kvm_init_mmu(struct kvm_vcpu *vcpu);
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 			     unsigned long cr4, u64 efer, gpa_t nested_cr3);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 02c54426e7a2..5a46a87b23b0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4212,8 +4212,8 @@ static inline u64 reserved_hpa_bits(void)
  * table in guest or amd nested guest, its mmu features completely
  * follow the features in guest.
  */
-void
-reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu, struct kvm_mmu *context)
+static void reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu,
+					struct kvm_mmu *context)
 {
 	/*
 	 * KVM uses NX when TDP is disabled to handle a variety of scenarios,
@@ -4247,7 +4247,6 @@ reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu, struct kvm_mmu *context)
 	}
 
 }
-EXPORT_SYMBOL_GPL(reset_shadow_zero_bits_mask);
 
 static inline bool boot_cpu_is_amd(void)
 {
@@ -4714,6 +4713,12 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 		 */
 		context->shadow_root_level = new_role.base.level;
 	}
+
+	/*
+	 * Redo the shadow bits, the reset done by shadow_mmu_init_context()
+	 * (above) may use the wrong shadow_root_level.
+	 */
+	reset_shadow_zero_bits_mask(vcpu, context);
 }
 EXPORT_SYMBOL_GPL(kvm_init_shadow_npt_mmu);
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 33b2f9337e26..927e545591c3 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -110,7 +110,6 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu->get_guest_pgd     = nested_svm_get_tdp_cr3;
 	vcpu->arch.mmu->get_pdptr         = nested_svm_get_tdp_pdptr;
 	vcpu->arch.mmu->inject_page_fault = nested_svm_inject_npf_exit;
-	reset_shadow_zero_bits_mask(vcpu, vcpu->arch.mmu);
 	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
 }
 
-- 
2.32.0.288.g62a8d224e6-goog

