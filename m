Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65EE315E96
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 06:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhBJFHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 00:07:46 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16804 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhBJFGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 00:06:43 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602369b90000>; Tue, 09 Feb 2021 21:06:01 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 05:05:57 +0000
Received: from ubuntu.vdiclient.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 10 Feb 2021 05:05:55 +0000
From:   Timur Tabi <ttabi@nvidia.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        <akpm@linux-foundation.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        <roman.fietze@magna.com>, "Kees Cook" <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        <akinobu.mita@gmail.com>, <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH 3/3] [v2] lib/vsprintf: make-printk-non-secret printks all addresses as unhashed
Date:   Tue, 9 Feb 2021 23:05:29 -0600
Message-ID: <20210210050529.843005-4-ttabi@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210050529.843005-1-ttabi@nvidia.com>
References: <20210210050529.843005-1-ttabi@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612933561; bh=nILtLouqYG0ZxaviM/LyTLNoaremqp+z19s7vgq4xqE=;
        h=From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=P5hUKCXwzU4Hyxh56q/GOc+d92gKvj1odqsEuGop7CfzykReMs+KyLqcNl6TKcGRb
         dqllFJQll9W4jw366WrtBKRO+56qb3HpoR/R2Wbt80fNNd5g+nc7t11T1snhoj104o
         ot99XNNAXv2oHZ1cn/JDYCHO7RXENbIqW+mSFgyBtxmbf6EnbCJPpbXOS5ifNdGuJK
         NxGkXlW/sEoeuky7/di3sLZ1PcMfwHQzIR7UHLkn3ed9GTqfs7yZRa1oekE6sLL+ji
         4m4PYQCykC8Fyj4GrEBeA7GogawaLM3yHERqwRZ1ZHxzk/I8MT1pKeFxiVD8NPkP7C
         EmQgxSdTWs4Lg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timur Tabi <timur@kernel.org>

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

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index 9e3cdb271d06..e639b0f32a6c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2613,6 +2613,21 @@
 			different yeeloong laptops.
 			Example: machtype=3Dlemote-yeeloong-2f-7inch
=20
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
 	max_addr=3Dnn[KMG]	[KNL,BOOT,ia64] All physical memory greater
 			than or equal to this physical address is ignored.
=20
diff --git a/lib/test_printf.c b/lib/test_printf.c
index ad2bcfa8caa1..b0b62d76e598 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -35,6 +35,8 @@ KSTM_MODULE_GLOBALS();
 static char *test_buffer __initdata;
 static char *alloced_buffer __initdata;
=20
+extern bool debug_never_hash_pointers;
+
 static int __printf(4, 0) __init
 do_test(int bufsize, const char *expect, int elen,
 	const char *fmt, va_list ap)
@@ -301,6 +303,12 @@ plain(void)
 {
 	int err;
=20
+	if (debug_never_hash_pointers) {
+		pr_warn("skipping plain 'p' tests");
+		skipped_tests +=3D 2;
+		return;
+	}
+
 	err =3D plain_hash();
 	if (err) {
 		pr_warn("plain 'p' does not appear to be hashed\n");
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3b53c73580c5..1296d9b0b328 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2090,6 +2090,34 @@ char *fwnode_string(char *buf, char *end, struct fwn=
ode_handle *fwnode,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
=20
+/* Disable pointer hashing if requested */
+bool debug_never_hash_pointers __ro_after_init;
+EXPORT_SYMBOL_GPL(debug_never_hash_pointers);
+
+static int __init debug_never_hash_pointers_enable(char *str)
+{
+	debug_never_hash_pointers =3D true;
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
@@ -2297,8 +2325,14 @@ char *pointer(const char *fmt, char *buf, char *end,=
 void *ptr,
 		}
 	}
=20
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
=20
 /*
--=20
2.25.1

