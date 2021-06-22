Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB1D3B0C53
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhFVSF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhFVSFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:05:12 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E493DC0698D9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:40 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id t6-20020ac80dc60000b029024e988e8277so28499qti.23
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=k+Hy19n7FuHwFcs3JayYH/6a6QV1H82GfzCUZvXtG9E=;
        b=kc43GkOoFjhxBlR2WnQizL7y/R6T20mYKUPc4GWABbmYOlM+hIYTLQly6uwfypaxcN
         hbqSMfJGPmbRYC0pc6LMOeCo2Q5wyUWTehdI26c7fwa28fuVht/I8l3tCycOpeMhGbqR
         HIvG+LqzkKzq7y2iEHXyjiW9wyKm8/017obkkSMOpK2yDqz5mgxc2qFkFiXJhgcfhzo3
         2KbnRJCbw3z50LzyZ34L258jbdmuFgi1ZkZmbxDLohfETk33DzmzjwwyCqqcQKhXOlBg
         NZgkGjCSNYK/y0II5mcoczplHqFfr+fZarq5qcPGjZkgL+sqE8I1sTaUrBOMCKxLcYex
         Qn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=k+Hy19n7FuHwFcs3JayYH/6a6QV1H82GfzCUZvXtG9E=;
        b=uIABPV1Irt2k5H3YyV5eU3LU/Uo+eC9kelVckXY2VVsNtoPVgVqCmL0vPTlgF1f+y8
         AewZudMr65EaS4hrVyqy7kcRlOFJxV3URDTaWP6Wvwzxdj1Z1WiM/vuwKcmBFlgxc1Xx
         qt93+cYEk6r3x0S+tjSlQPA42HD9ctsrggqCWZFb8DhcXvXZPKFdmxzeYmJlGzEHvEEm
         X/8I7Qm6r71auGFkv21/+tQgrC1ynJ02r1JEQb+uwZIw5XX5NpDrixHn/UGXTvftggpk
         BJCk0jLO2yaPzwiAgyTvp32BAvCbZaWuO7eHZHSnzwAstBnmkHFgBNAlJRTeOYr8xvA/
         T3eg==
X-Gm-Message-State: AOAM530Ep1WIcUkya0LMyovYQ2iYWiysJVq1upmzDPJ2wKa5kOzkDOqh
        QOXwPM4PGgnIjpy7BmS575AZRFXoWSc=
X-Google-Smtp-Source: ABdhPJzDV7t+Mio030wqwE3ZWqwSFDniRvJIygSpTKs4WI9yL6JICXgMf3/orZizQZF8JOXx/lMAOkL+95U=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:5722:92ce:361f:3832])
 (user=seanjc job=sendgmr) by 2002:a25:ca10:: with SMTP id a16mr6601987ybg.172.1624384780054;
 Tue, 22 Jun 2021 10:59:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 10:57:30 -0700
In-Reply-To: <20210622175739.3610207-1-seanjc@google.com>
Message-Id: <20210622175739.3610207-46-seanjc@google.com>
Mime-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 45/54] KVM: x86/mmu: Collapse 32-bit PAE and 64-bit statements
 for helpers
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

Skip paging32E_init_context() and paging64_init_context_common() and go
directly to paging64_init_context() (was the common version) now that
the relevant flows don't need to distinguish between 64-bit PAE and
32-bit PAE for other reasons.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b83fd635e1f2..4e11cb284006 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4531,9 +4531,8 @@ static void reset_guest_paging_metadata(struct kvm_vcpu *vcpu,
 	update_last_nonleaf_level(mmu);
 }
 
-static void paging64_init_context_common(struct kvm_mmu *context)
+static void paging64_init_context(struct kvm_mmu *context)
 {
-	WARN_ON_ONCE(!is_cr4_pae(context));
 	context->page_fault = paging64_page_fault;
 	context->gva_to_gpa = paging64_gva_to_gpa;
 	context->sync_page = paging64_sync_page;
@@ -4541,11 +4540,6 @@ static void paging64_init_context_common(struct kvm_mmu *context)
 	context->direct_map = false;
 }
 
-static void paging64_init_context(struct kvm_mmu *context)
-{
-	paging64_init_context_common(context);
-}
-
 static void paging32_init_context(struct kvm_mmu *context)
 {
 	context->page_fault = paging32_page_fault;
@@ -4555,11 +4549,6 @@ static void paging32_init_context(struct kvm_mmu *context)
 	context->direct_map = false;
 }
 
-static void paging32E_init_context(struct kvm_mmu *context)
-{
-	paging64_init_context_common(context);
-}
-
 static union kvm_mmu_extended_role kvm_calc_mmu_role_ext(struct kvm_vcpu *vcpu,
 							 struct kvm_mmu_role_regs *regs)
 {
@@ -4650,8 +4639,6 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 
 	if (!is_paging(vcpu))
 		context->gva_to_gpa = nonpaging_gva_to_gpa;
-	else if (is_long_mode(vcpu))
-		context->gva_to_gpa = paging64_gva_to_gpa;
 	else if (is_pae(vcpu))
 		context->gva_to_gpa = paging64_gva_to_gpa;
 	else
@@ -4704,10 +4691,8 @@ static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *conte
 
 	if (!____is_cr0_pg(regs))
 		nonpaging_init_context(context);
-	else if (____is_efer_lma(regs))
+	else if (____is_cr4_pae(regs))
 		paging64_init_context(context);
-	else if (____is_cr4_pae(regs))
-		paging32E_init_context(context);
 	else
 		paging32_init_context(context);
 	context->root_level = role_regs_to_root_level(regs);
-- 
2.32.0.288.g62a8d224e6-goog

