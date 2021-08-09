Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70E83E402C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 08:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhHIGg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 02:36:58 -0400
Received: from mail-db8eur05on2085.outbound.protection.outlook.com ([40.107.20.85]:41569
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233425AbhHIGgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:36:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKXQODJySMu4L3M3XuRkHHONtfW183lPGTZL3JuBH74BpEj4f7hq7itUQN5uNOolbHN+DAyGMAb5qPihBR6QMcDpkmQxA/Eav6qf+U16AuHq5C2fNVIA/kxawVrCZRyp9FHfD49YpOYl8C+IN1cANBr+mVYKQfczw2CUfecdavwVddmLaJ130ZDsO5QET11tB+Cgox3JTD334ZwcIqs6R+x2RmbiObuamQkeqdqsxmugQPUz9OF5W7W/wBucSPW9DwTGcIRh/CdYuRAoyiPcmJYaf6iWXNOO5yPqHoBFhkav1H1cJqTAOh/yhXaXplSld26oVNMu5ca2J0vdpFrTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nG/THkKxdrGSubW37K0BiYYLksbOr5a9r2wdQcAjd4=;
 b=a7orzgTMGQTP0HfuhR074k+3sqO3qBiD9IAzIw3u51qEZ93HwWaw2rCjt3Uc6rP+lmJtTrYPbDgvuFqyEU4B1sX4UjHFv/0zpR6RB8TjOxCNT1tXIAUBUrtpQ7+GhWfVmBWARCILBPCXxJqUC0atVa8x5xUghst+Lr1DXCC0LscgtZmWSPhzhsihHUsAsKAtGXeQ/mP6cSoUcUVb+Egj1L9MuVVFr/e+17T0VSLY6cskWINXMO24rI07jn6hZlmAWq1onAZAWZ/j3RAln+GTNcr0OCKeJzkt55W5/r+c/dsn9H8gvlFwZWJgLLSUkN7yChTgkJ5e/hYB0QOcTNn0fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nG/THkKxdrGSubW37K0BiYYLksbOr5a9r2wdQcAjd4=;
 b=ExbUnO1y+woVcC/iVDnVqWnt3j7hyZHbvNwjxR5DbaRF7BMxVoDO8c9vqsMveWBb8oSHKFPuTwlKyT0Pc41FVCR0AR6eA4bphviaPYZgrme+tZwbv0QMaV9xw3tN8iTUppWxDBl+Z50JYZjsV9baOOxcLGfQW36KndLoZGaM/uA=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AS8PR04MB7653.eurprd04.prod.outlook.com (2603:10a6:20b:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Mon, 9 Aug
 2021 06:36:25 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::74f8:10b:8efd:b265%5]) with mapi id 15.20.4394.022; Mon, 9 Aug 2021
 06:36:25 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V4 7/8] i3c: master: svc: add the missing module device table
