Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED27B32AC1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 22:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449517AbhCBVJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352105AbhCBSLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:11:12 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27753C0617AB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 09:45:22 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id 130so5285728qkm.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 09:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=5/elzHKwYLkN+eBkXoR3/tKQXe6bjPSZcc2tVPAsRfM=;
        b=C53i1Iy2d9Zgd7MgCcEDwZQOu6xidTY0b0GaaBJbnadm0fsfGrP0eKtLL9tvcjybZx
         NGnuax0zbTcAmgqwrtWlJF0y//QOBhsJYMiwmJu66peXwMMwlTahOfpkDU63HcCqpgBT
         Drb5F9f/bncYxCKH8ARMmYQBKxAa2d9xN8QNzcW1+38kzXcVDFyDT63M4YILj2ywx2D/
         COva0NkacrgkrndijEzjEcCW060nYABJT11gIJwPc5X0QL50fFSccXgQZLhSI7WCPO5j
         U/4QMuIbyg2nkolQbVA3NXLJ8iifjlSmnjkn5u5RJTyYu5JW44PCTntQCqgw9HY8HdO5
         WBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=5/elzHKwYLkN+eBkXoR3/tKQXe6bjPSZcc2tVPAsRfM=;
        b=QDxe0MimYSCyFkurnbuFFn47T5arhZiWagpDj9/DxbBpCBusNI4WA+3YJsNqcvFW8B
         Awi3w9Z5CAQV/Q0BB/e4YBSQtjMeAXmdWZtsOV3aBvg3jB/22LpZjIDY7OPCD5upgd8D
         pQNY7eY2ic/ks/eh1tAmiaGDb/mE3r7e69KLju0M032aSlmoxY5ipeIu/1uUNiZZTeeM
         YNZOvSU5vRGh2R9YXuXeeJRDOe5cJRp/9ZJPj2U6vEWFVsHsvl6QAY819v3HRoZ3aMi8
         xVxMIIwV1qvC5/ADl4MeuwpjGeX3DMK8T3yOBWxiag/mMZxTdzzUJ3VUAmM5F7tic2yP
         RAZQ==
X-Gm-Message-State: AOAM533gTWTYz5e2sSmrmy0/OCLAyQC+kNh523cItPPaLvIM4cXrBOnV
        H+OF1M8ZyKYcTsMhwjTmWZfmkS+1tj8=
X-Google-Smtp-Source: ABdhPJxdXnFWysaLU/7z5LU0knkvvvBO3bCJCwcjOeNkm4zHzKYCwnJH62bYpc12JdRgvL8NnZ82AXMqjEc=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:805d:6324:3372:6183])
 (user=seanjc job=sendgmr) by 2002:a0c:b894:: with SMTP id y20mr4551211qvf.43.1614707121201;
 Tue, 02 Mar 2021 09:45:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  2 Mar 2021 09:45:14 -0800
