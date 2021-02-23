Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDFE322A40
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhBWMFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbhBWMBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:01:17 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EDAC061786
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 04:01:02 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id w18so6537797plc.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 04:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F7VAQChhyRdzHQZeRZYrhZFLlVoxDoMdKmK4VaSa46c=;
        b=fdFJek4WxVN8fA8cQBiI59rKJ3FEwD/pBnuk2rsyiEJ3nppIPe14lYGIT5AscuqVWI
         7ee6tiSPX4vut1Lp0MOrUSUx/q4Jn7jEV0IYGkpLMcznJsW+p+1sxuENkRhC4u1GvdRR
         pjR0ycAVuSzlkSM/CrbGAPLNZ2FBzCGKUSMax9sBgsTW+wQSkbgKp907UQ/T1u5p93NO
         sF4djevOM9nFtBZ7fXJGRzYij2PySPiuJXmDRkbwxclbj5SDOTv2UGCT8YB1SAwjvRrC
         vP1neEWh8uG6e4Pfj+09Wg7tynJY3hrUwmGQAmwCgGxuTJ0ibDxQd5XJRQP56Qj8BugM
         wjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F7VAQChhyRdzHQZeRZYrhZFLlVoxDoMdKmK4VaSa46c=;
        b=oDWoj14wr4QtJJq9h8Msw+TqDcZnprg1EDzUqb39yxnj1o4wbhAEH436CIeTvxCcO5
         SHiznSQxznTjmAhn/BnoCE9Hu6w84wo+WayTOHOzhxB5D9dxSau2Jm4irLrRIN2Q0t7A
         k0nw+IHZKkBb9Un+zzJiK3mumgUI/Dzw8nN1m8/F2wRY5sQgwWYyLmBo7R+CkXF+qW1s
         ztMQxdo4eU0QMIJ5pwzIs5VQEnXXWp9J/aGOsYFomb30oR0riA2n54zVKup8xCe23bLK
         GseocJjLTLTWtTLr5AIBeKpFvHhpTRHS+rbpislgD0ee66owTJg+G0tTp5o2xkWr+CKk
         NDiA==
X-Gm-Message-State: AOAM531m8C1El9RMW/aVtDvjIRWXz+zRizhJBOeyBpX0ypvBSxIIOfxL
        uxi+LEo0iLE8LV9ymSzin5lxAQ==
X-Google-Smtp-Source: ABdhPJzqR78TU+4ycFQRa54C6Gm0zUOePm0Wck15JRagUJdy2BdFjZyVAW6bwVCW05WjhPx93JsbeQ==
X-Received: by 2002:a17:902:7592:b029:e2:e80f:6893 with SMTP id j18-20020a1709027592b02900e2e80f6893mr27417060pll.61.1614081662147;
        Tue, 23 Feb 2021 04:01:02 -0800 (PST)
Received: from localhost.localdomain ([122.173.196.104])
        by smtp.gmail.com with ESMTPSA id o127sm15730412pfg.202.2021.02.23.04.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 04:01:01 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     daniel.thompson@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] kdb: Remove redundant function definitions/prototypes
Date:   Tue, 23 Feb 2021 17:30:45 +0530
Message-Id: <20210223120045.153208-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup kdb code to get rid of unused function definitions/prototypes.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 kernel/debug/kdb/kdb_main.c    |  2 +-
 kernel/debug/kdb/kdb_private.h |  3 ---
 kernel/debug/kdb/kdb_support.c | 18 ------------------
 3 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index b29f7f375afb..2b9f0bb3542e 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -410,7 +410,7 @@ int kdbgetularg(const char *arg, unsigned long *value)
 	return 0;
 }
 
-int kdbgetu64arg(const char *arg, u64 *value)
+static int kdbgetu64arg(const char *arg, u64 *value)
 {
 	char *endp;
 	u64 val;
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index 12d0abab73ee..99ec64cfe791 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -103,7 +103,6 @@ extern int kdb_getword(unsigned long *, unsigned long, size_t);
 extern int kdb_putword(unsigned long, unsigned long, size_t);
 
 extern int kdbgetularg(const char *, unsigned long *);
-extern int kdbgetu64arg(const char *, u64 *);
 extern char *kdbgetenv(const char *);
 extern int kdbgetaddrarg(int, const char **, int*, unsigned long *,
 			 long *, char **);
@@ -209,9 +208,7 @@ extern unsigned long kdb_task_state(const struct task_struct *p,
 				    unsigned long mask);
 extern void kdb_ps_suppressed(void);
 extern void kdb_ps1(const struct task_struct *p);
-extern void kdb_print_nameval(const char *name, unsigned long val);
 extern void kdb_send_sig(struct task_struct *p, int sig);
-extern void kdb_meminfo_proc_show(void);
 extern char kdb_getchar(void);
 extern char *kdb_getstr(char *, size_t, const char *);
 extern void kdb_gdb_state_pass(char *buf);
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 6226502ce049..b59aad1f0b55 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -665,24 +665,6 @@ unsigned long kdb_task_state(const struct task_struct *p, unsigned long mask)
 	return (mask & kdb_task_state_string(state)) != 0;
 }
 
-/*
- * kdb_print_nameval - Print a name and its value, converting the
- *	value to a symbol lookup if possible.
- * Inputs:
- *	name	field name to print
- *	val	value of field
- */
-void kdb_print_nameval(const char *name, unsigned long val)
-{
-	kdb_symtab_t symtab;
-	kdb_printf("  %-11.11s ", name);
-	if (kdbnearsym(val, &symtab))
-		kdb_symbol_print(val, &symtab,
-				 KDB_SP_VALUE|KDB_SP_SYMSIZE|KDB_SP_NEWLINE);
-	else
-		kdb_printf("0x%lx\n", val);
-}
-
 /* Last ditch allocator for debugging, so we can still debug even when
  * the GFP_ATOMIC pool has been exhausted.  The algorithms are tuned
  * for space usage, not for speed.  One smallish memory pool, the free
-- 
2.25.1

