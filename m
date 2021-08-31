Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67E73FC639
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 13:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241163AbhHaKpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 06:45:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38016 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241133AbhHaKpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:45:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B28522014F;
        Tue, 31 Aug 2021 10:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630406653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=6VUGImYUISwDQlSLqA5nQc2VqraaxPj0TRATbTEn7MU=;
        b=C5Y5xwa4ybJe2b6F82B1iJAOxSf5ci+CDu3p1R85tGZlVIaPDY43D55sR5mP7I2LfbcIMB
        quNzu0lLx1iJ6aENtOu49YqvzZX+K941gljdfSaFkd3VktF2VjMbSI6MmUUMlaNN6AsCyK
        HIK6qCRJ51acW5/84vnAK28prBBBKuo=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5C3ECA3B93;
        Tue, 31 Aug 2021 10:44:13 +0000 (UTC)
Date:   Tue, 31 Aug 2021 12:44:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 5.15
Message-ID: <YS4H+87KIBcdc0m2@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.15

=====================================

- Optionally, provide an index of possible printk messages via
  <debugfs>/printk/index/. It might be used when monitoring important
  kernel messages on a farm of various hosts. The monitor has to be
  updated when some messages has changed or are not longer available
  by a newly deployed kernel.

- Add printk.console_no_auto_verbose boot parameter. It allows to
  generate crash dump even with slow consoles in a reasonable
  time frame.

- Remove printk_safe buffers. The messages are always stored directly to
  the main logbuffer, even in NMI or recursive context. Also it allows
  to serialize syslog operations by a mutex instead of a spin lock.

- Misc clean up and build fixes.

----------------------------------------------------------------
Andy Shevchenko (1):
      lib/test_scanf: Handle n_bits == 0 in random tests

Chris Down (5):
      string_helpers: Escape double quotes in escape_special
      printk: Straighten out log_flags into printk_info_flags
      printk: Rework parse_prefix into printk_parse_prefix
      printk: Userspace format indexing support
      printk: index: Add indexing support to dev_printk

Dmitry Safonov (2):
      printk: Remove console_silent()
      printk: Add printk.console_no_auto_verbose boot parameter

John Ogness (6):
      lib/nmi_backtrace: explicitly serialize banner and regs
      printk: track/limit recursion
      printk: remove safe buffers
      printk: remove NMI tracking
      printk: convert @syslog_lock to mutex
      printk: syslog: close window between wait and read

Jonathan Corbet (1):
      printk: Move the printk() kerneldoc comment to its new home

Petr Mladek (8):
      printk/console: Check consistent sequence number when handling race in console_unlock()
      MIPS/asm/printk: Fix build failure caused by printk
      printk/index: Fix warning about missing prototypes
      lib/nmi_backtrace: Serialize even messages about idle CPUs
      Merge branch 'for-5.15-printk-index' into for-linus
      Merge branch 'for-5.15-verbose-console' into for-linus
      Merge branch 'rework/fixup-for-5.15' into for-linus
      Merge branch 'rework/printk_safe-removal' into for-linus

YueHaibing (1):
      printk/index: Fix -Wunused-function warning

 Documentation/admin-guide/kernel-parameters.txt |   9 +
 Documentation/core-api/printk-basics.rst        |   5 +-
 MAINTAINERS                                     |   5 +
 arch/arm/kernel/entry-v7m.S                     |   2 +-
 arch/arm/kernel/smp.c                           |   4 +-
 arch/arm/lib/backtrace-clang.S                  |   2 +-
 arch/arm/lib/backtrace.S                        |   2 +-
 arch/arm/mach-rpc/io-acorn.S                    |   2 +-
 arch/arm/vfp/vfphw.S                            |   6 +-
 arch/ia64/include/uapi/asm/cmpxchg.h            |   4 +-
 arch/mips/include/asm/asm.h                     |   2 +-
 arch/openrisc/kernel/entry.S                    |   6 +-
 arch/powerpc/kernel/head_fsl_booke.S            |   2 +-
 arch/powerpc/kernel/traps.c                     |   1 -
 arch/powerpc/kernel/watchdog.c                  |   5 -
 arch/powerpc/kexec/crash.c                      |   2 +-
 arch/um/include/shared/user.h                   |   3 +-
 arch/x86/kernel/head_32.S                       |   2 +-
 drivers/base/core.c                             |   6 +-
 include/asm-generic/vmlinux.lds.h               |  13 +
 include/linux/dev_printk.h                      |  66 +++--
 include/linux/hardirq.h                         |   2 -
 include/linux/module.h                          |   5 +
 include/linux/printk.h                          | 171 ++++++++---
 init/Kconfig                                    |  19 +-
 kernel/kexec_core.c                             |   1 -
 kernel/module.c                                 |   5 +
 kernel/panic.c                                  |   3 -
 kernel/printk/Makefile                          |   1 +
 kernel/printk/index.c                           | 195 +++++++++++++
 kernel/printk/internal.h                        |  31 +-
 kernel/printk/printk.c                          | 361 +++++++++++++----------
 kernel/printk/printk_safe.c                     | 364 +-----------------------
 kernel/trace/trace.c                            |   2 -
 lib/nmi_backtrace.c                             |  13 +-
 lib/string_helpers.c                            |   4 +
 lib/test-string_helpers.c                       |  14 +-
 lib/test_scanf.c                                |   4 +-
 38 files changed, 687 insertions(+), 657 deletions(-)
 create mode 100644 kernel/printk/index.c
