Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7FE315ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 06:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhBJFTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 00:19:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231255AbhBJFTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 00:19:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2658764E42;
        Wed, 10 Feb 2021 05:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612934307;
        bh=r8mlLnkiTtqHjwX7GPDdrTYdtz5ipUM83ae8N83ypv0=;
        h=From:To:Subject:Date:From;
        b=p3BkaluQeAe+D7tVC7ezEiSj63R3tHm0kVkGz5PhnawSERsD4o4EmzwPRLeTDEyVk
         W2Es7rCZBCGuILlzJQXS4TSkk9N1aEaw7Ap7SRjaver3H9qpGtVKm4NdYxqDz3ac3r
         fESqAjPY/KpMzfbsY/jbf1R692+e2Wg7mBck8DDO5PWkN6g0g/GTcZN02MegnkXTxB
         Vo/dB/ewF2q6SyMwQlJ8IVfOH2yGUXJqqJxk+M6FzLlHYAToOXFCIDa9UWlZb/HviA
         ZnifXDhIuRbrHRjWhmDmDlx6bHmQBfRf4CzvG6qXQVRp3L92VPhguumWgZGJ6uvVho
         rXH5FTiECjrxw==
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
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 0/3][RESEND] add support for never printing hashed addresses
Date:   Tue,  9 Feb 2021 23:18:11 -0600
Message-Id: <20210210051814.845713-1-timur@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[accidentally sent from the wrong email address, so resending]

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

Timur Tabi (3):
  lib/test_printf: use KSTM_MODULE_GLOBALS macro
  kselftest: add support for skipped tests
  [v2] lib/vsprintf: make-printk-non-secret printks all addresses as
    unhashed

 .../admin-guide/kernel-parameters.txt         | 15 +++++++
 lib/test_printf.c                             | 12 +++++-
 lib/vsprintf.c                                | 40 ++++++++++++++++++-
 tools/testing/selftests/kselftest_module.h    | 18 ++++++---
 4 files changed, 75 insertions(+), 10 deletions(-)

-- 
2.25.1

