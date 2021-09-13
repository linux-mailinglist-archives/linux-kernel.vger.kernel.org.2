Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2FB4096A0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 16:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345830AbhIMO4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 10:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348581AbhIMOyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 10:54:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3E9160F4C;
        Mon, 13 Sep 2021 14:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631544817;
        bh=p8UufsOAlWSGbHBx1QuHSYNdlIZ1/cc8QdkENxgjmzE=;
        h=From:To:Cc:Subject:Date:From;
        b=ot7U21ZNxcCOzhT7OMtmxg0NwBx6P6ES6edjWR6z4khq9r01VQU3PYKEaAFt7geYM
         ay4sc20A94Y4g7u9wluzEJJ7EwiNTv+f1bGn2Tx/6MvlBU7aJUtZSSMgD16X4OHkue
         5D4Jitr4iNBKMIgj3t/6mF4tfN+OFkikd7Evxsb8OLJkpCNZfrhXyjnPodpYXOEyuO
         2vaheca3GSTGTXNxQ4l9LJVcRKY8tY9DEeyteZKZ7ZLyBjCfiUKZ3x6T6foXc+98A6
         doQLPWO74CanJ5aco3whgqLLGpJWvk0UCNAApLti84jVqiYwqfTYYUBN7Gno9X+B/k
         ckmIfrM4kFqzQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Victor Stinner <vstinner@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] posix-cpu-timers: Fix spuriously armed 0-value itimer
Date:   Mon, 13 Sep 2021 16:53:32 +0200
Message-Id: <20210913145332.232023-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resetting/stopping an itimer eventually leads to it being reprogrammed
with an actual "0" value. As a result the itimer expires on the next
tick, triggering an unexpected signal.

To fix this, make sure that
struct signal_struct::it[CPUCLOCK_PROF/VIRT]::expires is set to 0 when
setitimer() passes a 0 it_value, indicating that the timer must stop.

Reported-by: Victor Stinner <vstinner@redhat.com>
Fixes: 406dd42bd1ba ("posix-cpu-timers: Force next expiration recalc after itimer reset")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/posix-cpu-timers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index ee736861b18f..643d412ac623 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1404,7 +1404,8 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clkid,
 			}
 		}
 
-		*newval += now;
+		if (*newval)
+			*newval += now;
 	}
 
 	/*
-- 
2.25.1

