Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E3142C87B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbhJMSTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbhJMSTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:19:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B67BC061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q193-20020a252aca000000b005ba63482993so4168392ybq.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uYgui4LcJCAu520X9XRPu73XHip6FUKmXdkDEHt9sf4=;
        b=DFFjEsk0DHYUkvEg71gesxM1jhY/PvKsosaTZYW26zppRAWHyO7xGBmA3GW1+3SvZO
         vJ3Aty5bZrryPS1KQ89oeEsy3OorFeX2/O/MCFV4ak4kQ8Q5j5DJpUm9p2ALqj1Kh67l
         BWeeV8dEb3J9BWb5QHusfPmt5pthzRIshMzvMpZxCxawvff7QBh6P4HF6iu5Y6EyIhIq
         j3VYtLAXRqrdSu0S9/j09gbPIVvqcjqFDcZUuGljfZTpgOmsRp5jk1tFY3odw2W5Y+g7
         FyE4G0zjHsSFxSQN9TUScZpEgdBZFAmH9/Bqh/lP3Cufg96rt6JMMsKv8DnRVq/dKSJq
         0QnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uYgui4LcJCAu520X9XRPu73XHip6FUKmXdkDEHt9sf4=;
        b=AbqIdKbKZ2QPZ80TuPuDvZHlk2kl+bgoaX0jwvPcTX8Ay/K/BqesJLW+jq83Shrxen
         AdkncEJH6mv8yvGUQKErC0wAzXpYYW425eXuevbv3DlS/87ouBvWF5hrpVXOpTGBq9TM
         FG5mGMtFXkA2OBbJumo15+oXFYbItp29CPEaWRP5gpJMyVgBJpWR6YXqv7aVG/s+j5jQ
         gYe0tG4Ef4NhZCKa9TxTRfkxp/Gr7QY3Cdaj6Mq9rvKb/YtGGMcGzo3FI0KJxZsg/wDo
         tsoCpyUDEFaaxCSHN8WjxeEuRGespMWSdn0XFCFNcLH3pWviZzyxMj1tKXt32QKaXGHu
         84Fw==
X-Gm-Message-State: AOAM531jf46O0D0YbTc+mP1W9V4EQ0a+lFUzEjSSQSMlHaEl8vlI3dHo
        TJ49mlNlHMeztZmZDlp5JIvteuAzLfjFB5xlysM=
X-Google-Smtp-Source: ABdhPJxGrZ3uK2o7zBGwJFbwOUMIqY2Gr1+8SNaYVvaItj5OgelXf3WnAMO9FMgcvi9tN2iVM+ZUHg1aJ2eifFKiBEM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:9ea6:6c27:1876:926c])
 (user=samitolvanen job=sendgmr) by 2002:a25:b309:: with SMTP id
 l9mr1016589ybj.188.1634149035299; Wed, 13 Oct 2021 11:17:15 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:16:49 -0700
In-Reply-To: <20211013181658.1020262-1-samitolvanen@google.com>
Message-Id: <20211013181658.1020262-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; h=from:subject;
 bh=5DShhAajwjmzrfSwj/lEi4XSN+JegxsOm6BWBdFck6I=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBhZyKZKs7Z8rJfh+XBswnV4fhruJzNX+jRaxkL1iyj
 4ScskumJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYWcimQAKCRBMtfaEi7xW7tp1C/
 9Z/6X7sYi+7RUoe7jG9LbKiOnREua/5UZWNkOXSEymJa7LVemcvOMNsKyEOC9bP9A0M+qJEVqWg4M4
 pLHVLlgAolDCiMSiDi3FPL5L8flnwyZWd5n7gonK6/ixYUGBU07O9ESMM+dZJSH2IpYq30t5Ghke9v
 W0FINWJcXfxur39c0c8U29feQjsHKwm6daEajkBJFJd9PcfQRbIKiou77cVkOkmmNSG55Q5Ab3Z28E
 ZYPXpA0btI9EAdOu89pUqJw3rwmxn/Ni+5iSv/zvw2j86xgcxIaOsIViRTjFZgH18zW64DlQwLkOtt
 /PnM9fWSkZuUNii0yPNlfB3o5yDP4RJkn702PeCmhecpcwbFQm2DYaWR63yCDMQ0859YTZ5TY6hMU6
 myaumMSkRFZo4xTPI3ND4PwssMappyQY0FKvBNEO4gCatylLrEQ8IqeFO2/YhiwSfWna7zqlWQkZUA
 u4UYby5V6XzqSjO5dmP3oV2fXNlw41TzefnqDCZqdQOxY=
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 06/15] ftrace: Use an opaque type for functions not
 callable from C
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

With CONFIG_CFI_CLANG, the compiler changes function references to
point to the CFI jump table. As ftrace_call, ftrace_regs_call, and
mcount_call are not called by C code, but are trampolines injected
as calls replacing the nops at the start of functions added by the
compiler, use DECLARE_NOT_CALLED_FROM_C to declare them.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 include/linux/ftrace.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 832e65f06754..c53a00b96ba9 100644
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
+DECLARE_NOT_CALLED_FROM_C(ftrace_call);
+DECLARE_NOT_CALLED_FROM_C(ftrace_regs_call);
+DECLARE_NOT_CALLED_FROM_C(mcount_call);
 
 void ftrace_modify_all_code(int command);
 
-- 
2.33.0.1079.g6e70778dc9-goog

