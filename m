Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AE8422A00
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhJEOFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235465AbhJEOCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:02:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8EE3617E4;
        Tue,  5 Oct 2021 13:58:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mXkxg-0055mW-SC; Tue, 05 Oct 2021 09:58:28 -0400
Message-ID: <20211005135828.704082376@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 05 Oct 2021 09:57:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 17/27] objtool: Add frame-pointer-specific function ignore
References: <20211005135733.485175654@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

Add a CONFIG_FRAME_POINTER-specific version of
STACK_FRAME_NON_STANDARD() for the case where a function is
intentionally missing frame pointer setup, but otherwise needs
objtool/ORC coverage when frame pointers are disabled.

Link: https://lkml.kernel.org/r/163163047364.489837.17377799909553689661.stgit@devnote2

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/objtool.h       | 12 ++++++++++++
 tools/include/linux/objtool.h | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 7e72d975cb76..aca52db2f3f3 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -66,6 +66,17 @@ struct unwind_hint {
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+/*
+ * STACK_FRAME_NON_STANDARD_FP() is a frame-pointer-specific function ignore
+ * for the case where a function is intentionally missing frame pointer setup,
+ * but otherwise needs objtool/ORC coverage when frame pointers are disabled.
+ */
+#ifdef CONFIG_FRAME_POINTER
+#define STACK_FRAME_NON_STANDARD_FP(func) STACK_FRAME_NON_STANDARD(func)
+#else
+#define STACK_FRAME_NON_STANDARD_FP(func)
+#endif
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -127,6 +138,7 @@ struct unwind_hint {
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
+#define STACK_FRAME_NON_STANDARD_FP(func)
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 7e72d975cb76..aca52db2f3f3 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -66,6 +66,17 @@ struct unwind_hint {
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+/*
+ * STACK_FRAME_NON_STANDARD_FP() is a frame-pointer-specific function ignore
+ * for the case where a function is intentionally missing frame pointer setup,
+ * but otherwise needs objtool/ORC coverage when frame pointers are disabled.
+ */
+#ifdef CONFIG_FRAME_POINTER
+#define STACK_FRAME_NON_STANDARD_FP(func) STACK_FRAME_NON_STANDARD(func)
+#else
+#define STACK_FRAME_NON_STANDARD_FP(func)
+#endif
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -127,6 +138,7 @@ struct unwind_hint {
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
+#define STACK_FRAME_NON_STANDARD_FP(func)
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
-- 
2.32.0
