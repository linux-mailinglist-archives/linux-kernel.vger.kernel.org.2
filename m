Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3371E369E33
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244305AbhDXAzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244248AbhDXAxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:53:49 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C62C06129F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:18 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id 99-20020a0c80ec0000b029017de514d56fso19459565qvb.17
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=+baILf2lXS2iWNLfTisgtic2CRjWJPJ8uCOLhPpc9SM=;
        b=nmztxv0y6RS5IsfCFItQFXpjcVSs2MxcwJHs9zE4Qs/AQCSej81PHB+CNuIS3XWNRF
         Ls/n88PLlbH+xcoOF3lKpGHR20LCj8fkdTrgGei7O5WxK7+CB6LWWlQvWrXIYLNIT6/j
         G98m3rjapaIF8hKRKdlxlllygjdXnZ2nSdf4bmDIH5nrqNIo21herfLIHPemuwqbdFr9
         P7HiyM9BSsxY2brAkpPL7WYR0EkyuR7darUnbAU8b89NhKyBwiM4GdNml9IJtWccn1lC
         h4JVzW7KWzEvigm9W2yA7Gtu0PCavzqkiSuTZ77K20tnEEFS053AW4Ts640tx2oaHrfj
         2z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=+baILf2lXS2iWNLfTisgtic2CRjWJPJ8uCOLhPpc9SM=;
        b=SuxkkSs35I0Eg8u67YNx4yZ5VJoX0DBMrJPSekeszg2yLZ9i2iX6/8H5ypZLUy2sep
         tnEJzstFGnVfiSUIv7kAxZayIBUjE062buvI6dODf3AsdpiAoaCCV6u3tAuJ1nTqlj3B
         X1GczPX9OdKp9+FUpAgv+uC09L8yNu2ZefDHPeFkhGLeOMloNMkCu+KZzw53WdpHdzJ0
         K/62AbmvZlRkC7E9da/jiGCahPlFawlPo5Q7rqHbK5YVpXwucL1aiQvhBHIS0LdBIFM8
         QiMVU5RSLBynhkHVvnUd8q9pEThf6InhFzO532i6x+34iivYkbbRSdIZm7qHf2GzF6rY
         jRGQ==
X-Gm-Message-State: AOAM532ax4npRTMFoynNUKpL5oYO+JgmNFeGMiOmQO7qiJj61VkQMtY0
        W5UfSRYev9KZh4wXHmrFEa/+FGI8tNQ=
X-Google-Smtp-Source: ABdhPJzcHLkaOfdICkyC5H3BnUMovLq0F9V3DSKROkZFnCWd8Ri859BzA6rNRz4oQHCVIpXu3EOFV0KYF3o=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a0c:ea48:: with SMTP id u8mr7077384qvp.47.1619225297836;
 Fri, 23 Apr 2021 17:48:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:37 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-36-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 35/43] KVM: x86: Move setting of sregs during vCPU RESET/INIT
 to common x86
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

Move the setting of CR0, CR4, EFER, RFLAGS, and RIP from vendor code to
common x86.  VMX and SVM now have near-identical sequences, the only
difference between that VMX updates the exception bitmap.  Updating the
bitmap on SVM is unnecessary, but benign.  Unfortunately it can't be left
behind in VMX due to the need to update exception intercepts after the
control registers are set.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 6 ------
 arch/x86/kvm/vmx/vmx.c | 9 ---------
 arch/x86/kvm/x86.c     | 8 ++++++++
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 996a6b03e338..23f880268ff5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1204,12 +1204,6 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 	init_sys_seg(&save->ldtr, SEG_TYPE_LDT);
 	init_sys_seg(&save->tr, SEG_TYPE_BUSY_TSS16);
 
-	svm_set_cr0(vcpu, X86_CR0_NW | X86_CR0_CD | X86_CR0_ET);
-	svm_set_cr4(vcpu, 0);
-	svm_set_efer(vcpu, 0);
-	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
-	vcpu->arch.regs[VCPU_REGS_RIP] = 0x0000fff0;
-
 	if (npt_enabled) {
 		/* Setup VMCB for Nested Paging */
 		control->nested_ctl |= SVM_NESTED_CTL_NP_ENABLE;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8c982e049cbb..d8afca144e11 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4557,9 +4557,6 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 		vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
 	}
 
-	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
-	kvm_rip_write(vcpu, 0xfff0);
-
 	vmcs_writel(GUEST_GDTR_BASE, 0);
 	vmcs_write32(GUEST_GDTR_LIMIT, 0xffff);
 
@@ -4587,12 +4584,6 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 
 	kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
 
-	vmx_set_cr0(vcpu, X86_CR0_NW | X86_CR0_CD | X86_CR0_ET);
-	vmx_set_cr4(vcpu, 0);
-	vmx_set_efer(vcpu, 0);
-
-	vmx_update_exception_bitmap(vcpu);
-
 	vpid_sync_context(vmx->vpid);
 	if (init_event)
 		vmx_clear_hlt(vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 167c650d1187..97d8e3e74bab 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10499,6 +10499,14 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 
 	static_call(kvm_x86_vcpu_reset)(vcpu, init_event);
 
+	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
+	kvm_rip_write(vcpu, 0xfff0);
+
+	static_call(kvm_x86_set_cr0)(vcpu, X86_CR0_NW | X86_CR0_CD | X86_CR0_ET);
+	static_call(kvm_x86_set_cr4)(vcpu, 0);
+	static_call(kvm_x86_set_efer)(vcpu, 0);
+	static_call(kvm_x86_update_exception_bitmap)(vcpu);
+
 	if (kvm_cr0_mmu_role_changed(old_cr0, kvm_read_cr0(vcpu)) ||
 	    kvm_cr4_mmu_role_changed(old_cr4, kvm_read_cr4(vcpu)))
 		kvm_mmu_reset_context(vcpu);
-- 
2.31.1.498.g6c1eba8ee3d-goog

