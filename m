Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267D73101FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhBEBBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbhBEA7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:59:24 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D017DC061223
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:58:13 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p22so5058905ybc.18
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 16:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=5c0/7fXNc9NJBGplJdQvhQnqZQRKuocBztrNMA5F0Ys=;
        b=UI4uOsdg+DtWPvjvsEFV/nZW5PPOVrGnyAiswLzJnHq/suToA932QWqpNqUrPKkuUV
         UZ+MRf5hqAgb5Xws18ZIEr0v1RqPV4jv8IEGo75LYvnzC9cTXpshrqjtRLOg7smdKVQ9
         TRg/7HWa5ezmwmwW33KvWt/jbwiTfdNd8sCcC4OA+jFas+CYGEP1e4AOhl9wj7SvwHlc
         2Si3dq+rMpRmUkH2m18vnLE+i1v5zHxSl3SLEauYEZ9A/gIpPI8Aj4EZxF/1Au7jcvBM
         2YuBRCR1ZDM5iMpPtfx07Tg7HyxMRhnZeVrS+I2OozmMsS7x1S6JNNc1Vs+h7Y2e006G
         B71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=5c0/7fXNc9NJBGplJdQvhQnqZQRKuocBztrNMA5F0Ys=;
        b=OMIou/YNOW9u1QuCdbzbEIBjERdLdOqP5BAw4nwwz3bbm+2j/WfNpoxTvy/Nvapci/
         ReFfxZSyljZLdgKEoNfajE37Cv8AbiXGcPWcVaZKce7HzFgOeKKhLICFY++DAYP7aSDs
         qdmZWZRhtGqiBp7w1Tb6OQH/mPaEAT2ggF7Hs7GjHMmsNGJ045pZPxiSVjuUyrSR/kFP
         wXF2OY5MnYQbA04x+cld7eSKOoU2kfCpHyTmFieYAc9I5e0+DVJpVwZf5Wm3fOcHHBFS
         /UZr5Gc9JqDMgm20wNFlkAX59edmuRezKdqCBp2kYM7UlK7kSTAMh9ODb5NnfU+qKWDI
         18Ew==
X-Gm-Message-State: AOAM531J0bbDo8LKryPZMPPMp+dz3yJCKhxgtb9WzbpjhJDiJRggNGHS
        iw4KnCR6EFjXzWmNgcPMmEJh9ARrqZM=
X-Google-Smtp-Source: ABdhPJyNKFJ7yPkQoW3pUfGUiI4sTBEfmQ/tUgh0osHkliXm6888BQwuO16qBZG34tXUNgRDwgk1mflD/0o=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:f16f:a28e:552e:abea])
 (user=seanjc job=sendgmr) by 2002:a25:af52:: with SMTP id c18mr2865534ybj.196.1612486693079;
 Thu, 04 Feb 2021 16:58:13 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  4 Feb 2021 16:57:48 -0800
In-Reply-To: <20210205005750.3841462-1-seanjc@google.com>
Message-Id: <20210205005750.3841462-8-seanjc@google.com>
Mime-Version: 1.0
References: <20210205005750.3841462-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 7/9] KVM: x86: Move RDPMC emulation to common code
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

Move the entirety of the accelerated RDPMC emulation to x86.c, and assign
the common handler directly to the exit handler array for VMX.  SVM has
bizarre nrips behavior that prevents it from directly invoking the common
handler.  The nrips goofiness will be addressed in a future patch.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/svm/svm.c          |  5 +----
 arch/x86/kvm/vmx/vmx.c          | 10 +---------
 arch/x86/kvm/x86.c              | 15 ++++++++-------
 4 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index edac91914f46..41d9aca3874a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1579,7 +1579,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
 
 unsigned long kvm_get_rflags(struct kvm_vcpu *vcpu);
 void kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
-bool kvm_rdpmc(struct kvm_vcpu *vcpu);
+int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu);
 
 void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr);
 void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3eb5a6c19ed7..74f37f282050 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2436,13 +2436,10 @@ static int rsm_interception(struct kvm_vcpu *vcpu)
 
 static int rdpmc_interception(struct kvm_vcpu *vcpu)
 {
-	int err;
-
 	if (!nrips)
 		return emulate_on_interception(vcpu);
 
-	err = kvm_rdpmc(vcpu);
-	return kvm_complete_insn_gp(vcpu, err);
+	return kvm_emulate_rdpmc(vcpu);
 }
 
 static bool check_selective_cr0_intercepted(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 82f39cf3bc4b..21db4e243b8d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5310,14 +5310,6 @@ static int handle_invlpg(struct kvm_vcpu *vcpu)
 	return kvm_skip_emulated_instruction(vcpu);
 }
 
-static int handle_rdpmc(struct kvm_vcpu *vcpu)
-{
-	int err;
-
-	err = kvm_rdpmc(vcpu);
-	return kvm_complete_insn_gp(vcpu, err);
-}
-
 static int handle_apic_access(struct kvm_vcpu *vcpu)
 {
 	if (likely(fasteoi)) {
@@ -5740,7 +5732,7 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[EXIT_REASON_HLT]                     = kvm_emulate_halt,
 	[EXIT_REASON_INVD]		      = kvm_emulate_invd,
 	[EXIT_REASON_INVLPG]		      = handle_invlpg,
-	[EXIT_REASON_RDPMC]                   = handle_rdpmc,
+	[EXIT_REASON_RDPMC]                   = kvm_emulate_rdpmc,
 	[EXIT_REASON_VMCALL]                  = kvm_emulate_hypercall,
 	[EXIT_REASON_VMCLEAR]		      = handle_vmx_instruction,
 	[EXIT_REASON_VMLAUNCH]		      = handle_vmx_instruction,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d81ffbc42bba..5643120060c0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1210,20 +1210,21 @@ void kvm_get_dr(struct kvm_vcpu *vcpu, int dr, unsigned long *val)
 }
 EXPORT_SYMBOL_GPL(kvm_get_dr);
 
-bool kvm_rdpmc(struct kvm_vcpu *vcpu)
+int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu)
 {
 	u32 ecx = kvm_rcx_read(vcpu);
 	u64 data;
-	int err;
 
-	err = kvm_pmu_rdpmc(vcpu, ecx, &data);
-	if (err)
-		return err;
+	if (kvm_pmu_rdpmc(vcpu, ecx, &data)) {
+		kvm_inject_gp(vcpu, 0);
+		return 1;
+	}
+
 	kvm_rax_write(vcpu, (u32)data);
 	kvm_rdx_write(vcpu, data >> 32);
-	return err;
+	return kvm_skip_emulated_instruction(vcpu);
 }
-EXPORT_SYMBOL_GPL(kvm_rdpmc);
+EXPORT_SYMBOL_GPL(kvm_emulate_rdpmc);
 
 /*
  * List of msr numbers which we expose to userspace through KVM_GET_MSRS
-- 
2.30.0.365.g02bc693789-goog

