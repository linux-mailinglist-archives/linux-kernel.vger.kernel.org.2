Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624F433F7E4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhCQSNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:13:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232836AbhCQSMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:12:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C05BE64F3A;
        Wed, 17 Mar 2021 18:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616004770;
        bh=ii6DJh0iWgadMqKp28TfT7dEM/zMPaqma8oVTHy1Xkg=;
        h=From:To:Cc:Subject:Date:From;
        b=oOojIaKnnyL20NFl0Ht/vlhSoRdmlQLdTjk3gM+mdDtfS26rrBicNTsSKp1FuVScY
         gQjPmItLSwOPZDZxGG9B9BHXKghBYJblk4wzRBtVW5fB7QpSFKV7l7URoPoTEMA6L8
         WCtdfyR01YrOIYKU06NSHw0fEauDDun+EL0slR8YBV+HvGFBM62a7vlfCeYRLJ627a
         dF2E7yo/mVw9VNjmnkGA0fGc4BAvdov9SV5oZDh7GQbEhO4NhB4mPgzKPURYozpmnz
         sKDI3j7Vtot4Cvpqcz3YZlWM6sNduSu5OKRp6FV9fMYtEIzl9wcRd+XtyFbCwEPfhR
         xidBkW5JK3qQA==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v4 0/9] kentry: A stable bugfix and a bunch of improvements
Date:   Wed, 17 Mar 2021 11:12:39 -0700
Message-Id: <cover.1616004689.git.luto@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed a little bug in fast compat syscalls.  I got a bit carried away
fixing it.  This renames the irqentry stuff to kentry, improves (IMNSHO)
the API, and adds lots of debugging.

It also tweaks the unwinder wrt ret_from_fork and rewrites ret_from_fork
in C.  I did this because the kentry work involved a small change to
ret_from_fork, and adjusting the asm is a mess.  So C it is.

Changes from v3: Get rid of arm64 special cases

Changes from v1 and v2: Complete rewrite

Andy Lutomirski (9):
  x86/dumpstack: Remove unnecessary range check fetching opcode bytes
  x86/kthread,dumpstack: Set task_pt_regs->cs.RPL=3 for kernel threads
  x86/entry: Convert ret_from_fork to C
  kentry: Simplify the common syscall API
  kentry: Remove enter_from/exit_to_user_mode()
  entry: Make CONFIG_DEBUG_ENTRY available outside x86
  kentry: Add debugging checks for proper kentry API usage
  kentry: Check that syscall entries and syscall exits match
  kentry: Verify kentry state in instrumentation_begin/end()

 arch/x86/Kconfig.debug           |  10 --
 arch/x86/entry/common.c          |  78 ++++++++++----
 arch/x86/entry/entry_32.S        |  51 ++-------
 arch/x86/entry/entry_64.S        |  33 ++----
 arch/x86/include/asm/switch_to.h |   2 +-
 arch/x86/kernel/dumpstack.c      |  10 +-
 arch/x86/kernel/process.c        |  15 ++-
 arch/x86/kernel/process_32.c     |   2 +-
 arch/x86/kernel/traps.c          |   4 +-
 arch/x86/kernel/unwind_orc.c     |   2 +-
 include/asm-generic/bug.h        |   8 +-
 include/linux/entry-common.h     | 127 +++--------------------
 include/linux/instrumentation.h  |  25 ++++-
 include/linux/sched.h            |   4 +
 init/init_task.c                 |   8 ++
 kernel/entry/common.c            | 173 ++++++++++++++++++++-----------
 lib/Kconfig.debug                |  11 ++
 17 files changed, 267 insertions(+), 296 deletions(-)

-- 
2.30.2

