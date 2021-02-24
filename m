Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F413237CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhBXHSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbhBXHRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:17:50 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50979C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 23:17:10 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w18so750135pfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 23:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QWrzEO3vpVCf5FK/cLz+7/4GrMfblEPP8ih2ftpKZGo=;
        b=YW9ffG57wFa5TpHjzfIMGUpi3ZaxjBFGnW0u6piVOCt/qdVsn8PMkIjZ4oNr/fPMKz
         ZcexCRjXxW01Mj9sgGyqlTVym0BwpiJNw8DK6j6eZI8zUWwgU9UVERN57tWaDfRrkfie
         5y2KIfKaKTuTqTwL8kBjgydZybLCaOxCQxLIVKSiNuq2s8klGIUBZA9RE+1Fks3Rw+AV
         eDGUNZW+be/Z+1EGnkAEFYU4ZNoP7s0tdiOgZ63DckEbGoPRMVJAIIA8xNRXiPXQAhtg
         P93UGYDAx6IU4+rkkNEN+2vQUhDEDQtAY2Vu3O11VJ1rGs7EqQEWkpS2/6cpKOD+yCok
         rM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QWrzEO3vpVCf5FK/cLz+7/4GrMfblEPP8ih2ftpKZGo=;
        b=Xx5gr/aTakW2a6V7Ai3lQMrWIjBKUQ+UxZu2KMSzoa30yTYeq1RVrlH9fApH5dMelN
         u/UcG5DYgMfb7QCXnUYCfUN/e4CPnGCStFVPeYYRVX8fyzfp2F7kxBH0bUHim6Pw7y+u
         cuUPOdRMqgbbg7gScO+KIBIZEjshivG3ACINB+C1yQssStK6ME9k7vPxjVyNygakNX9R
         n1z/DMLFPsNT9WgM1vkLh4Okx8NMRIWSRBW+tF2xBPN8BDOQ/399Ac6mwnQen8miGPRE
         m/XXeM1baBzo+mLEpn+rp0v9Gdw5NSwt4J7Zc30g4Y/2smc2o6/5SSBLOBoOUgHJjhJO
         jQYw==
X-Gm-Message-State: AOAM530GUTE2gMBETScBoU9QcqUYkUuL8cgklZjDMzy3DQu9aIZCgNr7
        0/WzTQbHPuLlkIPdtYmVZ87HVw==
X-Google-Smtp-Source: ABdhPJy3sPqLQXBn1Xlw856Q+THVhqkHroWqwIm50WHXVhRz1KbHgdbl8AMJYpSBgpFQpw7asJQpYA==
X-Received: by 2002:a65:5b43:: with SMTP id y3mr28298302pgr.415.1614151026770;
        Tue, 23 Feb 2021 23:17:06 -0800 (PST)
Received: from localhost.localdomain ([122.173.196.104])
        by smtp.gmail.com with ESMTPSA id p1sm1488619pjf.2.2021.02.23.23.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 23:17:06 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     daniel.thompson@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2] kdb: Remove redundant function definitions/prototypes
Date:   Wed, 24 Feb 2021 12:46:53 +0530
Message-Id: <20210224071653.409150-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup kdb code to get rid of unused function definitions/prototypes.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v2:
- Keep kdbgetu64arg() the way it was.

 kernel/debug/kdb/kdb_private.h |  2 --
 kernel/debug/kdb/kdb_support.c | 18 ------------------
 2 files changed, 20 deletions(-)

diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index 3cf8d9e47939..b857a84de3b5 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -210,9 +210,7 @@ extern unsigned long kdb_task_state(const struct task_struct *p,
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

