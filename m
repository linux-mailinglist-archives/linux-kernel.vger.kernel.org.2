Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3229B3FAA6B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 11:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbhH2JXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 05:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhH2JXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:23:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215CAC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:23:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id mf2so24033393ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+dqt6XS4ZNHrivjUXrH9fxmNodvBLxJ0+D0nFk09Hs=;
        b=JU8XOd2b7Xq5IKjUsiaaBVKqQ3ZtsFJwsPoNIih8o+KUk46lR4ecr611my62NK94Z5
         cLZlHegUnhQo6eN7sxiYLPLd8CIrtDYVLdwdtExbixGnYWFDEtkzsa11hQ/XG2rPr6mj
         RFadpuwGKvGyQGDZtydcVxY6RyAFMU1Tw44uD4EZhKQhbEUw4IVrdf0EK0tkinCyvFCO
         +lotJf7sryrklWXPjz0BHrU88LxcL6cgcP6lFcUZCXcQFP2d9RNBKMCdmK/CvckqjQwJ
         98Zcc5y4MDfDcgf5akQMDpnikq15HZn3lw+PvDjhQNydQomY60Im6u5BjleJdZ2rEZmX
         bUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+dqt6XS4ZNHrivjUXrH9fxmNodvBLxJ0+D0nFk09Hs=;
        b=mwBhpSBFXsFNYqwPjfvhNzvlxunRkR33lAtN0czLXLtwjsZJFDhX6P5zk/ycW5Vhqj
         xFkpTvRVwWQd6t5+kC+hDqxAtuqRC5mB0UWp31PmsGPpOfwjJUSEWiasc2q58kaJUhiP
         1Grp4a2UJMlW3BIPt28kJ/JFxW0SuF9VmuUPN+nUZFX+hysU2nApgWyUyZxGRmItG1mZ
         9FU+GWh6tc6q110VhoojAUfzO/pEIAiNFRUSrd8trHxGCQDzbqMUmgDQZBN+xu/pw24a
         WkkmHRKWh1jWOwiYB584macwwia9NcJroSZhqcemG8rxxJp4X9hZjoGED3diphzW7pnC
         dxJg==
X-Gm-Message-State: AOAM533LyWBPQGhydyNsIw8CiZVRhdDxmXAQymZFLiMPFPXOFFuZn5qc
        O8YfsUtTo9cBlde+cCB77k0=
X-Google-Smtp-Source: ABdhPJy6D7wvo+5iCtrPdFblc/OhtL1DNGesRrmldOnErYS5oePwvizVmEzgWREo4pwFRIlztOd93g==
X-Received: by 2002:a17:907:628d:: with SMTP id nd13mr19549239ejc.7.1630228978627;
        Sun, 29 Aug 2021 02:22:58 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id u4sm610916ejc.19.2021.08.29.02.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:22:57 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4] staging: greybus: Convert uart.c from IDR to XArray
Date:   Sun, 29 Aug 2021 11:22:50 +0200
Message-Id: <20210829092250.25379-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert greybus/uart.c from IDR to XArray. The abstract data type XArray
is more memory-efficient, parallelisable, and cache friendly. It takes
advantage of RCU to perform lookups without locking. Furthermore, IDR is
deprecated because XArray has a better (cleaner and more consistent) API.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v3->v4: 
	Remove mutex_lock/unlock around xa_load(). These locks seem to
	be unnecessary because there is a 1:1 correspondence between
	a specific minor and its gb_tty and there is no reference
	counting. I think that the RCU locks used inside xa_load()
	are sufficient to protect this API from returning an invalid
	gb_tty in case of concurrent access. Some more considerations 
	on this topic are in the following message to linux-kernel list:
	https://lore.kernel.org/lkml/3554184.2JXonMZcNW@localhost.localdomain/
v2->v3:
        Fix some issues according to a review by Alex Elder <elder@ieee.org>
