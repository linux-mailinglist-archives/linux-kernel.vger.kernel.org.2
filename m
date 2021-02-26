Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035F03264D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 16:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhBZPk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 10:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZPk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 10:40:26 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A250EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 07:39:44 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id t29so6477159pfg.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 07:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=a62UGN6nuLCBw5kbxfu+mOF0axpW0xIBvD2Q50Sh2ek=;
        b=BMXny/tacBcad3UJc61+sgVgyTIFzIUOsZn7ZfZ/u6IcLb2u/PUpLD9ocWA4BHrUWp
         2CtxITVhhLaBDzUyJpO0tFXdixcigjtqNhGliQM0sdkYZAQFjR4NKr304Qs7qVi2oJcZ
         xEF+gaxE5DhnPI9eM22XjLETs7bX2MjWzlZHcNmATLmBr0enMjZiaRKXqqMMG/xmfpmd
         J5afHSVn5ISOS8buz/vV3ZuP7jJ+zcrTVMfZ5cV+AItokHVjkHAtzTL/PQ9xgM5d66Y6
         MXLFs/x3MMcW6pYopbI+WC3PtlyeMvAuLvftnb57Es+Dgfq1bQ3u/I4MQd6bcAoNMUzA
         fw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=a62UGN6nuLCBw5kbxfu+mOF0axpW0xIBvD2Q50Sh2ek=;
        b=k0Je/yVt8PYJLPY/xO7qrUquoBAb6eZHwxe3Tg38kv4csPBGXd9dRRmTS13AqmBfaT
         ndYZV6d/G9YS71Dd9JZxwQOvn39kGLej0wOHX+ZYmLxZFZFK+4VOzI0NjHveavatOd4S
         w8FaQvC0ocP/qUsR9cE73TuJynZy26q7y+AXUpQvrEQ0jGlaXZtq4lLA13TAPagUd4WF
         rEjDpz76cJGKmpCEltWdX3QluIV563Wz+vD2xxCDBG6qGkIsNTOrGKbikF6b5uAGKRvh
         lNhuu1E8KI7d3Cpt2faQH4X51nKTyQimvgdETwKcziJjhYvvKDwLTEtCj3MjGDK3y8cx
         4tiA==
X-Gm-Message-State: AOAM530jrSYsiq3fPm252fSHNe289+rLW4R7VmpIv0G4XUJVtiaAm+xR
        Fqp69/W9egDCVNtPadJsm8ZLtQ==
X-Google-Smtp-Source: ABdhPJze6eWRiK8IIfPywvHEcYpEk18V7K+AWLFZbRCAz+zATXqUpUO0WKCp4A72dP5Kk55BjkCf9Q==
X-Received: by 2002:a65:480c:: with SMTP id h12mr3358780pgs.169.1614353983089;
        Fri, 26 Feb 2021 07:39:43 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u128sm10510941pfc.192.2021.02.26.07.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 07:39:42 -0800 (PST)
Date:   Fri, 26 Feb 2021 07:39:42 -0800 (PST)
X-Google-Original-Date: Fri, 26 Feb 2021 07:39:40 PST (-0800)
Subject: [GIT PULL] RISC-V Patches for the 5.12 Merge Window
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-fc1ac1f4-4558-4cfc-aef5-bc486eed7953@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.12-mw0

for you to fetch changes up to d7fbcf40df86bb67193d9faf52138fc1202decb2:

  riscv: Improve kasan population by using hugepages when possible (2021-02-22 18:54:17 -0800)

----------------------------------------------------------------
RISC-V Patches for the 5.12 Merge Window

I have a handful of new RISC-V related patches for this merge window:

* A check to ensure drivers are properly using uaccess.  This isn't
  manifesting with any of the drivers I'm currently using, but may catch
  errors in new drivers.
* Some preliminary support for the FU740, along with the HiFive
  Unleashed it will appear on.
* NUMA support for RISC-V, which involves making the arm64 code generic.
* Support for kasan on the vmalloc region.
* A handful of new drivers for the Kendryte K210, along with the DT
  plumbing required to boot on a handful of K210-based boards.
* Support for allocating ASIDs.
* Preliminary support for kernels larger than 128MiB.
* Various other improvements to our KASAN support, including the
  utilization of huge pages when allocating the KASAN regions.

We may have already found a bug with the KASAN_VMALLOC code, but it's
passing my tests.  There's a fix in the works, but that will probably
miss the merge window.

---

