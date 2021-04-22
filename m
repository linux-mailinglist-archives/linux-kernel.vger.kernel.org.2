Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF43367732
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhDVCM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbhDVCMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:12:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F35EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:11:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u73-20020a25ab4f0000b0290410f38a2f81so18069613ybi.22
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=GoSZGv7Y6e7lARdhV5mketnMC+wBjLMFqgO+1KaTReY=;
        b=GMw18gHVAzCwv+LaoeobpVSexFsDlMyhVgVQj7ByXdguQRXy3VfPbpxTxY8z17nuUl
         kriJI+OtRmL8/11pJ2E7dPQtOk7xO3jcOiVWNUqXk2FxD2vHkdgyYXdHSbm3lr7hBbLd
         puuF7YjDhGs3eWtlVyqU45r3WL1mx+xoOC3ivJWHAJNVyH2pHv01q7wgCfmJWz1jqDl1
         CQXeiv5I+QIgp+PCTBL2nzo8sLbzKgYQAiGJtncQf7aTIH7NNmSReS5NLXRHHmWj8bcc
         ryElqUKI2uTWlpiEEbWU+CXnI73fXmX7wponLwq1vQIC4pcYieRCulfr81fjzbNDZc9v
         guQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=GoSZGv7Y6e7lARdhV5mketnMC+wBjLMFqgO+1KaTReY=;
        b=hheqjPYhYK7uDHH1ZpTzOf8EIq5QOrJopw/J/tILXGemciMRSVxGfpHJlmoVczXk9s
         prDtGveUFoLVsitRwBg4dvKDh/rDbKQXrbTdPHgvByMaMBP7M7IkF8iemZjRtT14xAub
         o/60rC7ouKresGmlJNVUZdXd7AxG5OXnTrEv68jLd4t4hayM/6hbKOu1VqeBRMFmlyFU
         q1jBvzMZAcGlsGHpCra5h2MTOBdFDhG1gy/G5X0L5++wGfZJlmAB/gu9eEVBFyJDQ5p0
         BvjWfNCE5gu2TX+h4HtqC/S1LSazKmXRX7el6iT1Hx0ol3PPVo3jSOy7wP7fCXN61IEk
         Avzw==
X-Gm-Message-State: AOAM530CXQCSNh/QCzMXpxVvvzyfzbl6rRsJGWojBhh7gtfLAaILrHWy
        D5f7wNsPQebcr/4UQBe1EvIGhxK9gz4=
X-Google-Smtp-Source: ABdhPJxvg9wZgV5GpAgYuTY1uGCh0VjFAGn0+XLUAiUby4Errpq5ObcHR2latnfc4kXAu5iX/bb354pUBeA=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e012:374c:592:6194])
 (user=seanjc job=sendgmr) by 2002:a25:ef0c:: with SMTP id g12mr1292284ybd.235.1619057499451;
 Wed, 21 Apr 2021 19:11:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Apr 2021 19:11:15 -0700
In-Reply-To: <20210422021125.3417167-1-seanjc@google.com>
Message-Id: <20210422021125.3417167-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210422021125.3417167-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v5 05/15] KVM: SEV: Mask CPUID[0x8000001F].eax according to
 supported features
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

From: Paolo Bonzini <pbonzini@redhat.com>

Add a reverse-CPUID entry for the memory encryption word, 0x8000001F.EAX,
and use it to override the supported CPUID flags reported to userspace.
Masking the reported CPUID flags avoids over-reporting KVM support, e.g.
without the mask a SEV-SNP capable CPU may incorrectly advertise SNP
support to userspace.

Clear SEV/SEV-ES if their corresponding module parameters are disabled,
and clear the memory encryption leaf completely if SEV is not fully
supported in KVM.  Advertise SME_COHERENT in addition to SEV and SEV-ES,
as the guest can use SME_COHERENT to avoid CLFLUSH operations.

Explicitly omit SME and VM_PAGE_FLUSH from the reporting.  These features
are used by KVM, but are not exposed to the guest, e.g. guest access to
related MSRs will fault.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c   | 8 +++++++-
 arch/x86/kvm/cpuid.h   | 1 +
 arch/x86/kvm/svm/sev.c | 8 ++++++++
 arch/x86/kvm/svm/svm.c | 3 +++
 arch/x86/kvm/svm/svm.h | 1 +
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 2ae061586677..96e41e1a1bde 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -557,6 +557,10 @@ void kvm_set_cpu_caps(void)
 	 */
 	kvm_cpu_cap_mask(CPUID_8000_000A_EDX, 0);
 
+	kvm_cpu_cap_mask(CPUID_8000_001F_EAX,
+		0 /* SME */ | F(SEV) | 0 /* VM_PAGE_FLUSH */ | F(SEV_ES) |
+		F(SME_COHERENT));
+
 	kvm_cpu_cap_mask(CPUID_C000_0001_EDX,
 		F(XSTORE) | F(XSTORE_EN) | F(XCRYPT) | F(XCRYPT_EN) |
 		F(ACE2) | F(ACE2_EN) | F(PHE) | F(PHE_EN) |
@@ -944,8 +948,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		break;
 	/* Support memory encryption cpuid if host supports it */
 	case 0x8000001F:
-		if (!boot_cpu_has(X86_FEATURE_SEV))
+		if (!kvm_cpu_cap_has(X86_FEATURE_SEV))
 			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+		else
+			cpuid_entry_override(entry, CPUID_8000_001F_EAX);
 		break;
 	/*Add support for Centaur's CPUID instruction*/
 	case 0xC0000000:
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 888e88b42e8d..eeb4a3020e1b 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -99,6 +99,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_7_EDX]         = {         7, 0, CPUID_EDX},
 	[CPUID_7_1_EAX]       = {         7, 1, CPUID_EAX},
 	[CPUID_12_EAX]        = {0x00000012, 0, CPUID_EAX},
+	[CPUID_8000_001F_EAX] = {0x8000001f, 0, CPUID_EAX},
 };
 
 /*
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index fb32b93e325c..e54eff6dfbbe 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1764,6 +1764,14 @@ void sev_vm_destroy(struct kvm *kvm)
 	sev_asid_free(sev->asid);
 }
 
+void __init sev_set_cpu_caps(void)
+{
+	if (!sev)
+		kvm_cpu_cap_clear(X86_FEATURE_SEV);
+	if (!sev_es)
+		kvm_cpu_cap_clear(X86_FEATURE_SEV_ES);
+}
+
 void __init sev_hardware_setup(void)
 {
 	unsigned int eax, ebx, ecx, edx;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 12b2c04076bb..cb227e90dffb 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -914,6 +914,9 @@ static __init void svm_set_cpu_caps(void)
 	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
 	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
 		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD);
+
+	/* CPUID 0x8000001F (SME/SEV features) */
+	sev_set_cpu_caps();
 }
 
 static __init int svm_hardware_setup(void)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ec0407f41458..39d1412f2c45 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -581,6 +581,7 @@ int svm_unregister_enc_region(struct kvm *kvm,
 			      struct kvm_enc_region *range);
 int svm_vm_copy_asid_from(struct kvm *kvm, unsigned int source_fd);
 void pre_sev_run(struct vcpu_svm *svm, int cpu);
+void __init sev_set_cpu_caps(void);
 void __init sev_hardware_setup(void);
 void sev_hardware_teardown(void);
 void sev_free_vcpu(struct kvm_vcpu *vcpu);
-- 
2.31.1.498.g6c1eba8ee3d-goog

