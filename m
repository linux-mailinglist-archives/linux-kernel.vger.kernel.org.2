Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A486C3CA042
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbhGOOKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:10:34 -0400
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:8580
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238391AbhGOOK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:10:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYZcZ6pKqCPODIY/nAFlG9vHQRM+NEzRwvMyGviT9+iv+UxTI1gqply5hGv6cKhx6LtBIR326Sxt1Z2st3Rf4dui1UQZNDAKliSSFvwWD8FwQdFNadDUx3vLHJ9KF/Qof+WQ4aY8a73aOPg/2G6ehECixepHcdt01U1djcNInPgAcsLBoz9/6Be0a+AzAWKmXcpJ1xkFyrM9PTAEaC2j52lPcxWvFe4vOZe7fMdBxHsDtjvpiGRCcYtL0EHHYtEVrDYOEmQQtZL6Udy2Kueq8+gM1TmyB/uOlhyBDYhDL+FYcdb5v5Ij3EufDgJM/+3rVwfZta8gGLj2HuSJV8kqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTCQvgEl5LvKBmJTyQvzHiwr54VMk17zUe/ZbkihnGM=;
 b=VXWDelrVP9sYC3+CXVJ8IGgLs7iURSh8XYtus/5KD6Dvqi8xtJyvxGadiwl1G6CyLTOoOqIQbUIwKQtAmLMBCJvUIfyCNhy1nHNr0SRyJOHBsKqzo2T0yViKDWmSaOowcL9YdcuV6NKQTXNTfgfH1/rjwRMo28Cn84frPVVCdGO8b0xX9Av9hZ0jCYJdpd1Ft8TiAgfPHqxayFihfVlIKYvlYLva2k5uKkweEUmfx25hFGu+2nMReawdDRNT7cK6xQ7qLYGipYDk4L1vCvkFhFSrEyOh7Y0+JYRQ5uAilYAVAKsuqlsjvNDLX0ZXFYAuzuq0DWB5atn1dB8ydZCT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTCQvgEl5LvKBmJTyQvzHiwr54VMk17zUe/ZbkihnGM=;
 b=FIm+FToxCQwF084wQb0o6T0X8BHuIPzBPFZXVANhppyvyArkBU4Op1MpFtCsvTNc34YVjK2+RckExVO96gOXR3Qfa+t3zwWQLevOu5nvyKhGKhf2sJVaGsABuSctXlzOhl2G9l32udEV2NsROl4NOD9ANxCyi1ARrEf54KVDskI=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB6813.eurprd04.prod.outlook.com (2603:10a6:803:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 15 Jul
 2021 14:07:27 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 14:07:26 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     diana.craciun@nxp.com, ioana.ciornei@nxp.com, jon@solid-run.com,
        leoyang.li@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 1/8] bus: fsl-mc: fix arg in call to dprc_scan_objects()
