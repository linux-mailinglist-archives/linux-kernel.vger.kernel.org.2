Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428893CA045
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbhGOOKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:10:39 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:61237
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238417AbhGOOKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:10:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAtjePNSD4wSuYhF65lcJrVNmjZ7cL2dauWxk4Q/rzOQPwokbBRHKeSLkeXP7pmkWIURKAF2lZ2jaWkzZ4YNVMKDjTMFsLkONMHtQhw2DkxkJHDAoHH1uwEl73O0NP0z3SvV2V6InuODMtsdiBD63R9b16O0IarZB4IdrhQsJ2BOt45K143hxYn8f7MRh2GgAcfTVJ+aQDG+TPphqGKz/4WlQeNn0TEY0DrMW3hQhX6xU+rBXPG7bH8718rQAkSMNgPX0DHE7hJlFUxp/cuTBm6mACfBNUBxJ3Q+1+qobUfSeGCFUUdMD96KTxzKV7xj7oie3VQW5GxqP7GYsZ6beg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0q9coj7t/hBXcxJqYoN7QpOlMIgb2dMdndNa8bRVOo=;
 b=brndv1IG7pq7DSDgvn8oMMthUJLdQpgpdBA137lfcLauFHuGQF0siR/Du1qwemeIOGBBc8QKoGemtbCLx57TQbYIHAra8/+Sc7NgQ8CrQzV1NW/2OBYMNETFT1f1Fevx3lSv/hUMk8LwPkbxGvKxiKx5zXFkUex1/bA/yRSC0nEtUNwAgwjA1co53pEIQ7vb4oKirm22bN4THK9YK34xB65eCUKUuIv5Qvnl5amEktfMqggf8jsLz0BsAOLiMsXW+IeU7e/NDjEv0BOB1V5UQmy9SrEQkaMWfyq8v62zbkRtVqs9Kq2b7eocpKBHzrQQsZs7YtFRZdhegaaBZvI4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0q9coj7t/hBXcxJqYoN7QpOlMIgb2dMdndNa8bRVOo=;
 b=HIu5+Y1J8V8wjjsoHbGOgDhO4C7G1FW/GQZIb/pdAOkEkXj1eMm1lmsUptpDArqqwposKNBfVTFjbEQJOhRUqyBsOdQJY0NpvfKYMa+jIYEkqejNgq+Ue5PnCQyXfz31UDgeh8xWn+dVZaFN3fZUZ9HUxv6i4xRrCiq0UPwEZG0=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB6813.eurprd04.prod.outlook.com (2603:10a6:803:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 15 Jul
 2021 14:07:28 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 14:07:28 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     diana.craciun@nxp.com, ioana.ciornei@nxp.com, jon@solid-run.com,
        leoyang.li@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 2/8] bus: fsl-mc: handle DMA config deferral in ACPI case
