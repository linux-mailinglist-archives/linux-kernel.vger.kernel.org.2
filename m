Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B95312235
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 08:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBGHYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 02:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGHYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 02:24:52 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C19C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 23:24:12 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id a16so6175915plh.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 23:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uEuMnedgqTej0QSJxh1iRlfrELjx7TlOWPlJXqTZiVI=;
        b=N+mz0cQ8fywwZ4JwGLIh9GkLKQm73Ux9OLSIHoG516+IvqtLJ6djwdqw+jh6HMb+zo
         Lm+Ssu/yjzDswdpYnYbzqVq9rUUd6rylZ86Nu9l4R+qnQjopc2WDRGj/C+OLPDD9UqR4
         PSorGJ2AnXKjXzBW+LjHiGKFL5eaF7WN4XElPAGZ2bmSnqOSy1JsUW7LduYPnSstDJ9M
         l4/17+icevE2SGWiaIXxh3X3JHGnjf4BzJpkqjsmvJbF6ahAMdTa5DhLp6KLd/EphSS0
         SQFJnZgaGutYQhpjsx9pn2tajy5joj7XpIS152JXR+/50n2698x2fSwRzwId2VY/jfzs
         gEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uEuMnedgqTej0QSJxh1iRlfrELjx7TlOWPlJXqTZiVI=;
        b=ZSJ1qz3t/DlUsmjAWahOrE6TwYGZogEvhRLU7LLTgAhzRIRbINvX9gJ7CIjjOwAHHt
         wfd3vpQccqLYshpLp07ut3hbJLuobzG/ohgykhE0ilqnixgxhfZUUd7F49fl0eXdNqHC
         lt/rE1WVGwcC0D33GUkD6/Fs6r3zXAeMtMEdeNcYRAA/8HeantIDqksTl/I2ttPN1LMf
         jbJBirEluaYZr18HFlVxyv/p3B+M/Y2l0RS0xZ+56CnwH+C+5rHyLNpQ4Lz+hb5shH4f
         BJGfJ0h04g1iyYtU5lTjxjGivp4k8P2uO2Q/Rz4XbAfdTSFCcQxmpaiAnsy0+aGguCdj
         lc8A==
X-Gm-Message-State: AOAM531xs+OXGlBSaRPVr03SKqegqCL7rFaIlFhJT2fDSiehpQ3sHkcU
        qJ2p1wFBl2jLhPz/khoomFIPAw==
X-Google-Smtp-Source: ABdhPJymY9NyOaOwedd5eS1ObMnnw6bn/Q/0vt754rezBLqoLIJMiQWhLcyjDF+RTrX9cKrLJ+QauQ==
X-Received: by 2002:a17:90a:590c:: with SMTP id k12mr11404812pji.233.1612682651575;
        Sat, 06 Feb 2021 23:24:11 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id f3sm13659869pfe.25.2021.02.06.23.24.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2021 23:24:10 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
Subject: [PATCH] psi: Add PSI_CPU_FULL state
Date:   Sun,  7 Feb 2021 15:24:02 +0800
Message-Id: <20210207072402.67532-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FULL state doesn't exist for the CPU resource at the system level,
but exist at the cgroup level, means all non-idle tasks in a cgroup are
delayed on the CPU resource which used by others outside of the cgroup.

Co-developed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
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
index 39d758a15a57..c572ad529d87 100644
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
+ * of the cgroup.
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

