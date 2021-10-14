Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75C542D0FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJNDgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNDgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:36:23 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC66C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:34:19 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q19so4288393pfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+YpQVQ94dvMLzEWuy29CB4UiCMbkzHfsIlS1w9Mt9E=;
        b=dANzejg+PYXVn57PVbggK/8Hnvhk9tM7Uc/Ph7ZrXCPiue7hqYK9OUuDPrnsQTUcOs
         Qcj3QXRDXgU9Q0U5woOPcDwHhfgWKJIGjN2IIT6a5b+Z0NLm+YmxWaIPnLYQBm6SaXtg
         8gNwJX0AJn3rU8Dhllz3zM8jEWqz1mdKBR/+eCD5T0pcKVrIL6RMpIWXNclVJYXczkw4
         Z6bHnWs0LfwAZSUuPhivGulpo1Qb4K3APaS3IcGHAwlAQ9m9cTRNoBe1pFGtYgAKj4dV
         cbM3ECfUHLZ88UdmUKViTfd7cjdFnrrG6IHRgRB1GlusACbhuUslcR4YbuGi6DZY4QJ3
         j2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+YpQVQ94dvMLzEWuy29CB4UiCMbkzHfsIlS1w9Mt9E=;
        b=5gTQiRRVmaFrPFVGIQGoD9OqCBgEuNP4PUx7gbTYf9/s6fcRnna7JdUaEeCYfCql+u
         kdzVSPjjbbMr90uNmakTMPXUCRIcKCK4U4/ilgjkGT6TAZpzfTwMESPIRklGW30i1xe7
         OmTbpAsD22Qm8krxLqus9X8pmbLp7B49o39/U/bOfZaQx5R4cWmC4FUDPENZSQdUAwkH
         x0xwcxEKi5YgVp7TmIMrJg+YYe6J3lwvYpjP1sXZfTHNxQxhm/CURKi84C6ukgiatkQA
         y6mPqfGh+FBlk+FDCJguisGHwdKpueu1JNUon4NGsNlqn2Gwc29ZcmXiSaTvB4rBu08H
         bbqg==
X-Gm-Message-State: AOAM530kvC/rg+SwBcJnW1tCUtUqhzJaIIRYeQL7eKWAkQt9/0g/XM2n
        9cLVUqhB0Ev2TlnuXq/pS36cBKuQpt8=
X-Google-Smtp-Source: ABdhPJy9x0LluiTtih5AE/aGdhx7Ml1RfFLp38I4LPTIHkF138oDF+lyfaOBcwndq2AmB0PvtR+ldQ==
X-Received: by 2002:aa7:9844:0:b0:44c:ce0a:f736 with SMTP id n4-20020aa79844000000b0044cce0af736mr3139358pfq.1.1634182458878;
        Wed, 13 Oct 2021 20:34:18 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id x7sm842294pfj.28.2021.10.13.20.34.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:34:18 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH V3 06/49] compiler_types.h: Add __noinstr_section() for noinstr
Date:   Thu, 14 Oct 2021 11:33:29 +0800
Message-Id: <20211014033414.16321-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

And it will be extended for C entry code.

Cc: Borislav Petkov <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 include/linux/compiler_types.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index b6ff83a714ca..3c77631c68bd 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -208,10 +208,12 @@ struct ftrace_likely_data {
 #endif
 
 /* Section for code which can't be instrumented at all */
-#define noinstr								\
-	noinline notrace __attribute((__section__(".noinstr.text")))	\
+#define __noinstr_section(section)				\
+	noinline notrace __attribute((__section__(section)))	\
 	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
 
+#define noinstr __noinstr_section(".noinstr.text")
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
-- 
2.19.1.6.gb485710b

