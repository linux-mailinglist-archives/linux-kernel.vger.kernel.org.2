Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3FB32F7AC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 03:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhCFB7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 20:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhCFB7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 20:59:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98C9C061760
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 17:59:31 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d8so4619201ybs.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 17:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=5mX8Ozru9POHGSen+cT/TMfD88mH/rez7QuWZU4Qh+A=;
        b=ran5tY9Iu/tRFDanHhMFfXF0KwkxL7C0Vj8tETV9xqQbnI0sYGE7qhRy6kfiXE6MwR
         cg/Ude4WTT0EH2pZAHkmhLD4EFjdiIjXw2MH4fdCDXTLdBAZRk7iuV/r0fTe1+8SvC0y
         aZJnVnKOqjPQOIlqZXGOx/eaG4sQioEBwAq6oB9eCPtqQs+Wp90v6aU67p04DZ7qvhGe
         YyGvoGLLCt2vCItPDxzIHFbqZBuUE8pTflDjLQTkvUGoKYFCXtBz1hh1x7cvfahKmtRS
         lMfylUAnl2Fs6OijF57hV3uDPTiNcqffkztZ59aDGX08Hwz3dcVXJdxAeNQxgBUr+Cv6
         V0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=5mX8Ozru9POHGSen+cT/TMfD88mH/rez7QuWZU4Qh+A=;
        b=Enpztxtlkf5XmasyigXo1fgQ0YaGANCq7OGLwkv2samu12R6nitS5F+KyEDRe5RWoY
         uI6f6n5MZRwiTboFz0L5Z1PbIovno6JGIt5vOpOdM9di/PN4JHXSHDknqCEiW+PfRPEG
         eo1oLvbkHFRLmy0q73dtx0UDLLdnQnJVGc+lkJ2yrJ6GpzxrV7IqBuQuquQ11+jiCeEE
         biHbhK3Ia5Zt5d1XK2fUv3i5G87RNL1Or7OaB0tRnHj+Ch8i2MORBTT86EM+v29g0YXf
         TVfwH7Pjiw2vRD4/3Lykzdjwb4vGbdK30CeVwOsk8He1nG9sVwqxUFrVo/NdKZBDSnqf
         93kw==
X-Gm-Message-State: AOAM533wxLrfa0mIybvFHY6r5r3QaqUifAG15gOw9JhIyZ6IdvJWIi29
        NEcGW4RNkWTpLLcRcqqBG0/pWafe0Tw=
X-Google-Smtp-Source: ABdhPJzvKublaBMwQf60DWO0PJ3pBuMeCoEpWFfotrgt7gXz49gC+ec88jdZeWgeBc/2biO7FRMH5/QbiZ0=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:fc04:f9df:1efb:bf0c])
 (user=seanjc job=sendgmr) by 2002:a25:b09e:: with SMTP id f30mr18578139ybj.199.1614995971140;
 Fri, 05 Mar 2021 17:59:31 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  5 Mar 2021 17:58:57 -0800
In-Reply-To: <20210306015905.186698-1-seanjc@google.com>
Message-Id: <20210306015905.186698-7-seanjc@google.com>
Mime-Version: 1.0
References: <20210306015905.186698-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 06/14] KVM: SVM: Append "_enabled" to module-scoped
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
used for local struct kvm_sev_info pointers).

No functional change intended.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 871e040aad16..d6f069271e75 100644
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
@@ -214,7 +214,7 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 static int sev_es_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 {
-	if (!sev_es)
+	if (!sev_es_enabled)
 		return -ENOTTY;
 
 	to_kvm_svm(kvm)->sev_info.es_active = true;
@@ -1123,7 +1123,7 @@ int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 	struct kvm_sev_cmd sev_cmd;
 	int r;
 
-	if (!svm_sev_enabled() || !sev)
+	if (!svm_sev_enabled() || !sev_enabled)
 		return -ENOTTY;
 
 	if (!argp)
@@ -1332,7 +1332,7 @@ void __init sev_hardware_setup(void)
 	bool sev_es_supported = false;
 	bool sev_supported = false;
 
-	if (!IS_ENABLED(CONFIG_KVM_AMD_SEV) || !sev)
+	if (!IS_ENABLED(CONFIG_KVM_AMD_SEV) || !sev_enabled)
 		goto out;
 
 	/* Does the CPU support SEV? */
@@ -1370,7 +1370,7 @@ void __init sev_hardware_setup(void)
 	sev_supported = true;
 
 	/* SEV-ES support requested? */
-	if (!sev_es)
+	if (!sev_es_enabled)
 		goto out;
 
 	/* Does the CPU support SEV-ES? */
@@ -1385,8 +1385,8 @@ void __init sev_hardware_setup(void)
 	sev_es_supported = true;
 
 out:
-	sev = sev_supported;
-	sev_es = sev_es_supported;
+	sev_enabled = sev_supported;
+	sev_es_enabled = sev_es_supported;
 }
 
 void sev_hardware_teardown(void)
-- 
2.30.1.766.gb4fecdf3b7-goog

