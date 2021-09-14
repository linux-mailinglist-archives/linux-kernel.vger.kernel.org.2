Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC8C40B797
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhINTMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbhINTMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CB6C061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:10:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso180775ybq.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GntyULKYdaSgQ4FSc94xW8hjeJrETKXOJriN4s54uWw=;
        b=aT2jrjMLALuM68EN4GvqBSoT8NJnT9S2KnAKIX46DewiNosK9gM7YNFb5fGzZriFGh
         uDzfTa6GeTXvkTCRtLIUrwNnePSl9yeBJ1HJ7UMdv6Wk61BiJdpiqNGl1yHyLW9N/+8/
         zLbll7gVEFTWrlgJM4DrG6I7JAkFPIYDb6kIAI9WSZoe5r2oil66tfaQj1AfRj8rU7hf
         MEqRX7MYF0gEt6FXt6w1efL6SpTptQO5m8h2QhJrY/ctS7TpdEVAKklJCcBcwCJ3MwpG
         AidaSzC9/d7Xhchi37fMrF9Zuszg6sAA/imLd95dIE12VzNWRmz7WRAeXqiLCoX4nyVN
         mBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GntyULKYdaSgQ4FSc94xW8hjeJrETKXOJriN4s54uWw=;
        b=kHQ4eF+1UAysVtlsRECVEoV/nCXq+LQyQg+mkvV1F6PdWndVJKe4PKS7eJhjKJ64vo
         OviNToer6L6Zps8ujiqm06y22j/JdXEHfJkU8cxx81z2y1boFaTMFLuLqC5kTnPgImFf
         edKT3+pa+FZ/0pGa49koUmpkH2RQ3Avzu7o1UnWxj7Jeq2ny25cn3q3RgYAQ6E6pyyuL
         hA3w+vKb+SccPfO8WfxJU5KANZ/mRsL8GImH9QVKq1MjALbFdKqPwn51tJ3ULeKk66Mh
         PWuCz8IzF18Ls7e2g0ZIopRPOnfrth3lrxTwrQ5UcygCyqcZ07hthPLM6dlawW95pHCl
         eJlw==
X-Gm-Message-State: AOAM533dHfpKrSrn870tH1FchvZv+nHOsDhsxbMc6z0Rf5nsDrN/uY17
        IfvJLoVTbw+NE1c5s3sjFPsNYTe5cPqJ7OWPFXE=
X-Google-Smtp-Source: ABdhPJyYl9xP8Yp6E1SQkkBSZ4rht1wn3c1LW67yBaBUGjJheWeCP7bZzJS5bR7dIXtl9GLAlvLe0P8Tf6LjwTs01TA=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a25:c446:: with SMTP id
 u67mr972641ybf.269.1631646653326; Tue, 14 Sep 2021 12:10:53 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:31 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 02/16] objtool: Add ASM_STACK_FRAME_NON_STANDARD
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
2.33.0.309.g3052b89438-goog

