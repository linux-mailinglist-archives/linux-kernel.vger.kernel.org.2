Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0563ADDBB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 10:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhFTISu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 04:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhFTISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 04:18:47 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E98C061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 01:16:34 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v7so11543014pgl.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 01:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gEZn7B7dNvlhapHIK+/JpNKbE7yEjAepUUZv/RPCREM=;
        b=IVY29bbrCl/6ClPEJutmFJrLSnG2g8NJ5V1+pWRnMnxgK5DutS/JB442LDIB+u/oUM
         SQ1XCZdrEPyvZXu+Z2h/Sgy8JVHP7CDlPymDRIhfwXEUgdYw1zhyzFxg062T+imukr11
         bmtanCPhfL31+KppT4SlvGiQ+yVKuXaAxpPjMz2A97+wGn8JlHqnDQfPweMwd3Vpezww
         mwf/Yr2rrlzb4e3QzrTknRbuCifSjEAvBwLvtnJ3ItbWV5zBnGQqRxPwWxuJMcJwdc4Z
         c6Zw1IWSzEleHdjCrOqLI1Bz1P++ifZaeU1NRq2KpKneb+FNU5RyFBXO6WWZPLOJoRXz
         1Xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gEZn7B7dNvlhapHIK+/JpNKbE7yEjAepUUZv/RPCREM=;
        b=NSeA2NJYn9+IthEI+6V23QcQNMxHhcFJ3IcRkBFv+o3e7XpaOW1bf4hCRTUn8dBXwY
         uV23ab0vE70uxPIOis/50f24Nw0Et8wRUW8yt/qgJSYQz3DjOiwJbCHemow1wE+jG536
         sIupWEtjeVGGVMYzKjT7vCZF8TEf3/kL9qsqaXM4+j39PO8gtdBrEDEuaesyoCiIIBFK
         3stIMF92AVJ2//hSR1lxWV+CAahpFdow2CdipvPICuPkYATy2HcwCgHAixMK29awJUBd
         flYZ6p4a68+6gCtEJdjkklv/0labfLf6mmZRuz/xQAxuWnsf3yTYRIk5eYVyJuPs31wi
         q5Mg==
X-Gm-Message-State: AOAM531hLjXXI04vByfpK1osFSe2SlVAkuwuFVMemtZQFB4p2dMH74XG
        S6Gkqwj6kFY0ACzjAkIPr5UOVm3Jo5kS1SVm
X-Google-Smtp-Source: ABdhPJz1oDKdmRIsB2aRZg+Yb8jma2/4nJ6TRfkSVNdToWvpg+tfKJZOl9RhRODqym7/Nmtbn685Hw==
X-Received: by 2002:a63:e316:: with SMTP id f22mr18201551pgh.100.1624176993150;
        Sun, 20 Jun 2021 01:16:33 -0700 (PDT)
Received: from anisinha-lenovo.ba.nuagenetworks.net ([115.96.112.22])
        by smtp.googlemail.com with ESMTPSA id co18sm3229628pjb.37.2021.06.20.01.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 01:16:32 -0700 (PDT)
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
Subject: [PATCH V2] Add kernel logs when sched clock unstable and NO_HZ_FULL is not possible
Date:   Sun, 20 Jun 2021 13:46:04 +0530
Message-Id: <20210620081604.1754127-1-ani@anisinha.ca>
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
 
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index c2b2859ddd82..49f8c68faf56 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -192,8 +192,11 @@ void clear_sched_clock_stable(void)
 
 	smp_mb(); /* matches sched_clock_init_late() */
 
-	if (static_key_count(&sched_clock_running.key) == 2)
+	if (static_key_count(&sched_clock_running.key) == 2) {
 		__clear_sched_clock_stable();
+		WARN_ONCE(sched_clock_stable(),
+			  "sched clock is now marked unstable.");
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

