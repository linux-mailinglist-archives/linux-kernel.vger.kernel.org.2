Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B50538DC0F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 19:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhEWRG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 13:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhEWRG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 13:06:28 -0400
X-Greylist: delayed 1760 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 May 2021 10:05:01 PDT
Received: from srv1.deutnet.info (srv1.deutnet.info [IPv6:2a01:4f8:c2c:6846::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6A0C061574;
        Sun, 23 May 2021 10:05:01 -0700 (PDT)
Received: from agriveaux by srv1.deutnet.info with local (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1lkr4k-0000Rx-6R; Sun, 23 May 2021 18:35:38 +0200
From:   Alexandre GRIVEAUX <agriveaux@deutnet.info>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre GRIVEAUX <agriveaux@deutnet.info>
Subject: [PATCH RESEND 1/2] USB: serial: omninet: Adding Zyxel Omni 56K Plus
Date:   Sun, 23 May 2021 18:35:21 +0200
Message-Id: <20210523163522.1690-1-agriveaux@deutnet.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Zyxel Omni 56K Plus modem, this modem include:

USB chip:
NetChip
NET2888

Main chip:
901041A
F721501APGF

Another modem using the same chips is the Zyxel Omni 56K DUO/NEO,
could be added with the right USB ID.

Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
---
 drivers/usb/serial/omninet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/omninet.c b/drivers/usb/serial/omninet.c
index 83c62f920c50..8be91f5a4dd7 100644
--- a/drivers/usb/serial/omninet.c
+++ b/drivers/usb/serial/omninet.c
@@ -26,6 +26,7 @@
 
 #define ZYXEL_VENDOR_ID		0x0586
 #define ZYXEL_OMNINET_ID	0x1000
+#define ZYXEL_OMNI_56K_PLUS_ID	0x1500
 /* This one seems to be a re-branded ZyXEL device */
 #define BT_IGNITIONPRO_ID	0x2000
 
@@ -41,6 +42,7 @@ static void omninet_port_remove(struct usb_serial_port *port);
 static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(ZYXEL_VENDOR_ID, ZYXEL_OMNINET_ID) },
 	{ USB_DEVICE(ZYXEL_VENDOR_ID, BT_IGNITIONPRO_ID) },
+	{ USB_DEVICE(ZYXEL_VENDOR_ID, ZYXEL_OMNI_56K_PLUS_ID) },
 	{ }						/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, id_table);
-- 
2.20.1

