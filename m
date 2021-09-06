Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6694019B2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 12:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241929AbhIFKWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 06:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241912AbhIFKWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 06:22:04 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0D6C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 03:20:57 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1630923656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HBo+wIXmi7Lv5XQUqO6oLN4A2Krbr53UNQHRwql5XeM=;
        b=hkMXtoMYEdHTnVc7PI7rUxflmB1zC+tJ5NJIvauEuywChZ8SWmiG7TNoVd/gsYfRTejDa6
        pdEdfXDns3+WddTkFLA4iw5CJ6WaXoILlSGxOlC+KtCbOF/yHwQ09At/zioNIWrHKmsAkU
        JJQ1LDBx07gIKtDarTtVQLVzANwUAw0=
From:   Jackie Liu <liu.yun@linux.dev>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, liu.yun@linux.dev
Subject: [PATCH] mdacon: fix redefinition of 'scr_memsetw'
Date:   Mon,  6 Sep 2021 18:20:30 +0800
Message-Id: <20210906102030.1659910-1-liu.yun@linux.dev>
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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
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
index 848db1b1569f..3e71f879e7c0 100644
--- a/include/linux/vt_buffer.h
+++ b/include/linux/vt_buffer.h
@@ -16,7 +16,7 @@
 
 #include <linux/string.h>
 
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
+#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE) || defined(CONFIG_MDA_CONSOLE_MODULE)
 #include <asm/vga.h>
 #endif
 
-- 
2.25.1

