Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0DB32DC48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 22:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240713AbhCDVmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 16:42:40 -0500
Received: from marcansoft.com ([212.63.210.85]:34472 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240710AbhCDVmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 16:42:24 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C93F8426F5;
        Thu,  4 Mar 2021 21:41:35 +0000 (UTC)
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v3 19/27] tty: serial: samsung_tty: Add ucon_mask parameter
Date:   Fri,  5 Mar 2021 06:38:54 +0900
Message-Id: <20210304213902.83903-20-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304213902.83903-1-marcan@marcan.st>
References: <20210304213902.83903-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplifies the code by removing the only distinction between the
S3C2410 and S3C2440 codepaths.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/tty/serial/samsung_tty.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 78dc6e9240fb..33b421dbeb83 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -70,6 +70,7 @@ struct s3c24xx_uart_info {
 	unsigned long		num_clks;
 	unsigned long		clksel_mask;
 	unsigned long		clksel_shift;
+	unsigned long		ucon_mask;
 
 	/* uart port features */
 
@@ -1736,14 +1737,9 @@ static void s3c24xx_serial_resetport(struct uart_port *port,
 {
 	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
 	unsigned long ucon = rd_regl(port, S3C2410_UCON);
-	unsigned int ucon_mask;
 
-	ucon_mask = info->clksel_mask;
-	if (info->type == PORT_S3C2440)
-		ucon_mask |= S3C2440_UCON0_DIVMASK;
-
-	ucon &= ucon_mask;
-	wr_regl(port, S3C2410_UCON,  ucon | cfg->ucon);
+	ucon &= (info->clksel_mask | info->ucon_mask);
+	wr_regl(port, S3C2410_UCON, ucon | cfg->ucon);
 
 	/* reset both fifos */
 	wr_regl(port, S3C2410_UFCON, cfg->ufcon | S3C2410_UFCON_RESETBOTH);
@@ -2486,6 +2482,7 @@ static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
 		.num_clks	= 4,
 		.clksel_mask	= S3C2412_UCON_CLKMASK,
 		.clksel_shift	= S3C2412_UCON_CLKSHIFT,
+		.ucon_mask	= S3C2440_UCON0_DIVMASK,
 	},
 	.def_cfg = &(struct s3c2410_uartcfg) {
 		.ucon		= S3C2410_UCON_DEFAULT,
-- 
2.30.0

