Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B6A367759
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhDVCWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbhDVCWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:22:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538C4C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:21:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c1-20020a5b0bc10000b02904e7c6399b20so18253643ybr.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=dmzwSU4y73/4LEavmF/OYppkzQDl6f2ap4gCGRq/u7Q=;
        b=B3uHZlKmU3bUpjY9s9zd6Sx6XXeDiQuHUft/ttYvoKDv4H0Cnwd7rFWo/uM9hjbt3V
         MBjdIRB3khz9u7TdEcltObR7Lo5Uddix+Ii9jiFbzZp3k+RbQrh6ebnx835FjM97uRHG
         1BrJzpSswjwDNvcGZD4NB3zGsvqDlsQpCkvTCP9hS0t1p/q0APq2YrkO5N0tHWC9Yj4a
         dO2YhyKFS751IwMtb8ZaXa/sip0UyazMUZdAgpaZQIzS2bCGsUEjuqVNrM+HM50WUBqS
         wshEYB7/Eqn2eas6GOseDUqTdF7C7dy6ltuyldoep44gUDAVSnvIuJvRkSbIhEvpUFlZ
         HQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=dmzwSU4y73/4LEavmF/OYppkzQDl6f2ap4gCGRq/u7Q=;
        b=KGYGNErwrR9/zC5dy6ercVmGbxhay9yezkZe3ui+m+mV9P5vOal9M30VCG/GOSP+kN
         HprC58tqfHlps9qdws9iaf/+8mzpLYNTLWGM8dSn9M5k4dZfxk8a75voxRPVAqFO9jCS
         OaDg9hPcRGjj2mg+9RcKHvIAToPikAimpPBI+Qxtjlpa7SpfCjxY5vGMXFdemNBpXXA1
         mg4RwydVmoEJcKuRzSvzR/uJEGloLkIx2/k9oz4jUMCV7rfxXuNSbq8QrOxuTe8PD/cd
         fUZbN/8AhD4Xcx/gKWTUO4nT9DfR9/w6P+9NjlOg2hCRuf6FKDArRmbKQfXaJOaytyft
         LvnQ==
X-Gm-Message-State: AOAM5300S85Wtkc+xSvWwja9pdhd6OJsRDKTujCDeZeM7xuELU70yZ1o
        u/6l5P0C0Rab089Tl3ypLLjO7UY3PQg=
X-Google-Smtp-Source: ABdhPJxCE4gUrvDEB867GR4YRgftu5sFnMM6G98+N8tTlWicY3XWd/UzALl3kkxUTKkrcP0iHY34ArIC5lo=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e012:374c:592:6194])
 (user=seanjc job=sendgmr) by 2002:a25:11c5:: with SMTP id 188mr1415372ybr.322.1619058097612;
 Wed, 21 Apr 2021 19:21:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Apr 2021 19:21:22 -0700
In-Reply-To: <20210422022128.3464144-1-seanjc@google.com>
Message-Id: <20210422022128.3464144-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210422022128.3464144-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v2 3/9] KVM: SVM: Truncate GPR value for DR and CR accesses in
 !64-bit mode
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Babu Moger <babu.moger@amd.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop bits 63:32 on loads/stores to/from DRs and CRs when the vCPU is not
in 64-bit mode.  The APM states bits 63:32 are dropped for both DRs and
CRs:

  In 64-bit mode, the operand size is fixed at 64 bits without the need
  for a REX prefix. In non-64-bit mode, the operand size is fixed at 32
  bits and the upper 32 bits of the destination are forced to 0.

Fixes: 7ff76d58a9dc ("KVM: SVM: enhance MOV CR intercept handler")
Fixes: cae3797a4639 ("KVM: SVM: enhance mov DR intercept handler")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index cd8c333ed2dc..6df12d7967db 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2462,7 +2462,7 @@ static int cr_interception(struct kvm_vcpu *vcpu)
 	err = 0;
 	if (cr >= 16) { /* mov to cr */
 		cr -= 16;
-		val = kvm_register_read(vcpu, reg);
+		val = kvm_register_readl(vcpu, reg);
 		trace_kvm_cr_write(cr, val);
 		switch (cr) {
 		case 0:
@@ -2508,7 +2508,7 @@ static int cr_interception(struct kvm_vcpu *vcpu)
 			kvm_queue_exception(vcpu, UD_VECTOR);
 			return 1;
 		}
-		kvm_register_write(vcpu, reg, val);
+		kvm_register_writel(vcpu, reg, val);
 		trace_kvm_cr_read(cr, val);
 	}
 	return kvm_complete_insn_gp(vcpu, err);
@@ -2574,11 +2574,11 @@ static int dr_interception(struct kvm_vcpu *vcpu)
 	dr = svm->vmcb->control.exit_code - SVM_EXIT_READ_DR0;
 	if (dr >= 16) { /* mov to DRn  */
 		dr -= 16;
-		val = kvm_register_read(vcpu, reg);
+		val = kvm_register_readl(vcpu, reg);
 		err = kvm_set_dr(vcpu, dr, val);
 	} else {
 		kvm_get_dr(vcpu, dr, &val);
-		kvm_register_write(vcpu, reg, val);
+		kvm_register_writel(vcpu, reg, val);
 	}
 
 	return kvm_complete_insn_gp(vcpu, err);
-- 
2.31.1.498.g6c1eba8ee3d-goog

