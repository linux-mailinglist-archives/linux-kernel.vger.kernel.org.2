Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A55427C80
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 20:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhJISJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 14:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJISJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 14:09:11 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B8C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 11:07:14 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633802832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K6elq7AFobxNdKY5PG3UHJIIIjiAppGcE9M8qcToufc=;
        b=sTPGTwNAQTzHug+UFuxVG80POuk9/PMiMNa/I12ODj5K5w6CN+KSbwrfiHoGED/6kM9Av0
        783mzEBbyQD734w3KpPFEiVlfpB0Op/AkSS1Plsun4+T+yUvP/eK4ACeGTLIfjL4k0udiR
        L5dWgtEZDodMKnLfi5jkDXpt2z59QkM=
From:   Tao Zhou <tao.zhou@linux.dev>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Tao Zhou <tao.zhou@linux.dev>
Subject: [PATCH] sched/pelt: Use or not add in update_irq_load_avg()
Date:   Sun, 10 Oct 2021 02:06:42 +0800
Message-Id: <20211009180642.20319-1-tao.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ret value of update_irq_load_avg() can be 2. And this value
is used in __update_blocked_others(). It should be 0 or 1. Use
OR operation in update_irq_load_avg().
---
 kernel/sched/pelt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index a554e3bbab2b..7edf21f7977c 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -458,7 +458,7 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 				0,
 				0,
 				0);
-	ret += ___update_load_sum(rq->clock, &rq->avg_irq,
+	ret |= ___update_load_sum(rq->clock, &rq->avg_irq,
 				1,
 				1,
 				1);
-- 
2.32.0

