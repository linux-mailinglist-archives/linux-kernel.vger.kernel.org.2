Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DFB31B7BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 12:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhBOLDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 06:03:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:59416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhBOLD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 06:03:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11F40AD29;
        Mon, 15 Feb 2021 11:02:47 +0000 (UTC)
Date:   Mon, 15 Feb 2021 12:02:49 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/mm for v5.12
Message-ID: <20210215110249.GG23409@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the x86/mm pile (which has x86/cleanups too as they
topically belong together) for v5.12.

Thx.

---

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_v5.12

for you to fetch changes up to 40c1fa52cdb7c13ef88232e374b4b8ac8d820c4f:

  Merge branch 'x86/cleanups' into x86/mm (2021-02-12 13:40:02 +0100)

----------------------------------------------------------------
- PTRACE_GETREGS/PTRACE_PUTREGS regset selection cleanup

- Another initial cleanup - more to follow - to the fault handling code.

- Other minor cleanups and corrections.

----------------------------------------------------------------
Adrian Huang (1):
      x86/mm: Refine mmap syscall implementation

Alexey Dobriyan (1):
      x86/asm: Fixup TASK_SIZE_MAX comment

Anand K Mistry (1):
      x86/Kconfig: Remove HPET_EMULATE_RTC depends on RTC

Andy Lutomirski (15):
      x86/vm86/32: Remove VM86_SCREEN_BITMAP support
      x86/ptrace: Clean up PTRACE_GETREGS/PTRACE_PUTREGS regset selection
      x86/fault: Fix AMD erratum #91 errata fixup for user code
      x86/fault: Skip the AMD erratum #91 workaround on unaffected CPUs
      x86/fault: Fold mm_fault_error() into do_user_addr_fault()
      x86/fault/32: Move is_f00f_bug() to do_kern_addr_fault()
      x86/fault: Document the locking in the fault_signal_pending() path
      x86/fault: Correct a few user vs kernel checks wrt WRUSS
      x86/fault: Improve kernel-executing-user-memory handling
      x86/fault: Split the OOPS code out from no_context()
      x86/fault: Bypass no_context() for implicit kernel faults from usermode
      x86/fault: Rename no_context() to kernelmode_fixup_or_oops()
      x86/fault: Don't look for extable entries for SMEP violations
      x86/fault: Don't run fixups for SMAP violations
      x86/{fault,efi}: Fix and rename efi_recover_from_page_fault()

Arvind Sankar (1):
      x86/mm: Remove duplicate definition of _PAGE_PAT_LARGE

Hao Lee (1):
      x86/entry: Remove now unused do_IRQ() declaration

Ingo Molnar (1):
      Merge branch 'x86/cleanups' into x86/mm

Lorenzo Stoakes (1):
      x86/mm: Increase pgt_buf size for 5-level page tables

Tom Rix (1):
      x86: Remove definition of DEBUG

Zheng Yongjun (1):
      x86/mtrr: Convert comma to semicolon

 arch/x86/Kconfig                     |   2 +-
 arch/x86/include/asm/efi.h           |   2 +-
 arch/x86/include/asm/irq.h           |   2 -
 arch/x86/include/asm/page_64_types.h |   2 +-
 arch/x86/include/asm/pgtable_types.h |   2 -
 arch/x86/include/asm/vm86.h          |   1 -
 arch/x86/include/uapi/asm/vm86.h     |   4 +-
 arch/x86/kernel/cpu/mtrr/cleanup.c   |   4 +-
 arch/x86/kernel/cpu/mtrr/generic.c   |   1 -
 arch/x86/kernel/cpu/mtrr/mtrr.c      |   2 -
 arch/x86/kernel/pci-iommu_table.c    |   3 -
 arch/x86/kernel/ptrace.c             |  46 +++-
 arch/x86/kernel/sys_x86_64.c         |   8 +-
 arch/x86/kernel/vm86_32.c            |  62 ++----
 arch/x86/mm/fault.c                  | 403 ++++++++++++++++++-----------------
 arch/x86/mm/init.c                   |  19 +-
 arch/x86/mm/mmio-mod.c               |   2 -
 arch/x86/platform/efi/quirks.c       |  16 +-
 18 files changed, 298 insertions(+), 283 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
