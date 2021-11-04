Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184AD4455D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhKDPAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhKDPAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:00:14 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF045C06127A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 07:57:36 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 127so6122313pfu.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vX4yRlqINS3cJMioy/zbkZYtGwo1ojr7gZmj2zjRf/g=;
        b=BqrM61MUvrWQOLHvp+UR5ZnC+iO2ubyKGmk+NEmdSNqfYpRy4UYi0Cj+79nXJA8HNp
         E+1nBfrLq1M3yppcC4hnVSzHmAt1vZbO26o1/eR9WOvGrQLR9NXfbf/zi1x/rO1oIxJh
         fkZPcA7POXj9NhD1Tqc298sgY3WsI+u5cGrpXKaEPl8ng82ruyA6pD/C2x8KZhOv39hx
         YzIXcEcNtOK8V3yrMHqhPp9ir5D6RX/XeXHbLAtZTTrS7IQ37X8h7JDIwBhThJMQpt0N
         jC/o0BOoN1CMGT7Q3DEZRn/Vj7UIOSmn1Z82hY/ZE02vOzwEdWVkNXdGvxc8r0am3rFc
         H1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vX4yRlqINS3cJMioy/zbkZYtGwo1ojr7gZmj2zjRf/g=;
        b=jvPrQsLQUN8kbHItakuV8wuA32NUnjBbj+/5VPGFmSmZXBpas4VqTL8uI3OgGzxShu
         8D5pf62NeA9R4l0hN4dVEJ122Xo+ArPwTi4hPoNCUJ8zqs6SgXAa4lA91U/fXN+WoQsU
         J1rLrN/HcVYe6ZpWQ5bV7ai4HHYN8YQV0JNzPIpFBdFEcLB02nkYwGLRXiIdvqKq9VX4
         4aGgReNpbsb7jJCIjTyVl3enJZZUpQKZG9VXwyTlEgKLi1DxQPSbQvR9m2F7Yl1O0sYc
         2LXZQBDiOyeUU8M4oxWjkp3lpcivzPiMbs8cE0351mpkuV4whYFWXpt3mQTGQKGX5wva
         6TWw==
X-Gm-Message-State: AOAM531okMKi8Ish2HuBfEp2O79j0pTUtj9eYIslugpIGV94wkWi1qEV
        zxrwBmjzPOk8/AEJcPXWIIA=
X-Google-Smtp-Source: ABdhPJwWOE5Dc9iuie3hKLXSLwaXO/LGXWpNq/doECauuWXnpdo+AW7Yn6+Bfh+ATbjWUxVaiwL97Q==
X-Received: by 2002:a63:ef02:: with SMTP id u2mr9832332pgh.363.1636037856426;
        Thu, 04 Nov 2021 07:57:36 -0700 (PDT)
Received: from localhost.localdomain ([140.82.17.67])
        by smtp.gmail.com with ESMTPSA id t8sm4328530pgk.66.2021.11.04.07.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 07:57:36 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [RFC PATCH 4/4] sched/core: Do numa balance in cfs_migration
Date:   Thu,  4 Nov 2021 14:57:13 +0000
Message-Id: <20211104145713.4419-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211104145713.4419-1-laoar.shao@gmail.com>
References: <20211104145713.4419-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to active load balance, the numa balance work is also applied to
cfs tasks only and it should't preempt other FIFO tasks. We'd better assign
cfs_migration to the numa balance as well.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c  |  2 +-
 kernel/sched/fair.c  | 13 +++++++++++++
 kernel/sched/sched.h |  2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9cb81ef8acc8..4a37b06715f4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8724,7 +8724,7 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
 	/* TODO: This is not properly updating schedstats */
 
 	trace_sched_move_numa(p, curr_cpu, target_cpu);
-	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
+	return wakeup_cfs_migrater(curr_cpu, migration_cpu_stop, &arg);
 }
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 932f63baeb82..b7a155e05c98 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11960,6 +11960,19 @@ static void wakeup_cfs_migrater_nowait(unsigned int cpu, cpu_stop_fn_t fn, void
 	cfs_migration_queue_work(cpu, work_buf);
 }
 
+bool wakeup_cfs_migrater(unsigned int cpu, cpu_stop_fn_t fn, void *arg)
+{
+	struct cpu_stop_done done;
+	struct cpu_stop_work work = { .fn = fn, .arg = arg, .done = &done, .caller = _RET_IP_ };
+
+	cpu_stop_init_done(&done, 1);
+	cfs_migration_queue_work(cpu, &work);
+	cond_resched();
+	wait_for_completion(&done.completion);
+
+	return done.ret;
+}
+
 static int cfs_migration_should_run(unsigned int cpu)
 {
 	struct cfs_migrater *migrater = &per_cpu(cfs_migrater, cpu);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a00fc7057d97..7b242c18a6d8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3055,6 +3055,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 
 	return true;
 }
+
+bool wakeup_cfs_migrater(unsigned int cpu, cpu_stop_fn_t fn, void *arg);
 #endif
 
 extern void swake_up_all_locked(struct swait_queue_head *q);
-- 
2.17.1

