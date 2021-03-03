Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFE932BA9E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358107AbhCCLiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352581AbhCCD4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 22:56:13 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C9BC0617A9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 19:47:12 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b15so3324635pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 19:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/bMTb1SiUkPIVHGlvKm64n9tcLssKrIhbRkdSh07bVg=;
        b=HYcbSa18RL+IODlkwLwxK2Nx/w7NvSa7P/YanFcI39lYkemSHTYy3vMO5FgmSb2SIL
         zgfLZG5hHuXrID8jsl2Q29P4D7v0jrSDFEXBESlznHmE+fTTvD4nIGF88K/o4ImUshH1
         0FlA2CLVUAw0I9wNld3WKwGPp6A0rlIlNBqeGnQLHdw3phiIfFd9e7wG97iCl9njCrlX
         cjhAHHARLumKjPHSnEnz8YLFFS4ggzOck51RmReOpJn35I69n6LNiI5RuiraHMt+5Gq9
         9T62HAWKyDfRUvjHB3YXXNeqsU+XUUIl8WefPUQNQl9Hp3TXQ2vaVBr4n83gwhG+rJ1W
         jInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bMTb1SiUkPIVHGlvKm64n9tcLssKrIhbRkdSh07bVg=;
        b=jutNUlPGSK/MZaOgMvmX6rrwlhx0FksIRREAEX91lCm7nioFNDAh8coQfUa++JkZX3
         4I8C2sJMYnN7iDhkaP71qvttzySTI3+/qney7Ge3d/OHa0uIL8GBkZ7PJNpUKRrkvm5p
         vV/xvQOccdjXhHiwunchTy+DqO5WWLGSSgfnHf6T86QMRQmTob1ZGrFGnmu7Rpeau/kx
         vzy/irvVqRntXz84TQrKm5InQu9ywpO4dZmHG0+AwFFnHtLeJZDE0VhaXl/JPzRvPFOm
         0Us4kHuToj1dhYLGhyG4AsXyWfYcCl091j6+TWUKZSnajybHAXnXyfZ8tdLDRlbXCqIH
         yGWw==
X-Gm-Message-State: AOAM532WmiN/cDlT+PIhgqg1diR0BD0mAOwe3RUyfrCjzZeqIPbcgFDe
        6UlNGJ+sCj/r+5CwNNG9r7GFzw==
X-Google-Smtp-Source: ABdhPJz6USTu5q0PZOMJs9U0yFcGtpddTZ++a9rSkoDrDCMAih9PwBCkGiAhM+vI3Vv7SaorlGpuRw==
X-Received: by 2002:a17:90a:4589:: with SMTP id v9mr7436766pjg.113.1614743231884;
        Tue, 02 Mar 2021 19:47:11 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id p26sm23029703pfn.127.2021.03.02.19.47.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 19:47:11 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
Subject: [PATCH v2 1/4] psi: Add PSI_CPU_FULL state
Date:   Wed,  3 Mar 2021 11:46:56 +0800
Message-Id: <20210303034659.91735-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210303034659.91735-1-zhouchengming@bytedance.com>
References: <20210303034659.91735-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FULL state doesn't exist for the CPU resource at the system level,
but exist at the cgroup level, means all non-idle tasks in a cgroup are
delayed on the CPU resource which used by others outside of the cgroup
or throttled by the cgroup cpu.max configuration.

Co-developed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/psi_types.h |  3 ++-
 kernel/sched/psi.c        | 14 +++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index b95f3211566a..0a23300d49af 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -50,9 +50,10 @@ enum psi_states {
 	PSI_MEM_SOME,
 	PSI_MEM_FULL,
 	PSI_CPU_SOME,
+	PSI_CPU_FULL,
 	/* Only per-CPU, to weigh the CPU in the global average: */
 	PSI_NONIDLE,
-	NR_PSI_STATES = 6,
+	NR_PSI_STATES = 7,
 };
 
 enum psi_aggregators {
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 967732c0766c..2293c45d289d 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -34,7 +34,10 @@
  * delayed on that resource such that nobody is advancing and the CPU
  * goes idle. This leaves both workload and CPU unproductive.
  *
- * (Naturally, the FULL state doesn't exist for the CPU resource.)
+ * Naturally, the FULL state doesn't exist for the CPU resource at the
+ * system level, but exist at the cgroup level, means all non-idle tasks
+ * in a cgroup are delayed on the CPU resource which used by others outside
+ * of the cgroup or throttled by the cgroup cpu.max configuration.
  *
  *	SOME = nr_delayed_tasks != 0
  *	FULL = nr_delayed_tasks != 0 && nr_running_tasks == 0
@@ -225,6 +228,8 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 		return tasks[NR_MEMSTALL] && !tasks[NR_RUNNING];
 	case PSI_CPU_SOME:
 		return tasks[NR_RUNNING] > tasks[NR_ONCPU];
+	case PSI_CPU_FULL:
+		return tasks[NR_RUNNING] && !tasks[NR_ONCPU];
 	case PSI_NONIDLE:
 		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
 			tasks[NR_RUNNING];
@@ -678,8 +683,11 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
 		}
 	}
 
-	if (groupc->state_mask & (1 << PSI_CPU_SOME))
+	if (groupc->state_mask & (1 << PSI_CPU_SOME)) {
 		groupc->times[PSI_CPU_SOME] += delta;
+		if (groupc->state_mask & (1 << PSI_CPU_FULL))
+			groupc->times[PSI_CPU_FULL] += delta;
+	}
 
 	if (groupc->state_mask & (1 << PSI_NONIDLE))
 		groupc->times[PSI_NONIDLE] += delta;
@@ -1018,7 +1026,7 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 		group->avg_next_update = update_averages(group, now);
 	mutex_unlock(&group->avgs_lock);
 
-	for (full = 0; full < 2 - (res == PSI_CPU); full++) {
+	for (full = 0; full < 2; full++) {
 		unsigned long avg[3];
 		u64 total;
 		int w;
-- 
2.11.0

