Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16401318975
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhBKL37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 06:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhBKK4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:56:45 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0719.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::719])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D84C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 02:55:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK377GeTtKk98pUt7k1b1zrW3FHtWn0MdUnbr+Sl634Q1E+tqctBPW5JJMLh9OEXlZx0sH4ioBNq3EDaemhMjmbbQls/kOoFM06+8p1HRyKLX1rO5K9hnz1q0xeSWDq/qKBa1Etpsybnf+wtPKszOXuvMzqw79q5Dxu5Voj99A9ac3nhOF/H7BeNpcB1Ye8dFQqNAn4xZvzgo/WoyKqc5fXL80W50nqxkOq5sv6MJxkpjKpHgYPDi0wI8UW/tA7kSkmvplMnWegp1Oh3h+YvitIi6J9ameHtdC04ArkqRvPZHqsUaOIzt9bEen6Blf/eouC/8/fNMBSJb3p+GnHSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqUocex7wrieHyo9H/4xGRoIcPxnwPQ1npJuJa1D3og=;
 b=ISKh0rc9lzrf/QTitWNHM8Mi80nzJeBh3xlX/1pJxl8aJ7NqCePegfZZwxj+4wiU0AaxwBxTIKjbJ3+KGlENHFGS2dnXKznXU35wHTPi/nqmADkT/j+nbfvlM9J185YBiJ8p//NVZsjTTdnRAgvNEME8HsEO9+3PNthv+s8+SaU2pjlSTdBHPeCINir0tU65l5usrEA+w5UU+NCzhBEB9AhCm0eXGIlaaQ53NlNfo7ojCLlmVP6v/Ij51+LLJmA4LG1VXSgO/U4Uc+875uJL9Kvihtnp+r6NHvmbFmgpz4+N95Za9l7B8ZlyPr68yoJOMC4Kfes8TBXEMafK2d8GoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqUocex7wrieHyo9H/4xGRoIcPxnwPQ1npJuJa1D3og=;
 b=TYxf/5sVH16IGAHfWD0rFn1/PVxhR12MNxjcOaJHk0qG+a6K7785T+wIYRyveGzAsC8qispRfYcqknx9eXVFpI6rQHcY8aw/OhboIh8IlJRLGS9MsMKxPHEdqOiNt05pjSd0S2DzioDQihm8kKYjYw5605OCVsgQrJAsdtC2Xmg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3108.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:124::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 11 Feb
 2021 10:55:43 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bc4f:2b48:88cd:f90f]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bc4f:2b48:88cd:f90f%7]) with mapi id 15.20.3825.030; Thu, 11 Feb 2021
 10:55:43 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Axel Lin <axel.lin@ingics.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] regulator: pca9450: Add SD_VSEL GPIO for LDO5
