Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB6344F6F9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 06:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhKNF7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 00:59:43 -0500
Received: from smtpbg604.qq.com ([59.36.128.82]:45714 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232939AbhKNF7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 00:59:42 -0500
X-QQ-mid: bizesmtp41t1636869333tlg1bn5s
Received: from localhost.localdomain (unknown [125.69.41.88])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 14 Nov 2021 13:55:31 +0800 (CST)
X-QQ-SSF: 01000000002000C0F000B00A0000000
X-QQ-FEAT: 7nM+eLZz0bZ/0iG06QaU/Zg9CREKbPpcyJSPGzKP8pxr0+Fy5gaTGdRGgelnW
        L6XmdApV9MjTdmUx7wzbvoTOcsPqQHZUhrxEVzzm311WTZYzSIRe8raE67rRQhjKvRCOCR+
        SN8opLf0+A8DIC1gX5iK+CM2KxRxea0KZ6vDA8maSOCE3XgY16wD+hZ8GpC//QkVycxA3TU
        sNlZtZ4VuuZQgn6mfOfuDtT76cAHGB/fak/exQSPGv1zYA0+qw2LFf3ffBdEUKNh2UtmtuU
        V/560drfEvdgMHdMe0Jn1+0Yuwp2Ni0M84nfwIItje5xMeVt2AP1Ld0tnE4b/2JagmcbaZk
        VeGw/JmjANDafMMfrQzeFqPYH3q/A==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] sched: remove unneeded semicolon
Date:   Sun, 14 Nov 2021 13:55:29 +0800
Message-Id: <20211114055529.221612-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The semicolon after `}' is unneeded. So, just remove it.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 kernel/sched/core_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 517f72b008f5..f945b0c373db 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -203,7 +203,7 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 	default:
 		err = -EINVAL;
 		goto out;
-	};
+	}
 
 	if (type == PIDTYPE_PID) {
 		__sched_core_set(task, cookie);
-- 
2.33.0

