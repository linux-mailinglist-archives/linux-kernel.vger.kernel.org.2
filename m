Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60ED41938D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhI0LsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:48:18 -0400
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:44651 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234146AbhI0LsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:48:16 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 3AD871B02
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:46:37 +0100 (IST)
Received: (qmail 12512 invoked from network); 27 Sep 2021 11:46:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Sep 2021 11:46:36 -0000
Date:   Mon, 27 Sep 2021 12:46:35 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/fair: Null terminate buffer when updating
 tunable_scaling
Message-ID: <20210927114635.GH3959@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch null-terminates the temporary buffer in sched_scaling_write()
so kstrtouint() does not return failure and checks the value is valid.

Before
$ cat /sys/kernel/debug/sched/tunable_scaling
1
$ echo 0 > /sys/kernel/debug/sched/tunable_scaling
-bash: echo: write error: Invalid argument
$ cat /sys/kernel/debug/sched/tunable_scaling
1

After
$ cat /sys/kernel/debug/sched/tunable_scaling
1
$ echo 0 > /sys/kernel/debug/sched/tunable_scaling
$ cat /sys/kernel/debug/sched/tunable_scaling
0
$ echo 3 > /sys/kernel/debug/sched/tunable_scaling
-bash: echo: write error: Invalid argument

Fixes: 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/debug.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 49716228efb4..17a653b67006 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -173,16 +173,22 @@ static ssize_t sched_scaling_write(struct file *filp, const char __user *ubuf,
 				   size_t cnt, loff_t *ppos)
 {
 	char buf[16];
+	unsigned int scaling;
 
 	if (cnt > 15)
 		cnt = 15;
 
 	if (copy_from_user(&buf, ubuf, cnt))
 		return -EFAULT;
+	buf[cnt] = '\0';
 
-	if (kstrtouint(buf, 10, &sysctl_sched_tunable_scaling))
+	if (kstrtouint(buf, 10, &scaling))
 		return -EINVAL;
 
+	if (scaling >= SCHED_TUNABLESCALING_END)
+		return -EINVAL;
+
+	sysctl_sched_tunable_scaling = scaling;
 	if (sched_update_scaling())
 		return -EINVAL;
 
