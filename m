Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D80D3CB2C4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 08:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbhGPGg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 02:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbhGPGg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 02:36:57 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FBFC061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 23:34:03 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 62so9033220pgf.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 23:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kYvP40uuwwYr9NVoMrmSHdfuGUeNw8zjOe9FELwPdL4=;
        b=i10wPJkx51FTJMBZX5Hy+vMCcaqdopyzJHXRV8s/btNrCYRef3A2/5JXNcQHwpRTNk
         RgB6Ps9KiV6tEudpiJjEL9+7KwqYzkKTUCCTb3XABri31BWTCwayLVO8HmEbBytRs0pF
         Q94KGUkiR4YhoVqPUkGvPMGpwb4ndv3VMDxYehZCLbKff1Q0U5KSxpeLhfN+kMO1jaAK
         0Na4UrVExAYqFS/rskmxjm6X5A6EKxVyTYpTWSKt+BlMAyUnztEgDjlnsWlwgKLb2F3m
         xTMCe78J6I5jRX11vHyfRUb17JxP0Uz/uTrKO4oGg3GUPvFGUUnlx0AY7iib8PmMERuR
         aE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kYvP40uuwwYr9NVoMrmSHdfuGUeNw8zjOe9FELwPdL4=;
        b=k3SZEX/xYYoE2glegW+8JSJPy9csEbvzmjYnPis5G1btO5mYxmVsA5QhqwWKxiZIhv
         GxLoEWDbbCQZb+ZwEeAUQnJ2tYHBoqXupUePrk16rvSyM9xLgJcSjtjqXSc0vnoWyKEw
         T7Lw5tQrL9n/xzypXFtmxnsR5D7luyRyad8sP/stDbY52Rt6E2AyRJqzpAcSWMsLRMtk
         ErcOXZyc6g9G6MoYSgSfTh21Bk6/xwN/aDJQ8juTmqpU7aSJ/gKwhWNYt8aUUI42kYAU
         qUiCNGwtpcVpQ5EYVhjgCqZJtgvPZ8Ykvrvhlg2GrgzX2R0QKVTvNkjJwrHHkFCTqeXq
         AGcA==
X-Gm-Message-State: AOAM532tSEH6t1bgsEQIleI6JXfCFtt0A9WuHMLp7QqKDZm5y7jih/XA
        3lYv9nPcEc6MpBQgkAcXJ67FZvW9JIsw9g==
X-Google-Smtp-Source: ABdhPJz9VuhIjYijYTpi8Gq1hjp6m6Pggkhz2RRYMy7Mu3bFoYt/B+xFxmH9qOi167xqMu2qfJM4XA==
X-Received: by 2002:a62:154e:0:b029:32b:743f:dccb with SMTP id 75-20020a62154e0000b029032b743fdccbmr8507710pfv.57.1626417242559;
        Thu, 15 Jul 2021 23:34:02 -0700 (PDT)
Received: from anisinha-lenovo.ba.nuagenetworks.net ([115.96.126.211])
        by smtp.googlemail.com with ESMTPSA id v69sm9047971pfc.118.2021.07.15.23.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 23:34:02 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
To:     linux-kernel@vger.kernel.org
Cc:     anirban.sinha@nokia.com, mikelley@microsoft.com,
        Ani Sinha <ani@anisinha.ca>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-hyperv@vger.kernel.org
Subject: [PATCH] x86/hyperv: add comment describing TSC_INVARIANT_CONTROL MSR setting bit 0
Date:   Fri, 16 Jul 2021 12:03:41 +0530
Message-Id: <20210716063341.2865562-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dce7cd62754b5 ("x86/hyperv: Allow guests to enable InvariantTSC")
added the support for HV_X64_MSR_TSC_INVARIANT_CONTROL. Setting bit 0
of this synthetic MSR will allow hyper-v guests to report invariant TSC
CPU feature through CPUID. This comment adds this explanation to the code
and mentions where the Intel's generic platform init code reads this
feature bit from CPUID. The comment will help developers understand how
the two parts of the initialization (hyperV specific and non-hyperV
specific generic hw init) are related.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 arch/x86/kernel/cpu/mshyperv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 715458b7729a..d2429748170d 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -368,6 +368,14 @@ static void __init ms_hyperv_init_platform(void)
 	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
 #endif
 	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
+		/*
+		 * Setting bit 0 of the synthetic MSR 0x40000118 enables
+		 * guests to report invariant TSC feature through CPUID
+		 * instruction, CPUID 0x800000007/EDX, bit 8. See code in
+		 * early_init_intel() where this bit is examined. The
+		 * setting of this MSR bit should happen before init_intel()
+		 * is called.
+		 */
 		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 	}
-- 
2.25.1