Date:   Thu, 15 Jul 2021 17:07:12 +0300
Message-Id: <20210715140718.8513-2-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::11) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM4PR0101CA0043.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24 via Frontend Transport; Thu, 15 Jul 2021 14:07:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 010eef8a-3981-4d1b-0d19-08d94799e0d4
X-MS-TrafficTypeDiagnostic: VI1PR04MB6813:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6813487E6066A7091072B551EC129@VI1PR04MB6813.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IzpzLqbOiwOd/p5yMtHf+KWAftdQJ+asgCtpigu+MOVQ8vgL08Xjo9bH16eyAVI50r1+ozLf7DaYO/FtJebMsUk3jMxsZ24CfNJnSZ7Igo4+qkl1vtprUVZIQ7IowmwjkLSxOlxjLbHIYlE0O6/GanZX2UQzUkIE89pEs1qR2B8pCBpIv9HqesPdmzljzaHRq+lFB+dZI5S6r48FO9ey3dZtyQ+mtgxxHiYlCc56QloHTNpzSknlc3PF2+Nilr/FQbXBmj5Jaet+ZttPUTP+nWayRXI9R/3f/OiXPP/FOCkwaOOcsu5GMxgddw06AcwRpgmdZB7TqFd2mytYKsCB1Qg3IIkab+BuKLVogG788GkSssNHGdFqc6mXgwO/XBdhhcGOVkZ67NM8HwHjNOdTwsh3Nwqo9vGsw+Ij67yYzUq75WAvStVg98mLRVXGXavALet0s52WSA5D5ijVprDKLCpjCnL6wJqZr4PNAXUnO255I7z5I9pUKr321ZqyD8BfoujSoWHzEwYt3QhVMw+TTEHgkWnR+/1pJh2Wl2X709t351vAZaDtiC+DABOn/sOFvTXYMPMJv4XcD+GJSmbI6Ln+pzwZPk2UY1WvfvaSGjmibm/FnDOvMuFHECZrHrOdNvXtxcgCkLxWMx0M16qOzsYyXmBrdKYuBOlTIOvE/0lRndkucLszTtgE7k+sHCD/tEICu2FqHVmWWbKdjgRoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(8676002)(6512007)(6486002)(478600001)(36756003)(2616005)(316002)(38350700002)(4326008)(38100700002)(956004)(8936002)(52116002)(9686003)(1076003)(5660300002)(6666004)(26005)(86362001)(2906002)(66556008)(66946007)(83380400001)(66476007)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jm9nnZNaJVWrXRAeGF3sTrlc6M2OCU9i9zVDJF7Xyfltuas8riQEit0aSQBm?=
 =?us-ascii?Q?vhpzUngbKLXonOVNHjuuRgnZ6ZRBNXbhfHyuRfQ0RA0DGDZP2tZHz5qm8Ylc?=
 =?us-ascii?Q?3z7nkR+yg4Wouh7fznRBYaqtjgh0wZePBiiuqCOnk2CYVMYytkYASYu/A3Mo?=
 =?us-ascii?Q?yJlP+5KybxF4IcQSZ3nHAaqmmqIICZ32qzT2kqZGn9yY5Cs5X8kiMCy9ePHe?=
 =?us-ascii?Q?nhcRf/cKkQ2RH8Ns+4xdbydak0XdpyZch71NEyKJuCeNX1V7lUunDikzJYG0?=
 =?us-ascii?Q?aR6Q9n60qvBEmMUoS+MQKspRUBWg0ny3651/wVz8s0oGWAwfHW52506k1l/b?=
 =?us-ascii?Q?+ubQCBfQgnDbu8OOXDYsk303BwcDVJc9Un0WAbuit0qm5DE1MCNGJ0MqnoRA?=
 =?us-ascii?Q?WQihP3CFXVHdisv4mfDZ4Ftog+CG9g4Wttpat+c9eevfoYGLbboSnrgz+fx7?=
 =?us-ascii?Q?Tyr09Ct9+0ToK4ndbeUrimuJPsgSW4ouQ5HHVOPvwjZx6CBaGE9L8vo5o4GK?=
 =?us-ascii?Q?Bdjj5nsew7mODDdCBymjO9l7aPuqHWBr5PZxhFskE222xPKN9gaNPmCryA/g?=
 =?us-ascii?Q?lEO7rhZIrX1c747wQU+xBBTnN1sZIhXsFky5WBjO+M/LmTU3j8eUoCQHCChR?=
 =?us-ascii?Q?P90gLxns3Mlm5kv+TzB3mz0O5hl1nmHcnz2KmFCjbjtACrutE/gCZggt3TBT?=
 =?us-ascii?Q?Va5TnzATstAFUaqFpk+2+QItxPepCMz4RvZJAFSF1jfvNM4Xtxus4Zb3BMt2?=
 =?us-ascii?Q?+iP0MQDJPa7nIigRGU3J/MVXx3hS6n3Fhv5cRojZvzs+RD6NHCL1umIXDzH7?=
 =?us-ascii?Q?5Sud/uk+CDvB9XANvcbhwkd7ohhAF/sKey/5AyNBeWF5BQNst6bxaNkznQ7l?=
 =?us-ascii?Q?m0p9nEsDrh8syey6azsnPyV7M0hprNo0wpVLQg/SdE30ls4UZIljtXYZnx+3?=
 =?us-ascii?Q?OEZk/PGPx/OtkCQwKqBle2cozED/pjcbwcMBwR9rplzgdx/+47xJlNtSOTFR?=
 =?us-ascii?Q?dFzStQgXpgqKffg8DZgF+laspTezi+oM8R1nGiPFKXSd3fBiUeqduN49o2aq?=
 =?us-ascii?Q?gYROxCWTTNwAUx2u3kVO9B9yO51gtPmocLD1iK5tGBM08togjKRPGaI7NI9f?=
 =?us-ascii?Q?X7SH2jnh1mOuUTaIFECb+XvRNXboH85BC3RxXCbXLQApb4bQ/GIqGX9GXzMK?=
 =?us-ascii?Q?3552QkFUiQER7k5eVVPbi1enr8cB0OOYYVkNZzj6lVkxGhdUADWiaQsiJxv0?=
 =?us-ascii?Q?Z5R92DuRsE5kftldNGBbgncBCJCxmJNAa04WHeNfYwGVSN8qQ5GTix7CZJjB?=
 =?us-ascii?Q?afjTpGCnCj3JGVXQYj7almNa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010eef8a-3981-4d1b-0d19-08d94799e0d4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 14:07:27.9516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGsfTjMOBl+GJ8EUU3A3jXWk5+Y+rRXcmlDf27krF7Hhe1xESO8QgWjqUYI0bEvYqO0tW43CcXUKFhVtZ8K7/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6813
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

