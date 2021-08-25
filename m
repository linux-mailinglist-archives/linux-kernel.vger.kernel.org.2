Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DEE3F7D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 22:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhHYUvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 16:51:53 -0400
Received: from mail-db8eur05on2040.outbound.protection.outlook.com ([40.107.20.40]:32960
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242681AbhHYUvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 16:51:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUyJqvXONla1wibEGOwuV0wMOXLuEyLieZ/npFIWSDSLTjPw3mP0TpJ421UZVUN+5fxdUykDG+Iy7bzVPCFMt6ZqaKyrYutNZc/1ecGUs24TMfKmOTtrEwT97PO1RBgLPrWG2LebubfTLvcFGyruYZTS763rivwJBmxWYev8aJC8og7iWY/qPDfp9USFQ755iLy993RscYjpcKv2MPQh8OLx3fAvgZtvuwvdkCaIIicfOTBKkCD8w5BzYc5v7Kor6fqQtMc7xiGh6w7/OqmaJYdzzY0CRahgqQlEDMIYxc02A2/F6X3sbzsWV8OHreKz0xclBNDgEPcEDyN8O/LA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2gnqRLllnIByTpVCqnHbh9tlCXikZIo7ay9uQk6hlI=;
 b=Q+pDO9V2y67hMt3TLqrZIDOS18YQut/YQNRw/ZzdzOzptuQe7gDNN2pS2qZw6JUtvO1auX15zVlPXJywPi25q8OrVbdh77a8VMTXyHQzC5umAQxLsqGacxWRIuDrYXEWCnQzWzIH1Dk7yBd1Tqk87p0Uf6Auk7s6XEb7Ae0XfRgtsCvO741IPI6+svPKanR6qh2SIcJZmRyws0VMXUCHXp5MLembx1dV8soGEuVbbCXxdV78SgFTVWtq8+IDZdRbDz6uISG5eQSYW2nuLya47RPL2HSbIV3XzDnboaRVPhdm2SCrcP/jveGSUCfmqxTfPOl2ibJJE69WI3RQP7KvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2gnqRLllnIByTpVCqnHbh9tlCXikZIo7ay9uQk6hlI=;
 b=ooG1QdELzCUqxGizhKbEPK7qtFc6XchVp9IQ3pkB08FqYyNzpkDmv41/3lsMWSy/creKTb4nbZ4ZMqm8NcCb6YnQpawN+TTQ9pJKF4MNc51amYx5paG6rxjgAAtpBFT3avuNFSQKbh/wBVzMcRZdodNowlPyND5yZBwALz8n2L0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 20:51:01 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0%2]) with mapi id 15.20.4436.025; Wed, 25 Aug 2021
 20:51:01 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mfd: syscon: request a regmap with raw spinlocks for some devices
