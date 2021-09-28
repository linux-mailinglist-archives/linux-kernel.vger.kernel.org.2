Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D5141AEEA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbhI1M0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:26:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35316 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240528AbhI1M0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:26:06 -0400
Message-ID: <20210928122411.425097596@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632831866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=i59qocCoGCnBtQVrBi2XUTcWPiODGidnjCAobrgCY6U=;
        b=qbtlVxewaGzD6eve/blPDdhZl2Y4Peiwk9pLd+6clvjH17E7MRisZtQEK+Wgjnhf3IyJuF
        SnEMc0RG06mEv2fmN87eQ+QTN8R2WJmwFasiyrzUWBwAPxXjHyX1zvynp2EjaMrNHxabSb
        TFuxDpdJa79/p8PhObMkF7rOSC96xRoS0a965umh453um6mHk1eGHJHfHlqd8ZEBjnFUPk
        p+/A/1wTnpgJcb/85DgxSIh3JY4qn6T6bm51swacr07Q8Mz4qee49mISUrPtubfO3Vwv2c
        GuKICBMYgpvfQ+F0IOJDe/tT46WuAW4Pv47Q1iX3567wV2XVnMtN8OgK1mguMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632831866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=i59qocCoGCnBtQVrBi2XUTcWPiODGidnjCAobrgCY6U=;
        b=1EYbUtAw7h1W4Rb7aeMPirUSbqjX0CVkN+pYkdaBskglmU7tXz85UhIB8K7W4VX1bdhWeA
        oPn7MBAfHq4a5aBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 1/5] sched: Limit the number of task migrations per batch on RT
References: <20210928122339.502270600@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 28 Sep 2021 14:24:25 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Batched task migrations are a source for large latencies as they keep the
scheduler from running while processing the migrations.

Limit the batch size to 8 instead of 32 when running on a RT enabled
kernel.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c |    4 ++++
 1 file changed, 4 insertions(+)
---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -74,7 +74,11 @@ const_debug unsigned int sysctl_sched_fe
  * Number of tasks to iterate in a single balance run.
  * Limited because this is done with IRQs disabled.
  */
+#ifdef CONFIG_PREEMPT_RT
+const_debug unsigned int sysctl_sched_nr_migrate = 8;
+#else
 const_debug unsigned int sysctl_sched_nr_migrate = 32;
+#endif
 
 /*
  * period over which we measure -rt task CPU usage in us.

