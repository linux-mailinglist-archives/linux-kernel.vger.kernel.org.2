Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F547427C86
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 20:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhJISLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 14:11:44 -0400
Received: from out0.migadu.com ([94.23.1.103]:45365 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhJISLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 14:11:43 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633802984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rGXt4f7CdKbPRXq7mN3AyHsL8/pu8WFZGYmQ2fHzFGc=;
        b=vqxQWXHWxgtW4qmbOKuceom2R1J87crdKP0gtnOPbJ8yxbyWQvcS4FCQuK8t9pEL6u6vB1
        KXAw2N/9GDxSm2VSFwbz4vc0p1RbOUey5nA7kyrDfVyf/gjxUdC0TKBI0r4e+5ULXRXBrl
        YUcKJ902kvt53XPDX1gqXqA+331lfEw=
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
Subject: [PATCH] sched/fair: Check idle_cpu in select_idle_core/cpu()
Date:   Sun, 10 Oct 2021 02:09:41 +0800
Message-Id: <20211009180941.20458-1-tao.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In select_idle_core(), the idle core returned may have no cpu
allowed. I think the idle core returned for the task is the one
that can be allowed to run. I insist on this semantics.

In select_idle_cpu(), if select_idle_core() can not find the
idle core, one reason is that the core is not allowed for the
task, but the core itself is idle from the point of
sds->has_idle_cores. I insist on this semantics.

No others, just two additional check.
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f6a05d9b5443..a44aca5095d3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6213,7 +6213,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 			*idle_cpu = cpu;
 	}
 
-	if (idle)
+	if (idle && *idle_cpu != -1)
 		return core;
 
 	cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
@@ -6324,7 +6324,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
-	if (has_idle_core)
+	if (has_idle_core && *idle_cpu != -1)
 		set_idle_cores(target, false);
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
-- 
2.32.0

