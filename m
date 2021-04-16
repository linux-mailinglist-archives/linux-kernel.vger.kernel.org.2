Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21116362974
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343788AbhDPUjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343697AbhDPUjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:18 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F045C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:38:53 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id r18-20020a0ccc120000b02901a21aadacfcso2833992qvk.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2V8QAsj+Z02Kd4LR0nXDnyyqH7VtGeWLcnKeL+XD35A=;
        b=CDdGyScpvVmaCh6gbf/jPPbkNh4TnKHQUO41gkbgfdgmxuRVU/J80g77PWmuWvCb5A
         pMuHKl87ofecvT9ftF9y9n5UNOKXQ3SYtVDqIu2TfknnbvyJQ73W0feBd3VhMlWAatvj
         HPbP/xDZKsuJ6eR4p7P9o/OWom0atBPt+gmetLcHMuyVkIGmSugShyqazxYeablZpaKE
         oQOZMnA/xg+zHtMaDtyGVlNJxGTppzLd4ZT3YKlaj5nEXJulXjlMkQrv3xSDsbvVFjd2
         J4v5/OcZHFwASvCTLYApY50UaKflNddGoDlQTGOJ1KLzUBD1bYjrPaUIeo8oI3/05cDq
         F+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2V8QAsj+Z02Kd4LR0nXDnyyqH7VtGeWLcnKeL+XD35A=;
        b=KF7qqrw4H8JUBBshxAhat94+B0ijg3/hKHNmiKYpDv2RijClMZstiqK0nqKWU3lMaM
         7qudQT6Y6ketvGzRRRmvICrdMVKiaX5JjvA5qdxPPCR+eFV/g9Mki826vD/qyQ6yyyIR
         TZ94t6Vf9DK6ZdWn7Ezw0py3jbU7IjK5FMwrKgW5fWli4itnOa/O7MgTQ0u3ennaidVe
         Fbz+Ol9Zn9nPxkf78ORkxOyR9CsmyjZSL2NnDZXN+pUQn5Xcb8r+EZplfOoYboCtKr36
         UzEZqMMAtAjENic18EPfRwZx49rs1mO3oK3pmYokoHfgeGv7YT23V8qEE3stRSVkF5DC
         SWbQ==
X-Gm-Message-State: AOAM532oARh1GBNf56sjAtMkb0KzlmB6lRxyC3+LD1q2NXhLS34ADTHM
        jyYqxMPjA3aNYE1iwm1KIZYm+OXF+8EZM50DPVY=
X-Google-Smtp-Source: ABdhPJwBNtOC2GuqNSxtFRo/YW2dNu3RDamX5XVjt9LnAmvk0iapwxRvMqGGPKXU5a2SfpmC16u4n1T5+6nw6sxXmI8=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a0c:d80a:: with SMTP id
 h10mr10443081qvj.25.1618605532443; Fri, 16 Apr 2021 13:38:52 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:32 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 03/15] objtool: Add ASM_STACK_FRAME_NON_STANDARD
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
 include/linux/objtool.h       | 5 +++++
 tools/include/linux/objtool.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 7e72d975cb76..2f29ce48ab5f 100644
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
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 7e72d975cb76..2f29ce48ab5f 100644
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
-- 
2.31.1.368.gbe11c130af-goog

