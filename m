Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0083B1014
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 00:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhFVW2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 18:28:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:61024 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230473AbhFVW2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:28:13 -0400
IronPort-SDR: AG2+4XV+vj7UEng/J2jUt5KEE+/yla1qJZl+H00ZPMtfnpNyN9rRKk0hf5KCafphnRQ/Jbn5Nk
 7zF46kFHkPCg==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="292779534"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="292779534"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:25:55 -0700
IronPort-SDR: dhi+RZMUBLs8oi8vnY+i2EjW/uEiYx/eRSesuUYUO+LI/Kg6Gos17cH2wZ+lVR1+L6Ac2S7o4b
 DYnX5FlkAX9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="454430998"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2021 15:25:54 -0700
Subject: [RFC][PATCH 8/8] x86/pkeys: remove init_pkru_value variable
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, luto@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 22 Jun 2021 15:25:10 -0700
References: <20210622222455.E901B5AC@viggo.jf.intel.com>
In-Reply-To: <20210622222455.E901B5AC@viggo.jf.intel.com>
Message-Id: <20210622222510.0E201C34@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The kernel maintains a "default" PKRU value.  This is logically similar
to the hardware "init state", but the kernel chose a more restrictive
value.

This default is stored in a variable: 'init_pkru_value'.  The default
is also mirrored into the 'init_task' so that the value is picked up
by things like new kernel threads.

Both copies are not needed.  Remove the variable and depend instead
on the copy inside the 'init_task'.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
---

 b/arch/x86/include/asm/pkru.h  |    5 ++---
 b/arch/x86/kernel/cpu/common.c |   22 ++++++++++++++++++----
 b/arch/x86/mm/pkeys.c          |   19 ++-----------------
 3 files changed, 22 insertions(+), 24 deletions(-)

diff -puN arch/x86/include/asm/pkru.h~axe-init_pkru_value arch/x86/include/asm/pkru.h
--- a/arch/x86/include/asm/pkru.h~axe-init_pkru_value	2021-06-22 14:49:14.772051742 -0700
+++ b/arch/x86/include/asm/pkru.h	2021-06-22 14:49:14.781051742 -0700
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_PKRU_H
 #define _ASM_X86_PKRU_H
 
+#include <linux/sched/task.h>
 #include <asm/fpu/xstate.h>
 
 #define PKRU_AD_BIT 0x1
@@ -9,10 +10,8 @@
 #define PKRU_BITS_PER_PKEY 2
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-extern u32 init_pkru_value;
-#define pkru_get_init_value()	READ_ONCE(init_pkru_value)
+#define pkru_get_init_value()	READ_ONCE(init_task.thread.pkru)
 #else
-#define init_pkru_value	0
 #define pkru_get_init_value()	0
 #endif
 
diff -puN arch/x86/kernel/cpu/common.c~axe-init_pkru_value arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~axe-init_pkru_value	2021-06-22 14:49:14.774051742 -0700
+++ b/arch/x86/kernel/cpu/common.c	2021-06-22 14:49:14.782051742 -0700
@@ -464,6 +464,8 @@ __setup("nofsgsbase", x86_nofsgsbase_set
  */
 static bool pku_disabled;
 
+#define PKRU_AD_KEY(pkey)	(PKRU_AD_BIT << ((pkey) * PKRU_BITS_PER_PKEY))
+
 static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 {
 	if (c == &boot_cpu_data) {
@@ -480,11 +482,23 @@ static __always_inline void setup_pku(st
 	}
 
 	cr4_set_bits(X86_CR4_PKE);
-	/* Load the default PKRU value */
-	pkru_write_default();
 
-	/* Establish the default value for future tasks: */
-	init_task.thread.pkru = init_pkru_value;
+	/*
+	 * Establish the default value for future tasks.
+	 *
+ 	 * This is as restrictive as possible.  It ensures that a threads
+	 * clone()'d early in a process's lifetime will not accidentally
+	 * get access to data which is pkey-protected later on.
+	 */
+	init_task.thread.pkru =
+		      PKRU_AD_KEY( 1) | PKRU_AD_KEY( 2) | PKRU_AD_KEY( 3) |
+		      PKRU_AD_KEY( 4) | PKRU_AD_KEY( 5) | PKRU_AD_KEY( 6) |
+		      PKRU_AD_KEY( 7) | PKRU_AD_KEY( 8) | PKRU_AD_KEY( 9) |
+		      PKRU_AD_KEY(10) | PKRU_AD_KEY(11) | PKRU_AD_KEY(12) |
+		      PKRU_AD_KEY(13) | PKRU_AD_KEY(14) | PKRU_AD_KEY(15);
+
+	/* Load the default PKRU value into this CPU's register: */
+	pkru_write_default();
 }
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
diff -puN arch/x86/mm/pkeys.c~axe-init_pkru_value arch/x86/mm/pkeys.c
--- a/arch/x86/mm/pkeys.c~axe-init_pkru_value	2021-06-22 14:49:14.778051742 -0700
+++ b/arch/x86/mm/pkeys.c	2021-06-22 14:49:14.782051742 -0700
@@ -110,27 +110,13 @@ int __arch_override_mprotect_pkey(struct
 	return vma_pkey(vma);
 }
 
-#define PKRU_AD_KEY(pkey)	(PKRU_AD_BIT << ((pkey) * PKRU_BITS_PER_PKEY))
-
-/*
- * Make the default PKRU value (at execve() time) as restrictive
- * as possible.  This ensures that any threads clone()'d early
- * in the process's lifetime will not accidentally get access
- * to data which is pkey-protected later on.
- */
-u32 init_pkru_value = PKRU_AD_KEY( 1) | PKRU_AD_KEY( 2) | PKRU_AD_KEY( 3) |
-		      PKRU_AD_KEY( 4) | PKRU_AD_KEY( 5) | PKRU_AD_KEY( 6) |
-		      PKRU_AD_KEY( 7) | PKRU_AD_KEY( 8) | PKRU_AD_KEY( 9) |
-		      PKRU_AD_KEY(10) | PKRU_AD_KEY(11) | PKRU_AD_KEY(12) |
-		      PKRU_AD_KEY(13) | PKRU_AD_KEY(14) | PKRU_AD_KEY(15);
-
 static ssize_t init_pkru_read_file(struct file *file, char __user *user_buf,
 			     size_t count, loff_t *ppos)
 {
 	char buf[32];
 	unsigned int len;
 
-	len = sprintf(buf, "0x%x\n", init_pkru_value);
+	len = sprintf(buf, "0x%x\n", init_task.thread.pkru);
 	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
 }
 
@@ -158,7 +144,6 @@ static ssize_t init_pkru_write_file(stru
 	if (new_init_pkru & (PKRU_AD_BIT|PKRU_WD_BIT))
 		return -EINVAL;
 
-	WRITE_ONCE(init_pkru_value, new_init_pkru);
 	WRITE_ONCE(init_task.thread.pkru, new_init_pkru);
 
 	return count;
@@ -185,7 +170,7 @@ static __init int setup_init_pkru(char *
 	if (kstrtouint(opt, 0, &new_init_pkru))
 		return 1;
 
-	WRITE_ONCE(init_pkru_value, new_init_pkru);
+	WRITE_ONCE(init_task.thread.pkru, new_init_pkru);
 
 	return 1;
 }
_
