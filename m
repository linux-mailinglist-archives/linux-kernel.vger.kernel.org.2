Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333EA3572C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354634AbhDGRIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:08:51 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:46574 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234050AbhDGRIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:08:48 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-94-113-225-162.net.upcbroadband.cz [94.113.225.162])
        by raptor.unsafe.ru (Postfix) with ESMTPSA id E1C0040C8C;
        Wed,  7 Apr 2021 17:08:28 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-mm@kvack.org
Cc:     Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v10 0/9] Count rlimits in each user namespace
Date:   Wed,  7 Apr 2021 19:08:05 +0200
Message-Id: <cover.1617814298.git.gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.29.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (raptor.unsafe.ru [5.9.43.93]); Wed, 07 Apr 2021 17:08:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preface
-------
These patches are for binding the rlimit counters to a user in user namespace.
This patch set can be applied on top of:

git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v5.12-rc4

Problem
-------
The RLIMIT_NPROC, RLIMIT_MEMLOCK, RLIMIT_SIGPENDING, RLIMIT_MSGQUEUE rlimits
implementation places the counters in user_struct [1]. These limits are global
between processes and persists for the lifetime of the process, even if
processes are in different user namespaces.

To illustrate the impact of rlimits, let's say there is a program that does not
fork. Some service-A wants to run this program as user X in multiple containers.
Since the program never fork the service wants to set RLIMIT_NPROC=1.

service-A
 \- program (uid=1000, container1, rlimit_nproc=1)
 \- program (uid=1000, container2, rlimit_nproc=1)

The service-A sets RLIMIT_NPROC=1 and runs the program in container1. When the
service-A tries to run a program with RLIMIT_NPROC=1 in container2 it fails
since user X already has one running process.

The problem is not that the limit from container1 affects container2. The
problem is that limit is verified against the global counter that reflects
the number of processes in all containers.

This problem can be worked around by using different users for each container
but in this case we face a different problem of uid mapping when transferring
files from one container to another.

Eric W. Biederman mentioned this issue [2][3].

Introduced changes
------------------
To address the problem, we bind rlimit counters to user namespace. Each counter
reflects the number of processes in a given uid in a given user namespace. The
result is a tree of rlimit counters with the biggest value at the root (aka
init_user_ns). The limit is considered exceeded if it's exceeded up in the tree.

[1]: https://lore.kernel.org/containers/87imd2incs.fsf@x220.int.ebiederm.org/
[2]: https://lists.linuxfoundation.org/pipermail/containers/2020-August/042096.html
[3]: https://lists.linuxfoundation.org/pipermail/containers/2020-October/042524.html

Changelog
---------
v10:
* Fixed memory leak in __sigqueue_alloc.
* Handled an unlikely situation when all consumers will return ucounts at once.
* Addressed other review comments from Eric W. Biederman.

v9:
* Used a negative value to check that the ucounts->count is close to overflow.
* Rebased onto v5.12-rc4.

v8:
* Used atomic_t for ucounts reference counting. Also added counter overflow
  check (thanks to Linus Torvalds for the idea).
* Fixed other issues found by lkp-tests project in the patch that Reimplements
  RLIMIT_MEMLOCK on top of ucounts.

v7:
* Fixed issues found by lkp-tests project in the patch that Reimplements
  RLIMIT_MEMLOCK on top of ucounts.

v6:
* Fixed issues found by lkp-tests project.
* Rebased onto v5.11.

v5:
* Split the first commit into two commits: change ucounts.count type to atomic_long_t
  and add ucounts to cred. These commits were merged by mistake during the rebase.
* The __get_ucounts() renamed to alloc_ucounts().
* The cred.ucounts update has been moved from commit_creds() as it did not allow
  to handle errors.
* Added error handling of set_cred_ucounts().

v4:
* Reverted the type change of ucounts.count to refcount_t.
* Fixed typo in the kernel/cred.c

v3:
* Added get_ucounts() function to increase the reference count. The existing
  get_counts() function renamed to __get_ucounts().
* The type of ucounts.count changed from atomic_t to refcount_t.
* Dropped 'const' from set_cred_ucounts() arguments.
* Fixed a bug with freeing the cred structure after calling cred_alloc_blank().
* Commit messages have been updated.
* Added selftest.

v2:
* RLIMIT_MEMLOCK, RLIMIT_SIGPENDING and RLIMIT_MSGQUEUE are migrated to ucounts.
* Added ucounts for pair uid and user namespace into cred.
* Added the ability to increase ucount by more than 1.

v1:
* After discussion with Eric W. Biederman, I increased the size of ucounts to
  atomic_long_t.
* Added ucount_max to avoid the fork bomb.

--

Alexey Gladkov (9):
  Increase size of ucounts to atomic_long_t
  Add a reference to ucounts for each cred
  Use atomic_t for ucounts reference counting
  Reimplement RLIMIT_NPROC on top of ucounts
  Reimplement RLIMIT_MSGQUEUE on top of ucounts
  Reimplement RLIMIT_SIGPENDING on top of ucounts
  Reimplement RLIMIT_MEMLOCK on top of ucounts
  kselftests: Add test to check for rlimit changes in different user
    namespaces
  ucounts: Set ucount_max to the largest positive value the type can
    hold

 fs/exec.c                                     |   6 +-
 fs/hugetlbfs/inode.c                          |  16 +-
 fs/proc/array.c                               |   2 +-
 include/linux/cred.h                          |   4 +
 include/linux/hugetlb.h                       |   4 +-
 include/linux/mm.h                            |   4 +-
 include/linux/sched/user.h                    |   7 -
 include/linux/shmem_fs.h                      |   2 +-
 include/linux/signal_types.h                  |   4 +-
 include/linux/user_namespace.h                |  32 +++-
 ipc/mqueue.c                                  |  41 ++---
 ipc/shm.c                                     |  26 +--
 kernel/cred.c                                 |  50 +++++-
 kernel/exit.c                                 |   2 +-
 kernel/fork.c                                 |  18 +-
 kernel/signal.c                               |  58 +++----
 kernel/sys.c                                  |  14 +-
 kernel/ucount.c                               | 123 ++++++++++---
 kernel/user.c                                 |   3 -
 kernel/user_namespace.c                       |   9 +-
 mm/memfd.c                                    |   4 +-
 mm/mlock.c                                    |  23 ++-
 mm/mmap.c                                     |   4 +-
 mm/shmem.c                                    |   8 +-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/rlimits/.gitignore    |   2 +
 tools/testing/selftests/rlimits/Makefile      |   6 +
 tools/testing/selftests/rlimits/config        |   1 +
 .../selftests/rlimits/rlimits-per-userns.c    | 161 ++++++++++++++++++
 29 files changed, 490 insertions(+), 145 deletions(-)
 create mode 100644 tools/testing/selftests/rlimits/.gitignore
 create mode 100644 tools/testing/selftests/rlimits/Makefile
 create mode 100644 tools/testing/selftests/rlimits/config
 create mode 100644 tools/testing/selftests/rlimits/rlimits-per-userns.c

-- 
2.29.3

