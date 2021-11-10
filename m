Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F134B44C36D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhKJO5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 09:57:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232186AbhKJO5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 09:57:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED7E0611ED;
        Wed, 10 Nov 2021 14:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636556054;
        bh=q8Ad0wcsOm409rtbkeY2GY7Wxa4MXoE7oT6OiCH5teY=;
        h=From:To:Cc:Subject:Date:From;
        b=AtVpztXVKHpVWKSJ9mx4iwNkQ3hYFtQsVXeMdNf5SnQj26M2rP4fZZfs8B0DL9Yq8
         4lSaY6iu6oWrIUYYQexkRAH7rk9JWeD2tV8l1BaVAoHNEgLq9nCpPrbtE6q6tBEaYO
         4CNJXdSWxKXLi/kJcvIyWpBzaL2bt/mDz3BoAUIi9RdJ0XfhllRYeGSBDyTNgvMRYm
         Q2/vAdnpNWXm3+ETkgCpPKbg/gdosKGfUhukg8pk6HC66TzmoU+SJTt1ylEBkBH/mC
         ZDy2z6F96G5QlDaSIylM1Wf2f09YBKMkDxpkVnqiyljbJ7ywrb5HGxi4tWawdZmLXS
         7ltIPL68tMWDg==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] pidfd updates
Date:   Wed, 10 Nov 2021 15:52:23 +0100
Message-Id: <20211110145222.1967514-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

/* Summary */
Various places in the kernel have picked up pidfds. The two most recent
additions have probably been the ability to use pidfds in bpf maps and the
usage of pidfds in mm-based syscalls such as process_mrelease() and
process_madvise(). The same pattern to turn a pidfd into a struct task exists
in two places. One of those places used PIDTYPE_TGID while the other one used
PIDTYPE_PID even though it is clearly documented in all pidfd-helpers that
pidfds __currently__ only refer to thread-group leaders (subject to change in
the future if need be). This isn't a bug per se but has the potential to be one
if we allow pidfds to refer to individual threads. If that happens we want to
audit all codepaths that make use of them to ensure they can deal with pidfds
refering to individual threads. This pull request adds a simple helper to turn
a pidfd into a struct task making it easy to grep for such places. Plus, it
gets rid of code-duplication.

(This is coming a bit later than usual because of a few fixes I was working on.)

/* Testing */
All patches have been in linux-next since 5.15-rc5. No build failures or
warnings were observed. All old and new tests are passing.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next. However, a trivial merge conflict exists with current mainline.

diff --cc mm/oom_kill.c
index 195b3661da3d,70d399d5817e..000000000000
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@@ -1149,8 -1150,7 +1149,7 @@@ SYSCALL_DEFINE2(process_mrelease, int,
        struct task_struct *task;
        struct task_struct *p;
        unsigned int f_flags;
 -      bool reap = true;
 +      bool reap = false;
-       struct pid *pid;
        long ret = 0;

        if (flags)
@@@ -1200,12 -1194,9 +1193,10 @@@
        mmap_read_unlock(mm);

  drop_mm:
 -      mmdrop(mm);
 +      if (mm)
 +              mmput(mm);
  put_task:
        put_task_struct(task);
- put_pid:
-       put_pid(pid);
        return ret;
  #else
        return -ENOSYS;

The following changes since commit 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc:

  Linux 5.15-rc5 (2021-10-10 17:01:59 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/pidfd.v5.16

for you to fetch changes up to ee9955d61a0a770152f9c3af470bd1689f034c74:

  mm: use pidfd_get_task() (2021-10-14 13:29:22 +0200)

Please consider pulling these changes from the signed pidfd.v5.16 tag.

Thanks!
Christian

----------------------------------------------------------------
pidfd.v5.16

----------------------------------------------------------------
Christian Brauner (2):
      pid: add pidfd_get_task() helper
      mm: use pidfd_get_task()

 include/linux/pid.h |  1 +
 kernel/pid.c        | 36 ++++++++++++++++++++++++++++++++++++
 mm/madvise.c        | 15 +++------------
 mm/oom_kill.c       | 15 +++------------
 4 files changed, 43 insertions(+), 24 deletions(-)
