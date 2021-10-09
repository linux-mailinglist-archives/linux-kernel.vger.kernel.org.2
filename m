Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0B1427C88
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 20:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhJISMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 14:12:35 -0400
Received: from out1.migadu.com ([91.121.223.63]:14029 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhJISMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 14:12:34 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633803035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZMVxJqPKaSl4GSNlQsUxh9ySBX4Km3FVjqq+MNWj++o=;
        b=PO2DzdLYV6BZOvMai/wKqYUA4Vq9NTxkvOeHLrTiLu0UpflWJ0yKz0/TkYWX2/nItv7RM7
        9sxZSCil30pcKM+HpHAmX6o/ppn92c72yI+DzRKebGXAUiDgTh4hxA0CJXkAVxYFP9HHUD
        D86IEIJzewHxhwUpP1wjo/V0V5v6pY0=
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
Subject: [PATCH] sched/fair: Use this_sd->weight to calculate span_avg
Date:   Sun, 10 Oct 2021 02:10:55 +0800
Message-Id: <20211009181055.20512-1-tao.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

avg_idle, avg_cost got from this_rq and this_sd. I think
use this_sd->weight to calculate and estimate the number
of loop cpus in the target domain.
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f6a05d9b5443..7fab7b70814c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6300,7 +6300,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		avg_idle = this_rq->wake_avg_idle;
 		avg_cost = this_sd->avg_scan_cost + 1;
 
-		span_avg = sd->span_weight * avg_idle;
+		span_avg = this_sd->span_weight * avg_idle;
 		if (span_avg > 4*avg_cost)
 			nr = div_u64(span_avg, avg_cost);
 		else
-- 
2.32.0

