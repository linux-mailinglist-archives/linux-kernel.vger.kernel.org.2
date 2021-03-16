Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB1133D2D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhCPLU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:20:57 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:59238 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhCPLUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:20:20 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id 64A22E0457;
        Tue, 16 Mar 2021 19:20:14 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] sched: swait: use wake_up_process() instead of wake_up_state()
Date:   Tue, 16 Mar 2021 19:20:02 +0800
Message-Id: <1615893602-22260-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZS0tJTRhLTE5DHU8fVkpNSk5DQkhNSk9DTUJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxQ6Qgw*Ij8PF0oRDhEOGkk6
        Sk0KFD1VSlVKTUpOQ0JITUpOSEhOVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKQklNNwY+
X-HM-Tid: 0a783ac3d0c32c17kusn64a22e0457
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why not just use wake_up_process().

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 kernel/sched/swait.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index e1c655f..7a24925
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -69,7 +69,7 @@ void swake_up_all(struct swait_queue_head *q)
 	while (!list_empty(&tmp)) {
 		curr = list_first_entry(&tmp, typeof(*curr), task_list);
 
-		wake_up_state(curr->task, TASK_NORMAL);
+		wake_up_process(curr->task);
 		list_del_init(&curr->task_list);
 
 		if (list_empty(&tmp))
-- 
2.7.4

