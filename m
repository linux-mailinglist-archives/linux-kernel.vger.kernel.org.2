Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9A3318956
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhBKLYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 06:24:10 -0500
Received: from mail-eopbgr140123.outbound.protection.outlook.com ([40.107.14.123]:27008
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230469AbhBKK4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:56:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auLrAsVeG2xxr4wjimITqG8V1BkI4IQIA6oC2LowyWP5kgZeQgDykaW6dYm6b4u7ouYN4glBkBwA/lfzUB6IpGHaNFdQYcQ82j3vft1WW3M8E+uqka80jDt2Y9HkUbeUfU8gQrmYzDDkRWTauPw7aRwVykecsSSov6XiNOj9wIvS7nW2FBocvjcBnGx/vbS+9c88f8iJDkFMJupfiA1xx/a7NDrioyhMU1tC2qRbYm6y8j68seSb3QgMi/daqB7+LxjRr6a7MB0Poj5aEPywxe5VMgSKpFORcJ8K4bBm+sDV/16XKAhdemadsCiTylEDKCxcCMv5N6s2UE8PZvbc6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZZ1aTakMFGRfcVkeJM5pZcFHchNl+6+TcF5cOVg5EI=;
 b=oKhh2wmh7r2VVYlMep0TQgYYz5uZ85XefAU9CUQRbtynP/A0Vh4asQlndQUbb1zSC0L3xhQbrtgrTCYhXyHUubaDxNG4Yx7B1fr2PVXfS43qLC9Uhp3jXahxxoe7I92zQ0te9OcsZCnqr624LRkzshRlpsrH1HSD0T13sWOs9/pzsNKU2ES+PX7+P0lqRO+i/B1bx8JNudg7mK3jeQtBOv+Z3qJrO0v6NQ99pH/zu6QA77KCNEq6KGhjiOn5/4+dRljOkTLFwTrYBeu0NKmjppuVrTYfLGSVOkM4aRTOYGSR5DK1gEmaxAoIkg78aSX5U3a2AOOCtoFJIEK5qAXjeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZZ1aTakMFGRfcVkeJM5pZcFHchNl+6+TcF5cOVg5EI=;
 b=BL/yvU1LI0YwT2q/24+EjjKhNVjY8EnGhkgoEprFh0SSB0nmyXsxPRWTeji+uFltpSJZuys3eRh5N2MBFno5g9jL8aiS5rHrpCPbO3m7pLpqi4Bwt0RY4iPpouk7F88ipKT1PrebvrKDJnqsmsVCBUBeMSKSXoDjRodt6HqpXUs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3170.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:180::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 11 Feb
 2021 10:55:59 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bc4f:2b48:88cd:f90f]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bc4f:2b48:88cd:f90f%7]) with mapi id 15.20.3825.030; Thu, 11 Feb 2021
 10:55:59 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Robin Gong <yibin.gong@nxp.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Axel Lin <axel.lin@ingics.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] regulator: pca9450: Enable system reset on WDOG_B assertion
