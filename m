Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59185312F2E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhBHKiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:38:20 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61707 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbhBHK0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:26:45 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 118AQ0io058112;
        Mon, 8 Feb 2021 19:26:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Mon, 08 Feb 2021 19:26:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 118APtcd057991
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Feb 2021 19:26:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v5] lockdep: Allow tuning tracing capacity constants.
Date:   Mon,  8 Feb 2021 19:25:51 +0900
Message-Id: <20210208102551.5256-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since syzkaller continues various test cases until the kernel crashes,
syzkaller tends to examine more locking dependencies than normal systems.
As a result, syzbot is reporting that the fuzz testing was terminated
due to hitting upper limits lockdep can track [1] [2] [3]. Since analysis
via /proc/lockdep* did not show any obvious culprit [4] [5], we have no
choice but allow tuning tracing capacity constants.

[1] https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
[2] https://syzkaller.appspot.com/bug?id=381cb436fe60dc03d7fd2a092b46d7f09542a72a
[3] https://syzkaller.appspot.com/bug?id=a588183ac34c1437fc0785e8f220e88282e5a29f
[4] https://lkml.kernel.org/r/4b8f7a57-fa20-47bd-48a0-ae35d860f233@i-love.sakura.ne.jp
[5] https://lkml.kernel.org/r/1c351187-253b-2d49-acaf-4563c63ae7d2@i-love.sakura.ne.jp

Reported-by: syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com>
References: https://lkml.kernel.org/r/1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
---
 kernel/locking/lockdep.c           |  2 +-
 kernel/locking/lockdep_internals.h |  8 +++---
 lib/Kconfig.debug                  | 40 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bdaf4829098c..65b3777e8089 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1391,7 +1391,7 @@ static int add_lock_to_list(struct lock_class *this,
 /*
  * For good efficiency of modular, we use power of 2
  */
-#define MAX_CIRCULAR_QUEUE_SIZE		4096UL
+#define MAX_CIRCULAR_QUEUE_SIZE		(1UL << CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS)
 #define CQ_MASK				(MAX_CIRCULAR_QUEUE_SIZE-1)
 
 /*
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index de49f9e1c11b..ecb8662e7a4e 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -99,16 +99,16 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 #define MAX_STACK_TRACE_ENTRIES	262144UL
 #define STACK_TRACE_HASH_SIZE	8192
 #else
-#define MAX_LOCKDEP_ENTRIES	32768UL
+#define MAX_LOCKDEP_ENTRIES	(1UL << CONFIG_LOCKDEP_BITS)
 
-#define MAX_LOCKDEP_CHAINS_BITS	16
+#define MAX_LOCKDEP_CHAINS_BITS	CONFIG_LOCKDEP_CHAINS_BITS
 
 /*
  * Stack-trace: tightly packed array of stack backtrace
  * addresses. Protected by the hash_lock.
  */
-#define MAX_STACK_TRACE_ENTRIES	524288UL
-#define STACK_TRACE_HASH_SIZE	16384
+#define MAX_STACK_TRACE_ENTRIES	(1UL << CONFIG_LOCKDEP_STACK_TRACE_BITS)
+#define STACK_TRACE_HASH_SIZE	(1 << CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS)
 #endif
 
 /*
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7937265ef879..4cb84b499636 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1332,6 +1332,46 @@ config LOCKDEP
 config LOCKDEP_SMALL
 	bool
 
+config LOCKDEP_BITS
+	int "Bitsize for MAX_LOCKDEP_ENTRIES"
+	depends on LOCKDEP && !LOCKDEP_SMALL
+	range 10 30
+	default 15
+	help
+	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
+
+config LOCKDEP_CHAINS_BITS
+	int "Bitsize for MAX_LOCKDEP_CHAINS"
+	depends on LOCKDEP && !LOCKDEP_SMALL
+	range 10 30
+	default 16
+	help
+	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
+
+config LOCKDEP_STACK_TRACE_BITS
+	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
+	depends on LOCKDEP && !LOCKDEP_SMALL
+	range 10 30
+	default 19
+	help
+	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
+
+config LOCKDEP_STACK_TRACE_HASH_BITS
+	int "Bitsize for STACK_TRACE_HASH_SIZE"
+	depends on LOCKDEP && !LOCKDEP_SMALL
+	range 10 30
+	default 14
+	help
+	  Try increasing this value if you need large MAX_STACK_TRACE_ENTRIES.
+
+config LOCKDEP_CIRCULAR_QUEUE_BITS
+	int "Bitsize for elements in circular_queue struct"
+	depends on LOCKDEP
+	range 10 30
+	default 12
+	help
+	  Try increasing this value if you hit "lockdep bfs error:-1" warning due to __cq_enqueue() failure.
+
 config DEBUG_LOCKDEP
 	bool "Lock dependency engine debugging"
 	depends on DEBUG_KERNEL && LOCKDEP
-- 
2.18.4

