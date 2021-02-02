Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E145A30CCF2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhBBUVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:21:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232860AbhBBUTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:19:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D53464E58;
        Tue,  2 Feb 2021 20:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612297138;
        bh=CWKxJvbj5TQL0gN/TZC078q/51NUI9ShZk363Dx5J6o=;
        h=From:To:Subject:Date:From;
        b=lua6oLDMbInI06Z0ihdesrkkaQiFg7d+IZmmRjJV8kP8F/MrbMyDMtqKRVaM7NXO3
         BvtcIlYjkkrFzFTaJOu2khVbZywcNEf7Ub8/jUJIw00a/nrZr0NCiJ/A7OBAMsi2yq
         RnY7I/bC8P9B+59EypKpvFan34G4+ivLfHLWpR5/t4tWwFOnp3QY6X3aLR+WHU/hmM
         VQh3UoAnOhYG0CXEdqX8ubbf2qiipBmVFxM1tiNVFfnGP/EJqu+SBpFiAzDY3n/jDo
         zXPllB6AVXdffGzNw1KXziT0MMwnvsJ/GE7wd10XmLQ36MZ20739YM1Wvw72DFaEzy
         8JOdGngQb2WaQ==
From:   Timur Tabi <timur@kernel.org>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        akinobu.mita@gmail.com
Subject: [PATCH] lib/vsprintf: make-printk-non-secret printks all addresses as unhashed
Date:   Tue,  2 Feb 2021 14:18:46 -0600
Message-Id: <20210202201846.716915-1-timur@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the make-printk-non-secret command-line parameter is set, then
printk("%p") will print addresses as unhashed.  This is useful for
debugging purposes.

A large warning message is displayed if this option is enabled,
because unhashed addresses, while useful for debugging, exposes
kernel addresses which can be a security risk.

Signed-off-by: Timur Tabi <timur@kernel.org>
---
 lib/vsprintf.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3b53c73580c5..b9f87084afb0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2090,6 +2090,30 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
+/* Disable pointer hashing if requested */
+static bool debug_never_hash_pointers __ro_after_init;
+
+static int __init debug_never_hash_pointers_enable(char *str)
+{
+	debug_never_hash_pointers = true;
+	pr_warn("**********************************************************\n");
+	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
+	pr_warn("**                                                      **\n");
+	pr_warn("** All pointers that are printed to the console will    **\n");
+	pr_warn("** be printed as unhashed.                              **\n");
+	pr_warn("**                                                      **\n");
+	pr_warn("** Kernel memory addresses are exposed, which may       **\n");
+	pr_warn("** compromise security on your system.                  **\n");
+	pr_warn("**                                                      **\n");
+	pr_warn("** If you see this message and you are not debugging    **\n");
+	pr_warn("** the kernel, report this immediately to your vendor!  **\n");
+	pr_warn("**                                                      **\n");
+	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
+	pr_warn("**********************************************************\n");
+	return 0;
+}
+early_param("make-printk-non-secret", debug_never_hash_pointers_enable);
+
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
  * by an extra set of alphanumeric characters that are extended format
@@ -2297,8 +2321,14 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		}
 	}
 
-	/* default is to _not_ leak addresses, hash before printing */
-	return ptr_to_id(buf, end, ptr, spec);
+	/*
+	 * default is to _not_ leak addresses, so hash before printing, unless
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

