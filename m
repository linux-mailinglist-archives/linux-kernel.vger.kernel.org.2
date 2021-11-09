Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A895D44A420
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 02:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbhKIBn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 20:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238794AbhKIBnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 20:43:11 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A90BC07926A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 17:30:54 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x20-20020aa79414000000b0049f9cb19a5fso6994283pfo.17
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 17:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=/MNstCCiUVfIqlVu6yi/lq+5M3IDIxy5Mv5jnNwwivw=;
        b=MOfPtWrsB6uCFLjk6sd+arS8Ih/THizBPCLm4msJd1IhiyLLjocOlJkhILmt4P+kfK
         I15Q0+xBwj1sd2a3F5uJlfnOxiffp52JIJklfsk+k/PTCGeftnnyyCrsxH7KJvduOKW/
         CznZ14iSR9d+t3kwIauY/o9hcB6ktEeflfd42d/1SWa9IbXSLkqgaFTMgeJndqsV6877
         1SHTHbOIT/iOCjkgApt74dzHpeDN2qJYHpjFe3LXGY9X7bMH0gRuesU3BhCBhLzQleP0
         Hgd+Gan3ZPXa5sd06GSLnipZknb12z23I/Yk4ouafVBuOgD3zvjmcfrKkykmmdBa4jBr
         Tcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=/MNstCCiUVfIqlVu6yi/lq+5M3IDIxy5Mv5jnNwwivw=;
        b=kzMIL+YSv+HUZiYWIy8jIUgUuHtRP3q/MWAdlDHJ+ZsueQT4F/BOpXmayHMNyx9oV2
         NerXixf6GovNQKg9ry4RP7KvHRdVBC094RjU09/aWUocI4/E5EPMNma8Lx2jvpkItNaN
         maBm5JCwUAZSAZ4rLDnNtwXKFYaqi+kNHmP3k25C77Pcuzcrh3fkGrjqCR5r6uDF6U7t
         m5G6uctEzo2r9Du/pOoYGQTHG+P1haoWjnFo9Zb4ixUz7ADWUSN0jLUTA0wOuMgZ++Gi
         OTuwdNQLP8pihC9vPWdLGjl9HQWgYOXueOxeAfThToAaCLMhL8ppkn3sf9UlMLDMw06B
         1Qtg==
X-Gm-Message-State: AOAM533SE/PQSOQc0z3lzGYLOi/KURw5+DTmTdenNYo5BwRISb5529zW
        rNAiOMXkkf+qm2bHaMCszlv26EEOtfg=
X-Google-Smtp-Source: ABdhPJxPdzkTjjtM/JFYWHAfPitj8Pp3/fJ14IyeoX2MEkM7dEHKUnaa+4DFy2dFgAQRLKyFR6wM1SibMQQ=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:848:b0:49f:b215:e002 with SMTP id
 q8-20020a056a00084800b0049fb215e002mr3530934pfk.47.1636421453848; Mon, 08 Nov
 2021 17:30:53 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  9 Nov 2021 01:30:45 +0000
In-Reply-To: <20211109013047.2041518-1-seanjc@google.com>
Message-Id: <20211109013047.2041518-3-seanjc@google.com>
Mime-Version: 1.0
References: <20211109013047.2041518-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v4 2/4] KVM: nVMX: Handle dynamic MSR intercept toggling
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always check vmcs01's MSR bitmap when merging L0 and L1 bitmaps for L2,
and always update the relevant bits in vmcs02.  This fixes two distinct,
but intertwined bugs related to dynamic MSR bitmap modifications.

The first issue is that KVM fails to enable MSR interception in vmcs02
for the FS/GS base MSRs if L1 first runs L2 with interception disabled,
and later enables interception.

The second issue is that KVM fails to honor userspace MSR filtering when
preparing vmcs02.

Fix both issues simultaneous as fixing only one of the issues (doesn't
matter which) would create a mess that no one should have to bisect.
Fixing only the first bug would exacerbate the MSR filtering issue as
userspace would see inconsistent behavior depending on the whims of L1.
Fixing only the second bug (MSR filtering) effectively requires fixing
the first, as the nVMX code only knows how to transition vmcs02's
bitmap from 1->0.

