Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A3240B799
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhINTMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhINTMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:16 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C713EC061766
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:10:58 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d202-20020a3768d3000000b003d30722c98fso701716qkc.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MYedQpyvB9Rmmtvd5nbBABH5KnAjy2gVig66j6N03ws=;
        b=jV5ieCvRSmnHwgG1kcnfTC98EqPu6tMmhqKE58NlZh3zdBOtjDaH2Z1kfehpGXjL1v
         DnArexSZ4+J5ChP9E5mPy659ZCRgjmHr1YU14elAzeIsRhqfD6majuaSuM+7pOlSicru
         Im1bolmuY1wXNiUlFUhsP9C+5aVPx8G06siO23Ow1wtnKNwC9c2u8LE8NQQGMNHNiZFF
         kKRvVxlEBu831HRHQNP1RT5JPlT9n7cfpYZhnYVu+2KoxYJ1h2J1CRgpGLmdtvYlincP
         E/lDgqlNBSpRPeeYh/rsQyRInJckGdgYr8S2oDlmY65+GU6huC0FOx215/7GNnz5B53X
         UF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MYedQpyvB9Rmmtvd5nbBABH5KnAjy2gVig66j6N03ws=;
        b=oE034fvt8dJu/zKSSNnbt/AYJgjbup6bEnqb97RnZ3uABJHCB5goONSUjSju1Zme/V
         eMUa4u2U3tvEDL5alkDtCMDm0fUvSUiU/mYKdnWJC8V6eRKcIYgoOHN5h1rl2ZcTf3km
         sSE5w71gZQbaIOJizsMrghpsvcs4sZsLntxjsZLOVhEMVdI9dJfCcw8idpLXcTvnz43J
         Im8BRramzHRoycGqdbAEA4R6G7LmxLfLnegma1NwfSiKzi1k0WeOAJoku3UzUY+G+oqM
         kxsM0FnRAjq8tXyKBuFfSV2nUyK9htWJ6cq9A/2MrD1lze3+qVDSOiJ1LgFXzv1/GVpW
         uVhg==
X-Gm-Message-State: AOAM532wOrgiTelgeHs7jUxSyY2tsYsX6iyxRgak09SGIJSLSH7UbRXZ
        s/N0n/jLwmo7aFnA7/mqat+o084kW9GJ4f8b/Mk=
X-Google-Smtp-Source: ABdhPJwrCL8aGVXaMUWav9OzBfROuvbuHsjc+XeHdh9QeYYSbvOIXbTWQhyQpAvF57jHfZOs6K1C9GBv1ozee5pr/2I=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a0c:f38b:: with SMTP id
 i11mr7112243qvk.42.1631646658006; Tue, 14 Sep 2021 12:10:58 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:33 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 04/16] cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
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
---
 include/asm-generic/vmlinux.lds.h | 11 +++++++++++
 include/linux/cfi.h               | 14 ++++++++++++++
 kernel/cfi.c                      | 24 +++++++++++++++++++++++-
 3 files changed, 48 insertions(+), 1 deletion(-)

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
index 879744aaa6e0..9ebf67a0d421 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -20,6 +20,18 @@ extern void __cfi_check(uint64_t id, void *ptr, void *diag);
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
+		__attribute__((__section__(".cfi_excluded_stubs"))) \
+		= (void *)&fn
+
 #ifdef CONFIG_CFI_CLANG_SHADOW
 
 extern void cfi_module_add(struct module *mod, unsigned long base_addr);
@@ -35,6 +47,8 @@ static inline void cfi_module_remove(struct module *mod, unsigned long base_addr
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
2.33.0.309.g3052b89438-goog

