Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7788C367735
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhDVCMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbhDVCMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:12:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821F3C061347
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:11:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f7-20020a5b0c070000b02904e9a56ee7e7so18149035ybq.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Cy2Z9StAFaCNNYaNTHLegOTVABQ53S5igs8EWDLg6pk=;
        b=IXguRzzVn9daPNKJlaXl9w0jTiRuxgv1WJWWwygmTJEJMxqmp4w5Xz3KGZoQ13ysVg
         PuwGjus8egsQr9wKsGEoCcjuONqkskRV4953lQq/tFh3UH/j6P/tvYBw3JFBtyE0x39Z
         jkW5gs35v0vTHkq3pyxf4mkZXAgAKShL+mbYDm1eMzFRaYRWoLhscvY3iCh7rpwjZCKD
         /QzSYI1Dhex3UPofI5gUhAqseuo2/900mqukuheP68OINGluM8JCUxabzosldjkOA+Zc
         RAVZB+r2uJ8bu+8BJwZsTKFkxLowOVHxmi0LQXnCDFZvDu0fy8965+F3Nn1+ECPLIMuF
         oqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Cy2Z9StAFaCNNYaNTHLegOTVABQ53S5igs8EWDLg6pk=;
        b=FvTiKegyqtHRG3UqZSDubR52/DmlzlajTr3zzpblr0Omkjt4E9hnNh8pg0RyBM+AKe
         92qfLzlSHCARbfdCE1ZrVuQC+JGeWid9qVkq6qyXiniGLQ9gBACE9d5KqTGxIEs1kb2o
         IaJAcXFE/8A2EMwpCSWF5ABZZSevAuz/VquBMMVHb1xyBMujoX2iV9RdZUBHL9UL5MMp
         TFm1AwsCw7VIEK0ywZAwWtPgWjRURTXfxgG/ShfhRRyJYbXUH9VWGKwiwWItWk/YgNRy
         7yZDph9uYcrBN7rCcGjgwjPKr6QYOmQAxgCq9Mwucva5zao/g6K/D+3eHPoy1atbeXJR
         uoAg==
X-Gm-Message-State: AOAM5308/sCfpiKuBBSigauLAU/UlJt+N8UMkox0QiyNIRcs20MZpn0/
        HEKKnXgWLcGRxsB0jGuwoXvEB+NztYc=
X-Google-Smtp-Source: ABdhPJz0ISdf1ulAOT2Gusp2f/urMVPQ+VYrgVutNeaPJRqtEp65I+u7rLYDt36EBfstqBEk9lFfimxhuMM=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e012:374c:592:6194])
 (user=seanjc job=sendgmr) by 2002:a25:b78c:: with SMTP id n12mr1415301ybh.291.1619057503778;
 Wed, 21 Apr 2021 19:11:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Apr 2021 19:11:17 -0700
In-Reply-To: <20210422021125.3417167-1-seanjc@google.com>
Message-Id: <20210422021125.3417167-8-seanjc@google.com>
Mime-Version: 1.0
References: <20210422021125.3417167-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v5 07/15] KVM: SVM: Append "_enabled" to module-scoped
 SEV/SEV-ES control variables
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename sev and sev_es to sev_enabled and sev_es_enabled respectively to
better align with other KVM terminology, and to avoid pseudo-shadowing
when the variables are moved to sev.c in a future patch ('sev' is often
used for local struct kvm_sev_info pointers.

No functional change intended.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e54eff6dfbbe..9b6adc493cc8 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -29,12 +29,12 @@
 #define __ex(x) __kvm_handle_fault_on_reboot(x)
 
 /* enable/disable SEV support */
-static int sev = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT);
-module_param(sev, int, 0444);
+static bool sev_enabled = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT);
+module_param_named(sev, sev_enabled, bool, 0444);
 
 /* enable/disable SEV-ES support */
-static int sev_es = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT);
-module_param(sev_es, int, 0444);
+static bool sev_es_enabled = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT);
+module_param_named(sev_es, sev_es_enabled, bool, 0444);
 
 static u8 sev_enc_bit;
 static int sev_flush_asids(void);
@@ -1452,7 +1452,7 @@ int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 	struct kvm_sev_cmd sev_cmd;
 	int r;
 
-	if (!svm_sev_enabled() || !sev)
+	if (!svm_sev_enabled() || !sev_enabled)
 		return -ENOTTY;
 
 	if (!argp)
@@ -1471,7 +1471,7 @@ int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 
 	switch (sev_cmd.id) {
 	case KVM_SEV_ES_INIT:
-		if (!sev_es) {
+		if (!sev_es_enabled) {
 			r = -ENOTTY;
 			goto out;
 		}
@@ -1766,9 +1766,9 @@ void sev_vm_destroy(struct kvm *kvm)
 
 void __init sev_set_cpu_caps(void)
 {
-	if (!sev)
+	if (!sev_enabled)
 		kvm_cpu_cap_clear(X86_FEATURE_SEV);
-	if (!sev_es)
+	if (!sev_es_enabled)
 		kvm_cpu_cap_clear(X86_FEATURE_SEV_ES);
 }
 
@@ -1778,7 +1778,7 @@ void __init sev_hardware_setup(void)
 	bool sev_es_supported = false;
 	bool sev_supported = false;
 
-	if (!IS_ENABLED(CONFIG_KVM_AMD_SEV) || !sev || !npt_enabled)
+	if (!IS_ENABLED(CONFIG_KVM_AMD_SEV) || !sev_enabled || !npt_enabled)
 		goto out;
 
 	/* Does the CPU support SEV? */
@@ -1817,7 +1817,7 @@ void __init sev_hardware_setup(void)
 	sev_supported = true;
 
 	/* SEV-ES support requested? */
-	if (!sev_es)
+	if (!sev_es_enabled)
 		goto out;
 
 	/* Does the CPU support SEV-ES? */
@@ -1832,8 +1832,8 @@ void __init sev_hardware_setup(void)
 	sev_es_supported = true;
 
 out:
-	sev = sev_supported;
-	sev_es = sev_es_supported;
+	sev_enabled = sev_supported;
+	sev_es_enabled = sev_es_supported;
 }
 
 void sev_hardware_teardown(void)
-- 
2.31.1.498.g6c1eba8ee3d-goog

