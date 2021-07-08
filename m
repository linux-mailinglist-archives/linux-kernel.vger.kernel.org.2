Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5870E3C1A0F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 21:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhGHTt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 15:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhGHTt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 15:49:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB6BC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 12:46:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso4638887pjp.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 12:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCPnqnwkhUpJbwG5YpNTPwxxCuigLKiLFFGzIuCOfoc=;
        b=OYp2sE6p4qpLvqNozIcc1enqwNjIRLQ6GjZ6Ry5AJXYXEX2Pz8k231oec6nuHSuROi
         iZ+mQrOSaPVQwNmYTFj8iT14KztmF86p4P/47hxfMElAXFaJb866lRHJoMtUkPmXHc0X
         2EAnNV0Aab/VjTjTa9szssjgIJMp+ULMrOguo1oWxVOas1vh1uWu4xemlVtWV5TdA5EG
         C7Bio+IbNNYJZMQnfZehanKHuh0n8zmlAgugAdusmeL4FiPMTVF/bURXdM1xR9ZceA+R
         ZvISHtW1KEf50r2oVPc8zU0dr+hdH64tJyGk40giSBYJhrSItnm9mWxdTjxopSuDYVgz
         gS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCPnqnwkhUpJbwG5YpNTPwxxCuigLKiLFFGzIuCOfoc=;
        b=GjFU3bWKFE68yFhfMIc5aXXJGL9MQv2m7PmUlLwNRDaGaABR/hrPsvLkPehXlqLsui
         40qU3EmUdTVDShgV1aN1oUfhivFFGqDj+hU2/6wL7wcTOtbdQNRqTVUMLnNSzbeS7S33
         Z/aA77syIBCpwE6knKIkwYIAuIYZaj9xKKXNtd5QsUTbSkZ6zQBXfDPaAjdIRnRPKXwb
         Y7jsvcvMoNUDpLJewjg2f9YsmydjHR+aCcepXp3OYA9K9jJwGKZ40yWMcG/c0ArSmPhv
         hsqoFfMRPfiDs6Es0jYrWbg69CCAnYcOj7GnHKOdFfj64r9iqFapkqwLcpXN+elFpUHW
         9R8w==
X-Gm-Message-State: AOAM532l76DI9QX/a6VuxNFLHu0Y1lErCigDkFzYBq3C3NCox+Hf/k8g
        KvvNgavoEcLnpcGJVQgxRmvbYQ==
X-Google-Smtp-Source: ABdhPJywnEOUsJEftw32ORioWYS6TvEHBmogz2hT3CJwyyYCFeXMbq4+sSXZ4hsiVRJIN8qCw8uRcg==
X-Received: by 2002:a17:90a:d241:: with SMTP id o1mr6260162pjw.77.1625773604757;
        Thu, 08 Jul 2021 12:46:44 -0700 (PDT)
Received: from localhost.localdomain (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id v1sm3283176pjg.19.2021.07.08.12.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 12:46:44 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>,
        Jann Horn <jannh@google.com>
Subject: [RFC PATCH 1/3 v0.2] sched: add WF_CURRENT_CPU and externise ttwu
Date:   Thu,  8 Jul 2021 12:46:36 -0700
Message-Id: <20210708194638.128950-2-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210708194638.128950-1-posk@google.com>
References: <20210708194638.128950-1-posk@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add WF_CURRENT_CPU wake flag that advices the scheduler to
move the wakee to the current CPU. This is useful for fast on-CPU
context switching use cases such as UMCG.

In addition, make ttwu external rather than static so that
the flag could be passed to it from outside of sched/core.c.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 kernel/sched/core.c  |  3 +--
 kernel/sched/fair.c  |  4 ++++
 kernel/sched/sched.h | 15 +++++++++------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0c22cd026440..293f5801bf81 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3680,8 +3680,7 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
  * Return: %true if @p->state changes (an actual wakeup was done),
  *	   %false otherwise.
  */
-static int
-try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
+int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 {
 	unsigned long flags;
 	int cpu, success = 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 11d22943753f..16a9c93e6e82 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6836,6 +6836,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	if (wake_flags & WF_TTWU) {
 		record_wakee(p);

+		if ((wake_flags & WF_CURRENT_CPU) &&
+		    cpumask_test_cpu(cpu, p->cpus_ptr))
+			return cpu;
+
 		if (sched_energy_enabled()) {
 			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
 			if (new_cpu >= 0)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9a1c6aeb9165..80de6836f8ae 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2031,13 +2031,14 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 }

 /* Wake flags. The first three directly map to some SD flag value */
-#define WF_EXEC     0x02 /* Wakeup after exec; maps to SD_BALANCE_EXEC */
-#define WF_FORK     0x04 /* Wakeup after fork; maps to SD_BALANCE_FORK */
-#define WF_TTWU     0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */
+#define WF_EXEC         0x02 /* Wakeup after exec; maps to SD_BALANCE_EXEC */
+#define WF_FORK         0x04 /* Wakeup after fork; maps to SD_BALANCE_FORK */
+#define WF_TTWU         0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */

-#define WF_SYNC     0x10 /* Waker goes to sleep after wakeup */
-#define WF_MIGRATED 0x20 /* Internal use, task got migrated */
-#define WF_ON_CPU   0x40 /* Wakee is on_cpu */
+#define WF_SYNC         0x10 /* Waker goes to sleep after wakeup */
+#define WF_MIGRATED     0x20 /* Internal use, task got migrated */
+#define WF_ON_CPU       0x40 /* Wakee is on_cpu */
+#define WF_CURRENT_CPU  0x80 /* Prefer to move the wakee to the current CPU. */

 #ifdef CONFIG_SMP
 static_assert(WF_EXEC == SD_BALANCE_EXEC);
@@ -3037,6 +3038,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);

+extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
--
2.25.1

