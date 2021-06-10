Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022213A21B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 03:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFJBD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 21:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhFJBDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 21:03:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C70F613EC;
        Thu, 10 Jun 2021 01:01:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lr953-002bXj-57; Wed, 09 Jun 2021 21:01:57 -0400
Message-ID: <20210610010156.993158915@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Jun 2021 21:01:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: [for-next][PATCH 02/11] sched/tracing: Remove the redundant success in the sched tracepoint
References: <20210610010130.069460694@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed Tsai <ed.tsai@mediatek.com>

'success' is left here for a long time and also it is meaningless
for the upper user. Just remove it.

[ There were some tools expecting this, and this may break them. But
  hopefully they've been fixed in the mean time. Otherwise this may be
  likely reverted - SDR ]

Link: https://lkml.kernel.org/r/20210422122226.9415-1-ed.tsai@mediatek.com

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/events/sched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 1eca2305ca42..94640482cfe7 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -148,7 +148,6 @@ DECLARE_EVENT_CLASS(sched_wakeup_template,
 		__array(	char,	comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	pid			)
 		__field(	int,	prio			)
-		__field(	int,	success			)
 		__field(	int,	target_cpu		)
 	),
 
@@ -156,7 +155,6 @@ DECLARE_EVENT_CLASS(sched_wakeup_template,
 		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
-		__entry->success	= 1; /* rudiment, kill when possible */
 		__entry->target_cpu	= task_cpu(p);
 	),
 
-- 
2.30.2
