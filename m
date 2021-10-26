Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A909B43B3DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbhJZOYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbhJZOYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:24:07 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC38DC061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:21:43 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c4so14280346pgv.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yohk6bB6weZvIQ6DqBBBe5OJOa5DqldDKQ6ZoRfyBW8=;
        b=TI5LxOXH+Ej34Xgd61KMUpF77i7dYBG+Cu4msQfkRqWG1WwJTRKcJlAKinREbHC3l5
         WKibpY+0MxJR6OOgW9OqXyNzHGpBPyDrjoARbt/NIFSB7VDo8tSn/qXOjX/dqiMgmMgC
         ZyzaH9fSS93RUG6qzOMtL6SGfJCu/QBOXU8nNdzS56Rgxm2jPsr/fynBVakzKO1lOnim
         LHmPkoGAg3h+7cquVZX0W43ZV1K24d5KNs4TElYCK+zK32UiNjtVAVMd2FngxhWldxpI
         Oj4HritkXFuLSuR9rVPFOaWr3Ifxpe887kbZAyyyT0y1OJkm4gAcBkz9P06hQ9aHtLRj
         2jVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yohk6bB6weZvIQ6DqBBBe5OJOa5DqldDKQ6ZoRfyBW8=;
        b=26RTJVLYbG6GD3adgDbKDTZ9CTN2Z1ZXvlt2n/6C24r0PhZtPMb2Ps+dC2Z+u1nD0U
         Qfs12muXJ3bWCDQieQ3woarAfjuIu7grhN9Z39H5WIi4VtuBl9vWm1Wn9+iExKjERfvf
         DXSssjgaZuqgZRxwZurDnjS4jVQ0sYKJwGzsXF+qD9qNa8y4S1EIAZL+cS+GUOSFhJR4
         e+2knoUq9nZLso749zG2ou7cY7/qUvvlHm/t9BpVb8Uouu3lYoDRFIeCm+4Lj1NcTJzU
         BZSiQndzv2EpCPYzRj/vrQLrFZz1Vqbld9JQOrkkAurnHiaa7P95+trcLcpH+FGUY3m9
         Cocw==
X-Gm-Message-State: AOAM531BV6A5nX8H0kEv4vp28ExtkW5Z+OQsqQnTVvz3CPU78/nMLj9k
        1bCh53bCWYbPgHU1Ze8+a24v3J+TnWs=
X-Google-Smtp-Source: ABdhPJz94dXR/eCC95AiDMGVBvVPY1nZLSnTTwi1SxBRS1ftARMvgGfZPKpfdwQZC/7cdiv9UzgnnQ==
X-Received: by 2002:a62:e514:0:b0:47c:12f6:3aae with SMTP id n20-20020a62e514000000b0047c12f63aaemr3635707pff.26.1635258103256;
        Tue, 26 Oct 2021 07:21:43 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id h24sm23429671pfn.180.2021.10.26.07.21.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:21:42 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH V4 06/50] compiler_types.h: Add __noinstr_section() for noinstr
Date:   Tue, 26 Oct 2021 22:20:14 +0800
Message-Id: <20211026142058.17702-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

And it will be extended for C entry code.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 include/linux/compiler_types.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index b6ff83a714ca..df6f7252047e 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -208,9 +208,11 @@ struct ftrace_likely_data {
 #endif
 
 /* Section for code which can't be instrumented at all */
-#define noinstr								\
-	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
+#define __noinstr_section(section)				\
+	noinline notrace __section(section) __no_profile	\
+	__no_kcsan __no_sanitize_address __no_sanitize_coverage
+
+#define noinstr __noinstr_section(".noinstr.text")
 
 #endif /* __KERNEL__ */
 
-- 
2.19.1.6.gb485710b

