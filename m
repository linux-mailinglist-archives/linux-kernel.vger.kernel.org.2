Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1500936A32D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 23:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbhDXV0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 17:26:33 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:32860 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhDXV0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 17:26:32 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 3CC73F40538; Sat, 24 Apr 2021 23:25:51 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        linux-kernel@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] misc: eeprom_93xx46: Remove hardcoded bit lengths
Date:   Sat, 24 Apr 2021 23:25:41 +0200
Message-Id: <20210424212543.13929-2-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210424212543.13929-1-linkmauve@linkmauve.fr>
References: <20210424123034.11755-1-linkmauve@linkmauve.fr>
 <20210424212543.13929-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids using magic numbers based on the length of an address or a
command, while we only want to differentiate between 8-bit and 16-bit.

The driver was previously wrapping around the offset in the write
operation, this now returns -EINVAL instead (but should never happen in
the first place).

If two pointer indirections are too many, we could move the flags to the
main struct instead, but I doubt it’s going to make any sensible
difference on any hardware.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 57 ++++++++++++++++-------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 80114f4c80ad..ffdb8e5a26e0 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
@@ -70,6 +71,7 @@ static int eeprom_93xx46_read(void *priv, unsigned int off,
 	struct eeprom_93xx46_dev *edev = priv;
 	char *buf = val;
 	int err = 0;
+	int bits;
 
 	if (unlikely(off >= edev->size))
 		return 0;
@@ -83,21 +85,21 @@ static int eeprom_93xx46_read(void *priv, unsigned int off,
 	if (edev->pdata->prepare)
 		edev->pdata->prepare(edev);
 
+	/* The opcode in front of the address is three bits. */
+	bits = edev->addrlen + 3;
+
 	while (count) {
 		struct spi_message m;
 		struct spi_transfer t[2] = { { 0 } };
 		u16 cmd_addr = OP_READ << edev->addrlen;
 		size_t nbytes = count;
-		int bits;
 
-		if (edev->addrlen == 7) {
-			cmd_addr |= off & 0x7f;
-			bits = 10;
+		if (edev->pdata->flags & EE_ADDR8) {
+			cmd_addr |= off;
 			if (has_quirk_single_word_read(edev))
 				nbytes = 1;
 		} else {
-			cmd_addr |= (off >> 1) & 0x3f;
-			bits = 9;
+			cmd_addr |= (off >> 1);
 			if (has_quirk_single_word_read(edev))
 				nbytes = 2;
 		}
@@ -152,14 +154,14 @@ static int eeprom_93xx46_ew(struct eeprom_93xx46_dev *edev, int is_on)
 	int bits, ret;
 	u16 cmd_addr;
 
+	/* The opcode in front of the address is three bits. */
+	bits = edev->addrlen + 3;
+
 	cmd_addr = OP_START << edev->addrlen;
-	if (edev->addrlen == 7) {
+	if (edev->pdata->flags & EE_ADDR8)
 		cmd_addr |= (is_on ? ADDR_EWEN : ADDR_EWDS) << 1;
-		bits = 10;
-	} else {
+	else
 		cmd_addr |= (is_on ? ADDR_EWEN : ADDR_EWDS);
-		bits = 9;
-	}
 
 	if (has_quirk_instruction_length(edev)) {
 		cmd_addr <<= 2;
@@ -205,15 +207,19 @@ eeprom_93xx46_write_word(struct eeprom_93xx46_dev *edev,
 	int bits, data_len, ret;
 	u16 cmd_addr;
 
+	if (unlikely(off >= edev->size))
+		return -EINVAL;
+
+	/* The opcode in front of the address is three bits. */
+	bits = edev->addrlen + 3;
+
 	cmd_addr = OP_WRITE << edev->addrlen;
 
-	if (edev->addrlen == 7) {
-		cmd_addr |= off & 0x7f;
-		bits = 10;
+	if (edev->pdata->flags & EE_ADDR8) {
+		cmd_addr |= off;
 		data_len = 1;
 	} else {
-		cmd_addr |= (off >> 1) & 0x3f;
-		bits = 9;
+		cmd_addr |= (off >> 1);
 		data_len = 2;
 	}
 
@@ -253,7 +259,7 @@ static int eeprom_93xx46_write(void *priv, unsigned int off,
 		return count;
 
 	/* only write even number of bytes on 16-bit devices */
-	if (edev->addrlen == 6) {
+	if (edev->pdata->flags & EE_ADDR16) {
 		step = 2;
 		count &= ~1;
 	}
@@ -295,14 +301,14 @@ static int eeprom_93xx46_eral(struct eeprom_93xx46_dev *edev)
 	int bits, ret;
 	u16 cmd_addr;
 
+	/* The opcode in front of the address is three bits. */
+	bits = edev->addrlen + 3;
+
 	cmd_addr = OP_START << edev->addrlen;
-	if (edev->addrlen == 7) {
+	if (edev->pdata->flags & EE_ADDR8)
 		cmd_addr |= ADDR_ERAL << 1;
-		bits = 10;
-	} else {
+	else
 		cmd_addr |= ADDR_ERAL;
-		bits = 9;
-	}
 
 	if (has_quirk_instruction_length(edev)) {
 		cmd_addr <<= 2;
@@ -455,10 +461,12 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 	if (!edev)
 		return -ENOMEM;
 
+	edev->size = 128;
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
@@ -469,7 +477,6 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 	edev->spi = spi;
 	edev->pdata = pd;
 
-	edev->size = 128;
 	edev->nvmem_config.type = NVMEM_TYPE_EEPROM;
 	edev->nvmem_config.name = dev_name(&spi->dev);
 	edev->nvmem_config.dev = &spi->dev;
-- 
2.31.1

