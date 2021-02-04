Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2912730E836
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 01:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbhBDADF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 19:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbhBDACu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 19:02:50 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799DEC0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 16:01:38 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id w3so1216016qti.17
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 16:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=d2iRbGdfp/Ifr4yknHGjT6yfFI/3odhmNBJQhqstDno=;
        b=rjKpyX/qgfzTGAfG2oRnIAwsnHCzo2UL0l25qtM7TIDodrAopJ1I09Ndwpjl3Hz1jT
         f3SKbUXLKvBCcGpmk4G+3VaOvKAHbovX8NS0+KXUFPL4K0flu2Io6+8zKNFPrHqTkWPc
         DnkP3diUY3mrvKcNK7Yl9QuDcRtdZ/thWwji1PB4XhFrPZxKxq+Xld5KZ1eIznwwU/ns
         fey/cFpHieKuQfJExJWxLas7RgkYXRXJL69125YFmlkSh/p+OitYH2zCbQ+GBw2REj2j
         dq+eOI+VfUSuDRsPod77kz9haZOtj7WEHwbvK3jxAVKoM1bxykIygsjO3QHyld/BOLei
         m3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=d2iRbGdfp/Ifr4yknHGjT6yfFI/3odhmNBJQhqstDno=;
        b=fjOyXFTnXbO3Oh2Urbs+5gA1jve2gNEKn0za2PyGEUGhYLxdtM5XCQKwK6JZT4eDN6
         eJhlq4FGEgCK7/vSsFnjpVa/vth9qdkyKFSXVjIepMmeoyL7Oe6iJlK5gJhQOUuBeczO
         ddy1fA5FXg4EAkh0o0B6DixQ9xq592e8yrH7fSHVNcDOwSkPopAAzT0NRqknilonCchP
         ft6UU4T7vVYzYfZMyjLZDuorS8/clrkl0oAhEBW0cYdm0XgZCYfM6TiWScLj3Gv6ush4
         6MJyq1VaWFmZhW57bVXc/ixNV84Wb9MpxFpZ785NtUMt8aS0kWlRnFP3Y+gumozB75pS
         Y3mg==
X-Gm-Message-State: AOAM530N5bmQkcXscriEmPX2Trx2mv2WM+rCfr9Qmsz73kBFEbxFRtcU
        i+ws1BPyWEOZ65/gHEB3MG3bxeq1Nrw=
X-Google-Smtp-Source: ABdhPJx8RyG5PcUvngLKMHbmBv437Ki4ZOemCkox27BEbIjqqqvH0ZYWyyPPQlZpVj1jDMur4uDso78oJqs=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:a9a0:e924:d161:b6cb])
 (user=seanjc job=sendgmr) by 2002:ad4:5bc8:: with SMTP id t8mr5454160qvt.36.1612396897679;
 Wed, 03 Feb 2021 16:01:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  3 Feb 2021 16:01:10 -0800
In-Reply-To: <20210204000117.3303214-1-seanjc@google.com>
Message-Id: <20210204000117.3303214-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210204000117.3303214-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 05/12] KVM: VMX: Use GPA legality helpers to replace open
 coded equivalents
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a variety of open coded GPA checks with the recently introduced
common helpers.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 26 +++++++-------------------
 arch/x86/kvm/vmx/vmx.c    |  2 +-
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b14fc19ceb36..b25ce704a2aa 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -775,8 +775,7 @@ static int nested_vmx_check_apicv_controls(struct kvm_vcpu *vcpu,
 	   (CC(!nested_cpu_has_vid(vmcs12)) ||
 	    CC(!nested_exit_intr_ack_set(vcpu)) ||
 	    CC((vmcs12->posted_intr_nv & 0xff00)) ||
-	    CC((vmcs12->posted_intr_desc_addr & 0x3f)) ||
-	    CC((vmcs12->posted_intr_desc_addr >> cpuid_maxphyaddr(vcpu)))))
+	    CC(!kvm_vcpu_is_legal_aligned_gpa(vcpu, vmcs12->posted_intr_desc_addr, 64))))
 		return -EINVAL;
 
 	/* tpr shadow is needed by all apicv features. */
