Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7626C35AA0D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbhDJBxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhDJBxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:53:22 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786B9C0613D8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:53:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d124so5353177pfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=br6Q9nB7EzUYGhvzSIch8sIAGewUeFhxJoVc038K6FM=;
        b=TP/ej0A5oIbB+SZtsRxku6ynn0XFhltYZbU946pbzvENIPryBryzlCL8OsXZPO5/39
         5wp3q/GEB1X8Vec131bV1WM0mwViEIKK3qoyRIirnHyTnuEvIpGVUefSgMxW8FVaiD9H
         IDhSM2hT9uM40D9RHJWn5U6LOvPEUXG0EI1M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=br6Q9nB7EzUYGhvzSIch8sIAGewUeFhxJoVc038K6FM=;
        b=GFje5/g1vjTe6Md6HJfWxdvQXH8FzHgcmlP9eij+C8RW+SVPfnCAQW5y8EE+BnGigH
         7OYwrLkrKYeW2ti/8Wa09towtxsQ6u/Ngmdkb/OpoFvHugKpuu5GWPEgrMmnAuug+Z4o
         PJJOR/oKwq27atVkFxd8psl9t1nWtGT+yYs7e2yU/AqbKH0rnWXwlLSlPEKnMT2D+vz9
         7dhAilI1x70GEreSF3GlJvxDp5FaABSfUryvZVMxZ8V/ywN2AnC0AoETskZmjLg7nk4s
         sUPT621pPhUT7G05QAiTfwMWHNVOQ4g4U9tPDASaNoElgq322WXWGhDiDx6nSOSBB3HK
         1rXw==
X-Gm-Message-State: AOAM530luXpyDJf9A2M1kS3+7lA6BJRTL2p84kUD8Jo6ayEClBzg5zzI
        Kf09vLFFRaIDIccMp2vRlTXznA==
X-Google-Smtp-Source: ABdhPJw8ZEAEA342lhXIwD1tc1lC/gFPTrsFOOLwwizGLOeyoEtQpg+N0r26bdjfaqGjN5mMFbargw==
X-Received: by 2002:a63:1820:: with SMTP id y32mr15990639pgl.157.1618019587023;
        Fri, 09 Apr 2021 18:53:07 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5141:7881:7013:743b])
        by smtp.gmail.com with ESMTPSA id n23sm3837962pgl.49.2021.04.09.18.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:53:06 -0700 (PDT)
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
Subject: [PATCH v4 06/13] arm64: stacktrace: Use %pSb for backtrace printing
Date:   Fri,  9 Apr 2021 18:52:53 -0700
Message-Id: <20210410015300.3764485-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210410015300.3764485-1-swboyd@chromium.org>
References: <20210410015300.3764485-1-swboyd@chromium.org>
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

