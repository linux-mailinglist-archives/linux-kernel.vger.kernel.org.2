Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3FA42C879
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbhJMSTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238518AbhJMSTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:19:14 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32278C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:11 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id c13-20020a056214224d00b00382f21b95fcso3387086qvc.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7Et8itix18GpyAjahZqPt1V8kIsz34x/KqZyZkJ8saM=;
        b=ozICM49CE2OWJqCOH9tP80XKMk3vu1AtbDr/v3RLj5sNl9OdewL1mtqBHEkZgm/jre
         dy7ooHFtMVO0amhWXoZs6i5zgN3Uu37lKHSqW0Bsv8Jmq8R8cVVGoyywDiOFq5XGedI9
         194cN1LFqMqQEhmMLr1Eqinsgk33ThbxFdrvVvY1Hx7p2a1ZfdfqxHS0i8dTENOBn/sL
         b8pYfNQ4mQFPllXmBEgNKGgA/0E1I4lTRrvh83vb/bpCu+nOXD487+XFinwyHZevwJo2
         2+/rtj1Cek7q66Z5Ii3mdZXqBBp6cXT/Wz94WgSIowULd2Z76AeAWP3pXXgDJx26oKI+
         hEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7Et8itix18GpyAjahZqPt1V8kIsz34x/KqZyZkJ8saM=;
        b=s0/uc6J/nUnCjo0Et3cLpwRcG2MMXuYae9urVoXngdO7kmPwvxFB0T/Pwf46QG/36n
         T6sigEcG+B6XNZhtOQ72YmGMSNjMMDuHF+n/NvF/WQNsAr63ukdHr1cF0IDVE+cMenOO
         od6+V0idgNMuy45J4Qke/k59nrIudWm6paDAmAhQ2ydyjy90I1D5970sCkL5T0IXrl9k
         fk5SFsZeq+ytBSKq2f2hDNrHMOmS/uMtN2UiLsNYoXc1CB9IgXf4azSi+PNlhGy5olhr
         LLqnTXCyxdCFuMeDJlnLbAh5n2bWMwR7tk82eNaEz1Ch4RUI6TNEdnyifrFhodC9vclW
         m6Kw==
X-Gm-Message-State: AOAM531N808pwaw2EkppCoo48/ME+B7cw44wou5JuXtEccI5bYypY7v7
        nW7mxz00euzrufNnxxZgsQv0CqVcA36RJeYXrkw=
X-Google-Smtp-Source: ABdhPJwcoHVQJavUD3ZFgfmM1PTs5OPnXrvBPJgKaJnj/ce2aSdRwx6NsvwguvF8iGXaOvNW1dEloN+G1M/p4J7aauQ=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:9ea6:6c27:1876:926c])
 (user=samitolvanen job=sendgmr) by 2002:a05:622a:394:: with SMTP id
 j20mr1042103qtx.386.1634149030337; Wed, 13 Oct 2021 11:17:10 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:16:47 -0700
In-Reply-To: <20211013181658.1020262-1-samitolvanen@google.com>
Message-Id: <20211013181658.1020262-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3814; h=from:subject;
 bh=c20vs+8oCNIwFtONU4ML5OORlTf8ohrpjgEoh/S//sg=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBhZyKYmw2MiX69EDT1JRi2oj1H0ISRQ8X3gMVdZ1nt
 h4/nvC+JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYWcimAAKCRBMtfaEi7xW7uJ8C/
 98X2JIAb8WoYZ0uzW9SPF07AGAyyiJapAKnuP2YI1/zCaq0VUDo7bRT95fO8VEgNThWznatVDRz268
 t12ofjD41BS+qUksuSg0gYEoGCDondtLp0mC8rUcAWGGM0XwZeaZMCdNjy1LHBit2qlaplf45eaObr
 K1AvDg5YyHfGkG4ZROPn2R0jlO1YKt6RtJ+di6FHHjWP+03CzQ1+K3aH2U0g5OK304fnGDjB3LVoNb
 xOF06HYXFSdVJMBE7TC19OhUsIuwGqXP+JDAL1JRJ6o+jt+zZdxpqVIOJVcprhyPc3EX/NZSN9MsF/
 eH3FU41w/QNEowm0RVHSz2TIhmwOuFJTvrV3m2YF2EE+2GdHZh659rUlJ7VaNJ5mNDmezePqwBX6D6
 Ubb4JZLobYZNFtGFZs7bhXOwEgVbZ2TFZrzW+jc0cFHXevmx23gp49PMVdi+5Q+NKAW5ZB1UrJFqTd
 cp90deW3H7Lmp9E7X99yJwjLa/f14Hc7a+jf170aaiQSA=
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 04/15] cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change introduces the DEFINE_CFI_IMMEDIATE_RETURN_STUB macro,
which defines a stub function that immediately returns and when
defined in the core kernel, always passes indirect call checking
with CONFIG_CFI_CLANG. Note that this macro should only be used when
a stub cannot be called using the correct function type.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 11 +++++++++++
 include/linux/cfi.h               | 13 +++++++++++++
 kernel/cfi.c                      | 24 +++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f2984af2b85b..5b77284f7221 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -407,6 +407,16 @@
 	KEEP(*(.static_call_tramp_key))					\
 	__stop_static_call_tramp_key = .;
 
