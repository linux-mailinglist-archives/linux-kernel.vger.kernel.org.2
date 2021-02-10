Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580C8315EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 06:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhBJFTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 00:19:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231280AbhBJFTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 00:19:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B58264E53;
        Wed, 10 Feb 2021 05:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612934309;
        bh=EAJrkdTjLp1uAF7QOCzOX9hf/OWXBK2mBDp59mEQKdo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WUqdXSTpdbTQbtD1MKQ1t1Px/gJGkRXtE5gBU/JbOb9kwFKX3Ny9JPKCTYrMNG7qN
         zKG9g139dgerm0eigApLVTuW5gBqYgJOFdgQCmhxNRqip3E9bMiGaw2feLWaHEc+p7
         FUuYLc6OUMLt0yiDukcv677Pft/fBa32qJUy4B7LQuFFNmKmuydsUaQ9Z8woznAkfq
         2nXjmb/lfjZPt6bd2jJdVQXuSfetsERiCfznNfSXf4ZJxXQwBglzh8Vhx7YMVULhY6
         g4LChTgodzQUJsrh+N8mNAK5ciE5UXuLFe2xl5WtYlw6nkDzaE0IFQnk6dcpM7rjCq
         4t2rtoNZxWJGw==
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
Subject: [PATCH 1/3] lib/test_printf: use KSTM_MODULE_GLOBALS macro
Date:   Tue,  9 Feb 2021 23:18:12 -0600
Message-Id: <20210210051814.845713-2-timur@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210051814.845713-1-timur@kernel.org>
References: <20210210051814.845713-1-timur@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of defining the total/failed test counters manually,
test_printf should use the kselftest macro created for this
purpose.

Signed-off-by: Timur Tabi <ttabi@nvidia.com>
---
 lib/test_printf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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

