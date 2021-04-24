Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F6C369E10
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244593AbhDXAvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244476AbhDXAts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:49:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF3FC061364
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s2-20020a5b07420000b02904eb842efc40so26198052ybq.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ybux/4YslnMEYEZsvkcGPcqviW6S9OYK5jonptQyC4I=;
        b=n131qTWJCuWa04F4oe/3zu7xSR7HCmvR/RjU/3fY9RqKUdbO5EOJoN1M9/J4pd8A6J
         1E1lRubsGs7E2kBG1YxPkF4VPlN1Jn7mZd1l3+UUvHisjWJB+6SmEHaumw3zglONg9vX
         0NAgrjMgC5gAYnf89al/eiJPhFA/YwcYdoOe9Fd1TeBFkivvrtYlj3JC5WqB9C1kdObb
         OJZB4Yc2GB22sYAlYhzmfBz1r94xKrkPOgxFoON73t6nw9+6Yp+YtB20u768tvdkz310
         Pi7Wun0oZc0rel4564fvhXVkolzMGmGXIldyNEeX0NWOr450PnCTWY97ha2lJ4xyfQTK
         f/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ybux/4YslnMEYEZsvkcGPcqviW6S9OYK5jonptQyC4I=;
        b=WMr6lOzI8FyAxvivQ0L10tjEw0lj+h0nTkpU0U/hFe54XQriYWHoSYnh0LMHWhb2Z9
         ICPV7RA8MCV39JRQzXCXAflDM94TIS1JEsqyaWvThSwZ2J3Zy4Kw/e8FMRCrJ0D3j1UK
         KdumoqdgWm922bDXd8tTY0yMXuAl6WjDBF9cpUVZtDXEjHWTT9RwM3uCHoR4dfTXW+X7
         BToSfCvRBuPyYX5imCdi8IrDyk4k1FHgwRvS+TypkF3cNUdS7K1emBdHIGKZZaKRZZnf
         9Xr0M1gcZFyvmDlNdJWmxkVI/599jVBbcqX6JlNA8ZIihN/MbF0WtmkYz3rV+EgPbCa8
         x6cw==
X-Gm-Message-State: AOAM532UGba7zZMHXiX2hRTftOlAfbD99bXVGGD/bkHgsleIjrxWWkdV
        XLIf6zH3MvYkIIPHrqrl+ZP0s2ANlbI=
X-Google-Smtp-Source: ABdhPJyNpvOlFlK5nKkndMFN0zoAPRak6kIWE7dUUTmKDCl8k11TIMKl+UTWyXpWoIjH+UpQIIwz0khh63A=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a25:8143:: with SMTP id j3mr9160217ybm.237.1619225261741;
 Fri, 23 Apr 2021 17:47:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:21 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-20-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 19/43] KVM: x86: Move EDX initialization at vCPU RESET to
 common code
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

Move the EDX initialization at vCPU RESET, which is now identical between
VMX and SVM, into common code.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  5 -----
 arch/x86/kvm/svm/svm.c          | 13 -------------
 arch/x86/kvm/vmx/vmx.c          |  6 ------
 arch/x86/kvm/x86.c              | 13 +++++++++++++
 4 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3e5fc80a35c8..2b9799366dad 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1701,11 +1701,6 @@ static inline unsigned long read_msr(unsigned long msr)
 }
 #endif
 
-static inline u32 get_rdx_init_val(void)
-{
-	return 0x600; /* P6 family */
-}
-
 static inline void kvm_inject_gp(struct kvm_vcpu *vcpu, u32 error_code)
 {
 	kvm_queue_exception_e(vcpu, GP_VECTOR, error_code);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 271b6def087f..5c12ba725186 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1283,25 +1283,12 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	u32 dummy;
-	u32 eax = 1;
 
 	svm->spec_ctrl = 0;
 	svm->virt_spec_ctrl = 0;
 
 	init_vmcb(vcpu);
 
-	/*
-	 * Fall back to KVM's default Family/Model/Stepping if no CPUID match
-	 * is found.  Note, it's impossible to get a match at RESET since KVM
-	 * emulates RESET before exposing the vCPU to userspace, i.e. it's
-	 * impossible for kvm_cpuid() to find a valid entry on RESET.  But, go
-	 * through the motions in case that's ever remedied, and to be pedantic.
-	 */
-	if (!kvm_cpuid(vcpu, &eax, &dummy, &dummy, &dummy, true))
-		eax = get_rdx_init_val();
-	kvm_rdx_write(vcpu, eax);
-
 	if (kvm_vcpu_apicv_active(vcpu) && !init_event)
 		avic_update_vapic_bar(svm, APIC_DEFAULT_PHYS_BASE);
 }
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 40a4ac23d54f..805888541142 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4490,7 +4490,6 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u32 eax, dummy;
 	u64 cr0;
 
 	if (!init_event)
@@ -4501,11 +4500,6 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 
 	vmx->msr_ia32_umwait_control = 0;
 
-	eax = 1;
-	if (!kvm_cpuid(vcpu, &eax, &dummy, &dummy, &dummy, true))
-		eax = get_rdx_init_val();
-	kvm_rdx_write(vcpu, eax);
-
 	vmx->hv_deadline_tsc = -1;
 	kvm_set_cr8(vcpu, 0);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b87193190a73..167c650d1187 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10416,6 +10416,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 	unsigned long old_cr0 = kvm_read_cr0(vcpu);
 	unsigned long old_cr4 = kvm_read_cr4(vcpu);
+	u32 eax, dummy;
 
 	kvm_lapic_reset(vcpu, init_event);
 
@@ -10482,6 +10483,18 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	vcpu->arch.regs_avail = ~0;
 	vcpu->arch.regs_dirty = ~0;
 
+	/*
+	 * Fall back to KVM's default Family/Model/Stepping of 0x600 (P6/Athlon)
+	 * if no CPUID match is found.  Note, it's impossible to get a match at
+	 * RESET since KVM emulates RESET before exposing the vCPU to userspace,
+	 * i.e. it'simpossible for kvm_cpuid() to find a valid entry on RESET.
+	 * But, go through the motions in case that's ever remedied.
+	 */
+	eax = 1;
+	if (!kvm_cpuid(vcpu, &eax, &dummy, &dummy, &dummy, true))
+		eax = 0x600;
+	kvm_rdx_write(vcpu, eax);
+
 	vcpu->arch.ia32_xss = 0;
 
 	static_call(kvm_x86_vcpu_reset)(vcpu, init_event);
-- 
2.31.1.498.g6c1eba8ee3d-goog

