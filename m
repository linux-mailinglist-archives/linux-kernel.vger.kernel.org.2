Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D4C3B0C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhFVSEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbhFVSEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:04:11 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20738C0604C7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:19 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id cj11-20020a056214056bb029026a99960c7aso13382035qvb.22
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ZjfAtztgIxSnkfwWudgTHhql9ALcAbuUdFL41aYtPBI=;
        b=csSsNrTm7SI12ppYN58JeYha3x+cE+fgCutJGEvssLDjbBEMULDn1BwPwszMlXx1GB
         6+lYsiYTW4zTUgzVS6UFclb9K1iRvv+VzsYeVjAtPSOGbHq1+lowv20Ckt3x2RyPnGLm
         D8oP2XMw2uUruTasrKXEpjXmsuxJlaShM13diQbc19bSuzd86my16ue/NCBb+zoh8p+7
         8uMk+rhOQITvUfGXvyag8v/fQH/naHWyyk9WIg+WBPz10Cg4x5QhTdhWCisCZcfwTTeb
         NzXrODE/xUOf+eNwhdPjsCfeKJi6zWf4u0uvNPRju9jEpids20Q5QnkV1pGyDoZdVayb
         8xmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ZjfAtztgIxSnkfwWudgTHhql9ALcAbuUdFL41aYtPBI=;
        b=gCZksxKQfz89iJFTNFIYoq4eqNETu3PakJn5fdAKJlWQAOZsl+rA8tVGv79EVpuUQA
         vvcvcgPBl7jjgOJrNRf4oZh8FtBi6hWMotIlGpGtIthatlb5jmf9IUQZbylFIxUa+wg9
         sdORC8Ika9nWjA6spd9tVg6CRo3CyGpz0OBVHi/M/1x4GsGPmUdrtPf265U6I8XXjrC6
         lQXcMgHtS3+isMVoipczH8PcrHF8PvRFoP5tX56a8MFQ76djloiNESDRwHCsM1GbuSq0
         KqvoFDlXAfYhcTKaLvMwQf1CNt8Fnu26RPHh+g/rn3Hn6tRAOZyReCniTgIRK2DYh5SY
         EvwQ==
X-Gm-Message-State: AOAM5313HIYOK7SzdOFrbBgqHyqQl18k1Qxr4xE9ZGp5EIgk5I4tk/Lw
        AINIr09SWD1FtxIrJsn85QTX5egeYao=
X-Google-Smtp-Source: ABdhPJxXx+Wwn/dBmayYyuiHxcuuIHWJp1yEqrDn8Bw02FbchoW38HiSb1lW7Cnc9zkgBeCHHlIg9YNn/PM=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:5722:92ce:361f:3832])
 (user=seanjc job=sendgmr) by 2002:a25:ab91:: with SMTP id v17mr6397028ybi.512.1624384758232;
 Tue, 22 Jun 2021 10:59:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 10:57:21 -0700
In-Reply-To: <20210622175739.3610207-1-seanjc@google.com>
Message-Id: <20210622175739.3610207-37-seanjc@google.com>
Mime-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 36/54] KVM: x86/mmu: Use MMU's role/role_regs to compute
 context's metadata
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the MMU's role and role_regs to calculate the MMU's guest root level
and NX bit.  For some flows, the vCPU state may not be correct (or
relevant), e.g. EPT doesn't interact with EFER.NX and nested NPT will
configure the guest_mmu with possibly-stale vCPU state.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 67aa19ab628d..30cbc6cdb0db 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3948,8 +3948,7 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 				 max_level, true);
 }
 
-static void nonpaging_init_context(struct kvm_vcpu *vcpu,
-				   struct kvm_mmu *context)
+static void nonpaging_init_context(struct kvm_mmu *context)
 {
 	context->page_fault = nonpaging_page_fault;
 	context->gva_to_gpa = nonpaging_gva_to_gpa;
@@ -4513,14 +4512,13 @@ static void update_last_nonleaf_level(struct kvm_mmu *mmu)
 		mmu->last_nonleaf_level++;
 }
 
-static void paging64_init_context_common(struct kvm_vcpu *vcpu,
-					 struct kvm_mmu *context,
+static void paging64_init_context_common(struct kvm_mmu *context,
 					 int root_level)
 {
-	context->nx = is_nx(vcpu);
+	context->nx = is_efer_nx(context);
 	context->root_level = root_level;
 
-	MMU_WARN_ON(!is_pae(vcpu));
+	WARN_ON_ONCE(!is_cr4_pae(context));
 	context->page_fault = paging64_page_fault;
 	context->gva_to_gpa = paging64_gva_to_gpa;
 	context->sync_page = paging64_sync_page;
@@ -4528,17 +4526,16 @@ static void paging64_init_context_common(struct kvm_vcpu *vcpu,
 	context->direct_map = false;
 }
 
-static void paging64_init_context(struct kvm_vcpu *vcpu,
-				  struct kvm_mmu *context)
+static void paging64_init_context(struct kvm_mmu *context,
+				  struct kvm_mmu_role_regs *regs)
 {
-	int root_level = is_la57_mode(vcpu) ?
-			 PT64_ROOT_5LEVEL : PT64_ROOT_4LEVEL;
+	int root_level = ____is_cr4_la57(regs) ? PT64_ROOT_5LEVEL :
+						 PT64_ROOT_4LEVEL;
 
-	paging64_init_context_common(vcpu, context, root_level);
+	paging64_init_context_common(context, root_level);
 }
 
-static void paging32_init_context(struct kvm_vcpu *vcpu,
-				  struct kvm_mmu *context)
+static void paging32_init_context(struct kvm_mmu *context)
 {
 	context->nx = false;
 	context->root_level = PT32_ROOT_LEVEL;
@@ -4549,10 +4546,9 @@ static void paging32_init_context(struct kvm_vcpu *vcpu,
 	context->direct_map = false;
 }
 
-static void paging32E_init_context(struct kvm_vcpu *vcpu,
-				   struct kvm_mmu *context)
+static void paging32E_init_context(struct kvm_mmu *context)
 {
-	paging64_init_context_common(vcpu, context, PT32E_ROOT_LEVEL);
+	paging64_init_context_common(context, PT32E_ROOT_LEVEL);
 }
 
 static union kvm_mmu_extended_role kvm_calc_mmu_role_ext(struct kvm_vcpu *vcpu,
@@ -4712,13 +4708,13 @@ static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *conte
 	context->mmu_role.as_u64 = new_role.as_u64;
 
 	if (!____is_cr0_pg(regs))
-		nonpaging_init_context(vcpu, context);
+		nonpaging_init_context(context);
 	else if (____is_efer_lma(regs))
-		paging64_init_context(vcpu, context);
+		paging64_init_context(context, regs);
 	else if (____is_cr4_pae(regs))
-		paging32E_init_context(vcpu, context);
+		paging32E_init_context(context);
 	else
-		paging32_init_context(vcpu, context);
+		paging32_init_context(context);
 
 	if (____is_cr0_pg(regs)) {
 		reset_rsvds_bits_mask(vcpu, context);
-- 
2.32.0.288.g62a8d224e6-goog

