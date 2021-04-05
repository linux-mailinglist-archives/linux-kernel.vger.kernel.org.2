Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D052D353C61
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 10:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhDEI0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 04:26:04 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:9974 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhDEI0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 04:26:03 -0400
Received: from wanjb-KLV-WX9.. (unknown [180.111.237.208])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 01F6B9801F0;
        Mon,  5 Apr 2021 16:25:51 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] kernel: sched: Remove unnecessary struct declaration" 
Date:   Mon,  5 Apr 2021 16:25:41 +0800
Message-Id: <20210405082542.160279-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSkpNTh5OSB1KGBhDVkpNSkxNSkpKTk1PS0JVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxg6Eww6Mj8QCi9RThMiHSEp
        VgMKC1ZVSlVKTUpMTUpKSk5NTUxPVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlK
        Q0tVSkpKVUlITFVJS0NZV1kIAVlBSUtNSDcG
X-HM-Tid: 0a78a1236b73d992kuws01f6b9801f0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct sg_lb_stats is defined at 8043rd line.
The declaration and the definition are all independent on the MACRO.
The declaration here is unnecessary. Remove it.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..94e035da90c8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8609,9 +8609,6 @@ static inline enum fbq_type fbq_classify_rq(struct rq *rq)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
-
-struct sg_lb_stats;
-
 /*
  * task_running_on_cpu - return 1 if @p is running on @cpu.
  */
-- 
2.30.2

