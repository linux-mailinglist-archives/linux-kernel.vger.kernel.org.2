Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB4E38E81D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhEXNz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:55:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20548 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232409AbhEXNz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621864469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lNJWCUmL9Ntm82EBPDVLXzVo5nqx+ieQciivYxpJMDY=;
        b=WLUcyrhlhjZ1H2217nSqXiNi3ODtgWXwVKOWPTkVKWyjb54OzrLlFDs5hXo5qumG0xRI9k
        FUaSyTzkOJlICbLj0w4wyBLaXAErIu/RDjVVZIx3bgkUPixRK/ghZDEfKBPbb46FgY9FLn
        GwGs71gQT0UaCcopOL9k/StUCzuwNTI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-us6wmN4lM6eQk5vcpT-7DQ-1; Mon, 24 May 2021 09:54:25 -0400
X-MC-Unique: us6wmN4lM6eQk5vcpT-7DQ-1
Received: by mail-ed1-f69.google.com with SMTP id d8-20020a0564020008b0290387d38e3ce0so15621670edu.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 06:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lNJWCUmL9Ntm82EBPDVLXzVo5nqx+ieQciivYxpJMDY=;
        b=gHxDsYzeA1vlnB+G0JLfD11sB86eyki/FEYdZRdWdvzUXzdP7cXARKjbgSrgxIod3z
         nQClxCXArMe23Wm1gCbxR9pEhb9x3/R6Ygf4Iaaoq7roLYKHPYVfC6QfqwmKd6GPL3dF
         qNZLbsQoRfEKMyFTBemS0QcUpF56T7BW34OGefDWnlAJ8uvWf6WNx9HWDyk4rBUi0QZb
         SUen4dUhOKHcq616ww37Tr7zH8vRDuCgGu6rLlQt8ex/Z24MM15K7SF43Ny0Uk0DGl7u
         DVImFLxFJCLHr6wFXlY33JCD6JV6nuSwnvlK2eZZoTdo9CtQL//dbtQqKsmF/ndBblvK
         uaSg==
X-Gm-Message-State: AOAM530Xcklap9Aiqr1egiQPcjfDBNMWsB6VGFPaVk9ubiud/9T2ZRwo
        kVTWKcDH0DiYZGv8elXFn5LDjII63IwLuc2Squ83paSDL3VNv7+yPRloqO014ZDYtq+5UH0xRaR
        FaMdXypd3AQCAji7WzxRWMmNkH1urpijQGyVFv4eMopnR0VtxR+83ghGMRFI4a+ppMMPmqmBpR6
        NB
X-Received: by 2002:a50:9346:: with SMTP id n6mr25922320eda.365.1621864464233;
        Mon, 24 May 2021 06:54:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3aI2AKB5mGLPjGrz4diDrlmzrLwXkf9JYtDI2mIUa6MK4W57Cn/GtO21Q+KGRGbSIk1z/dw==
X-Received: by 2002:a50:9346:: with SMTP id n6mr25922294eda.365.1621864463969;
        Mon, 24 May 2021 06:54:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id z22sm10267401edm.57.2021.05.24.06.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 06:54:23 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] KVM: nVMX: Introduce nested_evmcs_is_used()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20210517135054.1914802-1-vkuznets@redhat.com>
 <20210517135054.1914802-2-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <115fcae7-0c88-4865-6494-bdf6fb672382@redhat.com>
Date:   Mon, 24 May 2021 15:54:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517135054.1914802-2-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/21 15:50, Vitaly Kuznetsov wrote:
> Unlike regular set_current_vmptr(), nested_vmx_handle_enlightened_vmptrld()
> can not be called directly from vmx_set_nested_state() as KVM may not have
> all the information yet (e.g. HV_X64_MSR_VP_ASSIST_PAGE MSR may not be
> restored yet). Enlightened VMCS is mapped later while getting nested state
> pages. In the meantime, vmx->nested.hv_evmcs remains NULL and using it
> for various checks is incorrect. In particular, if KVM_GET_NESTED_STATE is
> called right after KVM_SET_NESTED_STATE, KVM_STATE_NESTED_EVMCS flag in the
> resulting state will be unset (and such state will later fail to load).
> 
> Introduce nested_evmcs_is_used() and use 'is_guest_mode(vcpu) &&
> vmx->nested.current_vmptr == -1ull' check to detect not-yet-mapped eVMCS
> after restore.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Would it make sense to instead use hv_evmcs_ptr, making the unused
value -1 instead of 0?

