Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61464323509
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 02:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhBXBN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 20:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbhBXBFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 20:05:11 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B697C061786
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 16:56:31 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id z3so449810qtv.20
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 16:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=qPqWTKGBtiXgew3PhU0N/4Jj0Q0xiKY6q8BL4BwzsAU=;
        b=HunJVjKbKYQ5+XtdKimDZXAv30Guhr4IP7oIEdJc7r2ZY8T9q1TUL/oYbgxHvoizNY
         vVaw1gzKdcN61vKj+zzI4R6vjvUWlc4kq/PEuq24S22oLK7OYKNTlTgvh69hULpZaCWp
         9hi14vlflVmxyWK+peWu78muWleYnJ1efDkxVY24A2Y+eqvqUrh30D4+Q0Js1dhFb88s
         RLeWbzv0rw2i1wKgwjrZrP+ZN66NbrV+4HBSLGivZ1JM0ZFlwv4RVFR+Z3FxQJcVkgJD
         Fqa+4OPHLFDG4RCmRqcpmDHSNxWXq5XaVW5+tqrhUlWI7jp40/Xw9/bA4sOYc4+JAat6
         2f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=qPqWTKGBtiXgew3PhU0N/4Jj0Q0xiKY6q8BL4BwzsAU=;
        b=IMQ2x3KNpfgToSndyW6HHzijw/cAt6Jv/RANxz47MeNFUGFBhN6qebuIbZwWyeGl6J
         LqDnDQL8KHytTcrm8fG75nbSBVQXAIxhl6VUCEDGcAMl4yLcV4JqVz5yRMh5np00dpsK
         g9/knoklQM6GHln2TKz2dOATmbquosuoVCnjwoJ8aaHS/DleuJowkABdv2uuSe8FVUnP
         sbAtOjTRZGzk5XxsbN1FEupZd2l+fbrOnbZAh1/eNSXv4t61Fxt7rn2fpnV+DhjKbpun
         aA+EDZmJe0KKDZbnE6nz/N/Mvl3v4PoTcqc/CFBSwhqe9+Mhjg6tO2XSkny9cAjKAMqB
         yv4w==
X-Gm-Message-State: AOAM530vWZGRxFm1MHZHb9ZB15hdAa2E4OliCYwrG/6DlYec9Rg49cbn
        FaQeOoEocywXPwL/lR+0jVj9Yz6PIp4=
X-Google-Smtp-Source: ABdhPJzH3hAGs0FwoUemhwbym6SDVcEwG16rcuwMXwz97fmv4n8V/0SYC1Yl3E1PbNjpcyLrGYK8r924QTg=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:385f:4012:d20f:26b5])
 (user=seanjc job=sendgmr) by 2002:a05:6214:cad:: with SMTP id
 s13mr27824910qvs.53.1614128190725; Tue, 23 Feb 2021 16:56:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 23 Feb 2021 16:56:26 -0800
Message-Id: <20210224005627.657028-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH] KVM: SVM: Fix nested VM-Exit on #GP interception handling
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

Fix the interpreation of nested_svm_vmexit()'s return value when
synthesizing a nested VM-Exit after intercepting an SVM instruction while
L2 was running.  The helper returns '0' on success, whereas a return
value of '0' in the exit handler path means "exit to userspace".  The
incorrect return value causes KVM to exit to userspace without filling
the run state, e.g. QEMU logs "KVM: unknown exit, hardware reason 0".

Fixes: 14c2bf81fcd2 ("KVM: SVM: Fix #GP handling for doubly-nested virtualization")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 14e41dddc7eb..c4f2f2f6b945 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2200,13 +2200,18 @@ static int emulate_svm_instr(struct kvm_vcpu *vcpu, int opcode)
 		[SVM_INSTR_VMSAVE] = vmsave_interception,
 	};
 	struct vcpu_svm *svm = to_svm(vcpu);
+	int ret;
 
 	if (is_guest_mode(vcpu)) {
 		svm->vmcb->control.exit_code = guest_mode_exit_codes[opcode];
 		svm->vmcb->control.exit_info_1 = 0;
 		svm->vmcb->control.exit_info_2 = 0;
 
-		return nested_svm_vmexit(svm);
+		/* Returns '1' or -errno on failure, '0' on success. */
+		ret = nested_svm_vmexit(svm);
+		if (ret)
+			return ret;
+		return 1;
 	}
 	return svm_instr_handlers[opcode](vcpu);
 }
-- 
2.30.0.617.g56c4b15f3c-goog

