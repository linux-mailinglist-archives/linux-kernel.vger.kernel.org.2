Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3783EDF7E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 23:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhHPVv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 17:51:58 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:45534 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbhHPVv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:51:57 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFkVQ-00D7Rq-2k; Mon, 16 Aug 2021 21:50:52 +0000
Date:   Mon, 16 Aug 2021 21:50:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] fix PTRACE_KILL
Message-ID: <YRrdvKEu2JQxLI5n@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc'd to security@k.o, *NOT* because I consider it a serious security hole;
it's just that the odds of catching relevant reviewers there are higher
than on l-k and there doesn't seem to be any lists where that would be
on-topic.  My apologies for misuse of security@k.o ;-/]

Current implementation is racy in quite a few ways - we check that
the child is traced by us and use ptrace_resume() to feed it
SIGKILL, provided that it's still alive.

What we do not do is making sure that the victim is in ptrace stop;
as the result, it can go and violate all kinds of assumptions,
starting with "child->sighand won't change under ptrace_resume()",
"child->ptrace won't get changed under user_disable_single_step()",
etc.

Note that ptrace(2) manpage has this to say:
    
PTRACE_KILL
      Send  the  tracee a SIGKILL to terminate it.  (addr and data are
      ignored.)
    
      This operation is deprecated; do not use it!   Instead,  send  a
      SIGKILL  directly  using kill(2) or tgkill(2).  The problem with
      PTRACE_KILL is that it requires the  tracee  to  be  in  signal-
      delivery-stop,  otherwise  it  may  not work (i.e., may complete
      successfully but won't kill the tracee).  By contrast, sending a
      SIGKILL directly has no such limitation.
    
So let it check (under tasklist_lock) that the victim is traced by us
and call sig_send_info() to feed it SIGKILL.  It's easier that trying
to force ptrace_resume() into handling that mess and it's less brittle
that way.
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index f8589bf8d7dc..7f46be488b36 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1220,11 +1220,6 @@ int ptrace_request(struct task_struct *child, long request,
 	case PTRACE_CONT:
 		return ptrace_resume(child, request, data);
 
-	case PTRACE_KILL:
-		if (child->exit_state)	/* already dead */
-			return 0;
-		return ptrace_resume(child, request, SIGKILL);
-
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	case PTRACE_GETREGSET:
 	case PTRACE_SETREGSET: {
@@ -1270,6 +1265,20 @@ int ptrace_request(struct task_struct *child, long request,
 	return ret;
 }
 
+static int ptrace_kill(struct task_struct *child)
+{
+	int ret = -ESRCH;
+
+	read_lock(&tasklist_lock);
+	if (child->ptrace && child->parent == current) {
+		if (!child->exit_state)
+			send_sig_info(SIGKILL, SEND_SIG_PRIV, child);
+		ret = 0;
+	}
+	read_unlock(&tasklist_lock);
+	return ret;
+}
+
 #ifndef arch_ptrace_attach
 #define arch_ptrace_attach(child)	do { } while (0)
 #endif
@@ -1304,8 +1313,12 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
 		goto out_put_task_struct;
 	}
 
-	ret = ptrace_check_attach(child, request == PTRACE_KILL ||
-				  request == PTRACE_INTERRUPT);
+	if (request == PTRACE_KILL) {
+		ret = ptrace_kill(child);
+		goto out_put_task_struct;
+	}
+
+	ret = ptrace_check_attach(child, request == PTRACE_INTERRUPT);
 	if (ret < 0)
 		goto out_put_task_struct;
 
@@ -1449,8 +1462,12 @@ COMPAT_SYSCALL_DEFINE4(ptrace, compat_long_t, request, compat_long_t, pid,
 		goto out_put_task_struct;
 	}
 
-	ret = ptrace_check_attach(child, request == PTRACE_KILL ||
-				  request == PTRACE_INTERRUPT);
+	if (request == PTRACE_KILL) {
+		ret = ptrace_kill(child);
+		goto out_put_task_struct;
+	}
+
+	ret = ptrace_check_attach(child, request == PTRACE_INTERRUPT);
 	if (!ret) {
 		ret = compat_arch_ptrace(child, request, addr, data);
 		if (ret || request != PTRACE_DETACH)
