Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68D045482B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbhKQOKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:10:48 -0500
Received: from foss.arm.com ([217.140.110.172]:57112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233775AbhKQOKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:10:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 860F31FB;
        Wed, 17 Nov 2021 06:07:48 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 01B9A3F70D;
        Wed, 17 Nov 2021 06:07:45 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aou@eecs.berkeley.edu, borntraeger@de.ibm.com, bp@alien8.de,
        broonie@kernel.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        mark.rutland@arm.com, mhiramat@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, palmer@dabbelt.com, paul.walmsley@sifive.com,
        peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de,
        will@kernel.org
Subject: [PATCH 0/9] arm64: stacktrace: unify unwind code
Date:   Wed, 17 Nov 2021 14:07:28 +0000
Message-Id: <20211117140737.44420-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For historical reasons arm64 has a number of open-coded unwind functions. We'd
like to unify these to reduce the amount of unwind code we have to expose, and
to make it easier for subsequent patches to rework the unwind code for
RELIABLE_STACKTRACE.

These patches unify the various unwinders using arch_stack_walk(). So that we
can use arch_stack_walk() without having to expose /proc/${PID}/stack, I've
picked Peter's patch decoupling ARCH_STACKWALK from STACKTRACE, which was
previously posted at:

  https://lore.kernel.org/lkml/20211022152104.356586621@infradead.org/

As the direction of travel seems to be to not unify the get_wchan()
implementations, Peter suggested I pick the patch for now. This is the only
patch in the series touching other architectures.

The bulk of the series was perviously posted in Madhavan's series adding
reliability checks to the unwinder:

  https://lore.kernel.org/linux-arm-kernel/20211015025847.17694-1-madvenka@linux.microsoft.com/

I have made some minor tweaks and updated each commit message to explain why
the transformation is safe. Largely the changes should have no functional
effect, but in a couple of cases there is a (benign and/or desirable)
functional change, which is described in the relevant commit message.

To make it possible for get_wchan() to use arch_stack_walk(), and to correct
the expected behaviour of stack_trace_consume_entry_nosched() and
stack_trace_save_tsk(), we need to mark arm64's __switch_to() as __sched, for
which I've added a preparatory patch.

Currently this is based on the arm64 for-next/fixes branch, as the series
depends on a patch making arm64 using HAVE_FUNCTION_GRAPH_RET_ADDR_PTR:

  https://lore.kernel.org/all/20211027132529.30027-1-mark.rutland@arm.com/

I expect that this will be part of v5.16-rc2, and intend to rebase the series
once that's tagged.

Thanks,
Mark.

Madhavan T. Venkataraman (5):
  arm64: Make perf_callchain_kernel() use arch_stack_walk()
  arm64: Make __get_wchan() use arch_stack_walk()
  arm64: Make return_address() use arch_stack_walk()
  arm64: Make profile_pc() use arch_stack_walk()
  arm64: Make dump_backtrace() use arch_stack_walk()

Mark Rutland (3):
  arm64: Add comment for stack_info::kr_cur
  arm64: Mark __switch_to() as __sched
  arm64: Make some stacktrace functions private

Peter Zijlstra (1):
  arch: Make ARCH_STACKWALK independent of STACKTRACE

 arch/arm64/include/asm/stacktrace.h | 10 +++----
 arch/arm64/kernel/perf_callchain.c  | 13 ++------
 arch/arm64/kernel/process.c         | 44 ++++++++++++++++-----------
 arch/arm64/kernel/return_address.c  |  6 +---
 arch/arm64/kernel/stacktrace.c      | 60 ++++++++-----------------------------
 arch/arm64/kernel/time.c            | 23 +++++++-------
 arch/powerpc/kernel/Makefile        |  3 +-
 arch/riscv/kernel/stacktrace.c      |  4 ---
 arch/s390/kernel/Makefile           |  3 +-
 arch/x86/kernel/Makefile            |  2 +-
 include/linux/stacktrace.h          | 35 +++++++++++-----------
 11 files changed, 79 insertions(+), 124 deletions(-)

-- 
2.11.0

