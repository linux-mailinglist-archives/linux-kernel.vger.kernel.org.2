Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE9236A967
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 23:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhDYVMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 17:12:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:39913 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhDYVMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 17:12:39 -0400
IronPort-SDR: NNf1iKeDHOdO8bsOXdi1AybhUcfQgkC8b4ISQ+lFnhDXWBG/56Eg3CcszDWx4BrF1IwaUDt9nO
 c4/v+X+J4lXg==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="260209109"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="260209109"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 14:11:58 -0700
IronPort-SDR: luuqIzZY83IKnOkMvGxO8R7d1vhCzuWojivUgJTwhcPbwRsRyg1NCR+pGGIcxBBboaUDyZS6xc
 VawvYKbWUdgA==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="402697833"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 14:11:58 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     peterz@infradead.org
Cc:     jpoimboe@redhat.com, jbaron@akamai.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] static_call: Use single copy of static_call_return0
Date:   Sun, 25 Apr 2021 14:11:40 -0700
Message-Id: <20210425211140.3157580-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the inline version of static calls it is trying to use
all static call functions inline. But this doesn't work for
__static_call_return0, because its address is always taken,
which forces the compiler to generate a out of line copy.

If it only exists as a static inline this means there are
many copies generated. Instead use the out of line in static_call.c
for this.

This fixes another bug. When _INLINE is set static_inline.c was
not compiled at all, which disabled the self test even when
it was enabled in the configuration.

This fixes a build problem with gcc LTO. __static_call_return0
is referenced from assembler, which requires making it global
because the assembler can end in a different file than the other
C code.  But that's not possible for a static inline function.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 include/linux/static_call.h | 9 ++-------
 kernel/Makefile             | 2 +-
 kernel/static_call.c        | 4 ++++
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index ae04b1123a93..e75aef659224 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -100,6 +100,8 @@
 #ifdef CONFIG_HAVE_STATIC_CALL
 #include <asm/static_call.h>
 
+extern long __static_call_return0(void);
+
 /*
  * Either @site or @tramp can be NULL.
  */
@@ -148,8 +150,6 @@ extern void __static_call_update(struct static_call_key *key, void *tramp, void
 extern int static_call_mod_init(struct module *mod);
 extern int static_call_text_reserved(void *start, void *end);
 
-extern long __static_call_return0(void);
-
 #define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
 	DECLARE_STATIC_CALL(name, _func);				\
 	__visible struct static_call_key STATIC_CALL_KEY(name) = {	\
@@ -221,11 +221,6 @@ static inline int static_call_text_reserved(void *start, void *end)
 	return 0;
 }
 
-static inline long __static_call_return0(void)
-{
-	return 0;
-}
-
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
diff --git a/kernel/Makefile b/kernel/Makefile
index 320f1f3941b7..b589442c7724 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -110,7 +110,7 @@ obj-$(CONFIG_CPU_PM) += cpu_pm.o
 obj-$(CONFIG_BPF) += bpf/
 obj-$(CONFIG_KCSAN) += kcsan/
 obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
-obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call.o
+obj-$(CONFIG_HAVE_STATIC_CALL) += static_call.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 6d332c0c9134..7ec8608d94ab 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -10,6 +10,8 @@
 #include <linux/processor.h>
 #include <asm/sections.h>
 
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+
 extern struct static_call_site __start_static_call_sites[],
 			       __stop_static_call_sites[];
 extern struct static_call_tramp_key __start_static_call_tramp_key[],
@@ -496,6 +498,8 @@ int __init static_call_init(void)
 }
 early_initcall(static_call_init);
 
+#endif /* HAVE_STATIC_CALL_INLINE */
+
 long __static_call_return0(void)
 {
 	return 0;
-- 
2.25.4

