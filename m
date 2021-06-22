Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F0B3B0C54
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhFVSGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhFVSFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:05:12 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018A0C0698DB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:43 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w3-20020ac80ec30000b029024e8c2383c1so101196qti.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=1ZiFOSwRtx32Cmg7gPoYH6t1rIajFQFzmmt4+1jIiJU=;
        b=Y53/BvHc6UgBTsWlXJMVwoW18CMnCIdlsbhixtdLTOkc1gfD7ZUohb8GJahWXHVEH8
         ga7V0ax66f2eCcZTSl7ivlh37s/0jvP6YnK4vzsERBKzF2EaPHDEKh6jesaowpyW/L0c
         VDHUrOUxtgGGxfssFVzMAiEmmCCEPos9SdfRzoTfvQ9sgz0lehIB1HLdbc+vMehGzqDi
         4tvwXCLnBfwWULefc4Q+SFW5rki89N7fFYK1sIQyZ0aiQExhl54ZcfLlIlHb+eWQgqtE
         +lAN3RNr+53em+DB0zBbzlhUdFsh+9yw0Cih+rODz6DmtDbO8pG9MHVWHBUDTkkGgwZT
         kXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=1ZiFOSwRtx32Cmg7gPoYH6t1rIajFQFzmmt4+1jIiJU=;
        b=kgpMTXLeNuvdxIpo25nKtXO63NSdSmNYWszwvloXaR+CiLd+w4243VgK7s+ebeqgA6
         tSi8uLUQ5Sx7WtAty6h2nIWZABcmNp7Ygw8x0SOQfi5MPou1LIhXT3ioLod+kyFMa4JF
         lVKfD2dasixb4BPoPTueOP/4ehI1PkCvfjnM+cUAnMiWobXFs15rJGjVPiR2sDr7Bn67
         GG9KgYhju7lgfHWvUGVbJANUMk6ULGAc/IEADpoxWZDl1UD7MlDfcIvZkrnWZAgscYKO
         1ZeHKoCqId9V/OwofF1/yMsXNW1k+b512l6jGPxFsiU99dHUjCobFyyoqP1xT3ZkI0m2
         Q1FQ==
X-Gm-Message-State: AOAM530EimNQv1ZBrMOu9YCqJ/sDydcDvr3RTsFAdMFJyD/tq6mlTPcX
        hnrk/ACxGnY+wD/miQG9ndiQGaPsna4=
X-Google-Smtp-Source: ABdhPJw4hXz1ZOVS1kR/VpmOtIrSSZMI49ufuWuH2yrlO4nuS0i+RZkS1BvaQo8S4ZKz+GBLbLUboFrS+o4=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:5722:92ce:361f:3832])
 (user=seanjc job=sendgmr) by 2002:a25:8b0b:: with SMTP id i11mr6993196ybl.484.1624384782096;
 Tue, 22 Jun 2021 10:59:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 10:57:31 -0700
In-Reply-To: <20210622175739.3610207-1-seanjc@google.com>
Message-Id: <20210622175739.3610207-47-seanjc@google.com>
Mime-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 46/54] KVM: x86/mmu: Use MMU's role to determine PTTYPE
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

Use the MMU's role instead of vCPU state or role_regs to determine the
PTTYPE, i.e. which helpers to wire up.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4e11cb284006..92260cf48d5e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4637,9 +4637,9 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 	context->inject_page_fault = kvm_inject_page_fault;
 	context->root_level = role_regs_to_root_level(&regs);
 
-	if (!is_paging(vcpu))
+	if (!is_cr0_pg(context))
 		context->gva_to_gpa = nonpaging_gva_to_gpa;
-	else if (is_pae(vcpu))
+	else if (is_cr4_pae(context))
 		context->gva_to_gpa = paging64_gva_to_gpa;
 	else
 		context->gva_to_gpa = paging32_gva_to_gpa;
@@ -4689,9 +4689,9 @@ static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *conte
 
 	context->mmu_role.as_u64 = new_role.as_u64;
 
-	if (!____is_cr0_pg(regs))
+	if (!is_cr0_pg(context))
 		nonpaging_init_context(context);
-	else if (____is_cr4_pae(regs))
+	else if (is_cr4_pae(context))
 		paging64_init_context(context);
 	else
 		paging32_init_context(context);
-- 
2.32.0.288.g62a8d224e6-goog

