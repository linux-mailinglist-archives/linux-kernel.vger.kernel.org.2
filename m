Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966C53A440A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhFKO3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:29:22 -0400
Received: from router.aksignal.cz ([62.44.4.214]:41190 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhFKO3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:29:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id EA083484CD;
        Fri, 11 Jun 2021 16:27:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id qJukQUuu46Is; Fri, 11 Jun 2021 16:27:21 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 7D4D6484CC;
        Fri, 11 Jun 2021 16:27:20 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] nvmem: eeprom: at25: fix type compiler warnings
Date:   Fri, 11 Jun 2021 16:27:06 +0200
Message-Id: <20210611142706.27336-1-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes:
drivers/misc/eeprom/at25.c:181:28: warning: field width should have type 'int',
but argument has type 'unsigned long'

drivers/misc/eeprom/at25.c:386:13: warning: cast to smaller integer type 'int'
from 'const void *'

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/misc/eeprom/at25.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 6e26de68a001..744f7abb22ee 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -178,7 +178,7 @@ static ssize_t sernum_show(struct device *dev, struct device_attribute *attr, ch
 	struct at25_data *at25;
 
 	at25 = dev_get_drvdata(dev);
-	return sysfs_emit(buf, "%*ph\n", sizeof(at25->sernum), at25->sernum);
+	return sysfs_emit(buf, "%*ph\n", (int)sizeof(at25->sernum), at25->sernum);
 }
 static DEVICE_ATTR_RO(sernum);
 
@@ -379,11 +379,11 @@ static int at25_probe(struct spi_device *spi)
 	u8 sernum[FM25_SN_LEN];
 	int i;
 	const struct of_device_id *match;
-	int is_fram = 0;
+	unsigned long is_fram = 0;
 
 	match = of_match_device(of_match_ptr(at25_of_match), &spi->dev);
 	if (match)
-		is_fram = (int)match->data;
+		is_fram = (unsigned long)match->data;
 
 	/* Chip description */
 	if (!spi->dev.platform_data) {
-- 
2.25.1

