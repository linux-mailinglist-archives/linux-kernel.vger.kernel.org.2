Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E30144D370
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhKKIyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhKKIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:54:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304BEC061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:31 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so8337460yba.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b3N2HaP/XHgcVD8hyfejkqyzz5UvuglgH3sMPO8e7eg=;
        b=GSXaEqxiu7IA83z1DMhMBbknEwE53w1myYqUj862u46sxdWmE4QHfqPjMZ20OKugSz
         0qO3e7bp8I1CYTJkb6X8j/Yl3orDypQqtqF+pUttveHijsrOLpah02BXlKBvegeTrnsO
         oH6WuUdu7+RT/RJvOMuoi2X98yIyzBQB6UKITyOGn9rv0YWQjm2PEZiHQV0VHk5DUXMU
         O6rIyb0370xy+3Bg1HFINX6WCJbb3WnWNMK6W8Jn+FU5GA2FBG9VY6CUfUpBcXZCLrPu
         O+MduhlGVFHhP7VEL62jT5Ip9X8CYeI93blHX+37Kla5uiUE3V3ZguoG4uAzyyyZL2K7
         HfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b3N2HaP/XHgcVD8hyfejkqyzz5UvuglgH3sMPO8e7eg=;
        b=sOYErqSBVLRcF+ywXyI1hlHWSh6AYIvtWq55y2zmnzGg7SZVzu56xlb7w9o0Lx6Nec
         g2ygb6YbLR4jW+/hfy7eMhKz/wsaWJM9ToQtbY+ZsZ3s0EgACPN7jVnrOVcLC/1labyF
         6wH8ssFkKz1kMHoaX4FfDFQlCvlKd1hNNsqEBQMgMe3SaNnt9i8G8Jv9L4khrWmTO2p5
         LjOOt9Gkf1DmrBA7/Vd28zpLJ0fMrJhF4ZqjJVWTmnNGOTvgLDBMJrQGMx4TkWcYbKjb
         8PxVGgqc3ByGpRIaH3Kvld6zVV7Ap45bYhjUQ/LQ+I6feHA1HuOlsMZwzzcT5yLwyiHR
         ZqIg==
X-Gm-Message-State: AOAM532dBpG/6uHt0A580hcUIIgA9HlsbsRrVCT5TaCwoleP0mEqc0gU
        We/zL+fFmzOXXyO83sRx+kzU8KFucSpjlyndI5ESclZc6pB/TeazNLEnMtcf0nLzz4kGgm8iwfb
        K4x2tArpfWXEzVDU/h5S/sp0kMCVXOaXT7kZl9Jy5aVzZ/oHKtNTu0RySQI1MhcNeMbS87M6Z
X-Google-Smtp-Source: ABdhPJyHNDWyde3TgkAlaHjsSXvSMHAaKoQ3NJP5jMAiNR/c+a7UH+pvSaY64eiK6s5007dqc4mYRM8MeNwk
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:cdfe:134b:9d27:6cbf])
 (user=eranian job=sendgmr) by 2002:a25:3108:: with SMTP id
 x8mr6486510ybx.497.1636620690299; Thu, 11 Nov 2021 00:51:30 -0800 (PST)
Date:   Thu, 11 Nov 2021 00:44:09 -0800
In-Reply-To: <20211111084415.663951-1-eranian@google.com>
Message-Id: <20211111084415.663951-8-eranian@google.com>
Mime-Version: 1.0
References: <20211111084415.663951-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 07/13] perf/x86/amd: make Zen3 branch sampling opt-in
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a kernel config option to make support
for AMD Zen3 Branch Sampling (BRS) an opt-in compile
time option.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/Kconfig      |  8 +++++++
 arch/x86/events/amd/Makefile |  3 ++-
 arch/x86/events/perf_event.h | 44 ++++++++++++++++++++++++++++--------
 3 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
index d6cdfe631674..1dc002ef66da 100644
--- a/arch/x86/events/Kconfig
+++ b/arch/x86/events/Kconfig
@@ -44,4 +44,12 @@ config PERF_EVENTS_AMD_UNCORE
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called 'amd-uncore'.
+
+config PERF_EVENTS_AMD_BRS
+	depends on PERF_EVENTS && CPU_SUP_AMD
+	tristate "AMD Zen3 Branch Sampling support"
+	help
+	  Enable AMD Zen3 branch sampling support (BRS) which samples up to
+	  16 consecutive taken branches in registers.
+
 endmenu
diff --git a/arch/x86/events/amd/Makefile b/arch/x86/events/amd/Makefile
index cf323ffab5cd..b9f5d4610256 100644
--- a/arch/x86/events/amd/Makefile
+++ b/arch/x86/events/amd/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CPU_SUP_AMD)		+= core.o brs.o
+obj-$(CONFIG_CPU_SUP_AMD)		+= core.o
+obj-$(CONFIG_PERF_EVENTS_AMD_BRS)	+= brs.o
 obj-$(CONFIG_PERF_EVENTS_AMD_POWER)	+= power.o
 obj-$(CONFIG_X86_LOCAL_APIC)		+= ibs.o
 obj-$(CONFIG_PERF_EVENTS_AMD_UNCORE)	+= amd-uncore.o
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index f0026266a9d7..f8dc8faed584 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1213,6 +1213,8 @@ static inline bool fixed_counter_disabled(int i, struct pmu *pmu)
 #ifdef CONFIG_CPU_SUP_AMD
 
 int amd_pmu_init(void);
+
+#ifdef CONFIG_PERF_EVENTS_AMD_BRS
 int amd_brs_init(void);
 void amd_brs_disable(void);
 void amd_brs_enable(void);
@@ -1245,24 +1247,46 @@ static inline void amd_pmu_brs_del(struct perf_event *event)
 
 void amd_pmu_brs_sched_task(struct perf_event_context *ctx, bool sched_in);
 
-/*
- * check if BRS is activated on the CPU
- * active defined as it has non-zero users and DBG_EXT_CFG.BRSEN=1
- */
-static inline bool amd_brs_active(void)
+static inline s64 amd_brs_adjust_period(s64 period)
 {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	if (period > x86_pmu.lbr_nr)
+		return period - x86_pmu.lbr_nr;
 
-	return cpuc->brs_active;
+	return period;
+}
+#else
+static inline int amd_brs_init(void)
+{
+	return 0;
+}
+static inline void amd_brs_disable(void) {}
+static inline void amd_brs_enable(void) {}
+static inline void amd_brs_drain(void) {}
+static inline void amd_brs_lopwr_init(void) {}
+static inline void amd_brs_disable_all(void) {}
+static inline int amd_brs_setup_filter(struct perf_event *event)
+{
+	return 0;
 }
+static inline void amd_brs_reset(void) {}
 
-static inline s64 amd_brs_adjust_period(s64 period)
+static inline void amd_pmu_brs_add(struct perf_event *event)
 {
-	if (period > x86_pmu.lbr_nr)
-		return period - x86_pmu.lbr_nr;
+}
 
+static inline void amd_pmu_brs_del(struct perf_event *event)
+{
+}
+
+static inline void amd_pmu_brs_sched_task(struct perf_event_context *ctx, bool sched_in)
+{
+}
+
+static inline s64 amd_brs_adjust_period(s64 period)
+{
 	return period;
 }
+#endif
 
 #else /* CONFIG_CPU_SUP_AMD */
 
-- 
2.34.0.rc0.344.g81b53c2807-goog

