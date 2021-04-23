Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAD6369CCC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 00:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244156AbhDWWfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 18:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbhDWWe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 18:34:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF404C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 15:34:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e65-20020a25e7440000b02904ecfeff1ed8so14583887ybh.19
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=v1Exyl3dWucGDOE9RB7t5VjbkFrC7Sen6ZzJflRKQCo=;
        b=NQNFaYhStGsu5IDFNW+4tcsMQ9oxw8ww6l7ZuV2jrrMlLeeHY2ZIyFdMLsJw6hAC2u
         3yHVM0nOt3isla3mrMpwZXmJQQolCZoqR+LMQJHLvPdMmQTsuOtqs6RTixNzHxfgYZ7g
         J5fcyQSyr36Vowf6b4MgeWCiJX98Dyj46GNHwK5t1rBmZK8ne7D/yCYnnqqCf/O1ilyl
         NYBobajDtpV34S8VSQixBahj0gAiPDNA0SaU5w+8pueSORa1PkFUHEZJ7pUIkozP1GTz
         bfuCsTQNavwgf/eroUbAiJi2v4Sele/SZD5grKLwIoymYE51sbISIFt+ef+0HDNBuKbN
         m94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=v1Exyl3dWucGDOE9RB7t5VjbkFrC7Sen6ZzJflRKQCo=;
        b=UPIm5YsYo169jAFgykdzfL6LSFa7QE5cYPUgDjd3/eE85lsFQU8iGO4cqxgInlOvw8
         E5DeOE+BtHVOJ5ThtBvMoo+zjJL1qMjvsmIugxq5x6vZR5x/IESF/FXC9cPz9EHc0J/n
         8YPFEMfSsw0NKw+RCZkQ4SJr+Ak2FYtNZQEkaip9fAyqMCgRJP1vCnRU2zMZ4JdnAR+M
         xHFKav3WIOSGFvKHZl9JzV9oLa39DD1UdPXs1DweGL9hkINXKItg7FMYEfxGA9HC5fec
         +NYK0O3hrVSXRZyJ3cF33FPgcq+YhsHS4txgMeXl9R9l8JjJ+C9OkQ5vd3+Kum85OQNU
         wJ1w==
X-Gm-Message-State: AOAM533MuCtSY53ORiytzIOAIoQVpb8njj+hQk+bP6hWqCDh0LlQfET2
        PxssWywSvnWJSke+XZ8d+kQsBQiQUZU=
X-Google-Smtp-Source: ABdhPJySKzlNI+fLnsfzovBIYlbDkcXXjqw5Nnkem92Rqin8d+lBerGODSH1OHydVWtZfpwc/mg4TuhuPns=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a25:3c1:: with SMTP id 184mr641459ybd.76.1619217253258;
 Fri, 23 Apr 2021 15:34:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 15:34:01 -0700
In-Reply-To: <20210423223404.3860547-1-seanjc@google.com>
Message-Id: <20210423223404.3860547-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210423223404.3860547-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v3 1/4] KVM: SVM: Inject #GP on guest MSR_TSC_AUX accesses if
 RDTSCP unsupported
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

Inject #GP on guest accesses to MSR_TSC_AUX if RDTSCP is unsupported in
the guest's CPUID model.

Fixes: 46896c73c1a4 ("KVM: svm: add support for RDTSCP")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index cd8c333ed2dc..9ed9c7bd7cfd 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2674,6 +2674,9 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_TSC_AUX:
 		if (!boot_cpu_has(X86_FEATURE_RDTSCP))
 			return 1;
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
+			return 1;
 		msr_info->data = svm->tsc_aux;
 		break;
 	/*
@@ -2892,6 +2895,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		if (!boot_cpu_has(X86_FEATURE_RDTSCP))
 			return 1;
 
+		if (!msr->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
+			return 1;
+
 		/*
 		 * This is rare, so we update the MSR here instead of using
 		 * direct_access_msrs.  Doing that would require a rdmsr in
-- 
2.31.1.498.g6c1eba8ee3d-goog