ACPI DMA configure API may return a defer status code, so handle it.
On top of this, move the MC firmware resume after the DMA setup
is completed to avoid crashing due to DMA setup not being done yet or
being deferred.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index ffec838450f3..ffd7a1ff957a 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1089,17 +1089,6 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	}
 
 	if (mc->fsl_mc_regs) {
-		/*
-		 * Some bootloaders pause the MC firmware before booting the
-		 * kernel so that MC will not cause faults as soon as the
-		 * SMMU probes due to the fact that there's no configuration
-		 * in place for MC.
-		 * At this point MC should have all its SMMU setup done so make
-		 * sure it is resumed.
-		 */
-		writel(readl(mc->fsl_mc_regs + FSL_MC_GCR1) & (~GCR1_P1_STOP),
-		       mc->fsl_mc_regs + FSL_MC_GCR1);
-
 		if (IS_ENABLED(CONFIG_ACPI) && !dev_of_node(&pdev->dev)) {
 			mc_stream_id = readl(mc->fsl_mc_regs + FSL_MC_FAPR);
 			/*
@@ -1113,11 +1102,24 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 			error = acpi_dma_configure_id(&pdev->dev,
 						      DEV_DMA_COHERENT,
 						      &mc_stream_id);
+			if (error == -EPROBE_DEFER)
+				return error;
 			if (error)
 				dev_warn(&pdev->dev,
 					 "failed to configure dma: %d.\n",
 					 error);
 		}
+
+		/*
+		 * Some bootloaders pause the MC firmware before booting the
+		 * kernel so that MC will not cause faults as soon as the
+		 * SMMU probes due to the fact that there's no configuration
+		 * in place for MC.
+		 * At this point MC should have all its SMMU setup done so make
+		 * sure it is resumed.
+		 */
+		writel(readl(mc->fsl_mc_regs + FSL_MC_GCR1) & (~GCR1_P1_STOP),
+		       mc->fsl_mc_regs + FSL_MC_GCR1);
 	}
 
 	/*
-- 
2.17.1