Date:   Mon,  9 Aug 2021 14:36:44 +0800
Message-Id: <20210809063645.2289988-8-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809063645.2289988-1-xiaoning.wang@nxp.com>
References: <20210809063645.2289988-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0103.apcprd02.prod.outlook.com
 (2603:1096:4:92::19) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0103.apcprd02.prod.outlook.com (2603:1096:4:92::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 06:36:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44171f0a-e127-4257-7d63-08d95b000289
X-MS-TrafficTypeDiagnostic: AS8PR04MB7653:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB7653D5B2DB7802E5B57CCA01F3F69@AS8PR04MB7653.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evYkAnEHUyxMXytcZ7MCLJ9OcpAnldVXTKh4RC5jl1mWn6ERJ9mtDNAnKv1ihiezAFY7kNBOB+VGVMlyH2U27ErtE3PRMZJ6f0KYGx9P3LGfG17aDbOvJHPXytpSqgn5drSQWLp/VuUhttOehSDgctGcfp474dIu6bqAy2hKefHU7WrXslh+eDcPaQDCAk6tMFlUOHTsFwZOUSrowa6NM1D6xnBOFuY8zLG+xo11Iu/x+2UD+QEEqpkgC/cDfMhTFIhx8VkLtw7nM/b96bcsZaZp8mFf7SFDyFjapVB1M9kS9BdsX3gHHz0pQy64yktEaUj02K5oXud4aEcA3peYEB0Qti0oCR8HEmnRbBdGdLoFPaM3fZyaDnT0qz8LZFPjeIkyFSnZBmFE8C8IMvvW4lMzgPbgejgPv7oCsmh+FOU3IG5AwPPX2nMB8XTesGAem7W2rqxzZvm9AaMbupYtuFKvBbjkXNc8l4z1AovcClNNI5e808OTfr8FKCHYI36ESSpuAANg2idnSOzQ+gDjevvb6OnHqC3caaDBXr0b9cT+zKpqpKljrqcwdb50aYQ1CZYK14WPFM3D8sze/5T3oG/BKY0DpFxTEo4OKW1Elsi1mltnVxrRQfuuFyFUYR0va5Shx6VI3dHsXsVqyGZA0XT9Xz5tbQ8K7kHwpDouCfCZpVntu8AWsDvtONmiEEFwWp67+qPne6eoFbd0K/rp9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(38100700002)(38350700002)(478600001)(86362001)(36756003)(316002)(186003)(2906002)(8676002)(2616005)(956004)(6506007)(4326008)(26005)(52116002)(4744005)(8936002)(6512007)(1076003)(5660300002)(6486002)(66476007)(66556008)(66946007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T8Vpo4szOwIb3sun4NyGA+uitaZasEk0Rjtg0QQjEBgyZIJ/R/BbwP9efU5O?=
 =?us-ascii?Q?8UXHUeW7KFpND+V4bJ4kvwyyCftfipe8SYmN11Djb3XjjN7QtdrCEULuernk?=
 =?us-ascii?Q?wklA76jGPsBziAunnDBRJyJpH8LcyhEJD7mCUrPxi91j0lGQaJDkfnzEJjmY?=
 =?us-ascii?Q?ffBVfrASck/BVVmFS92mbep1nGFewL9wPe/tNITZCVK3re6dSfzpVM+bzNA6?=
 =?us-ascii?Q?Pb+uZ2tgAtlFPhiVmsmFM+TP0WH3Jv5xuao6LD4tyiA6hK6U5mgO0HxUB2Qu?=
 =?us-ascii?Q?ypFAq/bbtnda6hrJMpE9J01jMMUw+IfhSP2u/fo06mjcLjkdcMfUjt92s3nL?=
 =?us-ascii?Q?TlxY6wTtzmbNeHTKHaxJIP3lcHn1v0/DJ6srSfi9tY8DuRcmhQPD278ScifT?=
 =?us-ascii?Q?3AnGs7a9zC9k9L+iS8H+DcQ0/MQBbWaagOigZ9OdRS386w8pxNzxIRUe86xc?=
 =?us-ascii?Q?bNX8bJVytNOhZ0edWi0Lex4bmMmZN8lvjWe93oM8L4465hvgqQ8wgRsRJszT?=
 =?us-ascii?Q?EswWJh9ls6o2uZtNJge0ySdwONnxUF+Quboiu2qFsKmMhFjAqW3mD+ot214C?=
 =?us-ascii?Q?TRW6zCAhMrS3EF25n17Ou5dJVpNNkTUfe1qFen5DwpEKlD1HjaJm3k4LJBWs?=
 =?us-ascii?Q?6voJhUXXYKuVKkdneOID01jCmz5iw5o+XyqI4+Kvb7R/2Ekxs+/dgcxJVL01?=
 =?us-ascii?Q?mtUTpjao/YIpsN7Rb+cz4NHPSDI2dCrTAcHdS74vYeBT0OfeIRMdiTjrh2RH?=
 =?us-ascii?Q?/R9hURk336+1/TcG0bBauxRv+3v8pYqnNLBkc+gwKaws+PR7Rsu2wVaTDaWT?=
 =?us-ascii?Q?xwyeo8eGHsMOwrswFA8O4BPDAoej0O4DYbjLbNJsmOr1910FeStVd12ItJYi?=
 =?us-ascii?Q?2I+eadmzmXjyJVwc6aUJzmdTp0cFyqF171fDAwfpf6NWjOSQVTrE/hH7XMPF?=
 =?us-ascii?Q?pBqXe6cD3KXQdh9WEyvqME9s2X96yAXxypOSCAHMo+VZUzxkaLMlLYSt2qZe?=
 =?us-ascii?Q?mTPa3bJ3/tIV7PYKHoNbPF4cVErO+6P/oUkHeO6OvzkDZV1BLOrrdcNm+kbF?=
 =?us-ascii?Q?RP/zCALgahw7niQr1NXKjDD2fUuj85o6kfUTTHKqNoygLjNRu3gIASn0A57/?=
 =?us-ascii?Q?h/HHK3E60enktzEwyQVzd/Pl/k1Wjtu3s9CkNyGi4cmtH6E2kg3+I1IxIFQW?=
 =?us-ascii?Q?gwFSGK4VNeaLR229wzHWXBfkWXft+jWYUEA6Rm+EWnoPzy9fxkgf75eyt5Li?=
 =?us-ascii?Q?wr8hP19qcK0GBLCGpQhhn4kEWsM+shwjtXghRrWNXdA2upI5plYVO0k/UtDV?=
 =?us-ascii?Q?rKV81UCBSbGhDtTAtbkrX1WR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44171f0a-e127-4257-7d63-08d95b000289
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 06:36:25.3156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sC2mwzR2zdNNs4hvJO1wTAiRjWy0nlIXVK4QZzeiG2mTmWT1RvwKXTqkKVX3IU8jWahdgPByz2rIqQe9CgW9tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7653
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The missing MODULE_DEVICE_TABLE() will cause the svc-i3c-master cannot
be auto probed when it is built in moudle.
So add it.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
---
V4: New patch in this patchset
---
 drivers/i3c/master/svc-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 5939e0936697..77f67d407acd 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1612,6 +1612,7 @@ static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
 	{ .compatible = "silvaco,i3c-master" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
 
 static struct platform_driver svc_i3c_master = {
 	.probe = svc_i3c_master_probe,
-- 
2.25.1

