Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087DB31B12A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 17:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhBNQOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 11:14:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhBNQOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 11:14:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 333E264DAD;
        Sun, 14 Feb 2021 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613319232;
        bh=oHf15gSHKcdfrEuxcuEmshOdx1i9DIeGN5nSxvWb/No=;
        h=From:To:Subject:Date:From;
        b=O00k2kQ07nI0dSl2MUzumJwYSH1LWk6XWq2zYi1z1zxrGtqBxnLrwv0udEZb5j/Br
         xgezU5+xgLN5qGdt9t3IIM8LKMtDC8RNqbJd3Zp/ADvGfYnaZ9DAKG6mBUn+QaNFzB
         fFF5cHZ+6XRRt97tswNUL6njcYd283UQgEUiJKfdK9fbo5Md8rwDdWpcl2hTScAY9a
         0o9rZEnVY63o3OTraf33OKNLxNm4MKVIA1/3iNm3PCqnvrCbntdVCiaqGuG9elHGr8
         iduzTsrlfo9/nrbsaXuDnUu8Tkj5gSYo4a/jsV/WVqLRD+ML2wQx9Ab/YnF87eTB7t
         gWMJ18zYRaraA==
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
Subject: [PATCH 0/3][v4] add support for never printing hashed addresses
Date:   Sun, 14 Feb 2021 10:13:45 -0600
Message-Id: <20210214161348.369023-1-timur@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Timur Tabi (3):
  [v4] lib: use KSTM_MODULE_GLOBALS macro in kselftest drivers
  [v4] kselftest: add support for skipped tests
  [v4] lib/vsprintf: debug_never_hash_pointers prints all addresses as
    unhashed

 .../admin-guide/kernel-parameters.txt         | 15 ++++++++
 lib/test_bitmap.c                             |  3 +-
 lib/test_printf.c                             | 12 +++++-
 lib/vsprintf.c                                | 38 ++++++++++++++++++-
 tools/testing/selftests/kselftest_module.h    | 18 ++++++---
 5 files changed, 74 insertions(+), 12 deletions(-)

-- 
2.25.1

