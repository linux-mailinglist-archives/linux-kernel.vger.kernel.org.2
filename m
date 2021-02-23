Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46082323330
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 22:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhBWVWV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Feb 2021 16:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhBWVWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 16:22:15 -0500
Received: from mail.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF81C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 13:21:33 -0800 (PST)
Received: from localhost (unknown [66.175.76.100])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 7906E4D0C3F7E;
        Tue, 23 Feb 2021 13:21:31 -0800 (PST)
Date:   Tue, 23 Feb 2021 13:21:26 -0800 (PST)
Message-Id: <20210223.132126.1594995051384966189.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Tue, 23 Feb 2021 13:21:31 -0800 (PST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A host of mall cleanups and adjustments that have accumulated while
I was away, nothing major.

Please pull, thanks a lot!

The following changes since commit dd0d718152e4c65b173070d48ea9dfc06894c3e5:

  Merge tag 'spi-fix-v5.8-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi (2020-06-22 09:49:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 356184fb6d67770d7788f316226be810a430937b:

  sparc: make xchg() into a statement expression (2021-02-18 16:40:22 -0800)

----------------------------------------------------------------
Al Viro (1):
      sparc32: fix a user-triggerable oops in clear_user()

Alexander A. Klimov (1):
      arch/sparc: Replace HTTP links with HTTPS ones

Andreas Larsson (2):
      sparc32: Limit memblock allocation to low memory
      sparc32: Preserve clone syscall flags argument for restarts due to signals

Ben Hutchings (1):
      sparc32: signal: Fix stack trampoline for RT signals

Christoph Hellwig (1):
      sparc64: switch defconfig from the legacy ide driver to libata

Corentin Labbe (2):
      sparc: piggyback: handle invalid image
      sparc: sparc64_defconfig: add necessary configs for qemu

David S. Miller (1):
      Merge branch 'sparc32-srmmu-improve-type-safety-of-__nocache_fix'

Gustavo A. R. Silva (2):
      sparc64: viohs: Use struct_size() helper
      sparc: Use fallthrough pseudo-keyword

Jing Xiangfeng (1):
      sbus: char: Remove meaningless jump label out_free

Kaixu Xia (1):
      sparc32: Fix comparing pointer to 0 coccicheck warning

Khalid Aziz (1):
      sparc64: Use arch_validate_flags() to validate ADI flag

Matthew Wilcox (Oracle) (1):
      sparc: Fix handling of page table constructor failure

Mike Rapoport (2):
      sparc32: use PUD rather than PGD to get PMD in srmmu_inherit_prom_mappings()
      sparc32: srmmu: improve type safety of __nocache_fix()

Peter Collingbourne (1):
      sparc: remove SA_STATIC_ALLOC macro definition

Qinglang Miao (1):
      sparc: use for_each_child_of_node() macro

Randy Dunlap (4):
      SPARC: backoff.h: delete a duplicated word
      sparc64: only select COMPAT_BINFMT_ELF if BINFMT_ELF is set
      sparc: fix led.c driver when PROC_FS is not enabled
      sparc: make xchg() into a statement expression

Tiezhu Yang (1):
      sparc: Replace test_ti_thread_flag() with test_tsk_thread_flag()

Uwe Kleine-König (3):
      tty: vcc: Drop impossible to hit WARN_ON
      tty: vcc: Drop unnecessary if block
      tty: hvcs: Drop unnecessary if block

 arch/sparc/Kconfig                   |  4 ++--
 arch/sparc/boot/piggyback.c          |  4 ++++
 arch/sparc/configs/sparc64_defconfig | 11 ++++++++---
 arch/sparc/include/asm/backoff.h     |  2 +-
 arch/sparc/include/asm/cmpxchg_32.h  |  2 +-
 arch/sparc/include/asm/mman.h        | 54 +++++++++++++++++++++++++++++-------------------------
 arch/sparc/include/asm/pgtsrmmu.h    |  2 +-
 arch/sparc/include/asm/signal.h      | 12 ------------
 arch/sparc/kernel/auxio_64.c         |  1 -
 arch/sparc/kernel/central.c          |  2 +-
 arch/sparc/kernel/entry.S            |  8 +++-----
 arch/sparc/kernel/kgdb_32.c          |  2 +-
 arch/sparc/kernel/kgdb_64.c          |  2 +-
 arch/sparc/kernel/led.c              |  2 ++
 arch/sparc/kernel/pci.c              |  3 +--
 arch/sparc/kernel/pcr.c              |  2 +-
 arch/sparc/kernel/process_32.c       |  2 +-
 arch/sparc/kernel/prom_32.c          |  2 +-
 arch/sparc/kernel/rtrap_32.S         |  2 +-
 arch/sparc/kernel/signal32.c         |  4 ++--
 arch/sparc/kernel/signal_32.c        |  8 ++++----
 arch/sparc/kernel/signal_64.c        |  4 ++--
 arch/sparc/kernel/viohs.c            |  6 ++----
 arch/sparc/lib/memset.S              |  1 +
 arch/sparc/math-emu/math_32.c        |  8 ++++----
 arch/sparc/mm/init_32.c              |  3 +++
 arch/sparc/mm/init_64.c              |  2 +-
 arch/sparc/mm/srmmu.c                | 20 ++++++++++----------
 drivers/sbus/char/display7seg.c      |  4 +---
 drivers/tty/hvc/hvcs.c               |  3 ---
 drivers/tty/vcc.c                    | 10 ++--------
 31 files changed, 91 insertions(+), 101 deletions(-)
