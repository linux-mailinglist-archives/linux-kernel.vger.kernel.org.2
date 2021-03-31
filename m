Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE96034F728
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhCaDFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbhCaDFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:05:31 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7BBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:31 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id l123so13513977pfl.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mpMmDhY+dCpZ19xacYYKQOde4316qnbnc7ljrLohPKE=;
        b=Ver8reiPZMpiyLCuRsv1l+OLOUVQQz+1AVoVQx07SbSwxc0DEbf00Z5jlSHnLSkTnY
         rtI7YRvtpWE09kxM7dHdCjVyAqeMp50PBIXSjcZKfNDh8PCfUXbnyLpB4qL3RLlJByVn
         MHmHACZL1kuKSyRQ/chtMzmzEhD2oHHB6rRsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mpMmDhY+dCpZ19xacYYKQOde4316qnbnc7ljrLohPKE=;
        b=bW0ffmUZwh++olKG+I8HK9Ht2SazMUpFm9ig46PFiH7qE1QWnqjX9Ripg5LBhXTlqb
         7secwJaax7Lq0uwNPgIrKMCjUIsdli/pUgeAT5kBWw5Ukx+8RsDJlkmVObnvlrFSz7ti
         2qXpZqIh8ogP7rU3zg7eKQNanj5SYJH7cfh6x6xvgI+SrI4BPZs08ON8Xpz8obnzsNZC
         b7sh9oUlvfqGOzxC8JLChmmtlZTF7ykJH+kgp5jybL594IXQFVifOpIqjj452gvHgMbR
         yWn46Vy0JteKeNKRcoovAJmi7rgXpBaf0PSvxNaz9KS4xK3PthP0+B2NOqU9UvxIsYe3
         sNCw==
X-Gm-Message-State: AOAM530XznUql5OAY60F/URUN4U36nGqQ/mBORaXqzKz24StCNn1LAhv
        /PEccfbGYrMgoj+4CGGmwBN+JQ==
X-Google-Smtp-Source: ABdhPJyJx2npVrKvtFfocELgGN1prwFx/P+I7iSdtbgt8/1SE28RZtfmZqzLT62lHv7BFhAbx7xl4g==
X-Received: by 2002:a63:ed12:: with SMTP id d18mr1177504pgi.20.1617159931148;
        Tue, 30 Mar 2021 20:05:31 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:c8c2:b814:df0f:253f])
        by smtp.gmail.com with ESMTPSA id c6sm389024pfj.99.2021.03.30.20.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:05:30 -0700 (PDT)
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
Subject: [PATCH v3 06/12] x86/dumpstack: Use %pSb for backtrace printing
Date:   Tue, 30 Mar 2021 20:05:14 -0700
Message-Id: <20210331030520.3816265-7-swboyd@chromium.org>
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

