Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC9331B12B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 17:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhBNQOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 11:14:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhBNQOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 11:14:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 201EC64E61;
        Sun, 14 Feb 2021 16:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613319234;
        bh=A/DF1iVDTPKIB70CF61fjiKLTM0RjrihmRPkrxfYYdQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cCc6GhcvJ0dkEmdG2Ic7W24nFo7aHuak2XdE9e1NZ2Zry+zg5owY8jiRQ9ZRF5kXp
         G1RsOEXDM0KHhMNM2cZ+nBhjkg2wupZO7V8U/DkvdT4XozAdOPIr6JN3CUabK1x3LP
         eMHaa7F4JvPi9hAxdnipRv7l22AKMuh7unCRy3kLMlw1Xbd/VEerIOEB+7bFYMocKD
         MHzCvHzQcuabEqZ2iwOLIa/oKK2l4asfmrw4kv+qV6/3Ose5Za6KNJ7jSkb8TSepmr
         CmF8Sow/TZuSDlvPkXeQvzvCDDIoxHvPBWe7aq5HBrqAwZsvQSS5UMlzcQJH5TEMOZ
         F0FTB98DjCFvg==
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
Subject: [PATCH 1/3] [v4] lib: use KSTM_MODULE_GLOBALS macro in kselftest drivers
Date:   Sun, 14 Feb 2021 10:13:46 -0600
Message-Id: <20210214161348.369023-2-timur@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210214161348.369023-1-timur@kernel.org>
References: <20210214161348.369023-1-timur@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of defining the total/failed test counters manually,
test drivers that are clients of kselftest should use the
macro created for this purpose.

Signed-off-by: Timur Tabi <timur@kernel.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Marco Elver <elver@google.com>
---
 lib/test_bitmap.c | 3 +--
 lib/test_printf.c | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 4425a1dd4ef1..0ea0e8258f14 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -16,8 +16,7 @@
 
 #include "../tools/testing/selftests/kselftest_module.h"
 
-static unsigned total_tests __initdata;
-static unsigned failed_tests __initdata;
+KSTM_MODULE_GLOBALS();
 
 static char pbl_buffer[PAGE_SIZE] __initdata;
 
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 7ac87f18a10f..ad2bcfa8caa1 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -30,8 +30,8 @@
 #define PAD_SIZE 16
 #define FILL_CHAR '$'
 
-static unsigned total_tests __initdata;
-static unsigned failed_tests __initdata;
+KSTM_MODULE_GLOBALS();
+
 static char *test_buffer __initdata;
 static char *alloced_buffer __initdata;
 
-- 
2.25.1