I even had this untested patch already lying around as a cleanup I
never bothered to submit:

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index a19cfcb625da..dd3e4ddaaf26 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -187,7 +187,7 @@ static int nested_vmx_fail(struct kvm_vcpu *vcpu, u32 vm_instruction_error)
  	 * failValid writes the error number to the current VMCS, which
  	 * can't be done if there isn't a current VMCS.
  	 */
-	if (vmx->nested.current_vmptr == -1ull && !vmx->nested.hv_evmcs)
+	if (vmx->nested.current_vmptr == -1ull && vmx->nested.hv_evmcs_vmptr == -1)
  		return nested_vmx_failInvalid(vcpu);
  
  	return nested_vmx_failValid(vcpu, vm_instruction_error);
@@ -221,11 +221,11 @@ static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
  {
  	struct vcpu_vmx *vmx = to_vmx(vcpu);
  
-	if (!vmx->nested.hv_evmcs)
+	if (vmx->nested.hv_evmcs_vmptr == -1)
  		return;
  
  	kvm_vcpu_unmap(vcpu, &vmx->nested.hv_evmcs_map, NULL, true);
-	vmx->nested.hv_evmcs_vmptr = 0;
+	vmx->nested.hv_evmcs_vmptr = -1;
  	vmx->nested.hv_evmcs = NULL;
  }
  
@@ -1978,10 +1978,8 @@ static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
  	if (!nested_enlightened_vmentry(vcpu, &evmcs_gpa))
  		return EVMPTRLD_DISABLED;
  
