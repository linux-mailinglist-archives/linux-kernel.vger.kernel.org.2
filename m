Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344AF36A12E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 14:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbhDXMi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 08:38:29 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:55074 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbhDXMiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 08:38:15 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 60320F40537; Sat, 24 Apr 2021 14:30:58 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        devicetree@vger.kernel.org
Subject: [PATCH 3/4] misc: eeprom_93xx46: Compute bits based on addrlen
Date:   Sat, 24 Apr 2021 14:30:32 +0200
Message-Id: <20210424123034.11755-4-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210424123034.11755-1-linkmauve@linkmauve.fr>
References: <20210424123034.11755-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the read case, this also moves it out of the loop.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 39375255e22a..2f4b39417873 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -86,6 +86,7 @@ static int eeprom_93xx46_read(void *priv, unsigned int off,
 	struct eeprom_93xx46_dev *edev = priv;
 	char *buf = val;
 	int err = 0;
+	int bits;
 
 	if (unlikely(off >= edev->size))
 		return 0;
@@ -99,21 +100,21 @@ static int eeprom_93xx46_read(void *priv, unsigned int off,
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
 
 		if (edev->addrlen == 7) {
 			cmd_addr |= off & 0x7f;
-			bits = 10;
 			if (has_quirk_single_word_read(edev))
 				nbytes = 1;
 		} else {
 			cmd_addr |= (off >> 1) & 0x3f;
-			bits = 9;
 			if (has_quirk_single_word_read(edev))
 				nbytes = 2;
 		}
@@ -168,13 +169,14 @@ static int eeprom_93xx46_ew(struct eeprom_93xx46_dev *edev, int is_on)
 	int bits, ret;
 	u16 cmd_addr;
 
+	/* The opcode in front of the address is three bits. */
+	bits = edev->addrlen + 3;
+
 	cmd_addr = OP_START << edev->addrlen;
 	if (edev->addrlen == 7) {
 		cmd_addr |= (is_on ? ADDR_EWEN : ADDR_EWDS) << 1;
-		bits = 10;
 	} else {
 		cmd_addr |= (is_on ? ADDR_EWEN : ADDR_EWDS);
-		bits = 9;
 	}
 
 	if (has_quirk_instruction_length(edev)) {
@@ -221,15 +223,16 @@ eeprom_93xx46_write_word(struct eeprom_93xx46_dev *edev,
 	int bits, data_len, ret;
 	u16 cmd_addr;
 
+	/* The opcode in front of the address is three bits. */
+	bits = edev->addrlen + 3;
+
 	cmd_addr = OP_WRITE << edev->addrlen;
 
 	if (edev->addrlen == 7) {
 		cmd_addr |= off & 0x7f;
-		bits = 10;
 		data_len = 1;
 	} else {
 		cmd_addr |= (off >> 1) & 0x3f;
-		bits = 9;
 		data_len = 2;
 	}
 
@@ -311,13 +314,14 @@ static int eeprom_93xx46_eral(struct eeprom_93xx46_dev *edev)
 	int bits, ret;
 	u16 cmd_addr;
 
+	/* The opcode in front of the address is three bits. */
+	bits = edev->addrlen + 3;
+
 	cmd_addr = OP_START << edev->addrlen;
 	if (edev->addrlen == 7) {
 		cmd_addr |= ADDR_ERAL << 1;
-		bits = 10;
 	} else {
 		cmd_addr |= ADDR_ERAL;
-		bits = 9;
 	}
 
 	if (has_quirk_instruction_length(edev)) {
-- 
2.31.1

