Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D775B36772C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhDVCMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbhDVCMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:12:09 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1338C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:11:35 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h23-20020a05620a0537b02902e08ab174dbso10999336qkh.19
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=GEPLsHhggE4ujUPOGn3n4zU31w1TV+qR4/TlaMRYRNY=;
        b=slPLX5Efpq5Qz6dVPkoukEQX3cvFsE+OlhS0eupMy6lak7A1sC6I+FejoF2EJMPNbW
         a7HWdaIzf85VrMLEjD1W+k0wGM2yJabxz9WzxZZNemvI7hvsu1hPChw2a7jYwe/p8kz7
         sGiHdL2qrChIGywdW162odvkZzDsOk5uQEdQ2TrSG/naHYX4gfX27i6QDseT5oBtBDd0
         bjUSCHJVZ2D8IrF/akRfgEpfS5mUO2bG9b+mfFpzCiIK2liGMV47QQGpWbMDL9A1yB07
         SXhfvhL7Smd73RmViLgulFOSgTU//HyXoX0MILJm3EAAXKUBJ6cGHZxeVbje/gvvXsdS
         MCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=GEPLsHhggE4ujUPOGn3n4zU31w1TV+qR4/TlaMRYRNY=;
        b=K9aSLlE5GTt6kAGgltVzwb4G+S6lkQM2P2dXFIWGHDx+g9vLqUXxd7ybQh4iV7UysY
         pDzx5rTP5Gs424HnwgX3tmBFBOTlZ9kzjTCd9ZLl33FOBcdGp3WrZB2ctdizNUd6JxM9
         oRd6OM53O6OOsN0pLyHI3qOj2xkqxNxzMoHt3vUdoOl9RGo3adEM7sjVhM2AmCm2CGnW
         gktaLCCWxzJbt7bb43FREIH2B/6cqnJr7uySFjhBnAdXXXxp4DZvQiCpg0zPzMjFQUC3
         DA4XlzYvwf19cH8heD/irGtFKqAqk31b2fyA6fFJ+lTBuvRAgztcjYf2mJ9Wayf+ORrD
         BYDg==
X-Gm-Message-State: AOAM532tscIbo/38JEagR3lX0BTMYG+MIkrLN0C0VTYnwcqJg0afnYba
        WMKiBUwvqufQOtMRyY1wdxu4uF/VPF0=
X-Google-Smtp-Source: ABdhPJwSvYb/iu1t6hDfJHd6JCkiT0surOC8wPVw8IEmD23tTMd2MYm2hMkVOHQVvjeGSzeSshdNXw2tkak=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e012:374c:592:6194])
 (user=seanjc job=sendgmr) by 2002:a05:6214:1484:: with SMTP id
 bn4mr1180810qvb.33.1619057494976; Wed, 21 Apr 2021 19:11:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Apr 2021 19:11:13 -0700
In-Reply-To: <20210422021125.3417167-1-seanjc@google.com>
Message-Id: <20210422021125.3417167-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210422021125.3417167-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v5 03/15] KVM: SVM: Disable SEV/SEV-ES if NPT is disabled
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

Disable SEV and SEV-ES if NPT is disabled.  While the APM doesn't clearly
state that NPT is mandatory, it's alluded to by:

  The guest page tables, managed by the guest, may mark data memory pages
  as either private or shared, thus allowing selected pages to be shared
  outside the guest.

And practically speaking, shadow paging can't work since KVM can't read
the guest's page tables.

Fixes: e9df09428996 ("KVM: SVM: Add sev module_param")
Cc: Brijesh Singh <brijesh.singh@amd.com
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index fed153314aef..0e8489908216 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -970,7 +970,21 @@ static __init int svm_hardware_setup(void)
 		kvm_enable_efer_bits(EFER_SVME | EFER_LMSLE);
 	}
 
-	if (IS_ENABLED(CONFIG_KVM_AMD_SEV) && sev) {
+	/*
+	 * KVM's MMU doesn't support using 2-level paging for itself, and thus
+	 * NPT isn't supported if the host is using 2-level paging since host
+	 * CR4 is unchanged on VMRUN.
+	 */
+	if (!IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_X86_PAE))
+		npt_enabled = false;
+
+	if (!boot_cpu_has(X86_FEATURE_NPT))
+		npt_enabled = false;
+
+	kvm_configure_mmu(npt_enabled, get_max_npt_level(), PG_LEVEL_1G);
+	pr_info("kvm: Nested Paging %sabled\n", npt_enabled ? "en" : "dis");
+
+	if (IS_ENABLED(CONFIG_KVM_AMD_SEV) && sev && npt_enabled) {
 		sev_hardware_setup();
 	} else {
 		sev = false;
@@ -985,20 +999,6 @@ static __init int svm_hardware_setup(void)
 			goto err;
 	}
 
-	/*
-	 * KVM's MMU doesn't support using 2-level paging for itself, and thus
-	 * NPT isn't supported if the host is using 2-level paging since host
-	 * CR4 is unchanged on VMRUN.
-	 */
-	if (!IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_X86_PAE))
-		npt_enabled = false;
-
-	if (!boot_cpu_has(X86_FEATURE_NPT))
-		npt_enabled = false;
-
-	kvm_configure_mmu(npt_enabled, get_max_npt_level(), PG_LEVEL_1G);
-	pr_info("kvm: Nested Paging %sabled\n", npt_enabled ? "en" : "dis");
-
 	if (nrips) {
 		if (!boot_cpu_has(X86_FEATURE_NRIPS))
 			nrips = false;
-- 
2.31.1.498.g6c1eba8ee3d-goog

