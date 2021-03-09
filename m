Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF033327A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhCINtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:49:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:51514 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231304AbhCINsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:48:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615297701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oc97+qf4A0YSsFztEucEY2JDBPPlEsNort962uFLwIM=;
        b=ry6NxALgwZrH3BecWTO0caGbUYi2TBb/FihR4AfMIel2IJT6oxtWixE8hZqPh2gtWWg+iY
        nqVl433XXa7PQbBwjB4P6Sao/7nGhbuuOAz8SuLwBHZOgIeUP16yYZDGvOGIwGCx3YfteO
        DaLZZ42vtb+7pP2dvzqkDlL36c2vzbQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F94AADCD;
        Tue,  9 Mar 2021 13:48:21 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v6 08/12] x86/paravirt: simplify paravirt macros
Date:   Tue,  9 Mar 2021 14:48:09 +0100
Message-Id: <20210309134813.23912-9-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210309134813.23912-1-jgross@suse.com>
References: <20210309134813.23912-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The central pvops call macros ____PVOP_CALL() and ____PVOP_VCALL() are
looking very similar now.

The main differences are using PVOP_VCALL_ARGS or PVOP_CALL_ARGS, which
are identical, and the return value handling.

So drop PVOP_VCALL_ARGS and instead of ____PVOP_VCALL() just use
(void)____PVOP_CALL(long, ...).

Note that it isn't easily possible to just redefine ____PVOP_VCALL()
to use ____PVOP_CALL() instead, as this would require further hiding of
commas in macro parameters.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
V3:
- new patch
V4:
- fix build warnings with clang (kernel test robot)
---
 arch/x86/include/asm/paravirt_types.h | 41 ++++++++-------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 42f9eef84131..45bd21647dd8 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -408,11 +408,9 @@ int paravirt_disable_iospace(void);
  * makes sure the incoming and outgoing types are always correct.
  */
 #ifdef CONFIG_X86_32
-#define PVOP_VCALL_ARGS							\
+#define PVOP_CALL_ARGS							\
 	unsigned long __eax = __eax, __edx = __edx, __ecx = __ecx;
 
-#define PVOP_CALL_ARGS			PVOP_VCALL_ARGS
-
 #define PVOP_CALL_ARG1(x)		"a" ((unsigned long)(x))
 #define PVOP_CALL_ARG2(x)		"d" ((unsigned long)(x))
 #define PVOP_CALL_ARG3(x)		"c" ((unsigned long)(x))
@@ -428,12 +426,10 @@ int paravirt_disable_iospace(void);
 #define VEXTRA_CLOBBERS
 #else  /* CONFIG_X86_64 */
 /* [re]ax isn't an arg, but the return val */
-#define PVOP_VCALL_ARGS						\
+#define PVOP_CALL_ARGS						\
 	unsigned long __edi = __edi, __esi = __esi,		\
 		__edx = __edx, __ecx = __ecx, __eax = __eax;
 
-#define PVOP_CALL_ARGS		PVOP_VCALL_ARGS
-
 #define PVOP_CALL_ARG1(x)		"D" ((unsigned long)(x))
 #define PVOP_CALL_ARG2(x)		"S" ((unsigned long)(x))
 #define PVOP_CALL_ARG3(x)		"d" ((unsigned long)(x))
@@ -458,59 +454,46 @@ int paravirt_disable_iospace(void);
 #define PVOP_TEST_NULL(op)	((void)pv_ops.op)
 #endif
 
-#define PVOP_RETMASK(rettype)						\
+#define PVOP_RETVAL(rettype)						\
 	({	unsigned long __mask = ~0UL;				\
+		BUILD_BUG_ON(sizeof(rettype) > sizeof(unsigned long));	\
 		switch (sizeof(rettype)) {				\
 		case 1: __mask =       0xffUL; break;			\
 		case 2: __mask =     0xffffUL; break;			\
 		case 4: __mask = 0xffffffffUL; break;			\
 		default: break;						\
 		}							\
-		__mask;							\
+		__mask & __eax;						\
 	})
 
 
-#define ____PVOP_CALL(rettype, op, clbr, call_clbr, extra_clbr, ...)	\
+#define ____PVOP_CALL(ret, op, clbr, call_clbr, extra_clbr, ...)	\
 	({								\
 		PVOP_CALL_ARGS;						\
 		PVOP_TEST_NULL(op);					\
-		BUILD_BUG_ON(sizeof(rettype) > sizeof(unsigned long));	\
 		asm volatile(paravirt_alt(PARAVIRT_CALL)		\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
 			     : paravirt_type(op),			\
 			       paravirt_clobber(clbr),			\
 			       ##__VA_ARGS__				\
 			     : "memory", "cc" extra_clbr);		\
-		(rettype)(__eax & PVOP_RETMASK(rettype));		\
+		ret;							\
 	})
 
 #define __PVOP_CALL(rettype, op, ...)					\
-	____PVOP_CALL(rettype, op, CLBR_ANY, PVOP_CALL_CLOBBERS,	\
-		      EXTRA_CLOBBERS, ##__VA_ARGS__)
+	____PVOP_CALL(PVOP_RETVAL(rettype), op, CLBR_ANY,		\
+		      PVOP_CALL_CLOBBERS, EXTRA_CLOBBERS, ##__VA_ARGS__)
 
 #define __PVOP_CALLEESAVE(rettype, op, ...)				\
-	____PVOP_CALL(rettype, op.func, CLBR_RET_REG,			\
+	____PVOP_CALL(PVOP_RETVAL(rettype), op.func, CLBR_RET_REG,	\
 		      PVOP_CALLEE_CLOBBERS, , ##__VA_ARGS__)
 
-
-#define ____PVOP_VCALL(op, clbr, call_clbr, extra_clbr, ...)		\
-	({								\
-		PVOP_VCALL_ARGS;					\
-		PVOP_TEST_NULL(op);					\
-		asm volatile(paravirt_alt(PARAVIRT_CALL)		\
-			     : call_clbr, ASM_CALL_CONSTRAINT		\
-			     : paravirt_type(op),			\
-			       paravirt_clobber(clbr),			\
-			       ##__VA_ARGS__				\
-			     : "memory", "cc" extra_clbr);		\
-	})
-
 #define __PVOP_VCALL(op, ...)						\
-	____PVOP_VCALL(op, CLBR_ANY, PVOP_VCALL_CLOBBERS,		\
+	(void)____PVOP_CALL(, op, CLBR_ANY, PVOP_VCALL_CLOBBERS,	\
 		       VEXTRA_CLOBBERS, ##__VA_ARGS__)
 
 #define __PVOP_VCALLEESAVE(op, ...)					\
-	____PVOP_VCALL(op.func, CLBR_RET_REG,				\
+	(void)____PVOP_CALL(, op.func, CLBR_RET_REG,			\
 		      PVOP_VCALLEE_CLOBBERS, , ##__VA_ARGS__)
 
 
-- 
2.26.2

