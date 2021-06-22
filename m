Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D613B0D16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhFVSl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhFVSl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:41:27 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D672C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:39:11 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id cj11-20020a056214056bb029026a99960c7aso4986qvb.22
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OJShChp+OEm8CUCDXn9YjfihOBAeGQp03SAnCK0JAGI=;
        b=BL/JIjBKp+xwQjszmYVlybqvYn5pSXdBXdiOPA2XmTwmHnWcE+RJfNmSGrd/oXtEN1
         gMDm9MztzdY2uXLJ7RE+WEPJwm59bypEgzI4+Tw+DUY6JwL5PuFImPkHt8+eP/S9DMNb
         lNeHtL7En+3zAZpnlBQreWEf1RHN96Ec5pxQAthUL3N1V5dhVyhs0582ciKJS4ECUsyQ
         J5ctrqPZSEmfPOrajiaxavtt0MPmYl3yZw3DymENylC0Q/Pfgs8/evuYvZylt6qyktRL
         amGF9gkVHHdx2R7DuWSP1k0EbXQUZPuYpof5O4rIX3ggRirc+kqWhBVSQUC83i5H4b0z
         NaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OJShChp+OEm8CUCDXn9YjfihOBAeGQp03SAnCK0JAGI=;
        b=gtDlzstIsYb4c1HWVXWi16DhqoguMnHnNYtiQ0O2ow9McTF/Umy9MTvGon1tj7B5SV
         ejE/cS5AGpa+LRtecnqxXnUD6vnTzZsyq9r+Z6CPZ241gg6ARE19g/OyDJWD82WhSioH
         1p7Rldfd7Xxkl3NXf8svQgNkrrYqV+TcFMyLX1cR/nNkTg+IBj1VpbdpfIg67nOYga7J
         7A5uYLYgUknqlfehM2XjiUwVSyX/8VDF9/NQ3rTy59xuidf/uGJPJ4GWuhDDwK+C4p0L
         ZEktXhe3NzWAW9TT/6N8JiUaj4Gxo/Csv45yLa9/GvC4wJJOt+tqd24WzxaCeO2+7zWS
         RVhw==
X-Gm-Message-State: AOAM530snaIW7O1lqKVgxoLywlv/f4Sbfc9oibIf7mrCJYcIPyIZP2ld
        +8vsDnzAZU495hxB/7FMPeZ9rhEiWX2dZzGEWHw=
X-Google-Smtp-Source: ABdhPJyLX5n40MEfZJQ0ayxL6n1LkJPCpR5jvvuQxg6IVpQQyfsnT6FoAR+Z1vtHNmSamEOaN8JeA0ZEQkWp5spGt38=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:48c8:6911:c7bd:5211])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:4772:: with SMTP id
 d18mr143757qvx.35.1624387150618; Tue, 22 Jun 2021 11:39:10 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:38:55 -0700
Message-Id: <20210622183858.2962637-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH] kallsyms: strip LTO suffixes from static functions
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "KE . LI" <like1@oppo.com>, Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miroslav Benes <mbenes@suse.cz>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
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

Full LTO uses a different mangling scheme than thin LTO; full LTO
imports all code into effectively one big translation unit. It must
rename static functions to prevent collisions. Strip off these suffixes
so that we can continue to hook such static functions.

Reported-by: KE.LI(Lieke) <like1@oppo.com>
Tested-by: KE.LI(Lieke) <like1@oppo.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 kernel/kallsyms.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 4067564ec59f..14cf3a6474de 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -188,6 +188,24 @@ static inline bool cleanup_symbol_name(char *s)
 
 	return res != NULL;
 }
+#elif defined(CONFIG_LTO_CLANG_FULL)
+/*
+ * LLVM mangles static functions for full LTO so that two static functions with
+ * the same identifier do not collide when all code is combined into one
+ * module. The scheme used converts references to foo into
+ * foo.llvm.974640843467629774, for example. This can break hooking of static
+ * functions with kprobes.
+ */
+static inline bool cleanup_symbol_name(char *s)
+{
+	char *res;
+
+	res = strstr(s, ".llvm.");
+	if (res)
+		*res = '\0';
+
+	return res != NULL;
+}
 #else
 static inline bool cleanup_symbol_name(char *s) { return false; }
 #endif
-- 
2.32.0.288.g62a8d224e6-goog