v1->v2:
        Fix an issue found by the kernel test robot. It is due to
        passing to xa_*lock() the same old mutex that IDR used with
        the previous version of the code.

 drivers/staging/greybus/uart.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 73f01ed1e5b7..f66983adb51b 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -22,7 +22,7 @@
 #include <linux/serial.h>
 #include <linux/tty_driver.h>
 #include <linux/tty_flip.h>
-#include <linux/idr.h>
+#include <linux/xarray.h>
 #include <linux/fs.h>
 #include <linux/kdev_t.h>
 #include <linux/kfifo.h>
@@ -32,8 +32,9 @@
 
 #include "gbphy.h"
 
-#define GB_NUM_MINORS	16	/* 16 is more than enough */
-#define GB_NAME		"ttyGB"
+#define GB_NUM_MINORS		16	/* 16 is more than enough */
+#define GB_RANGE_MINORS		XA_LIMIT(0, GB_NUM_MINORS)
+#define GB_NAME			"ttyGB"
 
 #define GB_UART_WRITE_FIFO_SIZE		PAGE_SIZE
 #define GB_UART_WRITE_ROOM_MARGIN	1	/* leave some space in fifo */
@@ -67,8 +68,7 @@ struct gb_tty {
 };
 
 static struct tty_driver *gb_tty_driver;
-static DEFINE_IDR(tty_minors);
-static DEFINE_MUTEX(table_lock);
+static DEFINE_XARRAY(tty_minors);
 
 static int gb_uart_receive_data_handler(struct gb_operation *op)
 {
@@ -341,8 +341,7 @@ static struct gb_tty *get_gb_by_minor(unsigned int minor)
 {
 	struct gb_tty *gb_tty;
 
-	mutex_lock(&table_lock);
-	gb_tty = idr_find(&tty_minors, minor);
+	gb_tty = xa_load(&tty_minors, minor);
 	if (gb_tty) {
 		mutex_lock(&gb_tty->mutex);
 		if (gb_tty->disconnected) {
@@ -353,19 +352,18 @@ static struct gb_tty *get_gb_by_minor(unsigned int minor)
 			mutex_unlock(&gb_tty->mutex);
 		}
 	}
-	mutex_unlock(&table_lock);
 	return gb_tty;
 }
 
 static int alloc_minor(struct gb_tty *gb_tty)
 {
 	int minor;
+	int ret;
 
-	mutex_lock(&table_lock);
-	minor = idr_alloc(&tty_minors, gb_tty, 0, GB_NUM_MINORS, GFP_KERNEL);
-	mutex_unlock(&table_lock);
-	if (minor >= 0)
-		gb_tty->minor = minor;
+	ret = xa_alloc(&tty_minors, &minor, gb_tty, GB_RANGE_MINORS, GFP_KERNEL);
+	if (ret)
+		return ret;
+	gb_tty->minor = minor;
 	return minor;
 }
 
@@ -374,9 +372,7 @@ static void release_minor(struct gb_tty *gb_tty)
 	int minor = gb_tty->minor;
 
 	gb_tty->minor = 0;	/* Maybe should use an invalid value instead */
-	mutex_lock(&table_lock);
-	idr_remove(&tty_minors, minor);
-	mutex_unlock(&table_lock);
+	xa_erase(&tty_minors, minor);
 }
 
 static int gb_tty_install(struct tty_driver *driver, struct tty_struct *tty)
@@ -837,7 +833,7 @@ static int gb_uart_probe(struct gbphy_device *gbphy_dev,
 
 	minor = alloc_minor(gb_tty);
 	if (minor < 0) {
-		if (minor == -ENOSPC) {
+		if (minor == -EBUSY) {
 			dev_err(&gbphy_dev->dev,
 				"no more free minor numbers\n");
 			retval = -ENODEV;
@@ -982,7 +978,7 @@ static void gb_tty_exit(void)
 {
 	tty_unregister_driver(gb_tty_driver);
 	put_tty_driver(gb_tty_driver);
-	idr_destroy(&tty_minors);
+	xa_destroy(&tty_minors);
 }
 
 static const struct gbphy_device_id gb_uart_id_table[] = {
-- 
2.32.0

