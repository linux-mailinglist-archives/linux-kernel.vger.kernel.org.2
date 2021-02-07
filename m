Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829563123A1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 11:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhBGKlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 05:41:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:44634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhBGKlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 05:41:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4C63CACF4;
        Sun,  7 Feb 2021 10:40:25 +0000 (UTC)
Date:   Sun, 7 Feb 2021 11:40:22 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.11-rc7
Message-ID: <20210207104022.GA32127@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I hope this is the last batch of x86/urgent updates for this round.

Pls pull,
thx.

---

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.11_rc7

for you to fetch changes up to 816ef8d7a2c4182e19bc06ab65751cb9e3951e94:

  x86/efi: Remove EFI PGD build time checks (2021-02-06 13:54:14 +0100)

----------------------------------------------------------------
- Remove superfluous EFI PGD range checks which lead to those assertions failing
with certain kernel configs and LLVM.

- Disable setting breakpoints on facilities involved in #DB exception handling
to avoid infinite loops.

- Add extra serialization to non-serializing MSRs (IA32_TSC_DEADLINE and
x2 APIC MSRs) to adhere to SDM's recommendation and avoid any theoretical
issues.

- Re-add the EPB MSR reading on turbostat so that it works on older
kernels which don't have the corresponding EPB sysfs file.

- Add Alder Lake to the list of CPUs which support split lock.

- Fix %dr6 register handling in order to be able to set watchpoints with gdb
again.

- Disable CET instrumentation in the kernel so that gcc doesn't add
ENDBR64 to kernel code and thus confuse tracing.

----------------------------------------------------------------
Borislav Petkov (2):
      tools/power/turbostat: Fallback to an MSR read for EPB
      x86/efi: Remove EFI PGD build time checks

Dave Hansen (1):
      x86/apic: Add extra serialization for non-serializing MSRs

Fenghua Yu (1):
      x86/split_lock: Enable the split lock feature on another Alder Lake CPU

Josh Poimboeuf (1):
      x86/build: Disable CET instrumentation in the kernel

Lai Jiangshan (2):
      x86/debug: Prevent data breakpoints on __per_cpu_offset
      x86/debug: Prevent data breakpoints on cpu_dr7

Peter Zijlstra (1):
      x86/debug: Fix DR6 handling

 Makefile                              |  6 ----
 arch/x86/Makefile                     |  3 ++
 arch/x86/include/asm/apic.h           | 10 ------
 arch/x86/include/asm/barrier.h        | 18 +++++++++++
 arch/x86/kernel/apic/apic.c           |  4 +++
 arch/x86/kernel/apic/x2apic_cluster.c |  6 ++--
 arch/x86/kernel/apic/x2apic_phys.c    |  9 ++++--
 arch/x86/kernel/cpu/intel.c           |  1 +
 arch/x86/kernel/hw_breakpoint.c       | 61 +++++++++++++++++++++++------------
 arch/x86/platform/efi/efi_64.c        | 19 -----------
 tools/power/x86/turbostat/turbostat.c | 10 +++++-
 11 files changed, 85 insertions(+), 62 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
