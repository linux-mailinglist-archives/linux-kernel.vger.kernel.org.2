Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE943F3E76
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 09:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhHVHyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 03:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbhHVHwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 03:52:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0D0C0612E7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:51:35 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bo18so10082439pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BfB3Cmd48Lw3NLo2MjDQrUdYMYAq078Tr/lLK7PF2Ag=;
        b=WpSZT+yznpJZoZUZ5kVVTpVKD3OohqtuIuknuv8Bv74Y7MkECUy6dKXXvEgCPrHo2M
         StX+u1larUy+QKmqQ+AAWG7omBTY5WBirDfqH330dR49ICAwhYMMwaUE2HjnepVAO/wm
         OS/V3yeizwRlzeTjEdAGlaysFMabEff8UgGyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BfB3Cmd48Lw3NLo2MjDQrUdYMYAq078Tr/lLK7PF2Ag=;
        b=nle0Z1rppSFCIR78nemiX4Opn+M7Jieub6u7q9H93DWhGn7POhfZQfCSW1RmJKZBDN
         8rhse9T3yJNEEmu3dsOS6Gcha7kM6eJcXHvtXsLKd1DZrIwc/aM9SwIi8ZjidyyQYEIO
         Sk3UmIIYzQnXlyjyo4f9lnexTXpHrjXqMQdmlGPoXSokAntraMPhQAqFZ2tG9eaCHsF6
         x7xJJk5iL1iqZkOKR2O5MXasKgIUfyg5maLbIEl0IouYW1j+iYUhGG9k6q3vRXKqqAkW
         nbKEf8UDo2Uj/5FHCXYq5sOEku5JEKJyNdxa78zg8z3+TU7iMusKIIX4Q2RevMyFUB20
         fLXw==
X-Gm-Message-State: AOAM530lncHqxtaGH9Qs/9B/VLFQO1DJw2Z21/BYutissMUjveFIDdlV
        9bbIXmtaE1eqtvn6EWT3XUg8qg==
X-Google-Smtp-Source: ABdhPJyw/m0YL+SMwQw9xnTHSvKugbymKWallujGCiV2PHic2NaL3RUN9r6ivfwUSJFox6r2x6VV9A==
X-Received: by 2002:a17:90a:7642:: with SMTP id s2mr11394217pjl.128.1629618694601;
        Sun, 22 Aug 2021 00:51:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z12sm1547902pfe.79.2021.08.22.00.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:51:33 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 13/25] compiler_types.h: Remove __compiletime_object_size()
Date:   Sun, 22 Aug 2021 00:51:10 -0700
Message-Id: <20210822075122.864511-14-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2324; h=from:subject; bh=D5YSORUmsx9ZlfCs+tSqi/CZpajcAvBSa1fzHW5hC6U=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH3mQdShenoA8GqVoEcJNbXyXj34Z55m75eTMc1 mv6GEjiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB9wAKCRCJcvTf3G3AJoJRD/ 9QSglgyxVbQqmTx2NOrbeHh77uk5RWPYLHFf6ns+jNsTJ+ow1pQ9dk0XDk/P0uM3m5Rfss9NqadxJF MVFP4US/uGJrooGWaMIChdWImnRSs3D0d82TBTGbb44K0ScN6BhLur7Tpu6VKI4VcQoScI70PTQvKi REZQIUMGvPorwBmUfzZljjfitzvUstplSx02JcC5zqnvSylycjSVT/EZfSFuu/R/VlB/bCNyyRSs/h 2Fqtv37PwfWx1Gvci73CUKFXE04IP/ggsjG2aStDEZr69i+1hf4+7lYzjQXj5ovlb1zDQtL+4M9Ji0 oJLyeaEaFcAl1KgeD1zDrelT64tWw4G0y3DT2/OEohi4kGdjob7w22sUajJa5QtUGzK3AkItO0ckAM nK9EKhMaRFi7TwMoNfsXbsP4PoJVHMSM1pfm7Bg+XElJLMtTya2bxdtFxvKfl10LgNk1zvTtKPJ2yg 0FamEjd/2aciwAmW3JokAc4IR39xnT/6Qvh8WSfTO/sfs51LIdSWpgJhxYM09emhc+AzM1hFvMv2Ta abwMm9kBEmmqGFWqeQUWSN2pHW8TDkhvL3k3Xb3uFkULx7K6wDgOlBhXK9f2W55rbrRoZydPycWLjp ZFW2Mo/eeLeNjXKTeXx/N2SecQUSclhBoQJA9K9S802S5wZnyhYFFUVaHfRg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all compilers support __builtin_object_size(), and there is only
one user of __compiletime_object_size, remove it to avoid the needless
indirection. This lets Clang reason about check_copy_size() correctly.

Link: https://github.com/ClangBuiltLinux/linux/issues/1179
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler-gcc.h   | 2 --
 include/linux/compiler_types.h | 4 ----
 include/linux/thread_info.h    | 2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index cb9217fc60af..01985821944b 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -41,8 +41,6 @@
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
-#define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
-
 #define __compiletime_warning(message) __attribute__((__warning__(message)))
 #define __compiletime_error(message) __attribute__((__error__(message)))
 
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index e4ea86fc584d..c43308b0a9a9 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -290,10 +290,6 @@ struct ftrace_likely_data {
 	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
 	 sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
 
-/* Compile time object size, -1 for unknown */
-#ifndef __compiletime_object_size
-# define __compiletime_object_size(obj) -1
-#endif
 #ifndef __compiletime_warning
 # define __compiletime_warning(message)
 #endif
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 0999f6317978..ad0c4e041030 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -203,7 +203,7 @@ static inline void copy_overflow(int size, unsigned long count)
 static __always_inline __must_check bool
 check_copy_size(const void *addr, size_t bytes, bool is_source)
 {
-	int sz = __compiletime_object_size(addr);
+	int sz = __builtin_object_size(addr, 0);
 	if (unlikely(sz >= 0 && sz < bytes)) {
 		if (!__builtin_constant_p(bytes))
 			copy_overflow(sz, bytes);
-- 
2.30.2

