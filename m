Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D26345E472
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 03:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343978AbhKZCaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 21:30:46 -0500
Received: from mail-m963.mail.126.com ([123.126.96.3]:41956 "EHLO
        mail-m963.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343956AbhKZC2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 21:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=kAsEn
        EnfaHIRU+yztl06WBOn7SgNxzGTN5esiiYf4r4=; b=Qu4pJYWW8imp68jv2YSvN
        QpAU0MPRk8eLlgOOT3NOJS+kuAc7LgHDjqu5IiPP14y5ZSZXxMGQE08h8JG6ApJx
        shRZkXhk1PzC49iYeV7ma4zBfTlSDFfP4BR0vY3cO7qFiYDxTejPyoAxlnZ1eN5V
        vW/gkka6ioGtp1wRTpgB3o=
Received: from localhost.localdomain (unknown [221.218.15.192])
        by smtp8 (Coremail) with SMTP id NORpCgCXU7yum59hJRBYCg--.2408S2;
        Thu, 25 Nov 2021 22:20:30 +0800 (CST)
From:   Honglei Wang <jameshongleiwang@126.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: prevent cpu burst too many periods
Date:   Thu, 25 Nov 2021 22:20:28 +0800
Message-Id: <20211125142028.21790-1-jameshongleiwang@126.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgCXU7yum59hJRBYCg--.2408S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw17Xw4DKw4rWw45JryDGFg_yoW8ur45pF
        sxXFy3JF40qr1jvanrArnagFyrZ3s3Z347CFWUGayrZw45W3yjqr15Ka1jgFn0vr1rtF1F
        vF4YqFW3Cryj9a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j6MKtUUUUU=
X-Originating-IP: [221.218.15.192]
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbiYBhWrVpEFXhVXwABs7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasks might get more cpu than quota in persistent periods due to the
cpu burst introduced by commit f4183717b370 ("sched/fair: Introduce the
burstable CFS controller"). For example, one task group whose quota is
100ms per period and can get 100ms burst, and its avg utilization is
around 105ms per period. Once this group gets a free period which
leaves enough runtime, it has a chance to get computting power more
than its quota for 10 periods or more in common bandwidth configuration
(say, 100ms as period). It means tasks can 'steal' the bursted power to
do daily jobs because all tasks could be scheduled out or sleep to help
the group get free periods.

I believe the purpose of cpu burst is to help handling bursty worklod.
But if one task group can get computting power more than its quota for
persistent periods even there is no bursty workload, it's kinda broke.

This patch limits the burst to one period so that it won't break the
quota limit for long. With this, we can give task group more cpu burst
power to handle the real bursty workload and don't worry about the
'stealing'.

Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
---
 kernel/sched/fair.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e476f6d9435..cc2c4567fc81 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4640,14 +4640,17 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 	if (unlikely(cfs_b->quota == RUNTIME_INF))
 		return;
 
-	cfs_b->runtime += cfs_b->quota;
-	runtime = cfs_b->runtime_snap - cfs_b->runtime;
+	runtime = cfs_b->runtime_snap - cfs_b->quota - cfs_b->runtime;
+
 	if (runtime > 0) {
 		cfs_b->burst_time += runtime;
 		cfs_b->nr_burst++;
+		cfs_b->runtime = cfs_b->quota;
+	} else {
+		cfs_b->runtime += cfs_b->quota;
+		cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
 	}
 
-	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
 	cfs_b->runtime_snap = cfs_b->runtime;
 }
 
-- 
2.14.1

