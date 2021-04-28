Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1142D36DD16
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbhD1Qe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:34:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:33858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230470AbhD1QeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:34:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BAB8FB1BB;
        Wed, 28 Apr 2021 16:33:39 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] ata: pata_rb532: Add device tree support
Date:   Wed, 28 Apr 2021 18:33:35 +0200
Message-Id: <20210428163336.73125-2-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210428163336.73125-1-tsbogend@alpha.franken.de>
References: <20210428163336.73125-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make driver also available via device tree binding.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 drivers/ata/pata_rb532_cf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 529ba28f471f..93d839ab9654 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -162,11 +162,20 @@ static int rb532_pata_driver_remove(struct platform_device *pdev)
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

