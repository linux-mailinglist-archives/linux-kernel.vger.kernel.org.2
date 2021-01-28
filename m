Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1594F307AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 17:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhA1Q2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 11:28:30 -0500
Received: from mail1.windriver.com ([147.11.146.13]:36577 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhA1Q2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:28:23 -0500
X-Greylist: delayed 8655 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2021 11:28:13 EST
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 10SE28E5006791
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jan 2021 06:02:14 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 28 Jan 2021 06:02:10 -0800
Received: from arn-build2.wrs.com (128.224.95.15) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Thu, 28 Jan 2021 06:02:09 -0800
From:   Mikael Beckius <mikael.beckius@windriver.com>
To:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
Subject: [PATCH] hrtimer: Interrupt storm on clock_settime
Date:   Thu, 28 Jan 2021 15:02:08 +0100
Message-ID: <20210128140208.30264-1-mikael.beckius@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During clock_settime absolute realtime timers may get updated to expire
sooner in absolute monotonic time but if hrtimer_force_reprogram is
called as part of a clock_settime and the next hard hrtimer expires
before the next soft hrtimer softirq_expires_next will not be updated
to reflect this change (assuming the realtime timer is a soft timer).

This means that if the next soft hrtimer expires before
softirq_expires_next but after now no soft hrtimer interrupt will be
raised in hrtimer_interrupt which will instead retry tick_program_event
three times before forcing a tick_program_event using a very short delay
entering hrtimer_interrupt again almost immediately repeating the
process over and over again until now exceeds softirq_expires_next and a
soft hrtimer interrupt is finally raised.

This patch aims to solve this by always updating softirq_expires_next if
a soft hrtimer exists.

Signed-off-by: Mikael Beckius <mikael.beckius@windriver.com>
---
 kernel/time/hrtimer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 743c852e10f2..e4c233f404b1 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -633,7 +633,7 @@ hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
 	 */
 	expires_next = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_ALL);
 
-	if (cpu_base->next_timer && cpu_base->next_timer->is_soft) {
+	if (cpu_base->softirq_next_timer) {
 		/*
 		 * When the softirq is activated, hrtimer has to be
 		 * programmed with the first hard hrtimer because soft
@@ -643,7 +643,8 @@ hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
 			expires_next = __hrtimer_get_next_event(cpu_base,
 								HRTIMER_ACTIVE_HARD);
 		else
-			cpu_base->softirq_expires_next = expires_next;
+			cpu_base->softirq_expires_next = __hrtimer_get_next_event(cpu_base,
+								HRTIMER_ACTIVE_SOFT);
 	}
 
 	if (skip_equal && expires_next == cpu_base->expires_next)
-- 
2.28.0

