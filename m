Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CB039CEBA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 13:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhFFL64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 07:58:56 -0400
Received: from m12-13.163.com ([220.181.12.13]:45461 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhFFL6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 07:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=pesI/MGsRpDnh54JhJ
        c2VQiwfW2DknO904cI7gJytfQ=; b=E9eacGtVpkIYJPdGqUO8zS4MN6eNjYsql+
        Zbc493cY+XPYhSCOc+Rb18mykRBo37Kw28nTtIP7sjR9VinlFUQrAzUNthWd6LD/
        MJ37uhT8wo8EXs0VjXwgL3iq7vkdTG6he9W5sY2oPbYsNXZGART9CFMpyEKfHEYC
        bf08Wdwmg=
Received: from localhost.localdomain (unknown [117.139.248.43])
        by smtp9 (Coremail) with SMTP id DcCowABHTHyZt7xg8kJqEw--.30289S2;
        Sun, 06 Jun 2021 19:55:06 +0800 (CST)
From:   Hailong Liu <liuhailongg6@163.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Turner <pjt@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org (open list),
        Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [PATCH] sysctl: sched: move extern sysctl declarations to sched.h
Date:   Sun,  6 Jun 2021 19:54:51 +0800
Message-Id: <20210606115451.26745-1-liuhailongg6@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DcCowABHTHyZt7xg8kJqEw--.30289S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFWDXrykAFyfKw1xGry8Xwb_yoW5Aw43pF
        98Zr1UXr4UK340qr93Cw4rJrZ3Jr43Ar92yFsrXr4xAr1YgrWSqr1xKFWfGrW2krWxCFWS
        vF12g34akw4jyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jXJ5rUUUUU=
X-Originating-IP: [117.139.248.43]
X-CM-SenderInfo: xolxxtxlor0wjjw6il2tof0z/1tbi7xupYFr79sgv-wAAsy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hailong Liu <liu.hailong6@zte.com.cn>

Since commit '8a99b6833c88(sched: Move SCHED_DEBUG sysctl to debugfs)',
SCHED_DEBUG sysctls are moved to debugfs, so these extern sysctls in
include/linux/sched/sysctl.h are no longer needed for sysctl.c, even
some are no longer needed.

So move those extern sysctls that needed by kernel/sched/debug.c to
kernel/sched/sched.h, and remove others that are no longer needed.

Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
---
 include/linux/sched/sysctl.h | 18 ------------------
 kernel/sched/sched.h         | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index db2c0f34aaaf..304f431178fd 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -28,30 +28,12 @@ enum { sysctl_hung_task_timeout_secs = 0 };
 
 extern unsigned int sysctl_sched_child_runs_first;
 
-extern unsigned int sysctl_sched_latency;
-extern unsigned int sysctl_sched_min_granularity;
-extern unsigned int sysctl_sched_wakeup_granularity;
-
 enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_NONE,
 	SCHED_TUNABLESCALING_LOG,
 	SCHED_TUNABLESCALING_LINEAR,
 	SCHED_TUNABLESCALING_END,
 };
-extern unsigned int sysctl_sched_tunable_scaling;
-
-extern unsigned int sysctl_numa_balancing_scan_delay;
-extern unsigned int sysctl_numa_balancing_scan_period_min;
-extern unsigned int sysctl_numa_balancing_scan_period_max;
-extern unsigned int sysctl_numa_balancing_scan_size;
-
-#ifdef CONFIG_SCHED_DEBUG
-extern __read_mostly unsigned int sysctl_sched_migration_cost;
-extern __read_mostly unsigned int sysctl_sched_nr_migrate;
-
-extern int sysctl_resched_latency_warn_ms;
-extern int sysctl_resched_latency_warn_once;
-#endif
 
 /*
  *  control realtime throttling:
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a189bec13729..d79d4c8d01fc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2107,6 +2107,21 @@ extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
+#ifdef CONFIG_SCHED_DEBUG
+extern unsigned int sysctl_sched_latency;
+extern unsigned int sysctl_sched_min_granularity;
+extern unsigned int sysctl_sched_wakeup_granularity;
+extern int sysctl_resched_latency_warn_ms;
+extern int sysctl_resched_latency_warn_once;
+
+extern unsigned int sysctl_sched_tunable_scaling;
+
+extern unsigned int sysctl_numa_balancing_scan_delay;
+extern unsigned int sysctl_numa_balancing_scan_period_min;
+extern unsigned int sysctl_numa_balancing_scan_period_max;
+extern unsigned int sysctl_numa_balancing_scan_size;
+#endif
+
 #ifdef CONFIG_SCHED_HRTICK
 
 /*
-- 
2.17.1


