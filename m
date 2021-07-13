Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D243C74CD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhGMQhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbhGMQhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:37:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69921C0613BE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h1-20020a255f410000b02905585436b530so27738089ybm.21
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ALNwA0nn2jLAQkKVjta8iUWZIOtO+j8qUemSoasWZMM=;
        b=tsKrHbB6gm1pLlzWOE5P/IRXR75BgxSuXuWVMouLiiTJ1WzDTscsVtINWPa43tZ5BD
         jAAZb2xZjUDp1pu1gd5X9ZzGy2QB0llRnWqPUu41NVnV+Utj6vmWcIOVkRCRTAm6Wgob
         7Edon0eyQ6UzWs9KN+QKVBD/X2uXu/wxcW9dIwZMvEtwN6QupwXnc3Ayt2w9DBwYyEU0
         YB2pUdfAdaYmM9gsELj58ApUQ8TesWVWFAl+rTB6IbvgLkaGOv3tqAPhC5zJyWBWnwD5
         TQ9Z4s3JZd8NetNeY2i+uP4XWNIHL6TptPfh9BdSZDVJZWYcf5+2ZPJH4m6f3l1iuACd
         u1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ALNwA0nn2jLAQkKVjta8iUWZIOtO+j8qUemSoasWZMM=;
        b=FCPLjGoxJScygex3JaWzNW38S+ogvcjYUQhCjGwUWxC5eiAmrAOXtTO6Qa4SR3kW39
         fo4MBrLdiifrhsVmQWZUi53UeaevxX7JLVaRg6Hc/Wam1FtEhsv/Sr7CoTDYwJwtS/TJ
         kFLM8j2Y64p1nMVU+XyG8bfg0M0l9SWnAYiLLy1CNQip5U3WxoDr+4RMCGq93zpMxV2W
         OqNab4L0hsAHhuWr5cps15yOHXM11BDL2QQx5bA61c8hg20fzNZJjI8wl2bpky0wLDZY
         pm+2/FRVM4CuVWRtEM7FRBpBxyu2vS2+2PwHBOyKL5XmVM7IDmHvdhQJiymHGPh+v0px
         KcMg==
X-Gm-Message-State: AOAM533e8nKtOAAb4th8I591mJPJ3sLfAHgEgp7plvLU0Z+0v7o/4R7K
        OGkIfr0Pp7S+uN7U0TnjtXdxYjAhXWA=
X-Google-Smtp-Source: ABdhPJyIhV0xW5ndqPkBZyaoFrVwHHdjADouAB+hvpbP8ojYPVZtH7kxt44HS/FDUwcOTc564glOCn43Ku8=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a25:df06:: with SMTP id w6mr7173312ybg.361.1626194057638;
 Tue, 13 Jul 2021 09:34:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:33:01 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-24-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 23/46] KVM: VMX: Fold ept_update_paging_mode_cr0() back
 into vmx_set_cr0()
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

Move the CR0/CR3/CR4 shenanigans for EPT without unrestricted guest back
into vmx_set_cr0().  This will allow a future patch to eliminate the
rather gross stuffing of vcpu->arch.cr0 in the paging transition cases
by snapshotting the old CR0.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ed631564c651..db70fe463aa1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2994,27 +2994,6 @@ void ept_save_pdptrs(struct kvm_vcpu *vcpu)
 	kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
 }
 
-static void ept_update_paging_mode_cr0(unsigned long cr0, struct kvm_vcpu *vcpu)
-{
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-
-	if (!kvm_register_is_available(vcpu, VCPU_EXREG_CR3))
-		vmx_cache_reg(vcpu, VCPU_EXREG_CR3);
-	if (!(cr0 & X86_CR0_PG)) {
-		/* From paging/starting to nonpaging */
-		exec_controls_setbit(vmx, CPU_BASED_CR3_LOAD_EXITING |
-					  CPU_BASED_CR3_STORE_EXITING);
-		vcpu->arch.cr0 = cr0;
-		vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
-	} else if (!is_paging(vcpu)) {
-		/* From nonpaging to paging */
-		exec_controls_clearbit(vmx, CPU_BASED_CR3_LOAD_EXITING |
-					    CPU_BASED_CR3_STORE_EXITING);
-		vcpu->arch.cr0 = cr0;
-		vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
-	}
-}
-
 void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -3044,8 +3023,23 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	}
 #endif
 
-	if (enable_ept && !is_unrestricted_guest(vcpu))
-		ept_update_paging_mode_cr0(cr0, vcpu);
+	if (enable_ept && !is_unrestricted_guest(vcpu)) {
+		if (!kvm_register_is_available(vcpu, VCPU_EXREG_CR3))
+			vmx_cache_reg(vcpu, VCPU_EXREG_CR3);
+		if (!(cr0 & X86_CR0_PG)) {
+			/* From paging/starting to nonpaging */
+			exec_controls_setbit(vmx, CPU_BASED_CR3_LOAD_EXITING |
+						  CPU_BASED_CR3_STORE_EXITING);
+			vcpu->arch.cr0 = cr0;
+			vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
+		} else if (!is_paging(vcpu)) {
+			/* From nonpaging to paging */
+			exec_controls_clearbit(vmx, CPU_BASED_CR3_LOAD_EXITING |
+						    CPU_BASED_CR3_STORE_EXITING);
+			vcpu->arch.cr0 = cr0;
+			vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
+		}
+	}
 
 	vmcs_writel(CR0_READ_SHADOW, cr0);
 	vmcs_writel(GUEST_CR0, hw_cr0);
-- 
2.32.0.93.g670b81a890-goog

