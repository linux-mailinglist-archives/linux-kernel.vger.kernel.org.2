Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC963CB7E0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 15:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239391AbhGPNf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbhGPNfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:35:54 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887ABC061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 06:32:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g24so6455551pji.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 06:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=selXb4Bpi1MsQNNsOTSazIAMo3P6W3ZQxlBy+7d1uoA=;
        b=TKilLRGbQctMearfWgitH6Ew9iqkFRPPoNfm4Ep2oUcmmMFvI3jhFgAIZWHZQE3pqd
         KmraLPyMfR52nqwn100K7VEKcTyCCOHda4CUEN/aP+wRnBtCvUjcD5DU3Qdz4kB6gsBt
         5vqp3L3eid5W6E5VukZ9QRN7WrcgIZsSQv8cFLxot0b4dSyoqAetBaJXnica98nfDvKf
         XLVHVhXZ6oPFQufyxls0PnLHGhGMlas9vd9SCepwmmBJu/wIE5I3UHL7fgAM8rFT+AAm
         LVnqYBjsEkM5LRcX1q5EeqRg+Wj3YKZH9XUFZRG7Feheupz8oblp5Xoh718Hy6Vx4Iec
         giyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=selXb4Bpi1MsQNNsOTSazIAMo3P6W3ZQxlBy+7d1uoA=;
        b=nYURYyM3mqMhMM2OvS5OWDleParXYl0hbOh+HoASh9Q0zXGDefEXASAE07dPwf+bh2
         Ot7Io9DFNiVe6zbD2dWz8RgT0aXiXQWGCOklBX6I/NmFW5+gJVa0Ailh9nlz4mWsItgP
         rVLSyLoPqVUwJu3498dcSYi2cW0kPy2u+SLBBVUh7mbPKuD6mLhSTjizk6n1SfpXkVBw
         h2hGLyg/o6sgnGnVIJk1g27aoKI8jlEY+W/tS8T8ppmOVn6VNR2L2swndxTT+3QtfwMr
         InOgHqmzsWWCy0IiVJDoF5kAkl2jQd8U9Q0009iMCHB0NE3KejWlN3Pd681UH3dQqy84
         NODA==
X-Gm-Message-State: AOAM533SQUZ9UJykUVtyqnBZpqrl7My27l/6HvApcNz+LQdka/xrWO6P
        36Z9Lqf4w0JSq5JUUnPwLsSW6HSqIKUNka3P
X-Google-Smtp-Source: ABdhPJygtVXL3lsL1CB5q8xnQgTzQFCwFB8iHKf0NCmk7gV17UIErzJ4qWzHrSYgd2EeFyQLuDCs3w==
X-Received: by 2002:a17:902:760c:b029:129:2dde:f8c9 with SMTP id k12-20020a170902760cb02901292ddef8c9mr8036733pll.41.1626442378595;
        Fri, 16 Jul 2021 06:32:58 -0700 (PDT)
Received: from anisinha-lenovo.ba.nuagenetworks.net ([115.96.126.211])
        by smtp.googlemail.com with ESMTPSA id v14sm11434730pgo.89.2021.07.16.06.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 06:32:58 -0700 (PDT)
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
Subject: [PATCH v2] x86/hyperv: add comment describing TSC_INVARIANT_CONTROL MSR setting bit 0
Date:   Fri, 16 Jul 2021 19:02:45 +0530
Message-Id: <20210716133245.3272672-1-ani@anisinha.ca>
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
 arch/x86/kernel/cpu/mshyperv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

changelog:
v1: initial patch
v2: slight comment update based on received feedback.

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 715458b7729a..3b05dab3086e 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -368,6 +368,15 @@ static void __init ms_hyperv_init_platform(void)
 	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
 #endif
 	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
+		/*
+		 * Writing to synthetic MSR 0x40000118 updates/changes the
+		 * guest visible CPUIDs. Setting bit 0 of this MSR  enables
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

