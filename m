Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D3841C3EC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbhI2L4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:56:39 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:49921 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343523AbhI2L4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:56:11 -0400
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id E8698C81;
        Wed, 29 Sep 2021 04:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1632916470;
        bh=Y009K+RO8RDHvkwOXnnVGdcXcV27deDObF+gK4oQAV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e1JR3ccgRHn33ud6tMgC1CMeeRisKIlAAgrBRm7eb6hSGpyGrdolKwcy7HVnjgYQk
         PNAz2XS/8sH8jKzNjRq3hHsPjLgkukc3El2ZdjBfGCg1RbDxoUuzgZfUkDPi+piwd/
         RC1TN5yznTetYwWE5qOhl0+22V/KcVmBL31QXIEc=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     openbmc@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Zev Weiss <zev@bewilderbeest.net>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] mtd: spi-nor: aspeed: Don't automatically attach reserved chips
Date:   Wed, 29 Sep 2021 04:54:07 -0700
Message-Id: <20210929115409.21254-6-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210929115409.21254-1-zev@bewilderbeest.net>
References: <20210929115409.21254-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this change, any flash chips under the controller that are marked
with a DT status of "reserved" will be created, but not automatically
attached.  Userspace can later request that they be attached using the
attach_chip sysfs file.

This is to accommodate situations where a chip may be (for example)
shared with another controller external to the SoC and require
userspace to arbitrate access to it prior to actually attaching it.
(such as a firmware SPI flash shared between a BMC and the host
system).

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/mtd/spi-nor/controllers/aspeed-smc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/controllers/aspeed-smc.c b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
index da49192a8220..328b008fafb2 100644
--- a/drivers/mtd/spi-nor/controllers/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
@@ -826,10 +826,14 @@ static int aspeed_smc_setup_flash(struct aspeed_smc_controller *controller,
 	unsigned int cs;
 	int ret = -ENODEV;
 
-	for_each_available_child_of_node(np, child) {
+	for_each_child_of_node(np, child) {
 		struct aspeed_smc_chip *chip;
 		struct spi_nor *nor;
 
+		/* Skip disabled nodes, but include reserved ones for later attachment */
+		if (!of_device_is_available(child) && !of_device_is_reserved(child))
+			continue;
+
 		/* This driver does not support NAND or NOR flash devices. */
 		if (!of_device_is_compatible(child, "jedec,spi-nor"))
 			continue;
@@ -873,6 +877,9 @@ static int aspeed_smc_setup_flash(struct aspeed_smc_controller *controller,
 
 		controller->chips[cs] = chip;
 
+		if (of_device_is_reserved(child))
+			continue;
+
 		ret = aspeed_smc_register_chip(chip);
 		if (ret)
 			break;
-- 
2.33.0

