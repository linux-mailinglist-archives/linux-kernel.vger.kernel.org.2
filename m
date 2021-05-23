Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7146A38DB46
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhEWNkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 09:40:22 -0400
Received: from mx421.baidu.com ([119.249.100.229]:54973 "EHLO mx423.baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231761AbhEWNkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 09:40:17 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 May 2021 09:40:16 EDT
Received: from unknown.domain.tld (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by mx423.baidu.com (Postfix) with ESMTP id EB9A916E00444;
        Sun, 23 May 2021 21:31:30 +0800 (CST)
From:   Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
To:     peterz@infradead.org, vincent.donnefort@arm.com,
        valentin.schneider@arm.com, mingo@kernel.org, bristot@redhat.com,
        npiggin@gmail.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] cpu/hotplug: simplify access percpu cpuhp_state
Date:   Sun, 23 May 2021 21:31:30 +0800
Message-Id: <1621776690-13264-1-git-send-email-yuanzhaoxiong@baidu.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is unnecessary to invoke per_cpu_ptr() function everytime to access
percpu cpuhp_state and use the variable st instead.

Signed-off-by: Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
---
 kernel/cpu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index e538518..2942cb4 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -961,7 +961,7 @@ static int takedown_cpu(unsigned int cpu)
 	int err;
 
 	/* Park the smpboot threads */
-	kthread_park(per_cpu_ptr(&cpuhp_state, cpu)->thread);
+	kthread_park(st->thread);
 
 	/*
 	 * Prevent irq alloc/free while the dying cpu reorganizes the
@@ -977,7 +977,7 @@ static int takedown_cpu(unsigned int cpu)
 		/* CPU refused to die */
 		irq_unlock_sparse();
 		/* Unpark the hotplug thread so we can rollback there */
-		kthread_unpark(per_cpu_ptr(&cpuhp_state, cpu)->thread);
+		kthread_unpark(st->thread);
 		return err;
 	}
 	BUG_ON(cpu_online(cpu));
-- 
1.7.1