+#ifdef CONFIG_CFI_CLANG
+#define CFI_EXCLUDED_DATA						\
+	. = ALIGN(8);							\
+	__start_cfi_excluded = .;					\
+	KEEP(*(.cfi_excluded_stubs))					\
+	__stop_cfi_excluded = .;
+#else
+#define CFI_EXCLUDED_DATA
+#endif
+
 /*
  * Allow architectures to handle ro_after_init data on their
  * own by defining an empty RO_AFTER_INIT_DATA.
@@ -430,6 +440,7 @@
 		__start_rodata = .;					\
 		*(.rodata) *(.rodata.*)					\
 		SCHED_DATA						\
+		CFI_EXCLUDED_DATA					\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\
 		__start___tracepoints_ptrs = .;				\
diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index 879744aaa6e0..19f74af8eac2 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -20,6 +20,17 @@ extern void __cfi_check(uint64_t id, void *ptr, void *diag);
 #define __CFI_ADDRESSABLE(fn, __attr) \
 	const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
 
+/*
+ * Defines a stub function that returns immediately, and when defined and
+ * referenced in the core kernel, always passes CFI checking. This should
+ * be used only for stubs that cannot be called using the correct function
+ * pointer type, which should be rare.
+ */
+#define DEFINE_CFI_IMMEDIATE_RETURN_STUB(fn) \
+	void fn(void) { return; } \
+	const void *__cfi_excl_ ## fn __visible \
+		__section(".cfi_excluded_stubs") = (void *)&fn
+
 #ifdef CONFIG_CFI_CLANG_SHADOW
 
 extern void cfi_module_add(struct module *mod, unsigned long base_addr);
@@ -35,6 +46,8 @@ static inline void cfi_module_remove(struct module *mod, unsigned long base_addr
 #else /* !CONFIG_CFI_CLANG */
 
 #define __CFI_ADDRESSABLE(fn, __attr)
+#define DEFINE_CFI_IMMEDIATE_RETURN_STUB(fn) \
+	void fn(void) { return; }
 
 #endif /* CONFIG_CFI_CLANG */
 
diff --git a/kernel/cfi.c b/kernel/cfi.c
index 9594cfd1cf2c..8d931089141b 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -278,12 +278,34 @@ static inline cfi_check_fn find_module_check_fn(unsigned long ptr)
 	return fn;
 }
 
+extern unsigned long __start_cfi_excluded[];
+extern unsigned long __stop_cfi_excluded[];
+
+static inline bool is_cfi_excluded(unsigned long ptr)
+{
+	unsigned long *p = __start_cfi_excluded;
+
+	for ( ; p < __stop_cfi_excluded; ++p)
+		if (*p == ptr)
+			return true;
+
+	return false;
+}
+
+static void __cfi_pass(uint64_t id, void *ptr, void *diag)
+{
+}
+
 static inline cfi_check_fn find_check_fn(unsigned long ptr)
 {
 	cfi_check_fn fn = NULL;
 
-	if (is_kernel_text(ptr))
+	if (is_kernel_text(ptr)) {
+		if (unlikely(is_cfi_excluded(ptr)))
+			return __cfi_pass;
+
 		return __cfi_check;
+	}
 
 	/*
 	 * Indirect call checks can happen when RCU is not watching. Both
-- 
2.33.0.1079.g6e70778dc9-goog

