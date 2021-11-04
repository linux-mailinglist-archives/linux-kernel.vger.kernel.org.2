Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA574455CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhKDPAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhKDPAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:00:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABE2C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 07:57:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p18so7565805plf.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZNbjWmnMAuiKGLN12eUIf0g7HXFNqGhSj1Fiav18AY=;
        b=VRnmt4sdQYY55fhcZTIjMaIWfsbX1HEldch29i8QC56MHyS+EPwkX6lq2AbtWhPxDy
         l4kQoKTGo8NMj9demUc6LTTNQDs1pM+Br0bNN+3oK1KXfG6bb17GtT3iQTCqlrHfE2vK
         XJWpHGd8hc4ttrLlMQ77XNr2XIH5wDMhxrHkhrEEoOW07jf1SJt/zI0JrlYNE8PSR9o7
         SqR5OazVRI0yl/HwAZYNTHkSZvDLbotdwZfjlhIXk523+GgiXO839YZU+zly8wrIo1Dv
         LTGZegqKs2kI6HTeHZmXl7UEAhbSXcDjQGAM5nd9xqPxnzu7dvXN06SIFksPgC9fs/D/
         2soQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZNbjWmnMAuiKGLN12eUIf0g7HXFNqGhSj1Fiav18AY=;
        b=OXTcHdtiMoUPzgscfG9qpMtsicFUjz3GpzCK78dLsUH/N1FVSY+QceRbNpDxxKIXay
         47SKQp0yqoAZ/IRW6EmD7DaT3MRJ+otYF+3KDWUwNeFHn1OceYgH0BWzWPCwei2R0uYu
         C29+znWn3qxbsRJatCZEx8vve/oOgtd9b+ijbSCVxEp26VMRHyMT6eXYj0LT/r/rfX8t
         oZdyVmTG+49tom1AYOdQM9gP7J+qdwx1on2/9Pd3nhOPXxyI5ezMvJuVRcUAKijv+PV+
         RJp6j0SlH4kr4UleBh5V9RT7CQKuSJVVol+gG5jf0DvoPkajNNqM7QXjM/GsY/ihLE7b
         VU7w==
X-Gm-Message-State: AOAM532lziIojAhpPsYnFMK5x+aJIZO9hE7ism89hG3v9Xst1mb/3L49
        T2IBICEcKnz0dxfGg11k4zVHPNb4/u4JHw==
X-Google-Smtp-Source: ABdhPJyJ6osYM3p/b2bO1V3HxhsCSNKHoWLcpTEwemHruXMuxBG/4+XGhwz6gZkXguIInmQcrYFHjg==
X-Received: by 2002:a17:902:f691:b0:142:2f7a:308e with SMTP id l17-20020a170902f69100b001422f7a308emr5149737plg.19.1636037853784;
        Thu, 04 Nov 2021 07:57:33 -0700 (PDT)
Received: from localhost.localdomain ([140.82.17.67])
        by smtp.gmail.com with ESMTPSA id t8sm4328530pgk.66.2021.11.04.07.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 07:57:33 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [RFC PATCH 1/4] stop_machine: Move cpu_stop_done into stop_machine.h
Date:   Thu,  4 Nov 2021 14:57:10 +0000
Message-Id: <20211104145713.4419-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211104145713.4419-1-laoar.shao@gmail.com>
References: <20211104145713.4419-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move struct cpu_stop_done into the stop_machine.h, then it can be resued
by the functions outside of stop_maichine.c.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 include/linux/stop_machine.h | 12 ++++++++++++
 kernel/stop_machine.c        | 14 ++------------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 46fb3ebdd16e..b1234cb6ab70 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -20,6 +20,15 @@
 typedef int (*cpu_stop_fn_t)(void *arg);
 
 #ifdef CONFIG_SMP
+/*
+ * Structure to determine completion condition and record errors.  May
+ * be shared by works on different cpus.
+ */
+struct cpu_stop_done {
+	atomic_t		nr_todo;	/* nr left to execute */
+	int			ret;		/* collected return value */
+	struct completion	completion;	/* fired if nr_todo reaches 0 */
+};
 
 struct cpu_stop_work {
 	struct list_head	list;		/* cpu_stopper->works */
@@ -29,6 +38,9 @@ struct cpu_stop_work {
 	struct cpu_stop_done	*done;
 };
 
+void cpu_stop_init_done(struct cpu_stop_done *done, unsigned int nr_todo);
+void cpu_stop_signal_done(struct cpu_stop_done *done);
+
 int stop_one_cpu(unsigned int cpu, cpu_stop_fn_t fn, void *arg);
 int stop_two_cpus(unsigned int cpu1, unsigned int cpu2, cpu_stop_fn_t fn, void *arg);
 bool stop_one_cpu_nowait(unsigned int cpu, cpu_stop_fn_t fn, void *arg,
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cbc30271ea4d..cc94eb7d2c5c 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -23,16 +23,6 @@
 #include <linux/nmi.h>
 #include <linux/sched/wake_q.h>
 
-/*
- * Structure to determine completion condition and record errors.  May
- * be shared by works on different cpus.
- */
-struct cpu_stop_done {
-	atomic_t		nr_todo;	/* nr left to execute */
-	int			ret;		/* collected return value */
-	struct completion	completion;	/* fired if nr_todo reaches 0 */
-};
-
 /* the actual stopper, one per every possible cpu, enabled on online cpus */
 struct cpu_stopper {
 	struct task_struct	*thread;
@@ -67,7 +57,7 @@ void print_stop_info(const char *log_lvl, struct task_struct *task)
 static DEFINE_MUTEX(stop_cpus_mutex);
 static bool stop_cpus_in_progress;
 
-static void cpu_stop_init_done(struct cpu_stop_done *done, unsigned int nr_todo)
+void cpu_stop_init_done(struct cpu_stop_done *done, unsigned int nr_todo)
 {
 	memset(done, 0, sizeof(*done));
 	atomic_set(&done->nr_todo, nr_todo);
@@ -75,7 +65,7 @@ static void cpu_stop_init_done(struct cpu_stop_done *done, unsigned int nr_todo)
 }
 
 /* signal completion unless @done is NULL */
-static void cpu_stop_signal_done(struct cpu_stop_done *done)
+void cpu_stop_signal_done(struct cpu_stop_done *done)
 {
 	if (atomic_dec_and_test(&done->nr_todo))
 		complete(&done->completion);
-- 
2.17.1

