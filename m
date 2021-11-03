Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ED0443BE7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 04:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhKCDjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 23:39:52 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:25348 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhKCDjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 23:39:51 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HkXQP1W8jzbhPk;
        Wed,  3 Nov 2021 11:32:29 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Wed, 3
 Nov 2021 11:37:13 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <wangwensheng4@huawei.com>,
        <broonie@kernel.org>, <joe@perches.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH -next v2] ALSA: timer: Fix use-after-free problem
Date:   Wed, 3 Nov 2021 03:35:17 +0000
Message-ID: <20211103033517.80531-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

To fix this issue, we delete the timer instance from ack_list and
active_list unconditionally in snd_timer_stop1().

Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
Suggested-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 92b7008fcdb8..4f9bab931951 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -624,13 +624,13 @@ static int snd_timer_stop1(struct snd_timer_instance *timeri, bool stop)
 	if (!timer)
 		return -EINVAL;
 	spin_lock_irqsave(&timer->lock, flags);
+	list_del_init(&timeri->ack_list);
+	list_del_init(&timeri->active_list);
 	if (!(timeri->flags & (SNDRV_TIMER_IFLG_RUNNING |
 			       SNDRV_TIMER_IFLG_START))) {
 		result = -EBUSY;
 		goto unlock;
 	}
-	list_del_init(&timeri->ack_list);
-	list_del_init(&timeri->active_list);
 	if (timer->card && timer->card->shutdown)
 		goto unlock;
 	if (stop) {
-- 
2.17.1

