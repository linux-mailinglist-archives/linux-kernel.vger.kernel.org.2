Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3856338C23
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhCLMAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhCLL7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:59:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB9DC061574;
        Fri, 12 Mar 2021 03:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pG0wZH/JG+VFP/9RlBW6E98RYqovEqZJud7EzDWgMuM=; b=NqWp403xVcXg7Rak1H7ABki/Do
        Qr101uioz4P5dy1e8epxX+s73gXCUSGdPIgmc5UB+wiugcLJeNQBOV+J1CVBpkm3xfLBH/lsvKf2D
        r+nCzsWKQzrMlEFWMWhNR6k0vXz7jaIM791zp0JQhQYfo7w2ZmgAfEhsICnoMZGKcUDSVWb7v2ukv
        jpWpqoDegvBCvSYqWQ1W27ic9YGDefbWHR8IKpQFlCYBvs5+DCk6zOfadnOTmjjSmOfCjOerOlQD6
        qOWDArHb8vyrxliRJYbiDF5hZ1BmHTyXpUybv9t4IhaqBaLRPXdGgpbW1j0r8sW8eBJk9hSCdAjnU
        LnE/mtpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKgRc-00AYD6-BW; Fri, 12 Mar 2021 11:59:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0052C300455;
        Fri, 12 Mar 2021 12:59:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E10172D00DEDF; Fri, 12 Mar 2021 12:59:02 +0100 (CET)
Message-ID: <20210312115749.136357911@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 12 Mar 2021 12:32:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, rostedt@goodmis.org, hpa@zytor.com,
        torvalds@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com,
        alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: [PATCH 2/2] objtool,x86: Use asm/nops.h
References: <20210312113253.305040674@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the kernel will rely on a single canonical set of NOPs, make
sure objtool uses the exact same ones.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/arch/x86/include/asm/nops.h |   81 ++++++++++++++++++++++++++++++++++++++
 tools/objtool/arch/x86/decode.c   |   13 +++---
 tools/objtool/sync-check.sh       |    1 
 3 files changed, 90 insertions(+), 5 deletions(-)

--- /dev/null
+++ b/tools/arch/x86/include/asm/nops.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_NOPS_H
+#define _ASM_X86_NOPS_H
+
+/*
+ * Define nops for use with alternative() and for tracing.
+ */
+
+#ifndef CONFIG_64BIT
+
+/*
+ * Generic 32bit nops from GAS:
+ *
+ * 1: nop
+ * 2: movl %esi,%esi
+ * 3: leal 0x0(%esi),%esi
+ * 4: leal 0x0(%esi,%eiz,1),%esi
+ * 5: leal %ds:0x0(%esi,%eiz,1),%esi
+ * 6: leal 0x0(%esi),%esi
+ * 7: leal 0x0(%esi,%eiz,1),%esi
+ * 8: leal %ds:0x0(%esi,%eiz,1),%esi
+ *
+ * Except 5 and 8, which are DS prefixed 4 and 7 resp, where GAS would emit 2
+ * nop instructions.
+ */
+#define BYTES_NOP1	0x90
+#define BYTES_NOP2	0x89,0xf6
+#define BYTES_NOP3	0x8d,0x76,0x00
+#define BYTES_NOP4	0x8d,0x74,0x26,0x00
+#define BYTES_NOP5	0x3e,BYTES_NOP4
+#define BYTES_NOP6	0x8d,0xb6,0x00,0x00,0x00,0x00
+#define BYTES_NOP7	0x8d,0xb4,0x26,0x00,0x00,0x00,0x00
+#define BYTES_NOP8	0x3e,BYTES_NOP7
+
+#else
+
+/*
+ * Generic 64bit nops from GAS:
+ *
+ * 1: nop
+ * 2: osp nop
+ * 3: nopl (%eax)
+ * 4: nopl 0x00(%eax)
+ * 5: nopl 0x00(%eax,%eax,1)
+ * 6: osp nopl 0x00(%eax,%eax,1)
+ * 7: nopl 0x00000000(%eax)
+ * 8: nopl 0x00000000(%eax,%eax,1)
+ */
+#define BYTES_NOP1	0x90
+#define BYTES_NOP2	0x66,BYTES_NOP1
+#define BYTES_NOP3	0x0f,0x1f,0x00
+#define BYTES_NOP4	0x0f,0x1f,0x40,0x00
+#define BYTES_NOP5	0x0f,0x1f,0x44,0x00,0x00
+#define BYTES_NOP6	0x66,BYTES_NOP5
+#define BYTES_NOP7	0x0f,0x1f,0x80,0x00,0x00,0x00,0x00
+#define BYTES_NOP8	0x0f,0x1f,0x84,0x00,0x00,0x00,0x00,0x00
+
+#endif /* CONFIG_64BIT */
+
+#ifdef __ASSEMBLY__
+#define _ASM_MK_NOP(x) .byte x
+#else
+#define _ASM_MK_NOP(x) ".byte " __stringify(x) "\n"
+#endif
+
+#define ASM_NOP1 _ASM_MK_NOP(BYTES_NOP1)
+#define ASM_NOP2 _ASM_MK_NOP(BYTES_NOP2)
+#define ASM_NOP3 _ASM_MK_NOP(BYTES_NOP3)
+#define ASM_NOP4 _ASM_MK_NOP(BYTES_NOP4)
+#define ASM_NOP5 _ASM_MK_NOP(BYTES_NOP5)
+#define ASM_NOP6 _ASM_MK_NOP(BYTES_NOP6)
+#define ASM_NOP7 _ASM_MK_NOP(BYTES_NOP7)
+#define ASM_NOP8 _ASM_MK_NOP(BYTES_NOP8)
+
+#define ASM_NOP_MAX 8
+
+#ifndef __ASSEMBLY__
+extern const unsigned char * const x86_nops[];
+#endif
+
+#endif /* _ASM_X86_NOPS_H */
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -11,6 +11,9 @@
 #include "../../../arch/x86/lib/inat.c"
 #include "../../../arch/x86/lib/insn.c"
 
+#define CONFIG_64BIT 1
+#include <asm/nops.h>
+
 #include <asm/orc_types.h>
 #include <objtool/check.h>
 #include <objtool/elf.h>
@@ -640,11 +643,11 @@ void arch_initial_func_cfi_state(struct
 const char *arch_nop_insn(int len)
 {
 	static const char nops[5][5] = {
-		/* 1 */ { 0x90 },
-		/* 2 */ { 0x66, 0x90 },
-		/* 3 */ { 0x0f, 0x1f, 0x00 },
-		/* 4 */ { 0x0f, 0x1f, 0x40, 0x00 },
-		/* 5 */ { 0x0f, 0x1f, 0x44, 0x00, 0x00 },
+		{ BYTES_NOP1 },
+		{ BYTES_NOP2 },
+		{ BYTES_NOP3 },
+		{ BYTES_NOP4 },
+		{ BYTES_NOP5 },
 	};
 
 	if (len < 1 || len > 5) {
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -10,6 +10,7 @@ FILES="include/linux/objtool.h"
 
 if [ "$SRCARCH" = "x86" ]; then
 FILES="$FILES
+arch/x86/include/asm/nops.h
 arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/orc_types.h
 arch/x86/include/asm/emulate_prefix.h