-	if (unlikely(!vmx->nested.hv_evmcs ||
-		     evmcs_gpa != vmx->nested.hv_evmcs_vmptr)) {
-		if (!vmx->nested.hv_evmcs)
-			vmx->nested.current_vmptr = -1ull;
+	if (unlikely(evmcs_gpa != vmx->nested.hv_evmcs_vmptr)) {
+		vmx->nested.current_vmptr = -1ull;
  
  		nested_release_evmcs(vcpu);
  
@@ -2052,7 +2050,7 @@ void nested_sync_vmcs12_to_shadow(struct kvm_vcpu *vcpu)
  {
  	struct vcpu_vmx *vmx = to_vmx(vcpu);
  
-	if (vmx->nested.hv_evmcs) {
+	if (vmx->nested.hv_evmcs_vmptr != -1) {
  		copy_vmcs12_to_enlightened(vmx);
  		/* All fields are clean */
  		vmx->nested.hv_evmcs->hv_clean_fields |=
@@ -2204,7 +2202,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
  	u32 exec_control;
  	u64 guest_efer = nested_vmx_calc_efer(vmx, vmcs12);
  
-	if (vmx->nested.dirty_vmcs12 || vmx->nested.hv_evmcs)
+	if (vmx->nested.dirty_vmcs12 || vmx->nested.hv_evmcs_vmptr != -1)
  		prepare_vmcs02_early_rare(vmx, vmcs12);
  
  	/*
@@ -2487,9 +2485,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
  			  enum vm_entry_failure_code *entry_failure_code)
  {
  	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	struct hv_enlightened_vmcs *hv_evmcs = vmx->nested.hv_evmcs;
  
-	if (vmx->nested.dirty_vmcs12 || hv_evmcs) {
+	if (vmx->nested.dirty_vmcs12 || vmx->nested.hv_evmcs_vmptr != -1) {
  		prepare_vmcs02_rare(vmx, vmcs12);
  		vmx->nested.dirty_vmcs12 = false;
  	}
@@ -3075,7 +3072,7 @@ static bool nested_get_evmcs_page(struct kvm_vcpu *vcpu)
  	 * L2 was running), map it here to make sure vmcs12 changes are
  	 * properly reflected.
  	 */
-	if (vmx->nested.enlightened_vmcs_enabled && !vmx->nested.hv_evmcs) {
+	if (vmx->nested.enlightened_vmcs_enabled && vmx->nested.hv_evmcs_vmptr == -1) {
  		enum nested_evmptrld_status evmptrld_status =
  			nested_vmx_handle_enlightened_vmptrld(vcpu, false);
  
@@ -3419,7 +3416,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
  
  	load_vmcs12_host_state(vcpu, vmcs12);
  	vmcs12->vm_exit_reason = exit_reason.full;
-	if (enable_shadow_vmcs || vmx->nested.hv_evmcs)
+	if (enable_shadow_vmcs || vmx->nested.hv_evmcs_vmptr != -1)
  		vmx->nested.need_vmcs12_to_shadow_sync = true;
  	return NVMX_VMENTRY_VMEXIT;
  }
@@ -3449,7 +3446,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
  		return nested_vmx_failInvalid(vcpu);
  	}
  
-	if (CC(!vmx->nested.hv_evmcs && vmx->nested.current_vmptr == -1ull))
+	if (CC(vmx->nested.hv_evmcs_vmptr == -1 && vmx->nested.current_vmptr == -1ull))
  		return nested_vmx_failInvalid(vcpu);
  
  	vmcs12 = get_vmcs12(vcpu);
@@ -3463,7 +3460,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
  	if (CC(vmcs12->hdr.shadow_vmcs))
  		return nested_vmx_failInvalid(vcpu);
  
-	if (vmx->nested.hv_evmcs) {
+	if (vmx->nested.hv_evmcs_vmptr != -1) {
  		copy_enlightened_to_vmcs12(vmx);
  		/* Enlightened VMCS doesn't have launch state */
  		vmcs12->launch_state = !launch;
@@ -4014,10 +4011,10 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
  {
  	struct vcpu_vmx *vmx = to_vmx(vcpu);
  
-	if (vmx->nested.hv_evmcs)
+	if (vmx->nested.hv_evmcs_vmptr != -1)
  		sync_vmcs02_to_vmcs12_rare(vcpu, vmcs12);
  
-	vmx->nested.need_sync_vmcs02_to_vmcs12_rare = !vmx->nested.hv_evmcs;
+	vmx->nested.need_sync_vmcs02_to_vmcs12_rare = (vmx->nested.hv_evmcs_vmptr == -1);
  
  	vmcs12->guest_cr0 = vmcs12_guest_cr0(vcpu, vmcs12);
  	vmcs12->guest_cr4 = vmcs12_guest_cr4(vcpu, vmcs12);
@@ -4514,7 +4511,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
  	}
  
  	if ((vm_exit_reason != -1) &&
-	    (enable_shadow_vmcs || vmx->nested.hv_evmcs))
+	    (enable_shadow_vmcs || vmx->nested.hv_evmcs_vmptr != -1))
  		vmx->nested.need_vmcs12_to_shadow_sync = true;
  
  	/* in case we halted in L2 */
@@ -5210,7 +5207,7 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
  		return nested_vmx_fail(vcpu, VMXERR_VMPTRLD_VMXON_POINTER);
  
  	/* Forbid normal VMPTRLD if Enlightened version was used */
-	if (vmx->nested.hv_evmcs)
+	if (vmx->nested.hv_evmcs_vmptr != -1)
  		return 1;
  
  	if (vmx->nested.current_vmptr != vmptr) {
@@ -5266,7 +5263,7 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
  	if (!nested_vmx_check_permission(vcpu))
  		return 1;
  
-	if (unlikely(to_vmx(vcpu)->nested.hv_evmcs))
+	if (unlikely(to_vmx(vcpu)->nested.hv_evmcs_vmptr != -1))
  		return 1;
  
  	if (get_vmx_mem_address(vcpu, exit_qual, instr_info,
@@ -6038,7 +6035,7 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
  		if (vmx_has_valid_vmcs12(vcpu)) {
  			kvm_state.size += sizeof(user_vmx_nested_state->vmcs12);
  
-			if (vmx->nested.hv_evmcs)
+			if (vmx->nested.hv_evmcs_vmptr != -1)
  				kvm_state.flags |= KVM_STATE_NESTED_EVMCS;
  
  			if (is_guest_mode(vcpu) &&
@@ -6094,7 +6091,7 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
  	} else  {
  		copy_vmcs02_to_vmcs12_rare(vcpu, get_vmcs12(vcpu));
  		if (!vmx->nested.need_vmcs12_to_shadow_sync) {
-			if (vmx->nested.hv_evmcs)
+			if (vmx->nested.hv_evmcs_vmptr != -1)
  				copy_enlightened_to_vmcs12(vmx);
  			else if (enable_shadow_vmcs)
  				copy_shadow_to_vmcs12(vmx);
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 184418baeb3c..55925be48973 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -63,7 +63,7 @@ static inline int vmx_has_valid_vmcs12(struct kvm_vcpu *vcpu)
  	 * have vmcs12 if it is true.
  	 */
  	return is_guest_mode(vcpu) || vmx->nested.current_vmptr != -1ull ||
-		vmx->nested.hv_evmcs;
+		vmx->nested.hv_evmcs_vmptr != -1;
  }
  
  static inline u16 nested_get_vpid02(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f2fd447eed45..33208aa4ac87 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6974,6 +6974,7 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
  
  	vmx->nested.posted_intr_nv = -1;
  	vmx->nested.current_vmptr = -1ull;
+	vmx->nested.hv_evmcs_vmptr = -1;
  
  	vcpu->arch.microcode_version = 0x100000000ULL;
  	vmx->msr_ia32_feature_control_valid_bits = FEAT_CTL_LOCKED;

Paolo

