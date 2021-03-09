Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FD9332762
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhCINkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhCINko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:40:44 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8F0C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 05:40:44 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id j12so9371492pfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 05:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kw5kygfoQwlmz4PEj0VqIQ6gagYCkE2pi4eUDW+PS+E=;
        b=ABLiwSSGFxAYs7WFSkL/3pNRmIAQkcsld3ZEOEg7r2bdPqSpUCkLqDbyqtid4EO7JL
         MX+bEni+WH1ULVvIttSPq4b1LnO7h67ehNuRFlYLz0Spj/ybk9n0a4t92hJ3QJcZrE2f
         q3cZ6iD4+/ytOFK3+FqBUVMMRBfNIKsdyE8YuuwJvINSwT6z9inY29fQ3c89ysnkOhr/
         tuXh2IqVN/K/TtkvwVp8TObXqHshKUbI8wmSOf/JeFvGYrqxMiqqJGJvbFBd+Oc7Wzap
         +fg8DI1SXkG+nLb3upVxJPQMdDbBQeR+39KqHs9TOxz4A6SIjCTnCI2799z0t4IozLGS
         W17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kw5kygfoQwlmz4PEj0VqIQ6gagYCkE2pi4eUDW+PS+E=;
        b=bzjwJTOtpo/2uySRLY3FjRiFwyZv+QhRF8AOw99CQJBmQfk0H3Bm1m1SWqd/SJ3tIw
         HvEMdRAv33WVWfhVuUPQquezS4tXLoWe0kCCTzU9f8oq6P62GRCqGazpPinXeIM+YcRO
         oXsnqMsSHIAcjEmBW+juxXx9nrxim2cV7ES2t9zEJNPaYCfpHvX2kl0n+Hv00RJK8Wdb
         kBsBCOHHQDdkQAnnyy2YD1yBNF5s8dvQQjSXXXaL7+09+lFpiU2REe/O2huSUxPAPDTR
         v5GBNVKtH6J6EKBOJ03FwbxxtlGERo1BAJ7KX+SByvpI6M4txOJIyYJ4uDf2zYm3vhxR
         W38w==
X-Gm-Message-State: AOAM532ZI630Yd/h1xj+zwMujFbZXgH6l68NXAF63gVl7nOHDJoGhvdx
        Z8kZ1SRI2yO3P+Ce0jPr03Q=
X-Google-Smtp-Source: ABdhPJxuCBEvVomfaTd/FBVpg1mvCfpNq8ZnB420P52naNTEmEcfOjiJaeove/inWHSfaH+HOyzqJw==
X-Received: by 2002:a62:7bc4:0:b029:1f1:58ea:4010 with SMTP id w187-20020a627bc40000b02901f158ea4010mr20146648pfc.70.1615297243567;
        Tue, 09 Mar 2021 05:40:43 -0800 (PST)
Received: from localhost.localdomain ([209.9.72.215])
        by smtp.gmail.com with ESMTPSA id f14sm5566364pfk.92.2021.03.09.05.40.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 05:40:42 -0800 (PST)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     christian@brauner.io, axboe@kernel.dk, ebiederm@xmission.com,
        oleg@redhat.com, tglx@linutronix.de, pcc@google.com
Cc:     linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: [PATCH] exit: trigger panic when init process is set to SIGNAL_GROUP_EXIT
Date:   Tue,  9 Mar 2021 21:31:52 +0800
Message-Id: <1615296712-175334-1-git-send-email-zhaoqianligood@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qianli Zhao <zhaoqianli@xiaomi.com>

Once any init thread finds SIGNAL_GROUP_EXIT, trigger panic immediately
instead of last thread of global init has exited, and do not allow other
init threads to exit, protect task/memory state of all sub-threads for
get reliable init coredump

[   24.705376] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
[   24.705382] CPU: 4 PID: 552 Comm: init Tainted: G S         O    4.14.180-perf-g4483caa8ae80-dirty #1
[   24.705390] kernel BUG at include/linux/pid_namespace.h:98!

PID: 552   CPU: 4   COMMAND: "init"
PID: 1     CPU: 7   COMMAND: "init"
core4				core7
...				sys_exit_group()
				do_group_exit()
				    - sig->flags = SIGNAL_GROUP_EXIT
				    - zap_other_threads()
				do_exit()
				    - PF_EXITING is set
ret_to_user()
do_notify_resume()
get_signal()
    - signal_group_exit
    - goto fatal;