In-Reply-To: <20210302174515.2812275-1-seanjc@google.com>
Message-Id: <20210302174515.2812275-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210302174515.2812275-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 1/2] KVM: x86: Handle triple fault in L2 without killing L1
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synthesize a nested VM-Exit if L2 triggers an emulated triple fault
instead of exiting to userspace, which likely will kill L1.  Any flow
that does KVM_REQ_TRIPLE_FAULT is suspect, but the most common scenario
for L2 killing L1 is if L0 (KVM) intercepts a contributory exception that
is _not_intercepted by L1.  E.g. if KVM is intercepting #GPs for the
VMware backdoor, a #GP that occurs in L2 while vectoring an injected #DF
will cause KVM to emulate triple fault.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/lapic.c            |  2 +-
 arch/x86/kvm/svm/nested.c       | 14 ++++++++++++++
 arch/x86/kvm/vmx/nested.c       |  9 +++++++++
 arch/x86/kvm/x86.c              | 29 +++++++++++++++++++++++------
 arch/x86/kvm/x86.h              |  2 ++
 6 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6db60ea8ee5b..3668f38bad60 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1333,6 +1333,7 @@ struct kvm_x86_ops {
 struct kvm_x86_nested_ops {
 	int (*check_events)(struct kvm_vcpu *vcpu);
 	bool (*hv_timer_pending)(struct kvm_vcpu *vcpu);
+	void (*triple_fault)(struct kvm_vcpu *vcpu);
 	int (*get_state)(struct kvm_vcpu *vcpu,
 			 struct kvm_nested_state __user *user_kvm_nested_state,
 			 unsigned user_data_size);
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 45d40bfacb7c..9faed6e6960a 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2859,7 +2859,7 @@ void kvm_apic_accept_events(struct kvm_vcpu *vcpu)
 		return;
 
 	if (is_guest_mode(vcpu)) {
-		r = kvm_x86_ops.nested_ops->check_events(vcpu);
+		r = kvm_check_nested_events(vcpu);
 		if (r < 0)
 			return;
 		/*
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 90a1704b5752..93a61ed76e5b 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -671,6 +671,9 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	struct kvm_host_map map;
 	int rc;
 
+	/* Triple faults in L2 should never escape. */
+	WARN_ON_ONCE(kvm_check_request(KVM_REQ_TRIPLE_FAULT, vcpu));
+
 	rc = kvm_vcpu_map(vcpu, gpa_to_gfn(svm->nested.vmcb12_gpa), &map);
 	if (rc) {
 		if (rc == -EINVAL)
@@ -792,6 +795,16 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	return 0;
 }
 
+static void nested_svm_triple_fault(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	svm->vmcb->control.exit_code   = SVM_EXIT_SHUTDOWN;
+	svm->vmcb->control.exit_info_1 = 0;
+	svm->vmcb->control.exit_info_2 = 0;
+	nested_svm_vmexit(svm);
+}
+
 int svm_allocate_nested(struct vcpu_svm *svm)
 {
 	struct page *vmcb02_page;
@@ -1327,6 +1340,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 struct kvm_x86_nested_ops svm_nested_ops = {
 	.check_events = svm_check_nested_events,
+	.triple_fault = nested_svm_triple_fault,
 	.get_nested_state_pages = svm_get_nested_state_pages,
 	.get_state = svm_get_nested_state,
 	.set_state = svm_set_nested_state,
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index fdd80dd8e781..3493a48411a8 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4416,6 +4416,9 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	/* trying to cancel vmlaunch/vmresume is a bug */
 	WARN_ON_ONCE(vmx->nested.nested_run_pending);
 
+	/* Similarly, triple faults in L2 should never escape. */
+	WARN_ON_ONCE(kvm_check_request(KVM_REQ_TRIPLE_FAULT, vcpu));
+
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 
 	/* Service the TLB flush request for L2 before switching to L1. */
@@ -4552,6 +4555,11 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	vmx->fail = 0;
 }
 
+static void nested_vmx_triple_fault(struct kvm_vcpu *vcpu)
+{
+	nested_vmx_vmexit(vcpu, EXIT_REASON_TRIPLE_FAULT, 0, 0);
+}
+
 /*
  * Decode the memory-address operand of a vmx instruction, as recorded on an
  * exit caused by such an instruction (run by a guest hypervisor).
@@ -6593,6 +6601,7 @@ __init int nested_vmx_hardware_setup(int (*exit_handlers[])(struct kvm_vcpu *))
 struct kvm_x86_nested_ops vmx_nested_ops = {
 	.check_events = vmx_check_nested_events,
 	.hv_timer_pending = nested_vmx_preemption_timer_pending,
+	.triple_fault = nested_vmx_triple_fault,
 	.get_state = vmx_get_nested_state,
 	.set_state = vmx_set_nested_state,
 	.get_nested_state_pages = vmx_get_nested_state_pages,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 828de7d65074..11746f488f04 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8349,6 +8349,19 @@ static void update_cr8_intercept(struct kvm_vcpu *vcpu)
 	static_call(kvm_x86_update_cr8_intercept)(vcpu, tpr, max_irr);
 }
 
+int kvm_check_nested_events(struct kvm_vcpu *vcpu)
+{
+	if (WARN_ON_ONCE(!is_guest_mode(vcpu)))
+		return -EIO;
+
+	if (kvm_check_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
+		kvm_x86_ops.nested_ops->triple_fault(vcpu);
+		return 1;
+	}
+
+	return kvm_x86_ops.nested_ops->check_events(vcpu);
+}
+
 static void kvm_inject_exception(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.exception.error_code && !is_protmode(vcpu))
@@ -8401,7 +8414,7 @@ static void inject_pending_event(struct kvm_vcpu *vcpu, bool *req_immediate_exit
 	 * from L2 to L1.
 	 */
 	if (is_guest_mode(vcpu)) {
-		r = kvm_x86_ops.nested_ops->check_events(vcpu);
+		r = kvm_check_nested_events(vcpu);
 		if (r < 0)
 			goto busy;
 	}
@@ -8964,10 +8977,14 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			goto out;
 		}
 		if (kvm_check_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
-			vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
-			vcpu->mmio_needed = 0;
-			r = 0;
-			goto out;
+			if (is_guest_mode(vcpu)) {
+				kvm_x86_ops.nested_ops->triple_fault(vcpu);
+			} else {
+				vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
+				vcpu->mmio_needed = 0;
+				r = 0;
+				goto out;
+			}
 		}
 		if (kvm_check_request(KVM_REQ_APF_HALT, vcpu)) {
 			/* Page is swapped out. Do synthetic halt */
@@ -9265,7 +9282,7 @@ static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
 static inline bool kvm_vcpu_running(struct kvm_vcpu *vcpu)
 {
 	if (is_guest_mode(vcpu))
-		kvm_x86_ops.nested_ops->check_events(vcpu);
+		kvm_check_nested_events(vcpu);
 
 	return (vcpu->arch.mp_state == KVM_MP_STATE_RUNNABLE &&
 		!vcpu->arch.apf.halted);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index ee6e01067884..daccf20fbcd5 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -56,6 +56,8 @@ static inline unsigned int __shrink_ple_window(unsigned int val,
 
 #define MSR_IA32_CR_PAT_DEFAULT  0x0007040600070406ULL
 
+int kvm_check_nested_events(struct kvm_vcpu *vcpu);
+
 static inline void kvm_clear_exception_queue(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.exception.pending = false;
-- 
2.30.1.766.gb4fecdf3b7-goog

