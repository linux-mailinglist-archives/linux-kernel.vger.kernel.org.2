Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA5C339C48
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 06:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhCMFtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 00:49:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:62600 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233225AbhCMFt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 00:49:26 -0500
IronPort-SDR: T5iuHPw42xsllUP6ZYWzUrUBvmLS/CEAw/DXl0ARUJBA4JquT7EM6IpzAsopgtGUqaqJT/KN0c
 SAU2jUS3yTLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="176050566"
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="176050566"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 21:49:25 -0800
IronPort-SDR: C7YjjHlc4YURp1MKCH7EVYDimlcM8FTJBVJzOwYX7sOj4SwjzSLxIXbYL69m2U1F/9Fr+Xt6mw
 BSbIY4ONZdrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="372880398"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga006.jf.intel.com with ESMTP; 12 Mar 2021 21:49:24 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 0/3] x86/bus_lock: Enable bus lock detection
Date:   Sat, 13 Mar 2021 05:49:07 +0000
Message-Id: <20210313054910.2503968-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bus lock [1] is acquired through either split locked access to
writeback (WB) memory or any locked access to non-WB memory. This is
typically >1000 cycles slower than an atomic operation within
a cache line. It also disrupts performance on other cores.

Although split lock can be detected by #AC trap, the trap is triggered
before the instruction acquires bus lock. This makes it difficult to
mitigate bus lock (e.g. throttle the user application).

Some CPUs have ability to notify the kernel by an #DB trap after a user
instruction acquires a bus lock and is executed. This allows the kernel
to enforce user application throttling or mitigations.

#DB for bus lock detect fixes issues in #AC for split lock detect:
1) It's architectural ... just need to look at one CPUID bit to know it
   exists
2) The IA32_DEBUGCTL MSR, which reports bus lock in #DB, is per-thread.
   So each process or guest can have different behavior.
3) It has support for VMM/guests (new VMEXIT codes, etc).
4) It detects not only split locks but also bus locks from non-WB.

Hardware only generates #DB for bus lock detect when CPL>0 to avoid
nested #DB from multiple bus locks while the first #DB is being handled.

Use the existing kernel command line parameter "split_lock_detect=" to
handle #DB for bus lock with an additional option "ratelimit=N" to set
bus lock rate limit for a user.

[1] Intel Instruction Set Extension Chapter 9:
https://software.intel.com/content/dam/develop/public/us/en/documents/architecture-instruction-set-extensions-programming-reference.pdf

Change Log:
v5:
Address all comments from Thomas:
- In the cover letter, update the latest ISE link to include the #DB
  for bus lock spec.
- In patch 1, add commit message for breakpoint and bus lock on the same
  instruction.
- In patch 2, change warn to #AC if both #AC and #DB are supported, remove
  sld and bld variables, remove bus lock checking in handle_bus_lock() etc.
- In patch 3 and 4, remove bld_ratelimit < HZ/2 check and define
  bld_ratelimit only for Intel CPUs.
- Merge patch 2 and 3 into one patch for handling warn, fatal, and
  ratelimit.
v4 is here: https://lore.kernel.org/lkml/20201124205245.4164633-2-fenghua.yu@intel.com/

v4:
- Fix a ratelimit wording issue in the doc (Randy).
- Patch 4 is acked by Randy (Randy).

v3:
- Enable Bus Lock Detection when fatal to handle bus lock from non-WB
  (PeterZ).
- Add Acked-by: PeterZ in patch 2.

v2:
- Send SIGBUS in fatal case for bus lock #DB (PeterZ).

v1:
- Check bus lock bit by its positive polarity (Xiaoyao).
- Fix a few wording issues in the documentation (Randy).
[RFC v3 can be found at: https://lore.kernel.org/patchwork/cover/1329943/]

RFC v3:
- Remove DR6_RESERVED change (PeterZ).
- Simplify the documentation (Randy).

RFC v2:
- Architecture changed based on feedback from Thomas and PeterZ. #DB is
  no longer generated for bus lock in ring0.
- Split the one single patch into four patches.
[RFC v1 can be found at: https://lore.kernel.org/lkml/1595021700-68460-1-git-send-email-fenghua.yu@intel.com/]

Fenghua Yu (3):
  x86/cpufeatures: Enumerate #DB for bus lock detection
  x86/bus_lock: Handle #DB for bus lock
  Documentation/admin-guide: Change doc for split_lock_detect parameter

 .../admin-guide/kernel-parameters.txt         |  30 +++-
 arch/x86/include/asm/cpu.h                    |  10 +-
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   1 +
 arch/x86/include/uapi/asm/debugreg.h          |   1 +
 arch/x86/kernel/cpu/common.c                  |   2 +-
 arch/x86/kernel/cpu/intel.c                   | 148 +++++++++++++++---
 arch/x86/kernel/traps.c                       |   7 +
 include/linux/sched/user.h                    |   5 +-
 kernel/user.c                                 |  13 ++
 10 files changed, 187 insertions(+), 31 deletions(-)

-- 
2.30.2

