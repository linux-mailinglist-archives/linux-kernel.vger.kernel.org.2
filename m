Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D8042C876
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbhJMSTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbhJMSTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:19:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AC2C061753
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v70-20020a256149000000b005ba4d61ea0fso4024765ybb.22
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ddM0wjXjuVhiESwBHLGsB/XcUm7YnLsw3weEAwMgFME=;
        b=DzJe/FhyjAokjnnxFQ0rBkacgAGKjayT5VwKQxTR4XCFjeL0GT9oTPrs0S0kVuwWBb
         EO7HJtGj52OFfO1pEGUy+nmp8SjWRcDEmn5CmNnwDq8EP0m1QlH+erpfeOfI0b1CqLvU
         TXf3Jdi2OGDL5fLBmf2Jw850Lz6MPqfmrYUrzq5oVBy3sEMFRCBF5U7JErhv/QmtkoAK
         kVSfYtIgUoBjgLyYXqUqKuqr5rOL2l06G89950silNPDw71oeF3AcTAkcMLyKDpFvtBY
         6du/OpowoDdOn1uQ2jbcOXCVORj+xgh/p6M2hbzk+YYukSW3wp9PQco/TWuFC1IVQGv5
         bojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ddM0wjXjuVhiESwBHLGsB/XcUm7YnLsw3weEAwMgFME=;
        b=TgxtEwtwkhSx9pmNoHPgDSE//oLyHq7V2jbS24uISHOFsoQa8MjerCvl4NuZ3ljlh9
         pzTcz0aEaLU5ZAFVr72YUAZK0be1jvFJbWQhoW5/n0POkGll0V7uh5SHOukDBxhh2vtb
         22S+i4CIpwyxuBfFT2P2FWAV6jC9vIh91FlqVByRM2wHsqXsiq/Utw2oI8u9Zbzer42k
         jer2gjj9NCh7IWaEyErK5a6Yuuz+msND4722X/lPIwQL86d0lVzIbLa3pMeKfsEvB+Cw
         19sG5CktqWiO55DbD3oU200z3R0ds/TxwnhWh3VqppuzkXe1DPyPGnfpXcfHn96ldJCX
         Rdfg==
X-Gm-Message-State: AOAM531IvcLz2VUs1yczlup9G64jH54dL/emT7Q6pybsM3CyAcWjfNu3
        8MtgneVuEn+Bpy8uMD6HRcU2V1ESyVzDuX8rMtY=
X-Google-Smtp-Source: ABdhPJyfPiWvwvyeGuzv1LxIxNV3AorG5YJBB0JF63uKvJE7ax6+V2igiPMVtj2orDazolU/eFQ8Gjy3Rb43OAux4iY=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:9ea6:6c27:1876:926c])
 (user=samitolvanen job=sendgmr) by 2002:a25:bd93:: with SMTP id
 f19mr1010727ybh.23.1634149026081; Wed, 13 Oct 2021 11:17:06 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:16:45 -0700
In-Reply-To: <20211013181658.1020262-1-samitolvanen@google.com>
Message-Id: <20211013181658.1020262-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2401; h=from:subject;
 bh=FbKx6kJYHXjri4vS3aVbZDzbVSEbthmZmW2N9ZzoevU=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBhZyKYaPNjTvTJEt/2zmgf+vF3zAIrGYZaw+pgnDSc
 seWZsv2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYWcimAAKCRBMtfaEi7xW7l+SC/
 9Rs2vaJZcjKizF7OtJ+jkFalcGem/aEeWPBrHMuOC5YoULYYF6tC5JdtSl2YGGLykeqwyKJJyw6pvr
 ptAc0tl4opaiXPuJzVqq2EkVITGV2g3lezpp/5x7CrkTu+0uNxoLwbA3JjmR7dLN63j9MvCeozia0n
 aePKOv/AXfSjuNXMkT8mq/DWCJoxGIWRG+v8atmhLnHHxNdLYu0PqFXMbHUEsxr4shxsPQwh9qWJ+P
 PbXjZxmAWh+CLfZ6yYXkWely9sAyZ157NJuya9XsR7YhOdTEN6T5IgtWLY5Vcog91a7KYIFcKU/2nw
 HF6CZTRTscTOUrJhcvucGdZhKFPV+CdBDvPcb+Zat8XO6hBvczzBuhM5Mu453pnGkYW+KmmEF5CHsT
 pI3+S4s07v+ptfu0Imn35QbW6k+UbWdNaKZsaHjsbTIxb3aNWNmnLqda01fGR8bGSeVZT1afOQMvss
 sTI0VkSZj/3zvudtfkQ+0DzZ3gzQJ0fyKxW6ztSZI27Cs=
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 02/15] objtool: Add ASM_STACK_FRAME_NON_STANDARD
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
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
2.33.0.1079.g6e70778dc9-goog

