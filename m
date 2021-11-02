Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9287442BEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 11:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhKBK7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 06:59:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59024 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKBK7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 06:59:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B2F501FD4C;
        Tue,  2 Nov 2021 10:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635850619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=bI4B7yr35oWTj1TPj4CUZtyH2uZJxpOlkaEg3shV8go=;
        b=tkdjiWzGaVOVMeD8NPncbMQ/rWKXYb/Al0YhUgrEd0VTigvN49MFrBAndAjpt0WGIOpKKC
        BFO8ZWLF8GGHL8yCq3pVsJeWio7N0VEiZ6GnFz7u2xtIwlv6sKzTY/a6p9Dd+by2/M618E
        QhP9lOEvAQkBUcZWBoGG0N3T64+vzQQ=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 50C16A3B87;
        Tue,  2 Nov 2021 10:56:59 +0000 (UTC)
Date:   Tue, 2 Nov 2021 11:56:56 +0100
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
Subject: [GIT PULL] printk for 5.16
Message-ID: <YYEZeIVxrp8MJ/yb@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.16

=========================================

- Extend %pGp print format to print hex value of the page flags.

- Use kvmalloc instead of kmalloc to allocate devkmsg buffers.

- Misc cleanup and warning fixes.

----------------------------------------------------------------
Andy Shevchenko (1):
      lib/vsprintf.c: Amend static asserts for format specifier flags

Arnd Bergmann (1):
      printk: avoid -Wsometimes-uninitialized warning

John Ogness (1):
      printk: use gnu_printf format attribute for printk_sprint()

Matthew Wilcox (Oracle) (5):
      test_printf: Make pft array const
      test_printf: Remove separate page_flags variable
      test_printf: Remove custom appending of '|'
      test_printf: Append strings more efficiently
      vsprintf: Make %pGp print the hex value

Petr Mladek (2):
      vsprintf: Update %pGp documentation about that it prints hex value
      Merge branch 'for-5.16-vsprintf-pgp' into for-linus

Randy Dunlap (1):
      ia64: don't do IA64_CMPXCHG_DEBUG without CONFIG_PRINTK

Yong-Taek Lee (1):
      printk: use kvmalloc instead of kmalloc for devkmsg_user

 Documentation/core-api/printk-formats.rst |  2 +-
 arch/ia64/Kconfig.debug                   |  2 +-
 kernel/printk/index.c                     |  5 +--
 kernel/printk/printk.c                    |  5 ++-
 lib/test_printf.c                         | 61 +++++++++++++------------------
 lib/vsprintf.c                            | 11 +++++-
 mm/debug.c                                |  2 +-
 mm/memory-failure.c                       |  8 ++--
 mm/page_owner.c                           |  4 +-
 mm/slub.c                                 |  4 +-
 10 files changed, 51 insertions(+), 53 deletions(-)
