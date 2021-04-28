Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F59936DD13
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbhD1Qe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:34:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:33838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240747AbhD1QeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:34:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF240B122;
        Wed, 28 Apr 2021 16:33:38 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ata: pata_rb532: Make driver COMPILE_TESTable
Date:   Wed, 28 Apr 2021 18:33:34 +0200
Message-Id: <20210428163336.73125-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By removing the not needed #include <asm/mach-rc32434/rb.h> driver
could be COMPILE_TESTed.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 drivers/ata/Kconfig         | 2 +-
 drivers/ata/pata_rb532_cf.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

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
index 479c4b29b856..529ba28f471f 100644
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
-- 
2.29.2

