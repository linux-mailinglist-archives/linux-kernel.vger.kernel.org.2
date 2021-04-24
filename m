Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA03369E3B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244674AbhDXAzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244665AbhDXAyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:54:19 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE81C0612A4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:22 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id l19-20020a37f5130000b02902e3dc23dc92so11864891qkk.15
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=zLhT1Olw4w4A/z5QqS68fw+vGniyRMY+4zsyez+hxb8=;
        b=X/6DdF5y6jftvjVQXXyHqgICC6xuwcEmdwIrGhWdI/3AA4IADr9ArY/5Jq5XZ1oAbh
         8ixRUMsqk+4xeYynvXcrkDb/B7vOYJ8NT8LbkbswduKbml2KNWufSoE4F5+dhO9tgo+4
         eEnW+bD9DdCzvHbuoWRej9KL9UubtQnnmdTqkXDPVnZdJ0ExfO3inh1btsCY8JPmFdss
         /Br/Yx/m3eSEniFgzGCeQjGfy0EVCzsQoGTby5iGu9Gq7LyXI5YEKxJBa7FFYbiE45lE
         C4xmu9fk9NSLHc3st2IBYkyRxnuVdD5vu4ipAlWJ7to5vKrsQ/A3XZDOjxjHsILaSUdl
         eFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=zLhT1Olw4w4A/z5QqS68fw+vGniyRMY+4zsyez+hxb8=;
        b=jW3DgnEUFuDD/cCQL4XOZW8acJWKBaiLtUcHECYQZSHF4NbCi40XBVPKelcCmAplBp
         F/zKH/ZniLIl7NebOUuxhxDVjcNKAGhCWBu6ovgfEiI5Lh1pn0ceWxytLepREU9r3Y5B
         7xlsvj2IXiAx/ezRAaFMW56sltnPkiwGuqkHcorEa1T2L3krxXr+snfiTvPcX0b/yzCC
         5n1ztBTB85KFTGOgPeoTso6/OBSe78nRUN3++iyZyIr+FvGTvkVNTP7cirawvJz5zJ7v
         u1wsIMa1Cnn6hoTMLzRP8V31iLYmnFUbkOLKdj9upb3mwOukoHOlYnBPPb3pPQ+I7zbv
         QUxQ==
X-Gm-Message-State: AOAM532F0+U6qXEXBzrXWgUlEowrCS7awIyGzVu30WurAqM27BbQ2hVG
        QIJknReLYDXjV23LMlOh7PnCwGb5Thc=
X-Google-Smtp-Source: ABdhPJxREhJpQW8HpLyftkLk1ST20DVpT+NSBMDlbnY/lcznsryFA5sIGYAngsDKucwdsBX/xRGDO9Tn/8U=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a0c:ec4b:: with SMTP id n11mr7248572qvq.6.1619225302028;
 Fri, 23 Apr 2021 17:48:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:39 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-38-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 37/43] KVM: nVMX: Remove obsolete MSR bitmap refresh at nested transitions
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

Drop unnecessary MSR bitmap updates during nested transitions, as L1's
APIC_BASE MSR is not modified by the standard VM-Enter/VM-Exit flows,
and L2's MSR bitmap is managed separately.  In the unlikely event that L1
is pathological and loads APIC_BASE via the VM-Exit load list, KVM will
handle updating the bitmap in its normal WRMSR flows.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 6 ------
 arch/x86/kvm/vmx/vmx.c    | 2 +-
 arch/x86/kvm/vmx/vmx.h    | 1 -
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f811bb7f2dc3..9dcdf158a405 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4283,9 +4283,6 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	kvm_set_dr(vcpu, 7, 0x400);
 	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
 
-	if (cpu_has_vmx_msr_bitmap())
-		vmx_update_msr_bitmap(vcpu);
-
 	if (nested_vmx_load_msr(vcpu, vmcs12->vm_exit_msr_load_addr,
 				vmcs12->vm_exit_msr_load_count))
 		nested_vmx_abort(vcpu, VMX_ABORT_LOAD_HOST_MSR_FAIL);
@@ -4364,9 +4361,6 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 
 	kvm_mmu_reset_context(vcpu);
 
-	if (cpu_has_vmx_msr_bitmap())
-		vmx_update_msr_bitmap(vcpu);
-
 	/*
 	 * This nasty bit of open coding is a compromise between blindly
 	 * loading L1's MSRs using the exit load lists (incorrect emulation
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index acfb87f30979..45a013631f63 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3984,7 +3984,7 @@ static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu, u8 mode)
 	}
 }
 
-void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu)
+static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u8 mode = vmx_msr_bitmap_mode(vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 1283ad0e592d..e46df3253a21 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -380,7 +380,6 @@ void __vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
 u64 construct_eptp(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level);
 
 void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu);
-void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
 bool vmx_nmi_blocked(struct kvm_vcpu *vcpu);
 bool vmx_interrupt_blocked(struct kvm_vcpu *vcpu);
 bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu);
-- 
2.31.1.498.g6c1eba8ee3d-goog

