Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5623AFFE7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhFVJJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:09:43 -0400
Received: from mail-m17639.qiye.163.com ([59.111.176.39]:39648 "EHLO
        mail-m17639.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhFVJJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:09:42 -0400
DKIM-Signature: a=rsa-sha256;
        b=kW3MYcZqELPXs3Wj/0bVLvJgzqDlkRhKLz1c3NKqkhUc8pUtSMoIMLHaP4nkHWX/187NZ0Bz4SQaZhsXQqp7ALzkstM8dnaJkrZQDzeSMFOIIjFBV7AjlwvHgdwW68j8RgXgLct2F6d9Zqy6iHku1EKTGdQJEfnzHk5InX5e2XA=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=UNitqia/EPNbGctZz1frhVJ7NfVvBMXSZg12fK1tcbM=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.232])
        by mail-m17639.qiye.163.com (Hmail) with ESMTPA id 2537C380294;
        Tue, 22 Jun 2021 17:07:25 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Wang Qing <wangqing@vivo.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/2] watchdog: support watchdog hrtimer suspend when CPU suspend
Date:   Tue, 22 Jun 2021 17:06:47 +0800
Message-Id: <1624352816-26450-3-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624352816-26450-1-git-send-email-wangqing@vivo.com>
References: <1624352816-26450-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkJKS1ZDH05LQ0ofShlITUhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PlE6MDo*DT9JCD4*Ojg8KzIf
        CjwKCSpVSlVKTUlPSE5JQ09OTE5CVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISVlXWQgBWUFJT01CNwY+
X-HM-Tid: 0a7a32f96e84d994kuws2537c380294
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the watchdog hrtimer doesn’t have to work while CPU is suspend. Otherwise 
the maximum suspend time of the CPU is 4s if enable lockup detector,
which is unacceptable on some products.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 kernel/watchdog.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7c39790..f68591f
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -455,7 +455,8 @@ static void watchdog_enable(unsigned int cpu)
 	 * Start the timer first to prevent the NMI watchdog triggering
 	 * before the timer has a chance to fire.
 	 */
-	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
+	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD
+			| HRTIMER_MODE_SUSPEND);
 	hrtimer->function = watchdog_timer_fn;
 	hrtimer_start(hrtimer, ns_to_ktime(sample_period),
 		      HRTIMER_MODE_REL_PINNED_HARD);
-- 
2.7.4

