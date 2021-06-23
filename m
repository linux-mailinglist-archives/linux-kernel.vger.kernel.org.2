Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DB83B23CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 01:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFWXIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 19:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFWXIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 19:08:32 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31392C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:06:13 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 4-20020a05620a0784b02903b2faed5869so3211404qka.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=JYOF6IU31rISPQS51fxGfY25qPgNWHWroepjRPbVyV0=;
        b=FhDEofVv7xZfuj0yEbanAeLh5izVcGy94ZW/HpIxrq+UTUfNz5932VE3qFDG90wFze
         HFSZ52k9mcrYSV+VtkUaHKwh3gr1GZ1Ux6JsrdeRDten3lWqA6Vort0o2Ru4mb83KcbJ
         DcPScXdoL4aIr5jIVVMySiGw9N38hgK1UH/v+ZLzinbYQHnrXzrPq7TRo8uAhHpzwfMP
         xOCYuFE4CmwTfay1XzlAnIfrVmFFAqRjzemp2IIvmDz9wK36cCpTohzIw2v2U1SYw7Fl
         1nbrqBJ2K2sKUOcLPAeIvWHQe4IlrcafPG0y9zk2iCkrWkWDSQNMrIEw8YEBjmoNfx27
         Zm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=JYOF6IU31rISPQS51fxGfY25qPgNWHWroepjRPbVyV0=;
        b=O4SQHMnVJnGrAQhomuowhBOcKrF3MI5eRXRrcODLLIUcxlFdMYCqIEn4awiamGWQ+S
         caplaYSFRifrxqEItLl9vpAkX3KFy656W3MNwBjiy1O8Ka6bELW2aVzxjGYMh4S7fuoK
         HRwxUCRe/I6y6/ahPAcy4dKy+rYYd+kC488zpaLdBBciJtGgUDMzsbrsis1MMfa3jJD/
         UvNGatwTpZ5n7ldoD5l/g/yAe7dD+mC3aCbwthKkvpileERhQ6OTvCLMGwGBnVvDYdMg
         RzL7wBkPI+/ObaD6HWXioPsXS3AY3+zzzyrh+Hc0hXvnCMmHGxzuEJgQ/MBgiwD50isq
         +TYg==
X-Gm-Message-State: AOAM532sJNIreoyyfAtEO5TCzrU11VcOAESmdy20YNWf7NQOzhkfhYom
        zKFQ9P8j24sjEzuq/UfGAiPvEFH3Y+k=
X-Google-Smtp-Source: ABdhPJzlnWyNDJVBCpEkhcYeS0AKEtJS2LIBFOouzwcvlNqNDRnX3IgykVtM5EsNA5pqC4TTIFHy/V56rSg=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e9e:5b86:b4f2:e3c9])
 (user=seanjc job=sendgmr) by 2002:a25:b98d:: with SMTP id r13mr654971ybg.430.1624489572305;
 Wed, 23 Jun 2021 16:06:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 23 Jun 2021 16:05:51 -0700
In-Reply-To: <20210623230552.4027702-1-seanjc@google.com>
Message-Id: <20210623230552.4027702-7-seanjc@google.com>
Mime-Version: 1.0
References: <20210623230552.4027702-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 6/7] KVM: x86/mmu: Bury 32-bit PSE paging helpers in paging_tmpl.h
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move a handful of one-off macros and helpers for 32-bit PSE paging into
paging_tmpl.h.  Under no circumstance should anything but shadow paging
care about 32-bit PSE paging.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu.h             |  5 -----
 arch/x86/kvm/mmu/mmu.c         | 13 -------------
 arch/x86/kvm/mmu/paging_tmpl.h | 18 ++++++++++++++++++
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index bc11402df83b..2b9d08b080cc 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -34,11 +34,6 @@
 #define PT_DIR_PAT_SHIFT 12
 #define PT_DIR_PAT_MASK (1ULL << PT_DIR_PAT_SHIFT)
 
-#define PT32_DIR_PSE36_SIZE 4
-#define PT32_DIR_PSE36_SHIFT 13
-#define PT32_DIR_PSE36_MASK \
-	(((1ULL << PT32_DIR_PSE36_SIZE) - 1) << PT32_DIR_PSE36_SHIFT)
-
 #define PT64_ROOT_5LEVEL 5
 #define PT64_ROOT_4LEVEL 4
 #define PT32_ROOT_LEVEL 2
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 84d48a33e38b..ef92717bff86 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -259,23 +259,10 @@ static gpa_t translate_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u32 access,
         return gpa;
 }
 
-static int is_cpuid_PSE36(void)
-{
-	return 1;
-}
-
 static int is_nx(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.efer & EFER_NX;
 }
-
-static gfn_t pse36_gfn_delta(u32 gpte)
-{
-	int shift = 32 - PT32_DIR_PSE36_SHIFT - PAGE_SHIFT;
-
-	return (gpte & PT32_DIR_PSE36_MASK) << shift;
-}
-
 #ifdef CONFIG_X86_64
 static void __set_spte(u64 *sptep, u64 spte)
 {
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 9df7e4b315a1..a2dbea70ffda 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -31,6 +31,24 @@
 #define PT64_LVL_OFFSET_MASK(level) \
 	(GUEST_PT64_BASE_ADDR_MASK & ((1ULL << (PAGE_SHIFT + (((level) - 1) \
 						* PT64_LEVEL_BITS))) - 1))
+
+#define PT32_DIR_PSE36_SIZE 4
+#define PT32_DIR_PSE36_SHIFT 13
+#define PT32_DIR_PSE36_MASK \
+	(((1ULL << PT32_DIR_PSE36_SIZE) - 1) << PT32_DIR_PSE36_SHIFT)
+
+static inline int is_cpuid_PSE36(void)
+{
+	return 1;
+}
+
+static inline gfn_t pse36_gfn_delta(u32 gpte)
+{
+	int shift = 32 - PT32_DIR_PSE36_SHIFT - PAGE_SHIFT;
+
+	return (gpte & PT32_DIR_PSE36_MASK) << shift;
+}
+
 #endif /* __KVM_X86_PAGING_TMPL_COMMON_H */
 
 #if PTTYPE == 64
-- 
2.32.0.288.g62a8d224e6-goog

