Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29412365050
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 04:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhDTC0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 22:26:04 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48431 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhDTC0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 22:26:03 -0400
X-Originating-IP: 68.203.5.165
Received: from tacos.lan (cpe-68-203-5-165.austin.res.rr.com [68.203.5.165])
        (Authenticated sender: frank@zago.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 52E4520005;
        Tue, 20 Apr 2021 02:25:28 +0000 (UTC)
From:   Frank Zago <frank@zago.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jan-Niklas Burfeind <kernel@aiyionpri.me>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-usb@vger.kernel.org
Cc:     frank zago <frank@zago.net>
Subject: [PATCH 1/2] Revert "USB: serial: ch341: add new Product ID for CH341A"
Date:   Mon, 19 Apr 2021 21:25:19 -0500
Message-Id: <20210420022520.47965-1-frank@zago.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: frank zago <frank@zago.net>

The 0x5512 USB PID is for the I2C/GPIO/SPI interfaces. UART is still
present but only the TX and RX pins are available; DTS, DTR, ... are
used for other things. Remove the PID, and let a I2C driver bind to
it.

Existing CH341 boards usually have physical jumpers to switch between
the 3 modes.

This reverts commit 46ee4abb10a07bd8f8ce910ee6b4ae6a947d7f63.

Signed-off-by: Frank Zago <frank@zago.net>
Signed-off-by: frank zago <frank@zago.net>
---
 drivers/usb/serial/ch341.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index 2db917eab799..235adc77ee0e 100644
--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -81,7 +81,6 @@
 #define CH341_QUIRK_SIMULATE_BREAK	BIT(1)
 
 static const struct usb_device_id id_table[] = {
-	{ USB_DEVICE(0x1a86, 0x5512) },
 	{ USB_DEVICE(0x1a86, 0x5523) },
 	{ USB_DEVICE(0x1a86, 0x7522) },
 	{ USB_DEVICE(0x1a86, 0x7523) },
-- 
2.27.0