Date:   Wed, 25 Aug 2021 23:50:41 +0300
Message-Id: <20210825205041.927788-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210825205041.927788-1-vladimir.oltean@nxp.com>
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0187.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::31) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (82.78.148.104) by PR0P264CA0187.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Wed, 25 Aug 2021 20:51:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c107130-cc6f-4163-47b7-08d9680a0c3e
X-MS-TrafficTypeDiagnostic: VI1PR04MB5853:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB58538E23FBB6B1E655FB4C74E0C69@VI1PR04MB5853.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UiS3LfIDtcG+xHwineMcNXqJxRc3HkhHbc57oHAN2QHQnvzGQa2jzLscNTixOZ5DPKbCJV3I7qufS/3U2ArhBR8FX6DAD+cP7inSlpAnHKicJwzrJg7NKemXwglCs1EeDYDBD9HBfR7+Iu52GEkLJyFa5cl4nRTfUcKJMMgnRV0MQ0f2sTFhAMBcplkVztaFCzMGqkcDc3ckSh3LWVk93m249fCQTfF23Tdglm1qhR1a1iw3hhl0VrI+ZcVV9lsW7ScWlcK1Cq9M9yWB+OCu2pvZ6qjiwWDl70xfT0olRQuFIGbUDwWqxSdbEGCFaR49kX57aVmW+NHqNDHNTRfeO5p6KgGMByj/nAmLVywrXKWcoqcE8CwpZ8/GLsNetZox56DcsVtiauEP+LqdT8bytdw8wfNpa9tUKNBq7/+k4oMZa95gx7uWyppjRN3Xtgu9K/TsnXROKtqOdF3q59XI9XJ7Zcu/vLr/297d5nHhTAskEap+gqkYjXyMKa9TTR5okxdjDWu8OteSgIifIfZWkO0wCSnwk8k3XkITQI2xqi9g1/+Rrp16iWTZkHPS/Cwty3D/y0NX/iHeRrdAGPa7Q0i37I7gXf3FpxFk022rDCDign5eQmAx7zHbQpzgeEP4zJLiLrue5knhmi1+TKji99uJUS4aeDyd4znctCYd5aydnATTCTDYk0SA+ujmC+tdFu/usgtlSLfaih72SGBMog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(136003)(376002)(346002)(316002)(6666004)(36756003)(54906003)(8936002)(44832011)(83380400001)(5660300002)(86362001)(478600001)(8676002)(6916009)(6506007)(6486002)(52116002)(2616005)(66556008)(26005)(66476007)(38100700002)(38350700002)(4326008)(1076003)(956004)(2906002)(186003)(66946007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GrPFS6tGgy8mA+6GAtM46MjIL2tJ8kkMVdeSahiAigm6nsXKrpcL+OdRHenk?=
 =?us-ascii?Q?Mc60qjnqiGDdupdqB2yEZ4PjO8+g7Rsg3I3b3U4+SMib7bz/geNDohL5kSmf?=
 =?us-ascii?Q?/PYiSpwil4Vw0lsus5N8XEjmdWum6dZhzsV46YafvKvQIXSGNYm4MqyYQPIw?=
 =?us-ascii?Q?kkQLaIs3hL3Y0/OrLTMoi5sOYwFBWLhU0Ct4gXs19hq9Pghw5Cvw6L0rZJA7?=
 =?us-ascii?Q?o7ymSY4zLbYjr4mjwoElq6ZOsma7aHJ5mK3im6Gc1dUDDQK2vV+fgdGNI6El?=
 =?us-ascii?Q?Dd8wZGL8hZrlcpJJ41muDu72dGfgZuVdWMWfygLNn55p4f0F6koU/J6rZYa/?=
 =?us-ascii?Q?4rURvnXlWE0guYo42EK6wM1Yr6DV1fmoO+kFLgK7KmTCwTJj+OS13trS4FOI?=
 =?us-ascii?Q?huc9SbX0KyTpqYQ2dUI/IPcYiODRvw3ZklAurYRiSkl4LietGguG4XwrfNAo?=
 =?us-ascii?Q?EuEj3n18HY9GKNPa66r5f8KxtK85zGo1KPMJ/n74PhqY73sz6JuZ6qqRChAd?=
 =?us-ascii?Q?qeQ0j/AHk1nQosFflnKKFCPOs16okrhtiqknnC72P09SJlZgGuGU5UmV9gdt?=
 =?us-ascii?Q?H9nnqNRzqtONsjKOTN8jG2neVR05gaqkyQtmRmZ3oC2FEHvBtq8FyxWEOSwV?=
 =?us-ascii?Q?0VZSIS3dXa+eEP9hD7YQvA/e/MCjY0S0wuAP+arTVsGG4KPxbot3Mv0yvzLk?=
 =?us-ascii?Q?Tqe7ZEKr4TyDcS+a/rrQ3ITdCZndCHw85izY2RmDdsCHWsuO3IQskcg76mZL?=
 =?us-ascii?Q?jZdK4O+eoK8xPtPxgKmgWzmvbvJ4o6CYLxczOCm3FdT5csjbm3xOlxz0qrMD?=
 =?us-ascii?Q?ApR1qUF893AA7XnYB1ttXdgH/qBSZyX4UmIWgNre7rd5rRJKD0YlFUWmzZng?=
 =?us-ascii?Q?gERBKTNS1Lgq9nK5dDm6VcIRwwqbzGJlRvy7xAGIiryzlsnbIG26c4MXMFYM?=
 =?us-ascii?Q?tZYRU+QFfrYoRWKWT0I/Hn1c7yvagLQCy73z08WxB2mVuE57AIHIdrL68vSZ?=
 =?us-ascii?Q?NWrE3T16cX5rrd34bHuRVlZHtY+Zx+pAB4PTZsxyhVV/6tR0Uu8nEdYxFxT5?=
 =?us-ascii?Q?WASEoNkimJDDtCaVuVTwAWIvIB65/6lVWl3rD4FrG3lhgcPDWjDgIpac9KAZ?=
 =?us-ascii?Q?ACn6NuTDGG0z0bS6k8DA+nzMgcvEPLnZZmwVx7QL6aOx6bsMuUSlp001MgBz?=
 =?us-ascii?Q?lZNW0HW7W+GTlBppbWzlAEDzf9MY4KfjMM9ERrS/oAF8cWNSivfZJbG9s/6o?=
 =?us-ascii?Q?uyzGMlVcsWzTuBTrm8981bvCRsLz6ukX5ZzGsHCFyiE6fBVS8EFnuoIrwzrp?=
 =?us-ascii?Q?LrZNbUKsz8KziGuwh5A1OYEl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c107130-cc6f-4163-47b7-08d9680a0c3e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 20:51:01.5504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hpLPT+4AMSlcPp35pwdQ44t4sl15xqMzRc+3UNbvQJ5z+G56iKBp5wBGc8gvWkhmjgieIoJDTOVwyfvoql/og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5853
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch solves a ls-extirq irqchip driver bug in a perhaps
non-intuitive (at least non-localized) way.

The issue is that ls-extirq uses regmap, and due to the fact that it is
being called by the IRQ core under raw spinlock context, it needs to use
raw spinlocks itself. So it needs to request raw spinlocks from the
regmap config.

All is fine so far, except the ls-extirq driver does not manage its own
regmap, instead it uses syscon_node_to_regmap() to get it from the
parent syscon (this driver).

Because the syscon regmap is initialized before any of the consumer
drivers (ls-extirq) probe, we need to know beforehand whether to request
raw spinlocks or not.

The solution seems to be to check some compatible string. The ls-extirq
driver probes on quite a few NXP Layerscape SoCs, all with different
compatible strings. This is potentially fragile and subject to bit rot
(since the fix is not localized to the ls-extirq driver, adding new
compatible strings there but not here seems plausible). Anyway, it is
probably the best we can do without major rework.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/mfd/syscon.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 765c0210cb52..70da4e87b072 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -83,6 +83,22 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	if (ret)
 		reg_io_width = 4;
 
+	/*
+	 * We might be providing a regmap to e.g. an irqchip driver, and in
+	 * that case, normal spinlocks won't do: the IRQ core holds raw
+	 * spinlocks, so it needs to be raw spinlocks all the way down.
+	 * Detect those drivers here (currently "ls-extirq") and request raw
+	 * spinlocks in the regmap config for them.
+	 */
+	if (of_device_is_compatible(np, "fsl,lx2160a-isc") ||
+	    of_device_is_compatible(np, "fsl,ls2080a-isc") ||
+	    of_device_is_compatible(np, "fsl,ls2080a-isc") ||
+	    of_device_is_compatible(np, "fsl,ls1088a-isc") ||
+	    of_device_is_compatible(np, "fsl,ls1043a-scfg") ||
+	    of_device_is_compatible(np, "fsl,ls1046a-scfg") ||
+	    of_device_is_compatible(np, "fsl,ls1021a-scfg"))
+		syscon_config.use_raw_spinlock = true;
+
 	ret = of_hwspin_lock_get_id(np, 0);
 	if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret == 0)) {
 		syscon_config.use_hwlock = true;
-- 
2.25.1

