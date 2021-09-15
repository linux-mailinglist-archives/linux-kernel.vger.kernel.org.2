Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B28040BE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbhIODxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbhIODw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:52:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394E1C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 20:51:37 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso1231428pjq.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 20:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ccKCrgnZPpnCd3PTZVybb0VUM9dU3DmZO/E0Y5ltx4=;
        b=i6SxsX6NcrtYqHc3sAIAJw47NhQN+ITBuY1IhrYtDhJnbrBmXzAmly+61++rXLWz6A
         2OavB2fvsy8nzCl73SUsxx9cUuBy4OmArBZFgItvx7Pl/wrVgeeP2U3Gx0CjxCVk0en/
         rVQl/0aP6f0so5AD+lbKMK/bm2woGgFMnIRSEBKs2UhIejXS4lRJTvfglXtLK2MhrSIc
         vJqBeWe0urctAEk8gxEXLp8d2L2LvbrxCIjXkKcrXlqNhYrFNT4JKnaX8v32vkjSh+Ji
         z02exPzAOwfd59okD+aRx2ZejQyqvIlCc4OXNKW4NQ5XpPAYsDbFJe7Y6ZI9jfU2RtKg
         yvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ccKCrgnZPpnCd3PTZVybb0VUM9dU3DmZO/E0Y5ltx4=;
        b=nWP6qlDx7OcR5wJFPsOm295+ncoPL0RZ1zGqvLSXDXgUwCEM03sXSe+yMyk4aeem2J
         HX/Y6ch184XJVJLDheGwoVf/ryccHsJ8JRU3yfxjXotBsaQqMelf3QT97KWuxk4zCw7I
         CtXfwS1SAUKekTkeWn11VFMZY+ee9NACsesGsh91YNm578ln4Arp4c0VltnQok3KV11p
         z35V/iO1u20MTZuo52wfSuWUvEcBumbmCvX8ZK/aLoG3LMbBl9OZ2yUUAQAiJ1uaAfy/
         HujPldoG29xHOY8i1hWvZseCQz66m5JBeqC0SNJgQv/xri0lx5//Inh7zi9ren2aKLGX
         McIg==
X-Gm-Message-State: AOAM533VxNPvO7H+43kx9oXPjorQx0a9m2pIiMJRWcuf79f2fd3NjPXj
        A1IfRNGlbu/TSnGJLuE2Hrlx82cWzg==
X-Google-Smtp-Source: ABdhPJwFCwXHeOB9MbF1VEjQmGMag7cYn0GSQdxwGG5WEw0D4RHS31JcFah/uaxxpwaoUW+h+zLruA==
X-Received: by 2002:a17:90b:4f4d:: with SMTP id pj13mr5945539pjb.47.1631677896597;
        Tue, 14 Sep 2021 20:51:36 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x13sm8602357pfp.133.2021.09.14.20.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 20:51:36 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH 3/5] kernel/watchdog: adapt the watchdog_hld interface for async model
Date:   Wed, 15 Sep 2021 11:51:01 +0800
Message-Id: <20210915035103.15586-4-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915035103.15586-1-kernelfans@gmail.com>
References: <20210915035103.15586-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
yet. E.g. on arm64, PMU is not ready until
device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
with the driver model and cpuhp. Hence it is hard to push this
initialization before smp_init().

But it is easy to take an opposite approach by enabling watchdog_hld to
get the capability of PMU async.

The async model is achieved by introducing an extra parameter notifier
of watchdog_nmi_probe().

Note after this patch, the async model, which is utilized by the next
patch, does not take effect yet.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Julien Thierry <jthierry@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Wang Qing <wangqing@vivo.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Santosh Sivaraj <santosh@fossix.org>
To: linux-kernel@vger.kernel.org
---
 include/linux/nmi.h | 12 +++++++++--
 kernel/watchdog.c   | 49 +++++++++++++++++++++++++++++++++++----------
 2 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 750c7f395ca9..70665fa6e0a9 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -78,8 +78,10 @@ static inline void reset_hung_task_detector(void) { }
  */
 #define NMI_WATCHDOG_ENABLED_BIT   0
 #define SOFT_WATCHDOG_ENABLED_BIT  1
+#define NMI_WATCHDOG_UNDETERMINED_BIT  2
 #define NMI_WATCHDOG_ENABLED      (1 << NMI_WATCHDOG_ENABLED_BIT)
 #define SOFT_WATCHDOG_ENABLED     (1 << SOFT_WATCHDOG_ENABLED_BIT)
+#define NMI_WATCHDOG_UNDETERMINED    (1 << NMI_WATCHDOG_UNDETERMINED_BIT)
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR)
 extern void hardlockup_detector_disable(void);
@@ -116,10 +118,16 @@ static inline int hardlockup_detector_perf_init(void) { return 0; }
 # endif
 #endif
 
+struct watchdog_nmi_status {
+	unsigned int cpu;
+	int status;
+};
+
+typedef void (*watchdog_nmi_status_reporter)(struct watchdog_nmi_status *);
 void watchdog_nmi_stop(void);
 void watchdog_nmi_start(void);
