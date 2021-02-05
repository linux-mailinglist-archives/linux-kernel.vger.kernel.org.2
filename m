Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A323310210
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhBEBE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbhBEA7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:59:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0A9C061224
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:58:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s7so5154944ybj.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 16:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=q+0liJU8GabPl3PYejQh9F1gWHvngMzF13S5XCf8sWU=;
        b=ak9k2tm3NeARyReFBJfp7ptQLkAVEnEQOS8Y1mhvL1hqpa5bbLgrUULs5DGex4m4dD
         ktNSQGASgy4DqP6+Lu5EUhUn8fYtzoNyqXs/N6Uubsl/2m3J7wVAemQU8KOp3XJHiwUm
         XKnh0H9dXpAu65qrGcEAOswbGoDTq0lHyoOr+Qp+/Lm2nt6ndTei4NDuooEsR32MIbUf
         YI3hScxOnslWCuUP3X4I/9dHfKIAOg2n+NLUIJdTlxbT537jmZMJjKaRbgho+CiY6i2s
         tB6tDIKiYnj2xSfGcUdEkEXk2MItY96AXgDCRnYEaBU68p/0a6Xgop2+//kpaTrF/mLu
         BRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=q+0liJU8GabPl3PYejQh9F1gWHvngMzF13S5XCf8sWU=;
        b=ZHjY7yUbiy8Oq6mpThYKAxfpnRDTsOacWwvca3GmaO7IBxSgm5YfJArYj0kKofb3Qp
         O/SjbW2pbDtoADBY9gkF6U0uLEl325U8lrvAt9h3hsY5uWpFg44fYswojvvwSdIHRMoC
         B1oDzggY3DfigfVoUxDyTMdA2MeUJCjc3NgVTb1ED381H+QWb/fV2nLhqYSnlQ2OtNek
         tfX9mqa939/xMbkGziO5bLVdGdvP04J+Bx90ea1xhSazTcYo+TvTAfdgNnNwXp9wPa05
         ZYxiSKaq28BAcXJ+08n33PFoXHPquzJfiTlV5b8KYOm4oFQK380VMIvZbBkBAwycNRES
         MlnA==
X-Gm-Message-State: AOAM5308SMbF1EhS+t2Pc2pFuUaBwZcqCsWQIy5qFj1900hlweyI1AWy
        VvcBZGoqojPYKWbmi51mOlUn4ELB4S4=
X-Google-Smtp-Source: ABdhPJwlqJaLwYUDq5qtdREqGOMWIu5lte952elgDFrAu7wbn41ukhS6gKTkxcmv/c4m8Hr0NC+w1vwSXFY=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:f16f:a28e:552e:abea])
 (user=seanjc job=sendgmr) by 2002:a25:da41:: with SMTP id n62mr2578073ybf.155.1612486695505;
 Thu, 04 Feb 2021 16:58:15 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  4 Feb 2021 16:57:49 -0800
In-Reply-To: <20210205005750.3841462-1-seanjc@google.com>
Message-Id: <20210205005750.3841462-9-seanjc@google.com>
Mime-Version: 1.0
References: <20210205005750.3841462-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 8/9] KVM: SVM: Don't manually emulate RDPMC if nrips=0
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <trivial@kernel.org>
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

Remove bizarre code that causes KVM to run RDPMC through the emulator
when nrips is disabled.  Accelerated emulation of RDPMC doesn't rely on
any additional data from the VMCB, and SVM has generic handling for
updating RIP to skip instructions when nrips is disabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 74f37f282050..b6acc73d356a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2434,14 +2434,6 @@ static int rsm_interception(struct kvm_vcpu *vcpu)
 	return kvm_emulate_instruction_from_buffer(vcpu, rsm_ins_bytes, 2);
 }
 
-static int rdpmc_interception(struct kvm_vcpu *vcpu)
-{
-	if (!nrips)
-		return emulate_on_interception(vcpu);
-
-	return kvm_emulate_rdpmc(vcpu);
-}
-
 static bool check_selective_cr0_intercepted(struct kvm_vcpu *vcpu,
 					    unsigned long val)
 {
@@ -3068,7 +3060,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_SMI]				= kvm_emulate_as_nop,
 	[SVM_EXIT_INIT]				= kvm_emulate_as_nop,
 	[SVM_EXIT_VINTR]			= interrupt_window_interception,
-	[SVM_EXIT_RDPMC]			= rdpmc_interception,
+	[SVM_EXIT_RDPMC]			= kvm_emulate_rdpmc,
 	[SVM_EXIT_CPUID]			= kvm_emulate_cpuid,
 	[SVM_EXIT_IRET]                         = iret_interception,
 	[SVM_EXIT_INVD]                         = kvm_emulate_invd,
-- 
2.30.0.365.g02bc693789-goog

