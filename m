Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC81376914
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbhEGQyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236947AbhEGQyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:54:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 279ED6145D;
        Fri,  7 May 2021 16:53:03 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 5.13-rc1 (2nd set)
Date:   Fri,  7 May 2021 17:53:02 +0100
Message-Id: <20210507165302.1626-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 updates below. They contain a mix of fixes and
clean-ups that turned up too late for the first pull request this
merging window. There is a trivial conflict in alternative.c, my
resolution is at the end of this email.

Thanks.

The following changes since commit a27a8816568964fcef62a3ae5f9d2228ec1ebc68:

  Merge branch 'for-next/pac-set-get-enabled-keys' into for-next/core (2021-04-15 14:00:48 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to c76fba33467b96b8234a1bbef852cd257c0dca69:

  arm64: kernel: Update the stale comment (2021-05-06 12:26:26 +0100)

----------------------------------------------------------------
Assorted arm64 fixes and clean-ups, the most important:

- Restore terminal stack frame records. Their previous removal caused
  traces which cross secondary_start_kernel to terminate one entry too
  late, with a spurious "0" entry.

- Fix boot warning with pseudo-NMI due to the way we manipulate the PMR
  register.

- ACPI fixes: avoid corruption of interrupt mappings on watchdog probe
  failure (GTDT), prevent unregistering of GIC SGIs.

- Force SPARSEMEM_VMEMMAP as the only memory model, it saves with having
  to test all the other combinations.

- Documentation fixes and updates: tagged address ABI exceptions on
  brk/mmap/mremap(), event stream frequency, update booting requirements
  on the configuration of traps.

----------------------------------------------------------------
Bill Wendling (1):
      arm64/vdso: Discard .note.gnu.property sections in vDSO

Catalin Marinas (3):
      arm64: Force SPARSEMEM_VMEMMAP as the only memory management model
      arm64: doc: Add brk/mmap/mremap() to the Tagged Address ABI Exceptions
      arm64: Fix the documented event stream frequency

Jisheng Zhang (1):
      arm64: remove HAVE_DEBUG_BUGVERBOSE

Marc Zyngier (2):
      ACPI: GTDT: Don't corrupt interrupt mappings on watchdow probe failure
      ACPI: irq: Prevent unregistering of GIC SGIs

Mark Brown (3):
      arm64: Relax booting requirements for configuration of traps
      arm64: Explicitly require that FPSIMD instructions do not trap
      arm64: Explicitly document boot requirements for SVE

Mark Rutland (3):
      arm64: alternative: simplify passing alt_region
      arm64: stacktrace: restore terminal records
      arm64: entry: always set GIC_PRIO_PSR_I_SET during entry

Matthew Wilcox (Oracle) (1):
      arm64: Show three registers per line

Nick Desaulniers (1):
      arm64: vdso32: drop -no-integrated-as flag

Shaokun Zhang (1):
      arm64: kernel: Update the stale comment

Yang Li (1):
      psci: Remove unneeded semicolon

kernel test robot (1):
      arm64: cpufeatures: use min and max

 Documentation/arm64/booting.rst            | 33 +++++++++++++++++++++++++++++-
 Documentation/arm64/elf_hwcaps.rst         |  2 +-
 Documentation/arm64/tagged-address-abi.rst |  6 ++++++
 arch/arm64/Kconfig                         | 11 +---------
 arch/arm64/include/asm/daifflags.h         |  3 +++
 arch/arm64/include/asm/kernel-pgtable.h    |  2 +-
 arch/arm64/include/asm/memory.h            |  4 ++--
 arch/arm64/include/asm/sparsemem.h         |  3 ---
 arch/arm64/kernel/alternative.c            |  3 +--
 arch/arm64/kernel/cpufeature.c             |  5 +++--
 arch/arm64/kernel/cpuidle.c                |  2 +-
 arch/arm64/kernel/entry-common.c           | 17 ---------------
 arch/arm64/kernel/entry.S                  | 21 +++++--------------
 arch/arm64/kernel/process.c                |  9 +++-----
 arch/arm64/kernel/stacktrace.c             | 10 +++++----
 arch/arm64/kernel/vdso/vdso.lds.S          |  8 +++++++-
 arch/arm64/kernel/vdso32/Makefile          |  8 --------
 arch/arm64/mm/init.c                       |  8 ++------
 arch/arm64/mm/mmu.c                        |  2 --
 arch/arm64/mm/ptdump.c                     |  2 --
 drivers/acpi/arm64/gtdt.c                  | 10 +++++----
 drivers/acpi/irq.c                         |  6 +++++-
 drivers/firmware/psci/psci.c               |  2 +-
 23 files changed, 86 insertions(+), 91 deletions(-)

Conflict with current mainline (a48b0872e694):

-------------------8<--------------------------
diff --cc arch/arm64/kernel/alternative.c
index abc84636af07,f6fd16185040..f6aa38436f56
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@@ -133,11 -133,10 +133,10 @@@ static void clean_dcache_range_nopatch(
  	} while (cur += d_size, cur < end);
  }
  
- static void __nocfi __apply_alternatives(void *alt_region,  bool is_module,
 -static void __apply_alternatives(struct alt_region *region, bool is_module,
 -				 unsigned long *feature_mask)
++static void __nocfi __apply_alternatives(struct alt_region *region, bool is_module,
 +					 unsigned long *feature_mask)
  {
  	struct alt_instr *alt;
- 	struct alt_region *region = alt_region;
  	__le32 *origptr, *updptr;
  	alternative_cb_t alt_cb;
  
