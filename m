Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B03436C0BD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhD0IYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:24:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:38450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230228AbhD0IYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:24:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 95D72B001;
        Tue, 27 Apr 2021 08:23:48 +0000 (UTC)
Date:   Tue, 27 Apr 2021 10:23:46 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/core for v5.13
Message-ID: <YIfKEkC2lghJJHda@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

x86/core was special this time around - we had a bunch of cross-
dependencies due to parallel development happening, as it is noticeable
from the (well documented :)) merge commits. Eventually, we ended up
closing x86/cpu for this round, in favor of this branch. Thus, as a
result, it has a lot of fancy new stuff in it, see tag message.

Please pull,
thx.

---

The following changes since commit a5e13c6df0e41702d2b2c77c8ad41677ebb065b3:

  Linux 5.12-rc5 (2021-03-28 15:48:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v5.13

for you to fetch changes up to 2c88d45edbb89029c1190bb3b136d2602f057c98:

  x86, sched: Treat Intel SNC topology as default, COD as exception (2021-04-15 18:34:20 +0200)

----------------------------------------------------------------
- turn the stack canary into a normal __percpu variable on 32-bit which
gets rid of the LAZY_GS stuff and a lot of code.

- Add an insn_decode() API which all users of the instruction decoder
should preferrably use. Its goal is to keep the details of the
instruction decoder away from its users and simplify and streamline how
one decodes insns in the kernel. Convert its users to it.

- kprobes improvements and fixes

- Set the maximum DIE per package variable on Hygon

- Rip out the dynamic NOP selection and simplify all the machinery around
selecting NOPs. Use the simplified NOPs in objtool now too.

- Add Xeon Sapphire Rapids to list of CPUs that support PPIN

- Simplify the retpolines by folding the entire thing into an
alternative now that objtool can handle alternatives with stack
ops. Then, have objtool rewrite the call to the retpoline with the
alternative which then will get patched at boot time.

- Document Intel uarch per models in intel-family.h

- Make Sub-NUMA Clustering topology the default and Cluster-on-Die the
exception on Intel.

----------------------------------------------------------------
Alison Schofield (1):
      x86, sched: Treat Intel SNC topology as default, COD as exception

Andrew Cooper (1):
      x86/cpu: Comment Skylake server stepping too

Andy Lutomirski (2):
      x86/stackprotector/32: Make the canary into a regular percpu variable
      x86/entry/32: Remove leftover macros after stackprotector cleanups

Borislav Petkov (25):
      Merge tag 'v5.12-rc3' into x86/core
      Merge 'x86/seves' into x86/core
      x86/insn: Rename insn_decode() to insn_decode_from_regs()
      x86/insn: Add @buf_len param to insn_init() kernel-doc comment
      x86/insn: Add a __ignore_sync_check__ marker
      x86/insn: Add an insn_decode() API
      x86/insn-eval: Handle return values from the decoder
      x86/boot/compressed/sev-es: Convert to insn_decode()
      perf/x86/intel/ds: Check insn_get_length() retval
      perf/x86/intel/ds: Check return values of insn decoder functions
      x86/alternative: Use insn_decode()
      x86/mce: Convert to insn_decode()
      x86/kprobes: Convert to insn_decode()
      x86/sev-es: Split vc_decode_insn()
      x86/sev-es: Convert to insn_decode()
      x86/traps: Convert to insn_decode()
      x86/uprobes: Convert to insn_decode()
      x86/tools/insn_decoder_test: Convert to insn_decode()
      tools/objtool: Convert to insn_decode()
      x86/tools/insn_sanity: Convert to insn_decode()
      tools/perf: Convert to insn_decode()
      x86/insn: Remove kernel_insn_init()
      x86/insn: Make insn_complete() static
      tools/insn: Restore the relative include paths for cross building
      Merge 'x86/alternatives'

Ingo Molnar (2):
      Merge tag 'v5.12-rc5' into WIP.x86/core, to pick up recent NOP related changes
      Merge branch 'x86/cpu' into WIP.x86/core, to merge the NOP changes & resolve a semantic conflict

Masami Hiramatsu (5):
      x86/kprobes: Retrieve correct opcode for group instruction
      x86/kprobes: Identify far indirect JMP correctly
      x86/kprobes: Use int3 instead of debug trap for single-step
      x86/kprobes: Fix to check non boostable prefixes correctly
      x86/kprobes: Fix to identify indirect jmp and others using range case

Peter Zijlstra (19):
      x86: Remove dynamic NOP selection
      objtool/x86: Use asm/nops.h
      x86: Add insn_decode_kernel()
      x86/alternatives: Optimize optimize_nops()
      x86/retpoline: Simplify retpolines
      objtool: Correctly handle retpoline thunk calls
      objtool: Handle per arch retpoline naming
      objtool: Fix static_call list generation
      objtool: Rework the elf_rebuild_reloc_section() logic
      objtool: Add elf_create_reloc() helper
      objtool: Create reloc sections implicitly
      objtool: Extract elf_strtab_concat()
      objtool: Extract elf_symbol_add()
      objtool: Add elf_create_undef_symbol()
      objtool: Keep track of retpoline call sites
      objtool: Cache instruction relocs
      objtool: Skip magical retpoline .altinstr_replacement
      objtool/x86: Rewrite retpoline thunk calls
      x86/cpu: Resort and comment Intel models

Pu Wen (1):
      x86/cpu/hygon: Set __max_die_per_package on Hygon

Tony Luck (1):
      x86/mce: Add Xeon Sapphire Rapids to list of CPUs that support PPIN

Wei Yongjun (1):
      x86/kprobes: Move 'inline' to the beginning of the kprobe_is_ss() declaration

 arch/arm/include/asm/paravirt.h                    |  14 +-
 arch/arm/kernel/paravirt.c                         |   9 +-
 arch/arm64/include/asm/paravirt.h                  |  14 +-
 arch/arm64/kernel/paravirt.c                       |  13 +-
 arch/x86/Kconfig                                   |   9 +-
 arch/x86/Makefile                                  |   8 +
 arch/x86/boot/compressed/sev-es.c                  |  11 +-
 arch/x86/entry/entry_32.S                          | 101 +---
 arch/x86/entry/entry_64.S                          |   2 +-
 arch/x86/entry/vdso/vdso32/system_call.S           |   2 +-
 arch/x86/events/intel/ds.c                         |  11 +-
 arch/x86/events/intel/lbr.c                        |  10 +-
 arch/x86/include/asm/alternative-asm.h             | 114 ----
 arch/x86/include/asm/alternative.h                 | 149 +++++-
 arch/x86/include/asm/asm-prototypes.h              |  13 +-
 arch/x86/include/asm/cpufeature.h                  |  41 +-
 arch/x86/include/asm/cpufeatures.h                 |   4 +-
 arch/x86/include/asm/inat.h                        |   2 +-
 arch/x86/include/asm/insn-eval.h                   |   4 +-
 arch/x86/include/asm/insn.h                        |  46 +-
 arch/x86/include/asm/intel-family.h                |  52 +-
 arch/x86/include/asm/irqflags.h                    |   7 +-
 arch/x86/include/asm/jump_label.h                  |  12 +-
 arch/x86/include/asm/kprobes.h                     |  21 +-
 arch/x86/include/asm/mshyperv.h                    |   2 +-
 arch/x86/include/asm/nops.h                        | 176 ++----
 arch/x86/include/asm/nospec-branch.h               |   7 +-
 arch/x86/include/asm/paravirt.h                    | 167 +++---
 arch/x86/include/asm/paravirt_types.h              | 210 +++-----
 arch/x86/include/asm/processor.h                   |  15 +-
 arch/x86/include/asm/ptrace.h                      |   5 +-
 arch/x86/include/asm/segment.h                     |  30 +-
 arch/x86/include/asm/smap.h                        |   5 +-
 arch/x86/include/asm/special_insns.h               |   4 +-
 arch/x86/include/asm/stackprotector.h              |  79 +--
 arch/x86/include/asm/suspend_32.h                  |   6 +-
 arch/x86/kernel/Makefile                           |   3 +-
 arch/x86/kernel/alternative.c                      | 299 ++++-------
 arch/x86/kernel/asm-offsets.c                      |   7 -
 arch/x86/kernel/asm-offsets_32.c                   |   5 -
 arch/x86/kernel/cpu/amd.c                          |   5 -
 arch/x86/kernel/cpu/common.c                       |   5 +-
 arch/x86/kernel/cpu/hygon.c                        |   4 +-
 arch/x86/kernel/cpu/mce/intel.c                    |   1 +
 arch/x86/kernel/cpu/mce/severity.c                 |  12 +-
 arch/x86/kernel/cpu/vmware.c                       |   5 +-
 arch/x86/kernel/doublefault_32.c                   |   4 +-
 arch/x86/kernel/ftrace.c                           |   4 +-
 arch/x86/kernel/head_32.S                          |  18 +-
 arch/x86/kernel/jump_label.c                       |  32 +-
 arch/x86/kernel/kprobes/core.c                     | 596 +++++++++++++--------
 arch/x86/kernel/kprobes/opt.c                      |   9 +-
 arch/x86/kernel/kvm.c                              |   2 +-
 arch/x86/kernel/kvmclock.c                         |   2 +-
 arch/x86/kernel/paravirt-spinlocks.c               |   9 +
 arch/x86/kernel/paravirt.c                         |  75 +--
 arch/x86/kernel/paravirt_patch.c                   |  99 ----
 arch/x86/kernel/setup.c                            |   1 -
 arch/x86/kernel/setup_percpu.c                     |   1 -
 arch/x86/kernel/sev-es.c                           |  63 ++-
 arch/x86/kernel/smpboot.c                          |  90 ++--
 arch/x86/kernel/static_call.c                      |   4 +-
 arch/x86/kernel/tls.c                              |   8 +-
 arch/x86/kernel/traps.c                            |  10 +-
 arch/x86/kernel/tsc.c                              |   3 +-
 arch/x86/kernel/umip.c                             |   2 +-
 arch/x86/kernel/uprobes.c                          |   8 +-
 arch/x86/lib/atomic64_386_32.S                     |   2 +-
 arch/x86/lib/atomic64_cx8_32.S                     |   2 +-
 arch/x86/lib/copy_page_64.S                        |   2 +-
 arch/x86/lib/copy_user_64.S                        |   2 +-
 arch/x86/lib/inat.c                                |   2 +-
 arch/x86/lib/insn-eval.c                           |  44 +-
 arch/x86/lib/insn.c                                | 230 ++++++--
 arch/x86/lib/memcpy_64.S                           |   2 +-
 arch/x86/lib/memmove_64.S                          |   2 +-
 arch/x86/lib/memset_64.S                           |   2 +-
 arch/x86/lib/retpoline.S                           |  67 ++-
 arch/x86/mm/mem_encrypt.c                          |   6 +
 arch/x86/net/bpf_jit_comp.c                        |  10 +-
 arch/x86/platform/pvh/head.S                       |  14 -
 arch/x86/power/cpu.c                               |   6 +-
 arch/x86/tools/insn_decoder_test.c                 |  10 +-
 arch/x86/tools/insn_sanity.c                       |   8 +-
 arch/x86/xen/enlighten_pv.c                        |   5 +-
 arch/x86/xen/time.c                                |  26 +-
 drivers/xen/time.c                                 |   3 +-
 include/linux/static_call.h                        |  26 +-
 include/linux/static_call_types.h                  |  18 +
 scripts/gcc-x86_32-has-stack-protector.sh          |   6 +-
 tools/arch/x86/include/asm/inat.h                  |   2 +-
 tools/arch/x86/include/asm/insn.h                  |  46 +-
 tools/arch/x86/include/asm/nops.h                  |  81 +++
 tools/arch/x86/lib/inat.c                          |   2 +-
 tools/arch/x86/lib/insn.c                          | 230 ++++++--
 tools/include/linux/kconfig.h                      |  73 +++
 tools/include/linux/static_call_types.h            |  18 +
 tools/objtool/arch/x86/decode.c                    | 144 ++++-
 tools/objtool/arch/x86/include/arch/special.h      |   2 +-
 tools/objtool/check.c                              | 183 ++++---
 tools/objtool/elf.c                                | 289 +++++++---
 tools/objtool/include/objtool/arch.h               |   4 +
 tools/objtool/include/objtool/check.h              |   3 +-
 tools/objtool/include/objtool/elf.h                |  13 +-
 tools/objtool/include/objtool/objtool.h            |   1 +
 tools/objtool/objtool.c                            |   1 +
 tools/objtool/orc_gen.c                            |  33 +-
 tools/objtool/special.c                            |  12 +-
 tools/objtool/sync-check.sh                        |  18 +-
 tools/perf/arch/x86/tests/insn-x86.c               |   9 +-
 tools/perf/arch/x86/util/archinsn.c                |   9 +-
 tools/perf/check-headers.sh                        |  15 +-
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |  17 +-
 113 files changed, 2399 insertions(+), 2062 deletions(-)
 delete mode 100644 arch/x86/include/asm/alternative-asm.h
 delete mode 100644 arch/x86/kernel/paravirt_patch.c
 create mode 100644 tools/arch/x86/include/asm/nops.h
 create mode 100644 tools/include/linux/kconfig.h

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
