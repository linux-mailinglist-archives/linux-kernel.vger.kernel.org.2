Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F784449FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 21:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhKCVCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 17:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhKCVCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 17:02:07 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A75C061203
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 13:59:30 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id e6-20020a637446000000b002993ba24bbaso2111412pgn.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 13:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J5vfKF6W1D5gAeKm4lwrd0QK8zJYwxNEd4UBSUYOqrg=;
        b=hDN95wHzvTbJpve1QOZR6g6uC3sJG+J62rOJrTmrUAvLStwbBBBYKK7dYMU58dR7Pa
         tqxbfn1C45I801HzsjnnOE06SOdzPGy+f/8206Rcx2T9f4EmMfBLjou2X1FxnKjZMLZh
         QVtzJeGBVa8JjJClRNWdAWF0YbpMxhhkyKX+ifSO9sGFo2tDayg5NCiVYFMxYEPtGEvd
         h6Z5AquW377lu23nP+LB0towSMZmBRQ8NVHWPvxCjc5fQVPtzglUjWONSJmMKGuhSuJB
         qUgNilQTMQHwQDmBOvB7uFno0NNxzA92sjXfk8n3BOPG2FW1Vrf0tOkZbDm8zC5aDQq+
         BSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J5vfKF6W1D5gAeKm4lwrd0QK8zJYwxNEd4UBSUYOqrg=;
        b=ayYP8kM78M75FhYqRJ2Mdgyf/OLF8jGQ/HTXQ/FHjhbZgPp8D3QtxDQCU0Ln01vzg7
         cub0C9sLVcAFcOoTfKjJn0jPmZoLbWjLi+XK89t3NMVaDwvX3/WKUDOpjFY7/epanirn
         7ntyRGx4zpbk51osW0X280yXWETSmSQJFCpbsBlM5sNWGLUt0NhNO3QZo8FIgx63uLuY
         rvb8H89LzhWW8Q3K60RIuRaxsCIqIux0sz4aHENKgn6ESG7zf8ct93ElnEnRD9MzwDLZ
         1H76RYBijd6+WFQ7ip4nPu0WLln7Ipa53Rwl9ZzQJ5eMU/T+ZvuKEUA1SAZf6X9bSmIW
         W66g==
X-Gm-Message-State: AOAM531QneI8uflRETEGpHD7TGDuJy5vm4LESBGsDAHqZspEPQ8ShQyf
        NcdJGnltYn6cBc/Cy3bUu3mGAx0RTTPw
X-Google-Smtp-Source: ABdhPJxXmBmInBVhd+5vuxRRQp1JoR7j588ddxrRxk4y2EDke114rveLBcdn8DAL3DZszVomTr/91YT0bz7o
X-Received: from vipinsh.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:36b0])
 (user=vipinsh job=sendgmr) by 2002:a17:902:d885:b0:141:b4ca:7c80 with SMTP id
 b5-20020a170902d88500b00141b4ca7c80mr32624528plz.88.1635973169681; Wed, 03
 Nov 2021 13:59:29 -0700 (PDT)
Date:   Wed,  3 Nov 2021 20:59:10 +0000
In-Reply-To: <20211103205911.1253463-1-vipinsh@google.com>
Message-Id: <20211103205911.1253463-2-vipinsh@google.com>
Mime-Version: 1.0
References: <20211103205911.1253463-1-vipinsh@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 1/2] KVM: VMX: Add a wrapper to read index of GPR for
 INVPCID, INVVPID, and INVEPT
From:   Vipin Sharma <vipinsh@google.com>
To:     pbonzini@redhat.com, seanjc@google.com, jmattson@google.com
Cc:     dmatlack@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

handle_invept(), handle_invvpid(), handle_invpcid() read the same reg2
on VM exit. Move them to a common wrapper function.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/x86/kvm/vmx/nested.c | 10 ++++++----
 arch/x86/kvm/vmx/vmx.c    |  4 +++-
 arch/x86/kvm/vmx/vmx.h    |  5 +++++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b4ee5e9f9e20..f73d4e31dd99 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5379,7 +5379,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 	struct {
 		u64 eptp, gpa;
 	} operand;
-	int i, r;
+	int i, r, gpr_index;
 
 	if (!(vmx->nested.msrs.secondary_ctls_high &
 	      SECONDARY_EXEC_ENABLE_EPT) ||
@@ -5392,7 +5392,8 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 		return 1;
 
 	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
-	type = kvm_register_read(vcpu, (vmx_instruction_info >> 28) & 0xf);
+	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
+	type = kvm_register_read(vcpu, gpr_index);
 
 	types = (vmx->nested.msrs.ept_caps >> VMX_EPT_EXTENT_SHIFT) & 6;
 
@@ -5459,7 +5460,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 		u64 gla;
 	} operand;
 	u16 vpid02;
-	int r;
+	int r, gpr_index;
 
 	if (!(vmx->nested.msrs.secondary_ctls_high &
 	      SECONDARY_EXEC_ENABLE_VPID) ||
@@ -5472,7 +5473,8 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 		return 1;
 
 	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
-	type = kvm_register_read(vcpu, (vmx_instruction_info >> 28) & 0xf);
+	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
+	type = kvm_register_read(vcpu, gpr_index);
 
 	types = (vmx->nested.msrs.vpid_caps &
 			VMX_VPID_EXTENT_SUPPORTED_MASK) >> 8;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 71f54d85f104..e41d207e3298 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5494,6 +5494,7 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
 		u64 pcid;
 		u64 gla;
 	} operand;
+	int gpr_index;
 
 	if (!guest_cpuid_has(vcpu, X86_FEATURE_INVPCID)) {
 		kvm_queue_exception(vcpu, UD_VECTOR);
@@ -5501,7 +5502,8 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
 	}
 
 	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
-	type = kvm_register_read(vcpu, (vmx_instruction_info >> 28) & 0xf);
+	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
+	type = kvm_register_read(vcpu, gpr_index);
 
 	if (type > 3) {
 		kvm_inject_gp(vcpu, 0);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index e7db42e3b0ce..95c9bca45cdd 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -522,4 +522,9 @@ static inline bool vmx_guest_state_valid(struct kvm_vcpu *vcpu)
 
 void dump_vmcs(struct kvm_vcpu *vcpu);
 
+static inline int vmx_get_instr_info_reg2(u32 vmx_instr_info)
+{
+	return (vmx_instr_info >> 28) & 0xf;
+}
+
 #endif /* __KVM_X86_VMX_H */
-- 
2.33.1.1089.g2158813163f-goog

