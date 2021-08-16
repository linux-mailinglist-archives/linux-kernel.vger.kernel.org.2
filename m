Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B253EDE1F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhHPTuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhHPTui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:50:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30260C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:50:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id d11so33883942eja.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/HbL/ctCmtRDb+/41Ad/8cEQ9C3eCkUOM+E7n4I/I5c=;
        b=TqNtl4u0g79zy/qXZhDzaCeqQGiUCfuS03jLo2RNvseT3iwGe6Q5gzmXJXHqtnFBZ6
         180q4vktwjyThm5qWyX0cyOVOYk+TWeNl1ROhhHkh1BWotIXOAmDfPBFG4YHOjdLa0xa
         OzO47r6S6X9eOV8U+TIa60B1QL6ZNNUx0b9lakDc7AWTahE3JVutI6Ob5AY67FMpcIcz
         UfzaYbaLf2PxB53XJYz/DN5Dv15s7tA+OiqpkuNtvuTOefsesvdffj88njhfSvzVTAzH
         +wDN4NWGjsMkXUb3xZf9RUapaWDf1RpmWXQ4yBmnmMuSBMGV5kG6LVGfnf1ck1upl4cX
         MUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/HbL/ctCmtRDb+/41Ad/8cEQ9C3eCkUOM+E7n4I/I5c=;
        b=S1dK7ho+iG/wjKbkXXt67FLc7pRdWqlHKBqbWKBCBQWJwe2lf5ujspXtO9ss4n2jBq
         ICDO9A3zyUQwU9EzXhULysrbOyr5EUK5h5k7w7jeLF5wg0kbPbAn7npv6Vj6YuL2ZPcb
         pYSaD9H/NkcH1coXJQl66d8XRyyGDMdfgQbEhCxWKQ2bjdkkqkIfmLjno4KrqXSFIXfV
         m65je9GEEe3hQpQY5dibJBv9OrhsWApWIbD8QTKwZqPk5VOUu7dNScbzfUT4dDRdFI4z
         /Zg+PY8adSBUTevZ177iFv+j6qFDaVjCFUDZdniUJJCEB0W+glYecKP1ZFVHELUfWI+y
         WFkw==
X-Gm-Message-State: AOAM533p4zMVe+7COTxfIfwGcLVbPwjy+6fWIWjv1NywSLU8QACxt2E1
        3USijmLqYfBpXb6BBd9ZhyCHc5QSwsY=
X-Google-Smtp-Source: ABdhPJwXmSxmTnhAPUxjJ7lf5SNJakuHdjJekAR788RIHxzMXMaRxvwqPWXfxjRkGvvD8I0IcB8xGg==
X-Received: by 2002:a17:906:2acc:: with SMTP id m12mr122988eje.231.1629143404796;
        Mon, 16 Aug 2021 12:50:04 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id c16sm66622ejm.125.2021.08.16.12.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 12:50:04 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3] staging: greybus: Convert uart.c from IDR to XArray
Date:   Mon, 16 Aug 2021 21:50:00 +0200
Message-Id: <20210816195000.736-1-fmdefrancesco@gmail.com>
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

v2->v3:
	Fix some issues according to a review by Alex Elder <elder@ieee.org>

v1->v2:
        Fix an issue found by the kernel test robot. It is due to
        passing to xa_*lock() the same old mutex that IDR used with
        the previous version of the code.

 drivers/staging/greybus/uart.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 73f01ed1e5b7..815156c88005 100644
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
@@ -341,8 +341,8 @@ static struct gb_tty *get_gb_by_minor(unsigned int minor)
 {
 	struct gb_tty *gb_tty;
 
-	mutex_lock(&table_lock);
-	gb_tty = idr_find(&tty_minors, minor);
+	xa_lock(&tty_minors);
+	gb_tty = xa_load(&tty_minors, minor);
 	if (gb_tty) {
 		mutex_lock(&gb_tty->mutex);
 		if (gb_tty->disconnected) {
@@ -353,19 +353,19 @@ static struct gb_tty *get_gb_by_minor(unsigned int minor)
 			mutex_unlock(&gb_tty->mutex);
 		}
 	}
-	mutex_unlock(&table_lock);
+	xa_unlock(&tty_minors);
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
 
@@ -374,9 +374,7 @@ static void release_minor(struct gb_tty *gb_tty)
 	int minor = gb_tty->minor;
 
 	gb_tty->minor = 0;	/* Maybe should use an invalid value instead */
-	mutex_lock(&table_lock);
-	idr_remove(&tty_minors, minor);
-	mutex_unlock(&table_lock);
+	xa_erase(&tty_minors, minor);
 }
 
 static int gb_tty_install(struct tty_driver *driver, struct tty_struct *tty)
@@ -837,7 +835,7 @@ static int gb_uart_probe(struct gbphy_device *gbphy_dev,
 
 	minor = alloc_minor(gb_tty);
 	if (minor < 0) {
-		if (minor == -ENOSPC) {
+		if (minor == -EBUSY) {
 			dev_err(&gbphy_dev->dev,
 				"no more free minor numbers\n");
 			retval = -ENODEV;
@@ -982,7 +980,7 @@ static void gb_tty_exit(void)
 {
 	tty_unregister_driver(gb_tty_driver);
 	put_tty_driver(gb_tty_driver);
-	idr_destroy(&tty_minors);
+	xa_destroy(&tty_minors);
 }
 
 static const struct gbphy_device_id gb_uart_id_table[] = {
-- 
2.32.0

