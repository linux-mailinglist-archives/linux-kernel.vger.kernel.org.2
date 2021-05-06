Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCAC374FD5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhEFHMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhEFHMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:12:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073A6C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 00:11:33 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id e15so4417178pfv.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 00:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=RKE6jjXcJ0imsPN/Jcdv9I0BKrwvTPJLbt84HGfjOKU=;
        b=cVTBP3osPNsPjzgzQh1Ow7dy1X6bO3T0NsqwfkgRAygGaaHQr2D4cisPBz/HvaHfOn
         9ohX/ECpyU7rjhfKpMZ3u8EegIPDv+ywdGt5MTNdY7ZMJGVsNQPMCy76d7lnRIjCdiKQ
         SCdpV1ZhdIisiF1Did7to27dEP/PP+zAvRM07D7XuugW1ULhs5Gj7ceIbywrclcoDh3n
         /BgGeBa99rolzayb1B7Oj/jNM/YiLg8MUKv/fPKT8FrCkb63yrnfGxauau2u4LRxfuAV
         jeQwMv9il3ACnu+eduoy8uFHcGPlQd4qN/cPIpUPoHtJNCB88WJDIqaoKaKBJqO+Z2y9
         pcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=RKE6jjXcJ0imsPN/Jcdv9I0BKrwvTPJLbt84HGfjOKU=;
        b=g3aAfgqoMlgH8nMdqnZWmDcgSfwspBaCPAlToXxwYMCJHlgu3Z/w+IlLv8R196aOGv
         ptxK7QzhtOY9mjp1PZ/OzzGFZ+52bnbhldsv9rr4ksO1JIVgZyZEvrHnY7BliexJASvj
         e2dncaXcNa1iphIbvGiHXnj2WtAvHNO4JlkkeJV5RZwXoY5GpBb39ajuh9lRLz3RY4WE
         sK89fEfvphc6rCFOTBG/M/pBmZE0Z//uQ/Lnv60HIQ5YQcTyU29jrV7EQyniX0VsYhgY
         oIYJWllqON+DXfyMU3xiQYcRz8N8sLojxBUdmQfR7N+dYOFotFl2H8NxhVIS+NnIMAI5
         eajA==
X-Gm-Message-State: AOAM532g8vJhbTeb8K/fEWAoI0uSiAwakYskpe/38blfuFrN+90Eh6Kx
        fQHOykAXQ4Pm36/ID1GoVNyVqw==
X-Google-Smtp-Source: ABdhPJxhhfP8Rl5Euect2HwVRpdR8zXlp7FMlVmo2xpLE+q5oMhxVN/MdhVs+fCOwAtp/P09lJULHA==
X-Received: by 2002:a05:6a00:ad6:b029:28c:c28d:d3c5 with SMTP id c22-20020a056a000ad6b029028cc28dd3c5mr3280987pfl.54.1620285092455;
        Thu, 06 May 2021 00:11:32 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h22sm1234313pfn.55.2021.05.06.00.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 00:11:31 -0700 (PDT)
Subject: [PATCH] RISC-V: Don't check text_mutex during stop_machine
Date:   Thu,  6 May 2021 00:10:41 -0700
Message-Id: <20210506071041.417854-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        mhiramat@kernel.org, zong.li@sifive.com, guoren@linux.alibaba.com,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>,
        Changbin Du <changbin.du@gmail.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

We're currently using stop_machine() to update ftrace, which means that
the thread that takes text_mutex during ftrace_prepare() may not be the
same as the thread that eventually patches the code.  This isn't
actually a race because the lock is still held (preventing any other
concurrent accesses) and there is only one thread running during
stop_machine(), but it does trigger a lockdep failure.

This patch just elides the lockdep check during stop_machine.

Fixes: c15ac4fd60d5 ("riscv/ftrace: Add dynamic function tracer support")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Reported-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
In theory we should be able to avoid using stop_machine() with some
clever code sequences, but that's too big of a change to be considered a
fix.  I also can't find the text I thought was in the ISA manual about
the allowed behaviors for concurrent modification of the instruction
stream, so I might have just mis-remembered that.
---
 arch/riscv/include/asm/ftrace.h |  4 ++++
 arch/riscv/kernel/ftrace.c      | 15 +++++++++++++++
 arch/riscv/kernel/patch.c       | 10 +++++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 04dad3380041..ee8f07b4dbee 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -85,4 +85,8 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 
 #endif
 
+#ifndef __ASSEMBLY__
+extern int riscv_ftrace_in_stop_machine;
+#endif
+
 #endif /* _ASM_RISCV_FTRACE_H */
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 7f1e5203de88..da2405652f1d 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -11,6 +11,8 @@
 #include <asm/cacheflush.h>
 #include <asm/patch.h>
 
+int riscv_ftrace_in_stop_machine;
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
 {
@@ -232,3 +234,16 @@ int ftrace_disable_ftrace_graph_caller(void)
 }
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
+void arch_ftrace_update_code(int command)
+{
+	/*
+	 * The code sequences we use for ftrace can't be patched while the
+	 * kernel is running, so we need to use stop_machine() to modify them
+	 * for now.  This doesn't play nice with text_mutex, we use this flag
+	 * to elide the check.
+	 */
+	riscv_ftrace_in_stop_machine = true;
+	ftrace_run_stop_machine(command);
+	riscv_ftrace_in_stop_machine = false;
+}
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 0b552873a577..7983dba477f0 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -11,6 +11,7 @@
 #include <asm/kprobes.h>
 #include <asm/cacheflush.h>
 #include <asm/fixmap.h>
+#include <asm/ftrace.h>
 #include <asm/patch.h>
 
 struct patch_insn {
@@ -59,8 +60,15 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
 	 * Before reaching here, it was expected to lock the text_mutex
 	 * already, so we don't need to give another lock here and could
 	 * ensure that it was safe between each cores.
+	 *
+	 * We're currently using stop_machine() for ftrace, and while that
+	 * ensures text_mutex is held before installing the mappings it does
+	 * not ensure text_mutex is held by the calling thread.  That's safe
+	 * but triggers a lockdep failure, so just elide it for that specific
+	 * case.
 	 */
-	lockdep_assert_held(&text_mutex);
+	if (!riscv_ftrace_in_stop_machine)
+		lockdep_assert_held(&text_mutex);
 
 	if (across_pages)
 		patch_map(addr + len, FIX_TEXT_POKE1);
-- 
2.31.1.527.g47e6f16901-goog

