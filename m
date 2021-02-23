Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640FE322EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhBWQpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbhBWQpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:45:11 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F89C061574;
        Tue, 23 Feb 2021 08:44:30 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6BC2B1F41126
Received: by jupiter.universe (Postfix, from userid 1000)
        id C7A7F4800C3; Tue, 23 Feb 2021 17:44:20 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH] USB: serial: cp210x: add some more GE USB IDs
Date:   Tue, 23 Feb 2021 17:44:18 +0100
Message-Id: <20210223164418.118135-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GE CS1000 has some more custom USB IDs for CP2102N; add them
to the driver to have working auto-probing.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/usb/serial/cp210x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 9e1c609792fb..0d2d2a3baa07 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -201,6 +201,8 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x1901, 0x0194) },	/* GE Healthcare Remote Alarm Box */
 	{ USB_DEVICE(0x1901, 0x0195) },	/* GE B850/B650/B450 CP2104 DP UART interface */
 	{ USB_DEVICE(0x1901, 0x0196) },	/* GE B850 CP2105 DP UART interface */
+	{ USB_DEVICE(0x1901, 0x0197) }, /* GE CS1000 Display serial interface */
+	{ USB_DEVICE(0x1901, 0x0198) }, /* GE CS1000 M.2 Key E serial interface */
 	{ USB_DEVICE(0x199B, 0xBA30) }, /* LORD WSDA-200-USB */
 	{ USB_DEVICE(0x19CF, 0x3000) }, /* Parrot NMEA GPS Flight Recorder */
 	{ USB_DEVICE(0x1ADB, 0x0001) }, /* Schweitzer Engineering C662 Cable */
-- 
2.30.0

