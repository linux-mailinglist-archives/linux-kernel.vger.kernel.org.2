Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EBD42D095
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhJNCo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhJNCo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:44:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31283C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:42:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so5872398pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MCXL1wxbIIPtVPUvxM8dtdoMd+TQ/MoVrnyuxcC09GE=;
        b=FaGvFeFK7B5vD2fuaQKs3c9JWuSrhIAaB/JnMeXsYhkiT3ielLvLFlqHV+2RivA8YZ
         Pkqgcnp6ps4TBY65YZeCYsGK59FDt7jmNGUAmXNHP9BYq2hz3ExFYblx6xeLK1wxLaIv
         5S+PgFwx/WOmjCW7zzpyFm3PnlNm9TnlgNdhetCwLYtw31prKPIptI9Ppdkf3WPvzt8N
         zoUY4vqp5YH9owOnAKALXjwMgSAJhHIYU+RWmeJuvgoAgwAtStFlB3Hk1Ohq3Uiid5Vo
         GOR1TJhEMoAHsUUVWhTkrPzxQsKVck56FddkSju8OIazy4OlIU2iz+MtWRIN5TibltzR
         vefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MCXL1wxbIIPtVPUvxM8dtdoMd+TQ/MoVrnyuxcC09GE=;
        b=s6/9OjoL01duAG3sJEDUQcAHixeYizyQ6CiDcrFyWiT02rvstw01ba8imwl1VN3dTI
         pW8mFVnh1hWM7cOCrq8y7PI2hMwdhIc9sMxo0Fm0FdT2WULhvdXx4tJYUFwjnet9x2OW
         n7qhrKzZ1Vs+ZtCb09PdMk+XniMOtvG+isha+xACOQUSefKXN9svaxHeXWOcRategcuQ
         TkHH1jwBM8+VgLnC++mwwoRlWq+QLGR4WXlN2NM9LT+oWTrSTSsHne0Jjxr4X6nlnz5F
         qqN09D3aBOZDkXMheU+TJu5xPxg0yraK/AqReyrbELahRQFsQotGs//7erubDf+eLFiL
         ekOQ==
X-Gm-Message-State: AOAM533If8IMt/FmtyGgXy0kolQfehhPetGRg7iglELIhSMiFf3d/0S5
        h9IrjBW48TKnaL5ybwvgaWowI3qD7g==
X-Google-Smtp-Source: ABdhPJzQThXgZOxXmw2uYnollO+CHFsrzcj2LwY1rvFejhCwsA8wZZvMcg1/bdTITlfgBpi5ypRaVQ==
X-Received: by 2002:a17:902:d501:b0:13f:1b44:baa2 with SMTP id b1-20020a170902d50100b0013f1b44baa2mr2709101plg.56.1634179343578;
        Wed, 13 Oct 2021 19:42:23 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m28sm818403pgl.9.2021.10.13.19.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 19:42:23 -0700 (PDT)
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
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv3 3/4] kernel/watchdog: Adapt the watchdog_hld interface for async model
Date:   Thu, 14 Oct 2021 10:41:54 +0800
Message-Id: <20211014024155.15253-4-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211014024155.15253-1-kernelfans@gmail.com>
References: <20211014024155.15253-1-kernelfans@gmail.com>
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

The async model is achieved by expanding watchdog_nmi_probe() with
-EBUSY, and a re-initializing work_struct which waits on a wait_queue_head.

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
Cc: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Wang Qing <wangqing@vivo.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Santosh Sivaraj <santosh@fossix.org>
Cc: linux-arm-kernel@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 include/linux/nmi.h |  9 +++++++
 kernel/watchdog.c   | 57 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index b7bcd63c36b4..9def85c00bd8 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -118,6 +118,15 @@ static inline int hardlockup_detector_perf_init(void) { return 0; }
 
 void watchdog_nmi_stop(void);
 void watchdog_nmi_start(void);
+
+enum hld_detector_state {
+	DELAY_INIT_NOP,
+	DELAY_INIT_WAIT,
+	DELAY_INIT_READY
+};
+
+extern enum hld_detector_state detector_delay_init_state;
+extern struct wait_queue_head hld_detector_wait;
 int watchdog_nmi_probe(void);
 void watchdog_nmi_enable(unsigned int cpu);
 void watchdog_nmi_disable(unsigned int cpu);
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 6e6dd5f0bc3e..2f267d21a7a1 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -103,7 +103,11 @@ void __weak watchdog_nmi_disable(unsigned int cpu)
 	hardlockup_detector_perf_disable();
 }
 
-/* Return 0, if a NMI watchdog is available. Error code otherwise */
+/*
+ * Arch specific API. Return 0, if a NMI watchdog is available. -EBUSY if not
+ * ready, and arch code should wake up hld_detector_wait when ready. Other
+ * negative value if not support.
+ */
 int __weak __init watchdog_nmi_probe(void)
 {
 	return hardlockup_detector_perf_init();
@@ -739,15 +743,64 @@ int proc_watchdog_cpumask(struct ctl_table *table, int write,
 }
 #endif /* CONFIG_SYSCTL */
 
+static void lockup_detector_delay_init(struct work_struct *work);
+enum hld_detector_state detector_delay_init_state __initdata;
+
+struct wait_queue_head hld_detector_wait __initdata =
+		__WAIT_QUEUE_HEAD_INITIALIZER(hld_detector_wait);
+
+static struct work_struct detector_work __initdata =
+		__WORK_INITIALIZER(detector_work, lockup_detector_delay_init);
+
+static void __init lockup_detector_delay_init(struct work_struct *work)
+{
+	int ret;
+
+	wait_event(hld_detector_wait,
+			detector_delay_init_state == DELAY_INIT_READY);
+	ret = watchdog_nmi_probe();
+	if (!ret) {
+		nmi_watchdog_available = true;
+		lockup_detector_setup();
+	} else {
+		WARN_ON(ret == -EBUSY);
+		pr_info("Perf NMI watchdog permanently disabled\n");
+	}
+}
+
+/* Ensure the check is called after the initialization of PMU driver */
+static int __init lockup_detector_check(void)
+{
+	if (detector_delay_init_state < DELAY_INIT_WAIT)
+		return 0;
+
+	if (WARN_ON(detector_delay_init_state == DELAY_INIT_WAIT)) {
+		detector_delay_init_state = DELAY_INIT_READY;
+		wake_up(&hld_detector_wait);
+	}
+	flush_work(&detector_work);
+	return 0;
+}
+late_initcall_sync(lockup_detector_check);
+
+
 void __init lockup_detector_init(void)
 {
+	int ret;
+
 	if (tick_nohz_full_enabled())
 		pr_info("Disabling watchdog on nohz_full cores by default\n");
 
 	cpumask_copy(&watchdog_cpumask,
 		     housekeeping_cpumask(HK_FLAG_TIMER));
 
-	if (!watchdog_nmi_probe())
+	ret = watchdog_nmi_probe();
+	if (!ret)
 		nmi_watchdog_available = true;
+	else if (ret == -EBUSY) {
+		detector_delay_init_state = DELAY_INIT_WAIT;
+		queue_work_on(smp_processor_id(), system_wq, &detector_work);
+	}
+
 	lockup_detector_setup();
 }
-- 
2.31.1

