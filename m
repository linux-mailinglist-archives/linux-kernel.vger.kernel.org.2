Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DD5445C77
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 23:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhKDXCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 19:02:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:49613 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232025AbhKDXCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 19:02:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="212554538"
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="212554538"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 15:59:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="490138569"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga007.jf.intel.com with ESMTP; 04 Nov 2021 15:59:52 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, mingo@redhat.com,
        chang.seok.bae@intel.com
Subject: [PATCH 0/4] x86/fpu: Make AMX state ready for CPU idle
Date:   Thu,  4 Nov 2021 15:52:22 -0700
Message-Id: <20211104225226.5031-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMX state is a large state (at least 8KB or more). Entering CPU idle with
this non-initialized large state may result in shallow states while a
deeper low-power state is available, [1].

This series ensures AMX states are initialized before entering CPU idle.

PATCH1 update the opcode table for TILERELEASE. PATCH2 introduces a helper
to make the state ready for CPU idle. But then this function can be located
in two different places:

  (a) Under arch_cpu_idle_enter(), which is called before 
      cpuidle_idle_call() or cpu_idle_poll() [2].
  (b) In drivers/idle/intel_idle.c, call this along with other idle code 
      such as intel_idle() or intel_idle_s2idle(), as per peterz's 
      suggestion [3].
 
The approach (a) may decouple the architecture-specific idle code from the
chip-specific code in the intel_idle driver. (b) tends to put them together
in one place.

Both approaches are included now -- PATCH3 has the approach (a) and so does
PATCH4 for (b). But it shouldn't be an issue to pick one of them
exclusively from this series.

The patchset is based on 30d02551ba4f ("x86/fpu: Optimize out sigframe
xfeatures when in init state") in the tip's x86/urgent branch, as calling
xgetbv(1) via xfeatures_in_use().

Thanks,
Chang

[1]: Intel Architecture Instruction Set Extension Programming Reference
     May 2021, https://software.intel.com/content/dam/develop/external/us/en/documents-tps/architecture-instruction-set-extensions-programming-reference.pdf
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/sched/idle.c
[3]: https://lore.kernel.org/lkml/YK+I8YEEnhWjuVAd@hirez.programming.kicks-ass.net/

Chang S. Bae (4):
  x86/insn/amx: Add TILERELEASE instruction to the opcode map
  x86/fpu: Add a helper to prepare AMX registers for CPU idle
  x86/fpu: Prepare AMX state for CPU idle
  intel_idle/amx: Add SPR support with XSTATE idle

 arch/x86/include/asm/fpu/api.h        |  2 +
 arch/x86/include/asm/special_insns.h  |  9 ++++
 arch/x86/kernel/fpu/core.c            | 21 +++++++++
 arch/x86/kernel/process.c             |  1 +
 arch/x86/lib/x86-opcode-map.txt       |  8 +++-
 drivers/idle/intel_idle.c             | 62 +++++++++++++++++++++++++++
 tools/arch/x86/lib/x86-opcode-map.txt |  8 +++-
 7 files changed, 109 insertions(+), 2 deletions(-)


base-commit: 30d02551ba4f681cfa605cedacf231b8641169f0
-- 
2.17.1

