Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC92236C759
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbhD0Nyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:54:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:53344 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236516AbhD0Nyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:54:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619531627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=i9xQmDCeivVgWpnOYZBsW4xYs30EqI+Ven3RmapyFIo=;
        b=SHDSC5PP1QhaySFNnBycmnembRGUG+RoG5jqnlNQWDQuaspcyHXeWCfFHyxQdSqYhYhA0f
        cRrfj82CeJQm4HgLS6VaRvLsfIQOyO5oUsmaI11d0Enpj04PN2yTB7ssw0nx6ye6OiB5Pw
        hFwS0Gf+PnmIN05oS/EUTbcos8/xbXA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5EB12B1A5;
        Tue, 27 Apr 2021 13:53:47 +0000 (UTC)
Date:   Tue, 27 Apr 2021 15:53:46 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 5.13
Message-ID: <YIgXasI86BwJvQ0Z@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.13

==============================

- Stop synchronizing kernel log buffer readers by logbuf_lock.
  As a result, the access to the buffer is fully lockless now.

  Note that printk() itself still uses locks because it tries to
  flush the messages to the console immediately. Also the per-CPU
  temporary buffers are still there because they prevent infinite
  recursion and serialize backtraces from NMI. All this is going
  to change in the future.

- kmsg_dump API rework and cleanup as a side effect of
  the logbuf_lock removal.

- Make bstr_printf() aware that %pf and %pF formats could
  deference the given pointer.

- Show also page flags by %pGp format.

- Clarify the documentation for plain pointer printing.

- Do not show no_hash_pointers warning multiple times.

- Update Senozhatsky email address.

- Some clean up.

----------------------------------------------------------------
Bhaskar Chowdhury (1):
      kernel/printk.c: Fixed mundane typos

John Ogness (15):
      um: synchronize kmsg_dumper
      mtd: mtdoops: synchronize kmsg_dumper
      printk: limit second loop of syslog_print_all
      printk: kmsg_dump: remove unused fields
      printk: refactor kmsg_dump_get_buffer()
      printk: consolidate kmsg_dump_get_buffer/syslog_print_all code
      printk: introduce CONSOLE_LOG_MAX
      printk: use seqcount_latch for clear_seq
      printk: use atomic64_t for devkmsg_user.seq
      printk: add syslog_lock
      printk: kmsg_dumper: remove @active field
      printk: introduce a kmsg_dump iterator
      printk: remove logbuf_lock
      printk: kmsg_dump: remove _nolock() variants
      printk: console: remove unnecessary safe buffer usage

Marco Elver (1):
      lib/vsprintf: do not show no_hash_pointers message multiple times

Petr Mladek (2):
      Merge branch 'for-5.13-vsprintf-pgp' into for-linus
      Merge branch 'printk-rework' into for-linus

Rasmus Villemoes (2):
      printk: rename vprintk_func to vprintk
      lib/vsprintf.c: remove leftover 'f' and 'F' cases from bstr_printf()

Sergey Senozhatsky (1):
      MAINTAINERS: update Senozhatsky email address

Vlastimil Babka (1):
      printk: clarify the documentation for plain pointer printing

Yafang Shao (3):
      mm, slub: use pGp to print page flags
      mm, slub: don't combine pr_err with INFO
      vsprintf: dump full information of page flags in pGp

 Documentation/core-api/printk-formats.rst |  28 +-
 MAINTAINERS                               |   8 +-
 arch/powerpc/kernel/nvram_64.c            |   8 +-
 arch/powerpc/xmon/xmon.c                  |   6 +-
 arch/um/kernel/kmsg_dump.c                |  13 +-
 drivers/hv/vmbus_drv.c                    |   4 +-
 drivers/mtd/mtdoops.c                     |  17 +-
 fs/pstore/platform.c                      |   5 +-
 include/linux/kmsg_dump.h                 |  47 ++-
 kernel/debug/kdb/kdb_main.c               |  10 +-
 kernel/printk/internal.h                  |   7 +-
 kernel/printk/printk.c                    | 478 +++++++++++++++---------------
 kernel/printk/printk_safe.c               |  30 +-
 lib/test_printf.c                         |  90 +++++-
 lib/vsprintf.c                            |  78 ++++-
 mm/slub.c                                 |  13 +-
 16 files changed, 502 insertions(+), 340 deletions(-)
