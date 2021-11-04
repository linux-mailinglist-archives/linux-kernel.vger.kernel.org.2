Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095114459A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 19:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhKDSZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 14:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbhKDSZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:25:25 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD1EC061208
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 11:22:47 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id w13-20020a63934d000000b002a2935891daso4302759pgm.15
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=jpAcC9sKt5b/T+a4qZnHVk8srWMFmGVXhrzjULcw9gM=;
        b=XU3u9vuox99tFvdn2blqlYHVvzPWHcPxHBksOxD75cbfDSXbPe9AdiYsKvU24bWp2a
         UByzBBkp3i4b65+SGbvChxsrKDHANb1/52Q6h8MgvFKobE3Qkm0uxiewekYvm74qBRQJ
         zZ6FrpbUi0BaDLOpJJD416GpbxNsi0bVcbs+gGSUcZ+Zg3sRvT2CTf6XTQ+xrSxTQjAj
         oVOlLNdpS5yz6LooPyyT8TI2Q2+82ll+XvaNojQmQJOdGLuuWSlYGJL3gAhttpIA8q7R
         mukxt0JJPqim3Dv9Q+V81LsgGoLV1EwXdLFqqeAAiDYaoVwQlSQeyOatBD3+rJy6Yx2/
         86Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=jpAcC9sKt5b/T+a4qZnHVk8srWMFmGVXhrzjULcw9gM=;
        b=fZMiameJqfJ/GKck9NGUWl1MYFCmSCbYRbH7Kaj6G2fIE5sB0z0COm4EBUfgr5nNaK
         aS+7SY0QRhXuP2zQv4Topw1yBm/hyDXXZdoWj753RcPpWdcbsihLbq1ehL/KTt9Y/IhQ
         yDoA/mDenXly38niRYIULEjLL/8gPkADs3/oe28egC8WEjAd6u39zxfyliMyZXYxampY
         fYOD55v0JQz5TWxJ4hEQmpFNh8eqo97GslAvTa0Vi5bGkHBnf4UVZBgxM//SwvdP1D5N
         TSCeExB6mceFvX/TThK8Pk+cO5loMK0EPV6BMDXNiCax4KQ4myu+UVZRK5g0bhrncqma
         ORQg==
X-Gm-Message-State: AOAM531C8bBUGGq8CF2cmXt4r9B/oKnfwNjS178zCOmfZGwbmvA9oj+D
        okAqqTmZgTtpjtXvFUmDIK3/NWyr8e8=
X-Google-Smtp-Source: ABdhPJy86zvK8IJJ4Z5x9l95/Gc4m+3iWcNRdRFBnmMcxqJ9yjg7fLi2Mlj4km5rKu8VJG04D6OuRXCo3Ks=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:5285:: with SMTP id
 w5mr166505pjh.1.1636050166841; Thu, 04 Nov 2021 11:22:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  4 Nov 2021 18:22:39 +0000
In-Reply-To: <20211104182239.1302956-1-seanjc@google.com>
Message-Id: <20211104182239.1302956-3-seanjc@google.com>
Mime-Version: 1.0
References: <20211104182239.1302956-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 2/2] x86/hyperv: Move required MSRs check to initial
 platform probing
From:   Sean Christopherson <seanjc@google.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/hyperv/hv_init.c      |  9 +--------
 arch/x86/kernel/cpu/mshyperv.c | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 7d252a58fbe4..96eb7db31c8e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -386,20 +386,13 @@ static void __init hv_get_partition_id(void)
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
index 4794b716ec79..ff55df60228f 100644
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
2.34.0.rc0.344.g81b53c2807-goog

