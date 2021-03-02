Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAA032AD7C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837725AbhCBV6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581627AbhCBTA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 14:00:57 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F738C061A27
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:46:09 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id u8so15635410qvm.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=yssg349CIQcpusokJYUAbzu7BIQqlN4sh1bHcP1NJ8k=;
        b=ErDuGBDftepRR4OYZpswTC6tmPwDS8yB53aypu/42YKgFqbqnAGsFo+VNVcCZ98tS4
         LKYeb3A15u0xi54RX3uLZK9VBam6kPhbLVfbO5EPrsWM/7FM7i3Yjgo+2XZ1bjBKijR+
         QndDzLzFLHN1LcG72D2ixeApjOruIK06aBt6OZDWLC/cMvtAtrsOxRdIMSjkGC2+sfEg
         ToL/umXHkuxZv/yoymGi1+ngHX3ab3v4Eoa3T7M4Q0mPgm62xNCEpiwfqnQ5dFgF4yN8
         m/Kl/jX9s+X2zlJCc8RtK5/NIVo7V+zLDPwoL/VxV9id8H/4vMppnofbMplq7I5JhWIG
         Kcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=yssg349CIQcpusokJYUAbzu7BIQqlN4sh1bHcP1NJ8k=;
        b=P12A9Rku0CZfyVfszVC9gQus0g1KHjrDZ+wBrkHU7a/9Ojo2MxdsTs+dMq3B7wdL61
         dkiTp+XWIxaTWjSrKM5o1MdbE8pozB/XxiJc0RgLTTzgNehRvV+WtRrxJSrJtuNgqeEB
         YpDM0syge+2jeTBRYwL8Pthb3G/bg7msOtMngAUmfEd4UxqMn4s/+YCIrNP1xPJX8G40
         kbhGHELZUqriczjmIv+r1AsvEfhAB9C2X1UDR7c82ZkgKnX7b5/6nezKoGd7i4/V17dn
         hTgL52yUpUg4t4t9hueW8CKUTx4HpRpC/LyJTXizUxELWqiAZiGpH078hJ7RcdwMisAk
         o0xQ==
X-Gm-Message-State: AOAM530Cd7JC3JkJrhJ3uPIIy5ypEX7NpJoNQJ/VTWWOGDsydlcFPx1W
        YsLCOHa1j6GGNKq9fqP6APP6Cp2YVrI=
X-Google-Smtp-Source: ABdhPJyrDbObIs1DThtN5Ro3gDtAE1iGh/GjGP6Ti2k30XVBdhgm3at2LNs7pWUWgjLMUTKAU1r92bsSnm0=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:805d:6324:3372:6183])
 (user=seanjc job=sendgmr) by 2002:a0c:9ba4:: with SMTP id o36mr4947619qve.31.1614710768589;
 Tue, 02 Mar 2021 10:46:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  2 Mar 2021 10:45:34 -0800
In-Reply-To: <20210302184540.2829328-1-seanjc@google.com>
Message-Id: <20210302184540.2829328-10-seanjc@google.com>
Mime-Version: 1.0
References: <20210302184540.2829328-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 09/15] KVM: x86/mmu: Mark the PAE roots as decrypted for
 shadow paging
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the PAE roots used as decrypted to play nice with SME when KVM is
using shadow paging.  Explicitly skip setting the C-bit when loading
CR3 for PAE shadow paging, even though it's completely ignored by the
CPU.  The extra documentation is nice to have.

Note, there are several subtleties at play with NPT.  In addition to
legacy shadow paging, the PAE roots are used for SVM's NPT when either
KVM is 32-bit (uses PAE paging) or KVM is 64-bit and shadowing 32-bit
NPT.  However, 32-bit Linux, and thus KVM, doesn't support SME.  And
64-bit KVM can happily set the C-bit in CR3.  This also means that
keeping __sme_set(root) for 32-bit KVM when NPT is enabled is
conceptually wrong, but functionally ok since SME is 64-bit only.
Leave it as is to avoid unnecessary pollution.

