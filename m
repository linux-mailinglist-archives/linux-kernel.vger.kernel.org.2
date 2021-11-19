Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869ED456B45
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 09:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhKSIHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 03:07:13 -0500
Received: from mail-eopbgr80118.outbound.protection.outlook.com ([40.107.8.118]:43404
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229523AbhKSIHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 03:07:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7MXKmusNV2Bk5rwbtSSBsjveoZhXtZGDuPdRF/vZXdZibPfb2o+agOH3MTHbT1ePjI8OgsrO10vwe7meHsulSMdYiG+qE1K2spO5HamcVMlDDbq64sIonfLpB8PpNQPYUlkLiMkEyVbdciVVRtxI1SmsRyZtZruGAbQi3abwnoHEr8TEIfk2q+jVM08a1mz9zKc2ZSjE/DZ8cDRidjufMasBhZYI5UQfsu+/3hQJkCf7qllQBHkrYBJ5+x41M4tIO1XAg+cjOJnVyHeUF9N2Ra7dTkotnGRGzwAa8uumd+pWkrUOLE4fqzjVP8xQNQEvdwsgaCm/zTS1bPvHCGrQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yg6A1RIFr/8V3gOCQJ6B5079lIxMsTeznp6zA/mJsE=;
 b=JqocKguE53CmB55nnooZ6uzzS8LuRUVosQpFi5N0nIc8+UGbFIz2jYP+xmdxQpc0KCU3IQC8xhJLB1vIiUXzeGtqebZg6btNQwl2NTbffuXMpfJBbQnjHMxy63jxC/F2G2T5ZG2U3Eg5qLom8doe3dEV2D0K8NZyIqjTK5mjK2ZbDdh4kSyjTUC6SezrfDB0QQWCaKs3peSOCt2e5kJthz7zMJeJ0uAJ/KtuY0GDnSHcd92SG5sel+tC2MMk2DK6dEU6UJJMOYkw4pU7trJEl5b+BRGxnsXcu5zExa+xjsNoX/DNODyXT3DSD6QmNqYYv+4dMgd0FpbfNlLQw12pFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yg6A1RIFr/8V3gOCQJ6B5079lIxMsTeznp6zA/mJsE=;
 b=MU+MglAALuoatvQEgmVCuU0B9LEg7H6MSxQCNdq/XAZ/CepxevfGiY8Z5/Sm5hK0Ofc8se8uV2G5ctnGYut5eDz+o+3tNqESlbGWFaJuQ/W5ZW2McGzmTwUCDW1MFdzCyEqRFmx3hGQoKW23iBQ66Ub75uZT9MAG9E+osf1YYmY=
Received: from AS9PR0301CA0028.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::19) by AM0PR07MB4339.eurprd07.prod.outlook.com
 (2603:10a6:208:b1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.18; Fri, 19 Nov
 2021 08:04:09 +0000
Received: from VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:468:cafe::83) by AS9PR0301CA0028.outlook.office365.com
 (2603:10a6:20b:468::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Fri, 19 Nov 2021 08:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.17)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.17; helo=fihe3nok0735.emea.nsn-net.net;
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 VE1EUR03FT045.mail.protection.outlook.com (10.152.19.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 08:04:09 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 1AJ8458T032391;
        Fri, 19 Nov 2021 08:04:05 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-mtd@lists.infradead.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: mt25qu: Ignore 6th ID byte
Date:   Fri, 19 Nov 2021 09:04:02 +0100
Message-Id: <20211119080402.20262-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 601ef7da-b4cb-4287-94aa-08d9ab332a8e
X-MS-TrafficTypeDiagnostic: AM0PR07MB4339:
X-Microsoft-Antispam-PRVS: <AM0PR07MB4339EBDBF7011553D2DA7598889C9@AM0PR07MB4339.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y2x+UVKo5jURG+v+DUNFZzYvjCR1Lhb5KjjRdouuwXLqw8aeuD7Q8/Mib2ig2xuYobn9PvyBaaw/+hiVMrnb6TtOzVJQR0hMZozoib/fL5ttfVxYDh5YMvu5Zjtv7UmCfAf5/2McI3uiypzsKrhlLXbVfKGFZsHtXC3uoalkJK0RM4obtJFVRrHn4PFcWcK5wxTMq3/I0P/WkzfYdpPqMnfYVPBxGN645dMkN6mWqBIGfqAYTCBBmpJhUqcyhj0SFDZzZ5GqJSV0Z4EwNBa/dPIz4sOOK744jZAW80RHZZ868T6jgYsgyWnRs2JOmV6lQYnHN4qb3MUAgorAxW+VcMAPnndZ4gXk2/qixWbsspLDKd1p4ebY8GOvgjivDHzy9eOqcMIknXoVgUM5ARt3zfync0OZ1uFP9BGbUDgTM164LV5R888+ThTZITRLBc3xjnqwDAbvVbMOAYI8HgMBtHJKKle4ZzPeqTTGgfd6X0gf0gjAPvDMxkv9DjyaSZcVb2gnNvrDjhWtRZAhqzg51eDN6UNPzh4OCMiWqg62iSlJLEgCaQXCVp38S6SInJe6DqulBF8tbRDOnmGyvd6PZZ8c8tPWaLSPeF+noarIXTphBLjb/wav/t1WieDhZebq+tmcGBLjibjikTzJpMsvmUT7XAlGETKPPy/gposxYQ/phwZBH2plRkQbuQy9eMrIiUUvMqLwPu96PuxSQqE64vOaigcsIpBiKC5xNOcNHJU86ZRiT8omQan+K9hOpRCTxeePtIU409DgByrroq/1H0hw2QYDJ24dg1dx2wuaUfY=
X-Forefront-Antispam-Report: CIP:131.228.2.17;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(36860700001)(82960400001)(83380400001)(6666004)(336012)(81166007)(86362001)(5660300002)(26005)(36756003)(54906003)(186003)(82310400003)(8936002)(356005)(316002)(8676002)(2616005)(1076003)(47076005)(508600001)(70206006)(70586007)(2906002)(6916009)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 08:04:09.4475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 601ef7da-b4cb-4287-94aa-08d9ab332a8e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.17];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB4339
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Ignore 6th ID byte, secure version of mt25qu256a has 0x73 as 6th byte.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 drivers/mtd/spi-nor/micron-st.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index f3d19b7..509a732 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -155,9 +155,9 @@ static const struct flash_info st_parts[] = {
 	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K |
 			      USE_FSR | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
-	{ "mt25qu256a",  INFO6(0x20bb19, 0x104400, 64 * 1024,  512,
-			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
-			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ "mt25qu256a",  INFO(0x20bb19, 0x1044, 64 * 1024,  512,
+			      SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512,
 			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
 	{ "mt25ql512a",  INFO6(0x20ba20, 0x104400, 64 * 1024, 1024,
@@ -167,9 +167,9 @@ static const struct flash_info st_parts[] = {
 			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
 			      SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
 			      SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6) },
-	{ "mt25qu512a",  INFO6(0x20bb20, 0x104400, 64 * 1024, 1024,
-			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
-			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ "mt25qu512a",  INFO(0x20bb20, 0x1044, 64 * 1024, 1024,
+			      SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024,
 			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
 			      SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
-- 
2.10.2

