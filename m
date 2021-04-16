Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65EE362980
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343907AbhDPUje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343857AbhDPUj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:26 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E34DC061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:39:01 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 79so4510450qkm.20
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QGx/+5PSv4vcds8exhIxEpB6elgUIYsSVqcIzQ7CoY0=;
        b=uZKwdvxXSJVGChXYzLBAPig4b5FYoGeda5NKSXNeIL575TrHj+mv7A6/+z9Q1ULF47
         GnFegjvKKkl7mkg0kCeRTvHVoMkOPQN9NFKfTvTwa4rdwn1TJsA5bNIMe2sPLez4NF9l
         2Zg20J9c4zB9EqzOqCvBBzry6ki6GWBqYQH443gpTia0Wf9cAczRPhdZ+E6sQJ8CTBKE
         1G1jUiuRdYGYN+c+LThtYloKLH/8suUpE9jkMdU9MkLjVtKiVSy0McDLo32SbABPtaPs
         hqf4xH9PZJw6//EfRMRXxYTvr61J5xf4WOR74HouKDc984vllZj1WXQz1AXJFvc01LUB
         eYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QGx/+5PSv4vcds8exhIxEpB6elgUIYsSVqcIzQ7CoY0=;
        b=I2I46JOhpR/yi+YYNzQSH/f0aA8CcIUT4vr6amD+JIFgstu0/acxFNX5CxZsJZQ1fD
         iVAeNBK0JMUrT1Ttv3i8qPHzc2i2ngNztEWr/HV22LRFDxlFU3mRjId+qeeLLlUd6EP3
         n6K/ytdaibvweCYyu3cj6ZnzygnH+B6hzTdubs+yjxoVRW2RzyjB4pF6Zd34CFJkLMhD
         hM+MUIhKZ0oF5LLSOBM9Wm7sNoVXJI7Mw5d9X4oaAyArZr0XmnfT4pKbIwWr8wjE52oz
         LfcfjygkpzM+Ca7ujHAWdHs/82gBNgJPlZFTAW7jWFYfPxOgOAUqkTUzfCZhDXDxfHkp
         BnIQ==
X-Gm-Message-State: AOAM5328CaVFiLZdkfF39lwkKqIsCl1yWD1u6hXV8zxsS3P8/+siqaDN
        tjKdhqDHQHezJDAdgPSrtqxWfE1nlwq/BqgUhqI=
X-Google-Smtp-Source: ABdhPJyRVTTcyMgTah2hEg8Htw3gAC/nsLNQLXzjNNIB9gT6Tqpqgc0Ua2gQrpl1CRkqaDZyjPHxQmaRFDS26fQTb/Y=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a0c:f946:: with SMTP id
 i6mr10263185qvo.42.1618605540208; Fri, 16 Apr 2021 13:39:00 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:36 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 07/15] x86/ftrace: Use function_nocfi in MCOUNT_ADDR
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

With CONFIG_CFI_CLANG, the compiler replaces the __fentry__ address in
MCOUNT_ADDR with the address of a CFI jump table. Use function_nocfi()
to get the actual function address.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/include/asm/ftrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 9f3130f40807..0b7567994f4a 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -6,7 +6,7 @@
 #ifndef CC_USING_FENTRY
 # error Compiler does not support fentry?
 #endif
-# define MCOUNT_ADDR		((unsigned long)(__fentry__))
+# define MCOUNT_ADDR		((unsigned long)(function_nocfi(__fentry__)))
 #define MCOUNT_INSN_SIZE	5 /* sizeof mcount call */
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-- 
2.31.1.368.gbe11c130af-goog

