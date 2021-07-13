Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8323C74C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhGMQhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbhGMQg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:36:58 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43872C0613AE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:05 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d11-20020ac851cb0000b02902536d2bea0fso7923105qtn.19
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=BViIrq7/naaabix9eGtnsasIB9sZItVFvJ7J2DJEvDU=;
        b=ppznS5ugBlkpj+tQLECKl+QN/zTYkSxBGDVy/qaWcGfKQF3pHSPIMK9qk9f2GQikti
         Rlq/803lQYl1woPs1eam7z0RNaTdBIJRVT9hPb6z7rUWro/rEV92gg0yn1HWGr2lIwrO
         Z0Q/sd26v8m8ezlWllo3x2DDPmZcedwzF0qTeJYTYa1Zf2w7iGG9yKlsSKq2MgXCmD+U
         IN8m4KRzXSK+Jjhp6rmY/eEKkIbsldEgkKlY48hiyzDM6c6XNgtQoj7WMW8dNQhu0cvb
         nFZNN1wTe7qEBFHQdL+wOacaOqeE/vzt/mzweMcOUIAKVhuSUsKPdu2bbmQH9DlGWbKC
         oNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=BViIrq7/naaabix9eGtnsasIB9sZItVFvJ7J2DJEvDU=;
        b=jAVhgAxc9n48ff9L1XhMv97FvkOLUdzkMIPs9BFsInaXEhgetVB/q4xC13sgWtkILg
         7lz613zZUXS1wTOok+elhjnFJx7Ul/1K3XkHaFSa5y3YRVMXXbKKV0+idAV2cuxpSt1R
         uhgJgM69jFFssj/qw6e3ZJzX2YIY7CwTESZe6TYGPbg9yoOslV8tj6TsbCWTb0Z0kZHM
         LJJ2LgSNgTDpcRA4CCa5AWVyBQQxNrpRxsZHYwos8Nr5UjtWK+YNyVfbcW4VEgj8qw8A
         HvOZ3Ff/Z3nwn1gERa80jbCeLgz+JZriRXb496siy2UcAZumNAqjZPygjhQs+yWu7m/d
         U6EA==
X-Gm-Message-State: AOAM530h7hD2KY/IQVDGB4GwOf8gcT5nrvE0bTHYROjRY5wRYwPQyD1d
        4kboA324fobSp9ofB5uLXkF41BYauKY=
X-Google-Smtp-Source: ABdhPJxpNGefM+IAg3Y2fzT15N+qSYQC/SIzrDhkYXcNhqrVOgJxPBZGyV3jq0fM6xMJTqJVEYsCmDfmR5s=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a0c:f802:: with SMTP id r2mr5856501qvn.24.1626194044333;
 Tue, 13 Jul 2021 09:34:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:32:54 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-17-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 16/46] KVM: VMX: Stuff vcpu->arch.apic_base directly at
 vCPU RESET
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

Write vcpu->arch.apic_base directly instead of bouncing through
kvm_set_apic_base().  This is a glorified nop, and is a step towards
cleaning up the mess that is local APIC creation.

When using an in-kernel APIC, kvm_create_lapic() explicitly sets
vcpu->arch.apic_base to MSR_IA32_APICBASE_ENABLE to avoid its own
kvm_lapic_set_base() call in kvm_lapic_reset() from triggering state
changes.  That call during RESET exists purely to set apic->base_address
to the default base value.  As a result, by the time VMX gets control,
the only missing piece is the BSP bit being set for the reset BSP.

For a userspace APIC, there are no side effects to process (for the APIC).

In both cases, the call to kvm_update_cpuid_runtime() is a nop because
the vCPU hasn't yet been exposed to userspace, i.e. there can't be any
CPUID entries.

No functional change intended.

Reviewed-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 26c0e776827c..e6cc389ec697 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4387,7 +4387,6 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	struct msr_data apic_base_msr;
 	u32 eax, dummy;
 	u64 cr0;
 
@@ -4408,12 +4407,10 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	kvm_set_cr8(vcpu, 0);
 
 	if (!init_event) {
-		apic_base_msr.data = APIC_DEFAULT_PHYS_BASE |
-				     MSR_IA32_APICBASE_ENABLE;
+		vcpu->arch.apic_base = APIC_DEFAULT_PHYS_BASE |
+				       MSR_IA32_APICBASE_ENABLE;
 		if (kvm_vcpu_is_reset_bsp(vcpu))
-			apic_base_msr.data |= MSR_IA32_APICBASE_BSP;
-		apic_base_msr.host_initiated = true;
-		kvm_set_apic_base(vcpu, &apic_base_msr);
+			vcpu->arch.apic_base |= MSR_IA32_APICBASE_BSP;
 	}
 
 	vmx_segment_cache_clear(vmx);
-- 
2.32.0.93.g670b81a890-goog

