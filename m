Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586DD40BE7D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhIODxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbhIODw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:52:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7918CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 20:51:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 5so797887plo.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 20:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DKJx/SLi+V4wgtp0LqkjJJzkkF1Cm07cZIftAhzPdss=;
        b=b4KE3ZjDPs6Kgc9ykXAr44tBbaVd02d4zi3tQLqQf4i0rMWLjhYkEhKgp4XEK38S81
         JJdp9Joxag6nm5TRwoj4n2fVuETCOuSwlkRhUxjdrUOsJQtpF9JCSA0uQI45zby6xTcW
         Zr7OSRupz9RTqH6+g5uU2A5rS2Vs0Ydv8VeOR4fjKlBnCXnzjt12mXGuCNU+Z+Hg0cFY
         iFd37mmNir6URs+LCsEbTMR7z9q//QRMSM1ikM8Z4+aKV3Iq7mRhisxIsxZrpFj5kMgt
         Y0IuVN1zDD1bKQ6ZKdG+ZQgjjBtkJE3xmSqxBoKDZa874P7YHR2u2WnYVlljeX5sMKeg
         /44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DKJx/SLi+V4wgtp0LqkjJJzkkF1Cm07cZIftAhzPdss=;
        b=XIgMZo4WQw7PBjn20twXdYh7zCGPVOMbnzk5WGiU0Srb7kyeF3wA+33or+pjD7at/8
         VjPh9elBz4j0VuBYc9RxYLBA6IsU+nVVUiYinTJu6RCvyKQ5Kwy1ZwiRT4Dl+EG/rFEq
         2mBqBqQffN0z3amfqEUZRoGcPTMyWox/qld2VeX3CfBQxrH+hdoF/lD+iHvjgxqYz4tL
         HjDnNC4XPbM8ivXUp6HGhqIcOe7Uh/zsL6HzIx/zdgo+xBjWJGVecXpffZf2pkAoSGSf
         rvEpJMzxIMIupkXRmOQgtprkB6SaEiLR+NMJkx5LcOlRsZhehTlS7qpJUkILakN1Bmjz
         43Tw==
X-Gm-Message-State: AOAM530F7kivMPte2neTX/8L4nxsyVxauavmNrANU1XOCZ8tl/w11Mid
        jPAcQijSBesFQ6TuyxnjQdjXVZpFXQ==
X-Google-Smtp-Source: ABdhPJzyqT+I8noblQU/oPjJO+VwLO4NhAY6h3B+X14EP29sqDFk+rnK8o+i8nSqhCVduujrCSIxUw==
X-Received: by 2002:a17:902:9a06:b0:13c:86d8:ce0b with SMTP id v6-20020a1709029a0600b0013c86d8ce0bmr5544904plp.51.1631677900907;
        Tue, 14 Sep 2021 20:51:40 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x13sm8602357pfp.133.2021.09.14.20.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 20:51:40 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH 4/5] kernel/watchdog_hld: simplify the detecting of hld watchdog
Date:   Wed, 15 Sep 2021 11:51:02 +0800
Message-Id: <20210915035103.15586-5-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915035103.15586-1-kernelfans@gmail.com>
References: <20210915035103.15586-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By utilizing the new interface model, the stages of probe and enable can
be merged, which saves the pair of perf_event alloc and free.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Wang Qing <wangqing@vivo.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Santosh Sivaraj <santosh@fossix.org>
To: linux-kernel@vger.kernel.org
---
 include/linux/nmi.h   |  8 ++------
 kernel/watchdog.c     | 16 ++++++++++++++--
 kernel/watchdog_hld.c | 21 +++------------------
 3 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 70665fa6e0a9..e41cdf3edba7 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -101,20 +101,16 @@ extern void arch_touch_nmi_watchdog(void);
 extern void hardlockup_detector_perf_stop(void);
 extern void hardlockup_detector_perf_restart(void);
 extern void hardlockup_detector_perf_disable(void);
-extern void hardlockup_detector_perf_enable(void);
+extern int hardlockup_detector_perf_enable(void);
 extern void hardlockup_detector_perf_cleanup(void);
-extern int hardlockup_detector_perf_init(void);
 #else
 static inline void hardlockup_detector_perf_stop(void) { }
 static inline void hardlockup_detector_perf_restart(void) { }
 static inline void hardlockup_detector_perf_disable(void) { }
-static inline void hardlockup_detector_perf_enable(void) { }
+static inline int hardlockup_detector_perf_enable(void) { return -ENODEV; }
 static inline void hardlockup_detector_perf_cleanup(void) { }
 # if !defined(CONFIG_HAVE_NMI_WATCHDOG)
-static inline int hardlockup_detector_perf_init(void) { return -ENODEV; }
 static inline void arch_touch_nmi_watchdog(void) {}
-# else
-static inline int hardlockup_detector_perf_init(void) { return 0; }
 # endif
 #endif
 
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 4ab71943d65f..3f5efbd5961c 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -99,7 +99,17 @@ static watchdog_nmi_status_reporter status_reporter;
  */
 void __weak watchdog_nmi_enable(unsigned int cpu)
 {
-	hardlockup_detector_perf_enable();
+	struct watchdog_nmi_status data;
+	int ret;
+
+	ret = hardlockup_detector_perf_enable();
+	/* No concurrent risk because BP executes this before smp_init() */
+	if (watchdog_enabled & NMI_WATCHDOG_UNDETERMINED
+			&& status_reporter) {
+		data.cpu = cpu;
+		data.status = ret;
+		(*status_reporter)(&data);
+	}
 }
 
 void __weak watchdog_nmi_disable(unsigned int cpu)
@@ -130,7 +140,9 @@ static void watchdog_nmi_report_capability(struct watchdog_nmi_status *data)
  */
 int __weak __init watchdog_nmi_probe(watchdog_nmi_status_reporter notifier)
 {
-	return hardlockup_detector_perf_init();
+	status_reporter = notifier;
+
+	return -EBUSY;
 }
 
 /**
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 6876e796dbf5..2894778fbc6d 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -190,16 +190,17 @@ static int hardlockup_detector_event_create(void)
 /**
  * hardlockup_detector_perf_enable - Enable the local event
  */
-void hardlockup_detector_perf_enable(void)
+int hardlockup_detector_perf_enable(void)
 {
 	if (hardlockup_detector_event_create())
-		return;
+		return -ENODEV;
 
 	/* use original value for check */
 	if (!atomic_fetch_inc(&watchdog_cpus))
 		pr_info("Enabled. Permanently consumes one hw-PMU counter.\n");
 
 	perf_event_enable(this_cpu_read(watchdog_ev));
+	return 0;
 }
 
 /**
@@ -281,19 +282,3 @@ void __init hardlockup_detector_perf_restart(void)
 			perf_event_enable(event);
 	}
 }
-
-/**
- * hardlockup_detector_perf_init - Probe whether NMI event is available at all
- */
-int __init hardlockup_detector_perf_init(void)
-{
-	int ret = hardlockup_detector_event_create();
-
-	if (ret) {
-		pr_info("Perf NMI watchdog permanently disabled\n");
-	} else {
-		perf_event_release_kernel(this_cpu_read(watchdog_ev));
-		this_cpu_write(watchdog_ev, NULL);
-	}
-	return ret;
-}
-- 
2.31.1

