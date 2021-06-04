Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F7439B7F1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhFDLdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:33:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230150AbhFDLdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:33:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19E5061432;
        Fri,  4 Jun 2021 11:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622806328;
        bh=Dz27t/9kX5xl2Q7UkS0YP0Ly+RNmkd2lVoIIiDuarCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i1gqa7PAQqM/GeB8oOJGQS3I5j+4KM9VqjguMj+6TGXV8+J9WlpKOqYhPtv11pcno
         JLUwz24nBVQQnJMjEU0ZtAsEgJvU0rx87OavbXao/EWoIXDE3ORExzGaFYE7KXAYRL
         dkdzZrDGO2M1CumkQETc9TJ8lrHcZz9g+96TCyvwKIznuNOBpGqMrpsEzL1rDf1UVD
         LvYxJ3ig+A2KBgaXRgFKPFBzaUw0qrFldUi+ArTlO+7mHSjw6wO3jt9K30/JcrQ08Y
         wmw4m/ebYVYhlY43vac5sLypc95NJ1ri0z1iPY7GplfCiWL4Y6yFMPRlJE3WrRfryu
         X17SN9dOYg6sQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 2/6] posix-cpu-timers: Don't start process wide cputime counter if timer is disabled
Date:   Fri,  4 Jun 2021 13:31:55 +0200
Message-Id: <20210604113159.26177-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604113159.26177-1-frederic@kernel.org>
References: <20210604113159.26177-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If timer_settime() is called with a 0 expiration on a timer that is
already disabled, the process wide cputime counter will be started
and won't ever get a chance to be stopped by stop_process_timer() since
no timer is actually armed to be processed.

This process wide counter might bring some performance hit due to the
concurrent atomic additions at the thread group scope.

The following snippet is enough to trigger the issue.

	void trigger_process_counter(void)
	{
		timer_t id;
		struct itimerspec val = { };

		timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
		timer_settime(id, TIMER_ABSTIME, &val, NULL);
		timer_delete(id);
	}

So make sure we don't needlessly start it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/time/posix-cpu-timers.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index aa52fc85dbcb..132fd56fb1cd 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -632,10 +632,15 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 * times (in arm_timer).  With an absolute time, we must
 	 * check if it's already passed.  In short, we need a sample.
 	 */
-	if (CPUCLOCK_PERTHREAD(timer->it_clock))
+	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
 		val = cpu_clock_sample(clkid, p);
-	else
-		val = cpu_clock_sample_group(clkid, p, true);
+	} else {
+		/*
+		 * Sample group but only start the process wide cputime counter
+		 * if the timer is to be enabled.
+		 */
+		val = cpu_clock_sample_group(clkid, p, !!new_expires);
+	}
 
 	if (old) {
 		if (old_expires == 0) {
-- 
2.25.1

