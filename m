Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BE731726D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhBJVfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:35:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232344AbhBJVfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:35:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD3EB64E66;
        Wed, 10 Feb 2021 21:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612992906;
        bh=0CN0AXiGt7nS0p519elCd69YpBiDbXO8I+Tu+S7YevM=;
        h=From:To:Subject:Date:From;
        b=GY3Ey79AcOJsn6SXpnwj+p7UeBnWrMw4tW7uB4AfzKlO3ztuZoUCnadvMtyxZYJLS
         sJDlVXSg7r+H5vr0QYTBqF9XerUDznqFk2C8N0P6EjfqiA598Gb4x+3eY58B2sTXM9
         ENa6icxWjUVBuXha3U8rxbjsdUZ286EXmZofloYm7LVZYzC8XfHCcR1Qw3e6r7ETzL
         cX3wa8lupzQSKpnZTy3icoYluGQQR1DsGxvXoRxqOtZ3ILPb3Z6lBrRHwnqUdp9fm+
         p+rRgmz9rjly8IJ92gbXCljl4A0tQRSFG5/WE/ZOi1IoXPnLA+YlXWeKeeR5kTrzGl
         9A5EpLLktcJ0w==
From:   Timur Tabi <timur@kernel.org>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        akinobu.mita@gmail.com, glider@google.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/3][v3] add support for never printing hashed addresses
Date:   Wed, 10 Feb 2021 15:34:50 -0600
Message-Id: <20210210213453.1504219-1-timur@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[The list of email addresses on CC: is getting quite lengthy,
so I hope I've included everyone.]

Although hashing addresses printed via printk does make the
kernel more secure, it interferes with debugging, especially
with some functions like print_hex_dump() which always uses
hashed addresses.

To avoid having to choose between %p and %px, it's easier to
add a kernel command line that treats all %p as %px.  This
encourages developers to use %p more without making debugging
more difficult.

Patches #1 and #2 upgrade the kselftest framework so that
it can report on tests that were skipped outright.  This
is needed for the test_printf module which will now skip
%p hashing tests if hashing is disabled.

Patch #2 upgrades the printf library to check the command
line.  It also updates test_printf().

Full series:

Acked-by: Marco Elver <elver@google.com>

Timur Tabi (3):
  [v3] lib: use KSTM_MODULE_GLOBALS macro in kselftest drivers
  [v3] kselftest: add support for skipped tests
  [v3] lib/vsprintf: debug_never_hash_pointers prints all addresses as
    unhashed

 .../admin-guide/kernel-parameters.txt         | 15 ++++++++
 lib/test_bitmap.c                             |  3 +-
 lib/test_printf.c                             | 12 +++++-
 lib/vsprintf.c                                | 38 ++++++++++++++++++-
 tools/testing/selftests/kselftest_module.h    | 18 ++++++---
 5 files changed, 74 insertions(+), 12 deletions(-)

-- 
2.25.1

