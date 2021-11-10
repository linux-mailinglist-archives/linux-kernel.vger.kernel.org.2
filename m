Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890EE44C06B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhKJMBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhKJMAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:00:53 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1B0C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:06 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g28so2054600pgg.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h8+tdLXDpehbPC9iwSK30zXw4D3aySJVqJ4HdEfRKLo=;
        b=WS8RmwNYWCjEwPsjUg1XEmdXH/jsgTtEMeRtMdXPoFAauu9uZRZne+tvFDj/x4ZEOj
         m3/kX9JNLi5L3zzclB3N8a5HvhbW4ymC+ITgxqhVsSuBEvkxtp/WE9izulP3uikuTpm6
         eCMZRuRS5rWvRuMHu3r44bFmBToDBCYWgNo7nPPYx0G/TUNW9bYPsD+wRNo2+DXyK6CY
         PDKhhy0UYsAh8oK6h/7Gz9MN0zJprBmCvnEVgDBvs/vF7i+ZLNBaQZr9cZZAU+QLApsG
         rkk48pSgdWGyWk7PH2wZGQIm9QvSltFFM5Z4M8weS7qoXVjmzPuThvoO8hMCJk1vbZOp
         4hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h8+tdLXDpehbPC9iwSK30zXw4D3aySJVqJ4HdEfRKLo=;
        b=i7RKmahqHcqoYnK1cdhYuowjGbAKAhb03HGZQ4eYAgHLEs0qFvhYQc4eU28wQBzfLt
         azGLJJKjDg3sVgtWy6JCH4lXnCu/m94Z78E2WaUrY5NO2h41WmbT/abE8E5cV7E3cIUM
         KSk9cBIC7cVLP6AvbWkyD0rXhS1m9gK7mLI1e2p7OEhrFffXoeeVGOydXLXIZPEgz4+0
         ny98+0T4tuGkYNIPYBiMp+wJCUjrsczkwuhgq04XEYsRuql60tasepJdIK3mNeQ61FdK
         5FzzQQAjeeHW+bxFc9nJ5PbFGx7XeqgSQY79kjX5V+eldsO7Y6YzJXctPLPAeLBzDa9I
         07Nw==
X-Gm-Message-State: AOAM5312vyrYwXrbbLSjs3UomzLZJM6vRccVpVSQQXvwh2oXbbkVVG74
        7x8PdIAKlm3VKLoYTIPX0kI0JOkkRSQ=
X-Google-Smtp-Source: ABdhPJwlBlIqGmBIS7aSfy10S4Vjdo9E0kWKZvo6PbRf3o2WhytWyMnZsMpYtC9KX3dNmuKyQymOWA==
X-Received: by 2002:a63:720d:: with SMTP id n13mr11368963pgc.470.1636545485688;
        Wed, 10 Nov 2021 03:58:05 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id l21sm5386832pjt.24.2021.11.10.03.58.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:58:05 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Marco Elver <elver@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH V5 06/50] compiler_types.h: Add __noinstr_section() for noinstr
Date:   Wed, 10 Nov 2021 19:56:52 +0800
Message-Id: <20211110115736.3776-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
index 05ceb2e92b0e..b36e2df98647 100644
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

