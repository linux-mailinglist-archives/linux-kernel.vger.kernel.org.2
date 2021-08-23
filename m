Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDDA3F4F13
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhHWROS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhHWROM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:12 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E47C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:29 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id s206-20020a3745d70000b02903b9207abc7bso12332327qka.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/AlTSLKKvBCzDgdcHxG56ogzVSJhPh3j0OBqaQS6YrE=;
        b=mh+67HgadPiuCW+H32T/1juTuVYMmYEj1JTiCQGcERbm8zqhzvmtItRG3rd/iI/4kE
         dgFt3ONEhh6b0490VhQMK+dJ/GdcVVmF1a6rLZqIUa5gg0dQvPCr6gX4FH2fi8WgWvG6
         Yz2vi9d+cAr6eNL+J79YTOHImz0nUILhfmIXRWlpCP354YGYICKWF9PcxjmzeTs53Lsx
         Im5EKBsUiFQWjWAhObWytk/HKA2ypJD9XOgxsCmTmmBkH/WKmP42e1TWRtLRt2Sxo+Q8
         jbWuBV9KPT6GrekjI+TG7fOH8J1jIqg8uVyTU/F5OelFtPGFOOwJMaBaynLSUIxPSKlz
         GNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/AlTSLKKvBCzDgdcHxG56ogzVSJhPh3j0OBqaQS6YrE=;
        b=QR9KLmtJYN7irERYmhKQ8C+wXIiOYaa+toA/458LcbaO/x7mqvYPMH6SVvZhy7BJhu
         VBVDmuzxj4EdIqDdTWqEyEUTozMJl9sRusvcHG7eC8A3ARV0oDYUtTxhozY7p0FM3hoB
         A0KqsZaL1ZCGHLaMYnXQXkNo8/HuttACd7NUNyinPUJrmIsXUQKAxArjErnjspV8iSva
         LM/MtvoO5SzpzIgsfmO/B+9IRGx1P4PY91bwgQ+DI5LfQ0ZTHe4jaEh+WI586LCU6RC2
         ZG3xgVuOXRtQMybCWu01qBgFbahaOk9yGCgevrEG0zN81Md1LAmARjx6VGJUSkZGRXMF
         2Omg==
X-Gm-Message-State: AOAM533SL77Wv16poMFNQBgPYnoBIBiGbIcWc4m2xTu1qRruq0rRd6Us
        /zV5p/m2tVVQBFmfzcNrJw2rKzPZI+fOr0CU+k4=
X-Google-Smtp-Source: ABdhPJz7Z0jolFYC+ty7Ek2gcF4hwp8Wkq1J94AUg2lsYlAY9wPpd+Hs+gGT6rH2aJzKop/wOhMjjXSBOiygF6Ja/4c=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:4009:: with SMTP id
 kd9mr33959844qvb.40.1629738808441; Mon, 23 Aug 2021 10:13:28 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:07 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 03/14] linkage: Add DECLARE_ASM_FUNC_SYMBOL
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

The kernel has several assembly functions, which are not directly
callable from C but need to be referred to from C code. This change adds
the DECLARE_ASM_FUNC_SYMBOL macro, which allows us to declare these
symbols using an opaque type, which makes misuse harder, and avoids the
need to annotate references to the functions for Clang's Control-Flow
Integrity (CFI).

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/linkage.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index dbf8506decca..8b8d1db3ffbc 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -48,6 +48,19 @@
 #define __PAGE_ALIGNED_DATA	.section ".data..page_aligned", "aw"
 #define __PAGE_ALIGNED_BSS	.section ".bss..page_aligned", "aw"
 
+/*
+ * Declares a function not callable from C using an opaque type. Defined as
+ * an array to allow the address of the symbol to be taken without '&'.
+ */
+#ifndef DECLARE_ASM_FUNC_SYMBOL
+#define DECLARE_ASM_FUNC_SYMBOL(sym) \
+	extern const u8 sym[]
+#endif
+
+#ifndef __ASSEMBLY__
+typedef const u8 *asm_func_t;
+#endif
+
 /*
  * This is used by architectures to keep arguments on the stack
  * untouched by the compiler by keeping them live until the end.
-- 
2.33.0.rc2.250.ged5fa647cd-goog