Date:   Thu, 11 Feb 2021 11:55:28 +0100
Message-Id: <20210211105534.38972-1-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.250.136.36]
X-ClientProxiedBy: AM8P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::6) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fs-work.localdomain (109.250.136.36) by AM8P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Thu, 11 Feb 2021 10:55:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5e3aad3-8fb7-40cc-dae1-08d8ce7b93a7
X-MS-TrafficTypeDiagnostic: AM0PR10MB3108:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB31082F9CD72B75186F51ED36E98C9@AM0PR10MB3108.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zP+vaA6l9VvZz5G+dKFVEHDc1t9ArcCTHcUB94fYXxRBsF8a7sxnhb38lovv8EtK1i6W7E87MW7ZBmlNhbyPBHd5m9WIPn4U+H7rX9i58hE7tkfCqlVjsspnnbbnWpCvcMl82iyeU7ts6EYsiWrsQxkIpceUL9R+QyPIf4KFy61LPo/djJ0FF3P2onlcl2O0aESUBigaWMd/FNCUjvVbfyp+akArn4pubI5kR8Mc72/nXrkEwlRbB1CmK/OP6TEJttPl+k/sb9ARPZle5AH385ez2p/SBjS5xlYeit6sGN9AHgcBIiH7y6cKP3hqgOxqiMm7zl82bRi2yz6/xWcrne7Ktuh/rrz6VuNK4Kn5AOAzud3TlqApTq+3Jo87JQ2cyjqvsxhE+ZFGBsm1SMic7Gjmy1xLdwBy5S1Q5MgsBRJHA6EHbME0NBRzeGSRVAGm4nhN2CFKGqCCpNR+L5sr4RmpuptRipHM2AnB3/s1C1XiYvSbfJ/IszlFEAQcMvJdhJ8AuNAaBzhBA5oQ9OTTjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(8676002)(52116002)(8936002)(16526019)(186003)(26005)(6506007)(316002)(956004)(66476007)(66946007)(2616005)(86362001)(66556008)(36756003)(6486002)(478600001)(5660300002)(1076003)(2906002)(54906003)(6512007)(4326008)(6666004)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?T6Pj3VP9/Kw4b6QcZTbjtq/k38w0YYaler5aB2eA3z1xaiaXYYMmNLPHFG2q?=
 =?us-ascii?Q?0O/p6XQtt+JCeF2nw80t40yIIs4zdLiWo60aCq1RdlxESI36COBYyju3AOc9?=
 =?us-ascii?Q?H5mVUr5ngPDugJKApnHwViXwD0C8eW8grBrhvcpuyRWlUjGmA5QWKGbeVieN?=
 =?us-ascii?Q?SXPNaaGH+6vTw5RmzoAnvRPeBGjHEpeueyHFdXVUHgdzpb7iAsgAk+ngsTGu?=
 =?us-ascii?Q?9meZ6WJvYZFI7n6NhA88rJNfDHfoud3ljMH82+fPXtoGsK7+a0m5Jzd9SfKv?=
 =?us-ascii?Q?UiTs2yIPz42xPjApsPp9hz3K7LUAhx7i3OfD3NVWSsXWfE1X7ZPkPSLq2o/4?=
 =?us-ascii?Q?YHMFDk6zrsUmHJ7tGiPQAH0tue0GgpYCT5rjdXB7K6UhCGVv6fAFLGH0Zzw/?=
 =?us-ascii?Q?FFotOk0TrMICfmh7nwPlDUDUU6vqoO5+uuXB/kaYFhU3M/+mQmRpC7K0WaC5?=
 =?us-ascii?Q?FK+FOugA7tZq/GUbdMIWYtV2MiakLTkHY+jEeThlEkPCGkLLoiljXcb/YnbX?=
 =?us-ascii?Q?GGsFCoL34Nmz8swFChild/1/bmM4HRf4Uq7a0TN2rjB11G2vGzIj7VNwb4ta?=
 =?us-ascii?Q?3r7opKyrURSvnUApqZ1hLEXdc8GUNaIEqYYPeFIkIJDv1wRyGEzbwn6EJ3dj?=
 =?us-ascii?Q?eHL8nWdVO4Ujf928kCnT7YuSyudGW4OhXrXs8P1JmxwDZdgfrNoOoqew3ZEH?=
 =?us-ascii?Q?SNQhiXjSMboqvQqd6FeK6gbLFqm5PuYuvIY+2OeJ+S2QQPgDyD8o/6r6Iel2?=
 =?us-ascii?Q?L2DmcJL8eM8L6tk/+h0rOv+ileN9jmcFB0+BwReVkrmBe/NM2tJJz1HNTLjD?=
 =?us-ascii?Q?vIUOczrDzHIs3LrbTWRFjYBmE+rFWVU5tmaJJL1z4OzhIuJQMGUdA42sENN4?=
 =?us-ascii?Q?8RV5ZG7cSsCjwCPFs5AEIiOLH/AVoE06eK26wyz0+q59axaePX2m0Bjo/LNw?=
 =?us-ascii?Q?czLB7Zks9pPFPgOGG6hNZF2JYAZb6uhr5oLkgxSf398yjgpMMg4zORq6nf5D?=
 =?us-ascii?Q?p/HFwhWjejWklvuUvQUCJdWMxdpcJHgeTEJ2Yg569XYWYTMYsyvjIqNeF2Ft?=
 =?us-ascii?Q?jSZLq7a90r734H8DYrDyu/XTqCyXmyYiljpP6CtRrEGUDrHuDZM6uAeIy1tI?=
 =?us-ascii?Q?gCFhxmcR38Xz79MJSl5TpF6HM87/856URXLvkfGFrlvQisf+wN8b73hFC80q?=
 =?us-ascii?Q?4yX0ReflzJRmIC+6C3sEJADUI2UzQ2eg0tLRHnAxHRFYvlOHEGe4PpJULagP?=
 =?us-ascii?Q?WGzu9eSBB1SDrkQARe3nv+H+W19JbrTVpHTWp2kkIeGqI6pEh934JiECrlAl?=
 =?us-ascii?Q?dlEOuYCy5TrmseQwV7+gWn4x?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e3aad3-8fb7-40cc-dae1-08d8ce7b93a7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 10:55:42.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4u6W47LjMIPnT0BqtNj9FJQ/lkE9X+yWByp3zVr1LwqgmDM8PchVszDAtyofoVTTDQxC38Q5SaoMeOTTKlJfeY2PnrJ5DmDRKvz7p5WXjhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

LDO5 has two separate control registers. LDO5CTRL_L is used if the
input signal SD_VSEL is low and LDO5CTRL_H if it is high.
The current driver implementation only uses LDO5CTRL_H. To make this
work on boards that have SD_VSEL connected to a GPIO, we add support
for specifying an optional GPIO and setting it to high at probe time.

In the future we might also want to add support for boards that have
SD_VSEL set to a fixed low level. In this case we need to change the
driver to be able to use the LDO5CTRL_L register.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/regulator/pca9450-regulator.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index cb29421d745a..1bba8fdcb7b7 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -32,6 +33,7 @@ struct pca9450_regulator_desc {
 struct pca9450 {
 	struct device *dev;
 	struct regmap *regmap;
+	struct gpio_desc *sd_vsel_gpio;
 	enum pca9450_chip_type type;
 	unsigned int rcnt;
 	int irq;
@@ -795,6 +797,18 @@ static int pca9450_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	/*
+	 * The driver uses the LDO5CTRL_H register to control the LDO5 regulator.
+	 * This is only valid if the SD_VSEL input of the PMIC is high. Let's
+	 * check if the pin is available as GPIO and set it to high.
+	 */
+	pca9450->sd_vsel_gpio = gpiod_get_optional(pca9450->dev, "sd-vsel", GPIOD_OUT_HIGH);
+
+	if (IS_ERR(pca9450->sd_vsel_gpio)) {
+		dev_err(&i2c->dev, "Failed to get SD_VSEL GPIO\n");
+		return ret;
+	}
+
 	dev_info(&i2c->dev, "%s probed.\n",
 		type == PCA9450_TYPE_PCA9450A ? "pca9450a" : "pca9450bc");
 
-- 
2.25.1

