Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620C03B734B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 15:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhF2Nhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 09:37:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49138 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhF2NhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:37:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B490022186;
        Tue, 29 Jun 2021 13:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624973691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Sjii0conm7nXek4F00rSCybHQnljsExZM/nN8KDYUHs=;
        b=dbfIhr7ofLLN7OFd0AweDGPT310DynNQYgbdqOVXm594UKEBOwo/2kcTuobFvvuslXHc9p
        BIoJ0eXCnom5QqHGXDV7gvZvBx0jqCGxsvahNNUaD6/vEZKl8mWwIoF0J2Y+BfendicGpQ
        sk0HmjgBQhVtvdx+LDfRl8rI5uiIpVw=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5040FA3BC9;
        Tue, 29 Jun 2021 13:34:51 +0000 (UTC)
Date:   Tue, 29 Jun 2021 15:34:50 +0200
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
Subject: [GIT PULL] printk for 5.14
Message-ID: <YNshegt/DQV1JDc9@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.14

=====================================

- Add %pt[RT]s modifier to vsprintf(). It overrides ISO 8601 separator by
  using ' ' (space). It produces "YYYY-mm-dd HH:MM:SS" instead of
  "YYYY-mm-ddTHH:MM:SS".

- Correctly parse long row of numbers by sscanf() when using the field
  width. Add extensive sscanf() selftest.

- Generalize re-entrant CPU lock that has already been used to serialize
  dump_stack() output. It is part of the ongoing printk rework. It will
  allow to remove the obsoleted printk_safe buffers and introduce atomic
  consoles.

- Some code clean up and sparse warning fix.

======================================

Conflict with Andrew's -mm tree:

The commit generalizing the CPU lock conflicts with a patch that
introduces dump_stack_lvl(log_lvl). The resulting code is simple.
But the 3-way merge combined the hunks a messy way here.

A sample resolution can be found at

    git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git origin/for-5.14-mm-dump_stack-loglvl-conflict

----------------------------------------------------------------
Andy Shevchenko (4):
      lib/vsprintf: Allow to override ISO 8601 date and time separator
      kdb: Switch to use %ptTs
      nilfs2: Switch to use %ptTs
      usb: host: xhci-tegra: Switch to use %ptTs

Huilong Deng (1):
      printk: Remove trailing semicolon in macros

John Ogness (2):
      lib/dump_stack: move cpu lock to printk.c
      printk: fix cpu lock ordering

Petr Mladek (3):
      Merge branch 'for-5.14-vsprintf-pts' into for-linus
      Merge branch 'for-5.14-vsprintf-scanf' into for-linus
      Merge branch 'printk-rework' into for-linus

Richard Fitzgerald (6):
      lib: vsprintf: scanf: Negative number must have field width > 1
      lib: vsprintf: Fix handling of number field widths in vsscanf
      lib: test_scanf: Add tests for sscanf number conversion
      selftests: lib: Add wrapper script for test_scanf
      lib: test_scanf: Remove pointless use of type_min() with unsigned types
      random32: Fix implicit truncation warning in prandom_seed_state()

 Documentation/core-api/printk-formats.rst |   7 +-
 MAINTAINERS                               |   1 +
 drivers/usb/host/xhci-tegra.c             |   6 +-
 fs/nilfs2/sysfs.c                         |  19 +-
 include/linux/dev_printk.h                |   2 +-
 include/linux/prandom.h                   |   2 +-
 include/linux/printk.h                    |  41 ++
 kernel/debug/kdb/kdb_main.c               |   9 +-
 kernel/printk/printk.c                    | 116 +++++
 lib/Kconfig.debug                         |   3 +
 lib/Makefile                              |   1 +
 lib/dump_stack.c                          |  38 +-
 lib/kstrtox.c                             |  13 +-
 lib/kstrtox.h                             |   2 +
 lib/test_printf.c                         |   5 +
 lib/test_scanf.c                          | 750 ++++++++++++++++++++++++++++++
 lib/vsprintf.c                            | 110 +++--
 tools/testing/selftests/lib/Makefile      |   2 +-
 tools/testing/selftests/lib/config        |   1 +
 tools/testing/selftests/lib/scanf.sh      |   4 +
 20 files changed, 1020 insertions(+), 112 deletions(-)
 create mode 100644 lib/test_scanf.c
 create mode 100755 tools/testing/selftests/lib/scanf.sh