Date:   Thu, 15 Jul 2021 17:07:11 +0300
Message-Id: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::11) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM4PR0101CA0043.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24 via Frontend Transport; Thu, 15 Jul 2021 14:07:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8efb5d9-bf43-46c5-628f-08d94799e02b
X-MS-TrafficTypeDiagnostic: VI1PR04MB6813:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6813D8C5488F41F9A49649A2EC129@VI1PR04MB6813.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfBTZWv7XhS8/eWWX1DAA6in77z2SyUyxonnQz/x1ahlwPfljGRRyYzJGi69uLABwp+ZdSzC2dL8QJmISJ71iob6bJcWXWNL2DE0XNcOpPGjjbZWxngwYK69nVZpHQ5IaoSUG0429/FAiZ+YlBMSvULqIOFzTC5Jz7mArs6rOyo7l86VxI4O0TRPQw7hje6TCXP+DEqFgAO7fIQBP1Vxl0UyIfUYQTb62zUxLTUSlnpndi8Q7RySBFJXEKrVz+YZ+DRYJDNJtFOyC5M+8t9MjnRT/TNSdZ9ortNLxqUAEmRtrn64NdODvxy6vXNBtzPXa3w1lppUFNjJAGpV5H5FChlg6RZNwDzxZ4D2Bq1cBtakfNHi6cjW17noACBr6DkPAXIO/0pMdV3HmT8YQhMuFbtW+fg1EFgegohuZ9oWE4pToOWSMRvfFaSxmcPqmQT9aIsWJxfr7gxKIeG913ZhZhBMWjO3PLYlLhd7hVscgzx0vALN/cacUniqirZFhiGkn3lT9Asr8Kz/2kGvzt4bS5OE7nqou29bn8m4PFUUqYLhP3OY6oylI8LCChF12TkRyuI7s3t8HsBhS6qEr/6YcP5lkKwhA8Y0fw1OonNpaeLXlY8R1wcCT4U6e8frzlAUojYhAR1WZytthVwOhnys89FsbBuG7RLIwrW602LbmTgl9HpQbFxNDlECR/1KNWXsdaGAJznfLb1tC/IiFGD81g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(8676002)(6512007)(6486002)(478600001)(36756003)(2616005)(316002)(38350700002)(4326008)(38100700002)(956004)(8936002)(52116002)(9686003)(1076003)(5660300002)(6666004)(26005)(86362001)(4744005)(2906002)(66556008)(66946007)(83380400001)(66476007)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f0ruoTpCF6sygTmarpCTEO/f/gmGq0CMEs9Oy0qbHLuS3gbPSeOJsXPPhcIh?=
 =?us-ascii?Q?mk7FuYoRYkTUqCdifh9KWIgb5pnRp+A2X7nsZ3LBZW75SJemYn25Pp6stPnf?=
 =?us-ascii?Q?pijF1Tx35Qud5DGuZG17Lr8hDexAqx6v2TBab/379bkzBYdGcQZ40xVNi/jB?=
 =?us-ascii?Q?lt0DyrmdGdU0eDy7S/u++VZfCwthth5bXcUONUdaQMSkP2jC0XqUZB0kvpia?=
 =?us-ascii?Q?/D7MqTsTfQiz/3cfcU+C4sYSXRRXkEh4l5841tt+AIqTUweXOvLBJ9rUpM1w?=
 =?us-ascii?Q?xxcce3ENQiWFWlIPLyYJl55BuO5stvauSdFUyLAt9kjxvl7BtBkulmz/YWmm?=
 =?us-ascii?Q?xi72lNFiPYxEyasZhCx57cjYlChf29iKK6PCRPlXZ/ih251jMl3yM9aqo2YK?=
 =?us-ascii?Q?MAbKEr05CFeWHK3gkwU2kl8P9UU4p2zGLNXbdmbCifD2gFZgKWhHgP9XrpZk?=
 =?us-ascii?Q?xVyvuYjlstHz8Esj01wVhXhqgHqVsVX6cqBDzXlUOvieapXy4H/G87z8R6pn?=
 =?us-ascii?Q?TfcF5PVqo3/TFkg2DGvE6ZtZpNp7s0ELDcpLlY8NIZoqfIZ/r39HucZDyq8s?=
 =?us-ascii?Q?v5BCkwjQ64/LBWN2NJce0mvMrZDtIvowztM4ckDAuket7WR7xqFWlEm+4tF9?=
 =?us-ascii?Q?V/Ia6fbQUhBTq6i9x9ajwU5OKtvIIT9qUxhmyJpV1+3RzrNwysCyUNlN6EaI?=
 =?us-ascii?Q?gErsKsGkaVxKM9P61NJgRZbL9JXhAKKSoY+Hqs6SybDRzAxel7vd7SHLpOlq?=
 =?us-ascii?Q?vTwhdwBUv8JAKXKYFJqzzJoJN3mMXXbiZqdC37Qnp5WpDZ8XNqRuzUgZFY4j?=
 =?us-ascii?Q?wr7G6epkEIvcaq2Q+GzUV7pLTJqN/SfuQsatKJkVmQSjII8euHotDwXvsnC+?=
 =?us-ascii?Q?wPmYqMuf2fyDrG8i7OmkkTH05W3PIndorOLL2kOSusVrV4V8q7gDUbpWF1GL?=
 =?us-ascii?Q?cSRjo5wNu/+k/1SZjL/5YWIYKMdi5XzmrEmwVNgDCO+QRMBaLaMYAPFis0ea?=
 =?us-ascii?Q?lZ1shV67Km8qKTQbI3Gjj9+FprN/13CZ41g49H0dw8gXGwnlHAwbsa4/dUgY?=
 =?us-ascii?Q?dSddNtxDPC9JP0f1KexP3AjzUfLCX14aESrqIAK8uEyzn0BeGEq7ec1yLxzu?=
 =?us-ascii?Q?YminzzVHqzNCqXEws5wXn5smiukAYp/tsGzI4khn8Q5CMBA7hV8KCXIgFQFS?=
 =?us-ascii?Q?HKvpLkfJ2S+J9Gl2jEqdWgFTfrkmIGiKSmaGLzIbxE3VkuRjgCHdmJrDhcKg?=
 =?us-ascii?Q?g9tRxGpSvuzwl3bIe3tJihaHHDZ/U0RwPVfoJF376VeKIGtoj0CHtWLkGxV8?=
 =?us-ascii?Q?vrZogLH4wbqckO4T/BpeKWRf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8efb5d9-bf43-46c5-628f-08d94799e02b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 14:07:26.8792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4Qv8AnnWtRxTnFOy6/yOmxKTl3cMR7XVAnOeuAE2N1FB9Op9w56SK7pJ6Ku6ROou4Gu63HoH9u0yvRozSyzyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6813
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Second parameter of dprc_scan_objects() is a bool not a pointer
so change from NULL to false.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 09c8ab5e0959..ffec838450f3 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -220,7 +220,7 @@ static int scan_fsl_mc_bus(struct device *dev, void *data)
 	root_mc_dev = to_fsl_mc_device(dev);
 	root_mc_bus = to_fsl_mc_bus(root_mc_dev);
 	mutex_lock(&root_mc_bus->scan_mutex);
-	dprc_scan_objects(root_mc_dev, NULL);
+	dprc_scan_objects(root_mc_dev, false);
 	mutex_unlock(&root_mc_bus->scan_mutex);
 
 exit:
-- 
2.17.1

