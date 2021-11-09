Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F42E44B1F4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 18:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240951AbhKIR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 12:27:06 -0500
Received: from foss.arm.com ([217.140.110.172]:36476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240407AbhKIR1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:27:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02973101E;
        Tue,  9 Nov 2021 09:24:17 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A54A63F800;
        Tue,  9 Nov 2021 09:24:15 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     ardb@kernel.org, catalin.marinas@arm.com, frederic@kernel.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org
Subject: [PATCH 0/6] arm64 / sched/preempt: support PREEMPT_DYNAMIC with static keys
Date:   Tue,  9 Nov 2021 17:24:02 +0000
Message-Id: <20211109172408.49641-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables PREEMPT_DYNAMIC on arm64, offering an alternative approach
to other efforts which rely on enabling static_calls, e.g. as Ard is currently
attempting:

  https://lore.kernel.org/linux-arm-kernel/20211105145917.2828911-1-ardb@kernel.org/

For a number of reasons (laid out in grauitous detail in patch 5), static calls
are somewhat painful on arm64. For PREEMPT_DYNAMIC specifically where we're
only enabling/disabling functions rather than targetting multiple distinct
callees, (non-inline) static calls don't buy us much over placing early returns
in the preemption functions, which this series implements using static keys.

The first 4 patches are largely cleanup, and I think might make sense on their
own. Patch 3 specifically change the behaviour on x86 where I believe there's
simply an oversight, called out in the commit message.

I think the diffstate can be reduced a bit by with some helper macros to reduce
amount of boilerplate needed for the callees. There's also some room for
cleanup of the existing preempt logic to require less arch code (other than
where x86 has to override that today).

I've given this very light build+boot testing so far.

Thanks,
Mark.

Mark Rutland (6):
  sched/preempt: move PREEMPT_DYNAMIC logic later
  sched/preempt: refactor sched_dynamic_update()
  sched/preempt: simplify irqentry_exit_cond_resched() callers
  sched/preempt: decouple HAVE_PREEMPT_DYNAMIC from GENERIC_ENTRY
  sched/preempt: add PREEMPT_DYNAMIC using static keys
  arm64: support PREEMPT_DYNAMIC

 arch/Kconfig                     |  14 +-
 arch/arm64/Kconfig               |   1 +
 arch/arm64/include/asm/preempt.h |  16 +-
 arch/arm64/kernel/entry-common.c |   9 +
 arch/x86/Kconfig                 |   2 +-
 arch/x86/include/asm/preempt.h   |  10 +-
 include/linux/entry-common.h     |  15 +-
 include/linux/kernel.h           |   7 +-
 include/linux/sched.h            |  10 +-
 kernel/entry/common.c            |  22 ++-
 kernel/sched/core.c              | 347 +++++++++++++++++++++++----------------
 11 files changed, 293 insertions(+), 160 deletions(-)

-- 
2.11.0

