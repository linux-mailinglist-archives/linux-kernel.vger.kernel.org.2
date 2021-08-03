Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052AA3DF01E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbhHCOTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbhHCORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4B9C0617A4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 07:17:16 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+yWcBmgXw0+L0OHSgsFdHVx3soTQShqO/+GcpJlWs8=;
        b=uaoRKRTKmfZ1CX94Y/vCyFi13/e/Jk+683mISgKpTNeDCOEVIA0c/oG/9/oe2eU6ajRex1
        zSRusKlR0Q9Sejzer/5c9Ass+YUkRFZ5mte8phluwxX5e7zCoMjrTbTENvsUQAuF6ACaBJ
        wZ8xDyOzzExWq3q86pRf6qe4NzLLGeVB5GD7THYq1aXumSoGy0KyFMTQN/+6sL/p9xz6hv
        gvarZ8imZ3RbaK+yeDbDZUvNeIxxqyKGmAZoDhQ5CHvjkJCOUWDyWZNKJTPHcewMQn62u+
        3mTxS2aoVGg+2vhtX11VuznCDZWBZXic+ei6TbntG24ClLxUR/EY53TgLq1X3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+yWcBmgXw0+L0OHSgsFdHVx3soTQShqO/+GcpJlWs8=;
        b=p2ahZELw3gsrxkx92CnKDvyLkwhSL+TjG1Fl7OWKY1uz/+IJ104eN3Dsji6Dy+0CTAkupf
        adUmsJ4cWVgxIfBA==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 34/38] clocksource: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:17 +0200
Message-Id: <20210803141621.780504-35-bigeasy@linutronix.de>
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

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/clocksource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b89c76e1c02c4..b8a14d2fb5ba6 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -306,12 +306,12 @@ void clocksource_verify_percpu(struct clocksource *cs)
 		return;
 	cpumask_clear(&cpus_ahead);
 	cpumask_clear(&cpus_behind);
-	get_online_cpus();
+	cpus_read_lock();
 	preempt_disable();
 	clocksource_verify_choose_cpus();
 	if (cpumask_weight(&cpus_chosen) =3D=3D 0) {
 		preempt_enable();
-		put_online_cpus();
+		cpus_read_unlock();
 		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
 		return;
 	}
@@ -337,7 +337,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 			cs_nsec_min =3D cs_nsec;
 	}
 	preempt_enable();
-	put_online_cpus();
+	cpus_read_unlock();
 	if (!cpumask_empty(&cpus_ahead))
 		pr_warn("        CPUs %*pbl ahead of CPU %d for clocksource %s.\n",
 			cpumask_pr_args(&cpus_ahead), testcpu, cs->name);
--=20
2.32.0

