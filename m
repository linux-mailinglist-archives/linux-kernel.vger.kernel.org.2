Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D113036778A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhDVCjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbhDVCjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:39:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377D4C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:38:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so18307404ybo.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=xbd22aCtQRBPSIBux5x1ONfW3mzcaq+9oc3GdPhDL5A=;
        b=CQNZmCRn6tjpHmZXXODOgrYWhlhpa5V8QSPvAOYAmgGvNfkkZr0U7ML3JW+RkPYPPY
         +1rAfFq+0zB61kdoNZlgZM63U2qHKsUK9NzCEPuV0c4YwnmL4ih52ThlPHMCCxxHrwNr
         FeDr2TYhk3INAUrrQHwLF6HjW6P/uutql80C6h6UOlBP2xcWNtfYCXQd6Xa27tNRDVcH
         0tX/Y/0d79FaHQ654iTuI+fGRFAR6+QkXJIkoqTEMELekTkH8QWtjCgRL+him5ULG9Di
         DFoeWvq+L4DD0d9Qbo3aF/lyG9vG36/HovZbCetSNI1sJd7xA01c5R7D/ycfMcHzWw1r
         VKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=xbd22aCtQRBPSIBux5x1ONfW3mzcaq+9oc3GdPhDL5A=;
        b=CjrvHqjr0ugqOdOxLMAG9dpifLja3uq9lrB2L07eLi9//REESD5ZV3tCX4KBxP9rV9
         LwciJBpead/+QgFNefxYE5Bk6khfSh3TwiEzN6A0LnjgEWxX8cMiLGjpmQlMQTSY799p
         lCeX+BpLARoVA0hEQNKJOE/HYtjBXVD3uBj3KMO01PP1pBkTtFRqgiou99ncgKC2jzjg
         WkuG0Ud1xb+WaGeeAdS2ZcDYx40U9AWjk3t4HZ07xNzhffEjHbn+/LCFxcgpXFooQOtB
         DdGGOeusbNHGQPaDhNgxJneLwJj2iX2kvw691zx+UZCy7IQm7KKNNe3JuBLQWPCNDsS6
         KE4g==
X-Gm-Message-State: AOAM5338ixOGWINjHP8eCiCsT5za76f6An5BbHBwO1sg+Sx9PoJL+n7D
        gjJfYKNJqVgD33dmyNXz5bXPliK+gUE=
X-Google-Smtp-Source: ABdhPJzDJe6RG1R6CFv4PyI3kz6h2OZBhalOq3sWRQX107uJCy6Z9sEu6/7T5WqnCSiXcRX/RnlUnwRfW6o=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e012:374c:592:6194])
 (user=seanjc job=sendgmr) by 2002:a25:2fc5:: with SMTP id v188mr1593060ybv.140.1619059114437;
 Wed, 21 Apr 2021 19:38:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Apr 2021 19:38:31 -0700
Message-Id: <20210422023831.3473491-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH] KVM: VMX: Intercept FS/GS_BASE MSR accesses for 32-bit KVM
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

Disable pass-through of the FS and GS base MSRs for 32-bit KVM.  Intel's
SDM unequivocally states that the MSRs exist if and only if the CPU
supports x86-64.  FS_BASE and GS_BASE are mostly a non-issue; a clever
guest could opportunistically use the MSRs without issue.  KERNEL_GS_BASE
is a bigger problem, as a clever guest would subtly be broken if it were
migrated, as KVM disallows software access to the MSRs, and unlike the
direct variants, KERNEL_GS_BASE needs to be explicitly migrated as it's
not captured in the VMCS.

Fixes: 25c5f225beda ("KVM: VMX: Enable MSR Bitmap feature")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Note, this breaks kvm-unit-tests on 32-bit KVM VMX due to the boot code
using WRMSR(MSR_GS_BASE).  But, the tests are already broken on SVM, and
have always been broken on SVM, which is honestly the main reason I
didn't just turn a blind eye.  :-)  I post the fix shortly.

 arch/x86/kvm/vmx/nested.c | 2 ++
 arch/x86/kvm/vmx/vmx.c    | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8b111682fe5c..0f8c118ebc35 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -614,6 +614,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	}
 
 	/* KVM unconditionally exposes the FS/GS base MSRs to L1. */
+#ifdef CONFIG_X86_64
 	nested_vmx_disable_intercept_for_msr(msr_bitmap_l1, msr_bitmap_l0,
 					     MSR_FS_BASE, MSR_TYPE_RW);
 
@@ -622,6 +623,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 
 	nested_vmx_disable_intercept_for_msr(msr_bitmap_l1, msr_bitmap_l0,
 					     MSR_KERNEL_GS_BASE, MSR_TYPE_RW);
+#endif
 
 	/*
 	 * Checking the L0->L1 bitmap is trying to verify two things:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6501d66167b8..b58dc2d454f1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -157,9 +157,11 @@ static u32 vmx_possible_passthrough_msrs[MAX_POSSIBLE_PASSTHROUGH_MSRS] = {
 	MSR_IA32_SPEC_CTRL,
 	MSR_IA32_PRED_CMD,
 	MSR_IA32_TSC,
+#ifdef CONFIG_X86_64
 	MSR_FS_BASE,
 	MSR_GS_BASE,
 	MSR_KERNEL_GS_BASE,
+#endif
 	MSR_IA32_SYSENTER_CS,
 	MSR_IA32_SYSENTER_ESP,
 	MSR_IA32_SYSENTER_EIP,
@@ -6969,9 +6971,11 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
 	bitmap_fill(vmx->shadow_msr_intercept.write, MAX_POSSIBLE_PASSTHROUGH_MSRS);
 
 	vmx_disable_intercept_for_msr(vcpu, MSR_IA32_TSC, MSR_TYPE_R);
+#ifdef CONFIG_X86_64
 	vmx_disable_intercept_for_msr(vcpu, MSR_FS_BASE, MSR_TYPE_RW);
 	vmx_disable_intercept_for_msr(vcpu, MSR_GS_BASE, MSR_TYPE_RW);
 	vmx_disable_intercept_for_msr(vcpu, MSR_KERNEL_GS_BASE, MSR_TYPE_RW);
+#endif
 	vmx_disable_intercept_for_msr(vcpu, MSR_IA32_SYSENTER_CS, MSR_TYPE_RW);
 	vmx_disable_intercept_for_msr(vcpu, MSR_IA32_SYSENTER_ESP, MSR_TYPE_RW);
 	vmx_disable_intercept_for_msr(vcpu, MSR_IA32_SYSENTER_EIP, MSR_TYPE_RW);
-- 
2.31.1.498.g6c1eba8ee3d-goog