-int watchdog_nmi_probe(void);
-int watchdog_nmi_enable(unsigned int cpu);
+int watchdog_nmi_probe(watchdog_nmi_status_reporter notifier);
+void watchdog_nmi_enable(unsigned int cpu);
 void watchdog_nmi_disable(unsigned int cpu);
 
 /**
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index e2a9e3331416..4ab71943d65f 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -40,7 +40,7 @@ int __read_mostly watchdog_user_enabled = 1;
 int __read_mostly nmi_watchdog_user_enabled = NMI_WATCHDOG_DEFAULT;
 int __read_mostly soft_watchdog_user_enabled = 1;
 int __read_mostly watchdog_thresh = 10;
-static int __read_mostly nmi_watchdog_available;
+static int __read_mostly nmi_watchdog_status;
 
 struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
@@ -85,6 +85,10 @@ __setup("nmi_watchdog=", hardlockup_panic_setup);
 
 #endif /* CONFIG_HARDLOCKUP_DETECTOR */
 
+static void lockup_detector_update_enable(void);
+
+static watchdog_nmi_status_reporter status_reporter;
+
 /*
  * These functions can be overridden if an architecture implements its
  * own hardlockup detector.
@@ -93,10 +97,9 @@ __setup("nmi_watchdog=", hardlockup_panic_setup);
  * softlockup watchdog start and stop. The arch must select the
  * SOFTLOCKUP_DETECTOR Kconfig.
  */
-int __weak watchdog_nmi_enable(unsigned int cpu)
+void __weak watchdog_nmi_enable(unsigned int cpu)
 {
 	hardlockup_detector_perf_enable();
-	return 0;
 }
 
 void __weak watchdog_nmi_disable(unsigned int cpu)
@@ -104,8 +107,28 @@ void __weak watchdog_nmi_disable(unsigned int cpu)
 	hardlockup_detector_perf_disable();
 }
 
-/* Return 0, if a NMI watchdog is available. Error code otherwise */
-int __weak __init watchdog_nmi_probe(void)
+static void watchdog_nmi_report_capability(struct watchdog_nmi_status *data)
+{
+	/* Set status to 1 temporary to block any further access */
+	if (atomic_cmpxchg((atomic_t *)&nmi_watchdog_status, -EBUSY, 1)
+			== -EBUSY) {
+		if (!data->status) {
+			nmi_watchdog_status = 0;
+			lockup_detector_update_enable();
+		} else {
+			nmi_watchdog_status = -ENODEV;
+			/* turn offf watchdog_enabled forever */
+			lockup_detector_update_enable();
+			pr_info("Perf NMI watchdog permanently disabled\n");
+		}
+	}
+}
+
+/*
+ * Return 0, if a NMI watchdog is available. -ENODEV if unavailable. -EBUSY if
+ * undetermined at this stage, and async notifier will update later.
+ */
+int __weak __init watchdog_nmi_probe(watchdog_nmi_status_reporter notifier)
 {
 	return hardlockup_detector_perf_init();
 }
@@ -144,8 +167,12 @@ static void lockup_detector_update_enable(void)
 	watchdog_enabled = 0;
 	if (!watchdog_user_enabled)
 		return;
-	if (nmi_watchdog_available && nmi_watchdog_user_enabled)
-		watchdog_enabled |= NMI_WATCHDOG_ENABLED;
+	if (nmi_watchdog_user_enabled) {
+		if (nmi_watchdog_status == 0)
+			watchdog_enabled |= NMI_WATCHDOG_ENABLED;
+		else if (nmi_watchdog_status == -EBUSY)
+			watchdog_enabled |= NMI_WATCHDOG_UNDETERMINED;
+	}
 	if (soft_watchdog_user_enabled)
 		watchdog_enabled |= SOFT_WATCHDOG_ENABLED;
 }
@@ -467,7 +494,8 @@ static void watchdog_enable(unsigned int cpu)
 	/* Initialize timestamp */
 	update_touch_ts();
 	/* Enable the perf event */
-	if (watchdog_enabled & NMI_WATCHDOG_ENABLED)
+	if (watchdog_enabled &
+			(NMI_WATCHDOG_ENABLED | NMI_WATCHDOG_UNDETERMINED))
 		watchdog_nmi_enable(cpu);
 }
 
@@ -682,7 +710,7 @@ int proc_watchdog(struct ctl_table *table, int write,
 int proc_nmi_watchdog(struct ctl_table *table, int write,
 		      void *buffer, size_t *lenp, loff_t *ppos)
 {
-	if (!nmi_watchdog_available && write)
+	if (!nmi_watchdog_status && write)
 		return -ENOTSUPP;
 	return proc_watchdog_common(NMI_WATCHDOG_ENABLED,
 				    table, write, buffer, lenp, ppos);
@@ -748,7 +776,6 @@ void __init lockup_detector_init(void)
 	cpumask_copy(&watchdog_cpumask,
 		     housekeeping_cpumask(HK_FLAG_TIMER));
 
-	if (!watchdog_nmi_probe())
-		nmi_watchdog_available = true;
+	nmi_watchdog_status = watchdog_nmi_probe(watchdog_nmi_report_capability);
 	lockup_detector_setup();
 }
-- 
2.31.1

