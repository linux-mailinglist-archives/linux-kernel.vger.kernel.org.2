Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B003369E45
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244275AbhDXA46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244198AbhDXAzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:55:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FA4C061243
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s34-20020a252d620000b02904e34d3a48abso26210839ybe.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=R43ABUZ9/Fi53IKsY58euoL+dVYl7LoEC4YFNOGoqao=;
        b=gXjNOqK1L7vM4ncBy6xohX2vvBi4KwcgSkBOQa8L7aBPQfp16D1WJmCV/jdeojHOb3
         +DSylbvxS8KAgWscv86gsTLDKq3gjRiTy4ihusv4PEreJ42QGVxpCDxewRnMBBTJuBAy
         HFzGOqeuT3p+ktZJ6FljmDgd6X3hNhSgFY692LBEoiE4EsJmf2ceP9tNJ5CbIbmqHM9n
         KkFsE7lyGMYLmTWoYraea9HlpCHVi4V0P2ptJBwM9pft6TPEpT4kUgdOXrLEJJV/bIVA
         uYGiCZ1YyGIVzV5bglKD3vQhbGUIPZdbEMjV1hh4fEZgbJvuQwLIeQ/K6gRcPp5SLPPx
         1dvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=R43ABUZ9/Fi53IKsY58euoL+dVYl7LoEC4YFNOGoqao=;
        b=UKxe5L0Awk/XJ2vKGZI3IJEX/tnfJqJy8CT55OZxnBpabOkp1PFd2QWwKvoskNDS7t
         SsSTKKoA5y9J4GTcZxopHlLMsyk4/0RBMAau0xVi73fe31usdzcCF87cv/7YIOCSk6wH
         DC8XMtiwvbmUD5Kw2AqVCGUVukFW7c/iPCCGQjZe0XEulISgXaSdP0yjBpp+kgBYev/A
         ls6mPrCjiqRwXD93B18RJ1EqQcdwDgcR52Ef5ZbiJzw8H8Su6hvsCwUMOvun6TE1QxlP
         jSiW5U6EyDyk5P3A/FbVOGF8JYofB94h8X0/7uJJp+sBvTlDA/DCUuCPLGQLVwLmEfQh
         zotA==
X-Gm-Message-State: AOAM533s2W1KN0X/EbnVufB6L+heJg22ISfkHdqMgFzUbApecNR2sKU/
        LY1set8l3UkX/UFxNv3xoQ4TXzRAiVw=
X-Google-Smtp-Source: ABdhPJzPKy+rI/zbpn2Xldk6fWBp/khBlsJXC/ketf7A0l2T/NPalRCb7nmHR5GXqtN+0kehgINMCJzse5Q=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a25:840c:: with SMTP id u12mr9012245ybk.345.1619225315623;
 Fri, 23 Apr 2021 17:48:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:45 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-44-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 43/43] KVM: x86: Drop pointless @reset_roots from kvm_init_mmu()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the @reset_roots param from kvm_init_mmu(), the one user,
kvm_mmu_reset_context() has already unloaded the MMU and thus freed and
invalidated all roots.  This also happens to be why the reset_roots=true
paths doesn't leak roots; they're already invalid.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu.h        |  2 +-
 arch/x86/kvm/mmu/mmu.c    | 13 ++-----------
 arch/x86/kvm/svm/nested.c |  2 +-
 arch/x86/kvm/vmx/nested.c |  2 +-
 4 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 88d0ed5225a4..63b49725fb24 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -65,7 +65,7 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_exec_only);
 void
 reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu, struct kvm_mmu *context);
 
-void kvm_init_mmu(struct kvm_vcpu *vcpu, bool reset_roots);
+void kvm_init_mmu(struct kvm_vcpu *vcpu);
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4, u32 efer,
 			     gpa_t nested_cr3);
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 930ac8a7e7c9..ff3e200b32dd 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4793,17 +4793,8 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu)
 	update_last_nonleaf_level(vcpu, g_context);
 }
 
-void kvm_init_mmu(struct kvm_vcpu *vcpu, bool reset_roots)
+void kvm_init_mmu(struct kvm_vcpu *vcpu)
 {
-	if (reset_roots) {
-		uint i;
-
-		vcpu->arch.mmu->root_hpa = INVALID_PAGE;
-
-		for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
-			vcpu->arch.mmu->prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
-	}
-
 	if (mmu_is_nested(vcpu))
 		init_kvm_nested_mmu(vcpu);
 	else if (tdp_enabled)
@@ -4829,7 +4820,7 @@ kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu)
 void kvm_mmu_reset_context(struct kvm_vcpu *vcpu)
 {
 	kvm_mmu_unload(vcpu);
-	kvm_init_mmu(vcpu, true);
+	kvm_init_mmu(vcpu);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_reset_context);
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 540d43ba2cf4..a0b48a8f32ed 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -406,7 +406,7 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 	vcpu->arch.cr3 = cr3;
 	kvm_register_mark_available(vcpu, VCPU_EXREG_CR3);
 
-	kvm_init_mmu(vcpu, false);
+	kvm_init_mmu(vcpu);
 
 	return 0;
 }
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9dcdf158a405..3a5b86932a5e 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1137,7 +1137,7 @@ static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3, bool ne
 	vcpu->arch.cr3 = cr3;
 	kvm_register_mark_available(vcpu, VCPU_EXREG_CR3);
 
-	kvm_init_mmu(vcpu, false);
+	kvm_init_mmu(vcpu);
 
 	return 0;
 }
-- 
2.31.1.498.g6c1eba8ee3d-goog

