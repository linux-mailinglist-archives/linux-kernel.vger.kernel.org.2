Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D98D3C74EA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhGMQij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbhGMQi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:38:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92931C0613BD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w5-20020a0569021005b029055b51419c7dso27652503ybt.23
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=WzjACxS3vJSqCJVMr5JKsyBcfyvMVtL3FJuhC43+sT4=;
        b=pSSOz/N1wBCqRCB9767Mr2YSJDrKkYTfm5X9v0AonKgBoIiGxz1CeUEyFH5Zk8aXZl
         2rTjJl90nXqe2QhywLVjRUzZU5KHq4fzPmvbkUsbOzl7GIxVsNd2HIvPlnjvWoQlTEe8
         E2pURX7CKvGnQgIV7NFRGJMcEglu6rRWMdAx/CYQR7lv9DItpUg2pP54rgU3ilk2okiv
         Cyiy7cv8z1OKEMrI8DZnAwNAHv/XoAErHdtKCl6xl4JtTMQvqepGPlwLTo2czym+pavh
         DaJzB3A3B4SuwRpaWyxIlNfuK5g0CEDEWpHJ2TRHd0XEKUXacBOXUlmIIxOmd5JgYcr7
         tU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=WzjACxS3vJSqCJVMr5JKsyBcfyvMVtL3FJuhC43+sT4=;
        b=cI92oCI0Qaz5abKDiHXPWGkvFIP3p+tQbi4aDtfqcVTfsiTmkhjc2e7ODCsTWtFa3x
         p5w7Ikw+bwgWe0OoUHpLsefFnpdFE/YCkAzcQkMNuJHYw2mgqlGbWEppnP3bOU9f5yb4
         h+3G7P2vM++zuDYxRA/h9pH5BYnHIrkdAIreq/SRf5PvRmWcqnu61gjsxlPxXtg4/d8v
         z9xujcU+grn2A34c8v9aVMSrUR5vQujDCNhMrVmFp+UmRijLbXdx3cyMUmKLFrrhjk34
         KiGraLX6S49rLVpSN8HugIcZgzIKWyoyX0wNX+wC/7CbhNSs7nfAQq5xTURI+QGBmgZe
         nuzw==
X-Gm-Message-State: AOAM533nHwBMNquh0W1f6FPgUMgGQpijaiXMkwe6zbJPloKn2Qwwp49P
        Ahsx8+qNVcz3Vx+GunXHFCf/4YJs64s=
X-Google-Smtp-Source: ABdhPJye3BexlkfrOe53+nGwvSDofxLGrCXkzmJ1TZUWM1skavM0IHGrLjAAIkgdLaNtPaZR+KShBwMKQ/w=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a25:c78f:: with SMTP id w137mr7097023ybe.381.1626194087757;
 Tue, 13 Jul 2021 09:34:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:33:16 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-39-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 38/46] KVM: nVMX: Remove obsolete MSR bitmap refresh at
 nested transitions
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
index a77cfc8bcf11..0d0dd6580cfd 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4305,9 +4305,6 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	kvm_set_dr(vcpu, 7, 0x400);
 	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
 
-	if (cpu_has_vmx_msr_bitmap())
-		vmx_update_msr_bitmap(vcpu);
-
 	if (nested_vmx_load_msr(vcpu, vmcs12->vm_exit_msr_load_addr,
 				vmcs12->vm_exit_msr_load_count))
 		nested_vmx_abort(vcpu, VMX_ABORT_LOAD_HOST_MSR_FAIL);
@@ -4386,9 +4383,6 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 
 	kvm_mmu_reset_context(vcpu);
 
-	if (cpu_has_vmx_msr_bitmap())
-		vmx_update_msr_bitmap(vcpu);
-
 	/*
 	 * This nasty bit of open coding is a compromise between blindly
 	 * loading L1's MSRs using the exit load lists (incorrect emulation
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7e99535a4cbb..f605b43d28e1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3865,7 +3865,7 @@ static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu, u8 mode)
 	}
 }
 
-void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu)
+static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u8 mode = vmx_msr_bitmap_mode(vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index b584e41bed44..1b3dd5ddf235 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -378,7 +378,6 @@ u64 construct_eptp(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level);
 
 bool vmx_guest_inject_ac(struct kvm_vcpu *vcpu);
 void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu);
-void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
 bool vmx_nmi_blocked(struct kvm_vcpu *vcpu);
 bool vmx_interrupt_blocked(struct kvm_vcpu *vcpu);
 bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu);
-- 
2.32.0.93.g670b81a890-goog

