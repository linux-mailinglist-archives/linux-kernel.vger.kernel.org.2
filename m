Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202C4341352
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 04:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhCSC7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 22:59:52 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:48408 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhCSC7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 22:59:36 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.232])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id AB61EE0187;
        Fri, 19 Mar 2021 10:59:33 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] futex: use wake_up_process() instead of wake_up_state()
Date:   Fri, 19 Mar 2021 10:59:20 +0800
Message-Id: <1616122760-11790-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0sYHU5PHR8aSx4eVkpNSk1KSUlMTEhCQkhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mhg6Dzo6LT8LA04dCA9WUVEQ
        MBkwCxNVSlVKTUpNSklJTExPQ05PVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISVlXWQgBWUFKT09PNwY+
X-HM-Tid: 0a78486c81952c17kusnab61ee0187
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using wake_up_process() is more simpler and friendly, 
and it is more convenient for analysis and statistics

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 kernel/futex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index e68db77..078a1f9
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1820,7 +1820,7 @@ void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
 
 	q->lock_ptr = &hb->lock;
 
-	wake_up_state(q->task, TASK_NORMAL);
+	wake_up_process(q->task);
 }
 
 /**
-- 
2.7.4

