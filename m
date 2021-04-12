Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B435A35C339
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243233AbhDLJ7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244727AbhDLJ4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:56:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72677611AD;
        Mon, 12 Apr 2021 09:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618221378;
        bh=w4x4bSIGXiaDntxJP9nzVaq93yE3UA3w4909mBR6VxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ERfR33fCd6C6+cAAh8nRwrCXtPFEUhUdTKdr+HVO0DAr7Ktxxsmf0uMNvmGTv+m5E
         mzr3OXYuevT66+LeqJ4upXs4MOTtayYSMS1pb52TxmGb9JM4cmnuLfkUc4lAVRwreR
         7nU7jb5kHuvJSRA2RzNyhpYCuTcasXdtfwA2pXSWfea81XUGiApGvlytUbTLW2wnGW
         C6ZtXBEcveXFre2bA3/LV6e8XH+z710Rg57xPJvMJur/Kp5lhTKAubX9Ut5mS8WhP5
         6cNaof5JcPUaSk0ZgejO3Unk3ghTB8aF7gkQNavYDy68IBXE2jW/vDJ75RX+SkX6oy
         hBG/9gP6guOxA==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lVtIi-0000Ka-KV; Mon, 12 Apr 2021 11:56:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] USB: serial: xr: rename GPIO-mode defines
Date:   Mon, 12 Apr 2021 11:55:47 +0200
Message-Id: <20210412095557.1213-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210412095557.1213-1-johan@kernel.org>
References: <20210412095557.1213-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the GPIO mode defines so that they reflect the datasheet and how
they are used.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 64bc9d7b948b..a600448c6016 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -88,11 +88,11 @@ struct xr_txrx_clk_mask {
 #define XR21V141X_UART_FLOW_MODE_HW	0x1
 #define XR21V141X_UART_FLOW_MODE_SW	0x2
 
-#define XR21V141X_UART_MODE_GPIO_MASK	GENMASK(2, 0)
-#define XR21V141X_UART_MODE_RTS_CTS	0x1
-#define XR21V141X_UART_MODE_DTR_DSR	0x2
-#define XR21V141X_UART_MODE_RS485	0x3
-#define XR21V141X_UART_MODE_RS485_ADDR	0x4
+#define XR21V141X_GPIO_MODE_MASK	GENMASK(2, 0)
+#define XR21V141X_GPIO_MODE_RTS_CTS	0x1
+#define XR21V141X_GPIO_MODE_DTR_DSR	0x2
+#define XR21V141X_GPIO_MODE_RS485	0x3
+#define XR21V141X_GPIO_MODE_RS485_ADDR	0x4
 
 #define XR21V141X_REG_ENABLE		0x03
 #define XR21V141X_REG_FORMAT		0x0b
@@ -433,11 +433,11 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 		return;
 
 	/* Set GPIO mode for controlling the pins manually by default. */
-	gpio_mode &= ~XR21V141X_UART_MODE_GPIO_MASK;
+	gpio_mode &= ~XR21V141X_GPIO_MODE_MASK;
 
 	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0) {
 		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
-		gpio_mode |= XR21V141X_UART_MODE_RTS_CTS;
+		gpio_mode |= XR21V141X_GPIO_MODE_RTS_CTS;
 		flow = XR21V141X_UART_FLOW_MODE_HW;
 	} else if (I_IXON(tty)) {
 		u8 start_char = START_CHAR(tty);
-- 
2.26.3

