Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8197394EFC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 04:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhE3CzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 22:55:20 -0400
Received: from m12-14.163.com ([220.181.12.14]:54278 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229569AbhE3CzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 22:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=7LznpFnzYucJI9CvaJ
        1q/0wSgNVodqKhOk4SiGmEd5A=; b=afKbJG/lHkuV5QFVJopelOYYKkFLF7e70W
        FBuLdHygaLwENczOgAEdc0jKXodYkmoFhAfWZcHPVEoqZ1Xi9XNNKfadzgoaW+gX
        B73NoMAjhV4C8JIXzF0djbny2nOVkTPfcUVCTjjDw1qi6kUmBq1h3lzaigXWICB1
        vCAU501tU=
Received: from localhost.localdomain (unknown [36.170.33.212])
        by smtp10 (Coremail) with SMTP id DsCowAAnLz_X_bJghogZLw--.9163S2;
        Sun, 30 May 2021 10:52:08 +0800 (CST)
From:   Hailong Liu <liuhailongg6@163.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-kernel@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [PATCH] sched/debug:fix stale comments of sched_debug
Date:   Sun, 30 May 2021 10:51:45 +0800
Message-Id: <20210530025145.13527-1-liuhailongg6@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DsCowAAnLz_X_bJghogZLw--.9163S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1DWrWrGFWDGryxZw1xuFg_yoWkCrcEyw
        1rGr18ur1DArWUXrW7Xrs5ZFZ3ua1jvF95Zr1SqFy2qrWUtF98XrZ8uF1kJF1rW39rCrZ3
        uFyvqF9Yyr1j9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0LYFJUUUUU==
X-Originating-IP: [36.170.33.212]
X-CM-SenderInfo: xolxxtxlor0wjjw6il2tof0z/1tbiPRiiYFSIkn8YfQAAsz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hailong Liu <liu.hailong6@zte.com.cn>

Now /proc/sched_debug has been moved to debugfs, so make the comments
consistent with it.

Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
---
 kernel/sched/debug.c | 2 +-
 lib/Kconfig.debug    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 9c882f20803e..4cbd6d602829 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -9,7 +9,7 @@
 #include "sched.h"
 
 /*
- * This allows printing both to /proc/sched_debug and
+ * This allows printing both to debugfs/sched/debug and
  * to the console
  */
 #define SEQ_printf(m, x...)			\
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 678c13967580..bb4bc59b0920 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1166,7 +1166,7 @@ config SCHED_DEBUG
 	depends on DEBUG_KERNEL && PROC_FS
 	default y
 	help
-	  If you say Y here, the /proc/sched_debug file will be provided
+	  If you say Y here, the debugfs/sched/debug file will be provided
 	  that can help debug the scheduler. The runtime overhead of this
 	  option is minimal.
 
-- 
2.17.1

