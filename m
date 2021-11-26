Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D5E45EB43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376785AbhKZK0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353256AbhKZKYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:24:18 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25114C06175A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:27 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so7700465pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQVbJCW7Mbz/9sLwmTEwHJSmFrRArQ8ZV9euRKYXil0=;
        b=Oz7ghlS+gEXTENqDMgLAbIGjVBZ7ViVQevdJKjWVC7rKiz7gJyOQN2gGSEi6ZIEZE4
         xpcWKZfTwVskf6g0UVQEmj5Oq/61CO5LjwsJIJRIzGq7chxxtnUkXzAn7g+ERKt/oFLR
         5eWuE5qJdASkj3zRkwa8mqFSpJpKytktk8gOgyre9I3U5xLKqRS0BzqE0MyZ/7aKZWEc
         K2DrwvtYuweLW4MJgQVmaUrgz1QEwVwmlSVdRx3yDFGfCC1dtLs65jq2nKBH+zDZS/pu
         zud5d5vRFQZKS++W+kWwJHlfFG7mDS7voua7yK289oRbxCqaqio5FIhY53+0EBkA7/Rg
         iKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQVbJCW7Mbz/9sLwmTEwHJSmFrRArQ8ZV9euRKYXil0=;
        b=aOaOhdgexZsLqOaVyGV1tizhImhigc9GUfRnmcOQWjZedFIzttB2GXa1FEcBZU4xjg
         UaKC5xcIuedHxxiQ72DBAqy3NfYLC8XaluVpmfFhKMHX2O264BPhUiHYeTFuq6Os5q/l
         46Z5WqBNwHr6XiQfpvKaaIMWxxkiCupmUJ/FzveMcIrxxBuTK9JddDEyvB/wrveTU4H2
         PpurBUOerAnBgbPSEYlZmaiQwBG3WbxMngJ3+dYXNPc7dKMkixBjUMQ9lJcbeXPcQqSp
         fyChG0hYg9Em3rktGt9yV/gM71vzp/wNe/FYyYjprWWEoKd2q7EWGkHxD8RmLxw4Sg+4
         Mtgg==
X-Gm-Message-State: AOAM531apwVYjPpX1qfTzhB2twWD1O7Q1Ybi3gFmGa+p2xLr2xpSSHdH
        rPYifEtiYNq9+z/yfOgJSDvL5JWCZnM=
X-Google-Smtp-Source: ABdhPJy77CJxg2JL52Y+hMGVAAVRMz6+m9v/Q0jFIlh+nJx+GLX8cA/NbJ/oTWbX4CCoxmugKhekhA==
X-Received: by 2002:a17:902:758b:b0:144:ea8e:1bd4 with SMTP id j11-20020a170902758b00b00144ea8e1bd4mr37482744pll.25.1637921546573;
        Fri, 26 Nov 2021 02:12:26 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id p14sm5339857pjl.32.2021.11.26.02.12.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:12:26 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Marco Elver <elver@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH V6 05/49] compiler_types.h: Add __noinstr_section() for noinstr
Date:   Fri, 26 Nov 2021 18:11:25 +0800
Message-Id: <20211126101209.8613-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

And it will be extended for C entry code.

Cc: Borislav Petkov <bp@alien8.de>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 include/linux/compiler_types.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1d32f4c03c9e..1c9ca1e3ad26 100644
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

