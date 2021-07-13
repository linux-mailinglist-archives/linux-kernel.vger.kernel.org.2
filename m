Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772783C74DD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbhGMQiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbhGMQiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:38:03 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0DBC06139F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:33 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id c17-20020ac87dd10000b0290250fd339409so14042837qte.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=O8F2nWEtJIYygcgMXcnof9oNbtAG6cyy1DOkdSdwMwg=;
        b=lU/BnI4u37nMxKBf4RWQS1VmHCe7EUt2MinPqtPnyxVcBwX/6V64VvvmeOcembhiO6
         Fprqn/CnOqJMKcsOPPzucpZLv1vGA1N9tcnpLtaiHfDYfqNCgC/zob/VQjdxKRpyQnof
         QBBb1uS5huu4/kLbkHYr/5X+FgA9vJTv8rcGXNLigLmmuXXM4AOdXbQtEfDjM6t0Z+Wy
         TdKLoA5l5QH6h7TTEQLkgDvNbBQ3XRmxsmjUFyEHcR/2ORuq1waGYySNCSIpAOIdlP9u
         4rRsLSxw5MS4UPJR8mYRLGLusoXXR9fs5C6dgZCdKlGAAcu0EXIEORb7T9ZPFN3Pj0O0
         m0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=O8F2nWEtJIYygcgMXcnof9oNbtAG6cyy1DOkdSdwMwg=;
        b=k2lnPCjFAXPZj2r+Il8CMs+g0rQSENZl87zw9psZSe5VTpWuU/C0TDlAMiAk9Mpru3
         nX7ZJfz4xugBDl92HLM9OWdeoignopuJpZNJqwnGxWIIqc4nD+aCWhkcdABKtX100ZT6
         Rvc7zehHt8lGHL0WbeGG4iTLHwdxwOs39M/hzHkGOP1WMlIYev59tNJqOrOzOo7t9uHD
         v5/lvw0Kk6E5emZ6b7ekHAw2XPw+XiRmoGP/3jYHICHtZuHUaRpNykvg4cj7snDrwBjz
         7C7NmmYCoBOTFDHntrSDjO11FOnjVO/6BH/rt74Nq5KlTe0nRroeGY0/aXGvspdKXY6k
         aa6g==
X-Gm-Message-State: AOAM531eSqEalVzY3UeyxxoMNAxrNBAAHUnqiUEclF1qffnwCgbOjti+
        3XM2S4BVz2zb9BwBrF1fEBh/uN+VXBc=
X-Google-Smtp-Source: ABdhPJyPd/xo5zM+iDP1oWprDa1FMBnkUeM41nu9gskrU1zIA0fuH2wN+X9Rl3NkeEyMGrhXmO9eCog+ck0=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a05:6214:1141:: with SMTP id
 b1mr5849322qvt.2.1626194073090; Tue, 13 Jul 2021 09:34:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:33:09 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-32-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 31/46] KVM: SVM: Drop redundant writes to vmcb->save.cr4 at RESET/INIT
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

Drop direct writes to vmcb->save.cr4 during vCPU RESET/INIT, as the
values being written are fully redundant with respect to
svm_set_cr4(vcpu, 0) a few lines earlier.  Note, svm_set_cr4() also
correctly forces X86_CR4_PAE when NPT is disabled.

No functional change intended.

Reviewed-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 875d68c4cb9b..6eff7f1a4672 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1269,8 +1269,6 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
 	vcpu->arch.regs[VCPU_REGS_RIP] = 0x0000fff0;
 
-	save->cr4 = X86_CR4_PAE;
-
 	if (npt_enabled) {
 		/* Setup VMCB for Nested Paging */
 		control->nested_ctl |= SVM_NESTED_CTL_NP_ENABLE;
@@ -1280,7 +1278,6 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 		svm_clr_intercept(svm, INTERCEPT_CR3_WRITE);
 		save->g_pat = vcpu->arch.pat;
 		save->cr3 = 0;
-		save->cr4 = 0;
 	}
 	svm->current_vmcb->asid_generation = 0;
 	svm->asid = 0;
-- 
2.32.0.93.g670b81a890-goog

