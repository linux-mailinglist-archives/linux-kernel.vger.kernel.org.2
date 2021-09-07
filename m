Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7128040222F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 04:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhIGCFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 22:05:05 -0400
Received: from out0.migadu.com ([94.23.1.103]:18602 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230123AbhIGCFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 22:05:04 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1630980234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QWXpSaejyMww3vH7k/Zt9qfcRBFTytSDDJsgJ+Wx+Ds=;
        b=hfeKjMkC9kvpjSXm7TdKiF1tJL3ZunUSMfBhfTuwFZn0bkd9PKaR8yinF/sdgjjwzRsjP7
        HatSl2e1kJ9pAg2UF7a+MzV8lm2ytAJkGpJTSWeeD5q9PNjlxncd0WHKa/jjI3wE+NJB70
        0ISi9SwRvVk7DNcZGhE5f+2NXAfrkmY=
From:   Jackie Liu <liu.yun@linux.dev>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, liu.yun@linux.dev
Subject: [PATCH v2] mdacon: fix redefinition of 'scr_memsetw'
Date:   Tue,  7 Sep 2021 10:03:26 +0800
Message-Id: <20210907020326.2329486-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: liu.yun@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

CONFIG_VGA_CONSOLE=n and CONFIG_MDA_CONSOLE=n will cause vt_buffer.h not
include <asm/vga.h>.

But if we set CONFIG_MDA_CONSOLE=m, mdacon.c include <linux/vt_buffer.h>
is in front of include <asm/vga.h>. VT_BUF_HAVE_MEMSETW is not defined,
so vt_buffer.h will define a scr_memsetw, after that, vga.h also define
a scr_memsetw, so the repeated definition of scr_memsetw appears, builds
error.

We only need to make vt_buffer.h also contain vga.h when
CONFIG_MDA_CONSOLE=m. This problem can be fixed.

BTW, mdacon.c no need to include vga.h forcibly, let vt_buffer.h do it.

Fixes: ac036f9570a2 ("vga: optimise console scrolling")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/video/console/mdacon.c | 1 -
 include/linux/vt_buffer.h      | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index ef29b321967f..5898d01bc492 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -42,7 +42,6 @@
 #include <linux/init.h>
 
 #include <asm/io.h>
-#include <asm/vga.h>
 
 static DEFINE_SPINLOCK(mda_lock);
 
diff --git a/include/linux/vt_buffer.h b/include/linux/vt_buffer.h
index 848db1b1569f..3a79cc27a33b 100644
--- a/include/linux/vt_buffer.h
+++ b/include/linux/vt_buffer.h
@@ -16,7 +16,7 @@
 
 #include <linux/string.h>
 
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
+#if defined(CONFIG_VGA_CONSOLE) || IS_ENABLED(CONFIG_MDA_CONSOLE)
 #include <asm/vga.h>
 #endif
 
-- 
2.25.1

