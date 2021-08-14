Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C1A3EC365
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbhHNO4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 10:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbhHNO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 10:56:47 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936EDC061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 07:56:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gt38so2581457ejc.13
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tImfbxVWdTlhcDIkyDpmWJXKvDRSXiEiMFTfwAJNv9k=;
        b=EHOLnNLMMlJR/Uf4G7WZg2ue5EzYgozA1tZhnmkGZL5aUZNrMjUNaGz7u/HQFPrn8c
         GDxhbqm255pZS5aMxsgSHYKHdfCtFw8ipL0j/u5frb2Lrq7MHJi6rvj+X9/gkH6iDFLU
         hRC13RHdoKz3gyqxy4jY6XRXsutm8rz74PBKwdG5HCEPWdynaxmqCwlUck5pk+ZVxWJ5
         kh6ebzSSnO3dnfgQ5qM6xstAczJlXPk+huM+m/DMsQT6yjFjgjVwZEEdzhRSZ6cSvZZA
         4KjRQg5bPAx+cT06RkY65jihFJo0ugC00qH+ATWkNKe2zMVFwziGFmZ6Q1X9/KFQQv6w
         nIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tImfbxVWdTlhcDIkyDpmWJXKvDRSXiEiMFTfwAJNv9k=;
        b=KrmkgscdDpvWgEM/k/q0OJtsXQp0LIdnMRwvg9bGI2O9Y+4Y6fOpjhEN39QWE9LBq1
         8Wj6kw4hTp5k5Y2lXCv2d7oMgXkYNJCPUVeonPX/IqAYxUfmUGDglrExcOYeMCEC8x06
         x9Z37cou2Q7BRLDmX/h4YccjfXaXwHDgxtc8SQ87UhkNmBvsritmqOFasao3Vt5gALZ7
         79sWpP8qwnIJkoqmHRklR0/MGuW8yNKe3PXGSMVA3j4obXifCraANWfOyx8FBqr6u5i6
         rzBaricBiJLPgyL5ahdzPFRPVFQypEzWgvBHBf+kmg9a5ofENEgYD93vY/uhHPmMreyB
         L3uA==
X-Gm-Message-State: AOAM5335/uzR6ZoNXI0fi7Ko2o2RqL8mg9U/GRUONqZkDE6t51oZGkor
        tnuRoei9I7ld2fMrCTP27VfKSA8JZAg=
X-Google-Smtp-Source: ABdhPJy9N0iCyoePDC+ZEuwq4QPMU8YnqadyfCQ5pwETUuEVCcgbCTrHajg881i0eJusf9tYz2gnpg==
X-Received: by 2002:a17:906:b052:: with SMTP id bj18mr7840960ejb.55.1628952977036;
        Sat, 14 Aug 2021 07:56:17 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id v23sm2336373edy.21.2021.08.14.07.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 07:56:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: greybus: Convert uart.c from IDR to XArray
Date:   Sat, 14 Aug 2021 16:56:13 +0200
Message-Id: <20210814145613.6493-1-fmdefrancesco@gmail.com>
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
 drivers/staging/greybus/uart.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 73f01ed1e5b7..7c19156534ca 100644
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
@@ -33,6 +33,7 @@
 #include "gbphy.h"
 
 #define GB_NUM_MINORS	16	/* 16 is more than enough */
+#define GB_RANGE_MINORS		XA_LIMIT(0, GB_NUM_MINORS)
 #define GB_NAME		"ttyGB"
 
 #define GB_UART_WRITE_FIFO_SIZE		PAGE_SIZE
@@ -67,7 +68,7 @@ struct gb_tty {
 };
 
 static struct tty_driver *gb_tty_driver;
-static DEFINE_IDR(tty_minors);
+static DEFINE_XARRAY(tty_minors);
 static DEFINE_MUTEX(table_lock);
 
 static int gb_uart_receive_data_handler(struct gb_operation *op)
@@ -77,6 +78,7 @@ static int gb_uart_receive_data_handler(struct gb_operation *op)
 	struct tty_port *port = &gb_tty->port;
 	struct gb_message *request = op->request;
 	struct gb_uart_recv_data_request *receive_data;
+
 	u16 recv_data_size;
 	int count;
 	unsigned long tty_flags = TTY_NORMAL;
@@ -341,8 +343,8 @@ static struct gb_tty *get_gb_by_minor(unsigned int minor)
 {
 	struct gb_tty *gb_tty;
 
-	mutex_lock(&table_lock);
-	gb_tty = idr_find(&tty_minors, minor);
+	xa_lock(&table_lock);
+	gb_tty = xa_load(&tty_minors, minor);
 	if (gb_tty) {
 		mutex_lock(&gb_tty->mutex);
 		if (gb_tty->disconnected) {
@@ -353,19 +355,19 @@ static struct gb_tty *get_gb_by_minor(unsigned int minor)
 			mutex_unlock(&gb_tty->mutex);
 		}
 	}
-	mutex_unlock(&table_lock);
+	xa_unlock(&table_lock);
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
 
@@ -374,9 +376,7 @@ static void release_minor(struct gb_tty *gb_tty)
 	int minor = gb_tty->minor;
 
 	gb_tty->minor = 0;	/* Maybe should use an invalid value instead */
-	mutex_lock(&table_lock);
-	idr_remove(&tty_minors, minor);
-	mutex_unlock(&table_lock);
+	xa_erase(&tty_minors, minor);
 }
 
 static int gb_tty_install(struct tty_driver *driver, struct tty_struct *tty)
@@ -982,7 +982,7 @@ static void gb_tty_exit(void)
 {
 	tty_unregister_driver(gb_tty_driver);
 	put_tty_driver(gb_tty_driver);
-	idr_destroy(&tty_minors);
+	xa_destroy(&tty_minors);
 }
 
 static const struct gbphy_device_id gb_uart_id_table[] = {
-- 
2.32.0

