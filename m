Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EE144C371
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhKJO6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 09:58:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231703AbhKJO6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 09:58:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 755F6611ED;
        Wed, 10 Nov 2021 14:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636556151;
        bh=nl20ydh3JSvF+/L4nJPk1QcZPmefAyyYo/AMwHP+7E4=;
        h=From:To:Cc:Subject:Date:From;
        b=kJ+UWrKQdL38c4ggvHQzo3VcpwI++Z6Zli6VsdINBfWDs5xdfUoakgstUUFaTezwH
         yGHdWvTFzNiMZR5YsKbqqZxxcwu9LYqyeTOaPEEVONGSxFizV8xy2uJSnydd9ih2jG
         Sx6WlG4T7W6XSuA3FaoLndW0aTgCVQFJiJWm/Q5PWaL5/7e/fTzTHH6boJGQUqd9Nb
         of4M3Ixe9ly42O1q25R3bEg5FPoMdSPw6MSi+YGKowBHJjNHVCCUE6W2BPvMxGdupS
         FZ4z0D4XnFUCAVtCILEIk8acTZgcMpEOuZpOh3BCdK9uf+f8aCXATduqHI3SnnXgcM
         z6JyGr4eLBAmQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] prctl updates
Date:   Wed, 10 Nov 2021 15:55:26 +0100
Message-Id: <20211110145526.1968029-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

/* Summary */
This contains the missing prctl uapi pieces for PR_SCHED_CORE. In order to
activate core scheduling the caller is expected to specify the scope of the new
core scheduling domain. For example, passing 2 in the 4th argument of
prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, <pid>, 2, 0);
would indicate that the new core scheduling domain encompasses all tasks in the
process group of <pid>. Specifying 0 would only create a core scheduling domain
for the thread identified by <pid> and 2 would encompass the whole thread-group
of <pid>.

Note, the values 0, 1, and 2 correspond to PIDTYPE_PID, PIDTYPE_TGID, and
PIDTYPE_PGID. A first version tried to expose those values directly to which I
objected because:

- PIDTYPE_* is an enum that is kernel internal which we should not expose to
  userspace directly.
- PIDTYPE_* indicates what a given struct pid is used for it doesn't express a
  scope.

But what the 4th argument of PR_SCHED_CORE prctl() expresses is the scope of
the operation, i.e. the scope of the core scheduling domain at creation time.
So Eugene's patch now simply introduces three new defines
PR_SCHED_CORE_SCOPE_THREAD, PR_SCHED_CORE_SCOPE_THREAD_GROUP, and
PR_SCHED_CORE_SCOPE_PROCESS_GROUP. They simply express what happens.

This has been on the mailing list for quite a while with all relevant scheduler
folks Cced. I announced multiple times that I'd pick this up if I don't see or
her anyone else doing it. None of this touches proper scheduler code but only
concerns uapi so I think this is fine.

With core scheduling being quite common now for vm managers (e.g. moving
individual vcpu threads into their own core scheduling domain) and container
managers (e.g. moving the init process into its own core scheduling domain and
letting all created children inherit it) having to rely on raw numbers passed
as the 4th argument in prctl() is a bit annoying and everyone is starting to
come up with their own defines.

/* Testing */
All patches have been in linux-next since 5.15-rc3. No build failures or
warnings were observed. All old and new tests are passing.

/** Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/kernel.sys.v5.16

for you to fetch changes up to 61bc346ce64a3864ac55f5d18bdc1572cda4fb18:

  uapi/linux/prctl: provide macro definitions for the PR_SCHED_CORE type argument (2021-09-29 13:00:05 +0200)

Please consider pulling these changes from the signed kernel.sys.v5.16 tag.

Thanks!
Christian

----------------------------------------------------------------
kernel.sys.v5.16

----------------------------------------------------------------
Eugene Syromiatnikov (1):
      uapi/linux/prctl: provide macro definitions for the PR_SCHED_CORE type argument

 Documentation/admin-guide/hw-vuln/core-scheduling.rst | 5 +++--
 include/uapi/linux/prctl.h                            | 3 +++
 kernel/sched/core_sched.c                             | 4 ++++
 3 files changed, 10 insertions(+), 2 deletions(-)
