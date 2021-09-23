Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4E64160CC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241684AbhIWOMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241707AbhIWOMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:12:07 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C67FC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:10:36 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id m21so6401938pgu.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4uC2eWg7aEhw9OQsJm+DyTckWnK1d1EQQKLFN4MrYQw=;
        b=nZcWLyFX6b4h1Cn/kDTSOUiZYJB63rCYafEeVclmX1skSVyMr5tul8uelIiYPoPQoE
         qAn6MslpW+m0PQ1NmIdZSCRnuLaIKwBzHQMRIGp89JF6vqOgVHWkvQRzWwx5mY3Z687F
         1WAtFXZnSPgLjLUHuWOp8+xgBcfW9/XwQ6HMyoornzPYfjc25ncVI84+fJhrmVfa0CeM
         t2ZUZjFkkp+FJGLgb2rpJ0kGvHQ41li/JhuZSeeAOGrnTM5BxoSqVvT9Z9HasNoP0v4F
         iaZHqiSZmfjr649EPagTN1+sv7nEvyvzdG45Lb+7pampaxFx/wtw4atEMzDywhsNJLYO
         +zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4uC2eWg7aEhw9OQsJm+DyTckWnK1d1EQQKLFN4MrYQw=;
        b=BLPsZjIcZw2u4zhX8V3v4YLR43WlSSJUgsU8/uBXqOYkBYfVPWS3VIi+VrlmSzzWcU
         dRjmqiAE8dg/dLcYFQxHz4fk84tchLnmfnbMAl0dK+FLhR99TY/AQ//57D6MJ2v29H4O
         N3Ji4eNYNXlyxk+dpQBDov3kTLhEH3VaggrcDdSMzpC9vPDvQ/O28pXKJv4+vkA4/XvD
         j/O2zCvpcQyX04xjYyZ8js1+mM2HxIRcdZslHmn9j5bdXYpZ8FPjHGa3Cfqg0LMYji7R
         4+YeDKqvodP9AnEM3W3uy34OVANiUKKVWNztTwFkf8WSkiv0V19RXvGHCXyAKA+Hb+mW
         iALA==
X-Gm-Message-State: AOAM53146cYJGQpXJ6vRxvU19lqWtGoWvYiY9U/DJu5vXS0zLSoMCVPG
        XLoxE29piAuwMmJXJn/KCrvDpCW9dA==
X-Google-Smtp-Source: ABdhPJwmNSh05Gr/CtxmPWIkNtONd+/aOhaL6bSUzPs/gvjn+O8HsGhBu1NC2ey/m1AQaTZn2uSBCg==
X-Received: by 2002:a62:1e43:0:b0:447:cb0b:4c6e with SMTP id e64-20020a621e43000000b00447cb0b4c6emr4535184pfe.1.1632406235819;
        Thu, 23 Sep 2021 07:10:35 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j6sm5800766pfn.107.2021.09.23.07.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 07:10:34 -0700 (PDT)
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
Subject: [PATCHv2 3/4] kernel/watchdog: adapt the watchdog_hld interface for async model
Date:   Thu, 23 Sep 2021 22:09:50 +0800
Message-Id: <20210923140951.35902-4-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923140951.35902-1-kernelfans@gmail.com>
References: <20210923140951.35902-1-kernelfans@gmail.com>
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
 include/linux/nmi.h |  3 +++
 kernel/watchdog.c   | 37 +++++++++++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index b7bcd63c36b4..270d440fe4b7 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -118,6 +118,9 @@ static inline int hardlockup_detector_perf_init(void) { return 0; }
 
 void watchdog_nmi_stop(void);
 void watchdog_nmi_start(void);
+
+extern bool hld_detector_delay_initialized;
+extern struct wait_queue_head hld_detector_wait;
 int watchdog_nmi_probe(void);
 void watchdog_nmi_enable(unsigned int cpu);
 void watchdog_nmi_disable(unsigned int cpu);
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 6e6dd5f0bc3e..bd4ae1839b72 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -103,7 +103,10 @@ void __weak watchdog_nmi_disable(unsigned int cpu)
 	hardlockup_detector_perf_disable();
 }
 
-/* Return 0, if a NMI watchdog is available. Error code otherwise */
+/*
+ * Return 0, if a NMI watchdog is available. -EBUSY if not ready.
+ * Other negative value if not support.
+ */
 int __weak __init watchdog_nmi_probe(void)
 {
 	return hardlockup_detector_perf_init();
@@ -739,15 +742,45 @@ int proc_watchdog_cpumask(struct ctl_table *table, int write,
 }
 #endif /* CONFIG_SYSCTL */
 
+static void lockup_detector_delay_init(struct work_struct *work);
+bool hld_detector_delay_initialized __initdata;
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
+	wait_event(hld_detector_wait, hld_detector_delay_initialized);
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
+	else if (ret == -EBUSY)
+		queue_work_on(smp_processor_id(), system_wq, &detector_work);
+
 	lockup_detector_setup();
 }
-- 
2.31.1

