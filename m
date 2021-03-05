Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9A232DEE7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 02:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhCEBLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 20:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhCEBLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 20:11:35 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C077BC061762
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 17:11:34 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id c1so381497qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 17:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=UoSJXw/PVEOjBFScqgNo0bQzSNuTFSWEQtCbZglmTq0=;
        b=kQAMJObEqqL+h/6HsZlsplPO1BCJpjh9pP+48cHLs3OobIOB6CgTtrh6EZUMu3bXFi
         SHbHfRmqn8dUDqWqCLuyGL1qpn/iSCISWig3ZEmUqIOSOJf84eA7mq/rxUqwRENuEaS1
         bMeL/YM/DTmkCvKXJsxa8oH6zJQE+GEHRs++0WStbmPTpCCY4ix/suKB5VIiC8F2mFfm
         gVvvGp1a4BcXKYtQE/1E+t2IlypiBh1StC6Fx3FSEBYdV4TrwK8+IM67QaO/+AmjsMYu
         7w6gmYHZ7zvChYP1fmGyniTRJ06L8LCTWj1APum5SrUWMTrUkp5ID1aQAB1TXbCAYsLS
         /bOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=UoSJXw/PVEOjBFScqgNo0bQzSNuTFSWEQtCbZglmTq0=;
        b=mc32E4pAEjSI+CAO2U2naeJSAoqgBFV0wXMrVldP9wOg5cEkTkl+Brv5URvot97dmT
         WnC1WfUmnAJiAjpqTQ20MdLelJy+BmVPhGNLqycGZpJ+bJQT5cdvK1DAbZAbUtS2pV4U
         G0LfiWvl3V5USZFbyGltqq3t6x2iLrDrqAXCWaShi7Rbfm5qLXk15KYKtldGcrwkxruW
         j7bBdC28EGRRq+5PiMGUKpu/3f7uCCHDDaEtZIUxDYY2X6Zz1BZReMYVTjobFheV8qo1
         LGluywRxijj5ze3xW3eNY482qUsNU5nwOl9o7DFRH2bx3tzppEMhoVjYbSzpexPP5hAn
         8vNA==
X-Gm-Message-State: AOAM5331Q2l5xY7HCtwXMhEAwWTKRQy+xPZCNG5kkKl5iakmpRXmvSc3
        zXDdgpmBhXZbu5WvqQvoIZtfkiYDFVQ=
X-Google-Smtp-Source: ABdhPJzYlWm8aGDZV4ZezLV91M6AacXjOom4mKjt8Lg/YvFhNfe1l4qG1CS/p0mg+dc/jjRPcvsiw64XfYE=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:9857:be95:97a2:e91c])
 (user=seanjc job=sendgmr) by 2002:a0c:e5c9:: with SMTP id u9mr6738397qvm.55.1614906693998;
 Thu, 04 Mar 2021 17:11:33 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  4 Mar 2021 17:10:56 -0800
In-Reply-To: <20210305011101.3597423-1-seanjc@google.com>
Message-Id: <20210305011101.3597423-13-seanjc@google.com>
Mime-Version: 1.0
References: <20210305011101.3597423-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2 12/17] KVM: SVM: Don't strip the C-bit from CR2 on #PF interception
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't strip the C-bit from the faulting address on an intercepted #PF,
the address is a virtual address, not a physical address.

Fixes: 0ede79e13224 ("KVM: SVM: Clear C-bit from the page fault address")
Cc: stable@vger.kernel.org
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4769cf8bf2fd..dfc8fe231e8b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1907,7 +1907,7 @@ static int pf_interception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	u64 fault_address = __sme_clr(svm->vmcb->control.exit_info_2);
+	u64 fault_address = svm->vmcb->control.exit_info_2;
 	u64 error_code = svm->vmcb->control.exit_info_1;
 
 	return kvm_handle_page_fault(vcpu, error_code, fault_address,
-- 
2.30.1.766.gb4fecdf3b7-goog

