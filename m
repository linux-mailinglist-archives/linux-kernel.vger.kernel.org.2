Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C7534EAA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhC3OkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231752AbhC3Oji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:39:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F78A619C2;
        Tue, 30 Mar 2021 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617115178;
        bh=w4x4bSIGXiaDntxJP9nzVaq93yE3UA3w4909mBR6VxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBYeqsaQYtQsKEa01PjA5lqm96fzz9JTPqPK+TFbthg8WoXptWoM+8sNNLyStZ17x
         ie4/KuNGstaY2z1N6Fduq4PM4CA+8Ffxog0EIqIOADcq5Ro3oLaRq+6+9F/nTmRtMV
         nN8um/gWeriEIROQoH7PDicBB8R2jPe66ZDNgLuImmQm+J5Gt8FKJlQFiznpsYy8ou
         JoioyLGmqX/fYnyWGBPEIKJqmD4q9KcfcYHZ6tIKJnauz2f87CUrZw7mjZFFJogweg
         p/V6GrCYXDZGAqX+22rQAFc1Vr9TuH6fqzOVcM5SdW2FUTFRo7RdW64ntUvAxu14lq
         0idAK9hfdaF0g==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFXD-0002PI-Vb; Tue, 30 Mar 2021 16:40:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] USB: serial: xr: rename GPIO-mode defines
Date:   Tue, 30 Mar 2021 16:39:27 +0200
Message-Id: <20210330143934.9197-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330143934.9197-1-johan@kernel.org>
References: <20210330143934.9197-1-johan@kernel.org>
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

