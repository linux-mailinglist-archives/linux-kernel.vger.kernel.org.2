Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F5F369E23
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244620AbhDXAx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbhDXAvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:51:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43ADC06137A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o187-20020a2528c40000b02904e567b4bf7eso26380051ybo.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=OQ6Lvv5hUZLxy6LtPOKbAp59CLYR6ZOdLmQpGf/gsyE=;
        b=VAMmZddflONjj4+4i9x1eMZDZlg0Fk3FfXR97b9eh9OiOqWVMVlFB8OtX0Ia7HSXal
         cJkfdUeFpYIwSnMrVpVCJK+crTHF+kQ2qBUtaqCVXMTsnjwN+c6TmZUmBkWUMbpp05cY
         HJ5yxF67I+gB4biY/jxoqjlReB5Wo4gjt1zS4mrf3RQA4PIFpgfTuLVYAWV/74A7v0vt
         NHWWoDjT0YsykzXSQ4s7BNhMFN8dVFC+hJsXalhoM1r9NnDRxDw5jpPYBYHLCiuDcp+D
         Ff+B/dinV9IGDKYxxpki5nhSlqfIbzamUKNTdrMzm3r/oyON3ARkh3O6ZulmtR/HX32m
         2Xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=OQ6Lvv5hUZLxy6LtPOKbAp59CLYR6ZOdLmQpGf/gsyE=;
        b=ljtxYESVJKfvIUg66cQLe9+lXm0Rmd/EU+vEp9D7pqVyoIU3TuohgD31cS7lJjwrQy
         Y8NHa+5xd8hf6+4b7u6WguZoyOQ/sQZCHZyxVZuyp041e5BZmSHNkW+wutxBteMdL/e6
         BHCFVVEQugKUyR39EAZqz1ZRUq/6SIUTRO0uTxIEOp4onGa1Zoz5CHEhOGWFWa36Lgdq
         T1GOIRwY6EQmsET23KstSEhAn5u9kA4Z9VkIsvMT7hqaXESWUfXU/1vZIWdUiWIdMIH/
         CfEubaf9/YVUBif/2gvPAlJ+oaJAFBDamjn6Alqu32oXNTA7t/mlVY90O/7o0dbgnLnl
         0XnA==
X-Gm-Message-State: AOAM533QGc+gmg7KImtU8qvCdy/85Nx0kQy5WissWNCMeY9pLtwVFutS
        m9B2o7zskFqcCTlfJB1hhRhnxUwv3Po=
X-Google-Smtp-Source: ABdhPJz973IcJu9CuRU33WhIG6gKNEX6LxtNGUTLA8kxQ4jqGktu9x6SnWAkTtYu/q0TVa56P20RsnBL5d4=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a05:6902:4d4:: with SMTP id
 v20mr9489642ybs.420.1619225282067; Fri, 23 Apr 2021 17:48:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:30 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-29-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 28/43] KVM: nVMX: Don't evaluate "emulation required" on VM-Exit
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

Use the "internal" variants of setting segment registers when stuffing
state on nested VM-Exit in order to skip the "emulation required"
updates.  VM-Exit must always go to protected mode, and all segments are
mostly hardcoded (to valid values) on VM-Exit.  The bits of the segments
that aren't hardcoded are explicitly checked during VM-Enter, e.g. the
selector RPLs must all be zero.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 16 ++++++++--------
 arch/x86/kvm/vmx/vmx.c    |  6 ++----
 arch/x86/kvm/vmx/vmx.h    |  2 +-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 32126fa0c4d8..f811bb7f2dc3 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4245,7 +4245,7 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 		seg.l = 1;
 	else
 		seg.db = 1;
-	vmx_set_segment(vcpu, &seg, VCPU_SREG_CS);
+	__vmx_set_segment(vcpu, &seg, VCPU_SREG_CS);
 	seg = (struct kvm_segment) {
 		.base = 0,
 		.limit = 0xFFFFFFFF,
@@ -4256,17 +4256,17 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 		.g = 1
 	};
 	seg.selector = vmcs12->host_ds_selector;
-	vmx_set_segment(vcpu, &seg, VCPU_SREG_DS);
+	__vmx_set_segment(vcpu, &seg, VCPU_SREG_DS);
 	seg.selector = vmcs12->host_es_selector;
-	vmx_set_segment(vcpu, &seg, VCPU_SREG_ES);
+	__vmx_set_segment(vcpu, &seg, VCPU_SREG_ES);
 	seg.selector = vmcs12->host_ss_selector;
-	vmx_set_segment(vcpu, &seg, VCPU_SREG_SS);
+	__vmx_set_segment(vcpu, &seg, VCPU_SREG_SS);
 	seg.selector = vmcs12->host_fs_selector;
 	seg.base = vmcs12->host_fs_base;
-	vmx_set_segment(vcpu, &seg, VCPU_SREG_FS);
+	__vmx_set_segment(vcpu, &seg, VCPU_SREG_FS);
 	seg.selector = vmcs12->host_gs_selector;
 	seg.base = vmcs12->host_gs_base;
-	vmx_set_segment(vcpu, &seg, VCPU_SREG_GS);
+	__vmx_set_segment(vcpu, &seg, VCPU_SREG_GS);
 	seg = (struct kvm_segment) {
 		.base = vmcs12->host_tr_base,
 		.limit = 0x67,
@@ -4274,11 +4274,11 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 		.type = 11,
 		.present = 1
 	};
-	vmx_set_segment(vcpu, &seg, VCPU_SREG_TR);
+	__vmx_set_segment(vcpu, &seg, VCPU_SREG_TR);
 
 	memset(&seg, 0, sizeof(seg));
 	seg.unusable = 1;
-	vmx_set_segment(vcpu, &seg, VCPU_SREG_LDTR);
+	__vmx_set_segment(vcpu, &seg, VCPU_SREG_LDTR);
 
 	kvm_set_dr(vcpu, 7, 0x400);
 	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 37bfa20a04dd..594975dc3f94 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2827,8 +2827,6 @@ static __init int alloc_kvm_area(void)
 	return 0;
 }
 
-static void __vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
-
 static void fix_pmode_seg(struct kvm_vcpu *vcpu, int seg,
 		struct kvm_segment *save)
 {
@@ -3401,7 +3399,7 @@ static u32 vmx_segment_access_rights(struct kvm_segment *var)
 	return ar;
 }
 
-static void __vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg)
+void __vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	const struct kvm_vmx_segment_field *sf = &kvm_vmx_segment_fields[seg];
@@ -3438,7 +3436,7 @@ static void __vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, in
 	vmcs_write32(sf->ar_bytes, vmx_segment_access_rights(var));
 }
 
-void vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg)
+static void vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg)
 {
 	__vmx_set_segment(vcpu, var, seg);
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 19fe09fad2fe..1283ad0e592d 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -376,7 +376,7 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
 void set_cr4_guest_host_mask(struct vcpu_vmx *vmx);
 void ept_save_pdptrs(struct kvm_vcpu *vcpu);
 void vmx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
-void vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
+void __vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
 u64 construct_eptp(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level);
 
 void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu);
-- 
2.31.1.498.g6c1eba8ee3d-goog

