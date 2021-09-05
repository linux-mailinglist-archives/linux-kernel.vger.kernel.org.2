Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBC6401177
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 22:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhIEUTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 16:19:25 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49722 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhIEUTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 16:19:24 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:41328)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mMyao-000bcQ-UZ; Sun, 05 Sep 2021 14:18:19 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:37964 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mMyan-00HJu6-Hl; Sun, 05 Sep 2021 14:18:18 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, <linux-kernel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
Date:   Sun, 05 Sep 2021 15:17:37 -0500
Message-ID: <87a6kqvkta.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mMyan-00HJu6-Hl;;;mid=<87a6kqvkta.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19lJt2dFJFtDFCcFNdVwdQw0t6P91V24wI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 442 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 14 (3.1%), b_tie_ro: 12 (2.6%), parse: 1.50
        (0.3%), extract_message_metadata: 20 (4.4%), get_uri_detail_list: 3.1
        (0.7%), tests_pri_-1000: 20 (4.6%), tests_pri_-950: 1.83 (0.4%),
        tests_pri_-900: 1.42 (0.3%), tests_pri_-90: 92 (20.9%), check_bayes:
        90 (20.4%), b_tokenize: 9 (2.1%), b_tok_get_all: 8 (1.9%),
        b_comp_prob: 3.0 (0.7%), b_tok_touch_all: 66 (14.9%), b_finish: 1.14
        (0.3%), tests_pri_0: 269 (60.9%), check_dkim_signature: 0.78 (0.2%),
        check_dkim_adsp: 3.7 (0.8%), poll_dns_idle: 1.17 (0.3%), tests_pri_10:
        4.4 (1.0%), tests_pri_500: 13 (2.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] signal: Remove the bogus sigkill_pending in ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The existence of sigkill_pending is a little silly as it is
functionally a duplicate of fatal_signal_pending that is used in
exactly one place.

Checking for pending fatal signals and returning early in ptrace_stop
is actively harmful.  It casues the ptrace_stop called by
ptrace_signal to return early before setting current->exit_code.
Later when ptrace_signal reads the signal number from
current->exit_code is undefined, making it unpredictable what will
happen.

Instead rely on the fact that schedule will not sleep if there is a
pending signal that can awaken a task.

Removing the explict sigkill_pending test fixes fixes ptrace_signal
when ptrace_stop does not stop because current->exit_code is always
set to to signr.

Cc: stable@vger.kernel.org
Fixes: 3d749b9e676b ("ptrace: simplify ptrace_stop()->sigkill_pending() path")
Fixes: 1a669c2f16d4 ("Add arch_ptrace_stop")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Linus if you would like this as a pull request or after the merge window
closes please let me know.  This change just fixes a very old and nasty
piece of confusion in the code and is trivially correct so I thought you
might appreciate it directly.

 kernel/signal.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index a3229add4455..b024447b3ff3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2122,15 +2122,6 @@ static inline bool may_ptrace_stop(void)
 	return true;
 }
 
-/*
- * Return non-zero if there is a SIGKILL that should be waking us up.
- * Called with the siglock held.
- */
-static bool sigkill_pending(struct task_struct *tsk)
-{
-	return sigismember(&tsk->pending.signal, SIGKILL) ||
-	       sigismember(&tsk->signal->shared_pending.signal, SIGKILL);
-}
 
 /*
  * This must be called with current->sighand->siglock held.
@@ -2157,17 +2148,16 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 		 * calling arch_ptrace_stop, so we must release it now.
 		 * To preserve proper semantics, we must do this before
 		 * any signal bookkeeping like checking group_stop_count.
-		 * Meanwhile, a SIGKILL could come in before we retake the
-		 * siglock.  That must prevent us from sleeping in TASK_TRACED.
-		 * So after regaining the lock, we must check for SIGKILL.
 		 */
 		spin_unlock_irq(&current->sighand->siglock);
 		arch_ptrace_stop(exit_code, info);
 		spin_lock_irq(&current->sighand->siglock);
-		if (sigkill_pending(current))
-			return;
 	}
 
+	/*
+	 * schedule() will not sleep if there is a pending signal that
+	 * can awaken the task.
+	 */
 	set_special_state(TASK_TRACED);
 
 	/*
-- 
2.20.1

