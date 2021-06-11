Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3CF3A44E2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 17:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhFKP0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 11:26:34 -0400
Received: from router.aksignal.cz ([62.44.4.214]:41850 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhFKP0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 11:26:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 03A064851B;
        Fri, 11 Jun 2021 17:24:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id pFG4DSeB0dDi; Fri, 11 Jun 2021 17:24:23 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 84E9D4851A;
        Fri, 11 Jun 2021 17:24:23 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH] nvmem: eeprom: at25: fram discovery simplification
Date:   Fri, 11 Jun 2021 17:24:16 +0200
Message-Id: <20210611152416.68386-1-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed "is_fram" to bool and set it based on compatible string.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 drivers/misc/eeprom/at25.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 744f7abb22ee..4d09b672ac3c 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -69,9 +69,6 @@ struct at25_data {
  */
 #define	EE_TIMEOUT	25
 
-#define	IS_EEPROM	0
-#define	IS_FRAM		1
-
 /*-------------------------------------------------------------------------*/
 
 #define	io_limit	PAGE_SIZE	/* bytes */
@@ -363,8 +360,8 @@ static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
 }
 
 static const struct of_device_id at25_of_match[] = {
-	{ .compatible = "atmel,at25", .data = (const void *)IS_EEPROM },
-	{ .compatible = "cypress,fm25", .data = (const void *)IS_FRAM },
+	{ .compatible = "atmel,at25",},
+	{ .compatible = "cypress,fm25",},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, at25_of_match);
@@ -379,11 +376,11 @@ static int at25_probe(struct spi_device *spi)
 	u8 sernum[FM25_SN_LEN];
 	int i;
 	const struct of_device_id *match;
-	unsigned long is_fram = 0;
+	bool is_fram = 0;
 
 	match = of_match_device(of_match_ptr(at25_of_match), &spi->dev);
-	if (match)
-		is_fram = (unsigned long)match->data;
+	if (match && !strcmp(match->compatible, "cypress,fm25"))
+		is_fram = 1;
 
 	/* Chip description */
 	if (!spi->dev.platform_data) {
-- 
2.25.1