Move the various accessor/mutators that are currently buried in vmx.c
into vmx.h so that they can be shared by the nested code.

Fixes: 1a155254ff93 ("KVM: x86: Introduce MSR filtering")
Fixes: d69129b4e46a ("KVM: nVMX: Disable intercept for FS/GS base MSRs in vmcs02 when possible")
Cc: stable@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 111 +++++++++++++++++---------------------
 arch/x86/kvm/vmx/vmx.c    |  55 +------------------
 arch/x86/kvm/vmx/vmx.h    |  63 ++++++++++++++++++++++
 3 files changed, 115 insertions(+), 114 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b4ee5e9f9e20..c569a135ca48 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -524,29 +524,6 @@ static int nested_vmx_check_tpr_shadow_controls(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-/*
- * Check if MSR is intercepted for L01 MSR bitmap.
- */
-static bool msr_write_intercepted_l01(struct kvm_vcpu *vcpu, u32 msr)
-{
-	unsigned long *msr_bitmap;
-	int f = sizeof(unsigned long);
-
-	if (!cpu_has_vmx_msr_bitmap())
-		return true;
-
-	msr_bitmap = to_vmx(vcpu)->vmcs01.msr_bitmap;
-
-	if (msr <= 0x1fff) {
-		return !!test_bit(msr, msr_bitmap + 0x800 / f);
-	} else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff)) {
-		msr &= 0x1fff;
-		return !!test_bit(msr, msr_bitmap + 0xc00 / f);
-	}
-
-	return true;
-}
-
 /*
  * If a msr is allowed by L0, we should check whether it is allowed by L1.
  * The corresponding bit will be cleared unless both of L0 and L1 allow it.
@@ -600,6 +577,34 @@ static inline void enable_x2apic_msr_intercepts(unsigned long *msr_bitmap)
 	}
 }
 
+#define BUILD_NVMX_MSR_INTERCEPT_HELPER(rw)					\
+static inline									\
+void nested_vmx_set_msr_##rw##_intercept(struct vcpu_vmx *vmx,			\
+					 unsigned long *msr_bitmap_l1,		\
+					 unsigned long *msr_bitmap_l0, u32 msr)	\
+{										\
+	if (vmx_test_msr_bitmap_##rw(vmx->vmcs01.msr_bitmap, msr) ||		\
+	    vmx_test_msr_bitmap_##rw(msr_bitmap_l1, msr))			\
+		vmx_set_msr_bitmap_##rw(msr_bitmap_l0, msr);			\
+	else									\
+		vmx_clear_msr_bitmap_##rw(msr_bitmap_l0, msr);			\
+}
+BUILD_NVMX_MSR_INTERCEPT_HELPER(read)
+BUILD_NVMX_MSR_INTERCEPT_HELPER(write)
+
+static inline void nested_vmx_set_intercept_for_msr(struct vcpu_vmx *vmx,
+						    unsigned long *msr_bitmap_l1,
+						    unsigned long *msr_bitmap_l0,
+						    u32 msr, int types)
+{
+	if (types & MSR_TYPE_R)
+		nested_vmx_set_msr_read_intercept(vmx, msr_bitmap_l1,
+						  msr_bitmap_l0, msr);
+	if (types & MSR_TYPE_W)
+		nested_vmx_set_msr_write_intercept(vmx, msr_bitmap_l1,
+						   msr_bitmap_l0, msr);
+}
+
 /*
  * Merge L0's and L1's MSR bitmap, return false to indicate that
  * we do not use the hardware.
@@ -607,10 +612,11 @@ static inline void enable_x2apic_msr_intercepts(unsigned long *msr_bitmap)
 static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 						 struct vmcs12 *vmcs12)
 {
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int msr;
 	unsigned long *msr_bitmap_l1;
-	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
-	struct kvm_host_map *map = &to_vmx(vcpu)->nested.msr_bitmap_map;
+	unsigned long *msr_bitmap_l0 = vmx->nested.vmcs02.msr_bitmap;
+	struct kvm_host_map *map = &vmx->nested.msr_bitmap_map;
 
 	/* Nothing to do if the MSR bitmap is not in use.  */
 	if (!cpu_has_vmx_msr_bitmap() ||
@@ -661,44 +667,27 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 		}
 	}
 
