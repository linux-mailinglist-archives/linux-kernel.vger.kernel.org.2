Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF20C3661C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbhDTVu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbhDTVup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:50:45 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168B3C06138F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n10so9286842plc.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TgjLxTMswgoGuX5Ufpd99mf4WDXQ7EH22iq7Xe02XNg=;
        b=ADzfPOozkAyPGGkprom2jYtHCQwH6uB1cl0/Z+8TbX+7HImHE4WHLpNxw6M8aIx9FA
         7wRPPnFQT87XvfdZ/kCEuPm2w4Cq1lDCJ9PnLvhiyYZdgpKbpD86kSKKmbHaFFgfpAIB
         xMD6Bqyefxk0KdY7+oRIlSKLLna05jDv/u910=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TgjLxTMswgoGuX5Ufpd99mf4WDXQ7EH22iq7Xe02XNg=;
        b=WZYlvYvL01jt+rJpGzibUEUCo1G4aUOdf6BjEJily+gfPm6gufQNbkVVZ3bbdRFXtb
         GX3E2yA/0Fxh2YaDAw94kN9K6RQjRZon1fS1oqwcNCcP/bzypsBF5/ea7uC+GlWpGxJ/
         YJ751X5bvvjG1oZNaUn+YmzCwAxw8iqHYhPNup7o5OboyDKZc7EB6Hco1MDYI3BilxmR
         2JyTrh6lb44RceGhSCR106oo2iz3xfB9XYPNQRIOBfdnTHWrINCFR9Y+zBav4qFlaSGz
         Ohg783+l7ogEFWEpuj16WhubPW3mxi2RPoZ1pH/Zibjpp6t/TGeaZX1LSG5qjJSBJK7Q
         /5sA==
X-Gm-Message-State: AOAM530io+dg6WQtgdrvNimLtFJLN2aKmeUiw+T1Mhk1XtL6GsOLBkZA
        Z1n+9PRHcdwdiGgQDno93Zd9xQ==
X-Google-Smtp-Source: ABdhPJyYSt/sp/vHAPAJ0wTY88n203xox8pvJ907wdKtGaU3egQTlP7ZTjlkH6j9/lBlPwBpRsB/Xg==
X-Received: by 2002:a17:902:64:b029:eb:1827:de61 with SMTP id 91-20020a1709020064b02900eb1827de61mr30793889pla.32.1618955410684;
        Tue, 20 Apr 2021 14:50:10 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:bf8b:4b8b:2315:3719])
        by smtp.gmail.com with ESMTPSA id c21sm31481pfo.91.2021.04.20.14.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 14:50:10 -0700 (PDT)
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
Subject: [PATCH v5 07/13] x86/dumpstack: Use %pSb/%pBb for backtrace printing
Date:   Tue, 20 Apr 2021 14:49:57 -0700
Message-Id: <20210420215003.3510247-8-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210420215003.3510247-1-swboyd@chromium.org>
References: <20210420215003.3510247-1-swboyd@chromium.org>
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
 arch/x86/kernel/dumpstack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 299c20f0a38b..ea4fe192189d 100644
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
-- 
https://chromeos.dev

