Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE77F315EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 06:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhBJFT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 00:19:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231310AbhBJFTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 00:19:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E59464E45;
        Wed, 10 Feb 2021 05:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612934313;
        bh=V5tnoziY2hMH/8D5UdgC5pB8GP//YpSeQXh/fPdcfMg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=G5+MQtyLVJ4v/LNssd7nAFVCymdSi+QU/n68hkrUFBoYkTUSsS8i4iO3pOQ2qwL6i
         31A8/E+qR+5M+MlfNzmYWTlIc+gXTmRTcDw+9fpRjpwlW0pPdZl9+xZ20QxJRxLZG2
         pdacZbioJnRVcq8r2EbKQSYKokHMx5GQZapiLYYuH00n/LrTPm/1pAjqLmEV64cZZi
         26PgvlLCOzskmzmwrip2JmcCZiPv4KKZ9EY6pMjG23gRxidIADVQxG/5YjAqFxW36U
         tyZBb3yrIXUfL+OaYQKBI7A096qzxfj4/XKWkrLmwh2Rd4EK0PLWDCHis3Z6yVZjT7
         x6i+sAoqpIFOQ==
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
Subject: [PATCH 3/3] lib/vsprintf: make-printk-non-secret printks all addresses as unhashed
Date:   Tue,  9 Feb 2021 23:18:14 -0600
Message-Id: <20210210051814.845713-4-timur@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210051814.845713-1-timur@kernel.org>
References: <20210210051814.845713-1-timur@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the make-printk-non-secret command line parameter is set, then
printk("%p") will print pointers as unhashed.  This is useful for
debugging purposes.

A large warning message is displayed if this option is enabled.
Unhashed pointers, while useful for debugging, expose kernel
addresses which can be a security risk.

Also update test_printf to skip the hashed pointer tests if the
command-line option is set.

Signed-off-by: Timur Tabi <timur@kernel.org>
Acked-by: Petr Mladek <pmladek@suse.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 15 ++++++++
 lib/test_printf.c                             |  8 ++++
 lib/vsprintf.c                                | 38 ++++++++++++++++++-
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a10b545c2070..6962379469e4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2613,6 +2613,21 @@
 			different yeeloong laptops.
 			Example: machtype=lemote-yeeloong-2f-7inch
 
+        make-printk-non-secret
+			Force pointers printed to the console to be unhashed.
+			By default, when a pointer is printed to the kernel
+			console (via %p format string), that pointer is
+			"hashed", i.e. obscured by hashing the pointer value.
+			This is a security feature that hides actual kernel
+			addresses from unprivileged users, but it also makes
+			debugging the kernel more difficult since unequal
+			pointers can no longer be compared.  If this option is
+			specified, then all normal pointers will have their
+			true value printed.  Pointers printed via %pK may
+			still be hashed.  This option should only be specified
+			when debugging the kernel.  Please do not use on
+			production kernels.
+
 	max_addr=nn[KMG]	[KNL,BOOT,ia64] All physical memory greater
 			than or equal to this physical address is ignored.
 
diff --git a/lib/test_printf.c b/lib/test_printf.c
index ad2bcfa8caa1..b0b62d76e598 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -35,6 +35,8 @@ KSTM_MODULE_GLOBALS();
 static char *test_buffer __initdata;
 static char *alloced_buffer __initdata;
 
+extern bool debug_never_hash_pointers;
+
 static int __printf(4, 0) __init
 do_test(int bufsize, const char *expect, int elen,
 	const char *fmt, va_list ap)
@@ -301,6 +303,12 @@ plain(void)
 {
 	int err;
 
+	if (debug_never_hash_pointers) {
+		pr_warn("skipping plain 'p' tests");
+		skipped_tests += 2;
+		return;
+	}
+
 	err = plain_hash();
 	if (err) {
 		pr_warn("plain 'p' does not appear to be hashed\n");
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3b53c73580c5..1296d9b0b328 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2090,6 +2090,34 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
+/* Disable pointer hashing if requested */
+bool debug_never_hash_pointers __ro_after_init;
+EXPORT_SYMBOL_GPL(debug_never_hash_pointers);
+
+static int __init debug_never_hash_pointers_enable(char *str)
+{
+	debug_never_hash_pointers = true;
+
+	pr_warn("**********************************************************\n");
+	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
+	pr_warn("**                                                      **\n");
+	pr_warn("** All pointers that are printed to the console will    **\n");
+	pr_warn("** be printed as unhashed.                              **\n");
+	pr_warn("**                                                      **\n");
+	pr_warn("** Kernel memory addresses are exposed, which may       **\n");
+	pr_warn("** reduce the security of your system.                  **\n");
+	pr_warn("**                                                      **\n");
+	pr_warn("** If you see this message and you are not debugging    **\n");
+	pr_warn("** the kernel, report this immediately to your system   **\n");
+	pr_warn("** administrator!                                       **\n");
+	pr_warn("**                                                      **\n");
+	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
+	pr_warn("**********************************************************\n");
+
+	return 0;
+}
+early_param("make-printk-non-secret", debug_never_hash_pointers_enable);
+
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
  * by an extra set of alphanumeric characters that are extended format
@@ -2297,8 +2325,14 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		}
 	}
 
-	/* default is to _not_ leak addresses, hash before printing */
-	return ptr_to_id(buf, end, ptr, spec);
+	/*
+	 * default is to _not_ leak addresses, so hash before printing unless
+	 * make-printk-non-secret is specified on the command line.
+	 */
+	if (unlikely(debug_never_hash_pointers))
+		return pointer_string(buf, end, ptr, spec);
+	else
+		return ptr_to_id(buf, end, ptr, spec);
 }
 
 /*
-- 
2.25.1