do_group_exit()
do_exit()
    - PF_EXITING is set
    - panic("Attempted to kill init! exitcode=0x%08x\n")
				exit_notify()
				find_alive_thread() //no alive sub-threads
				zap_pid_ns_processes()//CONFIG_PID_NS is not set
				BUG()

Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
---
We got an init crash issue, but we can't get init coredump from fulldump, we also
see BUG() triggered which calling in zap_pid_ns_processes().

From crash dump we can get the following information:
1. "Attempted to kill init",init process is killed.
- Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
2. At the same time as init crash, a BUG() triggered in other core.
- [   24.705390] kernel BUG at include/linux/pid_namespace.h:98!
3. When init thread calls exit_mm, the corresponding thread task->mm will be empty, which is not conducive to extracting coredump

To fix the issue and save complete coredump, once find init thread is set to SIGNAL_GROUP_EXIT
trigger panic immediately,and other child threads are not allowed to exit just wait for reboot

PID: 1      TASK: ffffffc973126900  CPU: 7   COMMAND: "init"
 #0 [ffffff800805ba60] perf_trace_kernel_panic_late at ffffff99ac0bcbcc
 #1 [ffffff800805bac0] die at ffffff99ac08dc64
 #2 [ffffff800805bb10] bug_handler at ffffff99ac08e398
 #3 [ffffff800805bbc0] brk_handler at ffffff99ac08529c
 #4 [ffffff800805bc80] do_debug_exception at ffffff99ac0814e4
 #5 [ffffff800805bdf0] el1_dbg at ffffff99ac083298
->Exception
    /home/work/courbet-r-stable-build/kernel/msm-4.14/include/linux/pid_namespace.h: 98
 #6 [ffffff800805be20] do_exit at ffffff99ac0c22e8
 #7 [ffffff800805be80] do_group_exit at ffffff99ac0c2658
 #8 [ffffff800805beb0] sys_exit_group at ffffff99ac0c266c
 #9 [ffffff800805bff0] el0_svc_naked at ffffff99ac083cf
->SYSCALLNO: 5e (__NR_exit_group) 

PID: 552    TASK: ffffffc9613c8f00  CPU: 4   COMMAND: "init"
 #0 [ffffff801455b870] __delay at ffffff99ad32cc14
 #1 [ffffff801455b8b0] __const_udelay at ffffff99ad32cd10
 #2 [ffffff801455b8c0] msm_trigger_wdog_bite at ffffff99ac5d5be0
 #3 [ffffff801455b980] do_msm_restart at ffffff99acccc3f8
 #4 [ffffff801455b9b0] machine_restart at ffffff99ac085dd0
 #5 [ffffff801455b9d0] emergency_restart at ffffff99ac0eb6dc
 #6 [ffffff801455baf0] panic at ffffff99ac0bd008
 #7 [ffffff801455bb70] do_exit at ffffff99ac0c257c
    /home/work/courbet-r-stable-build/kernel/msm-4.14/kernel/exit.c: 842
 #8 [ffffff801455bbd0] do_group_exit at ffffff99ac0c2644
 #9 [ffffff801455bcc0] get_signal at ffffff99ac0d1384
#10 [ffffff801455be60] do_notify_resume at ffffff99ac08b2a8
#11 [ffffff801455bff0] work_pending at ffffff99ac083b8c

---
 kernel/exit.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index ef2fb929..6b2da22 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -758,6 +758,27 @@ void __noreturn do_exit(long code)
 	validate_creds_for_do_exit(tsk);
 
 	/*
+	 * Once init group is marked for death,
+	 * panic immediately to get a useable coredump
+	 */
+	if (unlikely(is_global_init(tsk) &&
+	    signal_group_exit(tsk->signal))) {
+		spin_lock_irq(&tsk->sighand->siglock);
+		if (!(tsk->signal->flags & SIGNAL_UNKILLABLE)) {
+			tsk->signal->flags |= SIGNAL_UNKILLABLE;
+			spin_unlock_irq(&tsk->sighand->siglock);
+			panic("Attempted to kill init! exitcode=0x%08x\n",
+				tsk->signal->group_exit_code ?: (int)code);
+		} else {
+			/* init sub-thread is dying, just wait for reboot */
+			spin_unlock_irq(&tsk->sighand->siglock);
+			futex_exit_recursive(tsk);
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule();
+		}
+	}
+
+	/*
 	 * We're taking recursive faults here in do_exit. Safest is to just
 	 * leave this task alone and wait for reboot.
 	 */
@@ -776,14 +797,6 @@ void __noreturn do_exit(long code)
 	acct_update_integrals(tsk);
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
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

