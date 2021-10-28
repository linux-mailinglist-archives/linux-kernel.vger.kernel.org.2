Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049FB43F2AE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 00:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhJ1WYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 18:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhJ1WYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 18:24:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1A2C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:22:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v18-20020a25fc12000000b005c1f3933580so3977811ybd.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=R5Vj2cz0XxBaTLMYx6D72vVpihASRpZeUPjo+Z9uVwU=;
        b=TlOl+cee0T9klC6MCTFU8JyexPMykshVX4RziZbSqbjw+pFVfMqyZtx+r9m/vUb1BS
         zQNwnGumg205s9WN6CxAadEE/UkuE8Dh1fIKNjKP3doLIYAeThBA3vf4s6egLRFOCHay
         7UF4n8Jqa5e7/Q/J8llSxap5G/8oA9nykMqZVCjQHRvhEFAp84V4U70TKbP6gWq3VmiF
         tnd4I+fe19JKAzubliobpEaJz0SYbbVSkqCoz5Zw/Eb2599o9ejRH84jtOt8kgGTK2rX
         zTDemykSnnlhSxhIH3n0yFPApyubTdZUox8Yp0XCMAqwUzWVY8KO2vpqJrVf4IsiPBZI
         QXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=R5Vj2cz0XxBaTLMYx6D72vVpihASRpZeUPjo+Z9uVwU=;
        b=0P9svRmcSLo4u6AyTin1cHwRbk5r5oVfrrhc1zvM+xIk8W1fQ/SFEl46CFegdYmu3Z
         xFP4+UK8UPcJdjq/XAHjzw1FrQ4WxdFSBKpSRsM7H2owZtp27YKgM1sRd82SmSq7U1Rt
         xKEKv50kYYzNOWj4ImggwomqK17gsuqf4FDKR6A180ft6JcEKeZtqZuYO2nFbGsiClUP
         58UgRaTYQoNHk8OApZCfKIs43XPIjeV9W4Dt+uaUGGIZ7Vcz5S8tYbeuXbojufD30iXX
         UNJ+qhCZSyqeiIcHo+kB3kgqf7ONkEYTG7sl3nSLtXf0fiKBV1J5CuRyjxN0Xq3The7B
         tImA==
X-Gm-Message-State: AOAM530yCP4hg0zEvDpvGkeYpfwIExs7I4Ch4WC5tCblpPtU/L3oWKBY
        YPdSJ0lYfyboDe2do375Pk/Xywp2yGg=
X-Google-Smtp-Source: ABdhPJzn09D8Z+miVZNv9veUBEk5F1G5T1hWANCg8wuQzzZEydHxex3xphBCcE7TGVdDY0vKaNtYe4ALQxY=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:cbc8:1a0d:eab9:2274])
 (user=seanjc job=sendgmr) by 2002:a5b:401:: with SMTP id m1mr7629430ybp.387.1635459721597;
 Thu, 28 Oct 2021 15:22:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 28 Oct 2021 15:21:48 -0700
In-Reply-To: <20211028222148.2924457-1-seanjc@google.com>
Message-Id: <20211028222148.2924457-3-seanjc@google.com>
Mime-Version: 1.0
References: <20211028222148.2924457-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 2/2] x86/hyperv: Move required MSRs check to initial platform probing
From:   Sean Christopherson <seanjc@google.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly check for MSR_HYPERCALL and MSR_VP_INDEX support when probing
for running as a Hyper-V guest instead of waiting until hyperv_init() to
detect the bogus configuration.  Add messages to give the admin a heads
up that they are likely running on a broken virtual machine setup.

At best, silently disabling Hyper-V is confusing and difficult to debug,
e.g. the kernel _says_ it's using all these fancy Hyper-V features, but
always falls back to the native versions.  At worst, the half baked setup
will crash/hang the kernel.

Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/hyperv/hv_init.c      |  9 +--------
 arch/x86/kernel/cpu/mshyperv.c | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6cc845c026d4..abfb09610e22 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -347,20 +347,13 @@ static void __init hv_get_partition_id(void)
  */
 void __init hyperv_init(void)
 {
-	u64 guest_id, required_msrs;
+	u64 guest_id;
 	union hv_x64_msr_hypercall_contents hypercall_msr;
 	int cpuhp;
 
 	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
 		return;
 
-	/* Absolutely required MSRs */
-	required_msrs = HV_MSR_HYPERCALL_AVAILABLE |
-		HV_MSR_VP_INDEX_AVAILABLE;
-
-	if ((ms_hyperv.features & required_msrs) != required_msrs)
-		return;
-
 	if (hv_common_init())
 		return;
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e095c28d27ae..ef6316fef99f 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -163,12 +163,22 @@ static uint32_t  __init ms_hyperv_platform(void)
 	cpuid(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS,
 	      &eax, &hyp_signature[0], &hyp_signature[1], &hyp_signature[2]);
 
-	if (eax >= HYPERV_CPUID_MIN &&
-	    eax <= HYPERV_CPUID_MAX &&
-	    !memcmp("Microsoft Hv", hyp_signature, 12))
-		return HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
+	if (eax < HYPERV_CPUID_MIN || eax > HYPERV_CPUID_MAX ||
+	    memcmp("Microsoft Hv", hyp_signature, 12))
+		return 0;
 
-	return 0;
+	/* HYPERCALL and VP_INDEX MSRs are mandatory for all features. */
+	eax = cpuid_eax(HYPERV_CPUID_FEATURES);
+	if (!(eax & HV_MSR_HYPERCALL_AVAILABLE)) {
+		pr_warn("x86/hyperv: HYPERCALL MSR not available.\n");
+		return 0;
+	}
+	if (!(eax & HV_MSR_VP_INDEX_AVAILABLE)) {
+		pr_warn("x86/hyperv: VP_INDEX MSR not available.\n");
+		return 0;
+	}
+
+	return HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
 }
 
 static unsigned char hv_get_nmi_reason(void)
-- 
2.33.0.1079.g6e70778dc9-goog

