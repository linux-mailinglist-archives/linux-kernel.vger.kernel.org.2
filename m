Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7345D324B54
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 08:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbhBYHf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 02:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbhBYHeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:34:17 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FC6C061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:33:51 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o63so3226324pgo.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ebRx4V31DSDhZXC0yr3LtKn279spf6opfPxtzn4I70=;
        b=b5Dg9LmaXf2YzgQNvM6K47rUortYW8n2hCPF5Krke30h9MXYtgfvQkBUZygduBw47k
         HOWRlBh3NPu3jRaUUgDwM9zK0n/HsCOVwYAsKiE+4GeDc0kfUqYBXSmbMPoMEeKO9L3r
         lUuUSKzR6/htE7vhh8dSgrr43yqm4IczLlTppo3nunX/DE0c9gLZuDIVFcjvFyUW8+27
         UEME7RkgvXelyfL29k8zxAgPBQJnWM0zXlTCt8Tt3rEspcDcVntrYmHTCnLVYg1OX/k3
         UeoXLbqXEl7oOYwyS1AseioOuPsNagDFOdNvUIkbWVYr9bhFwcyDy0qbjZqtZ0MWwKxl
         RA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ebRx4V31DSDhZXC0yr3LtKn279spf6opfPxtzn4I70=;
        b=panxGOni/olnsQiW0lP7B7xVFTAjq7Z2wYu4WaIjJVrQd8EAsn3C443nT9ahN0KgXd
         JXAiWKPRe24ozTZXeBmZESdrD34S2rclMu/BpuqPp6qISrU+RrVbid2l6XA2ZoEhZh5k
         HWdUxWQWgDGux+GcmIKBl4ADLZ+FN7IlcUZ3raHvfrQ9hFe+69dmV7Ik73FlO5n5bLQ6
         alVIHXfv7ZjlJzQeT28hPvBa32TbT41tQOsOxwdlivNHNl3NVVBwUY4yam3axUZvB+en
         SvnD4KBfdjuUe0dGeMYMi/jjnCvpwCnqGajhpx2jixYrhMejhUs3sRpsQH6lu+qPCiRK
         PMLw==
X-Gm-Message-State: AOAM530TiTpNsbiH7w9wMGCB+R14et/tjjNZvidt3CdNb0oEi4TLsMKb
        rFpNp7RMpmBiJVfeNyQOllU=
X-Google-Smtp-Source: ABdhPJz45/nZGq0qVdXrll6ISaRWXK4Er9JRFHjpVmUudiHHnAwEcTD+fJdDZQNzJuCCFu58chwvew==
X-Received: by 2002:a05:6a00:22d1:b029:1b4:9bb5:724c with SMTP id f17-20020a056a0022d1b02901b49bb5724cmr2069327pfj.63.1614238430691;
        Wed, 24 Feb 2021 23:33:50 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id w3sm4917561pjt.24.2021.02.24.23.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 23:33:50 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Nadav Amit <namit@vmware.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: [RFC 2/6] x86/vdso: add mask and flags to extable
Date:   Wed, 24 Feb 2021 23:29:06 -0800
Message-Id: <20210225072910.2811795-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225072910.2811795-1-namit@vmware.com>
References: <20210225072910.2811795-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Add a "mask" field to vDSO exception tables that says which exceptions
should be handled.

Add a "flags" field to vDSO as well to provide additional information
about the exception.

The existing preprocessor macro _ASM_VDSO_EXTABLE_HANDLE for assembly is
not easy to use as it requires the user to stringify the expanded C
macro. Remove _ASM_VDSO_EXTABLE_HANDLE and use a similar scheme to
ALTERNATIVE, using assembly macros directly in assembly without wrapping
them in C macros.

