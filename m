Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223B431726F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhBJVgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:36:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:56128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232956AbhBJVft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:35:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AB0E64EDC;
        Wed, 10 Feb 2021 21:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612992909;
        bh=opaMJmbGUaCmc56PK+hOgvVk5SMSJfQb65oUNwKsMM0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sTvTPnwIPxrWl4CaHUE8ZcmUojSiIZ7yE3ZiJQLzgY60/1ek1Yb8Y1ouJHADutrns
         2PK4vVslP4QVoSjcu2sJHnJW9n2Mf27yWMrO8MDLEJE+PNaoxjla+FW4f3fY965G/3
         8o50CLL/m7gEX0TvZsF0JFwsfq98qS82bDu7VIDjl48n7LbfBxF/Mia5Wp3go8YHQ/
         9zLZUdzpjGD5FH16En87XVC+ySozUjZlgukugDIsJFUtfq3VBhzK+WtOdxjNoIb+tT
         Hn28QhlYfsLTQSHLjn48qu2kXokuTuOsg5X0gT8Jx+OFoI0EfPh1hKmwK8Ml3pbRav
         fLFzP83oZmc/g==
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
Subject: [PATCH 1/3] [v3] lib: use KSTM_MODULE_GLOBALS macro in kselftest drivers
Date:   Wed, 10 Feb 2021 15:34:51 -0600
Message-Id: <20210210213453.1504219-2-timur@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210213453.1504219-1-timur@kernel.org>
References: <20210210213453.1504219-1-timur@kernel.org>
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

