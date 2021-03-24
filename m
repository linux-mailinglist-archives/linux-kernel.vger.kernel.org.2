Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC448346F35
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbhCXCFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbhCXCEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:04:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7C1C0613D8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id ay2so7100990plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xySi1eigssqYWy/eI4nZqzgttEYEQuYi6sWqKVX3Vec=;
        b=i06PGAqKhKGnGL6DOprRHrG8cbw57RqexRyr7W1bsK6A2cQoC6Seb3phQYzeeD3Tpc
         qylhS9HcMt+GntxZmYAegSC7WQwPzogsxoKARTxRcBVffCxWf/lh8GyCc62vEJCEo/Ga
         RR9pzYJIJtwRbfUD6Y42AVWruzwO3qQXt/l2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xySi1eigssqYWy/eI4nZqzgttEYEQuYi6sWqKVX3Vec=;
        b=GYO0kYDOjVSDr09MzIxItban3c+ZXeamtJbLzD6ocsOYUbZeozRxGoY2ecwgkCibAv
         H9jl0UiBe0/Wa9iqzbXpPmojpR6zTZ6TKdXvdyhidPwbmuiu5EciXLd5E4xxYtTJEXoa
         UG9aeY3V/o8W3a31MwI7DXNcW+Y/1utv7tvNrRmLwfLTE1R9R7znZHfTyl6bWv8F//J+
         7sq+xRa1QFhp7kpFbrMg5MTr1BbWlYvHVGbpt0GYPyVAF+YZIYFKfr17y1GFkAM1Vzf4
         ozHBBJOouktsfsYcpRM7aOOP3qKmRQzEoRYcHHe/Yn3qLas8LXMS5W9U6dRsXgSDAxSF
         yDIg==
X-Gm-Message-State: AOAM530JajYv2cGTbfwiXjxJioP6IfmKvi9pqP4wIqGpn3P6MZSEKRra
        tfonsy6PP7yvYm4xsmMEdWG43g==
X-Google-Smtp-Source: ABdhPJz4UpE4ksB09Ayuuf7HNSQXgsf6F0yQO+3RbRtsuQxUUJlLyQxrQhf5+GWyX/CcXGVPYN/bcA==
X-Received: by 2002:a17:90b:291:: with SMTP id az17mr921631pjb.206.1616551494041;
        Tue, 23 Mar 2021 19:04:54 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id b3sm389441pjg.41.2021.03.23.19.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:04:53 -0700 (PDT)
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
Subject: [PATCH v2 06/12] x86/dumpstack: Use %pSb for backtrace printing
Date:   Tue, 23 Mar 2021 19:04:37 -0700
Message-Id: <20210324020443.1815557-7-swboyd@chromium.org>
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

 arch/x86/kernel/dumpstack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 299c20f0a38b..7ad5eea99b2b 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
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

