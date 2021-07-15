Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BACF3CA046
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbhGOOKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:10:40 -0400
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:8580
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231446AbhGOOKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:10:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzOfHlLqKRMQ+j8d/BPrrj6xA+fehf1327CmUMl5Wl2FXAHRJh3jf1FuWCDaQnk+2SQoTsHq04ejSsogTZnQN5h+0U8y88wLudQt7cRrSdvjg0/mcal+d4M06c043Mv/kfGCLpwnuWNaJHUfBpQdVDi+AQD0MBcRZhH7vJXrqS/vv2+6Zj3IljC+88z4hpBiTVYXfIIqMbo2uzorCzz9KSUj3Na1faKox4LUAJpYSgUCPog8FzL1LTCumDUV2K8OVY3TmeRKYWrSp219XQChN6c9iwjCwTIAknanw/UwtZOuXYELWqWueQdDYaRZ5RriDE6YjNOJPnyPyKrkN8M4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+uHhlQXMf1U0xRHZ0vjpj63qM6jQ8ON54n5efdMF4U=;
 b=B1thH8dUIpadAptyx7ft1UNB+ATCMQJedTBFgPFy8hClo+HJw3gh4BnXv4mae2bNQlPwoU97E5zlidYO6/sNbDprolaFyHIwJkp6ZNptEUTvIsqMjffrL3lATKq+dGNcS06yqbbH1xxWR1IWcg/IHKCZ2giIgexDhrE9Yusdgv9ZSoZbID6i1BDGVmD7wVTOSbdFYqXmGvlRLwA9jPQPF4nBBkKyPkhiaPsEgfWjU3Ly8Zx6jPSix7YR9RDjEpttEpQYaRWXKJHko8RR2a1mQ4cqaxbHd71H88YU3yp3H1KiCAYk2EnEqIh51WmO7nUMK+OB8dVkzawlsUs8OT6vUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+uHhlQXMf1U0xRHZ0vjpj63qM6jQ8ON54n5efdMF4U=;
 b=BVZ4E/l5zVDUJkeWf4SpnoHF6eph4En9rCqp65Nb0OlqgcPWNJCZL+S9EFKBW7eZId+8Unke/tAIEecN78Y0UaZRswvK8108rFk6quMx+rYEJz4/PP2arXR/sAIiOVnoOFdgZF+NXTahaR7upJkxyP15KV1uPb+nJnARq94izIU=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB6813.eurprd04.prod.outlook.com (2603:10a6:803:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 15 Jul
 2021 14:07:30 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 14:07:30 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     diana.craciun@nxp.com, ioana.ciornei@nxp.com, jon@solid-run.com,
        leoyang.li@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 4/8] bus: fsl-mc: add .shutdown() op for the bus driver
