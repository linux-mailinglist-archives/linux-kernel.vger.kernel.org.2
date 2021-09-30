Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CCB41D3E5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 09:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348498AbhI3HHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 03:07:42 -0400
Received: from mx316.baidu.com ([180.101.52.236]:48528 "EHLO
        njjs-sys-mailin05.njjs.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233661AbhI3HHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 03:07:41 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Sep 2021 03:07:40 EDT
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by njjs-sys-mailin05.njjs.baidu.com (Postfix) with ESMTP id 32270CF80045;
        Thu, 30 Sep 2021 14:59:14 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by bjhw-sys-rpm015653cc5.bjhw.baidu.com (Postfix) with ESMTP id 14E46D9932;
        Thu, 30 Sep 2021 14:59:14 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     linux-kernel@vger.kernel.org, lirongqing@baidu.com,
        mingo@redhat.com, peterz@infradead.org
Subject: [PATCH] sched/fair: Drop the redundant setting of recent_used_cpu
Date:   Thu, 30 Sep 2021 14:59:14 +0800
Message-Id: <1632985154-12890-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

recent_used_cpu has been set to prev before check

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 kernel/sched/fair.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7b9fe8c..ec42eaa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6437,14 +6437,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    cpus_share_cache(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
-	    asym_fits_capacity(task_util, recent_used_cpu)) {
-		/*
-		 * Replace recent_used_cpu with prev as it is a potential
-		 * candidate for the next wake:
-		 */
-		p->recent_used_cpu = prev;
+	    asym_fits_capacity(task_util, recent_used_cpu))
 		return recent_used_cpu;
-	}
 
 	/*
 	 * For asymmetric CPU capacity systems, our domain of interest is
-- 
1.7.1

