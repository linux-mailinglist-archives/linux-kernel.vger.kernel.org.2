Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9AE34AD10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhCZREF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:04:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:65176 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229986AbhCZRDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:03:41 -0400
IronPort-SDR: 2m3SjYmeQCAg7zgda/G38PO/xeDJHkhHuXNcKB6rJbE/WQ6u6XoySHeS5nAeHHYmBYfU8h1oYN
 oqEjTYKc10EA==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="187900659"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="187900659"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 10:03:40 -0700
IronPort-SDR: wLL5MTp09blVL1D5KSYTjDaIvoRD56Hi42LhKXW/8iL93SWcutJacI7t8mSUszbt4gd7N2e6B4
 e1Oj4dfRXamA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="382706203"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 26 Mar 2021 10:03:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A5DE611F; Fri, 26 Mar 2021 19:03:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v1 1/1] kernel.h: Drop inclusion in bitmap.h
Date:   Fri, 26 Mar 2021 19:03:47 +0200
Message-Id: <20210326170347.37441-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bitmap.h header is used in a lot of code around the kernel.
Besides that it includes kernel.h which sometimes makes a loop.

Break the loop by introducing align.h, including it in kernel.h
and bitmap.h followed by replacing kernel.h with limits.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/align.h  | 15 +++++++++++++++
 include/linux/bitmap.h |  3 ++-
 include/linux/kernel.h |  9 +--------
 3 files changed, 18 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/align.h

diff --git a/include/linux/align.h b/include/linux/align.h
new file mode 100644
index 000000000000..2b4acec7b95a
--- /dev/null
+++ b/include/linux/align.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ALIGN_H
+#define _LINUX_ALIGN_H
+
+#include <linux/const.h>
+
+/* @a is a power of 2 value */
+#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
+#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
+#define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
+#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
+#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
+#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
+
+#endif	/* _LINUX_ALIGN_H */
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 70a932470b2d..6cbcd9d9edd2 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -4,10 +4,11 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/align.h>
 #include <linux/types.h>
 #include <linux/bitops.h>
+#include <linux/limits.h>
 #include <linux/string.h>
-#include <linux/kernel.h>
 
 /*
  * bitmaps provide bit arrays that consume one or more unsigned
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5b7ed6dc99ac..09035ac67d4b 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -3,6 +3,7 @@
 #define _LINUX_KERNEL_H
 
 #include <stdarg.h>
+#include <linux/align.h>
 #include <linux/limits.h>
 #include <linux/linkage.h>
 #include <linux/stddef.h>
@@ -30,14 +31,6 @@
  */
 #define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
 
-/* @a is a power of 2 value */
-#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
-#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
-#define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
-#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
-#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
-#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
-
 /* generic data direction definitions */
 #define READ			0
 #define WRITE			1
-- 
2.30.2

