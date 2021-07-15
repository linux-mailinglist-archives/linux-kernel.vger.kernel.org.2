Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76F33C9A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbhGOI0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:26:09 -0400
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:38884
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240720AbhGOI0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:26:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kqwl75E6ucaLjC/q0ggaA5vvytPhV1Hx7pYSbJ4uJbcdikCgRAVL0WBcgPke8EiDKSjZQIBTicoxE6DZC42RQTiQp3h3N7jr9bypGr6hS5Qc0Zc15ucqzqlw8rwQ/5/JfwERYQHB5WIfW6HIAO/m3aa9IQAHTpQ9t+zJ3e0iSza0jIXRC3i8gm05SF8ahqtXbQdgVWwcos2xute6cInbHyxykEVXPjnY/8zLKBWJj+SYkks0rls1aY/fc0lSpsF1MnxipvCIW6G8by1MQPr2AwK29iXBUuO3Ed0MTCyp0TgYxll8y4eowVXgrLRn4TTrFUYxvG+8WTAQ1ntH9GcyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls6fGOJNPBTG9DB1XIg7D71kmBM8VyA9hl9+bGbLZMk=;
 b=XlZbrOGiXGufVxzjIsATARK7VK6E1qPSc/WteiDZmsUOdAyF44xHBxrVcS+0NinMYv6RCKWTSFek0Z+Z3eMZnpqaONl8b8SmzYSrGYIe6cylDWJ7Mbj6c2p0KeOP7neOzkn/vII/MUKzAn1THLfQS5YXUPQy78xJb6lxl+e67Qvg2BHPJJhHm1+dvZ6dTNLZNuTOgnoye4xV09SrdPo9mg3N1/FOXnCF/gfEe8m3Kf5gys+aGSrCqoSHlAWhA4sJeNCtshJ+Um6v6yOM7cxRGu4TDVoIe4V0Cl7JvCTBxHrQjvyMa0mq0C+AJ2oTQ4z+dOOlkE7tpbzXcCgRqDcR1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls6fGOJNPBTG9DB1XIg7D71kmBM8VyA9hl9+bGbLZMk=;
 b=T/bHgrySgQAw9IEStGYWJLfXgNlDVeElVAHXA+o84Q7BEZu9wDibNEkAn4DDeilSznW02tam/F46l6U+S4wwtBfv0uLGowZPVSrFlSFDbJ5Vto9t8LwbwwG9w/9r9315pKqbFK9us1dpV5vDVpIBAGQ9ropvBUwjHqRHX3N36JI=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR04MB4167.eurprd04.prod.outlook.com (2603:10a6:209:4e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 08:23:12 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 08:23:12 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, vitor.soares@synopsys.com,
        boris.brezillon@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        xiaoning.wang@nxp.com
Subject: [PATCH 4/4] i3c: master: svc: set ODSTOP to let I2C device see the STOP signal
Date:   Thu, 15 Jul 2021 16:24:13 +0800
Message-Id: <20210715082413.3042149-5-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715082413.3042149-1-xiaoning.wang@nxp.com>
References: <20210715082413.3042149-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0142.apcprd03.prod.outlook.com
 (2603:1096:4:c8::15) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR03CA0142.apcprd03.prod.outlook.com (2603:1096:4:c8::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend Transport; Thu, 15 Jul 2021 08:23:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d2ccbbe-afbf-4bef-7263-08d94769c95c
X-MS-TrafficTypeDiagnostic: AM6PR04MB4167:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB41674FCC779F32978C90DEEFF3129@AM6PR04MB4167.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gz96Mr94W21Ygbgwf731HUpf/t8hqK3eFCNloEzxKlhvOywj9DkVWrCt6aJXAuUdX4jv0nOE6X/UxVm6nN30IKSphYgcYSSLES/BYJC7dh+b/NxocE6YjJFL8PDDorJvPyYcj85G4FKGBi2YDWSpBGVnDe+Ubwl/sumHTDjoXQnboLnVVItmxUszWmVLAsDjCGerdNVkMCGTraKLS16otLChuR9KZ7dDLA6sSWYeGBlFnQhRoOck32y01mB8jXmxbXflLsp3C5cbi+96fyIi53P/MiTA09zII7fyydXPmG10dm10P4zcWVrlQIbxRVnG5Fz2tqALmWBlFMS2DJMhmpjHJdXhjc4Kf085q+SbBIsE4ncwpJHQGogBMjOgkBQ5Ea8pxp8VKkjyXNvxlO7hNmed93L37Oa92sOY+i/UqkiN+/nts3xUWqQFNzveWi9r5bUIsQgUOg8vWtOW1sYYoVmticFo+ND385oTJASmxTF72+9qIpUnqKABYk9utudrGebEdU3lLowGUtb3C4maQdT97JDZmw8NtBBebG+T2QqoQ5P1I4HFCBdyJeS5UHFNqEHtawn1F5QzvUiDz0ulw3ir7wX3KPV/cgWOEAVZ+tLButBYmsHe1lmC2Vz6j6GWG4lNzc95q4gTUwYhfWv5Pkjxg5AhcKPXh++Eu6a/KVaPAMTTsPvY/FmgSN5jV/T8nFk2Snc6GcmGGc2TUU3eLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(6512007)(478600001)(4326008)(83380400001)(8676002)(8936002)(66946007)(86362001)(316002)(36756003)(2906002)(2616005)(52116002)(1076003)(956004)(5660300002)(38350700002)(6506007)(38100700002)(66476007)(186003)(26005)(6486002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FE1dF6/KhBj9nTNG2Y9ALcn5ChLfpZzXpJ44QmHGaU4Qy0QN3RmxUI2pCMvS?=
 =?us-ascii?Q?HMDXZ2cZbW4YbmbMuTLp1LpWtn5EZaiE9UyEpWT2Sbr9OBQ7zfwN9m1Mrmx4?=
 =?us-ascii?Q?rhKRPP0kTEOU57z2G7ozAEivGYwvvuePV933Nb95WYTBiteujY8UdKZo8EP5?=
 =?us-ascii?Q?6nHknOA63rBru5X23AhfFG6NJOilUkkaeNsJWMyA4Jq/5TbetWvqBLMPwMO6?=
 =?us-ascii?Q?GrujPw7UIE7WTFbtXH5YE1M0ZHSARZITndYf/gM/PO9pr37D70l3lT2KgsAr?=
 =?us-ascii?Q?Kz/25NXFvugQ7kP1gLQ6M0FnhVXyINoNHXr82Cph1zVXRM97bj0v8WUtjCLy?=
 =?us-ascii?Q?mlKE5Xl2O9gNg0hmrfc+t/mshgghJ7kUm2DwWGoNhlKKJ1OVPVmTaVsX6SP8?=
 =?us-ascii?Q?U/8qS/VB3UHNlZgAdNjwebgYmhY117bxUbC/rwc9VOYU0Vt3ZDLK6HpUarxZ?=
 =?us-ascii?Q?d6CxaIIeWiHLYxXnlOp9LZW1NzbNNzeeLdqxssLiej74ihTlK/XK9JZps2ub?=
 =?us-ascii?Q?9sUbzCsYSG8nHwo48DLmPSQACMXLp9UzZ5S4+/y5bgS/cr2L69fTyCpfP2rO?=
 =?us-ascii?Q?iFhswYv/iO7kYntWxwY8U4c0ckRr+IKxjp/O4TMhlg8pqBXScRtukMyOwxoL?=
 =?us-ascii?Q?NT1BrydohYPQt8VY4AHbtxbLsZzwWs+rEosqNBP+D1Xppc/N/D7avHUnG9Kb?=
 =?us-ascii?Q?xma2IqBZHUDXVsAT/U7GhVHdYCwSpokGZGzeie7jjsZFBLgUiWUwOfE/oBG7?=
 =?us-ascii?Q?s2cEuq4tr3mPBPy6H4mR2FNSnYutL5t9UMMU8L7T/jjD+w2UpMV1SZW7FxRm?=
 =?us-ascii?Q?NwVEKpkdSftTe5xdsauANmov7/WE0f9eOIeVBGEu77k3Rswc07fKMSrE4GXj?=
 =?us-ascii?Q?XhvcIulQ/nbxkmqLK3yNlwhEo33q/bL4f+VbPfUO+u4uWx18KZg/9MH8c684?=
 =?us-ascii?Q?FiCGddhSe4YrI+LrmwSeUejZu/bRKD+6eiiOcZ7ILiMRGm0GSS+fnRsayLUc?=
 =?us-ascii?Q?igyPKKzebOQD86ZUbpurIvgV03NET159tnqGWCRB6Dk+C8JT4PMBtBqqvwz8?=
 =?us-ascii?Q?3r/Zw+QsNaDTfWTGyzwGoLCZuywCfUKIvqDU5s1AzT+/Iru9ykrMMNGKuNB0?=
 =?us-ascii?Q?coSNoT1F5yMfmyda97ugKZaga+2KpK2a2FH8TJkIa1MxLRdC4BA9Z82Y2C4B?=
 =?us-ascii?Q?oKkrYmO7B1cNeeNkiJZgp810Fs6fRZ5V5xLD7PdnVfX0Pn54hiKf/WCT/F8U?=
 =?us-ascii?Q?I8iopx/9/7pAbeP7WBLd8/WtwdENbIKVS79/YIDlBm+uHTQ9yTDo61kaWcBJ?=
 =?us-ascii?Q?L+yncm5C8hMnplImrDliyAzl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2ccbbe-afbf-4bef-7263-08d94769c95c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 08:23:12.7741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5tiyw0Cgim/QSMYweEWDhK/I5YxoW9qISvrrYXGFtK/w38WdHYJ6LqrV6w9+Lq4/yu9aKg5G8oCpoqEqvu9kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4167
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If using I2C/I3C mixed mode, need to set ODSTOP. Otherwise, the I2C
devices cannot see the stop signal. It may cause message sending errors.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 892e57fec4b0..b05cc7f521e6 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -449,7 +449,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	struct i3c_device_info info = {};
 	unsigned long fclk_rate, fclk_period_ns;
 	unsigned int high_period_ns, od_low_period_ns;
-	u32 ppbaud, pplow, odhpp, odbaud, i2cbaud, reg;
+	u32 ppbaud, pplow, odhpp, odbaud, odstop, i2cbaud, reg;
 	int ret;
 
 	/* Timings derivation */
@@ -479,6 +479,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	switch (bus->mode) {
 	case I3C_BUS_MODE_PURE:
 		i2cbaud = 0;
+		odstop = 0;
 		break;
 	case I3C_BUS_MODE_MIXED_FAST:
 	case I3C_BUS_MODE_MIXED_LIMITED:
@@ -487,6 +488,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 		 * between the high and low period does not really matter.
 		 */
 		i2cbaud = DIV_ROUND_UP(1000, od_low_period_ns) - 2;
+		odstop = 1;
 		break;
 	case I3C_BUS_MODE_MIXED_SLOW:
 		/*
@@ -494,6 +496,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 		 * constraints as the FM+ mode.
 		 */
 		i2cbaud = DIV_ROUND_UP(2500, od_low_period_ns) - 2;
+		odstop = 1;
 		break;
 	default:
 		return -EINVAL;
@@ -502,7 +505,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	reg = SVC_I3C_MCONFIG_MASTER_EN |
 	      SVC_I3C_MCONFIG_DISTO(0) |
 	      SVC_I3C_MCONFIG_HKEEP(0) |
-	      SVC_I3C_MCONFIG_ODSTOP(0) |
+	      SVC_I3C_MCONFIG_ODSTOP(odstop) |
 	      SVC_I3C_MCONFIG_PPBAUD(ppbaud) |
 	      SVC_I3C_MCONFIG_PPLOW(pplow) |
 	      SVC_I3C_MCONFIG_ODBAUD(odbaud) |
-- 
2.25.1