Date:   Thu, 15 Jul 2021 17:07:14 +0300
Message-Id: <20210715140718.8513-4-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::11) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM4PR0101CA0043.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24 via Frontend Transport; Thu, 15 Jul 2021 14:07:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49cf312b-df14-4df6-8225-08d94799e20e
X-MS-TrafficTypeDiagnostic: VI1PR04MB6813:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB68132A246E9373330952F424EC129@VI1PR04MB6813.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3IleIIeMh3FeIkxh1O5Hx6720Txn4a/WRQvpE3V70sS1ldV7zShF4ygwRn+PblJ+LPqaM6+pC/p3fYNE3hodPceCeNmeCIv619rlM23rF9ySK04gob4kgubL1vHZ3M10XdDt7fJvW8XbMq/eSKEWAgxA4JUst/WyjF3Qy7huYNRAWuSkgveoD3cTPAh36k8tJOPImMZa5/QJv1AaLx7EriZhGdoyH8fY51n+6mKmcIIX2wxKz9ZLhfX+7Ud1qVfjXwEdAiaXHfz1eGlMrDONxBdvX6mzDg10jAepOU+NQ2JqdNtP/f2Xmq7xhDh212NgyyJ2lpWsY/sNXPznNn9GDbx1y5eizgjghgK4CnT9h0XDgbEXZSpUKvD33gqnprLLCzQIJ2y1ZxSN0qJbrru3k8XQaHniHiKYJ60OtKBC6UGIw4ekWUIZWt94mpd805IzNCLpOIwIaztkIofV7vzmkSBjy3NP8oEZcY0WQJJk3KRPxB79a+lMSdgPngnygivwqdFwznRhyvMLmmTudIAqsSHCdi5jvT4Uh6ud8RbTDxVQF3DnwN6PTIiXvkgsBf8SDDeRYb0mquBmJyeMhkm++62+jIF42CQ7bKJgSeONAx7rxCVSZ8HS66oFKeuZR+VVkpwCkgzAC9w0yLRmbXUsjLWXqJDnZLjXuGzMZ0VTweaYqZ+R6ILLQdrbB7uhm+BhmoA4aB8SHkEHse2FnSK3TQLaDdKPCta1dqSW/fgV1jU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(8676002)(6512007)(6486002)(478600001)(36756003)(2616005)(316002)(38350700002)(4326008)(38100700002)(956004)(8936002)(52116002)(9686003)(1076003)(5660300002)(6666004)(26005)(86362001)(2906002)(66556008)(66946007)(66476007)(186003)(6506007)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WUt5MtSlUZ7JVJ4gSPJ/qAveMGFWP07sUDhvL0WmTXE/W4G26bVGI1W/b+0C?=
 =?us-ascii?Q?K+LUftce7806KmfmvDRFy5J2ve1F6qe34XjSW64hnxWMKG7akcHeXqG9ic/d?=
 =?us-ascii?Q?QETCRn3K9e0IeLijKZAVgFccTvFt2CLn0B3V5AcAa7/1W+L1ArIa48bv5QlB?=
 =?us-ascii?Q?GIkCoL7G1twKEBRmuJ1LMVNY7JYbV/ZB/pt2vJid+/KHjhHf3P41ErxOUgV2?=
 =?us-ascii?Q?j45BX22bwElrUoCythvpYl0Bf5j71+gtMfsPp80NtQ/AEPkGB6vgdpz80qjf?=
 =?us-ascii?Q?U+7ONPbZx2eBS7w4RCn6FWAXbJ9uktihmOmjZ6zBFEDlHQrApGHql5BNPTQg?=
 =?us-ascii?Q?/SWqN8PuzGcY+Yo8OLRlZ7LVVlhQZYcP2qkGyiXUbyrHkDktErhDKt1EDJmW?=
 =?us-ascii?Q?pIMrm/Z782LsjtJRXNyo0MEMp4oX95QDUA6Q5/iglWqdLISWqfFv4MkE4Alw?=
 =?us-ascii?Q?eXfCU5rN7tRDajBIXCwRoW5KTTnkH3OqlR0qmRnrFMVBbtznxJDcTVXA1I1y?=
 =?us-ascii?Q?1cmZH97NS8u3vzSy9n8jQmfltVUDo3tpYn0wPe/jyVpc8tAh4G+X8McjzQwp?=
 =?us-ascii?Q?Bpxlh6o5Gz8kMqejaGuTS6AVHbFcqOmRjGOxlcPNCA7mGi5cbIl7opOqQlIt?=
 =?us-ascii?Q?VOlDcDTEgdhjRY17eW3s1fwPrl5+RB30VYK3v9u0yRVPmzjq60kduLKk6T4j?=
 =?us-ascii?Q?ZWfbvs/UvWUMSbtOwjg2aHyvcq6VISoeMzUg4Ok0BUO/jme59rC/brX4yp9U?=
 =?us-ascii?Q?FcoZOJslsV5QbXOcT5w18lXXl45OzLv5to3bWgsNJdKAECj9hrYnIGGF5l9S?=
 =?us-ascii?Q?6RjZFlESH3PZ7s5PeP1okGkKqcaDYLH1Y6qd83ib6hz5NPGFtvK/ez/jwW0d?=
 =?us-ascii?Q?QX6r/JdLY9CMXS7vbbmRJnOU0a97eHykOlRHq2/OsB1SKO4fawFknTKowRsc?=
 =?us-ascii?Q?eTPIiGUNMlulfC/5lvyDyF98efKb6EmM5+hSAjt6ZXMVv5I+ro9qU2pENwn7?=
 =?us-ascii?Q?xk2bNXrJCCOu+q9d8JM4Zb1/k2i9JHnd5ZnAGLJNBLu4MYwTDTTm00JLLr1j?=
 =?us-ascii?Q?YcClmSPACEmaoTzb1DMwj+PDdJR0cuNgnsb/CKUnlexUau6lDQ49v78Hv27Y?=
 =?us-ascii?Q?qhfToD39le/byNj5xDcnJl8z906bqoImbLralewvddqR7UUAQZ94uBRmBO4H?=
 =?us-ascii?Q?j6mCQNVztrhFNxNKwIWzcEFCggvkFdEwhqLujvGEpzv2megyRynvPV+QPS7C?=
 =?us-ascii?Q?zwUTSa2WIpb4gCqpsLyXu/Bz4K/Geh/353q6Pahcqx/EULSAUjj8f1NYyD7l?=
 =?us-ascii?Q?J+X3mNBxC7NU+Pj8gM+NuVbc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cf312b-df14-4df6-8225-08d94799e20e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 14:07:30.0504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: In4/f1exXym5f/O9su672zJu6nXb8ZYgYR8ZDS01XJX6RRQJIOVE81rFs5qgYvdTZ6vclO0jx2rnQtz0AaO0oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6813
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The fsl-mc bus driver is missing the .shutdown() callback, so add it.
The implementation simply calls the .remove() callback.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 2341de6bce67..efff48b3efa5 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1206,6 +1206,11 @@ static int fsl_mc_bus_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void fsl_mc_bus_shutdown(struct platform_device *pdev)
+{
+	fsl_mc_bus_remove(pdev);
+}
+
 static const struct of_device_id fsl_mc_bus_match_table[] = {
 	{.compatible = "fsl,qoriq-mc",},
 	{},
@@ -1228,6 +1233,7 @@ static struct platform_driver fsl_mc_bus_driver = {
 		   },
 	.probe = fsl_mc_bus_probe,
 	.remove = fsl_mc_bus_remove,
+	.shutdown = fsl_mc_bus_shutdown,
 };
 
 static int __init fsl_mc_bus_driver_init(void)
-- 
2.17.1

