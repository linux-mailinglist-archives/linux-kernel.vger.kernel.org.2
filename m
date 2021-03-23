Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4BF3461AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhCWOmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhCWOmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:42:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D9CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:42:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k10so27540963ejg.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BtJZ4piu7IIl49j+htoC0H5VXNoIO5TbTOYrZGWQSLA=;
        b=IpF/GJVRT/8kMvIQPSMJgs+jbWpMH1BPT5xFDejOLox/N068IccI/h2lFoaVGJgs19
         go3dYc5qBEilOOIgnLKirjJpGqkxR6mt6bvRbVxFdanGGw0kFpw/xui5NVTmEH8iKsp8
         fAOlhd2m8XXXwUQ5tbOFTS9Xkr3BfYq/bw000=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BtJZ4piu7IIl49j+htoC0H5VXNoIO5TbTOYrZGWQSLA=;
        b=COg16h+ybEIKhE9qUSZqdzADh+erorFBQf1C8xMNCdTF9PbN+HetzMn5x0Lsv0oyZp
         hhgPRWK4oiRqpZw8bywjHzSKxwzzuHyrUSOZn/HbJJ7gsfMKQXcyncqkDDlnExToak/7
         IRiRl2b5WrPpbWLssEE0NyH+DWPJL0g55AgJoZ2HNrNP+3JITokmI+ByN1Fz3gj/J2aa
         LvlPadtsplOml4a0W38+PC/fRNPnaAlPSEO3bX/N/kMbsGpKoBmXsg71iDuqZxEnCQYa
         wLo9OzujTRF3F03Ij0DQC8htsTV2dDvHPYzIJp/qqXCbYfJXDhnoS6BRrT9VUnJh8L2w
         uXbw==
X-Gm-Message-State: AOAM533P7aaqILsTNfhxM16mHjgGBGBzN9yLc4xJA3C5qv62Hhlmi+I/
        0xqBX95pDbTpR15MAaEftnVRfA==
X-Google-Smtp-Source: ABdhPJzUmgsojr1RkAl/LtAIqbmWcToufizSY637xBtC/t2PTrHgr1iDttOD/Uv/NuEjvp8sFDk1Cg==
X-Received: by 2002:a17:907:94cc:: with SMTP id dn12mr5226009ejc.177.1616510528194;
        Tue, 23 Mar 2021 07:42:08 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id bx2sm13319293edb.80.2021.03.23.07.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 07:42:07 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] printk: rename vprintk_func to vprintk
Date:   Tue, 23 Mar 2021 15:42:01 +0100
Message-Id: <20210323144201.486050-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printk code is already hard enough to understand. Remove an
unnecessary indirection by renaming vprintk_func to vprintk (adding
the asmlinkage annotation), and removing the vprintk definition from
printk.c. That way, printk is implemented in terms of vprintk as one
would expect, and there's no "vprintk_func, what's that? Some function
pointer that gets set where?"

The declaration of vprintk in linux/printk.h already has the
__printf(1,0) attribute, there's no point repeating that with the
definition - it's for diagnostics in callers.

linux/printk.h already contains a static inline {return 0;} definition
of vprintk when !CONFIG_PRINTK.

Since the corresponding stub definition of vprintk_func was not marked
"static inline", any translation unit including internal.h would get a
definition of vprintk_func - it just so happens that for
!CONFIG_PRINTK, there is precisely one such TU, namely printk.c. Had
there been more, it would be a link error; now it's just a silly waste
of a few bytes of .text, which one must assume are rather precious to
anyone disabling PRINTK.

$ objdump -dr kernel/printk/printk.o
00000330 <vprintk_func>:
 330:   31 c0                   xor    %eax,%eax
 332:   c3                      ret
 333:   8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi
 33a:   8d b6 00 00 00 00       lea    0x0(%esi),%esi

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/printk/internal.h    | 3 ---
 kernel/printk/printk.c      | 8 +-------
 kernel/printk/printk_safe.c | 3 ++-
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 3a8fd491758c..1c7554f0e71b 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -21,7 +21,6 @@ int vprintk_store(int facility, int level,
 
 __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
 __printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
-__printf(1, 0) int vprintk_func(const char *fmt, va_list args);
 void __printk_safe_enter(void);
 void __printk_safe_exit(void);
 
@@ -56,8 +55,6 @@ void defer_console_output(void);
 
 #else
 
-__printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
-
 /*
  * In !PRINTK builds we still export logbuf_lock spin_lock, console_sem
  * semaphore and some of console functions (console_unlock()/etc.), so
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 575a34b88936..458707a06124 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2104,12 +2104,6 @@ asmlinkage int vprintk_emit(int facility, int level,
 }
 EXPORT_SYMBOL(vprintk_emit);
 
-asmlinkage int vprintk(const char *fmt, va_list args)
-{
-	return vprintk_func(fmt, args);
-}
-EXPORT_SYMBOL(vprintk);
-
 int vprintk_default(const char *fmt, va_list args)
 {
 	return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
@@ -2143,7 +2137,7 @@ asmlinkage __visible int printk(const char *fmt, ...)
 	int r;
 
 	va_start(args, fmt);
-	r = vprintk_func(fmt, args);
+	r = vprintk(fmt, args);
 	va_end(args);
 
 	return r;
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 2e9e3ed7d63e..87d2e86af122 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -367,7 +367,7 @@ void __printk_safe_exit(void)
 	this_cpu_dec(printk_context);
 }
 
-__printf(1, 0) int vprintk_func(const char *fmt, va_list args)
+asmlinkage int vprintk(const char *fmt, va_list args)
 {
 #ifdef CONFIG_KGDB_KDB
 	/* Allow to pass printk() to kdb but avoid a recursion. */
@@ -420,3 +420,4 @@ void __init printk_safe_init(void)
 	/* Flush pending messages that did not have scheduled IRQ works. */
 	printk_safe_flush();
 }
+EXPORT_SYMBOL(vprintk);
-- 
2.29.2