Fixes: d0ec49d4de90 ("kvm/x86/svm: Support Secure Memory Encryption within KVM")
Cc: stable@vger.kernel.org
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 24 ++++++++++++++++++++++--
 arch/x86/kvm/svm/svm.c |  7 +++++--
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ddf1845f072e..45fe97b3b25d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -48,6 +48,7 @@
 #include <asm/memtype.h>
 #include <asm/cmpxchg.h>
 #include <asm/io.h>
+#include <asm/set_memory.h>
 #include <asm/vmx.h>
 #include <asm/kvm_page_track.h>
 #include "trace.h"
@@ -3313,8 +3314,9 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * tables are allocated and initialized at root creation as there is no
 	 * equivalent level in the guest's NPT to shadow.  Allocate the tables
 	 * on demand, as running a 32-bit L1 VMM is very rare.  Unlike 32-bit
-	 * NPT, the PDP table doesn't need to be in low mem.  Preallocate the
-	 * pages so that the PAE roots aren't leaked on failure.
+	 * NPT, the PDP table doesn't need to be in low mem, and doesn't need
+	 * to be decrypted.  Preallocate the pages so that the PAE roots aren't
+	 * leaked on failure.
 	 */
 	if (vcpu->arch.mmu->shadow_root_level == PT64_ROOT_4LEVEL &&
 	    (!vcpu->arch.mmu->pae_root || !vcpu->arch.mmu->lm_root)) {
@@ -5234,6 +5236,8 @@ slot_handle_leaf(struct kvm *kvm, struct kvm_memory_slot *memslot,
 
 static void free_mmu_pages(struct kvm_mmu *mmu)
 {
+	if (!tdp_enabled && mmu->pae_root)
+		set_memory_encrypted((unsigned long)mmu->pae_root, 1);
 	free_page((unsigned long)mmu->pae_root);
 	free_page((unsigned long)mmu->lm_root);
 }
@@ -5271,6 +5275,22 @@ static int __kvm_mmu_create(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
 	for (i = 0; i < 4; ++i)
 		mmu->pae_root[i] = 0;
 
+	/*
+	 * CR3 is only 32 bits when PAE paging is used, thus it's impossible to
+	 * get the CPU to treat the PDPTEs as encrypted.  Decrypt the page so
+	 * that KVM's writes and the CPU's reads get along.  Note, this is
+	 * only necessary when using shadow paging, as 64-bit NPT can get at
+	 * the C-bit even when shadowing 32-bit NPT, and SME isn't supported
+	 * by 32-bit kernels (when KVM itself uses 32-bit NPT).
+	 */
+	if (!tdp_enabled)
+		set_memory_decrypted((unsigned long)mmu->pae_root, 1);
+	else
+		WARN_ON_ONCE(shadow_me_mask);
+
+	for (i = 0; i < 4; ++i)
+		mmu->pae_root[i] = 0;
+
 	return 0;
 }
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 54610270f66a..4769cf8bf2fd 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3908,15 +3908,18 @@ static void svm_load_mmu_pgd(struct kvm_vcpu *vcpu, unsigned long root,
 	struct vcpu_svm *svm = to_svm(vcpu);
 	unsigned long cr3;
 
-	cr3 = __sme_set(root);
 	if (npt_enabled) {
-		svm->vmcb->control.nested_cr3 = cr3;
+		svm->vmcb->control.nested_cr3 = __sme_set(root);
 		vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
 
 		/* Loading L2's CR3 is handled by enter_svm_guest_mode.  */
 		if (!test_bit(VCPU_EXREG_CR3, (ulong *)&vcpu->arch.regs_avail))
 			return;
 		cr3 = vcpu->arch.cr3;
+	} else if (vcpu->arch.mmu->shadow_root_level >= PT64_ROOT_4LEVEL) {
+		cr3 = __sme_set(root);
+	} else {
+		cr3 = root;
 	}
 
 	svm->vmcb->save.cr3 = cr3;
-- 
2.30.1.766.gb4fecdf3b7-goog

