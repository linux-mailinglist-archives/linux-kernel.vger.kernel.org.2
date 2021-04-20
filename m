Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823EC365ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhDTOFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:05:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:55012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhDTOE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:04:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10E2BAD8A;
        Tue, 20 Apr 2021 14:04:26 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ata: pata_rb532: Add OF support and make COMPILE_TESTable
Date:   Tue, 20 Apr 2021 16:04:21 +0200
Message-Id: <20210420140422.88253-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add OF support for switching RB532 do device tree possible. By removing
the not needed asm/mach-rc32434/rb.h include the driver could be
compile tested now.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 drivers/ata/Kconfig         |  2 +-
 drivers/ata/pata_rb532_cf.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 030cb32da980..53f40f92e4eb 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1139,7 +1139,7 @@ config PATA_QDI
 
 config PATA_RB532
 	tristate "RouterBoard 532 PATA CompactFlash support"
-	depends on MIKROTIK_RB532
+	depends on MIKROTIK_RB532 || COMPILE_TEST
 	help
 	  This option enables support for the RouterBoard 532
 	  PATA CompactFlash controller.
diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 479c4b29b856..93d839ab9654 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -28,8 +28,6 @@
 #include <linux/libata.h>
 #include <scsi/scsi_host.h>
 
-#include <asm/mach-rc32434/rb.h>
-
 #define DRV_NAME	"pata-rb532-cf"
 #define DRV_VERSION	"0.1.0"
 #define DRV_DESC	"PATA driver for RouterBOARD 532 Compact Flash"
@@ -164,11 +162,20 @@ static int rb532_pata_driver_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id pata_rb532_match[] = {
+	{ .compatible = "mikrotik,rb532-pata", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pata_rb532_match);
+#endif
+
 static struct platform_driver rb532_pata_platform_driver = {
 	.probe		= rb532_pata_driver_probe,
 	.remove		= rb532_pata_driver_remove,
 	.driver	 = {
 		.name   = DRV_NAME,
+		.of_match_table = of_match_ptr(pata_rb532_match),
 	},
 };
 
-- 
2.29.2