-	/* KVM unconditionally exposes the FS/GS base MSRs to L1. */
-#ifdef CONFIG_X86_64
-	nested_vmx_disable_intercept_for_msr(msr_bitmap_l1, msr_bitmap_l0,
-					     MSR_FS_BASE, MSR_TYPE_RW);
-
-	nested_vmx_disable_intercept_for_msr(msr_bitmap_l1, msr_bitmap_l0,
-					     MSR_GS_BASE, MSR_TYPE_RW);
-
-	nested_vmx_disable_intercept_for_msr(msr_bitmap_l1, msr_bitmap_l0,
-					     MSR_KERNEL_GS_BASE, MSR_TYPE_RW);
-#endif
-
 	/*
-	 * Checking the L0->L1 bitmap is trying to verify two things:
-	 *
-	 * 1. L0 gave a permission to L1 to actually passthrough the MSR. This
-	 *    ensures that we do not accidentally generate an L02 MSR bitmap
-	 *    from the L12 MSR bitmap that is too permissive.
-	 * 2. That L1 or L2s have actually used the MSR. This avoids
-	 *    unnecessarily merging of the bitmap if the MSR is unused. This
-	 *    works properly because we only update the L01 MSR bitmap lazily.
-	 *    So even if L0 should pass L1 these MSRs, the L01 bitmap is only
-	 *    updated to reflect this when L1 (or its L2s) actually write to
-	 *    the MSR.
+	 * Always check vmcs01's bitmap to honor userspace MSR filters and any
+	 * other runtime changes to vmcs01's bitmap, e.g. dynamic pass-through.
 	 */
-	if (!msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL))
-		nested_vmx_disable_intercept_for_msr(
-					msr_bitmap_l1, msr_bitmap_l0,
-					MSR_IA32_SPEC_CTRL,
-					MSR_TYPE_R | MSR_TYPE_W);
-
-	if (!msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD))
-		nested_vmx_disable_intercept_for_msr(
-					msr_bitmap_l1, msr_bitmap_l0,
-					MSR_IA32_PRED_CMD,
-					MSR_TYPE_W);
-
-	kvm_vcpu_unmap(vcpu, &to_vmx(vcpu)->nested.msr_bitmap_map, false);
+#ifdef CONFIG_X86_64
+	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
+					 MSR_FS_BASE, MSR_TYPE_RW);
+
+	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
+					 MSR_GS_BASE, MSR_TYPE_RW);
+
+	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
+					 MSR_KERNEL_GS_BASE, MSR_TYPE_RW);
+#endif
+	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
+					 MSR_IA32_SPEC_CTRL, MSR_TYPE_RW);
+
+	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
+					 MSR_IA32_PRED_CMD, MSR_TYPE_W);
+
+	kvm_vcpu_unmap(vcpu, &vmx->nested.msr_bitmap_map, false);
 
 	return true;
 }
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 334323bd787d..a0be26d3e81f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -771,22 +771,11 @@ void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu)
  */
 static bool msr_write_intercepted(struct vcpu_vmx *vmx, u32 msr)
 {
-	unsigned long *msr_bitmap;
-	int f = sizeof(unsigned long);
-
 	if (!(exec_controls_get(vmx) & CPU_BASED_USE_MSR_BITMAPS))
 		return true;
 
-	msr_bitmap = vmx->loaded_vmcs->msr_bitmap;
-
-	if (msr <= 0x1fff) {
-		return !!test_bit(msr, msr_bitmap + 0x800 / f);
-	} else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff)) {
-		msr &= 0x1fff;
-		return !!test_bit(msr, msr_bitmap + 0xc00 / f);
-	}
-
-	return true;
+	return vmx_test_msr_bitmap_write(vmx->loaded_vmcs->msr_bitmap,
+					 MSR_IA32_SPEC_CTRL);
 }
 
 static void clear_atomic_switch_msr_special(struct vcpu_vmx *vmx,
@@ -3697,46 +3686,6 @@ void free_vpid(int vpid)
 	spin_unlock(&vmx_vpid_lock);
 }
 
