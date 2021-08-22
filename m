Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B75C3F3E8B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 09:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhHVH6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 03:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbhHVH5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 03:57:40 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28513C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:57:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id t13so12597479pfl.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ph4GT+kwYLxKYCnHgj0jmviVrrZnOYP9VDlVxWdpZQQ=;
        b=cbLTkI8FGlMZoWwhmEL31Z1PpldZ0bP1X2vFQGCguwY5ox7lY/NOROJg1Xo/BU8tS/
         dTs5W1L6oA+/2K1K+Tx4FfqCmeih9PwnXsX9lmumaLgQ3WuL9MkoBNqvAUkXzifIUUa+
         GJGdLE7kOjtc8r9IN3SzhvqM4bH7FMBRKuB9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ph4GT+kwYLxKYCnHgj0jmviVrrZnOYP9VDlVxWdpZQQ=;
        b=TP3VPCjcks6ALpF4OhHo3jW+ZmQLX0I6/uK4cVIZphzHeeX1m6SXOeHY7bokqLgu08
         GQVlwxlrFgOeMfcifA7t0iMDaAmVBaxKy9Bmyzwpp8TIrq2XSVvxtDcI0SQUCrgG4DZW
         yxfWWHd3YFhD6MlWHyHoE77f1ocBrDPlvfCYB7Vlx6bbeb/kUtMARa+WealNYODys+EA
         x/WRqrs3MyI1Uxm/wG2iks7dJA8ENExisVv29esJMbaLtmbrGmbO9nIhZ9zgrC/S3J4s
         KlmZTXIJdwHxgusgHJz4UrM0Xo7vMwxQSosGqvnl/Z1HdvZCmNQqWJovN+WO9hybCn8l
         MOmw==
X-Gm-Message-State: AOAM531eNpnZGtt95H641X+zmsmufqGWN3rX39nvHZIjS9DOEcrQ8KdA
        WH5QmpTAgLakeVcG7b72qm9saQ==
X-Google-Smtp-Source: ABdhPJzlbbguhPCOwVVseo2aHiBc5K1TMiBPy0saNT0fZdfylNZQrj8879LHDAnvJwM3IAaZ+bBpLw==
X-Received: by 2002:a63:1e5c:: with SMTP id p28mr27011640pgm.89.1629619019738;
        Sun, 22 Aug 2021 00:56:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u10sm12069888pfg.168.2021.08.22.00.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:56:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 15/25] fortify: Move remaining fortify helpers into fortify-string.h
Date:   Sun, 22 Aug 2021 00:51:12 -0700
Message-Id: <20210822075122.864511-16-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3207; h=from:subject; bh=93UyhKlsXw7Mzj4VgqjxzznxP8lIxJTMZfvK+B8oq14=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH3OYfO092ICV+ibgtBFhM/x4pDGM/xKvrIF7Y4 u9GhAY2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB9wAKCRCJcvTf3G3AJhbFEA CQLxyeDalkY9Ndqv9AMIJK+dR3dgTsvujTNcKxybFXMsPX5qQiLXzxnYHbnEZA6O9qCYtJGHDMqouc paqokzs2Ftz7Kl0kFYhdvYUcwRL9fpEtbKHFDkqhMKF8IiA+10Ii//mSexWDVUVLe8NK5LHKoLvbo8 48TXLu3uXiOmZGOYPlIBcvX5mpJM2AYJynN6+0hTg2FmNBd45C6pNtPNsA7DThyPl6jNJ+igNROeMK UThLUHiK5Q79iJFl6WC973bw5kezzGgJIdI6a1lppHVtLPsr9I5yI7GZkEjcPAq+rpaCy/gE1MmBci +SVMcWyeDoz5d99y1b0ctqGrX/yRGTZdo3lW8fTBk/iJ7UC9lp+SOtUYvqOIwMZbvntUVHp1kGEMuI xvTohIpbi6bWZ9S6I3OH9M2GFX31nnJkgChPBA+BqgBGC/ZCheCUWV+Ph5b2zeXaScEgHD81mhCo8P +O00gNJc7y/qHI9jPjraGc1ZlgsasPmF+GZDL0trnSJ7/PGjHQddLBdFytk8Mv3CyvxuCCG8JhqslH bHEx7JNqbiE8wYakA5zgtjc+KBMZyD8P4dBOVVGTMAMWshyQdGGbaeBIxwVrQBxq+2a/GOgpwpdKuv clylHOCpzbAArRCT+MmyC53n3BEbpzanfvZzsn7CJEuuvmmYH6WttlaIdD6Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When commit a28a6e860c6c ("string.h: move fortified functions definitions
in a dedicated header.") moved the fortify-specific code, some helpers
were left behind. Move the remaining fortify-specific helpers into
fortify-string.h so they're together where they're used. This requires
that any FORTIFY helper function prototypes be conditionally built to
avoid "no prototype" warnings. Additionally removes unused helpers.

Acked-by: Francis Laniel <laniel_francis@privacyrequired.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 7 +++++++
 include/linux/string.h         | 9 ---------
 lib/string_helpers.c           | 2 ++
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index c1be37437e77..7e67d02764db 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -2,6 +2,13 @@
 #ifndef _LINUX_FORTIFY_STRING_H_
 #define _LINUX_FORTIFY_STRING_H_
 
+#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline))
+#define __RENAME(x) __asm__(#x)
+
+void fortify_panic(const char *name) __noreturn __cold;
+void __read_overflow(void) __compiletime_error("detected read beyond size of object (1st parameter)");
+void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
+void __write_overflow(void) __compiletime_error("detected write beyond size of object (1st parameter)");
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
diff --git a/include/linux/string.h b/include/linux/string.h
index b48d2d28e0b1..9473f81b9db2 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -249,15 +249,6 @@ static inline const char *kbasename(const char *path)
 	return tail ? tail + 1 : path;
 }
 
-#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline))
-#define __RENAME(x) __asm__(#x)
-
-void fortify_panic(const char *name) __noreturn __cold;
-void __read_overflow(void) __compiletime_error("detected read beyond size of object passed as 1st parameter");
-void __read_overflow2(void) __compiletime_error("detected read beyond size of object passed as 2nd parameter");
-void __read_overflow3(void) __compiletime_error("detected read beyond size of object passed as 3rd parameter");
-void __write_overflow(void) __compiletime_error("detected write beyond size of object passed as 1st parameter");
-
 #if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
 #include <linux/fortify-string.h>
 #endif
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index e9433caab217..1274f45ffaf4 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -879,9 +879,11 @@ char *strreplace(char *s, char old, char new)
 }
 EXPORT_SYMBOL(strreplace);
 
+#ifdef CONFIG_FORTIFY_SOURCE
 void fortify_panic(const char *name)
 {
 	pr_emerg("detected buffer overflow in %s\n", name);
 	BUG();
 }
 EXPORT_SYMBOL(fortify_panic);
+#endif /* CONFIG_FORTIFY_SOURCE */
-- 
2.30.2