We have a handful of merge conflicts this round.  Here are my resolutions.  The
arm64 one was part of the NUMA cleanup, the other two were part of the Kendryte
rename (it's Canaan now, and it's alphabetically sorted).

diff --cc arch/arm64/mm/Makefile
index cd60e4fed78f,77222d92667a..f188c9092696
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@@ -6,6 -6,8 +6,7 @@@ obj-y				:= dma-mapping.o extable.o fau
  obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
  obj-$(CONFIG_PTDUMP_CORE)	+= ptdump.o
  obj-$(CONFIG_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
+ obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd.o
 -obj-$(CONFIG_NUMA)		+= numa.o
  obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
  obj-$(CONFIG_ARM64_MTE)		+= mteswap.o
  KASAN_SANITIZE_physaddr.o	+= n
diff --cc drivers/soc/Kconfig
index c0143651f4a9,f357c6c659d2..e8a30c4c5aec
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@@ -23,6 -22,6 +23,5 @@@ source "drivers/soc/ti/Kconfig
  source "drivers/soc/ux500/Kconfig"
  source "drivers/soc/versatile/Kconfig"
  source "drivers/soc/xilinx/Kconfig"
- source "drivers/soc/zte/Kconfig"
 -source "drivers/soc/kendryte/Kconfig"

  endmenu
diff --cc drivers/soc/Makefile
index 34b23645be14,9bceb12b291d..f678e4d9e585
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@@ -29,4 -28,4 +29,3 @@@ obj-y				+= ti
  obj-$(CONFIG_ARCH_U8500)	+= ux500/
  obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
  obj-y				+= xilinx/
- obj-$(CONFIG_ARCH_ZX)		+= zte/
 -obj-$(CONFIG_SOC_KENDRYTE)	+= kendryte/

----------------------------------------------------------------
Alexandre Ghiti (5):
      riscv: Get rid of MAX_EARLY_MAPPING_SIZE
      riscv: Improve kasan definitions
      riscv: Use KASAN_SHADOW_INIT define for kasan memory initialization
      riscv: Improve kasan population function
      riscv: Improve kasan population by using hugepages when possible

Anup Patel (1):
      RISC-V: Implement ASID allocator

Atish Patra (5):
      arm64, numa: Change the numa init functions name to be generic
      numa: Move numa implementation to common code
      riscv: Separate memory init from paging init
      riscv: Add numa support for riscv64 platform
      RISC-V: Add a non-void return for sbi v02 functions

Chen Huang (1):
      riscv/stacktrace: Fix stack output without ra on the stack top

Chengyang Fan (1):
      RISC-V: remove unneeded semicolon

Damien Le Moal (26):
      riscv: Fix builtin DTB handling
      riscv: Use vendor name for K210 SoC support
      riscv: Fix Canaan Kendryte K210 device tree
      riscv: cleanup Canaan Kendryte K210 sysctl driver
      dt-binding: mfd: Document canaan,k210-sysctl bindings
      dt-bindings: reset: Document canaan,k210-rst bindings
      dt-bindings: pinctrl: Document canaan,k210-fpioa bindings
      riscv: Add Canaan Kendryte K210 reset controller
      pinctrl: Add RISC-V Canaan Kendryte K210 FPIOA driver
      clk: Add RISC-V Canaan Kendryte K210 clock driver
      dt-bindings: update MAINTAINERS file
      dt-bindings: add Canaan boards compatible strings
      dt-bindings: update risc-v cpu properties
      dt-bindings: update sifive plic compatible string
      dt-bindings: update sifive clint compatible string
      dt-bindings: update sifive uart compatible string
      dt-bindings: fix sifive gpio properties
      dt-bindings: add resets property to dw-apb-timer
      riscv: Update Canaan Kendryte K210 device tree
      riscv: Add SiPeed MAIX BiT board device tree
      riscv: Add SiPeed MAIX DOCK board device tree
      riscv: Add SiPeed MAIX GO board device tree
      riscv: Add SiPeed MAIXDUINO board device tree
      riscv: Add Kendryte KD233 board device tree
      riscv: Update Canaan Kendryte K210 defconfig
      riscv: Add Canaan Kendryte K210 SD card defconfig

Eric Lin (2):
      riscv/mm: Introduce a die_kernel_fault() helper function
      riscv/mm: Prevent kernel module to access user memory without uaccess routines

Greentime Hu (1):
      riscv: Add support pte_protnone and pmd_protnone if CONFIG_NUMA_BALANCING

Guo Ren (9):
      riscv: Fixup compile error BUILD_BUG_ON failed
      riscv: Fixup wrong ftrace remove cflag
      riscv: Fixup patch_text panic in ftrace
      riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT
      riscv: Add kprobes supported
      riscv: Add KPROBES_ON_FTRACE supported
      riscv: Add uprobes supported
      riscv: Add support for function error injection
      riscv: Enable per-task stack canaries

Kefeng Wang (8):
      riscv: Cleanup sbi function stubs when RISCV_SBI disabled
      riscv: Add machine name to kernel boot log and stack dump output
      riscv: Add dump stack in show_regs
      riscv: Improve __show_regs
      initrd: Add the preprocessor guard in initrd.h
      initramfs: Provide a common initrd reserve function
      riscv: Covert to reserve_initrd_mem()
      riscv: Remove unnecessary declaration

Nylon Chen (1):
      riscv/kasan: add KASAN_VMALLOC support

Palmer Dabbelt (2):
      RISC-V: probes: Treat the instruction stream as host-endian
      soc: canaan: Sort the Makefile alphabetically

Patrick Stählin (1):
      RISC-V: Implement ptrace regs and stack API

Randy Dunlap (1):
      arch_numa: fix common code printing of phys_addr_t

Tobias Klauser (1):
      riscv: Disable KSAN_SANITIZE for vDSO

Vitaly Wool (1):
      riscv: add BUILTIN_DTB support for MMU-enabled targets

Yash Shah (8):
      dt-bindings: riscv: Update l2 cache DT documentation to add support for SiFive FU740
      RISC-V: sifive_l2_cache: Update L2 cache driver to support SiFive FU740
      dt-bindings: riscv: Update DT binding docs to support SiFive FU740 SoC
      dt-bindings: pwm: Update DT binding docs to support SiFive FU740 SoC
      dt-bindings: gpio: Update DT binding docs to support SiFive FU740 SoC
      riscv: dts: add initial support for the SiFive FU740-C000 SoC
      dt-bindings: riscv: Update YAML doc to support SiFive HiFive Unmatched board
      riscv: dts: add initial board data for the SiFive HiFive Unmatched

tangchunyou (1):
      arch/riscv:fix typo in a comment in arch/riscv/kernel/image-vars.h

 .../devicetree/bindings/gpio/sifive,gpio.yaml      |   29 +-
 .../interrupt-controller/sifive,plic-1.0.0.yaml    |   13 +-
 .../bindings/mfd/canaan,k210-sysctl.yaml           |  109 +++
 .../bindings/pinctrl/canaan,k210-fpioa.yaml        |  171 ++++
 .../devicetree/bindings/pwm/pwm-sifive.yaml        |    9 +-
 .../devicetree/bindings/reset/canaan,k210-rst.yaml |   40 +
 .../devicetree/bindings/riscv/canaan.yaml          |   47 +
 Documentation/devicetree/bindings/riscv/cpus.yaml  |    8 +
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml |   34 +-
 .../devicetree/bindings/riscv/sifive.yaml          |   17 +-
 .../devicetree/bindings/serial/sifive-serial.yaml  |    1 +
 .../devicetree/bindings/timer/sifive,clint.yaml    |   12 +-
 .../bindings/timer/snps,dw-apb-timer.yaml          |    3 +
 MAINTAINERS                                        |   23 +
 arch/arm64/Kconfig                                 |    1 +
 arch/arm64/include/asm/numa.h                      |   48 +-
 arch/arm64/kernel/acpi_numa.c                      |   12 -
 arch/arm64/mm/Makefile                             |    1 -
 arch/arm64/mm/init.c                               |    4 +-
 arch/riscv/Kconfig                                 |   48 +-
 arch/riscv/Kconfig.socs                            |   33 +-
 arch/riscv/Makefile                                |   14 +-
 arch/riscv/boot/dts/Makefile                       |    2 +-
 arch/riscv/boot/dts/canaan/Makefile                |    5 +
 arch/riscv/boot/dts/canaan/canaan_kd233.dts        |  152 +++
 arch/riscv/boot/dts/canaan/k210.dtsi               |  459 +++++++++
 arch/riscv/boot/dts/canaan/k210_generic.dts        |   46 +
 arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts     |  209 ++++
 arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts    |  211 ++++
 arch/riscv/boot/dts/canaan/sipeed_maix_go.dts      |  219 +++++
 arch/riscv/boot/dts/canaan/sipeed_maixduino.dts    |  184 ++++
 arch/riscv/boot/dts/kendryte/Makefile              |    4 -
 arch/riscv/boot/dts/kendryte/k210.dts              |   23 -
 arch/riscv/boot/dts/kendryte/k210.dtsi             |  125 ---
 arch/riscv/boot/dts/sifive/Makefile                |    3 +-
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi         |  293 ++++++
 .../riscv/boot/dts/sifive/hifive-unmatched-a00.dts |  253 +++++
 arch/riscv/configs/nommu_k210_defconfig            |   46 +-
 arch/riscv/configs/nommu_k210_sdcard_defconfig     |   92 ++
 arch/riscv/include/asm/bug.h                       |    1 +
 arch/riscv/include/asm/csr.h                       |    6 +
 arch/riscv/include/asm/kasan.h                     |   22 +-
 arch/riscv/include/asm/kprobes.h                   |   40 +
 arch/riscv/include/asm/mmu.h                       |    2 +
 arch/riscv/include/asm/mmu_context.h               |   10 +
 arch/riscv/include/asm/mmzone.h                    |   13 +
 arch/riscv/include/asm/numa.h                      |    8 +
 arch/riscv/include/asm/page.h                      |    3 -
 arch/riscv/include/asm/pci.h                       |   14 +
 arch/riscv/include/asm/pgtable.h                   |   21 +
 arch/riscv/include/asm/probes.h                    |   24 +
 arch/riscv/include/asm/processor.h                 |    1 +
 arch/riscv/include/asm/ptrace.h                    |   35 +
 arch/riscv/include/asm/sbi.h                       |   18 +-
 arch/riscv/include/asm/set_memory.h                |    2 +-
 arch/riscv/include/asm/soc.h                       |   38 -
 arch/riscv/include/asm/stackprotector.h            |    3 +-
 arch/riscv/include/asm/stacktrace.h                |    2 +
 arch/riscv/include/asm/thread_info.h               |    4 +-
 arch/riscv/include/asm/uprobes.h                   |   40 +
 arch/riscv/kernel/Makefile                         |    6 +-
 arch/riscv/kernel/asm-offsets.c                    |    3 +
 arch/riscv/kernel/ftrace.c                         |   95 +-
 arch/riscv/kernel/head.S                           |    4 +
 arch/riscv/kernel/image-vars.h                     |    2 +-
 arch/riscv/kernel/mcount-dyn.S                     |  342 +++----
 arch/riscv/kernel/patch.c                          |    8 +-
 arch/riscv/kernel/probes/Makefile                  |    6 +
 arch/riscv/kernel/probes/decode-insn.c             |   48 +
 arch/riscv/kernel/probes/decode-insn.h             |   18 +
 arch/riscv/kernel/probes/ftrace.c                  |   53 ++
 arch/riscv/kernel/probes/kprobes.c                 |  398 ++++++++
 arch/riscv/kernel/probes/kprobes_trampoline.S      |   93 ++
 arch/riscv/kernel/probes/simulate-insn.c           |   85 ++
 arch/riscv/kernel/probes/simulate-insn.h           |   47 +
 arch/riscv/kernel/probes/uprobes.c                 |  186 ++++
 arch/riscv/kernel/process.c                        |   18 +-
 arch/riscv/kernel/ptrace.c                         |   99 ++
 arch/riscv/kernel/sbi.c                            |   36 +-
 arch/riscv/kernel/setup.c                          |   23 +-
 arch/riscv/kernel/signal.c                         |    3 +
 arch/riscv/kernel/smpboot.c                        |   12 +-
 arch/riscv/kernel/soc.c                            |   27 -
 arch/riscv/kernel/stacktrace.c                     |   22 +-
 arch/riscv/kernel/traps.c                          |   22 +-
 arch/riscv/kernel/vdso/Makefile                    |    3 +-
 arch/riscv/lib/Makefile                            |    2 +
 arch/riscv/lib/error-inject.c                      |   10 +
 arch/riscv/mm/Makefile                             |    3 +-
 arch/riscv/mm/context.c                            |  265 +++++-
 arch/riscv/mm/fault.c                              |   38 +-
 arch/riscv/mm/init.c                               |  108 +--
 arch/riscv/mm/kasan_init.c                         |  176 +++-
 drivers/base/Kconfig                               |    6 +
 drivers/base/Makefile                              |    1 +
 arch/arm64/mm/numa.c => drivers/base/arch_numa.c   |   40 +-
 drivers/clk/Kconfig                                |    7 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-k210.c                             | 1007 ++++++++++++++++++++
 drivers/pinctrl/Kconfig                            |   13 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-k210.c                     |  985 +++++++++++++++++++
 drivers/reset/Kconfig                              |   10 +
 drivers/reset/Makefile                             |    1 +
 drivers/reset/reset-k210.c                         |  131 +++
 drivers/soc/Kconfig                                |    2 +-
 drivers/soc/Makefile                               |    2 +-
 drivers/soc/canaan/Kconfig                         |   12 +
 drivers/soc/canaan/Makefile                        |    3 +
 drivers/soc/canaan/k210-sysctl.c                   |   78 ++
 drivers/soc/kendryte/Kconfig                       |   14 -
 drivers/soc/kendryte/Makefile                      |    3 -
 drivers/soc/kendryte/k210-sysctl.c                 |  260 -----
 drivers/soc/sifive/sifive_l2_cache.c               |   27 +-
 include/asm-generic/numa.h                         |   52 +
 include/dt-bindings/clock/k210-clk.h               |    1 -
 include/dt-bindings/pinctrl/k210-fpioa.h           |  276 ++++++
 include/dt-bindings/reset/k210-rst.h               |   42 +
 include/linux/initrd.h                             |   11 +
 include/soc/canaan/k210-sysctl.h                   |   43 +
 init/initramfs.c                                   |   45 +
 121 files changed, 7605 insertions(+), 1040 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/canaan,k210-rst.yaml
 create mode 100644 Documentation/devicetree/bindings/riscv/canaan.yaml
 create mode 100644 arch/riscv/boot/dts/canaan/Makefile
 create mode 100644 arch/riscv/boot/dts/canaan/canaan_kd233.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k210.dtsi
 create mode 100644 arch/riscv/boot/dts/canaan/k210_generic.dts
 create mode 100644 arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts
 create mode 100644 arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts
 create mode 100644 arch/riscv/boot/dts/canaan/sipeed_maix_go.dts
 create mode 100644 arch/riscv/boot/dts/canaan/sipeed_maixduino.dts
 delete mode 100644 arch/riscv/boot/dts/kendryte/Makefile
 delete mode 100644 arch/riscv/boot/dts/kendryte/k210.dts
 delete mode 100644 arch/riscv/boot/dts/kendryte/k210.dtsi
 create mode 100644 arch/riscv/boot/dts/sifive/fu740-c000.dtsi
 create mode 100644 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
 create mode 100644 arch/riscv/configs/nommu_k210_sdcard_defconfig
 create mode 100644 arch/riscv/include/asm/mmzone.h
 create mode 100644 arch/riscv/include/asm/numa.h
 create mode 100644 arch/riscv/include/asm/probes.h
 create mode 100644 arch/riscv/include/asm/uprobes.h
 create mode 100644 arch/riscv/kernel/probes/Makefile
 create mode 100644 arch/riscv/kernel/probes/decode-insn.c
 create mode 100644 arch/riscv/kernel/probes/decode-insn.h
 create mode 100644 arch/riscv/kernel/probes/ftrace.c
 create mode 100644 arch/riscv/kernel/probes/kprobes.c
 create mode 100644 arch/riscv/kernel/probes/kprobes_trampoline.S
 create mode 100644 arch/riscv/kernel/probes/simulate-insn.c
 create mode 100644 arch/riscv/kernel/probes/simulate-insn.h
 create mode 100644 arch/riscv/kernel/probes/uprobes.c
 create mode 100644 arch/riscv/lib/error-inject.c
 rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (93%)
 create mode 100644 drivers/clk/clk-k210.c
 create mode 100644 drivers/pinctrl/pinctrl-k210.c
 create mode 100644 drivers/reset/reset-k210.c
 create mode 100644 drivers/soc/canaan/Kconfig
 create mode 100644 drivers/soc/canaan/Makefile
 create mode 100644 drivers/soc/canaan/k210-sysctl.c
 delete mode 100644 drivers/soc/kendryte/Kconfig
 delete mode 100644 drivers/soc/kendryte/Makefile
 delete mode 100644 drivers/soc/kendryte/k210-sysctl.c
 create mode 100644 include/asm-generic/numa.h
 create mode 100644 include/dt-bindings/pinctrl/k210-fpioa.h
 create mode 100644 include/dt-bindings/reset/k210-rst.h
 create mode 100644 include/soc/canaan/k210-sysctl.h
