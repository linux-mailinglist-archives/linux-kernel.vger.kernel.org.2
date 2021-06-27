Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CAB3B5269
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 09:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhF0HbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 03:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhF0HbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 03:31:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE22C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 00:28:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bb20so8029099pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 00:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90yc8ERBtTGvPRz+l3K+T9KPtKwKwwOE79jyoGwACLc=;
        b=qhQwcD0jq6KPfdwgNsS3f8raiI8bp5JiBC4OeCk3auMe7COx6IJCMaCXEZV2pxFh6M
         7uH1SbWP6tmn1l7i3m+mmyaTEjhM/007qFf/KuoUTu5TnBahTPNwceeZu+jqV4iKCxjF
         zvnUWdX/1TdBwx+lWx0Bbkz8kj7ZjDjVcuRG9qHhJTEWcOqrwxDHbqFsK9mFniRqTcWf
         FBB1LRukgK+S3393eoFO9VFnT8YBHTwYIXUv9KLX4n/RphwzywowAPNrq3EF9WdcdZYK
         R4gScqKnxwnLn5oqc/AzFFuGzLDBvhueCjcHlhwvD+FiN7BV6kIeoJXRgC3JA4ya0p1b
         SAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90yc8ERBtTGvPRz+l3K+T9KPtKwKwwOE79jyoGwACLc=;
        b=YOjYLg8OguYbQB92JC3oqnmlMHhDHnSkusYQjRxH43JqwapBeBVWxbY9SSToAXJIgR
         EK9AaBXyO+YMVzPt/7O7Xspg2TJthe085BfoqfsfMzaXufNPYKADkBcFtWE8Vi3QFGUe
         qnPUn4g+3JRcYlBWa7b0fnRlWDPjxOwNZEiy0Gw/ua95alnheYDzMLXi4CMHyUFcLPpW
         V70wWe7QNRZuGvAHwn5wMU/UHIh8MxVfTYifg54w1i2fAgCPwXpY+0qw/oXt6j39CtNE
         qONQa+E/pyOCtRRYnNlwMWbi5a3+iB5z9m0AtgVp3+iZu8pgebBtgeG99zsn67eRD+3+
         dMcA==
X-Gm-Message-State: AOAM532GtXcsTAiykY5rsf6mOwm8DEa8K5vlM5qxo43poWw61p8hkYD/
        YSq0KARfasVCff96nw6lyEidxOsBOnrv3w==
X-Google-Smtp-Source: ABdhPJxYvGV45vVGzx3xGajiq6RBM4rR8/9x1i06MoIokZHUvtKOlTc/a+zu2vd6eGyJnh6evvbWWA==
X-Received: by 2002:a17:90a:2f41:: with SMTP id s59mr21260336pjd.19.1624778921142;
        Sun, 27 Jun 2021 00:28:41 -0700 (PDT)
Received: from anisinha-lenovo.ba.nuagenetworks.net ([115.96.154.39])
        by smtp.googlemail.com with ESMTPSA id l10sm15678496pjg.26.2021.06.27.00.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 00:28:40 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
To:     linux-kernel@vger.kernel.org
Cc:     anirban.sinha@nokia.com, tglx@linutronix.de,
        Ani Sinha <ani@anisinha.ca>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v1] Add info log when user enables NOHZ in commandline but NOHZ is not possible
Date:   Sun, 27 Jun 2021 12:58:33 +0530
Message-Id: <20210627072833.2199463-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4f49b90abb4aca ("sched-clock: Migrate to use new tick
dependency mask model") had also removed the kernel warning
message informing the user that it was not possible to turn
on NO_HZ_FULL. This warning was added in commit e12d0271774fe
("nohz: Warn if the machine can not perform nohz_full") in order
to warn users when they enabled NOHZ using the kernel commandline
but kernel could not enable NOHZ. Removal of this log defeats this
purpose because we still do not want users thinking that they are
getting the benefit of nohz when their machine can not support it.
Hence this patch brings back the information log.

If at some point the conditions that prevented NOHZ from being
enabled goes away and the previous info log was printed, we print
another log informing the user that NOHZ was again possible.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 kernel/time/tick-sched.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

See also thread: https://lkml.org/lkml/2021/6/20/32

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 828b091501ca..fbef95b57b1d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -930,6 +930,7 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
 {
 #ifdef CONFIG_NO_HZ_FULL
 	int cpu = smp_processor_id();
+	static bool no_tick_warned;
 
 	if (!tick_nohz_full_cpu(cpu))
 		return;
@@ -937,10 +938,24 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
 	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
 		return;
 
-	if (can_stop_full_tick(cpu, ts))
+	if (can_stop_full_tick(cpu, ts)) {
 		tick_nohz_stop_sched_tick(ts, cpu);
-	else if (ts->tick_stopped)
-		tick_nohz_restart_sched_tick(ts, ktime_get());
+		if (no_tick_warned) {
+			pr_info("NO_HZ_FULL is now enabled in the system.\n");
+			no_tick_warned = false;
+		}
+	} else {
+		/*
+		 * Don't allow the user to think they can get
+		 * full NO_HZ with this machine.
+		 */
+		if (!no_tick_warned && tick_nohz_full_running) {
+			pr_info("NO_HZ_FULL has been disabled in the system.");
+			no_tick_warned = true;
+		}
+		if (ts->tick_stopped)
+			tick_nohz_restart_sched_tick(ts, ktime_get());
+	}
 #endif
 }
 
-- 
2.25.1

