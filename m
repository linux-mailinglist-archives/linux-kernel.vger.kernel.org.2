Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF57540B798
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhINTMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhINTMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448BEC061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:10:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m16-20020a25d410000000b005ab243aaaf4so126449ybf.20
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1oOz6kaFdaWVr/jQmAaRDSorIwh4Z5I78YdyCUUNK9s=;
        b=Mpm5cQyxv4z1foMX312l2Tgy7gTfZn2UKqiNEm/bDeCpNs2Z2PFSloOoHJZbl9naVQ
         zqBEYS3THb+8QyjMkgmxc7puYOFu37WsvvCCk/6UkKq4ej8f21HCMyVPWgDbpaQJiDcW
         w+fBeBgbzefjp3/omKonhEIcGN10jh9cTkqGGDyim/HTmHZeV33Gc7604YpJPeObUCs2
         d1y9TFpFItoYhXMBU67pq0VbC+GD++Rro/eLkWTCaJpM91IOrvQw4j+7aAZtd4+HTVHr
         tCig2fxlOqSR035A/SVkPOC6u6oHEu73HqFSGhY9E1vq8t3WpjjlGvfT9N/hCxLoMNJ3
         wdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1oOz6kaFdaWVr/jQmAaRDSorIwh4Z5I78YdyCUUNK9s=;
        b=QQi5+yaNDzhTLOpNa5oxjPpr5AxdpPgvO+SPNEh7htc4i3iT/FO33v+eNnmeU741GO
         QZG9g/81Tpxa1PeJ7r1iw4mz7Xj1+1Vck6HdU7MfTD32PqpZd1Yc6az+6Tdd0b9rMIKc
         RwLxaPSxz5J3RSzhJi9YUg/867KOgbTvHbycEwF4XufYumc5S9RUJIf+UVC++8c+6Zp9
         OzSypDRda/wijfQPCGLNC+TRIPS33z+vYYuFR80ylmqYTXLfag7A1yDjiVPZlNJxcmWk
         tkI9U/OnprNd8AX0oG+Ci/TZm2x9SQHjOt5aws+nWmL1kO075m5xS4jRlxbT2bDkRXwa
         Kqzg==
X-Gm-Message-State: AOAM530vFyC7mS3UtaLB2gSuD7kuywQOhHhcPY+2L+vNcVO7Rr3UnoOz
        Igl5mimrpCYIiWxQGZxc4uttC88rI+5SZsTkdaY=
X-Google-Smtp-Source: ABdhPJygYL+QqEjY5IK1osIHUTbFG9QZLqmwDt4ruKmO9HXh0t15yJzZ0ETG7dkreOm0w+tD1mcKz/86mHGueJRp8Sc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a25:3046:: with SMTP id
 w67mr1001922ybw.134.1631646655540; Tue, 14 Sep 2021 12:10:55 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:32 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 03/16] linkage: Add DECLARE_ASM_FUNC_SYMBOL
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
index dbf8506decca..f1eac26b2dd6 100644
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
+typedef const u8 *asm_func_ptr;
+#endif
+
 /*
  * This is used by architectures to keep arguments on the stack
  * untouched by the compiler by keeping them live until the end.
-- 
2.33.0.309.g3052b89438-goog

