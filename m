Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029AA37A3E5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhEKJlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:41:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40620 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhEKJlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:41:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14B9e3Zl105496;
        Tue, 11 May 2021 04:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620726003;
        bh=Er4e3Wlwj5BM2A9N1DSRChljXHG2w+7/nDeq1nnE1Ho=;
        h=From:To:CC:Subject:Date;
        b=W3ixTAsBPbdwW7z+9UNrCAgwKgSqS3KWm7nTlTsiuNA4oHhEU3yhG+G1BswDq5Dbr
         9HII/L497t1Eq4E4zKU720az38HZLQS4PQvV33NAmjyEBH/65WAcr49UBaJRs3URu3
         Xzo5UH5ZaUHQFmSRv98j+eAGzjoDotbECvXxSl84=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14B9e2c2067204
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 May 2021 04:40:03 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 11
 May 2021 04:40:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 11 May 2021 04:40:02 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14B9dxBK039609;
        Tue, 11 May 2021 04:40:00 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH] mtd: spi-nor: Add documentation for spi_nor_soft_reset()
Date:   Tue, 11 May 2021 15:09:58 +0530
Message-ID: <20210511093958.17258-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document what the function does and that it should only be used when it
is known that the device supports it. This will avoid unaware
programmers thinking that they can arbitrarily use it to reset the
device.

Suggested-by: Michael Walle <michael@walle.cc>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

---

 drivers/mtd/spi-nor/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 265d8b25fc7f..59e207f2e0e3 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2988,6 +2988,21 @@ static int spi_nor_init(struct spi_nor *nor)
 	return 0;
 }
 
+/**
+ * spi_nor_soft_reset() - Perform a software reset
+ * @nor:	pointer to 'struct spi_nor'
+ *
+ * Performs a "Soft Reset and Enter Default Protocol Mode" sequence which resets
+ * the device to its power-on-reset state. This is useful when the software has
+ * made some changes to device (volatile) registers and needs to reset it before
+ * shutting down, for example.
+ *
+ * Not every flash supports this sequence. The same set of opcodes might be used
+ * for some other operation on a flash that does not support this. Support for
+ * this sequence can be discovered via SFDP in the BFPT table.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
 static void spi_nor_soft_reset(struct spi_nor *nor)
 {
 	struct spi_mem_op op;
-- 
2.30.0

