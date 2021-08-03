Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7093DF013
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbhHCOSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:18:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56902 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236610AbhHCOR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:26 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zd6+hf6ZsfNX9cx+jadUaVsb0HPeW5zrfA0utYJWQZ0=;
        b=PZOn+W1TJoTL8i8MZZOrIN41wKPehT3QaZdinWzPvx+OhxNQBZIedqIEhxZCMeqBcRnSxx
        BOnPxa+j9wWKWv76iN2gmJUeHSaAYCY5tmJs3pBsl04qN3OkLiKRcnUrqAbP4yvuppbe1/
        978Iud+9+5Gfpb58lFaUNaHMDW5WeMudinlzQE8WxZ7ZnZMcDDLr3iw9EXFz1y4693S86c
        hQBbbTCYNbmP1h2BeBefZHIQ+itEMX15EXCDeSerPV+K9mHjJ54jsy6QvnZyj8x6K3Uvqt
        I515W/eJePPt6be8dJwtEQf5FWYabCCPLkUe58uQ4Eo/3tTF+hp+KkB69SzB2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zd6+hf6ZsfNX9cx+jadUaVsb0HPeW5zrfA0utYJWQZ0=;
        b=kHG2V+0bG73HIkxVtHlBzitAIsOH/X2tRJKlmyQ3zS0EUvJKeAqfdIwhLdQuhZX3W/6TnE
        bdwfOWnCdT7BRLAg==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 32/38] sched: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:15 +0200
Message-Id: <20210803141621.780504-33-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

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
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d9ff40f46619..721b2c9201f6d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9824,7 +9824,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg=
, u64 period, u64 quota,
 	 * Prevent race between setting of cfs_rq->runtime_enabled and
 	 * unthrottle_offline_cfs_rqs().
 	 */
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&cfs_constraints_mutex);
 	ret =3D __cfs_schedulable(tg, period, quota);
 	if (ret)
@@ -9868,7 +9868,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg=
, u64 period, u64 quota,
 		cfs_bandwidth_usage_dec();
 out_unlock:
 	mutex_unlock(&cfs_constraints_mutex);
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return ret;
 }
--=20
2.32.0

