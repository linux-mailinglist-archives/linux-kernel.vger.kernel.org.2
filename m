Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CAE3AFFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhFVJJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:09:38 -0400
Received: from mail-m17639.qiye.163.com ([59.111.176.39]:39380 "EHLO
        mail-m17639.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhFVJJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:09:36 -0400
DKIM-Signature: a=rsa-sha256;
        b=K1LCJydGBOM1/mVwE7K2WgXQ54+o+BMF9KS1KnsrrdqtdOlgL8LCz5ys660ah2F2n/89BiODioIryAL+ht+dOss50OhMgcs80RnFYOO+IF66AJkHNUY/OEuRKfOeXue64C8AI+90SqC5eNe6woKYxFwvm55PZwSw5ANxmMCFpz4=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=1YL4UeLMUfQdlEG7iY5oNNlGZhsJUD0rByQVc5RkXhs=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.232])
        by mail-m17639.qiye.163.com (Hmail) with ESMTPA id 115403801A8;
        Tue, 22 Jun 2021 17:07:19 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Wang Qing <wangqing@vivo.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: [PATCH RFC 1/2] hrtimer: support hrtimer suspend when CPU suspend
Date:   Tue, 22 Jun 2021 17:06:46 +0800
Message-Id: <1624352816-26450-2-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624352816-26450-1-git-send-email-wangqing@vivo.com>
References: <1624352816-26450-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUIaT1YaT0pITB0dQ09NSEJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OE06Kyo5Fz8BGD4UDDoUKz0u
        GQ0aCi1VSlVKTUlPSE5JQ0hCTE5KVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISVlXWQgBWUFPT0lINwY+
X-HM-Tid: 0a7a32f956e0d994kuws115403801a8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the CPU suspend, in order to achieve a more power-saving effect,
it is hoped that the CPU sleeps as long as possible, but the timer is an 
important reason for the CPU to wake up. 

In some cases, when the CPU suspend, the timer doesn’t have to work.
Here provides a hrtimer mechanism that supports suspend.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 include/linux/hrtimer.h  | 3 +++
 kernel/time/hrtimer.c    | 4 +++-
 kernel/time/tick-sched.c | 7 +++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index bb5e7b0..bd0a4e6
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -42,6 +42,7 @@ enum hrtimer_mode {
 	HRTIMER_MODE_PINNED	= 0x02,
 	HRTIMER_MODE_SOFT	= 0x04,
 	HRTIMER_MODE_HARD	= 0x08,
+	HRTIMER_MODE_SUSPEND	= 0x08,
 
 	HRTIMER_MODE_ABS_PINNED = HRTIMER_MODE_ABS | HRTIMER_MODE_PINNED,
 	HRTIMER_MODE_REL_PINNED = HRTIMER_MODE_REL | HRTIMER_MODE_PINNED,
@@ -112,6 +113,7 @@ enum hrtimer_restart {
  * @is_soft:	Set if hrtimer will be expired in soft interrupt context.
  * @is_hard:	Set if hrtimer will be expired in hard interrupt context
  *		even on RT.
+ * @is_suspend:	Set if hrtimer will be suspend when CPU suspend
  *
  * The hrtimer structure must be initialized by hrtimer_init()
  */
@@ -124,6 +126,7 @@ struct hrtimer {
 	u8				is_rel;
 	u8				is_soft;
 	u8				is_hard;
+	u8				is_suspend;
 };
 
 /**
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 4a66725..db34c9d
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -513,7 +513,8 @@ static ktime_t __hrtimer_next_event_base(struct hrtimer_cpu_base *cpu_base,
 
 		next = timerqueue_getnext(&base->active);
 		timer = container_of(next, struct hrtimer, node);
-		if (timer == exclude) {
+		if ((timer == exclude) ||
+		(tick_nohz_tick_inidle() && timer->is_suspend)) {
 			/* Get to the next timer in the queue. */
 			next = timerqueue_iterate_next(next);
 			if (!next)
@@ -1422,6 +1423,7 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 	base += hrtimer_clockid_to_base(clock_id);
 	timer->is_soft = softtimer;
 	timer->is_hard = !!(mode & HRTIMER_MODE_HARD);
+	timer->is_suspend = !!(mode & HRTIMER_MODE_SUSPEND);
 	timer->base = &cpu_base->clock_base[base];
 	timerqueue_init(&timer->node);
 }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 828b091..c886758
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -562,6 +562,13 @@ bool tick_nohz_tick_stopped_cpu(int cpu)
 	return ts->tick_stopped;
 }
 
+bool tick_nohz_tick_inidle(void)
+{
+	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+
+	return ts->inidle;
+}
+
 /**
  * tick_nohz_update_jiffies - update jiffies when idle was interrupted
  *
-- 
2.7.4

