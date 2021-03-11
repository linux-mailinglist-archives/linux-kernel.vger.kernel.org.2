Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E003372D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhCKMhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:37:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233190AbhCKMhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:37:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1794064FE6;
        Thu, 11 Mar 2021 12:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615466237;
        bh=I4y2AElfIxluZFcgYq0yvzhKqir2bW0RPqelVOJJZ0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=es5hNvnPZVV/ROxHIEBT0u9HtS4yhm0nUd/voR747OBTeM9uIkNm0C3Dkd8WyQV+/
         ifgmnR9eQaqD0CtaNDMsHIEtTataXgYm6MpA5E+uAdL/ILtQDwystlPujSJaiVJiU7
         Xo3sGkTPpQtCNBCSb8mpF01OjrprfJ7xTmywx0gg0QRB3D/VjUKg8r2WxZkqQonVRL
         n+GXcxnWaumPbLKnwfCdBsj49WuURlOLNGd7fZfQ+BgMnSRYoM/kQ3KGCJMPZr7U3N
         NLdPC825j5uWGPLgv3eaeB+NRCuLpzjCb6znQcXrQaO+MQYmSPZozcld4VLsRnncF4
         H5dUH2rpzJ4vg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 01/10] tick/nohz: Prevent tick_nohz_get_sleep_length() from returning negative value
Date:   Thu, 11 Mar 2021 13:36:59 +0100
Message-Id: <20210311123708.23501-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311123708.23501-1-frederic@kernel.org>
References: <20210311123708.23501-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>

If the hardware clock happens to fire its interrupts late, two possible
issues can happen while calling tick_nohz_get_sleep_length(). Either:

1) The next clockevent device event is due past the last idle entry time.

or:

2) The last timekeeping update happened before the last idle entry time
   and the next timer callback expires before the last idle entry time.

Make sure that both cases are handled to avoid returning a negative
duration to the cpuidle governors.

Signed-off-by: Ti Zhou <x2019cwm@stfx.ca>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index e10a4af88737..22b6a46818cf 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1142,6 +1142,9 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 
 	*delta_next = ktime_sub(dev->next_event, now);
 
+	if (unlikely(*delta_next < 0))
+		*delta_next = 0;
+
 	if (!can_stop_idle_tick(cpu, ts))
 		return *delta_next;
 
@@ -1156,6 +1159,9 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 	next_event = min_t(u64, next_event,
 			   hrtimer_next_event_without(&ts->sched_timer));
 
+	if (unlikely(next_event < now))
+		next_event = now;
+
 	return ktime_sub(next_event, now);
 }
 
-- 
2.25.1

