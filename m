Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7133C6FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 13:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhGMLlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 07:41:53 -0400
Received: from foss.arm.com ([217.140.110.172]:41840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235623AbhGMLlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:41:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46CED1FB;
        Tue, 13 Jul 2021 04:39:02 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 32A0C3F7D8;
        Tue, 13 Jul 2021 04:38:59 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, elver@google.com,
        ink@jurassic.park.msu.ru, jonas@southpole.se,
        juri.lelli@redhat.com, linux@armlinux.org.uk, luto@kernel.org,
        mark.rutland@arm.com, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, mpe@ellerman.id.au, paulmck@kernel.org,
        paulus@samba.org, peterz@infradead.org, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, vincent.guittot@linaro.org, will@kernel.org
Subject: [PATCH v3 00/10] thread_info: use helpers to snapshot thread flags
Date:   Tue, 13 Jul 2021 12:38:32 +0100
Message-Id: <20210713113842.2106-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[apologies for the dupliate cover letter; I messed up the LKML address when I
first tried to send this out]

As thread_info::flags scan be manipulated by remote threads, it is
necessary to use atomics or READ_ONCE() to ensure that code manipulates
a consistent snapshot, but we open-code plain accesses to
thread_info::flags across the kernel tree.

Generally we get away with this, but tools like KCSAN legitimately warn
that there is a data-race, and this is potentially fragile with compiler
optimizations, LTO, etc.

These patches introduce new helpers to snahpshot the thread flags, with
the intent being that these should replace all plain accesses.

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

[1] https://lore.kernel.org/r/20210609122001.18277-1-mark.rutland@arm.com
[2] https://lore.kernel.org/r/87k0mvtgeb.fsf@mpe.ellerman.id.au
[3] https://lore.kernel.org/r/20210621090602.16883-1-mark.rutland@arm.com

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
 18 files changed, 45 insertions(+), 33 deletions(-)

-- 
2.11.0

