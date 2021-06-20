Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDA83ADDEF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 12:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhFTKPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 06:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhFTKPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 06:15:43 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA76C061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 03:13:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g4so8243317pjk.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 03:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=np6ohhXBWtPY12jb8/5kaMcgPuhRLshpNxAS67+N7Js=;
        b=UjlanYdGOEAzXUILZffrYi8CMxiNrpzByTGgTcyQfHhBMBZGGCwzu1nAsl4SqS9Fy6
         OKeXbZEDtlFYSL1t/EZrRV8KQUia6qFu7yicOtep8+KWQZI5cF49sFe+p8qiO64r9eAS
         bL92KohRPoFHaLuLe6pzjbPeEP3OTRNnen2RPtICqzY0HlvlELh3cZRwah4k4moO3/N3
         v9ZFbi5U8pwWkWFwwuaahTJIxTDpjmZrl4tsJxh3f/9raDSrSzVYB/UPWvurgiUyE1/q
         YUWEXVvVxU1J20ogJuqLicdh0fpbllAfF6smHE3aKfuaP3H05+EJRup48M6aPSfHDTOO
         DQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=np6ohhXBWtPY12jb8/5kaMcgPuhRLshpNxAS67+N7Js=;
        b=f6cCQuL4C6B8Z9HYYtDaPjVljQXKDmiP/f1lhFyPCfauWfZg+Xjc8V/ftX1afPkG9+
         FTF1AWqRj63mjz+RuPqm/Ak2ncHEz/C63daxKVsAMNPd0SYtSkYeiEqGUivntdOIJNlC
         n2iKGfJCXOISIlChT3o9WYTTMmeLqcJr7qoH7b529cnjZsQfoxZ2wuwKX0BP7cgS8mVz
         3uh0naklrZ8h4LQyp+jBwYYaYuSFX6UVWYzKP6pXgwuSygVFjy9fsDjdIA7pBf4ff+tr
         Bmxv4OTNo25AS73la59PlnDSjEosVre7hfnrMapng+dXUBIVuyAzaRxdTmaL+s2mS7pG
         8C3Q==
X-Gm-Message-State: AOAM530uaqCY8e2aG+9VsaPN/DLei+i+0y3c8jZ8CTvP9IutAmDchael
        NZektQ4ZhB2JO8ZjGTrWg3hpRPS0DlyWVwaO
X-Google-Smtp-Source: ABdhPJxcvrd8xNYNNkTT33cBIKQ6cqHMdAOO6qALpC+kDzWn3rpPEDAACMgDPX6PSsdSbuRzb3WlLQ==
X-Received: by 2002:a17:90b:78e:: with SMTP id l14mr21296452pjz.110.1624184007678;
        Sun, 20 Jun 2021 03:13:27 -0700 (PDT)
Received: from anisinha-lenovo.ba.nuagenetworks.net ([115.96.112.22])
        by smtp.googlemail.com with ESMTPSA id c25sm12151575pfo.130.2021.06.20.03.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 03:13:27 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
To:     linux-kernel@vger.kernel.org
Cc:     anirban.sinha@nokia.com, Ani Sinha <ani@anisinha.ca>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3] Add kernel logs when sched clock unstable and NO_HZ_FULL is not possible
Date:   Sun, 20 Jun 2021 15:43:12 +0530
Message-Id: <20210620101312.1757363-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4f49b90abb4aca ("sched-clock: Migrate to use new tick
dependency mask model") had also removed the kernel warning
message informing the user that it was not possible to turn
on NO_HZ_FULL. Adding back that log message here. It is
unhelpful when the kernel turns off NO_HZ_FULL silently
without informing anyone.
Also added a kernel log when sched clock is marked as unstable.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 kernel/sched/clock.c     |  5 ++++-
 kernel/time/tick-sched.c | 14 +++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

changelog:
v1: original patch
v2: updated log message to make it non specific to sched clock. Also
    added another log when sched clock is marked as unstable.
v3: a bugfix to v2.

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index c2b2859ddd82..9f9fe658f8a5 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -192,8 +192,11 @@ void clear_sched_clock_stable(void)
 
 	smp_mb(); /* matches sched_clock_init_late() */
 
-	if (static_key_count(&sched_clock_running.key) == 2)
+	if (static_key_count(&sched_clock_running.key) == 2) {
+		WARN_ONCE(sched_clock_stable(),
+			  "sched clock is now marked unstable.");
 		__clear_sched_clock_stable();
+	}
 }
 
 static void __sched_clock_gtod_offset(void)
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 828b091501ca..6e583aa2d160 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -937,10 +937,18 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
 	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
 		return;
 
-	if (can_stop_full_tick(cpu, ts))
+	if (can_stop_full_tick(cpu, ts)) {
 		tick_nohz_stop_sched_tick(ts, cpu);
-	else if (ts->tick_stopped)
-		tick_nohz_restart_sched_tick(ts, ktime_get());
+	} else {
+		/*
+		 * Don't allow the user to think they can get
+		 * full NO_HZ with this machine.
+		 */
+		WARN_ONCE(tick_nohz_full_running,
+			  "NO_HZ_FULL will not work for the current system.");
+		if (ts->tick_stopped)
+			tick_nohz_restart_sched_tick(ts, ktime_get());
+	}
 #endif
 }
 
-- 
2.25.1

