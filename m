Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A63B33F0CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCQM7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 08:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhCQM7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:59:49 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5CBC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 05:59:49 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h3so1043356pfr.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S4y6Xmo5odpALLpT9mpzYc5WoHyBefdNU+Sii/iRNLw=;
        b=pWAuEodQrwpG0zp75JlHGLMW08a9X4pPGgWpGXXYWBBv9++TUuCwACoITVl2oYcFCm
         xSN8a4sjtQ8Wn63bgPUn3jYjMRs8TLsW02GblBTCsm9XB0IxafR9Nz7uZuf+SPUHYJ+I
         JsT/wUMkVIPhsLCRdje+uN5S7fW7IhGjv2Aor5lS8bmd0d5fvq6aHJOLuKx/EmglHP6z
         1c/jRXSZJAloDMsFE5+JCva2Z0vYuAUGoeuoNt1+FM/bpJAMDCtFcqQrSw5O2vd2HGf+
         PZXghNNwRFvxBDP/tiXY3tI+x5OomrUB79VQa6Ue/MYxv/DW5P6vPw9JCw+1e/oN4Rja
         e3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S4y6Xmo5odpALLpT9mpzYc5WoHyBefdNU+Sii/iRNLw=;
        b=q/x8q/yi1nrE7GkWbnECoAKn3lwvM4/FH2g58E+ATM54HA03jbRoKC15hZzv1aFIHP
         pY2wQ3E4zLvOuZQNrwg5fIbSUdaT5dOh3rWCW2jHW/wjRfXa6rwE2ga/ncK768BfB8Ud
         WdKX97YDcCZPj9n/zXbwTUyZOUasz9SJleY0K4K79AJuj+RfGSzzAe+ithZ2+vEYaaHd
         LLTQQBjCmjuufACaquQ0SAPZCJZ2eLdtsz+tDwLyx4M7ElOp3CH8lRc7sBTQr+YJ7IzC
         jVdiiAPze60eHQF/smgkttHW9reFGgaQuiv/wm/Y7XUqeu/g180u45TDzdiT7XmG07Qs
         bnhw==
X-Gm-Message-State: AOAM531QaSjf7T6m9O7SqRK6gTET6Rciga9rAJZkmnbfHPvXLTgLT//g
        sXhS32hISHyumAvn9ajtHy0=
X-Google-Smtp-Source: ABdhPJx6Mu4swRslmkDKblqci9Rk+njcKvwSbTb66DM0o+BFSIM20mYXLAvCgYbqHlnBxHiRG2ggpQ==
X-Received: by 2002:a62:e70f:0:b029:1fd:6bae:235d with SMTP id s15-20020a62e70f0000b02901fd6bae235dmr4218558pfh.43.1615985988958;
        Wed, 17 Mar 2021 05:59:48 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x190sm19399801pfx.60.2021.03.17.05.59.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Mar 2021 05:59:48 -0700 (PDT)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     christian@brauner.io, axboe@kernel.dk, ebiederm@xmission.com,
        oleg@redhat.com, tglx@linutronix.de, pcc@google.com
Cc:     linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: [PATCH V3] exit: trigger panic when global init has exited
Date:   Wed, 17 Mar 2021 20:51:00 +0800
Message-Id: <1615985460-112867-1-git-send-email-zhaoqianligood@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qianli Zhao <zhaoqianli@xiaomi.com>

When init sub-threads running on different CPUs exit at the same time,
zap_pid_ns_processe()->BUG() may be happened.
And every thread status is abnormal after exit(PF_EXITING set,task->mm=NULL etc),
which makes it difficult to parse coredump from fulldump normally.
In order to fix the above problem, when any one init has been set to SIGNAL_GROUP_EXIT,
trigger panic immediately, and prevent other init threads from continuing to exit

[   24.705376] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
[   24.705382] CPU: 4 PID: 552 Comm: init Tainted: G S         O    4.14.180-perf-g4483caa8ae80-dirty #1
[   24.705390] kernel BUG at include/linux/pid_namespace.h:98!

PID: 552   CPU: 4   COMMAND: "init"
PID: 1     CPU: 7   COMMAND: "init"
core4                           core7
...                             sys_exit_group()
                                do_group_exit()
                                   - sig->flags = SIGNAL_GROUP_EXIT
                                   - zap_other_threads()
                                do_exit() //PF_EXITING is set
ret_to_user()
do_notify_resume()
get_signal()
    - signal_group_exit
    - goto fatal;
do_group_exit()
do_exit() //PF_EXITING is set
    - panic("Attempted to kill init! exitcode=0x%08x\n")
                                exit_notify()
                                find_alive_thread() //no alive sub-threads
                                zap_pid_ns_processes()//CONFIG_PID_NS is not set
                                BUG()

Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
---
V3:
- Use group_dead instead of thread_group_empty() to test single init exit.

V2:
- Changelog update
- Remove wrong useage of SIGNAL_UNKILLABLE. 
- Add thread_group_empty() test to handle single init thread exit
---
 kernel/exit.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 04029e3..32b74e4 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -766,6 +766,17 @@ void __noreturn do_exit(long code)
 
 	validate_creds_for_do_exit(tsk);
 
+	group_dead = atomic_dec_and_test(&tsk->signal->live);
+	/*
+	 * If global init has exited,
+	 * panic immediately to get a useable coredump.
+	 */
+	if (unlikely(is_global_init(tsk) &&
+	    (group_dead || (tsk->signal->flags & SIGNAL_GROUP_EXIT)))) {
+			panic("Attempted to kill init! exitcode=0x%08x\n",
+				tsk->signal->group_exit_code ?: (int)code);
+	}
+
 	/*
 	 * We're taking recursive faults here in do_exit. Safest is to just
 	 * leave this task alone and wait for reboot.
@@ -784,16 +795,7 @@ void __noreturn do_exit(long code)
 	if (tsk->mm)
 		sync_mm_rss(tsk->mm);
 	acct_update_integrals(tsk);
-	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
-		/*
-		 * If the last thread of global init has exited, panic
-		 * immediately to get a useable coredump.
-		 */
-		if (unlikely(is_global_init(tsk)))
-			panic("Attempted to kill init! exitcode=0x%08x\n",
-				tsk->signal->group_exit_code ?: (int)code);
-
 #ifdef CONFIG_POSIX_TIMERS
 		hrtimer_cancel(&tsk->signal->real_timer);
 		exit_itimers(tsk->signal);
-- 
1.9.1