Date:   Thu, 11 Feb 2021 11:55:30 +0100
Message-Id: <20210211105534.38972-3-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211105534.38972-1-frieder.schrempf@kontron.de>
References: <20210211105534.38972-1-frieder.schrempf@kontron.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.250.136.36]
X-ClientProxiedBy: AM8P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::6) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fs-work.localdomain (109.250.136.36) by AM8P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Thu, 11 Feb 2021 10:55:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 131d22ac-7a42-47c8-1d29-08d8ce7b9d4a
X-MS-TrafficTypeDiagnostic: AM0PR10MB3170:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB31706B15550FD988641FA92EE98C9@AM0PR10MB3170.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oY3Ko+flWdWQzGL/xiSrxCZ8CNce8xqH2Mlx6PqcYpbNRupRX0tuSBWDR8lgHQqO1FPCRIylr902z/spWwDiXsTCwSbcARshTNP4N946eNtobTYklWKLb3Oqnprd4HYYEpNSIakOqS606ZrPcuyqqJqivPaFFJJfdQ0GyxWBZe+N1FY8W6DP6enOcZCmS08oOTVzOMWelfuKRSKZe2BPadtOlU8W2xagSTIH0Sea1TssZ+Wp2F+2IrvAC7Yr/YMqe1oVTUt3re9w9JPa0DKfMjK8CWzEokmaP0t5ZUOAGUF3QY9iFRMX7JSKyMaKhqNSSydtoA0Ft08QyDT6CUUMvcHWGnkqyt64xMKLWTsOfnRsg/K7FFpkdnQcCGAG4FNaATh8uzrML0Eu91aoXVI0tuSa8vF4SySCZ/BCqF9KDQqRTuqGVGSLm8g7Lnz4SPm0Bvk206x/PN8e0UqI+vhC0FZHGSTUS1LndcX+RE0w3S5FGkcsZVVkCcvSdkxeqd9KADi+obq74cne/G5jOQ7+5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(6506007)(956004)(2616005)(110136005)(16526019)(186003)(6666004)(36756003)(86362001)(26005)(6512007)(316002)(83380400001)(6486002)(4326008)(478600001)(8676002)(5660300002)(2906002)(1076003)(52116002)(54906003)(8936002)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2ArmD234GfaVUExTNnDQZbUGT9hb/zm6VheRd5DJiRJKJM/CH4teMPurB8Ib?=
 =?us-ascii?Q?RoE7baFCLQEUFZoJ4FIUwW72/b0kh1xUzbjM3vjkx233brpORXQFIrddDCRt?=
 =?us-ascii?Q?kJ+Cy5okV21fSajJyD13b17IydVYyP+MuJKE6TwgXaGpIOJVj7pkR8p+9zAh?=
 =?us-ascii?Q?+IVOz8cMFtM2YspKz/oNmnlWQ6nNsTVGjbxARde1TsUskL3EXHw3LmTk8ZiI?=
 =?us-ascii?Q?zQxJf5pDuX8GZ/agllZOC8lGjk4HvLCrSe3NJr406P9iUkdPwTCbK593Y0lj?=
 =?us-ascii?Q?BBHOehcc19k+Njkd5wCT9nVpleSPH6y8y7QeNaxty3LFV4Zkm4ajPI3C1S8j?=
 =?us-ascii?Q?QBJb3GiKrKv/cas31a7Qng/2Ui74m6He2xJSr07ifqnNzHxNSLnANfIJNLyd?=
 =?us-ascii?Q?yHe29AuhQ1Yg0FHSR1St1GxDbImxPWVhkQ3qRvhoh85bKjgwtJb3aTnQdAbf?=
 =?us-ascii?Q?JFARgIjCL5ijkhzd5jZGyXcWXhkd/v6emPnMoEI9+29N1jTFq6c9mADOgKDf?=
 =?us-ascii?Q?LuRxDn0EfNh9sMLdFQO2NUu3aH/mc+//vJV/p9p1on9lNf+bJcrlFoMNMbOy?=
 =?us-ascii?Q?1BigEmfkMnSDfsnrQZyhUbbiOi5uKyZCwsO2M+insmPLt2+uqyIkR5rajY6c?=
 =?us-ascii?Q?/dSaueZE5QNbKLPr9LqObQhHxxHnzYLbjAjx1TlGm9cSRF5OzITBS1LNiXqG?=
 =?us-ascii?Q?lRl0EliKd/P1Czv1M6BF7y4mRqfpmX3hgX9nPtCfFU4DDYvaNA0rzS0CBLV3?=
 =?us-ascii?Q?ILHvbpVIDEczo6gp9VDw2FmsMbQK+6kIOBLdU6dR5hb8f5k8uCODicvhZ4zs?=
 =?us-ascii?Q?gJzEy+dlITsCcwCMN57BtsAzfm9tOLttTGscnm836W93zAN0Yia71hCdkHfE?=
 =?us-ascii?Q?U1YQ4e/4L/C2ny7z7uUdcO0JMyrLopJPFPNMCOY0Vq2O4UD+sAfK/7Fmt6Ms?=
 =?us-ascii?Q?QuVIUkXaXXvdFCs18scYyGQslu/LDoKVneY3HQ6wuDPcpmUez+//TDLy0v+j?=
 =?us-ascii?Q?f33Zv1j2yagvhTEcB3yaBUyPj7dIL4/Wm3cOax5K+0yg9XyIVBSASdhGRRkm?=
 =?us-ascii?Q?sHWj/87JJJNxCAI3keatMSVnRMYL8uUbzB90lHaYf0YsLVjTYuzIVenzHYA0?=
 =?us-ascii?Q?HwHmRuUq6vvStwNGJYYncE5OrDyTs+CqEjhAKdqNFVCZXa35JaHG6E9zFIPi?=
 =?us-ascii?Q?roQeQYQQDPVMX3skgwD4gHhSG+uKPD4XMNFV5JYIAb15uka4Xwya61cLuMSG?=
 =?us-ascii?Q?gcSLoUF6QO8vaSPlZXIfnAF2ycGeNXOxEfwXRJ6rjdDAaMzIBRSV02+Gwb0U?=
 =?us-ascii?Q?WbItCdWO5XiITdseEkr/Qj2t?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 131d22ac-7a42-47c8-1d29-08d8ce7b9d4a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 10:55:59.1502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzZAMIk3mZqSET8mWK3/npCMSxQeC7T5UU0lnHRKwSOL2A7anEuUP3fCQH2dwagP5L0VnJavPif2lAi+fOOy+qfYdXmRePURg87E2FUg/YY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3170
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

By default the PCA9450 doesn't handle the assertion of the WDOG_B
signal, but this is required to guarantee that things like software
resets triggered by the watchdog work reliably.

As we don't want to rely on the bootloader to enable this, we tell
the PMIC to issue a cold reset in case the WDOG_B signal is
asserted (WDOG_B_CFG = 10), just as the NXP U-Boot code does.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/regulator/pca9450-regulator.c | 8 ++++++++
 include/linux/regulator/pca9450.h     | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 1bba8fdcb7b7..833d398c6aa2 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -797,6 +797,14 @@ static int pca9450_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	/* Set reset behavior on assertion of WDOG_B signal */
+	ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_RESET_CTRL,
+				WDOG_B_CFG_MASK, WDOG_B_CFG_COLD_LDO12);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to set WDOG_B reset behavior\n");
+		return ret;
+	}
+
 	/*
 	 * The driver uses the LDO5CTRL_H register to control the LDO5 regulator.
 	 * This is only valid if the SD_VSEL input of the PMIC is high. Let's
diff --git a/include/linux/regulator/pca9450.h b/include/linux/regulator/pca9450.h
index 1bbd3014f906..ccdb5320a240 100644
--- a/include/linux/regulator/pca9450.h
+++ b/include/linux/regulator/pca9450.h
@@ -216,4 +216,11 @@ enum {
 #define IRQ_THERM_105			0x02
 #define IRQ_THERM_125			0x01
 
+/* PCA9450_REG_RESET_CTRL bits */
+#define WDOG_B_CFG_MASK			0xC0
+#define WDOG_B_CFG_NONE			0x00
+#define WDOG_B_CFG_WARM			0x40
+#define WDOG_B_CFG_COLD_LDO12		0x80
+#define WDOG_B_CFG_COLD			0xC0
+
 #endif /* __LINUX_REG_PCA9450_H__ */
-- 
2.25.1

