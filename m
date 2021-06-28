Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECBF3B69AA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbhF1Udl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbhF1Udk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:33:40 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52070C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:31:14 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id c17-20020ac87d910000b029024ee21abd54so13735329qtd.19
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6T6NsHzWWvCAH0u6x7ev+GFXhfHMd6xAAjEggw6hDHk=;
        b=vz/oIBoeBx1vbFb4xLONG/UTG+UiVDS7Ei7xhUA2M/y9VbFNqDK2qZHJmN4VClPl22
         3KYKcdv6lAFr9ww2u7fX7cUbPnSJVOV+T4XBVef5COjhjnE5QAQYOCsflJrHdb1gY5cW
         xGVM9Kxx6CNe6IKwkE9nzUSGcy0K5XmoiUIPtwMSRMLqKjqHsFtFEZljUidN9huhlJVx
         8RhaDNYm0mvWy+bjjw4rjsJp4jcsl21gpwnURPihQBl2s3A1u8ky1wZ0B8t4Pt+sshod
         /v4eSmGlh/pDGufWj4tn1WLWvsPHXlVkjo12BHYcPJeq36B3VASYPUOwy4/EMvFgiU4f
         6ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6T6NsHzWWvCAH0u6x7ev+GFXhfHMd6xAAjEggw6hDHk=;
        b=sVm9H4Ve0NkjcxnhTvy441h9iAC8e2AlhL/uXLX6ciq768eXb2GRoIOeFB1PkhllWp
         HwITViHrcoQtYOhaxH7VPRJVCVs1n5o4FQGpJVy4/KVc8/IBSBBfv5ykZVJEo8SFPSP0
         Zr/5FTVSj8/Nt94qqHDD1cSS8Miext7p3aYYUFRUn4gv9n6doSsAmu8jpe57612XiTii
         YL7RFvnju+DMCm7meCzp1NQQyz8PgZPvDxPjeqr89mZejebK9dE8pa+w8r+4U4basKbD
         L2HP5s7bfkMmGt4okEcT06X6AIxVKOn7CCZFKPQfCqr572FSOwdYJdIbXNmPeF+rRqGk
         eLcQ==
X-Gm-Message-State: AOAM531rBeKIq/ZjvSQTMKp8HDkTI9c2vRObVJGrHa/iSjXn2ismzf43
        NS6Rd0Iy972UUWkZPVDcPepzMiSwRM87YOJsvpQ=
X-Google-Smtp-Source: ABdhPJy2KbyT83Eqkj9+n5PePZ5KGbthND/bIqx20IGreOA2AKLf+XT+Bfx7a6Dy6QjWxg1RY4Fqe3HTBfdpnurrRIg=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:6f7:d09:f550:3380])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:2a88:: with SMTP id
 jr8mr27049614qvb.6.1624912273427; Mon, 28 Jun 2021 13:31:13 -0700 (PDT)
Date:   Mon, 28 Jun 2021 13:31:06 -0700
In-Reply-To: <a970613b-014f-be76-e342-4a51e792b56d@kernel.org>
Message-Id: <20210628203109.2501792-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <a970613b-014f-be76-e342-4a51e792b56d@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v3] kallsyms: strip LTO suffixes from static functions
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "KE . LI" <like1@oppo.com>, Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to:
commit 8b8e6b5d3b01 ("kallsyms: strip ThinLTO hashes from static
functions")

It's very common for compilers to modify the symbol name for static
functions as part of optimizing transformations. That makes hooking
static functions (that weren't inlined or DCE'd) with kprobes difficult.

LLVM has yet another name mangling scheme used by thin LTO.  Strip off
these suffixes so that we can continue to hook such static functions.

Reported-by: KE.LI(Lieke) <like1@oppo.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v2 -> V3:
* Un-nest preprocessor checks, as per Nathan.

Changes v1 -> v2:
* Both mangling schemes can occur for thinLTO + CFI, this new scheme can
  also occur for thinLTO without CFI. Split cleanup_symbol_name() into
  two function calls.
* Drop KE.LI's tested by tag.
* Do not carry Fangrui's Reviewed by tag.
* Drop the inline keyword; it is meaningless.
 kernel/kallsyms.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 4067564ec59f..143c69e7e75d 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -171,6 +171,26 @@ static unsigned long kallsyms_sym_address(int idx)
 	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
 }
 
+#ifdef CONFIG_LTO_CLANG_THIN
+/*
+ * LLVM appends a suffix for local variables that must be promoted to global
+ * scope as part of thin LTO. foo() becomes foo.llvm.974640843467629774. This
+ * can break hooking of static functions with kprobes.
+ */
+static bool cleanup_symbol_name_thinlto(char *s)
+{
+	char *res;
+
+	res = strstr(s, ".llvm.");
+	if (res)
+		*res = '\0';
+
+	return res != NULL;
+}
+#else
+static bool cleanup_symbol_name_thinlto(char *s) { return false; }
+#endif /* CONFIG_LTO_CLANG_THIN */
+
 #if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
 /*
  * LLVM appends a hash to static function names when ThinLTO and CFI are
@@ -178,7 +198,7 @@ static unsigned long kallsyms_sym_address(int idx)
  * This causes confusion and potentially breaks user space tools, so we
  * strip the suffix from expanded symbol names.
  */
-static inline bool cleanup_symbol_name(char *s)
+static bool cleanup_symbol_name_thinlto_cfi(char *s)
 {
 	char *res;
 
@@ -189,8 +209,14 @@ static inline bool cleanup_symbol_name(char *s)
 	return res != NULL;
 }
 #else
-static inline bool cleanup_symbol_name(char *s) { return false; }
-#endif
+static bool cleanup_symbol_name_thinlto_cfi(char *s) { return false; }
+#endif /* CONFIG_CFI_CLANG && CONFIG_LTO_CLANG_THIN */
+
+static bool cleanup_symbol_name(char *s)
+{
+	return cleanup_symbol_name_thinlto(s) &&
+		cleanup_symbol_name_thinlto_cfi(s);
+}
 
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
-- 
2.32.0.93.g670b81a890-goog

