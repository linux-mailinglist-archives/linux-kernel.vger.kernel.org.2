Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D773F5C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhHXK0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:26:48 -0400
Received: from mx425.baidu.com ([119.249.100.233]:3906 "EHLO mx425.baidu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235905AbhHXK0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:26:47 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Aug 2021 06:26:46 EDT
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by mx425.baidu.com (Postfix) with ESMTP id 277D1125833B6;
        Tue, 24 Aug 2021 18:19:16 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by bjhw-sys-rpm015653cc5.bjhw.baidu.com (Postfix) with ESMTP id 1BC0CD9932;
        Tue, 24 Aug 2021 18:19:16 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        lirongqing@baidu.com
Subject: [PATCH] sched/core: return prio_less() directly in __sched_core_less
Date:   Tue, 24 Aug 2021 18:19:16 +0800
Message-Id: <1629800356-45550-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

return prio_less() directly to avoid unnecessary checking

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 kernel/sched/core.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d9ff40..73478c9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -140,10 +140,7 @@ static inline bool __sched_core_less(struct task_struct *a, struct task_struct *
 		return false;
 
 	/* flip prio, so high prio is leftmost */
-	if (prio_less(b, a, task_rq(a)->core->core_forceidle))
-		return true;
-
-	return false;
+	return prio_less(b, a, task_rq(a)->core->core_forceidle);
 }
 
 #define __node_2_sc(node) rb_entry((node), struct task_struct, core_node)
-- 
1.7.1

