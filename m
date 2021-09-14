Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A439040BC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 01:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbhINXKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 19:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbhINXKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 19:10:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEB9C061341
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 16:08:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v66-20020a25abc8000000b0059ef57c3386so1111535ybi.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=yj9QOQkqCw/wvw7mXPq1coe5Xsm7Bkjipk87W4UFhiY=;
        b=SbYOjz+CAxoykV4EmyXX1kF3SFoGm3CudQMaRKSl+lLpQeZ5tNJomK8E9aDIphQxnJ
         srhROad2/hsh8r4B5eAJ6hocxlCvrFvvm/ufsmxNrq7pNPFUifethN2rK4HCk1z3MFIR
         9wDV/6gJymbIPV+Uw71AVzSmSdrGCKlBNk0D281XFnvVlC5OlMpbkSoKf8N/17TuJt2w
         4UfnWENZBRZOdMmgaiEy+V3pGMK8RpQzvh/PqHMu9c6sBK4m2hAIALnnyvj9RwAEVJOw
         C/94kzcGK6d0N+Ad6lajPVd9Rm+rWwKDIGwws+Iwc7Qb2wXAtdL5ivVYetlDxm48Saza
         0pSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=yj9QOQkqCw/wvw7mXPq1coe5Xsm7Bkjipk87W4UFhiY=;
        b=vTniPhz0udHhHL7YQ0gp9pq4TX27w+3ZZh+hFwnLjS6kpN+kYM2F/7SbGq26p5XLAZ
         rJQd4EtRkvvwtWb3GN49GeQMEA7/QhVDX5oZJkuaTkp32fTzh23QFnZnIw7gfIEvbRCt
         C+CIS3zKTH4CEVs9JHk7uzAvdFRFQiVKDXHTqqv81A5eSbChiX/U3kq+17l5RU2I98/n
         2ODT2Y8AlG5KRE+WbhME/EjM0etGQMdhN0tLo7iqBQOwQD4IRlvkxQUQh2sBRvD/RYDE
         sgl84NfvdtOvPiAw/fyosQ/MDAPMvm+TMWEYtj91NHcU+hTXQlQK41yX8VS2WByiLi9/
         wiAA==
X-Gm-Message-State: AOAM5323F8kSzgKl0gMsUxgfY38r5ve6mBS+5aKs5bUZ9sxWZv/ZjicG
        S656ZsisGhfNUS/fVtOFxcMTCnkHB+Q=
X-Google-Smtp-Source: ABdhPJxuWWKVrMVQLTmU7SeOhUJQnRfeZKN6a6iG/G3krGQqnU6hVvnVG0p1O6IMygKIycQ1lERX4yh4JVU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:d59f:9874:e5e5:256b])
 (user=seanjc job=sendgmr) by 2002:a25:b9cf:: with SMTP id y15mr2103063ybj.110.1631660930573;
 Tue, 14 Sep 2021 16:08:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Sep 2021 16:08:40 -0700
In-Reply-To: <20210914230840.3030620-1-seanjc@google.com>
Message-Id: <20210914230840.3030620-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210914230840.3030620-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 3/3] KVM: SVM: Move RESET emulation to svm_vcpu_reset()
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

Move RESET emulation for SVM vCPUs to svm_vcpu_reset(), and drop an extra
init_vmcb() from svm_create_vcpu() in the process.  Hopefully KVM will
someday expose a dedicated RESET ioctl(), and in the meantime separating
"create" from "RESET" is a nice cleanup.

Keep the call to svm_switch_vmcb() so that misuse of svm->vmcb at worst
breaks the guest, e.g. premature accesses doesn't cause a NULL pointer
dereference.

Cc: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c |  6 +++---
 arch/x86/kvm/svm/svm.c | 29 +++++++++++++++++------------
 arch/x86/kvm/svm/svm.h |  2 +-
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 75e0b21ad07c..4cf40021dde4 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2599,11 +2599,11 @@ void sev_es_init_vmcb(struct vcpu_svm *svm)
 	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTTOIP, 1, 1);
 }
 
-void sev_es_create_vcpu(struct vcpu_svm *svm)
+void sev_es_vcpu_reset(struct vcpu_svm *svm)
 {
 	/*
-	 * Set the GHCB MSR value as per the GHCB specification when creating
-	 * a vCPU for an SEV-ES guest.
+	 * Set the GHCB MSR value as per the GHCB specification when emulating
+	 * vCPU RESET for an SEV-ES guest.
 	 */
 	set_ghcb_msr(svm, GHCB_MSR_SEV_INFO(GHCB_VERSION_MAX,
 					    GHCB_VERSION_MIN,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 1a70e11f0487..bb79ae8e8bcd 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1303,6 +1303,19 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 
 }
 
+static void __svm_vcpu_reset(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	svm_vcpu_init_msrpm(vcpu, svm->msrpm);
+
+	svm_init_osvw(vcpu);
+	vcpu->arch.microcode_version = 0x01000065;
+
+	if (sev_es_guest(vcpu->kvm))
+		sev_es_vcpu_reset(svm);
+}
+
 static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -1311,6 +1324,9 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	svm->virt_spec_ctrl = 0;
 
 	init_vmcb(vcpu);
+
+	if (!init_event)
+		__svm_vcpu_reset(vcpu);
 }
 
 void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb)
@@ -1370,24 +1386,13 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
 
 	svm->vmcb01.ptr = page_address(vmcb01_page);
 	svm->vmcb01.pa = __sme_set(page_to_pfn(vmcb01_page) << PAGE_SHIFT);
+	svm_switch_vmcb(svm, &svm->vmcb01);
 
 	if (vmsa_page)
 		svm->vmsa = page_address(vmsa_page);
 
 	svm->guest_state_loaded = false;
 
-	svm_switch_vmcb(svm, &svm->vmcb01);
-	init_vmcb(vcpu);
-
-	svm_vcpu_init_msrpm(vcpu, svm->msrpm);
-
-	svm_init_osvw(vcpu);
-	vcpu->arch.microcode_version = 0x01000065;
-
-	if (sev_es_guest(vcpu->kvm))
-		/* Perform SEV-ES specific VMCB creation updates */
-		sev_es_create_vcpu(svm);
-
 	return 0;
 
 error_free_vmsa_page:
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 524d943f3efc..001698919148 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -561,7 +561,7 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu);
 int sev_handle_vmgexit(struct kvm_vcpu *vcpu);
 int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in);
 void sev_es_init_vmcb(struct vcpu_svm *svm);
-void sev_es_create_vcpu(struct vcpu_svm *svm);
+void sev_es_vcpu_reset(struct vcpu_svm *svm);
 void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
 void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu);
 void sev_es_unmap_ghcb(struct vcpu_svm *svm);
-- 
2.33.0.309.g3052b89438-goog

