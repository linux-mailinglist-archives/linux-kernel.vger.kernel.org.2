Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512E1321AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhBVPJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:09:41 -0500
Received: from mail-eopbgr40138.outbound.protection.outlook.com ([40.107.4.138]:55390
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230443AbhBVPJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:09:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBymAwW+GTxyGSTKRpY8j5tMlj/NBUMiLBvwij17lVWly4zB7LsHnbVvrr1yvB60KLO7yefA70V+HyMqmWQBAN3L+HQDB1Z6xmTHZRy3v5cqwHa6fCpQv7i20Onuxb4/sA/2tvJohpIM+xuN6ajoiRdLr7hrXmYjukF7BHT316qNnvD1wdlIcMJSM3jwVTgGVtigEqHWMeeqmXcG+Dc18DD7PgTewrkW5mexlxttzHBjkkislDmW10AIThAqlOdc3zsL4HdBAhPI/3jPQrvrODSgxd5UtAXdT7Oi9F/gI6W0fEeTiOWHdtUHyN3cX/2Y1QVHNEH1y/5zI5rr3pPdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pPtqCUdGbTMVwbD1W6J/ZBej43b2TsVHwpRrOstmrA=;
 b=n7w+ZBukEwR56I0Qhr5v1C5ECHyDyGOwJE+80YSSopfxcEmUPzRNIT8ejERhEoBERqi8yTBxbyqHr+kQG9c/BO3eawKko9IoFZ6R7nPz6K2aULRZ2oCVV3Z+Cfl8PDrpItk0w5Fi5krrlise/w539m2mJrdIVg3ZtWBgkO6sqlM27sohzroooAjsRwOa9ER4meiUbZSCxSHktL+wysuYaixgZY5N/Z2JqobMKZ8owP7UgtEtNBfJEP4nNxO7+nvaeu67214/gIoCgS/lQFTlU0EqLv4ydgT5rbgV4FWj1m4aKUjw7LC60781jpbpDhODOlOhF3+SP7R5JKiax3nK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pPtqCUdGbTMVwbD1W6J/ZBej43b2TsVHwpRrOstmrA=;
 b=WkSmPw/aybQq3fJuUNUmQrIYKZ2bi5m1FCgYu+ikf8unDtxEKMUoLxLPUj1XLt2ufWass0CD5Hr1DODK8XnVX/24+/hOvJiaduD5r+2QWqM7ciBb5u5w98zAe+8AUyaxHTTSUpxJiavZwinOn77buby0EoMEUTbEsdBBYldtztg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM8PR10MB4308.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Mon, 22 Feb
 2021 15:08:27 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a907:416:cdde:9538]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a907:416:cdde:9538%3]) with mapi id 15.20.3868.031; Mon, 22 Feb 2021
 15:08:27 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Axel Lin <axel.lin@ingics.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: pca9450: Fix return value when failing to get sd-vsel GPIO