-static void vmx_clear_msr_bitmap_read(ulong *msr_bitmap, u32 msr)
-{
-	int f = sizeof(unsigned long);
-
-	if (msr <= 0x1fff)
-		__clear_bit(msr, msr_bitmap + 0x000 / f);
-	else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff))
-		__clear_bit(msr & 0x1fff, msr_bitmap + 0x400 / f);
-}
-
-static void vmx_clear_msr_bitmap_write(ulong *msr_bitmap, u32 msr)
-{
-	int f = sizeof(unsigned long);
-
-	if (msr <= 0x1fff)
-		__clear_bit(msr, msr_bitmap + 0x800 / f);
-	else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff))
-		__clear_bit(msr & 0x1fff, msr_bitmap + 0xc00 / f);
-}
-
-static void vmx_set_msr_bitmap_read(ulong *msr_bitmap, u32 msr)
-{
-	int f = sizeof(unsigned long);
-
-	if (msr <= 0x1fff)
-		__set_bit(msr, msr_bitmap + 0x000 / f);
-	else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff))
-		__set_bit(msr & 0x1fff, msr_bitmap + 0x400 / f);
-}
-
-static void vmx_set_msr_bitmap_write(ulong *msr_bitmap, u32 msr)
-{
-	int f = sizeof(unsigned long);
-
-	if (msr <= 0x1fff)
-		__set_bit(msr, msr_bitmap + 0x800 / f);
-	else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff))
-		__set_bit(msr & 0x1fff, msr_bitmap + 0xc00 / f);
-}
-
 void vmx_disable_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index e7db42e3b0ce..d51311fa9ffc 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -400,6 +400,69 @@ static inline void vmx_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr,
 
 void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
 
+static inline bool vmx_test_msr_bitmap_read(ulong *msr_bitmap, u32 msr)
+{
+	int f = sizeof(unsigned long);
+
+	if (msr <= 0x1fff)
+		return test_bit(msr, msr_bitmap + 0x000 / f);
+	else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff))
+		return test_bit(msr & 0x1fff, msr_bitmap + 0x400 / f);
+	return true;
+}
+
+static inline bool vmx_test_msr_bitmap_write(ulong *msr_bitmap, u32 msr)
+{
+	int f = sizeof(unsigned long);
+
+	if (msr <= 0x1fff)
+		return test_bit(msr, msr_bitmap + 0x800 / f);
+	else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff))
+		return test_bit(msr & 0x1fff, msr_bitmap + 0xc00 / f);
+	return true;
+}
+
+static inline void vmx_clear_msr_bitmap_read(ulong *msr_bitmap, u32 msr)
+{
+	int f = sizeof(unsigned long);
+
+	if (msr <= 0x1fff)
+		__clear_bit(msr, msr_bitmap + 0x000 / f);
+	else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff))
+		__clear_bit(msr & 0x1fff, msr_bitmap + 0x400 / f);
+}
+
+static inline void vmx_clear_msr_bitmap_write(ulong *msr_bitmap, u32 msr)
+{
+	int f = sizeof(unsigned long);
+
+	if (msr <= 0x1fff)
+		__clear_bit(msr, msr_bitmap + 0x800 / f);
+	else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff))
+		__clear_bit(msr & 0x1fff, msr_bitmap + 0xc00 / f);
+}
+
+static inline void vmx_set_msr_bitmap_read(ulong *msr_bitmap, u32 msr)
+{
+	int f = sizeof(unsigned long);
+
+	if (msr <= 0x1fff)
+		__set_bit(msr, msr_bitmap + 0x000 / f);
+	else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff))
+		__set_bit(msr & 0x1fff, msr_bitmap + 0x400 / f);
+}
+
+static inline void vmx_set_msr_bitmap_write(ulong *msr_bitmap, u32 msr)
+{
+	int f = sizeof(unsigned long);
+
+	if (msr <= 0x1fff)
+		__set_bit(msr, msr_bitmap + 0x800 / f);
+	else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff))
+		__set_bit(msr & 0x1fff, msr_bitmap + 0xc00 / f);
+}
+
+
 static inline u8 vmx_get_rvi(void)
 {
 	return vmcs_read16(GUEST_INTR_STATUS) & 0xff;
-- 
2.34.0.rc0.344.g81b53c2807-goog

