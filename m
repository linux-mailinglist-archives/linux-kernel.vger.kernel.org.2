Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18AF38B64A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbhETSs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:48:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235880AbhETSss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:48:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 347AA6124C;
        Thu, 20 May 2021 18:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621536446;
        bh=tjZHOWaK+cFm3eDjHyyP9YNAx0VLERWMIXFQByYvbjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tm6u9YuLHKaS5VVmKkehR+QiJCQlNIvK0Rsy7A31iPDsEXalFnU13t2sUQayM0/Rl
         2V7HSV1X3TsZITjTscWVqtHfe8lo5Oo0RczMu2RKUIrKIpRMtJz1Y23DOYwWo0nofg
         O9I1RRg8e+MkzIbusUwamXGpRhNsJmNgCSwpsCpebyfW+s45hHKi50Lj5O/51mwtSN
         fiBsYS99NpEVjw2SD3lCoxst7iW44ChWXowyc/S5uL6BXroUSbWIHMrqcH7gtunoIn
         5atbfOPzcS12lvBg/VVPVj3ec0/PIMxQzOj5Uml/7Jw2VRmXmtHnB/lNxxJUF3YaiI
         GzYMtg/ARv7vg==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kernel-team@android.com
Subject: [PATCH 2/5] tick/broadcast: Split __tick_broadcast_oneshot_control() into a helper
Date:   Thu, 20 May 2021 19:47:02 +0100
Message-Id: <20210520184705.10845-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520184705.10845-1-will@kernel.org>
References: <20210520184705.10845-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding support for per-cpu wakeup timers, split
_tick_broadcast_oneshot_control() into a helper function which deals
only with the broadcast timer management across idle transitions.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/time/tick-broadcast.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index fb794ff4855e..f3f2f4ba4321 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -717,24 +717,16 @@ static void broadcast_shutdown_local(struct clock_event_device *bc,
 	clockevents_switch_state(dev, CLOCK_EVT_STATE_SHUTDOWN);
 }
 
-int __tick_broadcast_oneshot_control(enum tick_broadcast_state state)
+static int ___tick_broadcast_oneshot_control(enum tick_broadcast_state state,
+					     struct tick_device *td,
+					     int cpu)
 {
-	struct clock_event_device *bc, *dev;
-	int cpu, ret = 0;
+	struct clock_event_device *bc, *dev = td->evtdev;
+	int ret = 0;
 	ktime_t now;
 
-	/*
-	 * If there is no broadcast device, tell the caller not to go
-	 * into deep idle.
-	 */
-	if (!tick_broadcast_device.evtdev)
-		return -EBUSY;
-
-	dev = this_cpu_ptr(&tick_cpu_device)->evtdev;
-
 	raw_spin_lock(&tick_broadcast_lock);
 	bc = tick_broadcast_device.evtdev;
-	cpu = smp_processor_id();
 
 	if (state == TICK_BROADCAST_ENTER) {
 		/*
@@ -863,6 +855,21 @@ int __tick_broadcast_oneshot_control(enum tick_broadcast_state state)
 	return ret;
 }
 
+int __tick_broadcast_oneshot_control(enum tick_broadcast_state state)
+{
+	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
+	int cpu = smp_processor_id();
+
+	if (tick_broadcast_device.evtdev)
+		return ___tick_broadcast_oneshot_control(state, td, cpu);
+
+	/*
+	 * If there is no broadcast device, tell the caller not
+	 * to go into deep idle.
+	 */
+	return -EBUSY;
+}
+
 /*
  * Reset the one shot broadcast for a cpu
  *
-- 
2.31.1.818.g46aad6cb9e-goog

