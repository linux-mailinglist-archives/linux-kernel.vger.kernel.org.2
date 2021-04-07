Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3241356A2C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351406AbhDGKqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:46:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351339AbhDGKp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:45:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B760B613A0;
        Wed,  7 Apr 2021 10:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617792346;
        bh=TW3dYg3jLvzppmitvf970CQZyFxMpiK3Cl4p/9esRb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z3YTfKICQ0MdGoI2blKHkqXGSX/7TfgArnk0eJpaZ83M6ibe6NLmaDryAJeBeF5Kt
         iHQ5FF9QMTTQzir7Anqin5EgJWFpTZ199aSICEOzedwPBZoW7SKrrhXJmsPogNDBTz
         ncvcdWzdt8vByZja6HMAuGfvJA/joUCWaVgLsMRB6fj+D86k9Cy4p7wCl4BPEOmAqM
         a6kl7gu74BbRr/UQFUbtySrQzRLMn++gXQ7MzuiEoLg5ps/xqS+VxLeodMCa5GLFY0
         G4Wf39eAJPk0HJs+aK6JfiIb5MIvpJE4t6PqJlheMaXYNuJzmy/EMTPgmlRTFR2rnF
         eahLc2eV3112g==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5gp-0000Ip-I2; Wed, 07 Apr 2021 12:45:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] USB: serial: ti_usb_3410_5052: drop closing_wait module parameter
Date:   Wed,  7 Apr 2021 12:45:28 +0200
Message-Id: <20210407104529.1110-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407104529.1110-1-johan@kernel.org>
References: <20210407104529.1110-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ti_usb_3410_5052 has supported changing the closing_wait parameter
through TIOCSSERIAL (setserial) for about a decade and commit
f1175daa5312 ("USB: ti_usb_3410_5052: kill custom closing_wait").

It's time to drop the corresponding driver-specific module parameter.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ti_usb_3410_5052.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index c312d0cce5fb..35cc1be738ef 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -344,8 +344,6 @@ static int ti_write_byte(struct usb_serial_port *port, struct ti_device *tdev,
 
 static int ti_download_firmware(struct ti_device *tdev);
 
-static int closing_wait = TI_DEFAULT_CLOSING_WAIT;
-
 static const struct usb_device_id ti_id_table_3410[] = {
 	{ USB_DEVICE(TI_VENDOR_ID, TI_3410_PRODUCT_ID) },
 	{ USB_DEVICE(TI_VENDOR_ID, TI_3410_EZ430_ID) },
@@ -497,10 +495,6 @@ MODULE_FIRMWARE("moxa/moxa-1131.fw");
 MODULE_FIRMWARE("moxa/moxa-1150.fw");
 MODULE_FIRMWARE("moxa/moxa-1151.fw");
 
-module_param(closing_wait, int, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(closing_wait,
-    "Maximum wait for data to drain in close, in .01 secs, default is 4000");
-
 MODULE_DEVICE_TABLE(usb, ti_id_table_combined);
 
 module_usb_serial_driver(serial_drivers, ti_id_table_combined);
@@ -608,7 +602,7 @@ static int ti_port_probe(struct usb_serial_port *port)
 		tport->tp_uart_base_addr = TI_UART1_BASE_ADDR;
 	else
 		tport->tp_uart_base_addr = TI_UART2_BASE_ADDR;
-	port->port.closing_wait = msecs_to_jiffies(10 * closing_wait);
+	port->port.closing_wait = msecs_to_jiffies(10 * TI_DEFAULT_CLOSING_WAIT);
 	tport->tp_port = port;
 	tport->tp_tdev = usb_get_serial_data(port->serial);
 
-- 
2.26.3

