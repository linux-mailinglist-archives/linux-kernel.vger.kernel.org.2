Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857EE41A145
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbhI0VVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:21:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59334 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbhI0VVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:21:09 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632777570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L1DXV9AK736cmZLVDACTxlbY8l9WzymnQaO2J7ivysQ=;
        b=mPERQa/VufULTlRlGdLcqLDUVHnpxoKbq7VQnaJj02n6QynngQPjiUem6SjITMQ+k2gV7W
        DLOiDjr964pbsmnh8LpQC1wdcn99HupuQB+bmfX5RDg+kSiQriOjTgWQrBI9cgaLAu73vz
        b2UU9kO4SPc9escdvtg1gzl9WT+Vqp+KgF5oc/nYzTeFKJaEXl/QM+fj7xXQ/tyknMEmQh
        McTV1sXN/51p1RnEIcOOwNY9nIp/3ByAaKjn1sxTTe3ewc0vIor++U7KNu6VBiTOY41cVq
        3SqWz1vDeZgsBNdFaoN/xkTAut5fcM3FmaZeafmW1pgaeU4rn2AI53vLUBLFGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632777570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L1DXV9AK736cmZLVDACTxlbY8l9WzymnQaO2J7ivysQ=;
        b=0DlCNkGuPkkvsLc44GCHb66F00G6lj8V2e+aOZugPhn/MAJfH7i+6HgCK9P1Phyl7vKXpa
        eeNo/6fgszoYvvAw==
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
Subject: [PATCH 1/5] sched/rt: Annotate the RT balancing logic irqwork as IRQ_WORK_HARD_IRQ
Date:   Mon, 27 Sep 2021 23:19:15 +0200
Message-Id: <20210927211919.310855-2-bigeasy@linutronix.de>
In-Reply-To: <20210927211919.310855-1-bigeasy@linutronix.de>
References: <20210927211919.310855-1-bigeasy@linutronix.de>
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

