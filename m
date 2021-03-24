Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C932A346F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbhCXCFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbhCXCFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:05:01 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DF9C061765
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id m7so13598811pgj.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=br6Q9nB7EzUYGhvzSIch8sIAGewUeFhxJoVc038K6FM=;
        b=gCj9wu0DPQF3nxAjDePTGT6o/I3+3MFaoBuS0S8SRkHISCvcx2hCBGamPTxp7WSFkC
         yb2AgkaKXYAtLhlAABCIWTa2wJ7QKwWFeS0WDtlpZsM/3y3vCZpvdNjeczYqN1c2rDxR
         NhhB9N90GDPUbtPYn6wJKwLWxWw3dM6N5grf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=br6Q9nB7EzUYGhvzSIch8sIAGewUeFhxJoVc038K6FM=;
        b=XATRqm/qHFTpeAkv9t8XVu7AGGW/z7LfTAi4zfw8SDSfi08gfZuiPoOT4z0VrvQ5pn
         txo9aQmsT7jnUPujwlThpUjdQzwKWDwF02niA5R5AhkcpwUWzVeQFIvJN2m8/eCSueYL
         shLDZrV8+5CmdlqDpFGECLf5bktja4rM4N2vQdbTYE3seFwhccLYkouOlfGF9Lvq7uxI
         5zf3nv3AuhKt8d+2FgtXB2ZLCgxP7uQySTxUD1Z5W4oxq8vMZJtxGrZpZn839vGs7Y2S
         UlAKINiwsajb+deRE34N2M46u7UUGONWGnXfzITQh8NHYhh2N0raz4yAgusmzyHnJR9L
         wuBA==
X-Gm-Message-State: AOAM531c53PRQSAiG5xcvPtpjTDnaKRqJKfSGvGgYbPY0Mjz16w8Dfmy
        T7WpRv6T5Z8QF7zKQY+/8dPksInmOXWx1Q==
X-Google-Smtp-Source: ABdhPJya/tUfqxOxrzzqmFmGwgYqGsx9kpRcIhIF5cAHE/qmNC2FD8WYBf/aeveCHq1MxO1+5L+awg==
X-Received: by 2002:aa7:8ec4:0:b029:1ee:f581:ec12 with SMTP id b4-20020aa78ec40000b02901eef581ec12mr966245pfr.0.1616551492667;
        Tue, 23 Mar 2021 19:04:52 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id b3sm389441pjg.41.2021.03.23.19.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:04:52 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 05/12] arm64: stacktrace: Use %pSb for backtrace printing
Date:   Tue, 23 Mar 2021 19:04:36 -0700
Message-Id: <20210324020443.1815557-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324020443.1815557-1-swboyd@chromium.org>
References: <20210324020443.1815557-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use the new printk format to print the stacktrace entry when
printing a backtrace to the kernel logs. This will include any module's
build ID[1] in it so that offline/crash debugging can easily locate the
debuginfo for a module via something like debuginfod[2].

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Link: https://fedoraproject.org/wiki/Releases/FeatureBuildId [1]
Link: https://sourceware.org/elfutils/Debuginfod.html [2]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index ad20981dfda4..9d38da01ff98 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -129,7 +129,7 @@ NOKPROBE_SYMBOL(walk_stackframe);
 
 static void dump_backtrace_entry(unsigned long where, const char *loglvl)
 {
-	printk("%s %pS\n", loglvl, (void *)where);
+	printk("%s %pSb\n", loglvl, (void *)where);
 }
 
 void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
-- 
https://chromeos.dev

