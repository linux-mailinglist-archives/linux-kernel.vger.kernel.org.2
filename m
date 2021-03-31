Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7B534F727
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhCaDFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbhCaDFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:05:30 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C682C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g15so13548628pfq.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=br6Q9nB7EzUYGhvzSIch8sIAGewUeFhxJoVc038K6FM=;
        b=PeADhDJNiRgIOEcF+wkSPzMcbbUX6gZBKwZAQSjLdgUMl5KM6cQaPet90MQdmPSCyn
         iGsR23rROUHXJpqZs624kHtm7qVmf506UE+nRNBUhWSDl0c623M4yn2B8R/SJUkvsBpp
         iMbF2LCL6lbsP8ROhLrMBJmB3Xv2yYGcBXdLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=br6Q9nB7EzUYGhvzSIch8sIAGewUeFhxJoVc038K6FM=;
        b=nhJDlhnzYSzA6QFStFyhmT/8E2vjErTlUgrCMfdNDWSEZMl/EdmCzRCF1DM9hlLVwv
         HB1JMM4waALBU8ADGbO+HXPjrADwTdBpEmkP2Kjj4XCgMCLY5sjMe2wJiOGd8KzoOdqh
         c2CmGtYRjJqjk25YK3ytmpGJXgSkz1aVmtEn2THNTRqp7qoPhQ5+b/H4oSMh4Q7PvkO3
         RvxYQdCdUjeMerqCv3Vedalp0TjaXqsgc1deihlSrpyfMq7IHkga5Fmw9h0qcOCxAlzq
         AXeZOvWczJt+evtoaW4Eb40Y7uL00JXC/6tNtaM0p9Q38nYB8/toB2XZ86u2bkKx17hC
         oy/Q==
X-Gm-Message-State: AOAM531I3IPgXNmlsbRySPjbcBZ46b9Q4HZe8t40DSvNHPjh1yBryTi4
        EDgQAOYk8mXlIBEDMVgifLo5EQ==
X-Google-Smtp-Source: ABdhPJzm0de/jGzfHBMBvV7eJXO4k4Msdp6jIUDaWhAN21Pxga+BrMA4W7QvoRXtC7recrv9I7fjyA==
X-Received: by 2002:a63:3744:: with SMTP id g4mr1089520pgn.387.1617159929699;
        Tue, 30 Mar 2021 20:05:29 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:c8c2:b814:df0f:253f])
        by smtp.gmail.com with ESMTPSA id c6sm389024pfj.99.2021.03.30.20.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:05:29 -0700 (PDT)
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
Subject: [PATCH v3 05/12] arm64: stacktrace: Use %pSb for backtrace printing
Date:   Tue, 30 Mar 2021 20:05:13 -0700
Message-Id: <20210331030520.3816265-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210331030520.3816265-1-swboyd@chromium.org>
References: <20210331030520.3816265-1-swboyd@chromium.org>
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

