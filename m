Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2AC31C8E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 11:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhBPKgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 05:36:53 -0500
Received: from foss.arm.com ([217.140.110.172]:60208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhBPKgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:36:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01BF9ED1;
        Tue, 16 Feb 2021 02:35:24 -0800 (PST)
Received: from e124901.arm.com (unknown [10.57.6.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C54173F73B;
        Tue, 16 Feb 2021 02:35:22 -0800 (PST)
From:   vincent.donnefort@arm.com
To:     peterz@infradead.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v2 2/3] cpu/hotplug: CPUHP_BRINGUP_CPU failure exception
Date:   Tue, 16 Feb 2021 10:35:05 +0000
Message-Id: <20210216103506.416286-3-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210216103506.416286-1-vincent.donnefort@arm.com>
References: <20210216103506.416286-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

The atomic states (between CPUHP_AP_IDLE_DEAD and CPUHP_AP_ONLINE) are
triggered by the CPUHP_BRINGUP_CPU step. If the latter fails, no atomic
state can be rolled back.

DEAD callbacks too can't fail and disallow recovery. As a consequence,
during hotunplug, the fail injection interface should prohibit all states
from CPUHP_BRINGUP_CPU to CPUHP_ONLINE.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 093f96fb0824..d44877095b8c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1038,9 +1038,13 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	 * to do the further cleanups.
 	 */
 	ret = cpuhp_down_callbacks(cpu, st, target);
-	if (ret && st->state == CPUHP_TEARDOWN_CPU && st->state < prev_state) {
-		cpuhp_reset_state(st, prev_state);
-		__cpuhp_kick_ap(st);
+	if (ret && st->state < prev_state) {
+		if (st->state == CPUHP_TEARDOWN_CPU) {
+			cpuhp_reset_state(st, prev_state);
+			__cpuhp_kick_ap(st);
+		} else {
+			WARN(1, "DEAD callback error for CPU%d", cpu);
+		}
 	}
 
 out:
@@ -2214,6 +2218,15 @@ static ssize_t write_cpuhp_fail(struct device *dev,
 	if (cpuhp_is_atomic_state(fail))
 		return -EINVAL;
 
+	/*
+	 * DEAD callbacks cannot fail...
+	 * ... neither can CPUHP_BRINGUP_CPU during hotunplug. The latter
+	 * triggering STARTING callbacks, a failure in this state would
+	 * hinder rollback.
+	 */
+	if (fail <= CPUHP_BRINGUP_CPU && st->state > CPUHP_BRINGUP_CPU)
+		return -EINVAL;
+
 	/*
 	 * Cannot fail anything that doesn't have callbacks.
 	 */
-- 
2.25.1

