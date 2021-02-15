Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281D431B922
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhBOMZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhBOMUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:20:14 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985AAC061574;
        Mon, 15 Feb 2021 04:19:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E1A72424A1;
        Mon, 15 Feb 2021 12:19:13 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/25] tty: serial: samsung_tty: Use devm_ioremap_resource
Date:   Mon, 15 Feb 2021 21:17:08 +0900
Message-Id: <20210215121713.57687-21-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215121713.57687-1-marcan@marcan.st>
References: <20210215121713.57687-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This picks up the non-posted I/O mode needed for Apple platforms to
work properly.

This removes the request/release functions, which are no longer
necessary, since devm_ioremap_resource takes care of that already. Most
other drivers already do it this way, anyway.

Also fix a bug checking the return value, which should use IS_ERR().

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/tty/serial/samsung_tty.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 821cd0e4f870..619bc4864e2a 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1572,26 +1572,11 @@ static const char *s3c24xx_serial_type(struct uart_port *port)
 	}
 }
 
-#define MAP_SIZE (0x100)
-
-static void s3c24xx_serial_release_port(struct uart_port *port)
-{
-	release_mem_region(port->mapbase, MAP_SIZE);
-}
-
-static int s3c24xx_serial_request_port(struct uart_port *port)
-{
-	const char *name = s3c24xx_serial_portname(port);
-
-	return request_mem_region(port->mapbase, MAP_SIZE, name) ? 0 : -EBUSY;
-}
-
 static void s3c24xx_serial_config_port(struct uart_port *port, int flags)
 {
 	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
 
-	if (flags & UART_CONFIG_TYPE &&
-	    s3c24xx_serial_request_port(port) == 0)
+	if (flags & UART_CONFIG_TYPE)
 		port->type = info->port_type;
 }
 
@@ -1644,8 +1629,6 @@ static struct uart_ops s3c24xx_serial_ops = {
 	.shutdown	= s3c24xx_serial_shutdown,
 	.set_termios	= s3c24xx_serial_set_termios,
 	.type		= s3c24xx_serial_type,
-	.release_port	= s3c24xx_serial_release_port,
-	.request_port	= s3c24xx_serial_request_port,
 	.config_port	= s3c24xx_serial_config_port,
 	.verify_port	= s3c24xx_serial_verify_port,
 #if defined(CONFIG_SERIAL_SAMSUNG_CONSOLE) && defined(CONFIG_CONSOLE_POLL)
@@ -1667,8 +1650,6 @@ static const struct uart_ops s3c64xx_serial_ops = {
 	.shutdown	= s3c64xx_serial_shutdown,
 	.set_termios	= s3c24xx_serial_set_termios,
 	.type		= s3c24xx_serial_type,
-	.release_port	= s3c24xx_serial_release_port,
-	.request_port	= s3c24xx_serial_request_port,
 	.config_port	= s3c24xx_serial_config_port,
 	.verify_port	= s3c24xx_serial_verify_port,
 #if defined(CONFIG_SERIAL_SAMSUNG_CONSOLE) && defined(CONFIG_CONSOLE_POLL)
@@ -1926,8 +1907,8 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 	dev_dbg(port->dev, "resource %pR)\n", res);
 
-	port->membase = devm_ioremap(port->dev, res->start, resource_size(res));
-	if (!port->membase) {
+	port->membase = devm_ioremap_resource(port->dev, res);
+	if (IS_ERR(port->membase)) {
 		dev_err(port->dev, "failed to remap controller address\n");
 		return -EBUSY;
 	}
-- 
2.30.0