@@ -789,13 +788,11 @@ static int nested_vmx_check_apicv_controls(struct kvm_vcpu *vcpu,
 static int nested_vmx_check_msr_switch(struct kvm_vcpu *vcpu,
 				       u32 count, u64 addr)
 {
-	int maxphyaddr;
-
 	if (count == 0)
 		return 0;
-	maxphyaddr = cpuid_maxphyaddr(vcpu);
-	if (!IS_ALIGNED(addr, 16) || addr >> maxphyaddr ||
-	    (addr + count * sizeof(struct vmx_msr_entry) - 1) >> maxphyaddr)
+
+	if (!kvm_vcpu_is_legal_aligned_gpa(vcpu, addr, 16) ||
+	    !kvm_vcpu_is_legal_gpa(vcpu, (addr + count * sizeof(struct vmx_msr_entry) - 1)))
 		return -EINVAL;
 
 	return 0;
@@ -1093,14 +1090,6 @@ static void prepare_vmx_msr_autostore_list(struct kvm_vcpu *vcpu,
 	}
 }
 
-static bool nested_cr3_valid(struct kvm_vcpu *vcpu, unsigned long val)
-{
-	unsigned long invalid_mask;
-
-	invalid_mask = (~0ULL) << cpuid_maxphyaddr(vcpu);
-	return (val & invalid_mask) == 0;
-}
-
 /*
  * Returns true if the MMU needs to be sync'd on nested VM-Enter/VM-Exit.
  * tl;dr: the MMU needs a sync if L0 is using shadow paging and L1 didn't
@@ -1152,7 +1141,7 @@ static bool nested_vmx_transition_mmu_sync(struct kvm_vcpu *vcpu)
 static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3, bool nested_ept,
 			       enum vm_entry_failure_code *entry_failure_code)
 {
-	if (CC(!nested_cr3_valid(vcpu, cr3))) {
+	if (CC(kvm_vcpu_is_illegal_gpa(vcpu, cr3))) {
 		*entry_failure_code = ENTRY_FAIL_DEFAULT;
 		return -EINVAL;
 	}
@@ -2666,7 +2655,6 @@ static int nested_vmx_check_nmi_controls(struct vmcs12 *vmcs12)
 static bool nested_vmx_check_eptp(struct kvm_vcpu *vcpu, u64 new_eptp)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	int maxphyaddr = cpuid_maxphyaddr(vcpu);
 
 	/* Check for memory type validity */
 	switch (new_eptp & VMX_EPTP_MT_MASK) {
@@ -2697,7 +2685,7 @@ static bool nested_vmx_check_eptp(struct kvm_vcpu *vcpu, u64 new_eptp)
 	}
 
 	/* Reserved bits should not be set */
-	if (CC(new_eptp >> maxphyaddr || ((new_eptp >> 7) & 0x1f)))
+	if (CC(kvm_vcpu_is_illegal_gpa(vcpu, new_eptp) || ((new_eptp >> 7) & 0x1f)))
 		return false;
 
 	/* AD, if set, should be supported */
@@ -2881,7 +2869,7 @@ static int nested_vmx_check_host_state(struct kvm_vcpu *vcpu,
 
 	if (CC(!nested_host_cr0_valid(vcpu, vmcs12->host_cr0)) ||
 	    CC(!nested_host_cr4_valid(vcpu, vmcs12->host_cr4)) ||
-	    CC(!nested_cr3_valid(vcpu, vmcs12->host_cr3)))
+	    CC(kvm_vcpu_is_illegal_gpa(vcpu, vmcs12->host_cr3)))
 		return -EINVAL;
 
 	if (CC(is_noncanonical_address(vmcs12->host_ia32_sysenter_esp, vcpu)) ||
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index beb5a912014d..cbeb0748f25f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1114,7 +1114,7 @@ static inline bool pt_can_write_msr(struct vcpu_vmx *vmx)
 static inline bool pt_output_base_valid(struct kvm_vcpu *vcpu, u64 base)
 {
 	/* The base must be 128-byte aligned and a legal physical address. */
-	return !kvm_vcpu_is_illegal_gpa(vcpu, base) && !(base & 0x7f);
+	return kvm_vcpu_is_legal_aligned_gpa(vcpu, base, 128);
 }
 
 static inline void pt_load_msr(struct pt_ctx *ctx, u32 addr_range)
-- 
2.30.0.365.g02bc693789-goog

