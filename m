Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DDB3C74CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbhGMQhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbhGMQhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:37:11 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD64C061787
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:14 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 81-20020a370b540000b02903b854c43335so6619399qkl.21
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=vZPov19t8seutNZvZmmF4+o9jQkrFF2KtkeJS46Aq18=;
        b=VopMNO7HNEXA8hUjPdJmij4fABMuFmfzYYgItGc0441FQi4C11HDt5fH9s88dy6jaK
         lf2Ks3MiNV/S8wXOU85/kDoApjMfT9uLCwAvyGvMoFpAKZ6mk4iLcp4WYs8PK51S0hpE
         VQhlrRGpvcXODsgUOONai0ZNyBlekD0bDh6ZjgGYjEVGHgNnDCA5oPvVjzX+E/HqooXx
         sgiDsSkVVgMYkfs/z/CxT1tn3X+rKDFbL6RgOVkH97VE3WtZHis00v8RpEllvHe/LBg4
         N5qJveL998nOtOCGNtZUuKUBlZqVHfkeXncK7+8PUih743LvR3eADLKkfLREijOz6ayR
         P6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=vZPov19t8seutNZvZmmF4+o9jQkrFF2KtkeJS46Aq18=;
        b=s/5fowzfGd1JcOyQgNbe61TajjvyeegQ/MT8sEUJ7HwvuIW7uxUNq6cSlZCGyYTqcl
         NE9ON2o74fBgQJIAYHzYbRcvaJ5SWqusTfsWrh5A9nadxgfCQVKCp9o6rD5npLPeT5sc
         Eq8H8DOy1djcd21ld9hUnmfHcuyMNNplbt1ro4frX05w09/Kky5/z5hP+AhIfEuF7v98
         Dp1xZv+L+DRioVAvVL4Fcyn0yZ5oYTLyDR9nU4qkYPVmXfMUqQqr2IKkNledKRag8Ner
         HsFEKpCdzxQJEEJpavgf+X6mo3KYvg12sLtPiHZxPhCWPaeh8u70XzCoxfuekTHxfB0n
         eiUQ==
X-Gm-Message-State: AOAM530YgA0L8+L5zwMTVRITvEh/IVgyrhqITGXlhNc7ZhTvpwqH72vn
        rj2jdECS4coPC43vVnK1uVv7gItc4rk=
X-Google-Smtp-Source: ABdhPJxTBvC2/uhRrFcuw3Dvu3wtq6/KTPvhO8/hFY8KAScEIlI7/pKb9QNOKEf+W8kvdnqsw1bCV2USwJA=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a0c:ff48:: with SMTP id y8mr5643746qvt.29.1626194053767;
 Tue, 13 Jul 2021 09:34:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:32:59 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-22-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 21/46] KVM: VMX: Invert handling of CR0.WP for EPT without
 unrestricted guest
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Opt-in to forcing CR0.WP=1 for shadow paging, and stop lying about WP
being "always on" for unrestricted guest.  In addition to making KVM a
wee bit more honest, this paves the way for additional cleanup.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f506b94539ab..02aec75ec6f6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -136,8 +136,7 @@ module_param(allow_smaller_maxphyaddr, bool, S_IRUGO);
 #define KVM_VM_CR0_ALWAYS_OFF (X86_CR0_NW | X86_CR0_CD)
 #define KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST X86_CR0_NE
 #define KVM_VM_CR0_ALWAYS_ON				\
-	(KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST | 	\
-	 X86_CR0_WP | X86_CR0_PG | X86_CR0_PE)
+	(KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST | X86_CR0_PG | X86_CR0_PE)
 
 #define KVM_VM_CR4_ALWAYS_ON_UNRESTRICTED_GUEST X86_CR4_VMXE
 #define KVM_PMODE_VM_CR4_ALWAYS_ON (X86_CR4_PAE | X86_CR4_VMXE)
@@ -2995,9 +2994,7 @@ void ept_save_pdptrs(struct kvm_vcpu *vcpu)
 	kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
 }
 
-static void ept_update_paging_mode_cr0(unsigned long *hw_cr0,
-					unsigned long cr0,
-					struct kvm_vcpu *vcpu)
+static void ept_update_paging_mode_cr0(unsigned long cr0, struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -3016,9 +3013,6 @@ static void ept_update_paging_mode_cr0(unsigned long *hw_cr0,
 		vcpu->arch.cr0 = cr0;
 		vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
 	}
-
-	if (!(cr0 & X86_CR0_WP))
-		*hw_cr0 &= ~X86_CR0_WP;
 }
 
 void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
@@ -3031,6 +3025,8 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 		hw_cr0 |= KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST;
 	else {
 		hw_cr0 |= KVM_VM_CR0_ALWAYS_ON;
+		if (!enable_ept)
+			hw_cr0 |= X86_CR0_WP;
 
 		if (vmx->rmode.vm86_active && (cr0 & X86_CR0_PE))
 			enter_pmode(vcpu);
@@ -3049,7 +3045,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 #endif
 
 	if (enable_ept && !is_unrestricted_guest(vcpu))
-		ept_update_paging_mode_cr0(&hw_cr0, cr0, vcpu);
+		ept_update_paging_mode_cr0(cr0, vcpu);
 
 	vmcs_writel(CR0_READ_SHADOW, cr0);
 	vmcs_writel(GUEST_CR0, hw_cr0);
-- 
2.32.0.93.g670b81a890-goog