Move the vsgx supported exceptions test out of the generic C code into
vsgx-specific assembly by setting vsgx supported exceptions in the mask.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/entry/vdso/extable.c |  9 +--------
 arch/x86/entry/vdso/extable.h | 21 +++++++++++++--------
 arch/x86/entry/vdso/vsgx.S    |  9 +++++++--
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/x86/entry/vdso/extable.c b/arch/x86/entry/vdso/extable.c
index c81e78636220..93fb37bd32ad 100644
--- a/arch/x86/entry/vdso/extable.c
+++ b/arch/x86/entry/vdso/extable.c
@@ -7,6 +7,7 @@
 
 struct vdso_exception_table_entry {
 	int insn, fixup;
+	unsigned int mask, flags;
 };
 
 bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
@@ -17,14 +18,6 @@ bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
 	unsigned int nr_entries, i;
 	unsigned long base;
 
-	/*
-	 * Do not attempt to fixup #DB or #BP.  It's impossible to identify
-	 * whether or not a #DB/#BP originated from within an SGX enclave and
-	 * SGX enclaves are currently the only use case for vDSO fixup.
-	 */
-	if (trapnr == X86_TRAP_DB || trapnr == X86_TRAP_BP)
-		return false;
-
 	if (!current->mm->context.vdso)
 		return false;
 
diff --git a/arch/x86/entry/vdso/extable.h b/arch/x86/entry/vdso/extable.h
index b56f6b012941..7ca8a0776805 100644
--- a/arch/x86/entry/vdso/extable.h
+++ b/arch/x86/entry/vdso/extable.h
@@ -2,26 +2,31 @@
 #ifndef __VDSO_EXTABLE_H
 #define __VDSO_EXTABLE_H
 
+#include <asm/trapnr.h>
+
+#define ASM_VDSO_ASYNC_FLAGS	(1 << 0)
+
 /*
  * Inject exception fixup for vDSO code.  Unlike normal exception fixup,
  * vDSO uses a dedicated handler the addresses are relative to the overall
  * exception table, not each individual entry.
  */
 #ifdef __ASSEMBLY__
-#define _ASM_VDSO_EXTABLE_HANDLE(from, to)	\
-	ASM_VDSO_EXTABLE_HANDLE from to
-
-.macro ASM_VDSO_EXTABLE_HANDLE from:req to:req
+.macro ASM_VDSO_EXTABLE_HANDLE from:req to:req mask:req flags:req
 	.pushsection __ex_table, "a"
 	.long (\from) - __ex_table
 	.long (\to) - __ex_table
+	.long (\mask)
+	.long (\flags)
 	.popsection
 .endm
 #else
-#define _ASM_VDSO_EXTABLE_HANDLE(from, to)	\
-	".pushsection __ex_table, \"a\"\n"      \
-	".long (" #from ") - __ex_table\n"      \
-	".long (" #to ") - __ex_table\n"        \
+#define ASM_VDSO_EXTABLE_HANDLE(from, to, mask, flags)		\
+	".pushsection __ex_table, \"a\"\n"			\
+	".long (" #from ") - __ex_table\n"			\
+	".long (" #to ") - __ex_table\n"			\
+	".long (" #mask ")\n"					\
+	".long (" #flags ")\n"					\
 	".popsection\n"
 #endif
 
diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
index 86a0e94f68df..c588255af480 100644
--- a/arch/x86/entry/vdso/vsgx.S
+++ b/arch/x86/entry/vdso/vsgx.S
@@ -4,6 +4,7 @@
 #include <asm/export.h>
 #include <asm/errno.h>
 #include <asm/enclu.h>
+#include <asm/trapnr.h>
 
 #include "extable.h"
 
@@ -146,6 +147,10 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
 
 	.cfi_endproc
 
-_ASM_VDSO_EXTABLE_HANDLE(.Lenclu_eenter_eresume, .Lhandle_exception)
-
+/*
+ * Do not attempt to fixup #DB or #BP.  It's impossible to identify
+ * whether or not a #DB/#BP originated from within an SGX enclave.
+ */
+ASM_VDSO_EXTABLE_HANDLE .Lenclu_eenter_eresume, .Lhandle_exception,	\
+			~((1<<X86_TRAP_DB)+(1<<X86_TRAP_BP)), 0
 SYM_FUNC_END(__vdso_sgx_enter_enclave)
-- 
2.25.1

