Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C165F35AA0E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbhDJBxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbhDJBxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:53:23 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A230C0613D9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:53:08 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id n38so5399256pfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUQWTfijg1cAUQuQg/jqN0uOSlJ8iwcYRlNSG9SB/TU=;
        b=AIimY/rCAR/aUWtyJ2t2wANiXe5VkUMQQRwEdSCBWnpGsuTrpU/1oWHRYh43EjJufx
         Jfp2DqV/P/OGOnbF79EMEEXn09OL/zvW/53bWaOy/DtnItf2rLdhlvNLRrgWCsPXStC+
         eueFlyJfKD+73OdUruEkMIGCm4joo4Yzugkis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUQWTfijg1cAUQuQg/jqN0uOSlJ8iwcYRlNSG9SB/TU=;
        b=Ib/UBonejCGEtX2yZ1XVMq0rqe8lbWzsqN27HQN6YrtnMfbfa5PHF6mImjID5kqB/D
         QQlQHNQuuzyCBIg1btpymcePo1KzM3TUW5iBImY8bXspauOrWyiCvT29/5fPcgGx8fcZ
         1XuSFJPnYnINccfVB4V+tykry1J1NBTVL3shWHqXxtGQyYJ+CZhjBiwCgzK9+kVB7XAI
         Id1HFOayeq7NbYSkg0lPg4/OtuNRxBeOMr37DPE0cp0HHNUxuo4QlGH+/UrCcoR914aF
         BkyQ0F2+XzLzhFP0K2343utdOV8XRZVo/heQYFhdBc5gJxNOkXVOTioYSBKPm3xIDihH
         QOWA==
X-Gm-Message-State: AOAM53201N0HReMm/Hz6D2dlGc97sVwmjxjKmpd8FVrGXaixPyAXtR6g
        xN2yRI83fPDhho3Axt8H5GodVw==
X-Google-Smtp-Source: ABdhPJwKZMBcsAc59YGHuABKAPfV6l4KYnqWQf4Qp8UlVb9HwYa7Tz+TCtM5emHDoukIUiQ+vxi3fQ==
X-Received: by 2002:a63:556:: with SMTP id 83mr16381598pgf.436.1618019587880;
        Fri, 09 Apr 2021 18:53:07 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5141:7881:7013:743b])
        by smtp.gmail.com with ESMTPSA id n23sm3837962pgl.49.2021.04.09.18.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:53:07 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 07/13] x86/dumpstack: Use %pSb/%pBb for backtrace printing
Date:   Fri,  9 Apr 2021 18:52:54 -0700
Message-Id: <20210410015300.3764485-8-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210410015300.3764485-1-swboyd@chromium.org>
References: <20210410015300.3764485-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use the new printk formats to print the stacktrace entries when
printing a backtrace to the kernel logs. This will include any module's
build ID[1] in it so that offline/crash debugging can easily locate the
debuginfo for a module via something like debuginfod[2].

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: <x86@kernel.org>
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
 arch/x86/kernel/dumpstack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 299c20f0a38b..be2de39bf16f 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -69,7 +69,7 @@ static void printk_stack_address(unsigned long address, int reliable,
 				 const char *log_lvl)
 {
 	touch_nmi_watchdog();
-	printk("%s %s%pB\n", log_lvl, reliable ? "" : "? ", (void *)address);
+	printk("%s %s%pBb\n", log_lvl, reliable ? "" : "? ", (void *)address);
 }
 
 static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
@@ -143,9 +143,9 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 void show_ip(struct pt_regs *regs, const char *loglvl)
 {
 #ifdef CONFIG_X86_32
-	printk("%sEIP: %pS\n", loglvl, (void *)regs->ip);
+	printk("%sEIP: %pSb\n", loglvl, (void *)regs->ip);
 #else
-	printk("%sRIP: %04x:%pS\n", loglvl, (int)regs->cs, (void *)regs->ip);
+	printk("%sRIP: %04x:%pSb\n", loglvl, (int)regs->cs, (void *)regs->ip);
 #endif
 	show_opcodes(regs, loglvl);
 }
-- 
https://chromeos.dev

