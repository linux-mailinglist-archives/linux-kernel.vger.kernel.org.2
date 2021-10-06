Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F85E423C82
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbhJFLU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbhJFLUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:20:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151A1C061762
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 04:19:00 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633519137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L1DXV9AK736cmZLVDACTxlbY8l9WzymnQaO2J7ivysQ=;
        b=xLwbHUZSWIhS9yeaKd365XBC0eUFceh+yzCsj+yJTxk8SfN+CXKf57a2wTFbPSDUlz7icl
        Zk96TuziVu/M7JzIX7dYXKRCwmSzGbGH3eAAWZxspoZr4lqzol6cP0hns54R2LaNZ8amwX
        1e25MeKpgoAb45Fruf4EythsyowJC9F+jghC7qma4DF+3C+wiKCgIP90Rphu+43A7243/G
        dYXdQpz4xLWiT8LrUVv8Xcd4CEk4qCmkzwOf3ZVvVlZmlqmRjKYwNRS+gaDq8St7jgjqO1
        x4XA+ZjNdlnlLShsMZcqwuItl/+ZZpGaSakzMtJzeIACeBbJ8e2Zlp+U6/g+/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633519137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L1DXV9AK736cmZLVDACTxlbY8l9WzymnQaO2J7ivysQ=;
        b=yL1kMqOMSM6HP8KySAark7aiQGQ7xbHPt3avOM/jhwSrTuWyI+pN+BIZXmepm4SHkAzgOn
        mXGxDupW0bQ0JbBA==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v2 1/4] sched/rt: Annotate the RT balancing logic irqwork as IRQ_WORK_HARD_IRQ
Date:   Wed,  6 Oct 2021 13:18:49 +0200
Message-Id: <20211006111852.1514359-2-bigeasy@linutronix.de>
In-Reply-To: <20211006111852.1514359-1-bigeasy@linutronix.de>
References: <20211006111852.1514359-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The push-IPI logic for RT tasks expects to be invoked from hardirq
context. One reason is that a RT task on the remote CPU would block the
softirq processing on PREEMPT_RT and so avoid pulling / balancing the RT
tasks as intended.

Annotate root_domain::rto_push_work as IRQ_WORK_HARD_IRQ.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 4e8698e62f075..3d0157bd4e144 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -526,7 +526,7 @@ static int init_rootdomain(struct root_domain *rd)
 #ifdef HAVE_RT_PUSH_IPI
 	rd->rto_cpu =3D -1;
 	raw_spin_lock_init(&rd->rto_lock);
-	init_irq_work(&rd->rto_push_work, rto_push_irq_work_func);
+	rd->rto_push_work =3D IRQ_WORK_INIT_HARD(rto_push_irq_work_func);
 #endif
=20
 	rd->visit_gen =3D 0;
--=20
2.33.0

