Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092C030B4C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 02:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhBBBf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 20:35:56 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:36965 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhBBBfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:35:54 -0500
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 62B2A100003;
        Tue,  2 Feb 2021 01:35:07 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] alarmtimer: update kerneldoc
Date:   Tue,  2 Feb 2021 02:34:57 +0100
Message-Id: <20210202013457.3482388-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update kerneldoc comments to reflect the actual arguments and return values
of the documented functions.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 kernel/time/alarmtimer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index f4ace1bf8382..98d7a15e8cf6 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -527,8 +527,11 @@ static enum alarmtimer_type clock2alarm(clockid_t clockid)
 /**
  * alarm_handle_timer - Callback for posix timers
  * @alarm: alarm that fired
+ * @now: time at the timer expiration
  *
  * Posix timer callback for expired alarm timers.
+ *
+ * Return: whether the timer is to be restarted
  */
 static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm,
 							ktime_t now)
@@ -715,8 +718,11 @@ static int alarm_timer_create(struct k_itimer *new_timer)
 /**
  * alarmtimer_nsleep_wakeup - Wakeup function for alarm_timer_nsleep
  * @alarm: ptr to alarm that fired
+ * @now: time at the timer expiration
  *
  * Wakes up the task that set the alarmtimer
+ *
+ * Return: ALARMTIMER_NORESTART
  */
 static enum alarmtimer_restart alarmtimer_nsleep_wakeup(struct alarm *alarm,
 								ktime_t now)
@@ -733,6 +739,7 @@ static enum alarmtimer_restart alarmtimer_nsleep_wakeup(struct alarm *alarm,
  * alarmtimer_do_nsleep - Internal alarmtimer nsleep implementation
  * @alarm: ptr to alarmtimer
  * @absexp: absolute expiration time
+ * @type: alarm type (BOOTTIME/REALTIME).
  *
  * Sets the alarm timer and sleeps until it is fired or interrupted.
  */
@@ -806,7 +813,6 @@ static long __sched alarm_timer_nsleep_restart(struct restart_block *restart)
  * @which_clock: clockid
  * @flags: determins abstime or relative
  * @tsreq: requested sleep time (abs or rel)
- * @rmtp: remaining sleep time saved
  *
  * Handles clock_nanosleep calls against _ALARM clockids
  */
-- 
2.29.2

