Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A94B33845F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 04:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhCLDdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 22:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhCLDdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 22:33:24 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDF0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 19:33:24 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id a24so11256694plm.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 19:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SWLHXds1dLAx2i1imCEpLjsUbhFpiJzp1IHLGVU6xwk=;
        b=VlvZju8Tel87GPmOQZK545polSPqf57VZO7KeaQHsbdwsVZekaSqkcaNAOLuuuY75g
         g5joIl2yfxSpxcVpAKmErAYmbR78wM3X8byizKpae53Avwf88xYfuQ42LSg90jynE68m
         gw6dmJ4OnZau9/CKUqQBvwBkLUrSuqaKLmp7BWBRl+Xo4JnjCJZfFNEFWgzJALyd8iEb
         Bycr8HxN3cZGZ7WZa14WbB7yOurdtXTyPbI5lCBZOtKh7uWt8oIgL9317SWDcv8Uqll+
         Unn7U7wWHzmReTOVBwfZkOpW9aiNotQD8iAaPJwGWHRymIrT8G3R0sfMQhwP4PoleLxL
         Ucaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SWLHXds1dLAx2i1imCEpLjsUbhFpiJzp1IHLGVU6xwk=;
        b=snY88DCHd2lNBDNaN6flF133bDaNmDCsUfO5XetHueg9nJ70UYk/BdNHaEarLPxRL9
         anZCOCSmCv/yexhCHrVRAmbFo1GkmeF3v7qsy6tE9TaPvfvS5P4f2oiWawEqJTxtVi/g
         yYYdm3Wmw1rensB046C6L1yF5FkNEtvAYihZjlXa8NJ7IDLYPpFhGiK+OqmI5o/7t0WC
         w1e0jWSr0vDYuRz2AMCueQNJ+TRrCrs6lJpLlPuQZkxE91EIaRVs3HMujt50emMxVtlB
         k5K+uHSbCjI2y5col9Wjl/h2I16pKhwdCL2QIUtsRIV+rrHlng3iF5SQonl0c3AUs4KF
         4U6Q==
X-Gm-Message-State: AOAM532o6ctzHNPByJp84z7UiPJyM5tEI1PExnxsrszT1VnGZmYdIYFz
        OWHje7rmnBhYS08rwycm3Vc=
X-Google-Smtp-Source: ABdhPJxKkcy4Rnfxunlz8rthJrSalIUwDv9YgIUEvdvD/eqCUIR8iuYxt6anVRKcXhwGP43dyc7wGQ==
X-Received: by 2002:a17:90b:17d1:: with SMTP id me17mr11915663pjb.106.1615520004174;
        Thu, 11 Mar 2021 19:33:24 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id r184sm3640901pfc.107.2021.03.11.19.33.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 19:33:23 -0800 (PST)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     christian@brauner.io, axboe@kernel.dk, ebiederm@xmission.com,
        oleg@redhat.com, tglx@linutronix.de, pcc@google.com
Cc:     linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: [PATCH V2] exit: trigger panic when global init has exited
Date:   Fri, 12 Mar 2021 11:24:38 +0800
Message-Id: <1615519478-178620-1-git-send-email-zhaoqianligood@gmail.com>
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
trigger panic immediately, and prevent other init threads from continuing to exit.

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
V2:
- Changelog update
- Remove wrong useage of SIGNAL_UNKILLABLE. 
- Add thread_group_empty() test to handle single init thread exit

---
 kernel/exit.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 04029e3..9d2716b 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -767,6 +767,17 @@ void __noreturn do_exit(long code)
 	validate_creds_for_do_exit(tsk);
 
 	/*
+	 * If global init has exited,
+	 * panic immediately to get a useable coredump.
+	 */
+	if (unlikely(is_global_init(tsk) &&
+	    (thread_group_empty(tsk) ||
+	    (tsk->signal->flags & SIGNAL_GROUP_EXIT)))) {
+			panic("Attempted to kill init! exitcode=0x%08x\n",
+				tsk->signal->group_exit_code ?: (int)code);
+	}
+
+	/*
 	 * We're taking recursive faults here in do_exit. Safest is to just
 	 * leave this task alone and wait for reboot.
 	 */
@@ -786,14 +797,6 @@ void __noreturn do_exit(long code)
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

