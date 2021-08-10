Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDF73E7E21
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 19:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhHJRUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 13:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhHJRUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 13:20:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD43FC061799
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 10:20:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f3-20020a25cf030000b029055a2303fc2dso21685502ybg.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 10:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=+t80HslQO1fcYwWS9Oo4DIQTnljb44fDDveV2/U8cXk=;
        b=aK8QrwMATZBMtxTisoYFkhvx3SV+v0hzCcL0OG/3OA81/jIUmmCrbZgIWzhlVrOHJy
         Yga8ypxswPPyCTht9/p3rtSk5W/azCWhsvgMppJfubFdS4+ETuquMpSUvshVMjhHzcjP
         ABBbjigBTVKj9WGN/YLu5ORHUQ3n7pjASDYImQsTRSYe9UvOmcddvBnmoeyGkcu9KRMQ
         W6gD4IeMmL5MmgM3Ck6EbcYLkRtNJjN/wsqEGgv4WwHogoXOaMdl+i5JPEah1UTa9Lw4
         oO3Zlac+nELpVUD21HPR4NmkHbZPwWLaTCdzeFPQQCa+RYb2B87ALNPp3c2kgNcbhN5Q
         YhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=+t80HslQO1fcYwWS9Oo4DIQTnljb44fDDveV2/U8cXk=;
        b=nwiJi/GQbkGK0wN9+wxbuItgLAga2IUiFBcqUsD1zm4hFu6NaSfM6SWKWAJL9FD1D1
         +rYn9RhLKyaMst4J40s50qFeq7T9uDXWQ7EGlfU/ik6MhYkHk/LjPNDSb5BGN9kDVun8
         onaBvukXRCLM9zWsnRxGb6Fu0R0TQIoOPqvrU0WTaenP2ljx+guaJXMZOFAVMrkN6PDT
         c0OxAhBYXmv8oL9kjds3rxsNrAj3DKtofWNcbfw9taxwgRwrpqR+fDwkrwgBF15ZIhLY
         S2UUWuq8FOWvQ5KqCRPVOvGECi2oBZR0ELCtiASpSS/JpmUFDZxaMNe7mBvLnTCfROdh
         5pTA==
X-Gm-Message-State: AOAM532fEbFP5B0Hf7yJrkwV11ppQvHqoALK8GfYWazxHLeIzCNgciLB
        eIuldXFriG8K7xRtlA77rshew7z/XoU=
X-Google-Smtp-Source: ABdhPJzedoGDQo4G1y2qT2X24/RjpR7EZFPZhj3qfwew/mYV59ERVQJYEYCSw6CTtQIR+cobo51KITmzLrg=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:de69:b19a:1af5:866d])
 (user=seanjc job=sendgmr) by 2002:a25:d7d5:: with SMTP id o204mr3035264ybg.359.1628616008061;
 Tue, 10 Aug 2021 10:20:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 10 Aug 2021 10:19:51 -0700
In-Reply-To: <20210810171952.2758100-1-seanjc@google.com>
Message-Id: <20210810171952.2758100-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210810171952.2758100-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH 3/4] KVM: VMX: Drop caching of KVM's desired sec exec controls
 for vmcs01
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the secondary execution controls cache now that it's effectively
dead code; it is only read immediately after it is written.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 20 ++++++++------------
 arch/x86/kvm/vmx/vmx.h |  3 +--
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ae8e62df16dd..6c93122363b2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4212,7 +4212,7 @@ vmx_adjust_secondary_exec_control(struct vcpu_vmx *vmx, u32 *exec_control,
 #define vmx_adjust_sec_exec_exiting(vmx, exec_control, lname, uname) \
 	vmx_adjust_sec_exec_control(vmx, exec_control, lname, uname, uname##_EXITING, true)
 
-static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
+u32 vmx_secondary_exec_control(struct vcpu_vmx *vmx)
 {
 	struct kvm_vcpu *vcpu = &vmx->vcpu;
 
@@ -4298,7 +4298,7 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
 	if (!vcpu->kvm->arch.bus_lock_detection_enabled)
 		exec_control &= ~SECONDARY_EXEC_BUS_LOCK_DETECTION;
 
-	vmx->secondary_exec_control = exec_control;
+	return exec_control;
 }
 
 #define VMX_XSS_EXIT_BITMAP 0
@@ -4322,10 +4322,8 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 
 	exec_controls_set(vmx, vmx_exec_control(vmx));
 
-	if (cpu_has_secondary_exec_ctrls()) {
-		vmx_compute_secondary_exec_control(vmx);
-		secondary_exec_controls_set(vmx, vmx->secondary_exec_control);
-	}
+	if (cpu_has_secondary_exec_ctrls())
+		secondary_exec_controls_set(vmx, vmx_secondary_exec_control(vmx));
 
 	if (kvm_vcpu_apicv_active(&vmx->vcpu)) {
 		vmcs_write64(EOI_EXIT_BITMAP0, 0);
@@ -6982,7 +6980,7 @@ static u64 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 	return (cache << VMX_EPT_MT_EPTE_SHIFT) | ipat;
 }
 
-static void vmcs_set_secondary_exec_control(struct vcpu_vmx *vmx)
+static void vmcs_set_secondary_exec_control(struct vcpu_vmx *vmx, u32 new_ctl)
 {
 	/*
 	 * These bits in the secondary execution controls field
@@ -6996,7 +6994,6 @@ static void vmcs_set_secondary_exec_control(struct vcpu_vmx *vmx)
 		SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
 		SECONDARY_EXEC_DESC;
 
-	u32 new_ctl = vmx->secondary_exec_control;
 	u32 cur_ctl = secondary_exec_controls_get(vmx);
 
 	secondary_exec_controls_set(vmx, (new_ctl & ~mask) | (cur_ctl & mask));
@@ -7141,10 +7138,9 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 	vmx_setup_uret_msrs(vmx);
 
-	if (cpu_has_secondary_exec_ctrls()) {
-		vmx_compute_secondary_exec_control(vmx);
-		vmcs_set_secondary_exec_control(vmx);
-	}
+	if (cpu_has_secondary_exec_ctrls())
+		vmcs_set_secondary_exec_control(vmx,
+						vmx_secondary_exec_control(vmx));
 
 	if (nested_vmx_allowed(vcpu))
 		to_vmx(vcpu)->msr_ia32_feature_control_valid_bits |=
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 414b440de9ac..2bd07867e9da 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -263,8 +263,6 @@ struct vcpu_vmx {
 	u64		      spec_ctrl;
 	u32		      msr_ia32_umwait_control;
 
-	u32 secondary_exec_control;
-
 	/*
 	 * loaded_vmcs points to the VMCS currently used in this vcpu. For a
 	 * non-nested (L1) guest, it always points to vmcs01. For a nested
@@ -477,6 +475,7 @@ static inline u32 vmx_vmexit_ctrl(void)
 }
 
 u32 vmx_exec_control(struct vcpu_vmx *vmx);
+u32 vmx_secondary_exec_control(struct vcpu_vmx *vmx);
 u32 vmx_pin_based_exec_ctrl(struct vcpu_vmx *vmx);
 
 static inline struct kvm_vmx *to_kvm_vmx(struct kvm *kvm)
-- 
2.32.0.605.g8dce9f2422-goog

