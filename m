Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637703B71F3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 14:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbhF2MVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 08:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbhF2MVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:21:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5F4C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 05:18:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id q18so4746328lfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 05:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RxHGY7S/PGo9l+epfA3kfSLzx4lK4ynQ52nhtavStLI=;
        b=N7S+pQWxu2P+OqTBZjsZwN+Aq8bnjh2R156qgQ+pkDEwvqz4RQk19NBs3DTJJGjWA2
         SJHxMquhxUS+ZhoWZj0/FRN3vwp1H7uNWuHABPO2rjhJT7vxJ1Hlrr70LDHdrHFgQmIx
         ezRop4HX3kKJo0E4TbRP6r4vjEipby8u65I8p1YKQjX+hgx8JzCAcFn0m+Onu8vCWaa8
         kMpDmRFX3PetwCzbCPT8bZ89STrMQ9HoUJl8AVu3RrpbaIrqJDJKpDwLXZDcr4rsgU3s
         mlPvgL9IqM5dYYa/DemyxekA4vskJo0zmenUwOWVtWMiIozbbaqfiQiLnG3D/DPaJanv
         ULQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RxHGY7S/PGo9l+epfA3kfSLzx4lK4ynQ52nhtavStLI=;
        b=OjwtOCunejeaJtvBrpf3pnIQbyJ/F6MS36qkjOimhGLBqh6yPJNmteC2c9dnxA7l6X
         XS4NXBbfyOq9sVacZ4ZDwDgXO6YN1dE2CM8oL7ksHAsCY7OQVAu9ffXwV1pXg5764j2J
         AiqK7epWdgEGdYy1hH0p74fIRpAI58H5gJsKAj+E8Ju+tdzhYFUElpr/HlLl+7VbysiS
         8XEy0VfKkALn4Nd2859z9wM60RhvTtjH5CBdWhTQXwwMEqWXrF9hoHUYP5cK+KPD2yx/
         4O0Qf/kRpJZXmhqWkBNHGlUy5tF5bxf9/ijML07MBpVc1MDte92o0WbO/ZAyi3KO45pt
         pqPg==
X-Gm-Message-State: AOAM532VFmqTpjEi2anLgpD5CKikSW/AmllHpg3qD5/L+PUYcPWtwqSP
        +geJQwdbydAtLI4H4xvB9llNLw==
X-Google-Smtp-Source: ABdhPJxTlCYxtMQrgBeCVYcJvkUFgtW9Cfsuj5jfhDAx+1Fiq9L2Yo2NN8h6Egq3cLdCmqiqTp/wgA==
X-Received: by 2002:a19:410c:: with SMTP id o12mr4736548lfa.10.1624969125704;
        Tue, 29 Jun 2021 05:18:45 -0700 (PDT)
Received: from localhost.localdomain (ti0005a400-2351.bb.online.no. [80.212.254.60])
        by smtp.gmail.com with ESMTPSA id w13sm542021ljd.27.2021.06.29.05.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 05:18:45 -0700 (PDT)
From:   Odin Ugedal <odin@uged.al>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Odin Ugedal <odin@uged.al>
Subject: [PATCH] sched/fair: Fix CFS bandwidth hrtimer expiry type
Date:   Tue, 29 Jun 2021 14:14:52 +0200
Message-Id: <20210629121452.18429-1-odin@uged.al>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The time remaining until expiry of the refresh_timer can be negative.
Casting the type to an unsigned 64-bit value will cause integer
underflow, making the runtime_refresh_within return false instead of
true. These situations are rare, but they do happen.

This does not cause user-facing issues or errors; other than
possibly unthrottling cfs_rq's using runtime from the previous period(s),
making the CFS bandwidth enforcement less strict in those (special)
situations.

Signed-off-by: Odin Ugedal <odin@uged.al>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 23663318fb81..62446c052efb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5108,7 +5108,7 @@ static const u64 cfs_bandwidth_slack_period = 5 * NSEC_PER_MSEC;
 static int runtime_refresh_within(struct cfs_bandwidth *cfs_b, u64 min_expire)
 {
 	struct hrtimer *refresh_timer = &cfs_b->period_timer;
-	u64 remaining;
+	s64 remaining;
 
 	/* if the call-back is running a quota refresh is already occurring */
 	if (hrtimer_callback_running(refresh_timer))
@@ -5116,7 +5116,7 @@ static int runtime_refresh_within(struct cfs_bandwidth *cfs_b, u64 min_expire)
 
 	/* is a quota refresh about to occur? */
 	remaining = ktime_to_ns(hrtimer_expires_remaining(refresh_timer));
-	if (remaining < min_expire)
+	if (remaining < (s64)min_expire)
 		return 1;
 
 	return 0;
-- 
2.32.0

