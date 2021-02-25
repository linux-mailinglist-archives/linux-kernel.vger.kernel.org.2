Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A318325409
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbhBYQvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:51:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:50230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233844AbhBYQrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:47:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4DB91AC1D;
        Thu, 25 Feb 2021 16:46:47 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Timur Tabi <timur@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] printk: clarify the documentation for plain pointer printing
Date:   Thu, 25 Feb 2021 17:46:39 +0100
Message-Id: <20210225164639.27212-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have several modifiers for plain pointers (%p, %px and %pK) and now also
the no_hash_pointers boot parameter. The documentation should help to choose
which variant to use. Importantly, we should discourage %px in favour of %p
(with the new boot parameter when debugging), and stress that %pK should be
only used for procfs and similar files, not dmesg buffer. This patch clarifies
the documentation in that regard.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 Documentation/core-api/printk-formats.rst | 26 ++++++++++++++++++++++-
 lib/vsprintf.c                            |  7 ++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 160e710d992f..6724adf58082 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -79,7 +79,19 @@ Pointers printed without a specifier extension (i.e unadorned %p) are
 hashed to prevent leaking information about the kernel memory layout. This
 has the added benefit of providing a unique identifier. On 64-bit machines
 the first 32 bits are zeroed. The kernel will print ``(ptrval)`` until it
-gathers enough entropy. If you *really* want the address see %px below.
+gathers enough entropy.
+
+When possible, use specialised modifiers such as %pS or %pB (described below)
+to avoid the need of providing an unhashed address that has to be interpreted
+post-hoc. If not possible, and the aim of printing the address is to provide
+more information for debugging, use %p and boot the kernel with the
+``no_hash_pointers`` parameter during debugging, which will print all %p
+addresses unmodified. If you *really* always want the unmodified address, see
+%px below.
+
+If (and only if) you are printing addresses as a content of a virtual file in
+e.g. procfs or sysfs (using e.g. seq_printf(), not printk()) read by a
+userspace process, use the %pK modifier described below instead of %p or %px.
 
 Error Pointers
 --------------
@@ -139,6 +151,11 @@ For printing kernel pointers which should be hidden from unprivileged
 users. The behaviour of %pK depends on the kptr_restrict sysctl - see
 Documentation/admin-guide/sysctl/kernel.rst for more details.
 
+This modifier is *only* intended when producing content of a file read by
+userspace from e.g. procfs or sysfs, not for dmesg. Please refer to the
+section about %p above for discussion about how to manage hashing pointers
+in printk().
+
 Unmodified Addresses
 --------------------
 
@@ -153,6 +170,13 @@ equivalent to %lx (or %lu). %px is preferred because it is more uniquely
 grep'able. If in the future we need to modify the way the kernel handles
 printing pointers we will be better equipped to find the call sites.
 
+Before using %px, consider if using %p is sufficient together with enabling the
+``no_hash_pointers`` kernel parameter during debugging sessions (see the %p
+description above). One valid scenario for %px might be printing information
+immediately before a panic, which prevents any sensitive information to be
+exploited anyway, and with %px there would be no need to reproduce the panic
+with no_hash_pointers.
+
 Pointer Differences
 -------------------
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 41ddc353ebb8..c4dc971e5ca5 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2186,7 +2186,9 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
  *       Implements a "recursive vsnprintf".
  *       Do not use this feature without some mechanism to verify the
  *       correctness of the format string and va_list arguments.
- * - 'K' For a kernel pointer that should be hidden from unprivileged users
+ * - 'K' For a kernel pointer that should be hidden from unprivileged users.
+ *       Use only for procfs, sysfs and similar files, not printk(); please
+ *       read the documentation (path below) first.
  * - 'NF' For a netdev_features_t
  * - 'h[CDN]' For a variable-length buffer, it prints it as a hex string with
  *            a certain separator (' ' by default):
@@ -2225,7 +2227,8 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
  *		Without an option prints the full name of the node
  *		f full name
  *		P node name, including a possible unit address
- * - 'x' For printing the address. Equivalent to "%lx".
+ * - 'x' For printing the address unmodified. Equivalent to "%lx".
+ *       Please read the documentation (path below) before using!
  * - '[ku]s' For a BPF/tracing related format specifier, e.g. used out of
  *           bpf_trace_printk() where [ku] prefix specifies either kernel (k)
  *           or user (u) memory to probe, and:
-- 
2.30.1

