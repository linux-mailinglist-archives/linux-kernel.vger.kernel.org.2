Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1C83661C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhDTVuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbhDTVun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:50:43 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C468C06138E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e9so3453604plj.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=br6Q9nB7EzUYGhvzSIch8sIAGewUeFhxJoVc038K6FM=;
        b=Ec+7pf8QFOQGETswMvOwtCRnFSRRBh6lgonx4jun1dk6+8y4PtaKE2ursXiRrg09fb
         oaXLDuTuNy5OI63T9ZRfLkbe6d9Jiccq/+/AViB8L7ikRzkcy2FO2GXqXL9w7nesdi/K
         tvVxkFehtsUBOhsmh2vqumM4MHbE1anmyBtjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=br6Q9nB7EzUYGhvzSIch8sIAGewUeFhxJoVc038K6FM=;
        b=RDpza5kdMTgr5gpgVnLLP+QRx6ZPemOAej2UsRI+D/PV9TNL5sfUZHIARbnNrJkYd1
         pTALumiaNqFRkLnxBYVUNGM2HyxuF0GeiU3WcT6n86L72e+pIlK9oIUmNEBqfO0TuSQT
         tQ/EZ4HZ/OE59VXHAPzWS4DXHUw6s2yiBJJzkS037lg0qw9l+V47M6jJP1R9JlZub7cy
         QsNCo7LnhcNSPuONNdjIPavzBgP1ypvLsYohtE+OydhdQi6waLhB4rQzS8aXrSb16hFh
         lz4izzKzMimilHSHIZR6G4qkb9Lv9rMbSDH/Nar+zdmzMnFAc4mY8eYa63gD4XLC115X
         urBQ==
X-Gm-Message-State: AOAM532sGVBH3MA6Y13JTrPWZRRNmOJP7cFix0D1QDuv7LQKkgXFvBRB
        5LXZqbLIF5xDc/fVzKPxeSVaBw==
X-Google-Smtp-Source: ABdhPJzuTnBpFyGRqoJZe6cfnkCyoMW/W7XlUttLH2iWotczB0vRzufkAo6PBx/lCSNDhKMfGxFErg==
X-Received: by 2002:a17:902:70c5:b029:ec:9a57:9cc8 with SMTP id l5-20020a17090270c5b02900ec9a579cc8mr13011264plt.73.1618955409659;
        Tue, 20 Apr 2021 14:50:09 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:bf8b:4b8b:2315:3719])
        by smtp.gmail.com with ESMTPSA id c21sm31481pfo.91.2021.04.20.14.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 14:50:09 -0700 (PDT)
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
Subject: [PATCH v5 06/13] arm64: stacktrace: Use %pSb for backtrace printing
Date:   Tue, 20 Apr 2021 14:49:56 -0700
Message-Id: <20210420215003.3510247-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210420215003.3510247-1-swboyd@chromium.org>
References: <20210420215003.3510247-1-swboyd@chromium.org>
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

