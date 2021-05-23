Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADCD38DC11
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 19:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhEWRGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 13:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhEWRGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 13:06:31 -0400
Received: from srv1.deutnet.info (srv1.deutnet.info [IPv6:2a01:4f8:c2c:6846::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660DFC061574;
        Sun, 23 May 2021 10:05:04 -0700 (PDT)
Received: from agriveaux by srv1.deutnet.info with local (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1lkr4o-0000S8-Hs; Sun, 23 May 2021 18:35:42 +0200
From:   Alexandre GRIVEAUX <agriveaux@deutnet.info>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre GRIVEAUX <agriveaux@deutnet.info>
Subject: [PATCH RESEND 2/2] USB: serial: omninet: Renaming driver to Zyxel omni.net
Date:   Sun, 23 May 2021 18:35:22 +0200
Message-Id: <20210523163522.1690-2-agriveaux@deutnet.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210523163522.1690-1-agriveaux@deutnet.info>
References: <20210523163522.1690-1-agriveaux@deutnet.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the inclusion of Omni 56K Plus, this driver seem to be more common
among the family of Zyxel omni modem.

Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
---
 drivers/usb/serial/omninet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/omninet.c b/drivers/usb/serial/omninet.c
index 8be91f5a4dd7..79c0dab46ae8 100644
--- a/drivers/usb/serial/omninet.c
+++ b/drivers/usb/serial/omninet.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * USB ZyXEL omni.net LCD PLUS driver
+ * USB ZyXEL omni.net driver
  *
  * Copyright (C) 2013,2017 Johan Hovold <johan@kernel.org>
  *
@@ -22,7 +22,7 @@
 #include <linux/usb/serial.h>
 
 #define DRIVER_AUTHOR "Alessandro Zummo"
-#define DRIVER_DESC "USB ZyXEL omni.net LCD PLUS Driver"
+#define DRIVER_DESC "USB ZyXEL omni.net Driver"
 
 #define ZYXEL_VENDOR_ID		0x0586
 #define ZYXEL_OMNINET_ID	0x1000
@@ -52,7 +52,7 @@ static struct usb_serial_driver zyxel_omninet_device = {
 		.owner =	THIS_MODULE,
 		.name =		"omninet",
 	},
-	.description =		"ZyXEL - omni.net lcd plus usb",
+	.description =		"ZyXEL - omni.net usb",
 	.id_table =		id_table,
 	.num_bulk_out =		2,
 	.calc_num_ports =	omninet_calc_num_ports,
-- 
2.20.1

