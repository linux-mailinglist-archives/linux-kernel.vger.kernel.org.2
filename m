Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887DC37BE47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhELNep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbhELNei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620826410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=itDf62+uu/hg9owgCGRA6LJBx/kgYnU4Cr4KnZW18tI=;
        b=MT1/m4AAWuNULNM1MGg1hbj1W59aiwY6Ufg9r+f6OpSOnKasRCFOn+qNaCHnNfx3dfdMy7
        dteWq3O8PntVQibA9Wu/XpDaiJMbOmc+oZwI+3kw/50rJCZUkkjI0bG2P8RwiuFIUV3qli
        vTOCfKz8RErKyyU3y0A2cPSwc/4U9WY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-pXz-52LdPfqfrn4SvtwJeA-1; Wed, 12 May 2021 09:33:28 -0400
X-MC-Unique: pXz-52LdPfqfrn4SvtwJeA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E80911854E24;
        Wed, 12 May 2021 13:33:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9375519C95;
        Wed, 12 May 2021 13:33:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 12 May 2021 15:33:26 +0200 (CEST)
Date:   Wed, 12 May 2021 15:33:08 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simon.marchi@efficios.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ptrace: make ptrace() fail if the tracee changed its pid
 unexpectedly
Message-ID: <20210512133308.GA16331@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suppose we have 2 threads, the group-leader L and a sub-theread T,
both parked in ptrace_stop(). Debugger tries to resume both threads
and does

	ptrace(PTRACE_CONT, T);
	ptrace(PTRACE_CONT, L);

If the sub-thread T execs in between, the 2nd PTRACE_CONT doesn not
resume the old leader L, it resumes the post-exec thread T which was
actually now stopped in PTHREAD_EVENT_EXEC. In this case the
PTHREAD_EVENT_EXEC event is lost, and the tracer can't know that the
tracee changed its pid.

This patch makes ptrace() fail in this case until debugger does wait()
and consumes PTHREAD_EVENT_EXEC which reports old_pid. This affects all
ptrace requests except the "asynchronous" PTRACE_INTERRUPT/KILL.

The patch doesn't add the new PTRACE_ option to not complicate the API,
and I _hope_ this won't cause any noticeable regression:

	- If debugger uses PTRACE_O_TRACEEXEC and the thread did an exec
	  and the tracer does a ptrace request without having consumed
	  the exec event, it's 100% sure that the thread the ptracer
	  thinks it is targeting does not exist anymore, or isn't the
	  same as the one it thinks it is targeting.

	- To some degree this patch adds nothing new. In the scenario
	  above ptrace(L) can fail with -ESRCH if it is called after the
	  execing sub-thread wakes the leader up and before it "steals"
	  the leader's pid.

Test-case:

	#include <stdio.h>
	#include <unistd.h>
	#include <signal.h>
	#include <sys/ptrace.h>
	#include <sys/wait.h>
	#include <errno.h>
	#include <pthread.h>
	#include <assert.h>

	void *tf(void *arg)
	{
		execve("/usr/bin/true", NULL, NULL);
		assert(0);

		return NULL;
	}

	int main(void)
	{
		int leader = fork();
		if (!leader) {
			kill(getpid(), SIGSTOP);

			pthread_t th;
			pthread_create(&th, NULL, tf, NULL);
			for (;;)
				pause();

			return 0;
		}

		waitpid(leader, NULL, WSTOPPED);

		ptrace(PTRACE_SEIZE, leader, 0,
				PTRACE_O_TRACECLONE | PTRACE_O_TRACEEXEC);
		waitpid(leader, NULL, 0);

		ptrace(PTRACE_CONT, leader, 0,0);
		waitpid(leader, NULL, 0);

		int status, thread = waitpid(-1, &status, 0);
		assert(thread > 0 && thread != leader);
		assert(status == 0x80137f);

		ptrace(PTRACE_CONT, thread, 0,0);
		/*
		 * waitid() because waitpid(leader, &status, WNOWAIT) does not
		 * report status. Why ????
		 *
		 * Why WEXITED? because we have another kernel problem connected
		 * to mt-exec.
		 */
		siginfo_t info;
		assert(waitid(P_PID, leader, &info, WSTOPPED|WEXITED|WNOWAIT) == 0);
		assert(info.si_pid == leader && info.si_status == 0x0405);

		/* OK, it sleeps in ptrace(PTRACE_EVENT_EXEC == 0x04) */
		assert(ptrace(PTRACE_CONT, leader, 0,0) == -1);
		assert(errno == ESRCH);

		assert(leader == waitpid(leader, &status, WNOHANG));
		assert(status == 0x04057f);

		assert(ptrace(PTRACE_CONT, leader, 0,0) == 0);

		return 0;
	}

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Reported-by: Simon Marchi <simon.marchi@efficios.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Acked-by: Pedro Alves <palves@redhat.com>
Acked-by: Simon Marchi <simon.marchi@efficios.com>
Acked-by: Jan Kratochvil <jan.kratochvil@redhat.com>
---
 kernel/ptrace.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 76f09456ec4b..2997ca600d18 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -170,6 +170,21 @@ void __ptrace_unlink(struct task_struct *child)
 	spin_unlock(&child->sighand->siglock);
 }
 
+static bool looks_like_a_spurious_pid(struct task_struct *task)
+{
+	if (task->exit_code != ((PTRACE_EVENT_EXEC << 8) | SIGTRAP))
+		return false;
+
+	if (task_pid_vnr(task) == task->ptrace_message)
+		return false;
+	/*
+	 * The tracee changed its pid but the PTRACE_EVENT_EXEC event
+	 * was not wait()'ed, most probably debugger targets the old
+	 * leader which was destroyed in de_thread().
+	 */
+	return true;
+}
+
 /* Ensure that nothing can wake it up, even SIGKILL */
 static bool ptrace_freeze_traced(struct task_struct *task)
 {
@@ -180,7 +195,8 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 		return ret;
 
 	spin_lock_irq(&task->sighand->siglock);
-	if (task_is_traced(task) && !__fatal_signal_pending(task)) {
+	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
+	    !__fatal_signal_pending(task)) {
 		task->state = __TASK_TRACED;
 		ret = true;
 	}
-- 
2.25.1.362.g51ebf55


