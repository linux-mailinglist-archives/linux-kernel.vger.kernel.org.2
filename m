Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DBE367741
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhDVCNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbhDVCMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:12:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F174C06134D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:11:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f7-20020a5b0c070000b02904e9a56ee7e7so18149646ybq.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=aWI/oX9oWB/hl9QdG+c4lHwJM0nKmk+pq/bbva7Q8do=;
        b=F5XDDthI3v7lBZni4HzRvwmxbRK+QBMmfBrbmdlKYrxUcEeBzdil91bvCqSwqnP6BJ
         7Y2I0cpm2qKqiwlXTiOPbe94FNgQDJsMzjJw8fNYxE0NqdOYoQCdQ+dcIDNxjn+Bc9z3
         BJQ3/GdQymrk1VXrKbFANWGvJJEDzy/Nai75KPGWBrZazai9yCzM2/fh7tLN0qhid37J
         cU44VLXqF34QAuzAQ16I4hBOZj3E8GUb+xKYbkQZrS5lr2GzGDtD4761kTFNlqh3IXul
         ttJbAsPzV1vHPtMGNhBWSM3C+P9LS1LygqvoOm1/uZAQp+/HCsZLnruDRVTxr4Lubn5H
         FKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=aWI/oX9oWB/hl9QdG+c4lHwJM0nKmk+pq/bbva7Q8do=;
        b=nW4ANwKjt9+I7fE4NxpHxFCwmRKxFf52Z6gSD3KzZNxOtehQHrSqLcmh2Fz1IbZRV4
         EKZqd8rsMQHNMKJT0VX2ngTOZ43nIvcxnobl0JQeeAzZZPT5Hi49tLLDXLGHAZTcvIk9
         TBimOvL/rTr5HWn7FtchBPITN1CaQK3Iw4Ky8RzOoQ/3cCiSmMDxDX4jPWkL0yhC5pbn
         aTEfV/rTCypKOLRbGcP6TxjKy9ZKjt9CYjU+lFWpO7ydr1W2lsZczC76UqTiWAW9qpaR
         +KMTj1VsZaQ7sLWmEQcN78lkKFOFzeaid1ipOnm24FgI8W+OfUwKA5o5SwslzZQBk7Pi
         62DQ==
X-Gm-Message-State: AOAM531S8rs01mqajCMUbPaU7lzbZAj/55Q4R71mQmWJiTF52CMTuBEg
        6a4lQLCzjMj8pUOLr4U3P3ZOKBAgO1o=
X-Google-Smtp-Source: ABdhPJyMfd9ZDN8qlRdlHxrqdYLXMVflXu6wRslMAp5U4iF+w+rZvNT4XHi0I8J9Pmek9LZ1NAwAJKjtjgk=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e012:374c:592:6194])
 (user=seanjc job=sendgmr) by 2002:a5b:452:: with SMTP id s18mr1418504ybp.482.1619057516481;
 Wed, 21 Apr 2021 19:11:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Apr 2021 19:11:23 -0700
In-Reply-To: <20210422021125.3417167-1-seanjc@google.com>
Message-Id: <20210422021125.3417167-14-seanjc@google.com>
Mime-Version: 1.0
References: <20210422021125.3417167-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v5 13/15] KVM: SVM: Drop redundant svm_sev_enabled() helper
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

Replace calls to svm_sev_enabled() with direct checks on sev_enabled, or
in the case of svm_mem_enc_op, simply drop the call to svm_sev_enabled().
This effectively replaces checks against a valid max_sev_asid with checks
against sev_enabled.  sev_enabled is forced off by sev_hardware_setup()
if max_sev_asid is invalid, all call sites are guaranteed to run after
sev_hardware_setup(), and all of the checks care about SEV being fully
enabled (as opposed to intentionally handling the scenario where
max_sev_asid is valid but SEV enabling fails due to OOM).

Reviewed by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 6 +++---
 arch/x86/kvm/svm/svm.h | 5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 68999085db6e..4440459cf8e3 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1457,7 +1457,7 @@ int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 	struct kvm_sev_cmd sev_cmd;
 	int r;
 
-	if (!svm_sev_enabled() || !sev_enabled)
+	if (!sev_enabled)
 		return -ENOTTY;
 
 	if (!argp)
@@ -1844,7 +1844,7 @@ void __init sev_hardware_setup(void)
 
 void sev_hardware_teardown(void)
 {
-	if (!svm_sev_enabled())
+	if (!sev_enabled)
 		return;
 
 	bitmap_free(sev_asid_bitmap);
@@ -1855,7 +1855,7 @@ void sev_hardware_teardown(void)
 
 int sev_cpu_init(struct svm_cpu_data *sd)
 {
-	if (!svm_sev_enabled())
+	if (!sev_enabled)
 		return 0;
 
 	sd->sev_vmcbs = kcalloc(max_sev_asid + 1, sizeof(void *), GFP_KERNEL);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 0af638f97b5f..f455784519d7 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -568,11 +568,6 @@ void svm_vcpu_unblocking(struct kvm_vcpu *vcpu);
 
 extern unsigned int max_sev_asid;
 
-static inline bool svm_sev_enabled(void)
-{
-	return IS_ENABLED(CONFIG_KVM_AMD_SEV) ? max_sev_asid : 0;
-}
-
 void sev_vm_destroy(struct kvm *kvm);
 int svm_mem_enc_op(struct kvm *kvm, void __user *argp);
 int svm_register_enc_region(struct kvm *kvm,
-- 
2.31.1.498.g6c1eba8ee3d-goog

