Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBDF30CE00
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 22:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhBBVhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 16:37:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229838AbhBBVhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 16:37:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 878BF64E4A;
        Tue,  2 Feb 2021 21:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612301812;
        bh=CWKxJvbj5TQL0gN/TZC078q/51NUI9ShZk363Dx5J6o=;
        h=From:To:Subject:Date:From;
        b=bZ7xHGf/3iT3mRNlMienc3MxR0NCLq/VyfZ3wDYUFOukO2PC5u2zGZ3MZZc5eJK+C
         xGRafK06ss3dTTH7VuYX2aDd8GkrBrYVmOXsvIqWJU38pvGMsciMlYYYiKjySn/hNz
         36Stmzat1sr6A2LtZSje64u/+dPNOQowb0Tp1sK7gNpnlmvZI7djl3x9EQn4MVOA4m
         3+UXz28WnNPBbwf1ujeY7MBp4u0OndyFCFeFXAo7A5Ccak7ja+NiOIkZig+PF4Pk61
         UG8KwRa4u6tSRnhF1XLyLfWyd165zr/tD74u/LyxU2q9pk9ysFmtV3v78Y/zJizLbh
         fhEeD2WPbwGBw==
From:   Timur Tabi <timur@kernel.org>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        akinobu.mita@gmail.com
Subject: [PATCH][RESEND] lib/vsprintf: make-printk-non-secret printks all addresses as unhashed
Date:   Tue,  2 Feb 2021 15:36:33 -0600
Message-Id: <20210202213633.755469-1-timur@kernel.org>
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

