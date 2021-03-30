Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D512034EAA2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhC3OkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231922AbhC3Oji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:39:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20335619CD;
        Tue, 30 Mar 2021 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617115178;
        bh=iPfrSBItyWuMu42ZaE4BnzALTKfr/Gm8n1bEr5jU74I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4klqeClONjxOdZOxP6lE37mfgBEZ5jd/oi00/C+X9CCiirZ8jXSBajP4i0ioC+hc
         pqGLlHNovWAnQukKdM/smcmHJUbfOJKHk6V55Xg0H1srxBjfw/QeeFYGXu9gZAh3zm
         1GvaGkcCtgy6W49aZ47jonDjfxamnakhnbRkKvcm2qi9qJ1mlZ9usZ+BXJuscUze0w
         9AA1B1wduSFX0j6VnfJiljReqqeU9yRLvMqROjbCzIcbaVSUbFfoTBP8JF3HnTtiDE
         pgIHbiDfcI4yK2JZVR4j/FgNZQlusEVUez9auz4rffJIhcx5Xk8mgaP8qnJcMlbjyC
         pPBu2uL0XDuuw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFXE-0002PL-2y; Tue, 30 Mar 2021 16:40:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] USB: serial: xr: rename GPIO-pin defines
Date:   Tue, 30 Mar 2021 16:39:28 +0200
Message-Id: <20210330143934.9197-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330143934.9197-1-johan@kernel.org>
References: <20210330143934.9197-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the GPIO-pin defines so that they reflect how they are used.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index a600448c6016..f5087a8b6c86 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -57,12 +57,12 @@ struct xr_txrx_clk_mask {
 #define XR21V141X_UART_ENABLE_TX	0x1
 #define XR21V141X_UART_ENABLE_RX	0x2
 
-#define XR21V141X_UART_MODE_RI		BIT(0)
-#define XR21V141X_UART_MODE_CD		BIT(1)
-#define XR21V141X_UART_MODE_DSR		BIT(2)
-#define XR21V141X_UART_MODE_DTR		BIT(3)
-#define XR21V141X_UART_MODE_CTS		BIT(4)
-#define XR21V141X_UART_MODE_RTS		BIT(5)
+#define XR21V141X_GPIO_RI		BIT(0)
+#define XR21V141X_GPIO_CD		BIT(1)
+#define XR21V141X_GPIO_DSR		BIT(2)
+#define XR21V141X_GPIO_DTR		BIT(3)
+#define XR21V141X_GPIO_CTS		BIT(4)
+#define XR21V141X_GPIO_RTS		BIT(5)
 
 #define XR21V141X_UART_BREAK_ON		0xff
 #define XR21V141X_UART_BREAK_OFF	0
@@ -250,12 +250,12 @@ static int xr_tiocmget(struct tty_struct *tty)
 	 * Modem control pins are active low, so reading '0' means it is active
 	 * and '1' means not active.
 	 */
-	ret = ((status & XR21V141X_UART_MODE_DTR) ? 0 : TIOCM_DTR) |
-	      ((status & XR21V141X_UART_MODE_RTS) ? 0 : TIOCM_RTS) |
-	      ((status & XR21V141X_UART_MODE_CTS) ? 0 : TIOCM_CTS) |
-	      ((status & XR21V141X_UART_MODE_DSR) ? 0 : TIOCM_DSR) |
-	      ((status & XR21V141X_UART_MODE_RI) ? 0 : TIOCM_RI) |
-	      ((status & XR21V141X_UART_MODE_CD) ? 0 : TIOCM_CD);
+	ret = ((status & XR21V141X_GPIO_DTR) ? 0 : TIOCM_DTR) |
+	      ((status & XR21V141X_GPIO_RTS) ? 0 : TIOCM_RTS) |
+	      ((status & XR21V141X_GPIO_CTS) ? 0 : TIOCM_CTS) |
+	      ((status & XR21V141X_GPIO_DSR) ? 0 : TIOCM_DSR) |
+	      ((status & XR21V141X_GPIO_RI) ? 0 : TIOCM_RI) |
+	      ((status & XR21V141X_GPIO_CD) ? 0 : TIOCM_CD);
 
 	return ret;
 }
@@ -269,13 +269,13 @@ static int xr_tiocmset_port(struct usb_serial_port *port,
 
 	/* Modem control pins are active low, so set & clr are swapped */
 	if (set & TIOCM_RTS)
-		gpio_clr |= XR21V141X_UART_MODE_RTS;
+		gpio_clr |= XR21V141X_GPIO_RTS;
 	if (set & TIOCM_DTR)
-		gpio_clr |= XR21V141X_UART_MODE_DTR;
+		gpio_clr |= XR21V141X_GPIO_DTR;
 	if (clear & TIOCM_RTS)
-		gpio_set |= XR21V141X_UART_MODE_RTS;
+		gpio_set |= XR21V141X_GPIO_RTS;
 	if (clear & TIOCM_DTR)
-		gpio_set |= XR21V141X_UART_MODE_DTR;
+		gpio_set |= XR21V141X_GPIO_DTR;
 
 	/* Writing '0' to gpio_{set/clr} bits has no effect, so no need to do */
 	if (gpio_clr)
@@ -545,7 +545,7 @@ static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
 	 * Configure DTR and RTS as outputs and RI, CD, DSR and CTS as
 	 * inputs.
 	 */
-	gpio_dir = XR21V141X_UART_MODE_DTR | XR21V141X_UART_MODE_RTS;
+	gpio_dir = XR21V141X_GPIO_DTR | XR21V141X_GPIO_RTS;
 	xr_set_reg_uart(port, XR21V141X_REG_GPIO_DIR, gpio_dir);
 
 	/* Setup termios */
-- 
2.26.3

