Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B2D42DE42
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhJNPjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:39:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhJNPjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:39:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9128660F59;
        Thu, 14 Oct 2021 15:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634225855;
        bh=ALDN3MhMFqzTzxdrYEkQyNbrwemtVYPY0TqR71kU+hc=;
        h=From:To:Cc:Subject:Date:From;
        b=JF7Ra+Cc9kVoB86llO2MR/kqRsJ4tIssAVpelKH2vnfrtbHajvZmgexooNAetfsuL
         1u8+hZI0tAebYmeHRugRlG/5aem+tfHCb+0nfOAs8yYOcF6jpqA5QDfM8qexR9ztrn
         2IYCCeT4WxcYUpqY9Cz4buapxDiD6rkmNtPorvYGtlWbkDt9PJw8bxIdIz2c0SIiR1
         xymNWZoRHb9F0sEvnQhKPWeerPkDbI/vJc9F6GazO0S2DmjLXo4sWYLL/QdI0sTiur
         azSs6G5OfMtqzTMMG7jzCSDnXEtqmHgXPh73q9nTUaMW7tU30vQBrp5dytIDL+jsJf
         T6d8CD4scB/4w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] eeprom: 93xx46: fix MODULE_DEVICE_TABLE
Date:   Thu, 14 Oct 2021 17:37:18 +0200
Message-Id: <20211014153730.3821376-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added SPI device ID table does not work because the
entry is incorrectly copied from the OF device table.

During build testing, this shows as a compile failure when building
it as a loadable module:

drivers/misc/eeprom/eeprom_93xx46.c:424:1: error: redefinition of '__mod_of__eeprom_93xx46_of_table_device_table'
MODULE_DEVICE_TABLE(of, eeprom_93xx46_of_table);

Change the entry to refer to the correct symbol.

Fixes: 137879f7ff23 ("eeprom: 93xx46: Add SPI device ID table")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 660ee924f8b1..1f15399e5cb4 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -421,7 +421,7 @@ static const struct spi_device_id eeprom_93xx46_spi_ids[] = {
 	  .driver_data = (kernel_ulong_t)&microchip_93lc46b_data, },
 	{}
 };
-MODULE_DEVICE_TABLE(of, eeprom_93xx46_of_table);
+MODULE_DEVICE_TABLE(spi, eeprom_93xx46_spi_ids);
 
 static int eeprom_93xx46_probe_dt(struct spi_device *spi)
 {
-- 
2.29.2

