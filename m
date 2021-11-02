Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2C8442F2F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 14:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhKBNpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:45:44 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14702 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhKBNpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:45:41 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hk9yx4jCJzZcf8;
        Tue,  2 Nov 2021 21:40:57 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Tue, 2
 Nov 2021 21:43:01 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <broonie@kernel.org>,
        <joe@perches.com>, <wangwensheng4@huawei.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH -next] ALSA: timer: Fix use-after-free problem
Date:   Tue, 2 Nov 2021 13:41:07 +0000
Message-ID: <20211102134107.35126-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the timer instance was add into ack_list but was not currently in
process, the user could stop it via snd_timer_stop1() without delete it
from the ack_list. Then the user could free the timer instance and when
it was actually processed UAF occurred.

This issue could be reproduced via testcase snd_timer01 in ltp - running
several instances of that testcase at the same time.

What I actually met was that the ack_list of the timer broken and the
kernel went into deadloop with irqoff. That could be detected by
hardlockup detector on board or when we run it on qemu, we could use gdb
to dump the ack_list when the console has no response.

To fix this issue, we introduce a new flag SNDRV_TIMER_IFLG_ACKING to
indicate the state where the timer instance is in ack_list but not
currently processed and check against the new flag in snd_timer_stop1()
and delete it from ack_list if the flag is set.

Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 include/sound/timer.h |  1 +
 sound/core/timer.c    | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/sound/timer.h b/include/sound/timer.h
index 760e132cc0cd..549288e94a39 100644
--- a/include/sound/timer.h
+++ b/include/sound/timer.h
@@ -31,6 +31,7 @@
 #define SNDRV_TIMER_IFLG_CALLBACK 0x00000020	/* timer callback is active */
 #define SNDRV_TIMER_IFLG_EXCLUSIVE 0x00000040	/* exclusive owner - no more instances */
 #define SNDRV_TIMER_IFLG_EARLY_EVENT 0x00000080	/* write early event to the poll queue */
+#define SNDRV_TIMER_IFLG_ACKING    0x00000100	/* the timeri was added to ack_list */
 
 #define SNDRV_TIMER_FLG_CHANGE	0x00000001
 #define SNDRV_TIMER_FLG_RESCHED	0x00000002	/* need reschedule */
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 92b7008fcdb8..1d1e4274919c 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -625,10 +625,12 @@ static int snd_timer_stop1(struct snd_timer_instance *timeri, bool stop)
 		return -EINVAL;
 	spin_lock_irqsave(&timer->lock, flags);
 	if (!(timeri->flags & (SNDRV_TIMER_IFLG_RUNNING |
-			       SNDRV_TIMER_IFLG_START))) {
+			       SNDRV_TIMER_IFLG_START |
+			       SNDRV_TIMER_IFLG_ACKING))) {
 		result = -EBUSY;
 		goto unlock;
 	}
+
 	list_del_init(&timeri->ack_list);
 	list_del_init(&timeri->active_list);
 	if (timer->card && timer->card->shutdown)
@@ -649,7 +651,8 @@ static int snd_timer_stop1(struct snd_timer_instance *timeri, bool stop)
 			}
 		}
 	}
-	timeri->flags &= ~(SNDRV_TIMER_IFLG_RUNNING | SNDRV_TIMER_IFLG_START);
+	timeri->flags &= ~(SNDRV_TIMER_IFLG_RUNNING | SNDRV_TIMER_IFLG_START |
+			   SNDRV_TIMER_IFLG_ACKING);
 	if (stop)
 		timeri->flags &= ~SNDRV_TIMER_IFLG_PAUSED;
 	else
@@ -786,6 +789,7 @@ static void snd_timer_process_callbacks(struct snd_timer *timer,
 
 		/* remove from ack_list and make empty */
 		list_del_init(&ti->ack_list);
+		ti->flags &= ~SNDRV_TIMER_IFLG_ACKING;
 
 		if (!(ti->flags & SNDRV_TIMER_IFLG_DEAD)) {
 			ticks = ti->pticks;
@@ -890,8 +894,10 @@ void snd_timer_interrupt(struct snd_timer * timer, unsigned long ticks_left)
 			ack_list_head = &timer->ack_list_head;
 		else
 			ack_list_head = &timer->sack_list_head;
-		if (list_empty(&ti->ack_list))
+		if (list_empty(&ti->ack_list)) {
 			list_add_tail(&ti->ack_list, ack_list_head);
+			ti->flags |= SNDRV_TIMER_IFLG_ACKING;
+		}
 		list_for_each_entry(ts, &ti->slave_active_head, active_list) {
 			ts->pticks = ti->pticks;
 			ts->resolution = resolution;
-- 
2.17.1

