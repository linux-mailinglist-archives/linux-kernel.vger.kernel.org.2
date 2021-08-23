Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BAA3F4F15
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhHWROT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhHWROO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:14 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFF7C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:31 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id m22-20020a05622a1196b029026549e62339so8946296qtk.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y1wIG3cVmpd4xa85rFblMllcZ1GkvMzjnLxgyrp1PBQ=;
        b=UR5N0BFHElSUkBSQFS7IRnWg9ye3xqrC5uWs8Q58L6k3/X1XKRNrA0b6ehi0z1pnnh
         ukv2NIX/yGhQHUQBIEnDv1+cIrOjwfFZSQ637+UhTmgo+C6lB8E4467KEsleaRyVuf8l
         LPm0vmMrIjXRI57/Cv/NSIuPQrsNU2YNe+BpyduzKpebsO4w79niuksN+bCJ7kh4+OXF
         gJIXP9xP7N6dZ5l1Y5lsws/L8BqOlJZx7r9BC2EaX5KnKiaZWGztILBnY2O1xs/dtFDa
         JcRF7rBXaSKygF4C7yECJgsmhIToViDgDVHmiSMFeskY7MXNZ7If7xfI+TUGfPl3JQNh
         KLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y1wIG3cVmpd4xa85rFblMllcZ1GkvMzjnLxgyrp1PBQ=;
        b=oFjXJXCFOhYHyNAroLldAiasYMXhexTAABWiQkCA+kt1osRxNxaVYnMqm2O+lQX1Mj
         rfGaCUp03OvXtu6i+QWOhUQPI7OY4VhIEuDCduuDQPMRmWRjf5N5cogv+rc1N0XqV7ib
         8hUwEzt9vY+9wgsJGDb0uW0uEPrP4/24O7bqa1/EUra4vnJ+o9eOjAdpPkVJSQXJS0OO
         1bJoFtTPFJlU2/oztfRpsOn+43DUaQLpZHEMk4u2NIeeBf20mQdPU0NUP3gMMW6Tg6C+
         ktmME8vkJU9+zipyK7GZpxPG/LWVvMjKSTqr+AIjDpg/9ZPSb1+RXgX/EOGwC+QO8rqg
         h7yw==
X-Gm-Message-State: AOAM530OhNRj67kAGk5+IBJktjATg101mkHeBjD9BEWUyKfuK12KcVj2
        62/UvHm/YmXNEwstKseyaVEEgFrioH9NfRPyKsY=
X-Google-Smtp-Source: ABdhPJziyOvP+QWBDtSJeOoqGBazQWys1QijMPFocO7Y1Epuyme1bD5gJNucc356VALDlG5Je49i62tUqSF88NWcLqc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:29cd:: with SMTP id
 gh13mr33753444qvb.25.1629738810535; Mon, 23 Aug 2021 10:13:30 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:08 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 04/14] ftrace: Use an opaque type for functions not
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
index a69f363b61bf..6fdfbcc14608 100644
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
2.33.0.rc2.250.ged5fa647cd-goog

