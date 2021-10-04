Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C23420913
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhJDKL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:11:59 -0400
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]:53197
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230337AbhJDKL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:11:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9AX0c49YyXKM/H2Rj4nSDWtL/lrsxskh+JmBtwoCZWQzctBqD8d99GgFa5CtUygolM/HJTF4Wy77tpu8byI6VTEITrq9LnHGsD/G7qaoJ3lpVA2WUkQQYC8dxEEN54na08/chzE1miIklqcEjd0n9xY0BUGrpLv3SwytzNRHo2JV7C0dDYGy/AVnahyqpSYuENTf38GZLaFA+uP4wLcpsNeaynI0Ev0kdP2ZsPSAyZ1bQtlr7K+Gh7/MW2xJjgnPz7mMxMZSfqGbNW6wnibX9jTrTrZ3eglLnJAqjWOzl1DBOJeIvXMqVusVladNNKH7E3ZHZCUbvbE/h7auW5oPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TWVKMKSYP2z/IW+ova1SkKb88LKs9dC/45cSQ1gTKw=;
 b=B5s0ptQ9s4l+Z0Ejl0j0G4eSr58Olspt2NacDfJjCDoV/7YB3SYSRzxkOKGwQw9sYe8NZ+gxaWqmLkjvu2gGfJsMEsMQ6CRQetcWG/KTFAyYrc+drS1qDeqxOyWR/pZwoYhvJPzzbt52sucshRsXV4T16yf2Cz446m3OPPynUg4raQu+1pa1i27SB/mPpXOFxcPVWY1pvXbGJf6K5wesdQjpiV7Wyw+nhYi34seMy2WycbYpfno/O1dgDKUiZieZXXOQjINhzzN2GRZ/B64zweOEvpdzMchgrj5bywORU3rg4UUv25PxfMkh3xQoPzNAOkzlkXt6rIE4vKWet3mikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TWVKMKSYP2z/IW+ova1SkKb88LKs9dC/45cSQ1gTKw=;
 b=Wp/aDLAfBQPUS+3eVvdg5Xgu4lmD5VuzW9mLVFt/NHCd+c9gPixHbnba6QwlKhNe4SBQxI++C6bFbe1Y2vbwScnQxnIWzE8+3zL6j7x8tTqKV2SCcGIrImMI97lOfT7ZcvktocQtuaOBjXhaih+Rkneleaa9XBBs9oWjloIv2r0=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VE1PR04MB7231.eurprd04.prod.outlook.com (2603:10a6:800:1a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Mon, 4 Oct
 2021 10:10:05 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::e948:b382:34fc:c923]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::e948:b382:34fc:c923%7]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 10:10:05 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     leoyang.li@nxp.com, youri.querry_1@oss.nxp.com,
        ioana.ciornei@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH] soc: dpio: fix cleanup on error
Date:   Mon,  4 Oct 2021 13:09:44 +0300
Message-Id: <20211004100944.15023-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0501CA0063.eurprd05.prod.outlook.com
 (2603:10a6:200:68::31) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
