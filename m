Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F1A3492F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhCYNRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhCYNRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:17:13 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBDEC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 06:17:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id l1so1755472pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 06:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E8R/uv85zPM3yGP2/tFWyzAhiP++yYtTCdREeByl7KI=;
        b=CHCSKCxbgD75vPy7GBmaC+lu5Gdm/xpjvojVhcyniq7PoE4xTJuXHj2xevxFtHTCNW
         UEKT37DVZ7WcRdjA7C1CAlZc5MhFKkYPAY1t60r0FyfzWNcDitAryEFs0J1qxZBleUx3
         o7xee5TlGpwgr2/KMW7p1oPBv2YfiP5kUetJDKR9O7EcMm2jtBEfFG0bZJp9LmEdFWxW
         OVT6M0hJqlK48SYggDqs5gGauRHSCjKdeUCOTySP2cLjnl2FnGX0UAC9QQ5plAjdgKXZ
         I29UkSYU7Rljj6gUTZZ6zBo80qRfX+XkNlSXIaBosQFVJaJjsp6mOLj+/lqcKRi8yng/
         TLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E8R/uv85zPM3yGP2/tFWyzAhiP++yYtTCdREeByl7KI=;
        b=scPnewVXLg7Lgeak7DKIf/EF3WV6liliVraAK9WAW74TXnbhL8NOHDPB7bBaBF/LDj
         SwpCgI0/WX4Bsyi3lhtYYcLCs7yRvul68VvSCDT6MjF52ncA8iLr0Q5zp5m37jn3K1/S
         v8XI1z9e0pqCUCPg4rwg+Hdb9whOJR/RGerTnefPKCg0dwPApq8r/zc13+0wbHtmXGNP
         GE4tUx56XFJuJRnIPGDON+Wp45xz6IrGWNmHu5ILx2QmZG8sUrSWM0UQnz77b4Zzf4z5
         LUtxpcra1GAfxpL/IBxlZUtQnsFAMvPm+8V8y1qX+iyKLk3dlCNpVQbjLsUbucxHbUTQ
         TOVQ==
X-Gm-Message-State: AOAM532QkE+B8eVkjcf/XJYJ6qEwFJSwVyTO1QCurA0Conn6zfSL164a
        XzaXDMpRfeRECe7slazeOUk=
X-Google-Smtp-Source: ABdhPJw3Ic8tUJ2aS7Jsk1SSYArmiRvtfKvVoWJgvx1GdeMSm6uK4kR76zy6g+sCheTo9uJOsvFVbA==
X-Received: by 2002:a63:d848:: with SMTP id k8mr7347767pgj.72.1616678226501;
        Thu, 25 Mar 2021 06:17:06 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id i22sm5566963pjz.56.2021.03.25.06.17.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Mar 2021 06:17:05 -0700 (PDT)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     christian@brauner.io, axboe@kernel.dk, ebiederm@xmission.com,
        oleg@redhat.com, tglx@linutronix.de, pcc@google.com
Cc:     linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: [PATCH V4] exit: trigger panic when global init has exited
Date:   Thu, 25 Mar 2021 21:08:01 +0800
Message-Id: <1616677681-60183-1-git-send-email-zhaoqianligood@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qianli Zhao <zhaoqianli@xiaomi.com>

When init sub-threads running on different CPUs exit at the same time,
zap_pid_ns_processe()->BUG() may be happened(timing is as below),move
panic() before set PF_EXITING to fix this problem.

In addition,if panic() after other sub-threads finish do_exit(),
some key variables (task->mm,task->nsproxy etc) of sub-thread will be lost,
which makes it difficult to parse coredump from fulldump,checking SIGNAL_GROUP_EXIT
to prevent init sub-threads exit.

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
V4:
- Changelog update

V3:
- Use group_dead instead of thread_group_empty() to test single init exit.

V2:
- Changelog update
- Remove wrong useage of SIGNAL_UNKILLABLE. 
- Add thread_group_empty() test to handle single init thread exit

---
 kernel/exit.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 04029e3..f95f8dc 100644
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
@@ -784,16 +795,8 @@ void __noreturn do_exit(long code)
 	if (tsk->mm)
 		sync_mm_rss(tsk->mm);
 	acct_update_integrals(tsk);
-	group_dead = atomic_dec_and_test(&tsk->signal->live);
-	if (group_dead) {
-		/*
-		 * If the last thread of global init has exited, panic
-		 * immediately to get a useable coredump.
-		 */
-		if (unlikely(is_global_init(tsk)))
-			panic("Attempted to kill init! exitcode=0x%08x\n",
-				tsk->signal->group_exit_code ?: (int)code);
 
+	if (group_dead) {
 #ifdef CONFIG_POSIX_TIMERS
 		hrtimer_cancel(&tsk->signal->real_timer);
 		exit_itimers(tsk->signal);
-- 
1.9.1

