Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF27743E5F4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhJ1QVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:21:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:34178 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhJ1QVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:21:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="254023023"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="254023023"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 09:12:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="725782695"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 28 Oct 2021 09:12:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D9FCF107; Thu, 28 Oct 2021 19:12:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 1/1] kernel.h: split out instruction pointer accessors
Date:   Thu, 28 Oct 2021 19:12:48 +0300
Message-Id: <20211028161248.45232-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>

bottom_half.h needs _THIS_IP_ to be standalone, so split that and _RET_IP_
out from kernel.h into the new instruction_pointer.h. kernel.h directly
needs them, so include it there and replace the include of kernel.h with
this new file in bottom_half.h.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: fixed yet another lurking typo (lkp), build on x86_64 passed now
 include/linux/bottom_half.h         | 2 +-
 include/linux/instruction_pointer.h | 8 ++++++++
 include/linux/kernel.h              | 4 +---
 3 files changed, 10 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/instruction_pointer.h

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index 11d107d88d03..fc53e0ad56d9 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_BH_H
 #define _LINUX_BH_H
 
-#include <linux/kernel.h>
+#include <linux/instruction_pointer.h>
 #include <linux/preempt.h>
 
 #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
diff --git a/include/linux/instruction_pointer.h b/include/linux/instruction_pointer.h
new file mode 100644
index 000000000000..cda1f706eaeb
--- /dev/null
+++ b/include/linux/instruction_pointer.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_INSTRUCTION_POINTER_H
+#define _LINUX_INSTRUCTION_POINTER_H
+
+#define _RET_IP_		(unsigned long)__builtin_return_address(0)
+#define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
+
+#endif /* _LINUX_INSTRUCTION_POINTER_H */
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 24df51162e3e..968b4c4fe65b 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -20,6 +20,7 @@
 #include <linux/printk.h>
 #include <linux/build_bug.h>
 #include <linux/static_call_types.h>
+#include <linux/instruction_pointer.h>
 #include <asm/byteorder.h>
 
 #include <uapi/linux/kernel.h>
@@ -53,9 +54,6 @@
 }					\
 )
 
-#define _RET_IP_		(unsigned long)__builtin_return_address(0)
-#define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
-
 /**
  * upper_32_bits - return bits 32-63 of a number
  * @n: the number we're accessing
-- 
2.33.0

