Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3372936A12C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 14:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbhDXMiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 08:38:21 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:55054 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhDXMiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 08:38:14 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id B9BE6F40534; Sat, 24 Apr 2021 14:30:55 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        devicetree@vger.kernel.org
Subject: [PATCH 2/4] misc: eeprom_93xx46: set size and addrlen according to the dts
Date:   Sat, 24 Apr 2021 14:30:31 +0200
Message-Id: <20210424123034.11755-3-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210424123034.11755-1-linkmauve@linkmauve.fr>
References: <20210424123034.11755-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can then be used by the rest of the driver to use the correct
commands on 93c56 and 93c66.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 64dd76f66463..39375255e22a 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -18,6 +18,7 @@
 #include <linux/spi/spi.h>
 #include <linux/nvmem-provider.h>
 #include <linux/eeprom_93xx46.h>
+#include <linux/log2.h>
 
 #define OP_START	0x4
 #define OP_WRITE	(OP_START | 0x1)
@@ -474,10 +475,22 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 	if (!edev)
 		return -ENOMEM;
 
+	if (pd->flags & EE_SIZE1K)
+		edev->size = 128;
+	else if (pd->flags & EE_SIZE2K)
+		edev->size = 256;
+	else if (pd->flags & EE_SIZE4K)
+		edev->size = 512;
+	else {
+		dev_err(&spi->dev, "unspecified size\n");
+		err = -EINVAL;
+		goto fail;
+	}
+
 	if (pd->flags & EE_ADDR8)
-		edev->addrlen = 7;
+		edev->addrlen = ilog2(edev->size);
 	else if (pd->flags & EE_ADDR16)
-		edev->addrlen = 6;
+		edev->addrlen = ilog2(edev->size) - 1;
 	else {
 		dev_err(&spi->dev, "unspecified address type\n");
 		return -EINVAL;
@@ -488,7 +501,6 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 	edev->spi = spi;
 	edev->pdata = pd;
 
-	edev->size = 128;
 	edev->nvmem_config.type = NVMEM_TYPE_EEPROM;
 	edev->nvmem_config.name = dev_name(&spi->dev);
 	edev->nvmem_config.dev = &spi->dev;
@@ -508,8 +520,9 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 	if (IS_ERR(edev->nvmem))
 		return PTR_ERR(edev->nvmem);
 
-	dev_info(&spi->dev, "%d-bit eeprom %s\n",
+	dev_info(&spi->dev, "%d-bit eeprom containing %d bytes %s\n",
 		(pd->flags & EE_ADDR8) ? 8 : 16,
+		edev->size,
 		(pd->flags & EE_READONLY) ? "(readonly)" : "");
 
 	if (!(pd->flags & EE_READONLY)) {
-- 
2.31.1