Date:   Mon, 22 Feb 2021 16:08:04 +0100
Message-Id: <20210222150809.208942-1-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [88.130.66.75]
X-ClientProxiedBy: AM5PR0601CA0047.eurprd06.prod.outlook.com
 (2603:10a6:203:68::33) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fs-work.localdomain (88.130.66.75) by AM5PR0601CA0047.eurprd06.prod.outlook.com (2603:10a6:203:68::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 15:08:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 484e6a75-3386-4573-b04a-08d8d743b526
X-MS-TrafficTypeDiagnostic: AM8PR10MB4308:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR10MB4308F9F7898E06FEF8708AFCE9819@AM8PR10MB4308.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BgLxLLRVasMuxd20CQClFL62sYNkBplkb9E0gQ1N5Ge1lf8RjuaItNDsCzoFmhP42mw5VrUuYS2TnjzKiSFw8KlqseVMLB27dK7ouBHBFZVHpfmgT+Z8PCpuGJq3l+Rafm8qBiiV4yWQpcNLn5GeXR9i1IMqQQHhFljaFrfFZtFw0MkrxlqYZw/wrPO+BRkeEkUT727VOTBmt97v8+gjnAA9DNk0J3awKoyuee1gX92jVono6+OLLpYN14kmYkqRVKbGOw8ADI06bWJQeVRpBGtV/iofN2Cbbny1TzLf1Dc26boCUlH6uG4gqwIXvzLq+MC/dg3U6TwenHkqE1smNWXcaLsKmxGr16Yda4MzfF4ELrXGo9QUZ3sK7QbPk5vKqsVoQx4toy1hf/dWZvCXem5o+YyGQDv7WTumvzFdHK6bYouHI/oZJqHAZ/r0TVqTQezRFdl3xeRvbgXl2Hbfvcge3Pol2LbFxF5Rp4jHd/5Q0tyMmq2FPu3Dth9Gvej26UgsBo8Bbjt5RPHqXVCkPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39850400004)(2616005)(66946007)(478600001)(26005)(2906002)(66556008)(1076003)(316002)(6666004)(86362001)(6512007)(4326008)(8936002)(8676002)(956004)(5660300002)(66476007)(186003)(6506007)(54906003)(110136005)(83380400001)(6486002)(52116002)(16526019)(4744005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YynDtGeHJ0ZMOvzQe1mMxtOUGCcvoj3KNM84lcJqPpG88ZzeWEjvGmu04JPO?=
 =?us-ascii?Q?Pkj0LDp7sArIKwp/ePyf6REe9BGd7N9KWhaeD9aF04FhJpAD+HMqEPz/KEfN?=
 =?us-ascii?Q?p67cIqUKGI55Q62310BNjQ23FxHHq3qLqMkh0wX2lwVRSwFafNosz3raRZYI?=
 =?us-ascii?Q?zFeBjoiEZ+LxqHNx905NlDv2ZWwMP1mLO37OV3i8fLhbwCJO2onBes4yr25g?=
 =?us-ascii?Q?e4UdpjGTicx7KyIOTr4cNFID7AO8kXVKzmx2ahI1gEroO85xRYSWH4lIm6cq?=
 =?us-ascii?Q?zn/355ailFeLdpUdwON2egoPA8ajDIRQyfydf+lncsQioDXDd+RUmZHnn+WR?=
 =?us-ascii?Q?c+HCgOujMEDmWt11lnh6NUSoiU+19gfQrCUfaVvjQyGWn0+CjRhCkL6g5/zu?=
 =?us-ascii?Q?zWDURSPWPFI3ONxEdlEy5EpXd74luny3oLMZimCa/FTACazuYT5av8DqsEdB?=
 =?us-ascii?Q?+RzFta3jpqwcYJuZqhixKc01VGy5YB0Z/uWcOXBSWMxXg8wSbmcD9MY6d/e7?=
 =?us-ascii?Q?ZTAlb/SE1OMBYi4XznzMEjcu8fzXlIyBbLQHCoDT3H+JM93eC0ZVXbVbVR34?=
 =?us-ascii?Q?aTh9tS3E63NYwCOrSNvFFapeaylFtBhjg3LKIsW9EYML4R5PtUYT9Qy27JI8?=
 =?us-ascii?Q?VtZ5RSRxxrcZ5TKd2YEcUAq9hBI0njyY+mN3zHWhpwKYf1ipKmversMFBMvo?=
 =?us-ascii?Q?mKkSJzJ7KF5bVDlztdI72cL+m+w5+2Hm5nQb+ufgP9BjhzkU4Kdtw9PD4oib?=
 =?us-ascii?Q?ZER/2yFuRY+ApTcI4gLDyEpaPurHZWxz6kaKhwnPqzEMaQeg5N6jfdHvE4JO?=
 =?us-ascii?Q?WufjrB5+dFO1fdn8Gr+wnqIHVzOUXYkJvZ67WaZ3RgJlFCPLXHCUoNnbEAac?=
 =?us-ascii?Q?WoQcMFGgPaewSi12mAB4IYhljjIIagvU9osHDs4eaaD+Qt6noqZSg/opCcO0?=
 =?us-ascii?Q?vpKCWnct4q8sZ3Y1tV6ZAQCFZNwiL/nKyVx5WfQxcqWhZILYtkzkoe/Q5bym?=
 =?us-ascii?Q?qLdkBHe73cRet3G3ffsK1EfLe2o3YJ68s0W7iO4TevYQEvhwmA1k4CqULnep?=
 =?us-ascii?Q?KoZI1JM0vcsmm525xb9KWb8dyRZWNbvvsoVide9QaBDtEbkUM82ug4aaqoiJ?=
 =?us-ascii?Q?CwEWtU3Lh5KMODMvkhVkL0MUskKQC0/Irl6yElcF2Zn0gm0VueOld9YZ+k6b?=
 =?us-ascii?Q?Xk7uGsnZ8y/sTFO13ZuZObI2kimD2TV7/1a7C1IU850IBENlWUV4L9UCcnYz?=
 =?us-ascii?Q?FeehdnjLRuC/PjrWgEVrngBWDt36umhe5zO99ONG20tr391/grFtiWvyzQ4a?=
 =?us-ascii?Q?F0DTuH9MX6OOntiEarDLuSbk?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 484e6a75-3386-4573-b04a-08d8d743b526
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 15:08:27.6666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: napD1kjZnfw1//jIMer5TPPtaweoUFQ9MFMKdIk3kfR8uIYSMg6v1yf/oF+JCti4mAiV9ZB7/K+7UoxJH5Znah7NiJg2tIa9duu6nfSKzII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4308
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This fixes the return value of pca9450_i2c_probe() to use the correct
error code when getting the sd-vsel GPIO fails.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/regulator/pca9450-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index d38109cc3a01..2f7ee212cb8c 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -822,7 +822,7 @@ static int pca9450_i2c_probe(struct i2c_client *i2c,
 
 	if (IS_ERR(pca9450->sd_vsel_gpio)) {
 		dev_err(&i2c->dev, "Failed to get SD_VSEL GPIO\n");
-		return ret;
+		return PTR_ERR(pca9450->sd_vsel_gpio);
 	}
 
 	dev_info(&i2c->dev, "%s probed.\n",
-- 
2.25.1

