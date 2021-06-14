Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1983A72BB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 01:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhFNX6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 19:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhFNX6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 19:58:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8DFC061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 16:56:41 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v13so7495954ple.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 16:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2hZ/fLKjk/CGa8mnGkTM9do02TlLwRcH/q+h0ZKU7YY=;
        b=EpO4Jyl3aeBWQqUeRYC87rEUTL0cCpUevsHit8s+C4YnZ051NpzaLV/m5ZadnYO29y
         gt9q7hURxiIRzT4Nwu5e9rz+4p50Dx2WAr4i1dea+wPiYdFRnWaNEJUvB7CIp/s4mkBx
         lH2Qegd0Rz3HuJB3s6hGeSj3CmI8i+QX7WDwsbR1nCJkIxaMRgCreyJh0AKf9zYt3nh4
         r1MVy9omNGnz26G1yIJqivH+9jVIlC7Ff2L4abvSJGTfXo8f7I+55Nm0Fb4GrN/NcsWL
         p6wKowFBMCSeTdVOeOpVewgBYRGDWfpLx0wMGfp18hbJVCZjsVnjTJgMM5OOFKblZGWh
         8SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2hZ/fLKjk/CGa8mnGkTM9do02TlLwRcH/q+h0ZKU7YY=;
        b=fw1HtidrSWyo+KrKoFvvZiijYd73O8C1rzM47/1YBX9OAzRm48sXBZAzHMXbg8pUQ0
         gxx6Am33a+rcUh2lcMqizZTcWODVKIywPdYqeLAlTSxghDzC86cmE6nBmYF22genDbEv
         DzsDtQ7YfxFBcMeI7/nze3N7b2e6rKjDFSXzX9pMjQgYwkruqH57SS/059O4ROBFdAIQ
         mgteawIpzoA170ZeT6VCSIY2+RnQOidNKIagSnWBxXr1Dh3d/IZ6TAsJ61Q5W/JXWRhm
         JvSmv2ZQfj45zBj+pSU4KMB4b88SiBiVAMwS7u55tli4nDbD+R9j+AuIvcMV+oN9adal
         OQ3A==
X-Gm-Message-State: AOAM531HZ88WnRBfZGXQo/2QkpjdSz/hy6s8pnWVE9lwQW1tzNGSfQ58
        RLe+/oFu9RGtH0PpM2tsYmA=
X-Google-Smtp-Source: ABdhPJxM0zND9y0Z3ugZx173hcRK4jjSxC/NXhHPLxjDcnI7+QUFtc6Ruky8sME6kmiiv/FyLuDjHg==
X-Received: by 2002:a17:90b:3ec3:: with SMTP id rm3mr22241049pjb.105.1623715000470;
        Mon, 14 Jun 2021 16:56:40 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id v6sm13694092pfi.46.2021.06.14.16.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 16:56:39 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     pmladek@suse.com, senozhatsky@chromium.org
Cc:     Punit Agrawal <punitagrawal@gmail.com>, rostedt@goodmis.org,
        john.ogness@linutronix.de, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org
Subject: [PATCH] printk: Move EXPORT_SYMBOL() closer to vprintk definition
Date:   Tue, 15 Jun 2021 08:56:35 +0900
Message-Id: <20210614235635.887365-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 28e1745b9fa2 ("printk: rename vprintk_func to vprintk") while
improving readability by removing vprintk indirection, inadvertently
placed the EXPORT_SYMBOL() for the newly renamed function at the end
of the file.

For reader sanity, and as is convention move the EXPORT_SYMBOL()
declaration just after the end of the function.

Fixes: 28e1745b9fa2 ("printk: rename vprintk_func to vprintk")
Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
--
Hi,

The out-of-place EXPORT_SYMBOL() caused an unexpected conflict while
attempting to rebase the RT patches onto newer kernels.

Generally I avoid sending trivial changes on their own but this one is
a little hard to overlook. Also it felt like an obvious oversight in
the original patch.

Please consider merging.

Thanks,
Punit
---
 kernel/printk/printk_safe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 7a1414622051..94232186fccb 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -391,6 +391,7 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	/* No obstacles. */
 	return vprintk_default(fmt, args);
 }
+EXPORT_SYMBOL(vprintk);
 
 void __init printk_safe_init(void)
 {
@@ -411,4 +412,3 @@ void __init printk_safe_init(void)
 	/* Flush pending messages that did not have scheduled IRQ works. */
 	printk_safe_flush();
 }
-EXPORT_SYMBOL(vprintk);
-- 
2.30.2

