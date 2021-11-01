Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7000441D95
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhKAP4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:56:45 -0400
Received: from mout.gmx.net ([212.227.17.20]:50887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230517AbhKAP4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635782043;
        bh=o8O/vojK2NIE9mJpyWbXMCjMOgFZFpA8dCaHEaWp19Y=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=R2ZUQSH4s4kOitA0WBg07eDPzOZxXmHf03ADrFi8sbtNMuaYekntqhZiVjBRhe76c
         B3RN3Qti49fWACOwlEHfB43QjsbJ3KmYmrTr2X2hh473HRpq1FbghpHt4IDFz4XuMc
         QKOAR3NCSJbI8FdVcIp+gP8UV3cjifSMeYNH/ZUs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.177.231]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fnj-1mnucW1bZH-006RYN; Mon, 01
 Nov 2021 16:54:03 +0100
Date:   Mon, 1 Nov 2021 16:53:37 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Subject: [GIT PULL] parisc architecture fixes for kernel v5.16-rc1
Message-ID: <YYANgdNcYx8KQJUJ@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:2ltR8udwH8z6wmjI/1pbZ6eF0wKRadBEyt7a1xQe9YBxMxnxC0L
 Bg5sDEtjtCO590ZOnTDRbrHxmKtrZruoIDObViKVHJziaW88Js5V3xWV3TQi7P2sM4e0Dor
 8UpeRazAcU+J0S/IL66rVpJkc3C4FekavIRW4PGb6bMAh4HUao16R0ZbQHkhsxqnkCqCpvL
 10/ZVlkAyoObPcpnpKyxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:II99DMCnopc=:0VdOqCAukw1/2I8UnDp3vq
 5fhjF7EKS3OLpATPctxcSlGjZXn6vwmJDQRPUYNtQLOOIdb6YvGjHssHHvYe95VeuDEqAKGVN
 BIg0ysf78wcrQg4SJlwDgPyBxCXm7KzQp+cVrgq7WqzP5xkEIBQ86Cz3y0axyajI/JtMMjqRC
 RmIDn+Rc7HB066oIolLcNsHh+w7zOK7/mON1vIW2pxXjBiNZEYi7Ra/itsMNxVBlO9dW7xSUo
 M2dXKOMDv8RalyDxHHLUVLD5Z6lxrRGjvcKMo4W1AYLY2YzYGAXQu1y5D27UQS16etl/b6y7Z
 2ltWfGda2JZwsYfcPM6H/6H58OinURfzIP410CvRFDUdskmazcp3CV6eSjOjc/VX5v4vViy/Q
 7GckScYnWS21cgBHmNce/5w+zq8Hfx4iPNQjGXiIRNOrPzD7ERk1uVpJOq3xD0GBW+QWpcnd7
 VMhEtNAg1IXfnxiAmDXnM/B3CczukX3UBt4mXVmmWuoBL8jyGZpwhCaAdVt3KA4p/VC9EekLC
 QHpIyt6dvwiEdXVuAZvtx0GbVZxDJaFMd45dzryF1UZR8YztqLTSOmEP0WHMVt+65Qjx4Iu4K
 BGTSCTxG/BVYHZaQW3rWxPBKz0Cdgf8Ah0KT21piwOml3WkIn6VTxDM1SC4tyI4A6StoVv+KJ
 pkTAfMF+1DaEfK5kdCVIvBLPjC7duEv8qJmv3z5Iq+8Ivot4aRfRmy1C3bR86IUA4uZu24PS6
 L2feL6z53QcDrrWHfHc00khtOEEo3wfyGEkTb6MhTXDzahD+jOyZp1V3S78M/L6iBi24cAPOr
 oPinv2BZvJpfJaI1XK9Xj8gFRfJM/Js3WGF5xT20lptNc9gPi5/QLK8rca10sbg9CrfMKYY4i
 TnIS1UXEHSGv8b/wx/Q4IDcRp52RblTYQgzSBWecCKJXUj4ymwZxTEl+/qZCRrx98Tzh4OOb5
 +eFAYO4DuIROs/p5I2arzDB+PEU1hL2g7g/kgvvWoYdaU8TqlWzBR2I0sprpWIDJPdkldv6Zn
 /HKkSvM0jQkafXYhXUgf43Pf+QrpJcvR7q2ZJ/pABTaDWedr+D6nb5a3eBkt5hD9KSKOny7C3
 uUrkHMyWeTUicA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3a4347d82efdfcc5465b3ed37616426989182915:

  Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux (2021-10-30 09:55:46 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-1

for you to fetch changes up to 6e866a462867b60841202e900f10936a0478608c:

  parisc: Fix set_fixmap() on PA1.x CPUs (2021-11-01 12:00:22 +0100)

----------------------------------------------------------------
parisc architecture updates for kernel v5.16-rc1

Lots of new features and fixes:
* Added TOC (table of content) support, which is a debugging feature which is
  either initiated by pressing the TOC button or via command in the BMC. If
  pressed the Linux built-in KDB/KGDB will be called (Sven Schnelle)
* Fix CONFIG_PREEMPT (Sven)
* Fix unwinder on 64-bit kernels (Sven)
* Various kgdb fixes (Sven)
* Added KFENCE support (me)
* Switch to ARCH_STACKWALK implementation (me)
* Fix ptrace check on syscall return (me)
* Fix kernel crash with fixmaps on PA1.x machines (me)
* Move thread_info into task struct, aka CONFIG_THREAD_INFO_IN_TASK (me)
* Updated defconfigs
* Smaller cleanups, including Makefile cleanups (Masahiro Yamada),
  use kthread_run() macro (Cai Huoqing), use swap() macro (Yihao Han).

----------------------------------------------------------------
Cai Huoqing (1):
      parisc: Make use of the helper macro kthread_run()

Helge Deller (17):
      parisc: make parisc_acctyp() available outside of faults.c
      parisc: Switch to ARCH_STACKWALK implementation
      parisc: Add KFENCE support
      parisc: Define FRAME_ALIGN and PRIV_USER/PRIV_KERNEL in assembly.h
      parisc: Allocate task struct with stack frame alignment
      parisc: Use FRAME_SIZE and FRAME_ALIGN from assembly.h
      parisc: Use PRIV_USER instead of 3 in entry.S
      task_stack: Fix end_of_stack() for architectures with upwards-growing stack
      parisc: Fix ptrace check on syscall return
      parisc: Move thread_info into task struct
      parisc: Use PRIV_USER in syscall.S
      parisc: Use PRIV_USER and PRIV_KERNEL in ptrace.h
      parisc: Drop ifdef __KERNEL__ from non-uapi kernel headers
      parisc: enhance warning regarding usage of O_NONBLOCK
      parisc: Remove unused constants from asm-offsets.c
      parisc: Update defconfigs
      parisc: Fix set_fixmap() on PA1.x CPUs

Masahiro Yamada (2):
      parisc: decompressor: remove repeated depenency of misc.o
      parisc: decompressor: clean up Makefile

Sven Schnelle (15):
      parisc/unwind: use copy_from_kernel_nofault()
      parisc: disable preemption during local tlb flush
      parisc: deduplicate code in flush_cache_mm() and flush_cache_range()
      parisc: fix preempt_count() check in entry.S
      parisc: disable preemption in send_IPI_allbutself()
      parisc: fix warning in flush_tlb_all
      parisc/unwind: fix unwinder when CONFIG_64BIT is enabled
      parisc: move virt_map macro to assembly.h
      parisc: add PIM TOC data structures
      parisc/firmware: add functions to retrieve TOC data
      parisc: add support for TOC (transfer of control)
      parisc/kgdb: add kgdb_roundup() to make kgdb work with idle polling
      parisc: mark xchg functions notrace
      parisc/ftrace: set function trace function
      parisc/ftrace: use static key to enable/disable function graph tracer

Yihao Han (1):
      parisc: Use swap() to swap values in setup_bootmem()

 .../core/thread-info-in-task/arch-support.txt      |   2 +-
 arch/parisc/Kconfig                                |  22 +++-
 arch/parisc/boot/compressed/Makefile               |   9 +-
 arch/parisc/configs/generic-32bit_defconfig        |   9 +-
 arch/parisc/configs/generic-64bit_defconfig        |  21 ++--
 arch/parisc/include/asm/assembly.h                 |  32 ++++++
 arch/parisc/include/asm/bitops.h                   |  10 --
 arch/parisc/include/asm/current.h                  |  19 ++++
 arch/parisc/include/asm/futex.h                    |   3 -
 arch/parisc/include/asm/ide.h                      |   4 -
 arch/parisc/include/asm/kfence.h                   |  44 ++++++++
 arch/parisc/include/asm/mckinley.h                 |   2 -
 arch/parisc/include/asm/pdc.h                      |   2 +
 arch/parisc/include/asm/processor.h                |  11 +-
 arch/parisc/include/asm/ptrace.h                   |   6 +-
 arch/parisc/include/asm/runway.h                   |   2 -
 arch/parisc/include/asm/smp.h                      |  19 +++-
 arch/parisc/include/asm/thread_info.h              |  12 +--
 arch/parisc/include/asm/traps.h                    |   1 +
 arch/parisc/include/asm/unaligned.h                |   2 -
 arch/parisc/include/uapi/asm/pdc.h                 |  28 +++++-
 arch/parisc/kernel/Makefile                        |   1 +
 arch/parisc/kernel/asm-offsets.c                   |  34 ++-----
 arch/parisc/kernel/cache.c                         |  87 +++++++---------
 arch/parisc/kernel/entry.S                         |  90 ++++++-----------
 arch/parisc/kernel/firmware.c                      |  32 ++++++
 arch/parisc/kernel/ftrace.c                        |  21 ++--
 arch/parisc/kernel/head.S                          |  40 ++++----
 arch/parisc/kernel/irq.c                           |   6 +-
 arch/parisc/kernel/pdt.c                           |   4 +-
 arch/parisc/kernel/process.c                       |   4 +-
 arch/parisc/kernel/smp.c                           |  25 ++++-
 arch/parisc/kernel/stacktrace.c                    |  30 +++---
 arch/parisc/kernel/sys_parisc.c                    |  10 +-
 arch/parisc/kernel/syscall.S                       |  26 ++---
 arch/parisc/kernel/toc.c                           | 111 +++++++++++++++++++++
 arch/parisc/kernel/toc_asm.S                       |  88 ++++++++++++++++
 arch/parisc/kernel/traps.c                         |   7 +-
 arch/parisc/kernel/unwind.c                        |  34 ++++---
 arch/parisc/lib/bitops.c                           |  12 +--
 arch/parisc/mm/fault.c                             |   2 +-
 arch/parisc/mm/fixmap.c                            |   5 +-
 arch/parisc/mm/init.c                              |  10 +-
 include/linux/sched/task_stack.h                   |   4 +
 44 files changed, 622 insertions(+), 321 deletions(-)
 create mode 100644 arch/parisc/include/asm/current.h
 create mode 100644 arch/parisc/include/asm/kfence.h
 create mode 100644 arch/parisc/kernel/toc.c
 create mode 100644 arch/parisc/kernel/toc_asm.S
