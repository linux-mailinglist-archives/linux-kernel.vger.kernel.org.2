Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EAB3B68D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbhF1THx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbhF1THp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:07:45 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E037BC061768
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:05:17 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id e13-20020a37e50d0000b02903ad5730c883so18539373qkg.22
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mrnpINK5iyhqWzOKn2U+Wb/F3LThfuiu21IBE0XytmI=;
        b=PL0eaGkGjLHjo5hDnJb77vqMKVTVhf2fxFMhRvzRBn8zsFFpoQSu1FnpPDtw8E/bc3
         AMrJk/Kt2I55zY6ZSSw0qFGrGeA45AOhfnAMtbLb55D0ZP/jFrBW2lA20s0AZ4NKLZjj
         hGtsniOwSXweW51qJOcoq8mlV1hI7oAPKAcHKY6uOaCdFCUUumPpnJ27wGdzt4rmQ3Y3
         kJhTk66vpeDQvlJg8NGY/MkQ/iO9cFlg3P0R88IXN+n6Y1Gs9CZrgEZy6gXf71AIl1Hs
         cy8MgK8/m3cdw1oQBhvbkl5H4WOA4/0ZafFMeAw0WDshRGFGTqYeWuM4SCQrLr+CMr0O
         6Y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mrnpINK5iyhqWzOKn2U+Wb/F3LThfuiu21IBE0XytmI=;
        b=m6JwLIA62G40IpgTsnUdrWNsaBHsB3aGVbpYfZhiMLE+1TKtLTIAtkVXiCcU+xpoPw
         9igevEDpg3rbPST4gOiv0WirCohLqPAbOyo87w8EcaqKwABNkwA8rUscUZeejNzSFM9F
         K2Uu2TiaknFm6DKlZqBl9Wf8g7jIMlHtq1iKGqyMfGL/lEkh1PQ5DY2GbO+NpKVDu7ER
         50IZrz4jgxHsUBkk7su29k7DQpaYdtd8+eQ1Okh6lZjUXwkhJO3Yq7D4djzzDCxvIVa+
         q888g6Pu2AvLfUcQzxNYqaCqzX4WAspHYknD1X5cRPtYVcius1jUW/lB6SrsiKX3My/h
         n7fQ==
X-Gm-Message-State: AOAM532N8Ph06B28GlsFfsRkb/UB07rZfbcmURFAPXtkgxXgnwkwkDMK
        NvXbIQDGg1hmhIjznO4G7knHACSK9dAcjyAlsP4=
X-Google-Smtp-Source: ABdhPJweW2J8MnrNOBgv+m5W/MxRvgvrrXeRg9lc+wUJC2COr0ElaWRD5nUE4okde33LXiPxseTT/Z7ixL2jKHES+GY=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:6f7:d09:f550:3380])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:1cb:: with SMTP id
 c11mr26921739qvt.47.1624907116853; Mon, 28 Jun 2021 12:05:16 -0700 (PDT)
Date:   Mon, 28 Jun 2021 12:05:06 -0700
In-Reply-To: <20210622201822.ayavok3d2fw3u2pl@google.com>
Message-Id: <20210628190509.2486992-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210622201822.ayavok3d2fw3u2pl@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2] kallsyms: strip LTO suffixes from static functions
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "KE . LI" <like1@oppo.com>, Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@kernel.org>,
        Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
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
Changes v1 -> v2:
* Both mangling schemes can occur for thinLTO + CFI, this new scheme can
  also occur for thinLTO without CFI. Split cleanup_symbol_name() into
  two function calls.
* Drop KE.LI's tested by tag.
* Do not carry Fangrui's Reviewed by tag.
* Drop the inline keyword; it is meaningless.

 kernel/kallsyms.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 4067564ec59f..fbce4a1ec700 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -171,14 +171,30 @@ static unsigned long kallsyms_sym_address(int idx)
 	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
 }
 
-#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
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
+#ifdef CONFIG_CFI_CLANG
 /*
  * LLVM appends a hash to static function names when ThinLTO and CFI are
  * both enabled, i.e. foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
  * This causes confusion and potentially breaks user space tools, so we
  * strip the suffix from expanded symbol names.
  */
-static inline bool cleanup_symbol_name(char *s)
+static bool cleanup_symbol_name_thinlto_cfi(char *s)
 {
 	char *res;
 
@@ -189,8 +205,17 @@ static inline bool cleanup_symbol_name(char *s)
 	return res != NULL;
 }
 #else
-static inline bool cleanup_symbol_name(char *s) { return false; }
-#endif
+static bool cleanup_symbol_name_thinlto_cfi(char *s) { return false; }
+#endif /* CONFIG_CFI_CLANG */
+#else
+static bool cleanup_symbol_name_thinlto(char *s) { return false; }
+#endif /* CONFIG_LTO_CLANG_THIN */
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

