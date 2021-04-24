Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28D236A127
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 14:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbhDXMiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 08:38:16 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:55050 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhDXMiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 08:38:14 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Apr 2021 08:38:13 EDT
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 3E879F40539; Sat, 24 Apr 2021 14:31:00 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        devicetree@vger.kernel.org
Subject: [PATCH 4/4] misc: eeprom_93xx46: Switch based on word size, not addrlen
Date:   Sat, 24 Apr 2021 14:30:33 +0200
Message-Id: <20210424123034.11755-5-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210424123034.11755-1-linkmauve@linkmauve.fr>
References: <20210424123034.11755-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids using magic numbers based on the total size and length of an
address, where we only want to differentiate between 8-bit and 16-bit,
and finally makes 93c56 and 93c66 usable!

If the two pointer indirections is too much, we could move the flags to
the main struct instead, but I doubt it’s going to make any sensible
difference.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 2f4b39417873..afa89f71a390 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -109,12 +109,12 @@ static int eeprom_93xx46_read(void *priv, unsigned int off,
 		u16 cmd_addr = OP_READ << edev->addrlen;
 		size_t nbytes = count;
 
-		if (edev->addrlen == 7) {
-			cmd_addr |= off & 0x7f;
+		if (edev->pdata->flags & EE_ADDR8) {
+			cmd_addr |= off;
 			if (has_quirk_single_word_read(edev))
 				nbytes = 1;
 		} else {
-			cmd_addr |= (off >> 1) & 0x3f;
+			cmd_addr |= (off >> 1);
 			if (has_quirk_single_word_read(edev))
 				nbytes = 2;
 		}
@@ -173,7 +173,7 @@ static int eeprom_93xx46_ew(struct eeprom_93xx46_dev *edev, int is_on)
 	bits = edev->addrlen + 3;
 
 	cmd_addr = OP_START << edev->addrlen;
-	if (edev->addrlen == 7) {
+	if (edev->pdata->flags & EE_ADDR8) {
 		cmd_addr |= (is_on ? ADDR_EWEN : ADDR_EWDS) << 1;
 	} else {
 		cmd_addr |= (is_on ? ADDR_EWEN : ADDR_EWDS);
@@ -223,16 +223,19 @@ eeprom_93xx46_write_word(struct eeprom_93xx46_dev *edev,
 	int bits, data_len, ret;
 	u16 cmd_addr;
 
+	if (unlikely(off >= edev->size))
+		return -EINVAL;
+
 	/* The opcode in front of the address is three bits. */
 	bits = edev->addrlen + 3;
 
 	cmd_addr = OP_WRITE << edev->addrlen;
 
-	if (edev->addrlen == 7) {
-		cmd_addr |= off & 0x7f;
+	if (edev->pdata->flags & EE_ADDR8) {
+		cmd_addr |= off;
 		data_len = 1;
 	} else {
-		cmd_addr |= (off >> 1) & 0x3f;
+		cmd_addr |= (off >> 1);
 		data_len = 2;
 	}
 
@@ -272,7 +275,7 @@ static int eeprom_93xx46_write(void *priv, unsigned int off,
 		return count;
 
 	/* only write even number of bytes on 16-bit devices */
-	if (edev->addrlen == 6) {
+	if (edev->pdata->flags & EE_ADDR16) {
 		step = 2;
 		count &= ~1;
 	}
@@ -318,7 +321,7 @@ static int eeprom_93xx46_eral(struct eeprom_93xx46_dev *edev)
 	bits = edev->addrlen + 3;
 
 	cmd_addr = OP_START << edev->addrlen;
-	if (edev->addrlen == 7) {
+	if (edev->pdata->flags & EE_ADDR8) {
 		cmd_addr |= ADDR_ERAL << 1;
 	} else {
 		cmd_addr |= ADDR_ERAL;
-- 
2.31.1

