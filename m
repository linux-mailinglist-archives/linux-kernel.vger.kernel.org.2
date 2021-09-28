Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2DD41B21E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241295AbhI1OcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:32:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36036 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241265AbhI1OcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:32:07 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632839426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=cRzCqfRi39bCLXCOKbAa6ygzqRXl17QXnGvNdRp1Xlw=;
        b=y8U+/g+L1NrYNPkt2L+6Quiy1ooZHDUSke0RlJXylYWUTIVREjHe1400Uf3U5QIS3vjiDT
        KWS/WOmhQwqHUFMFCSoD71alBh7NH5hPgNgy/vVXzWoQoqHywucVV0Hn+D6VYmVpPCkSdH
        lmeMu2SiN2ElvaG3yL+lGYZ1LRLj9haojYsj2PWZwTWiwHigx7s0xYaI3Va59tr7bmzk+j
        sMFKXF4lnZKnS2nco6YL4oinkNqXwpdz5m+cDflxltgBRGgMqvzACYOwFmdzMr1dAGe05q
        83iEe0E6Jtoy+mq0yfVC6QSfYirWoT18iTtNWWb1zzOH2ag2tl04jE1HuPt52g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632839426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=cRzCqfRi39bCLXCOKbAa6ygzqRXl17QXnGvNdRp1Xlw=;
        b=fqC6yKP/yzXrljCV7mr0aCvBS3tf0BhKmzLSk/9iDuN4jVuuGxEYzjwLYFw8hT5Dv8CGpE
        WmvIv5yF1+i+bBCg==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Peter Oskolkov <posk@posk.io>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: sched: Remove pointless preemption disable in sched_submit_work()
Date:   Tue, 28 Sep 2021 16:30:26 +0200
Message-ID: <87sfxoai2l.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither wq_worker_sleeping() nor io_wq_worker_sleeping() require to be invoked
with preemption disabled:

  - The worker flag checks operations only need to be serialized against
    the worker thread itself.

  - The accounting and worker pool operations are serialized with locks.

which means that disabling preemption has neither a reason nor a
value. Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c |    2 --
 1 file changed, 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6327,12 +6327,10 @@ static inline void sched_submit_work(str
 	 * requires it.
 	 */
 	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
-		preempt_disable();
 		if (task_flags & PF_WQ_WORKER)
 			wq_worker_sleeping(tsk);
 		else
 			io_wq_worker_sleeping(tsk);
-		preempt_enable_no_resched();
 	}
 
 	if (tsk_is_pi_blocked(tsk))
