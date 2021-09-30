Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3706B41E094
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353060AbhI3SHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353052AbhI3SHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:23 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C795C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:05:40 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id j6-20020a05620a288600b0045e5d85ca17so14132991qkp.16
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yAjbLnc/4a+xG0iJA7167YzRctoMe7iQs3Th7exl8y0=;
        b=SvlcxRI3GX2nd8j9Q0bgxfBDF3ydh6ydlHg7K7EZljsvTET8asCVHOloFKQ7TRijza
         vN0HjN5JaVANlUkWbGRwoLqyCgaugjgFLtXJHICFTckU6s8u5Nw3D5IRqZLMoisvtJT2
         lwK7V/I2GkKyyR8M8zIipdubdj0hm5i89gRWQrdBh2hPr2MdTtfMRvAeGSHtTIvOdIhf
         ZgQHGgegg2kyvZYqJy9o/zJ24gjETr43HBOkQdJxZ72YKuNL5hp0p+5Nx8/E20tIzHQZ
         64R8fZAjx4IFoTPSPIENZysfkgVYoNGXhh3++DuTcKc8F+NymV7l7WKLPlMjk4zfml8u
         QopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yAjbLnc/4a+xG0iJA7167YzRctoMe7iQs3Th7exl8y0=;
        b=2WoMkr+/EibymJWKopeomGwGr1vjOLosPYctAMBlMKozNUcMAYQVeefDoqbqbcU3v3
         8FqkYuuideR5cPiGilXnYDinOS3e7G+4Txhe0kkzIoX0r9ZMaZrA96nQ7uapz8tecf7X
         wMUb1LdETeBN1UsR0GCB4kkTUew+d2jhkFk+YqrEAcBCu6y8Qys31ZWVioENRVc4FAwh
         WB9KVnl7Wj0zx5HyFuuoejBzclMMmj4Xif9mc00hJlQowfxxvmjeub4mnGYKZdjmKJ1E
         2jM/w90qrXpX8kLdIboMy4f/rcoJiw+FHIVF1CzynJDFjuncremhgSzwfde0Ty4yQxUm
         HLxw==
X-Gm-Message-State: AOAM532OMq8deXg39bPJ0T+yS9BtuGHjaE6xYQZrCJyM44nk0xbeKT1R
        LKeUN4+EYy+8TKGS0we0dTTa32mc2xZLN2H1Mu0=
X-Google-Smtp-Source: ABdhPJzSSSnwMdWUnZcSCWxApNcxtPczjvh4ogkn8fqf5fL6TvlzIOJjfdSg+b9xxcs7cfAmBGB0tTMcLHwNPjr9GOk=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a0c:9d05:: with SMTP id
 m5mr5140529qvf.30.1633025139519; Thu, 30 Sep 2021 11:05:39 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:18 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 02/15] objtool: Add ASM_STACK_FRAME_NON_STANDARD
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use the STACK_FRAME_NON_STANDARD macro for a static symbol
defined in inline assembly, we need a C declaration that implies
global visibility. This type mismatch confuses the compiler with
CONFIG_CFI_CLANG. This change adds an inline assembly version of
the macro to avoid the issue.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/objtool.h       | 6 ++++++
 tools/include/linux/objtool.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 7e72d975cb76..080e95174536 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -66,6 +66,11 @@ struct unwind_hint {
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+#define ASM_STACK_FRAME_NON_STANDARD(func)				\
+	".pushsection .discard.func_stack_frame_non_standard, \"aw\"\n"	\
+	".long " __stringify(func) " - .\n"				\
+	".popsection\n"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -127,6 +132,7 @@ struct unwind_hint {
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
+#define ASM_STACK_FRAME_NON_STANDARD(func)
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 7e72d975cb76..080e95174536 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -66,6 +66,11 @@ struct unwind_hint {
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+#define ASM_STACK_FRAME_NON_STANDARD(func)				\
+	".pushsection .discard.func_stack_frame_non_standard, \"aw\"\n"	\
+	".long " __stringify(func) " - .\n"				\
+	".popsection\n"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -127,6 +132,7 @@ struct unwind_hint {
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
+#define ASM_STACK_FRAME_NON_STANDARD(func)
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
-- 
2.33.0.800.g4c38ced690-goog

