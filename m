Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA68D40B79B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhINTM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhINTMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:20 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43829C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:03 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h7-20020a37b707000000b003fa4d25d9d0so666216qkf.17
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jYwwg+Kk2U3ZYcf6hnRJvQXYZdAJEEpKGctoJaVt6gw=;
        b=NPAnSX36jiv1lKvN8PC/ewFg4fvEFLSg0OXLd21hP+Yo1usj7PqD7TR2NByTekAfUh
         h9FPMybF8EhSxOIuOyNDV9uJ3TwEcK1rcB6qB5/J0Tl0bZGvxvAqk2EDGRz1Mt/FZDQ7
         KAqeulJ41HnmYVV0VRGj/e/Bdnaq6UA5+Mf4Pw1RQ5+HIX/nmeyLhlAhPZ+kxQNzIbMK
         73i8cwOy46P1K3GtC6eEcdY7ARKNBIR0voK5g+UhKzsZPQ+HtMoorSGJctiTYpw/+R+W
         zmKfLiyY1lX2hHyg2Z0XkIggSV3I6MVdfihK1jHHsSzHQkEGdMEpalpoF6M63toc9pvQ
         Rkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jYwwg+Kk2U3ZYcf6hnRJvQXYZdAJEEpKGctoJaVt6gw=;
        b=Di5u/H9G54MSFlNQOYjKbu9tLUOR2GOmTYSgERtipapQkZ7BWQhkkDWLPErFjVNEYr
         iNbeHAJ5YsCfE+0y2sdX7C4mnh3c1/JuK67bqdaWWfN0uhY2ITDVPIhZ54c+9b19Yw6H
         6uVydQlv0LxSTC9n5cf9p/em4rHtvZv6uwtO9Xqvuhzc5OfMbuOvQBC5GhQ/DmeXj2ou
         K58B5BDycf6f1nP3iwCDaLozA8oz2gVtx8Ry+/5d3Twl0K3TGSlaJvwbGEyC14jcYvZ8
         B+iiJQXQEYNfQHJ243Sd0MZDu43j/8PrMnaA5sQXrtVLjg0jb4Ey84vdS/ebM4aSpA/F
         LtEQ==
X-Gm-Message-State: AOAM533UUgBcSRBbpy249LQSJ/dIt7m0ptiIdz0XKEt0V8yejy87Wucp
        aitA4lUxCAlsMe7scho1OAQ7Cjg1rxcx1pWNtm0=
X-Google-Smtp-Source: ABdhPJwfi4qx4qnJtxV1+MH40mouU14ol9xzH3S5QgcUtGhRKkBUjAuIzNteOtfGHhHJLuACMu86DCp6Rz07WMTqCQQ=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4652:: with SMTP id
 y18mr7035452qvv.2.1631646662445; Tue, 14 Sep 2021 12:11:02 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:35 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 06/16] ftrace: Use an opaque type for functions not
 callable from C
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

With CONFIG_CFI_CLANG, the compiler changes function references to point
to the CFI jump table. As ftrace_call, ftrace_regs_call, and mcount_call
are not called from C, use DECLARE_ASM_FUNC_SYMBOL to declare them.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/ftrace.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 832e65f06754..67de28464aeb 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -578,9 +578,10 @@ extern void ftrace_replace_code(int enable);
 extern int ftrace_update_ftrace_func(ftrace_func_t func);
 extern void ftrace_caller(void);
 extern void ftrace_regs_caller(void);
-extern void ftrace_call(void);
-extern void ftrace_regs_call(void);
-extern void mcount_call(void);
+
+DECLARE_ASM_FUNC_SYMBOL(ftrace_call);
+DECLARE_ASM_FUNC_SYMBOL(ftrace_regs_call);
+DECLARE_ASM_FUNC_SYMBOL(mcount_call);
 
 void ftrace_modify_all_code(int command);
 
-- 
2.33.0.309.g3052b89438-goog

