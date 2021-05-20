Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1BD38A0A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 11:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhETJOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 05:14:50 -0400
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com ([40.107.223.89]:63201
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230361AbhETJOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:14:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3g/6vjPP445EBGDddLF7vP6AzdqomFgXNNRP1c9HwZx86Z7VdrnLkdZDVbpPHUCpFYg0LUTrguKswhj/i8RxE1gFDO4Quajs5eRpQTst0H2hy1HcLmRdjh7FBLK6il0OnxVXAb+Lc+ELw0J+OzuRbn3uUHS9IJcVh4fYU2u9hgRqwmnW4qdaCWk3fWbAxrDNz5vuhC59bUWY6xCs/jYDuRO5J7jqnfY42qJw317EB2S6IQmlla+yD7bazsIvh69C3dSqdwD2qKsPBlwIDkLjqhgfVft+WDO8Gvo2TBf39ZT1ptrcwKRPbWHUewYN2Pi/FwiWkNm1nWg+2oSPFkqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrltPjeKQpK6k6weP4bg2N3NiO6Skf0FzIewQVhU3lQ=;
 b=ZISuePEyQYMi3LmopZsAhyo/150Twdy/yIPkQtQTsG7672uvd+dq2OGmkGeNxbs4QDk5Dya/Oxz3cBV9ELF/tsq8A59lgvH3keKFvaGSNr1gnzWgot9BC5qilECwxjx2KBClNoDg8f7MqxSbJmGugBAxJ706pEaYJi8I9h8C5Y65q/jGF+8KXFO42X51Qc7Hh3UZJNs5Ajbokj8HK04nHg2KkWvIpBawpzwToj0V48PXLlMgUUHv7pgKIHbjbwYZYYSBz4bjGbCNYCSC4q97vLF6LKn9T9GgHZsDLUTPD6OGl1R0uQl+fX9Y+MAYYEnbGNhFxbjw24zSJfJV/HHbBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrltPjeKQpK6k6weP4bg2N3NiO6Skf0FzIewQVhU3lQ=;
 b=fcjslLg9fe7yT2bUGWUdOqrBWDQbm3AjmCoOjjeF2fmGohsvhVQl89CPPTkdIQQzKyOQzVd/n1tsKANsoigF+snrp7BWYCdTIg1Qt4gEGyHgo+xhdBfoTvWeJHHyBKlzoI85H/WdLpqdLZZztnO2mm/3Q6OzT41eBR8LsvpaHaU=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN8PR03MB4595.namprd03.prod.outlook.com (2603:10b6:408:9c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 09:13:27 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791%4]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 09:13:27 +0000
Date:   Thu, 20 May 2021 17:13:16 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] reset: berlin: support module build
Message-ID: <20210520171316.395de63e@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR13CA0114.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::29) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR13CA0114.namprd13.prod.outlook.com (2603:10b6:a03:2c5::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Thu, 20 May 2021 09:13:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fd2c6fa-1172-4266-97c9-08d91b6f8737
X-MS-TrafficTypeDiagnostic: BN8PR03MB4595:
X-Microsoft-Antispam-PRVS: <BN8PR03MB4595D5B29EB98315DD55BC34ED2A9@BN8PR03MB4595.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRTr35gjNtnSQaPITCA22oTcbXMfEGGC7Y5pWsIchxadHsj74w7IXX2UlB9mpz1RcmbyVXEBCskDGTOElfRKyzOlB05nDR4Ywvy59D9PPZxzVc5CaWK6HH08rVhMOYWYu/xLjvi3QqpOmzOR/zcikkhTie8L0NJrCao9RMrK9eHBC9U8WtfdJpo/AFBq3N1cije0AJOI0ttrWOMPpDsfaCA/7ZTJlWd7khrANKLn6v8uw4mFd/vSVQmGvVdsobzYPP2elfb+a5M5j9nizALbawWOlhuxlhc/0fremTdXcm9alWFTbPJQeck20lv6rQOdRhlV1G3RzLzDypwdXdGLpkOsx0mFyzVvgWpfVW+kBcWV5qqmN6Z/4oQpenR2htp+CJ7k/tAs5/o+guL3RJ4737ZWfYRocOqSMLApgPNg9HWRTGameqpRlyg6hQ4omp4pmvTEIsIh+GW53HmKf5nuutxf5/WJKOeW+Nz5yDDT6qcXSPteXNE/dmX2XmRQ3EJycAGN5wn8AxrbjGU2tg0DX44DU21xDsm43ADd4Jf6a9w1fWqS6zpn1BUBdAfRekhX75/LexoQH76qC42MLXTPTQ1mhaBcHsMMNhSMMYJvV5P/UNmBJqfVTu6Vk3t+Pgn4RygBakMahleHFjZS4l6pm+E9sE0RR76QPoQDAVRwB4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(39850400004)(346002)(136003)(66946007)(38350700002)(5660300002)(4326008)(316002)(38100700002)(478600001)(52116002)(7696005)(66556008)(16526019)(66476007)(186003)(6916009)(956004)(1076003)(6506007)(26005)(8936002)(86362001)(55016002)(6666004)(2906002)(83380400001)(8676002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?e7V5iJVNupxMNvyUkFsOqiEzxpNV3RB8Z5gDjBDDCkOCUp691hkfQiciUrN5?=
 =?us-ascii?Q?h3AYRimUEYxIVZF6P6O9bXPRDrk30n5nxGebKXge8YkfDiqVUdnAQT8kqutP?=
 =?us-ascii?Q?HXFTA4HLDUm2OCULhEfOkqLPBOUYEU2jbHrQC4NsIMnq+Jscv8Yd9eZvOogE?=
 =?us-ascii?Q?Q4wp4u5xLoBppRBhPU8AKqHDPPrIigRj70LtgQeszYV8LGl4m3ta1bX8RnqJ?=
 =?us-ascii?Q?gKOPgiM70Foms6VBXwgw0eDpwxRyJ2J79emJqK3O9d7Atp63yezvVSebEXHw?=
 =?us-ascii?Q?3JudY5n7xPmgI3SiPsY39wZtZDv7mAdaJRvrn52Vrr3pic9ubktIlPNlORRt?=
 =?us-ascii?Q?DGPOuCUBghEtSNYXjlqoTOZQR3IZvUKoghtI4kQbE2UVi//oC7tOTF0aWQy5?=
 =?us-ascii?Q?b3cxA5P6DjlP3A3zLTy2UgRjRa9hylCvaet3LXHu/E8NZP3FyXRacqjFyxFE?=
 =?us-ascii?Q?0VXOGZqKQ5XIC7Gq4h8HiOrcCZnyYAG64hAEraxpRDO8VPyImiuwTRdYm5DO?=
 =?us-ascii?Q?xiorhqmtIWPWEYM4G5fhL8EuTOiiH4VaauySuLWO2x+XJWzAUbXC7rHsl86I?=
 =?us-ascii?Q?MhkqlV05ydYBMRwy1mDpahey8VD3KfKyY9FjFOxHwf/6nOL/vFwnFcueeuSC?=
 =?us-ascii?Q?EAS5qwWr/o4iePreWC/xf9HMyWTyzSGx7/Eo/wSP12XT0URZbA3t2ObyzOVl?=
 =?us-ascii?Q?uOnm/e3kQ/8Xp6W8RSt6Px8vHNlzTkamKhajUUzVsVkM7NiBeJcP9whNfntp?=
 =?us-ascii?Q?ElaxYG6hr1T8hyukvKp3ilsCDN8dQ/vh5FhwY8VroIrx4nYj4D+DV4WyXUXQ?=
 =?us-ascii?Q?C4viOykAS0npCdY5xjZilTdXrieBs0ld4C5ZLEGN2j7dJnylh2hspDwpwELy?=
 =?us-ascii?Q?lwLNsXWJe/MlXOmoU1oZzLCVhfliZCCGlp3oilm5RtW2gIcCqW4nXmVDd9zh?=
 =?us-ascii?Q?/3tbR7ef2rzf1J5/Ax/whzbSNyFBM/Sd708uzmVxPjB24qnQD8ef0NTFudxO?=
 =?us-ascii?Q?HSRs2p1wtr2b+2d18SVAXnrXk0sO8mcSrv6fKYpFvAJyq2QjMzcMzSxjOUS5?=
 =?us-ascii?Q?zUUPI6O31BGX9AVmJ5JplfvAPgqt9T4nV296rpzkY1jUwy7imyEe7rXZ1re0?=
 =?us-ascii?Q?hhpIo3efoPhAApEL1COb58jWrug1qBP3Edo1z9LQ/rAEjPV2hdzPfX6APH94?=
 =?us-ascii?Q?MNxP1kjMuI66FNKs3Td/oJKPEyeu1Dc5zN/fJBNv5OjeDL1l6kQ46I4cF00s?=
 =?us-ascii?Q?AQ0H35Te0qBqL1hGKinJV9/URFj9KWqGY71cU0/50DrfAxAVFu3+r2j10OYw?=
 =?us-ascii?Q?dO3x4+tWknA3AlbuhsWzej/m?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd2c6fa-1172-4266-97c9-08d91b6f8737
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 09:13:27.5723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AW3oqXE6IVPUgWjzrCDfqfqazhAa3T6D469PAh2/Nj6fGSwDNZlVnl348JnVGe2iIEvMpUa9jeDmMIo4tqZHPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4595
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make reset-berlin driver to be tristate module, support to build as
a module, this is useful for GKI.

Partially revert commit ed4dba99cae8 ("reset: berlin: make it
explicitly non-modular")

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/reset/Kconfig        |  4 ++--
 drivers/reset/reset-berlin.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 3e7f55e44d84..1e7443a4dae1 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -43,8 +43,8 @@ config RESET_BCM6345
 	  This enables the reset controller driver for BCM6345 SoCs.
 
 config RESET_BERLIN
-	bool "Berlin Reset Driver" if COMPILE_TEST
-	default ARCH_BERLIN
+	tristate "Berlin Reset Driver"
+	depends on ARCH_BERLIN || COMPILE_TEST
 	help
 	  This enables the reset controller driver for Marvell Berlin SoCs.
 
diff --git a/drivers/reset/reset-berlin.c b/drivers/reset/reset-berlin.c
index 371197bbd055..72d8ea554d5f 100644
--- a/drivers/reset/reset-berlin.c
+++ b/drivers/reset/reset-berlin.c
@@ -14,7 +14,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
-#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -93,6 +93,7 @@ static const struct of_device_id berlin_reset_dt_match[] = {
 	{ .compatible = "marvell,berlin2-reset" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, berlin_reset_dt_match);
 
 static struct platform_driver berlin_reset_driver = {
 	.probe	= berlin2_reset_probe,
@@ -101,4 +102,9 @@ static struct platform_driver berlin_reset_driver = {
 		.of_match_table = berlin_reset_dt_match,
 	},
 };
-builtin_platform_driver(berlin_reset_driver);
+module_platform_driver(berlin_reset_driver);
+
+MODULE_AUTHOR("Antoine Tenart <antoine.tenart@free-electrons.com>");
+MODULE_AUTHOR("Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>");
+MODULE_DESCRIPTION("Synaptics Berlin reset controller");
+MODULE_LICENSE("GPL");
-- 
2.31.0

