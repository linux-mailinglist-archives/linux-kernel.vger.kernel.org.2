Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6B83BA16D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhGBNpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:45:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232719AbhGBNp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:45:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9342D61439;
        Fri,  2 Jul 2021 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625233376;
        bh=j0sAISF6TrBQtWd6KwNA6oEpI+hi30rZzbLkvV/VyfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DaIXhci4yXdsTZEoExhJxWrn6fMvIla8KC26KGtmV8V58K56JABVBE6kR/5M7gI/B
         9XNgJdF1mZ5IK1aFBKUwIsyjVRHw5xy1+H0cPUHvu55O31vYaW8bq/N7bysi98403z
         rciqSt/HwLC+uFG1oEOoZU7cExV3nvOJdViUY3rIgA+6Neg0PL1opPp6bD7Eqxlscb
         JMiPDxq8Hzy7VfqFujARoMrlccSklECURrTmjwib8N/I5gJuarRDE6gJvNbo9BzRHm
         Yrd8xkd8dRKP/Gc8j80t9+sC+ljQCr/cvMyxIl0U5qqLfm330wVt6pEbQr9/qmMvyr
         pc2/GmDDUnY+Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lzJRT-0006QA-7s; Fri, 02 Jul 2021 15:42:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] USB: serial: cp210x: clean up set-chars request
Date:   Fri,  2 Jul 2021 15:42:25 +0200
Message-Id: <20210702134227.24621-5-johan@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210702134227.24621-1-johan@kernel.org>
References: <20210702134227.24621-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic control request helper to implement the SET_CHARS
request.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index c7cea86c659c..4c51381cf9aa 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1144,33 +1144,6 @@ static void cp210x_disable_event_mode(struct usb_serial_port *port)
 	port_priv->event_mode = false;
 }
 
-static int cp210x_set_chars(struct usb_serial_port *port,
-		struct cp210x_special_chars *chars)
-{
-	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
-	struct usb_serial *serial = port->serial;
-	void *dmabuf;
-	int result;
-
-	dmabuf = kmemdup(chars, sizeof(*chars), GFP_KERNEL);
-	if (!dmabuf)
-		return -ENOMEM;
-
-	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-				CP210X_SET_CHARS, REQTYPE_HOST_TO_INTERFACE, 0,
-				port_priv->bInterfaceNumber,
-				dmabuf, sizeof(*chars), USB_CTRL_SET_TIMEOUT);
-
-	kfree(dmabuf);
-
-	if (result < 0) {
-		dev_err(&port->dev, "failed to set special chars: %d\n", result);
-		return result;
-	}
-
-	return 0;
-}
-
 static bool cp210x_termios_change(const struct ktermios *a, const struct ktermios *b)
 {
 	bool iflag_change, cc_change;
@@ -1218,7 +1191,8 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 		chars.bXonChar = START_CHAR(tty);
 		chars.bXoffChar = STOP_CHAR(tty);
 
-		cp210x_set_chars(port, &chars);
+		cp210x_write_reg_block(port, CP210X_SET_CHARS, &chars,
+				sizeof(chars));
 	}
 
 	mutex_lock(&port_priv->mutex);
-- 
2.31.1

