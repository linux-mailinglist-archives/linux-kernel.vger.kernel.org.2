Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA74539C803
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 14:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhFEMGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 08:06:36 -0400
Received: from m12-12.163.com ([220.181.12.12]:52579 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhFEMGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 08:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=UNfsF8jMsTP64BqsBI
        EP7j+b7la3dUXzBpaMkLndybI=; b=DWf4uxOFBr39nBzOChjXEUkSJ3Be6OD8aV
        REhdmTGuC1cybXFlHXHha/XTiRIlHv6fzSUZp1RmUjf1YpZbzped2LpNiQm2nYyB
        l9dnvkWZMbRT31ppzCtFtKeCKQb2yAjk2H5siag0PPDFL+zRqbF9JHO0KuV+fnkS
        PIk4VjymU=
Received: from localhost.localdomain (unknown [117.139.248.43])
        by smtp8 (Coremail) with SMTP id DMCowAAXsjJTZLtglnzDIA--.10967S2;
        Sat, 05 Jun 2021 19:47:32 +0800 (CST)
From:   Hailong Liu <liuhailongg6@163.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-kernel@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [PATCH v2] sched/debug:fix stale comments of sched_debug
Date:   Sat,  5 Jun 2021 19:47:19 +0800
Message-Id: <20210605114719.70818-1-liuhailongg6@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DMCowAAXsjJTZLtglnzDIA--.10967S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyxZFW3WF4kJw45CryDZFb_yoW8AF4rpa
        s8WFyUGFyUGF1rtryrA3y8WryfuF97Ja4aqFy7u345ZryrGa1Sqry5tFW7KF1UZrWrAF4f
        uFWYg342gF1jy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j773kUUUUU=
X-Originating-IP: [117.139.248.43]
X-CM-SenderInfo: xolxxtxlor0wjjw6il2tof0z/xtbBCgaoYF3l-syT5gAAs7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hailong Liu <liu.hailong6@zte.com.cn>

Since commit 'd27e9ae2f24(sched: Move /proc/sched_debug to debugfs)'
file /proc/sched_debug file no longer exists, so update the comments
and the dependencies and help text of CONFIG_SCHED_DEBUG.

Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
---

changes since v1:
 - check and updated the dependencies of CONFIG_SCHED_DEBUG which
   suggested by Andy Shevchenko and Peter Zijlstra.
---
 kernel/sched/debug.c | 2 +-
 lib/Kconfig.debug    | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

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
index 678c13967580..9c1fb07a6950 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1163,12 +1163,13 @@ menu "Scheduler Debugging"
 
 config SCHED_DEBUG
 	bool "Collect scheduler debugging info"
-	depends on DEBUG_KERNEL && PROC_FS
+	depends on DEBUG_KERNEL && PROC_FS && DEBUG_FS
 	default y
 	help
-	  If you say Y here, the /proc/sched_debug file will be provided
-	  that can help debug the scheduler. The runtime overhead of this
-	  option is minimal.
+	  If you say Y here, the dictory debugfs/sched/ with various
+	  scheduler-related debug files (such as debug, features, etc.)
+	  and files /proc/pid/sched will be provided, that can help debug
+	  the scheduler. The runtime overhead of this option is minimal.
 
 config SCHED_INFO
 	bool
-- 
2.17.1


