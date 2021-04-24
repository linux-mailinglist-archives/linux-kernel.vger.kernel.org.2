Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0E6369E2A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbhDXAyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244256AbhDXAxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:53:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3E7C06137F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d89-20020a25a3620000b02904dc8d0450c6so26112288ybi.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=dsiMBchNTtndnmQlk4F63qszrVBMRXg4RloYviM4gF4=;
        b=DLHJVAghmlCF6JmDRY3qJZSPKKBmK7vBFJ9tA2azFp9TZbNze8G6Dk+Et/qgGC5OPh
         DJUS44SdtB817l7bOzG0U6SKVW7HuaG1CrykmapcI0bmvwsKnIeu92on9mT+vHZ+OpZ5
         HLmFQGihRTiuKUveO2bSSkIUxvfVkbym6Mecyb3VZjRcQlK49lX+8QdpkmDb5HIp4Sda
         qSij8iYdhJ5QpSU61zus5WOKpUrPJ1vv5dwmnUb4jqDi0Bna+gIAbnh12ac3jz0RdyD9
         8AbAAZld7/AdGjOhjV9dJk2IaV72uTLa1jgdy0ZcQAbEssuNLl29zZVFG0uDjRsbGC1j
         hAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=dsiMBchNTtndnmQlk4F63qszrVBMRXg4RloYviM4gF4=;
        b=EuBMGlPF663zETeqUT90NvzWGbbQnxvXNKGZKQvy0QSnw/To317oxlvuD9MwivALjX
         5pRsChy3oblIW3G+Po2zw7Y+DgkhiR2lOHQ/MPL8kPRNDUWlYL3fxBZWoY3UDchJqiKL
         xX1tUUf5oVzwpxdLt5deCxfxerppuuK33oW6rrtbEfpzRgg81V6dDere6mqlEgqLNxYE
         Nk411GvxWEoRNPcizA3odNg/nh0Jz4bMUqP64PdteXMtzGlazlg1+oqnW1jdGCvdpai/
         V3fIr5s9sAdPdiqB9vRVItzy9WH1wIEyys4easRBXoGBh5QA/juWHz7wqhq5ZHO96xkp
         CJMQ==
X-Gm-Message-State: AOAM530Q2AvIu+2Ljikj/ozXCdC+4rBt+0lKgaFWqwb/3rvRJk0uSq82
        N1kSHQUjGaoqVdqKIYpf5PmII2ZFqRo=
X-Google-Smtp-Source: ABdhPJzHd1onR0oqXPgHGSf07Ej3AmYGAmthNY/gfjWbuNGb2R8GtbRaqSXyt8YUb+K2T5W3zOT9ewLF2cE=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a25:1905:: with SMTP id 5mr9570731ybz.302.1619225286449;
 Fri, 23 Apr 2021 17:48:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:32 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-31-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 30/43] KVM: SVM: Drop redundant writes to vmcb->save.cr4 at RESET/INIT
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

Drop direct writes to vmcb->save.cr4 during vCPU RESET/INIT, as the
values being written are fully redundant with respect to
svm_set_cr4(vcpu, 0) a few lines earlier.  Note, svm_set_cr4() also
correctly forces X86_CR4_PAE when NPT is disabled.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 88d34fa93d8b..558329f53709 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1211,8 +1211,6 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
 	vcpu->arch.regs[VCPU_REGS_RIP] = 0x0000fff0;
 
-	save->cr4 = X86_CR4_PAE;
-
 	if (npt_enabled) {
 		/* Setup VMCB for Nested Paging */
 		control->nested_ctl |= SVM_NESTED_CTL_NP_ENABLE;
@@ -1222,7 +1220,6 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 		svm_clr_intercept(svm, INTERCEPT_CR3_WRITE);
 		save->g_pat = vcpu->arch.pat;
 		save->cr3 = 0;
-		save->cr4 = 0;
 	}
 	svm->current_vmcb->asid_generation = 0;
 	svm->asid = 0;
-- 
2.31.1.498.g6c1eba8ee3d-goog

