Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212F234C1F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 04:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhC2Cgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 22:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhC2CgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 22:36:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398BAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 19:36:21 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso5209311pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 19:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E8R/uv85zPM3yGP2/tFWyzAhiP++yYtTCdREeByl7KI=;
        b=NdD78yuLYTGdfabSkW9fDFCmI/wAKkRI+bdbi3C40h46k09r+CPXXnDsULEeMRpYCY
         mTA9SlV0i9LRcZwDyLdDsPbDlUZ0vRKzk10vvve4fpWOgX38GXwtFKi7IZQI/aJKHK7u
         /tUdntrGJvJxIs8FTAq2BmA6G2wiFTJyOKp3xfW+YmGHZDFg7n/orBLoqjmMubNf9IUF
         9offqL0dJuZ96+J8D99jWZCLq+qCsiicbI7frK9KWOLcTjCZRweT7gQR5BKKmEFSnOJn
         x3V2kcmm0LpxMqage0PQqdoUdqimNHXOoQRiLnSiORuXe9yvBrYwlyurZis47xz5BuNh
         eR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E8R/uv85zPM3yGP2/tFWyzAhiP++yYtTCdREeByl7KI=;
        b=mS5DKyDN32xMOpfGVWKY/UMHyHnVKIJqpAHbTkQfywY2hbrbHG1YVm1hchiKxmH2QA
         aDn+yvp9EpxP42eO3eV9XxsqmZL0ojFvyc1JtjUqINbZLruA89LaRw1ijWN9tdHXUsOH
         CMvyUlB7AA3sKKh8MLZfYXE5R9Gy3BRsvjuBMnEZf6RgzR2C+xYVgN23E4V5/+sx1o2Y
         6fMemKMmPFSGo1TmxjDM7pgQVd0IeBGL4gY6h0DT5agUFovBO0NhRULh7Gi2LWTTVr6e
         O1QEY4IWvt/2EGJJ7SE+Nz9PQLpeDw8t1wht7ymCl22rIOPBQge1wKJRjQqufctigONT
         ioyA==
X-Gm-Message-State: AOAM5318MfCrS0WWdtjcK5yH+z8AoVB7nZz6vDJkp1ZHWErNArIXW23E
        Duzw2ackkRE4RzrMoN/ahv4=
X-Google-Smtp-Source: ABdhPJxZ849+jWX0gjrx0lO+sVP2orhASW3JCcSspPRCnP+wrB6iVfJhjHxrTGeezqC0l4KvTxjTFQ==
X-Received: by 2002:a17:90b:3553:: with SMTP id lt19mr24154314pjb.222.1616985380578;
        Sun, 28 Mar 2021 19:36:20 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id a21sm15450037pfk.83.2021.03.28.19.36.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Mar 2021 19:36:20 -0700 (PDT)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     christian@brauner.io, axboe@kernel.dk, ebiederm@xmission.com,
        oleg@redhat.com, tglx@linutronix.de, pcc@google.com
Cc:     linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: [PATCH V4] exit: trigger panic when global init has exited
Date:   Mon, 29 Mar 2021 10:27:26 +0800
Message-Id: <1616984846-184466-1-git-send-email-zhaoqianligood@gmail.com>
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

