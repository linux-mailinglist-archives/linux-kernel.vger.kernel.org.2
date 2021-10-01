Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3584841F5FE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 21:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhJAUAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 16:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhJAUAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 16:00:22 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A217C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 12:58:38 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id bv15-20020ad4488f000000b003827388ecfcso14219357qvb.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 12:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jAuT2Ih3MFOePb85QCkMtLI141zk5gS6D05a628HxZY=;
        b=r0CihtWGn69tmcZFeSCcKUPbPscg8Kju+ik2iGSaKknPFwicL/q+zW6y8jRIZzsb+R
         oOTIJpRHvE3GWgAtPgp3NDvLWUryCfaAtHOIBwoSng+UFL7jOz/dONqVIog6AyRl9sgN
         Onu9y1UaXTdlYcHkLuf4uWyL5VdqQCaWNL07mw92SNmYfvurN/rUFQolH+gxPU90KG9I
         aqQobN0ap1r/xSllQkvAT3y5Qgkd4nnhsuh42ypNHDyzf/Uw/UCSO9wbMv2Zu0IPaE3S
         CQ4IIZZhrSQAa87g9Icjc72Hvo6D2Pze8tuspMulRG42sbiiXojrguCJa3scEfEhN2Fm
         ujQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jAuT2Ih3MFOePb85QCkMtLI141zk5gS6D05a628HxZY=;
        b=wIYfewNC4on9b+cPiyEC6nWsWUfrz8wSL3QOLRGOh5A0kuDmLN3r5bVvFb5Kf+hmMR
         QkKTHFbzMM2GtfrnJ6kbozbLK/Z5mF+00chhNJW7S7NfpEA5mikZfx2uBjOAmLR/IUBp
         uNKvqbEaKIOIvfpuyTENFhpNv6LQmMDornimiYTUdDNK4zobTsQ4GP3N34ENrcjxsG2H
         dT8M4sJsog/CNdcy+N5JaWLaI2YDgMV53wqctWmBsbl25UoA9zgu9P0ZqRE8Q8X7U/TZ
         sbHBbex/u2YywvegXaXxhzKpUl2p39sP+cG+s94eQg9kend9Ul7S601RAYhNpJcehl+X
         YNbQ==
X-Gm-Message-State: AOAM531onrNvHffcuSMJ546+vMcxIxNPgHAhuXnRIxMat9ONOrj0RgDM
        EleGrVRfhhA2FyWDDiTzMw8yl3nOVbE2vY8W3Xs=
X-Google-Smtp-Source: ABdhPJyiYvFeU2KcQlXH3qtdKxpV2Uk5f53K4zvyFxfeL4giQfZehQqsQuS621d0cjHXGQQTb4re4DkvbtAAPAxEQN0=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:99e9:cd62:e5f3:763d])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:c293:: with SMTP id
 b19mr11016594qvi.22.1633118317541; Fri, 01 Oct 2021 12:58:37 -0700 (PDT)
Date:   Fri,  1 Oct 2021 12:58:21 -0700
In-Reply-To: <CABCJKue5Ay6_+8sibzh5wRh3gPzV1g72gJ9m2ot4E1ezj8bpHA@mail.gmail.com>
Message-Id: <20211001195823.581937-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CABCJKue5Ay6_+8sibzh5wRh3gPzV1g72gJ9m2ot4E1ezj8bpHA@mail.gmail.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v5] kallsyms: strip LTO suffixes from static functions
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "KE . LI" <like1@oppo.com>, Fangrui Song <maskray@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

LLVM has yet another name mangling scheme used by thin LTO.

Combine handling of the various schemes by truncating after the first
'.'.  Strip off these suffixes so that we can continue to hook such
static functions.  Clang releases prior to clang-13 would use '$'
instead of '.'

Link: https://reviews.llvm.org/rGc6e5c4654bd5045fe22a1a52779e48e2038a404c
Reported-by: KE.LI(Lieke) <like1@oppo.com>
Suggested-by: Fangrui Song <maskray@google.com>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
Suggested-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v4 -> v5:
* Absorb Padmanabha Srinivasaiah's patch from
  https://lore.kernel.org/lkml/20210814124224.8551-1-treasure4paddy@gmail.com/.
* Add Padmanabha's Suggested-by tag.
* Rewrite the patch to truncate after first '.', as per Sami's comment
  from
  https://lore.kernel.org/lkml/CABCJKue5Ay6_+8sibzh5wRh3gPzV1g72gJ9m2ot4E1ezj8bpHA@mail.gmail.com/.
* Add Sami's Suggested-by tag.
* Verify that the '$' delimiter only appears for
  thin LTO + CFI + clang <= 12, use __clang_minor__ to check.
* Update comments as per Nathan + Fangrui, add their Suggested-by tags.
* While Nathan + Fangrui did review v4, v5 is too different IMO to carry
  those tags forward.

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

 kernel/kallsyms.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 0ba87982d017..3e4766204b07 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -164,26 +164,45 @@ static unsigned long kallsyms_sym_address(int idx)
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
 
+	if (!IS_ENABLED(CONFIG_LTO_CLANG))
+		return false;
+
+	/*
+	 * LLVM appends various suffixes for local functions and variables that must
+	 * be promoted to global scope as part of LTO.  This can break hooking of
+	 * static functions with kprobes. '.' is not a valid character in an
+	 * identifier in C. Suffixes observed:
+	 * - foo.llvm.[0-9a-f]+
+	 * - foo.[0-9a-f]+
+	 * - foo.[0-9a-f]+.cfi_jt
+	 */
+	res = strchr(s, '.');
+	if (res) {
+		*res = '\0';
+		return true;
+	}
+
+	if (!IS_ENABLED(CONFIG_CFI_CLANG) || !IS_ENABLED(CONFIG_LTO_CLANG_THIN) ||
+	    __clang_major__ >= 13)
+		return false;
+
+	/*
+	 * Prior to LLVM 13, the following suffixes were observed when thinLTO
+	 * and CFI are both enabled:
+	 * - foo$[0-9]+
+	 */
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

base-commit: 4de593fb965fc2bd11a0b767e0c65ff43540a6e4
-- 
2.33.0.800.g4c38ced690-goog

