Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EF132DA0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbhCDTHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:07:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236872AbhCDTGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:06:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7694364F64;
        Thu,  4 Mar 2021 19:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614884767;
        bh=GqNx2NifyKFc47WHKV+OTISdS1HyMi1UG6SPVAfOvbs=;
        h=From:To:Cc:Subject:Date:From;
        b=lgQXZmthgHg5uQPoy2kHWjFibsxe5BGLa1dFV33JB3YJuyyz5qwztg4T2Lqv6r8wZ
         qXpa+a4wd+7r/JxBx1DYxTQPn0VgEBLzeS6NfhtzVEjFEVW45KsMXQDKs+vRzSf7kD
         /eGxJYni8JWUGKYxUrPEZRgxRjVoKsXdoPJtkZIxcBceJ41wuM7L0h+Qa7Gmxoo2NQ
         FEl5tZjgbMpsN4WxNpq2j8r9IwINz8qIIZ4DYPi0NQpjAKDByE/e7v5ymBpiwPrmRr
         NNGFjbLEG/SuXCrShLemX1jjQDDw8Hdj9ZJ8/q4WwEBCluQDokAU3q5tplRjP58eKf
         uXM+ud5IyeYxA==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 00/11] kentry: A stable bugfix and a bunch of improvements
Date:   Thu,  4 Mar 2021 11:05:53 -0800
Message-Id: <cover.1614884673.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
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

Changes from v1 and v2: Complete rewrite

Andy Lutomirski (11):
  x86/entry: Fix entry/exit mismatch on failed fast 32-bit syscalls
  kentry: Rename irqentry to kentry
  x86/dumpstack: Remove unnecessary range check fetching opcode bytes
  x86/kthread,dumpstack: Set task_pt_regs->cs.RPL=3 for kernel threads
  x86/entry: Convert ret_from_fork to C
  kentry: Simplify the common syscall API
  kentry: Make entry/exit_to_user_mode() arm64-only
  entry: Make CONFIG_DEBUG_ENTRY available outside x86
  kentry: Add debugging checks for proper kentry API usage
  kentry: Check that syscall entries and syscall exits match
  kentry: Verify kentry state in instrumentation_begin/end()

 arch/x86/Kconfig.debug           |  10 --
 arch/x86/entry/common.c          |  85 ++++++++++----
 arch/x86/entry/entry_32.S        |  51 ++------
 arch/x86/entry/entry_64.S        |  33 ++----
 arch/x86/include/asm/idtentry.h  |  28 ++---
 arch/x86/include/asm/switch_to.h |   2 +-
 arch/x86/kernel/cpu/mce/core.c   |  10 +-
 arch/x86/kernel/dumpstack.c      |  10 +-
 arch/x86/kernel/kvm.c            |   6 +-
 arch/x86/kernel/nmi.c            |   6 +-
 arch/x86/kernel/process.c        |  15 ++-
 arch/x86/kernel/process_32.c     |   2 +-
 arch/x86/kernel/traps.c          |  32 ++---
 arch/x86/kernel/unwind_orc.c     |   2 +-
 arch/x86/mm/fault.c              |   6 +-
 include/asm-generic/bug.h        |   8 +-
 include/linux/entry-common.h     | 180 ++++++++--------------------
 include/linux/instrumentation.h  |  25 +++-
 include/linux/sched.h            |   4 +
 init/init_task.c                 |   8 ++
 kernel/entry/common.c            | 193 +++++++++++++++++++++----------
 lib/Kconfig.debug                |  11 ++
 22 files changed, 366 insertions(+), 361 deletions(-)

-- 
2.29.2

