Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5CF40ABB5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhINKbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:31:55 -0400
Received: from foss.arm.com ([217.140.110.172]:42694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231612AbhINKby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:31:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43C5F6D;
        Tue, 14 Sep 2021 03:30:36 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B3153F59C;
        Tue, 14 Sep 2021 03:30:33 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org
Cc:     benh@kernel.crashing.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, elver@google.com,
        ink@jurassic.park.msu.ru, jonas@southpole.se,
        juri.lelli@redhat.com, linux@armlinux.org.uk, luto@kernel.org,
        mark.rutland@arm.com, mattst88@gmail.com, michal.simek@xilinx.com,
        mpe@ellerman.id.au, paulmck@kernel.org, paulus@samba.org,
        rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, vincent.guittot@linaro.org,
        will@kernel.org
Subject: [PATCH v5 00/10] thread_info: use helpers to snapshot thread flags
Date:   Tue, 14 Sep 2021 11:30:17 +0100
Message-Id: <20210914103027.53565-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As thread_info::flags scan be manipulated by remote threads, it is
necessary to use atomics or READ_ONCE() to ensure that code manipulates
a consistent snapshot, but we open-code plain accesses to
thread_info::flags across the kernel tree.

Generally we get away with this, but tools like KCSAN legitimately warn
that there is a data-race, and this is potentially fragile with compiler
optimizations, LTO, etc.

These patches introduce new helpers to snahpshot the thread flags, with
the intent being that these should replace all plain accesses.

I've been assuming this would go via the TIP tree. TIP folk, are you happy to
pick this up, or would you be happy to pick at least the first three patches
which cover the core bits?

Since v1 [1]:
* Drop RFC
* Make read_ti_thread_flags() __always_inline
* Clarify commit messages
* Fix typo in arm64 patch
* Accumulate Reviewed-by / Acked-by tags
* Drop powerpc patch to avoid potential conflicts (per [2])

Since v2 [3]:
* Rebase to v5.14-rc1
* Reinstate powerpc patch

Since v3 [4]:
* Rebase to v5.14-rc4

Since v4 [5]:
* Rebase to v5.15-rc1
* Apply Acked-by / Tested-by tags

[1] https://lore.kernel.org/r/20210609122001.18277-1-mark.rutland@arm.com
[2] https://lore.kernel.org/r/87k0mvtgeb.fsf@mpe.ellerman.id.au
[3] https://lore.kernel.org/r/20210621090602.16883-1-mark.rutland@arm.com
[4] https://lore.kernel.org/r/20210713113842.2106-1-mark.rutland@arm.com
[5] https://lore.kernel.org/r/20210803095428.17009-1-mark.rutland@arm.com

Thanks,
Mark.

Mark Rutland (10):
  thread_info: add helpers to snapshot thread flags
  entry: snapshot thread flags
  sched: snapshot thread flags
  alpha: snapshot thread flags
  arm: snapshot thread flags
  arm64: snapshot thread flags
  microblaze: snapshot thread flags
  openrisc: snapshot thread flags
  powerpc: snapshot thread flags
  x86: snapshot thread flags

 arch/alpha/kernel/signal.c          |  2 +-
 arch/arm/kernel/signal.c            |  2 +-
 arch/arm/mm/alignment.c             |  2 +-
 arch/arm64/kernel/entry-common.c    |  2 +-
 arch/arm64/kernel/ptrace.c          |  4 ++--
 arch/arm64/kernel/signal.c          |  2 +-
 arch/arm64/kernel/syscall.c         |  4 ++--
 arch/microblaze/kernel/signal.c     |  2 +-
 arch/openrisc/kernel/signal.c       |  2 +-
 arch/powerpc/kernel/interrupt.c     | 13 ++++++-------
 arch/powerpc/kernel/ptrace/ptrace.c |  3 +--
 arch/x86/kernel/process.c           |  8 ++++----
 arch/x86/kernel/process.h           |  6 +++---
 arch/x86/mm/tlb.c                   |  2 +-
 include/linux/entry-kvm.h           |  2 +-
 include/linux/thread_info.h         | 14 ++++++++++++++
 kernel/entry/common.c               |  4 ++--
 kernel/entry/kvm.c                  |  4 ++--
 kernel/sched/core.c                 |  2 +-
 19 files changed, 46 insertions(+), 34 deletions(-)

-- 
2.11.0

