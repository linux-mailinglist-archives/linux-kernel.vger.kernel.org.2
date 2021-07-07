Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B0D3BEE90
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhGGSWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhGGSWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:22:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B79C06127E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 11:18:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 132-20020a25158a0000b029055791ebe1e6so3636219ybv.20
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 11:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mga0Rd0lQM3GUSKkdzD/AR1AZUen0HMS0SXtDj3bF9w=;
        b=J6D8M2wJCLKbFAAIQMvMZoljTv2Fa+/bMC3ZYguBE2QniBlDhrjPQKithpmSMSyDdl
         keqvDKbulPVmbVQBgnBYMi1bRTe7GIsEZzyKPaeKM6/bEAgdLKpAn8YNpnUS0Mxvamo+
         ifveAK4p1u74rt/MUDdZBwM+np0GGOGtpfjeDrYX/iIM4RyKIDbI4lHmF5Bi9D0DPl5F
         lho9SH4Ib/LA5DtLC6pTbtBMkI0WO4wGT8n7byid2T3g3muHBq9qI68mLH4q1tk6qBQ8
         xXjAW0Qza4DaG++FiwYTeP7zzLvlOqqkLzMHMIlhXiJNWh/J6scUABGWIv2t6TO8m2hT
         uB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mga0Rd0lQM3GUSKkdzD/AR1AZUen0HMS0SXtDj3bF9w=;
        b=ABd1zH49bXwXlHkNAhqS74Izcb1F+LW63f9b+JNV1BBl02kMW77I1bzgNS9E3YIiTH
         aHod43WjvaEf2tbuf0iPQXH3Goxk0p2Jt2Wrhj3sLGNClPXYMoV8HVU7Fv6uQoPqOtpB
         AcYzUERRw+aXI66Z4V52joep3r+9bLP9RmcCkw//WbZFYnMiLsOiaPWyAizCwYiVVQoK
         pVyxeWC0QSb9ICscqmLZ1JWlIzYROxP5F8yzYrCV8IkdxQBQ6zyd+mJiooKU9NmhOSqd
         kMHMMUrWSRTH5w8d/8/RFipXO/VhbvRuED81TD9bf8ynpJlmYB81apRU3Ul3OxWuQmYA
         f3eg==
X-Gm-Message-State: AOAM531XUCBynwhUep3flAUj7tKXT4CjZHKm+LY8IKTpOVtVVu9pO21G
        7sYBQS1ci4N8aOgCqf7niuoevQIgamTcFIGH5z4=
X-Google-Smtp-Source: ABdhPJwv4kvhFxHvDRTVe8p7L87i5aXP30uhjgX0hS9zJJ47W+XJiWZ/+5rCIekY0Lg7H0Yv3VnNEhodBk8StelIO8g=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:d417:6e24:4a54:1792])
 (user=ndesaulniers job=sendgmr) by 2002:a25:a2d0:: with SMTP id
 c16mr17939317ybn.18.1625681898165; Wed, 07 Jul 2021 11:18:18 -0700 (PDT)
Date:   Wed,  7 Jul 2021 11:18:11 -0700
In-Reply-To: <08a2e179-3f5f-639e-946f-54cd07ae12fa@kernel.org>
Message-Id: <20210707181814.365496-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <08a2e179-3f5f-639e-946f-54cd07ae12fa@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v4] kallsyms: strip LTO suffixes from static functions
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "KE . LI" <like1@oppo.com>, Nathan Chancellor <nathan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
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
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v3 -> v4:
* Convert this function to use IS_ENABLED rather than provide multiple
  definitions based on preprocessor checks.
* Add Nathan's suggested-by.

Changes v2 -> v3:
* Un-nest preprocessor checks, as per Nathan.

Changes v1 -> v2:
* Both mangling schemes can occur for thinLTO + CFI, this new scheme can
  also occur for thinLTO without CFI. Split cleanup_symbol_name() into
  two function calls.
* Drop KE.LI's tested by tag.
* Do not carry Fangrui's Reviewed by tag.
* Drop the inline keyword; it is meaningless.

 kernel/kallsyms.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 4067564ec59f..a10dab216f4f 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -171,26 +171,43 @@ static unsigned long kallsyms_sym_address(int idx)
 	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
 }
 
-#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
-/*
- * LLVM appends a hash to static function names when ThinLTO and CFI are
- * both enabled, i.e. foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
- * This causes confusion and potentially breaks user space tools, so we
- * strip the suffix from expanded symbol names.
- */
-static inline bool cleanup_symbol_name(char *s)
+static bool cleanup_symbol_name(char *s)
 {
 	char *res;
 
+	/*
+	 * LLVM appends a suffix for local variables that must be promoted to
+	 * global scope as part of ThinLTO. foo() becomes
+	 * foo.llvm.974640843467629774. This can break hooking of static
+	 * functions with kprobes.
+	 */
+	if (!IS_ENABLED(CONFIG_LTO_CLANG_THIN))
+		return false;
+
+	res = strstr(s, ".llvm.");
+	if (res) {
+		*res = '\0';
+		return true;
+	}
+
+	/*
+	 * LLVM appends a hash to static function names when ThinLTO and CFI
+	 * are both enabled, i.e. foo() becomes
+	 * foo$707af9a22804d33c81801f27dcfe489b. This causes confusion and
+	 * potentially breaks user space tools, so we strip the suffix from
+	 * expanded symbol names.
+	 */
+	if (!IS_ENABLED(CONFIG_CFI_CLANG))
+		return false;
+
 	res = strrchr(s, '$');
-	if (res)
+	if (res) {
 		*res = '\0';
+		return true;
+	}
 
-	return res != NULL;
+	return false;
 }
-#else
-static inline bool cleanup_symbol_name(char *s) { return false; }
-#endif
 
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
-- 
2.32.0.93.g670b81a890-goog

