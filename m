Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D5F40BCFC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhIOBPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhIOBPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:15:38 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307D5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:14:20 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1631668456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZNpudidzVmP4jemFhTF+Od7e/hnMt6Xl6jWXwSgmpfs=;
        b=M9TTANL6lOT2gGPl2aW6mLuWfct17FK29lfcwNsgUym1xpmkQMzLy/s6hTJKSE6Eldfa8t
        O08E2qM0ZqBj7QYOIO73uw/Nf/TIsh4H8EwtslkhTedbslG1Jd9AH9oV8jxhcA4e8FKI4L
        RR1XOfuUt7ZH2pXQfeE6d86aAdVlEBE=
From:   Jackie Liu <liu.yun@linux.dev>
To:     dri-devel@lists.freedesktop.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        liu.yun@linux.dev
Subject: [PATCH v3] mdacon: fix redefinition of 'scr_memsetw'
Date:   Wed, 15 Sep 2021 09:13:54 +0800
Message-Id: <20210915011354.2669416-1-liu.yun@linux.dev>
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

Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Fixes: ac036f9570a2 ("vga: optimise console scrolling")
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