Received: from fsr-ub1864-101.ea.freescale.net (92.120.5.2) by AM4PR0501CA0063.eurprd05.prod.outlook.com (2603:10a6:200:68::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Mon, 4 Oct 2021 10:10:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 664f360b-dcab-47ae-be40-08d9871f2322
X-MS-TrafficTypeDiagnostic: VE1PR04MB7231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB7231D82C9D6DAF601339D319ECAE9@VE1PR04MB7231.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: srzVxjQXvyOkyNf5Kk6LY7IuOaUW625tzBY3YR8DL4+Q/OxpNGblgiL8upY346jHLxaMy6BokFLdzpeciurL5JEoBVH5LjMi1n3CSErTAMlDe4oteucgqU0+1LkLyMA8ComGcXDBIqoVerG3kANVhM1KkDCpqV2gc/kpTHvSBN+37/Hby/NkffXZLXXTBx8bQ/Mc1uZw5EmwzbiX++dKnwQonDLtChPnuc22I1SD6TSYoqG8AhNTfUPyNLQ7m493DMfR3fYMgGKXuO71H3j5IjIkuRZ0V5yHedBnnM1p6JRiStxNDYp4rNXutt1wNfED0nIBuE+mPc9PfTu5FK771wxmEkb5BKiknP/LUZxIokXFmPN/ggCOwpE58v52WOlJogB/dFBQiTdWXDHoYCIXoHyxEyjLEP0HBUp4x4dg01lAyZgj6i7g/BTZcKdxwG+AI6HyVw8kr28wAjL+jEi/GbExmD9B4zIMG4b1aguC8mr9fZnCGYz6V8LFg08rIXSfgPGUWUV48MSyyybNECAFglcmpWJQFktENxXpqdmTJb9R/SAtNTusNnu5In3oBdY9SGtKYyBNzlDz6NfH1I1UKpqC6J+BnaU0lii+IVNExiScA3RyV7iRfcPUc0PFhscRUGWwW6mzl75EqKkJ6dNE9n6qthiLnr6KzmKS63SlFEt84rPkzIy7kbYki3+AxuOQvITx0P6w6fKXOvMjVbRkEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(2906002)(83380400001)(26005)(6506007)(86362001)(4326008)(36756003)(52116002)(8676002)(44832011)(66946007)(5660300002)(66476007)(66556008)(6512007)(1076003)(38350700002)(6666004)(508600001)(316002)(38100700002)(8936002)(956004)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XNj0E7tNmF6BEkYD1RhwXyuFMGrkA0+aJW3lu8ILnujoV/Xfh4M6lNOiZckS?=
 =?us-ascii?Q?7AsV5ZSCns2XjeDs155ySgl3qjuUDnpYyjySzr/XaifFqBoOdYz6cJT+CwlC?=
 =?us-ascii?Q?21MhyCp9qeYMD62gYLjE2pcLXHG/Kmvl71iTDQ5DOpwYuHRUh4fMXl3j5CNH?=
 =?us-ascii?Q?gNVkFQzPUFF13EEhvbNRVPjkM56MLm9StRkXaGSBvjHCKSBLH0KgBewbPISQ?=
 =?us-ascii?Q?CkGUT6b40eLFXIqGQ8FJjmdI7w+I3Gjr476YxNFltFGPzWRs5mM90xbqeu0S?=
 =?us-ascii?Q?aJKDDcfOW6fP+pEdbXoA0ONKBqInUiI5KoXkO063uoBgx2qZU8B7pGxjW3XZ?=
 =?us-ascii?Q?9Ziylttl41PxAskBMPrlcKnTZuKUFJMWx2hjrMdWV1qvfPs/aZrtcHjz2cGq?=
 =?us-ascii?Q?KpSD0sYAkgrobgR8thAbJd5h1i8CyREF2OU9qsJ3HTixE1NX1dIk4OGzClUD?=
 =?us-ascii?Q?WDq1IKbXtpjh6DRCc9hS19eDhhmA66Kn9LoT8buwLMvwXhDHh2EWrTlK9B2c?=
 =?us-ascii?Q?LqqqOIws1Ejve5c0gikFemY4YCNL6tbSwsFRP+LRxoS0u4xFZpnxsSaXP7bb?=
 =?us-ascii?Q?vDh9liYOcAqkbK/r+9azHsTdmGGzQ4S6mvteX3dSMfgCDpFbxtwH7GrGbCPL?=
 =?us-ascii?Q?rPOVQYnfMmbPXnPtD2vqhpbQE27ATDTXCvsRem43CN0oafqsnNd0tfG3HoPp?=
 =?us-ascii?Q?ZCQjeu8XAPBJ5mIEKwm0JSR1G3NOdQaJPSnDlwb5gaer+SYZn0VWSju27bFU?=
 =?us-ascii?Q?V1f6OMAvc6iG0rrQsDPq6RD6kpLAPfHWzYP6N10kCncdi8eXbPSLljEmYC7Z?=
 =?us-ascii?Q?nZlBVTdvPUmmfPvhh9WtSv9F37ZFulFZSc6avSDP2JOOqrxP9MQScgQpgVQR?=
 =?us-ascii?Q?BCSR1VWdWUMrQpd5HnWs+ywwLmMgPSrQdKI9s8UJ9J8Lj6zYD27XYZ7UQSTj?=
 =?us-ascii?Q?g6MXCMJ5v+fl/O2bUHVAABkigK/QnutwyVP4QMtAa9rISmZivbltDOH1lrWF?=
 =?us-ascii?Q?UfbtIsUhvYAOcbQPi9ynOzeCjHkNAZ9+5XMv+R9+091nV3mlNa/C6j0u1Fke?=
 =?us-ascii?Q?SoxKwIx5gNvV5/l8M2CiJd5u6IPUAs7gWLsoffxEsVEHkYLL1V78gyRvih8Y?=
 =?us-ascii?Q?po872YdZtMzGyEEkPoaEvwEvmflSEHWJbX1Fk2QcVdindxabL5ITHI4SttaF?=
 =?us-ascii?Q?24CyUeRblusAPrPP7eEKZuw454YOeFLTHhWBsn+69x2SRBdV7uos/nxDr625?=
 =?us-ascii?Q?od9/RTf8jJrp7YUMrnf8wHrKQWZGobZusc8sQI5o0J0PM5FhD/1CtONq7y6j?=
 =?us-ascii?Q?iJ8UmVkKli9YW0W1oPMz3AQj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664f360b-dcab-47ae-be40-08d9871f2322
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 10:10:05.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osW5x01sp3VVgwp0FJ9inDx03PF4U7Ef3LuX+BkPWuvGp2SkkWYn5p2su3MZOg0Ri0OhfItfW6zbvEOlKigiMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7231
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dpaa2_io_service_register() adds an element to a linked list but
doesn't remove it on the error path, leaking it. Fix it.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-service.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index 7351f3030550..b42367eb1653 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -278,10 +278,20 @@ int dpaa2_io_service_register(struct dpaa2_io *d,
 	spin_unlock_irqrestore(&d->lock_notifications, irqflags);
 
 	/* Enable the generation of CDAN notifications */
-	if (ctx->is_cdan)
-		return qbman_swp_CDAN_set_context_enable(d->swp,
-							 (u16)ctx->id,
-							 ctx->qman64);
+	if (ctx->is_cdan) {
+		int ret;
+
+		ret = qbman_swp_CDAN_set_context_enable(d->swp, (u16)ctx->id,
+							ctx->qman64);
+		if (ret) {
+			spin_lock_irqsave(&d->lock_notifications, irqflags);
+			list_del(&ctx->node);
+			spin_unlock_irqrestore(&d->lock_notifications,
+					       irqflags);
+
+			return ret;
+		}
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dpaa2_io_service_register);
-- 
2.17.1

