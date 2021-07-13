Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6B13C68CD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 05:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhGMDIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 23:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhGMDIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 23:08:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CA8C0613E9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 20:05:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id me13-20020a17090b17cdb0290173bac8b9c9so521772pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 20:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DXyb8cCIwppWpUQRpcQXTZ4WLjfNm/trhJb3p3mykm0=;
        b=Wrk1pvOWsKkxGAS6xO1JSip9axSHIXu7zN43XZ3Y6OeFe8SiG3kmD6DfjBGKHmvRNu
         1tx6Q0Lqj/xW83VuhPW4GA8LVq3d9A60JTeO6d1VlPqet/yIO3Zc14O4/P0e7le1QkUC
         4ZbJb2HvcqX5DMLOKnt7H7RGL/RnSuNddYdhHl5GRRoxN6OYikYBtMauZoDin51cAHnl
         sUMQmjieW2GFqMLdHLQ92ZU7UlQ7V/nBHhyCNRkqTCiJAtTANdldMoN3cXqkUpQDWQqx
         uGkMQDiG22/LKnmzVxboKITqXkaUzI9/AyLzb7l5GOWB8ZGyKkRkBHiBl0+1kSdDQuQG
         oWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DXyb8cCIwppWpUQRpcQXTZ4WLjfNm/trhJb3p3mykm0=;
        b=j2100XlYGKK/bSkIUQHzy1rNmSvPnW58HrkkP/+dogT7+S4h5u549AhKjEBDYrZBxF
         K6vd9geitfAbi1x7uDkTPLNbqBTfJF0NU3+1eSQLub8Qo75kSaNXz04umiT3CXZZQD92
         AXdEF5/g59NPT+Cdi/B3MqgH3BPDX+ArRRrKp4mfGiEmjOEZpRG+eXJNsegfpe9R8AZ4
         mv2p9rPgksiXJtxb4QtckLbyZnEcjH+o1SDbHpYCjWfs6croBpJwodRyqnF1Cb270xLO
         tI05SqPrSzbt22St2uEdQROO6DNTJ8pdu9ko8V4qtu8HrbipUIi/41BTBfbBy+P0dfvj
         F+YA==
X-Gm-Message-State: AOAM532UDTTkR64NT6epFOyB6SA2bF4NBtIIhTv5coM5Ai78T5VmeYCn
        /AYy51Wsa7PvEwTFoE1L3X82MWyb0u0t7g==
X-Google-Smtp-Source: ABdhPJzZif/raFVcicQFOqIrBxg4Ue1CHBHc2rqAoxPW9eqSfy8aClfLAUnev1B62ZFmhFxTaOsYgQ==
X-Received: by 2002:a17:90a:9ab:: with SMTP id 40mr10994553pjo.9.1626145554063;
        Mon, 12 Jul 2021 20:05:54 -0700 (PDT)
Received: from anisinha-lenovo.ba.nuagenetworks.net ([115.96.120.123])
        by smtp.googlemail.com with ESMTPSA id p5sm10447984pfn.46.2021.07.12.20.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 20:05:53 -0700 (PDT)
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
Subject: [PATCH] Hyper-V: fix for unwanted manipulation of sched_clock when TSC marked unstable
Date:   Tue, 13 Jul 2021 08:35:21 +0530
Message-Id: <20210713030522.1714803-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marking TSC as unstable has a side effect of marking sched_clock as
unstable when TSC is still being used as the sched_clock. This is not
desirable. Hyper-V ultimately uses a paravirtualized clock source that
provides a stable scheduler clock even on systems without TscInvariant
CPU capability. Hence, mark_tsc_unstable() call should be called _after_
scheduler clock has been changed to the paravirtualized clocksource. This
will prevent any unwanted manipulation of the sched_clock. Only TSC will
be correctly marked as unstable.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 arch/x86/kernel/cpu/mshyperv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 22f13343b5da..715458b7729a 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -370,8 +370,6 @@ static void __init ms_hyperv_init_platform(void)
 	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
 		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
-	} else {
-		mark_tsc_unstable("running on Hyper-V");
 	}
 
 	/*
@@ -432,6 +430,12 @@ static void __init ms_hyperv_init_platform(void)
 	/* Register Hyper-V specific clocksource */
 	hv_init_clocksource();
 #endif
+	/* TSC should be marked as unstable only after Hyper-V
+	 * clocksource has been initialized. This ensures that the
+	 * stability of the sched_clock is not altered.
+	 */
+	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
+		mark_tsc_unstable("running on Hyper-V");
 }
 
 static bool __init ms_hyperv_x2apic_available(void)
-- 
2.25.1

