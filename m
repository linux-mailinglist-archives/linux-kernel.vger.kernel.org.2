Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6436D31E41C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 02:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhBRBmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 20:42:02 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:56218 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhBRBl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 20:41:57 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1BCF372C8B1;
        Thu, 18 Feb 2021 04:41:14 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 0D9777CC8A2; Thu, 18 Feb 2021 04:41:14 +0300 (MSK)
Date:   Wed, 17 Feb 2021 08:00:00 +0000
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Anatoly Pugachev <matorola@gmail.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: make copy_thread honor pid namespaces
Message-ID: <20210217080000.GA25861@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sparc, fork and clone syscalls have an unusual semantics of
returning the pid of the parent process to the child process.

Apparently, the implementation did not honor pid namespaces at all,
so the child used to get the pid of its parent in the init namespace.

This bug was found by strace test suite.

Reproducer:

  $ gcc -Wall -O2 -xc - <<'EOF'
  #define _GNU_SOURCE
  #include <err.h>
  #include <errno.h>
  #include <sched.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <sys/wait.h>
  #include <unistd.h>
  #include <asm/unistd.h>
  #include <linux/sched.h>
  int main(void)
  {
    if (unshare(CLONE_NEWPID | CLONE_NEWUSER) < 0)
      err(1, "unshare");
    int pid = syscall(__NR_fork);
    if (pid < 0)
      err(1, "fork");
    fprintf(stderr, "current: %d, parent: %d, fork returned: %d\n",
            getpid(), getppid(), pid);
    int status;
    if (wait(&status) < 0) {
      if (errno == ECHILD)
        _exit(0);
      err(1, "wait");
    }
    return !WIFEXITED(status) || WEXITSTATUS(status) != 0;
  }
  EOF
  $ sh -c ./a.out
  current: 10001, parent: 10000, fork returned: 10002
  current: 1, parent: 0, fork returned: 10001

Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Although the fix seems to be obvious, I have no means to test it myself,
so any help with the testing is much appreciated.

 arch/sparc/kernel/process_32.c | 2 +-
 arch/sparc/kernel/process_64.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index a02363735915..7a89969befa8 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -368,7 +368,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 #endif
 
 	/* Set the return value for the child. */
-	childregs->u_regs[UREG_I0] = current->pid;
+	childregs->u_regs[UREG_I0] = task_pid_nr_ns(current, task_active_pid_ns(p));
 	childregs->u_regs[UREG_I1] = 1;
 
 	/* Set the return value for the parent. */
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 6f8c7822fc06..ec97217ab970 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -629,7 +629,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 		t->utraps[0]++;
 
 	/* Set the return value for the child. */
-	t->kregs->u_regs[UREG_I0] = current->pid;
+	t->kregs->u_regs[UREG_I0] = task_pid_nr_ns(current, task_active_pid_ns(p));
 	t->kregs->u_regs[UREG_I1] = 1;
 
 	/* Set the second return value for the parent. */
-- 
ldv
