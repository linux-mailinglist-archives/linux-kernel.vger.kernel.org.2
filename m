Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B053B0C12
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhFVSBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhFVSBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:01:17 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7481C06114A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:58:35 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w3-20020ac80ec30000b029024e8c2383c1so98135qti.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=QSqv+w39xe1F0DIgRTvyqG5XP+AuLOEkvmdHnfG0H3g=;
        b=hsyQ3lcL2d9ASWwXD1yqXR6tjA2lEHul6PC1aLlT0mqXYWU722Afpxe8/b2ZCV7tnR
         S+vjGxp57jxXOteMQy2VSqJYxv2M6o8ulQwLwrFElNVmoqsAwIDcuJexv9Jerpb8qCQm
         d1Ji0dqMYjVwmiScuFiK2zLyqyyO8oxGICUkxuhcCyV91RyFgdptUV4Ue4MM/2qkiu09
         R9snveLgqVZHgg175XAXfpO2031f7+uN61uEyRY5c49WJIhNtJthbZ4BCJTErQ6MJplx
         FR5To3mRB/QN7vr6MOPaIGR2nEwfI/OJE6Qz7w7i38NIevPhibiqSC1s4uy9wmtVjAtk
         DIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=QSqv+w39xe1F0DIgRTvyqG5XP+AuLOEkvmdHnfG0H3g=;
        b=aD9P+WIJdOJgitszC/h9m2RaUvILOPNkxDjfJnny2PnoF5e//9NqbwDm5SKmK0c0qB
         FIMibJbDj0AP/hNAGl7KEDiYV6/Yt5/Ttma40jvJeIFWhbjCZUc4bscu8JnDHMNNDCXC
         cZkWeSpcjjgANnkaXlTzwmuXsdq+ybqTcDtpApyHRphziRAlxsShsfXqiyFYyPN2UXr3
         LhacL2ojynOQT+5IoB+6BVoMOoR/28qmk4Hfv3s4KzR7LNWP1vznGNzJtRR9Z2B+InG5
         6P0Nvgf5oyhNM536rbTN+l7W1nboy87pCsO02qOzuLC+mdxtrZmXaH88mZX1b6o0O+WC
         C9yw==
X-Gm-Message-State: AOAM531ZvPkbZBootGStT+QjMfWdUNU/qznO33glF9ZfmP2C4zGq1edz
        j0MRN3zvvwO/ZKINfb2C9UHjpPHPtv0=
X-Google-Smtp-Source: ABdhPJyC8b7MOHAhw56pTNKP4xt7DE193oymRVmJEkB/uOjizB43RS24onuhynJYRajX7hHLfAgZZpfyKg4=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:5722:92ce:361f:3832])
 (user=seanjc job=sendgmr) by 2002:a05:6214:80c:: with SMTP id
 df12mr9849qvb.18.1624384714932; Tue, 22 Jun 2021 10:58:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 10:57:02 -0700
In-Reply-To: <20210622175739.3610207-1-seanjc@google.com>
Message-Id: <20210622175739.3610207-18-seanjc@google.com>
Mime-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 17/54] KVM: x86: Read and pass all CR0/CR4 role bits to shadow
 MMU helper
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

Grab all CR0/CR4 MMU role bits from current vCPU state when initializing
a non-nested shadow MMU.  Extract the masks from kvm_post_set_cr{0,4}(),
as the CR0/CR4 update masks must exactly match the mmu_role bits, with
one exception (see below).  The "full" CR0/CR4 will be used by future
commits to initialize the MMU and its role, as opposed to the current
approach of pulling everything from vCPU, which is incorrect for certain
flows, e.g. nested NPT.

CR4.LA57 is an exception, as it can be toggled on VM-Exit (for L1's MMU)
but can't be toggled via MOV CR4 while long mode is active.  I.e. LA57
needs to be in the mmu_role, but technically doesn't need to be checked
by kvm_post_set_cr4().  However, the extra check is completely benign as
the hardware restrictions simply mean LA57 will never be _the_ cause of
a MMU reset during MOV CR4.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu.h     | 6 ++++++
 arch/x86/kvm/mmu/mmu.c | 4 ++--
 arch/x86/kvm/x86.c     | 9 ++-------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 47131b92b990..4e926f4935b0 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -44,6 +44,12 @@
 #define PT32_ROOT_LEVEL 2
 #define PT32E_ROOT_LEVEL 3
 
+#define KVM_MMU_CR4_ROLE_BITS (X86_CR4_PGE | X86_CR4_PSE | X86_CR4_PAE | \
+			       X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_PKE | \
+			       X86_CR4_LA57)
+
+#define KVM_MMU_CR0_ROLE_BITS (X86_CR0_PG | X86_CR0_WP)
+
 static __always_inline u64 rsvd_bits(int s, int e)
 {
 	BUILD_BUG_ON(__builtin_constant_p(e) && __builtin_constant_p(s) && e < s);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ca7680d1ea24..02c54426e7a2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4778,8 +4778,8 @@ static void init_kvm_softmmu(struct kvm_vcpu *vcpu)
 	struct kvm_mmu *context = &vcpu->arch.root_mmu;
 
 	kvm_init_shadow_mmu(vcpu,
-			    kvm_read_cr0_bits(vcpu, X86_CR0_PG),
-			    kvm_read_cr4_bits(vcpu, X86_CR4_PAE),
+			    kvm_read_cr0_bits(vcpu, KVM_MMU_CR0_ROLE_BITS),
+			    kvm_read_cr4_bits(vcpu, KVM_MMU_CR4_ROLE_BITS),
 			    vcpu->arch.efer);
 
 	context->get_guest_pgd     = get_cr3;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2d3b9f10b14a..cdce4b134bef 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -832,14 +832,12 @@ EXPORT_SYMBOL_GPL(load_pdptrs);
 
 void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0)
 {
-	unsigned long update_bits = X86_CR0_PG | X86_CR0_WP;
-
 	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
 		kvm_clear_async_pf_completion_queue(vcpu);
 		kvm_async_pf_hash_reset(vcpu);
 	}
 
-	if ((cr0 ^ old_cr0) & update_bits)
+	if ((cr0 ^ old_cr0) & KVM_MMU_CR0_ROLE_BITS)
 		kvm_mmu_reset_context(vcpu);
 
 	if (((cr0 ^ old_cr0) & X86_CR0_CD) &&
@@ -1018,10 +1016,7 @@ EXPORT_SYMBOL_GPL(kvm_is_valid_cr4);
 
 void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned long cr4)
 {
-	unsigned long mmu_role_bits = X86_CR4_PGE | X86_CR4_PSE | X86_CR4_PAE |
-				      X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_PKE;
-
-	if (((cr4 ^ old_cr4) & mmu_role_bits) ||
+	if (((cr4 ^ old_cr4) & KVM_MMU_CR4_ROLE_BITS) ||
 	    (!(cr4 & X86_CR4_PCIDE) && (old_cr4 & X86_CR4_PCIDE)))
 		kvm_mmu_reset_context(vcpu);
 }
-- 
2.32.0.288.g62a8d224e6-goog

