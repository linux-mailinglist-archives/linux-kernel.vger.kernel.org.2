Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8AC3C6BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhGMIP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 04:15:57 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:54403
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234157AbhGMIPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:15:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gc4JejonkWaBA4H8KusHN4/IggShiP8vL4t6Tg4G/aSTUiZWeFAkuQX7Ysv7G9erNbM6rx0Gh1EMeX7g+NyrM+hSnmL5RjZ7NqKxMlFyYoNN0arV9bimfn+S43hVsmBihXAXbgb2KXthHX8VVBVOgwrmtDzlCGxj1U83STWTx2jRhdLqpwuNjkhNkNE6gyGWA1wROr1tdvohLz2rU0sc8Dg9w/YGGl5wu0Cu41fj6iSBRxyfTit9g9oGyE8lCvPfBpoeUrM11BLFAiNJt7g71pLxW9CMzChw/yGE68eaaDQTJLz5zDPCyphSmXdMIgOiWYU2cyV3XPu+hkg7ABAjeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBtB1U6ri/n+V0pCRt+uXG7InGF0o8Y7XRL6v9cnSkM=;
 b=YTljv7kqge2Z8R6apAry2491vW/uI8jxE8A0drhQNQlHeqPPDrtcLJnWJGIYr87JQBgfm746C/L/5TPu/m9GrcTQ5ybO/oXVgecQISrYibZH9sGdBgGpx9bKoveGS16znPrwpy95fXHBk7Jo8httI/n7/WWd2Fw1EOPiF5SCA0J1A3Ninaf2sSMNkA/LnnuR/NofwAC4Qo/hABffdLlOhd8BRjAiTSNIYMh8AqUpy4eRnXCJogBtneY0+xMwIX4ogp/zZGQ1q2gwVykFVRHGGGLCwWweDJTOu6ksesOpXu9C4pwzMYVAUOGTfk0dh2XCyXuwAOAfKDmuqeLT7GZudQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBtB1U6ri/n+V0pCRt+uXG7InGF0o8Y7XRL6v9cnSkM=;
 b=Yrsk2auNsmQK9Aa4Xh8GqHDMVZbpkZ6DozLrylzRADyqIw5HMU2fChlyLCsRx4EESA2G0L9v3lmTa7xc3skJHuBXSYIySbdsx5sRzQl4NvAfKFls5SrWOWQLnrUQlIGnbCGBMI/h4Mj9Kn+qDrJz5Qf8rg7yTWT6uP1e5tNK5NE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB6661.eurprd04.prod.outlook.com (2603:10a6:20b:d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.25; Tue, 13 Jul
 2021 08:13:03 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::b817:4f8e:ac7a:1e51]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::b817:4f8e:ac7a:1e51%4]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 08:13:03 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Subject: [PATCH v1] base: soc: export soc_device_to_device API
Date:   Tue, 13 Jul 2021 16:12:55 +0800
Message-Id: <20210713081255.17308-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::28) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by MA1PR0101CA0066.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Tue, 13 Jul 2021 08:13:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7669d50-4f18-4924-0d50-08d945d60919
X-MS-TrafficTypeDiagnostic: AM6PR04MB6661:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB66618BF32E90FF5EAD80D532A3149@AM6PR04MB6661.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qUaKhTB+sReF6rbmbT4+VjOrTC962fmNaPEP6ktgYJPWkg2GUd7rF2BjhMfp8zNnw+jAcfeEgPAZMLy6nx5vsVhPFp87AsvrXzpiNN0zAxWzV1hAEQabZrH8Nk3nsAd9+ENd0qRTOVrboXiHhr/t0vLzAp1rUDkvlByLTuYSN6DBYJ3eGKwP8PPjdkm+1XvSitUG7J8ZrWl7B29w5jx43JtwGwZR4CyWHKm5zhHynmosk3DUDDyOHb3iYMcB8S0XMQU7VUSlAYy33i44rRXfrr50aaCZA7lbsdJCZZwE1yma4jXpPQy6t0bhePqnFNSt3dgJN2DXj0MqdR2zmPw1DE9BpClNEMXqLJlHRG+4HG355ZWkC+9rOcI7AXZ+LG41HLZD8L1HixDca0UJ6hWl4gWJcphP4zcv6962e22n+yjDrYuanfnmThIzAY8syr/nOLvjwt4LOitevp37B1SiYCAZi24U7naxSYIyBV3yCd5P5fJKTaBoBCUSokGSvKbppuNeaAwLK3McXkVqkB4XRLN+85w32L/PQCSpyLww7WvzIfQlJiw6IYVrGff4z0BLudLeQZTp3e5wg8CpH3s09596KKg/37IjNkAWqu0DkYXBVTUm4N83CJ+cIlCjnhpMZdlXPr53H+GOUSETBV9NQ5Hns+k1GHGkmxnkmkgAZHLJdOQYH7bms7zPIgLQEa3bestlDq8asZVE7jnANgoPtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(2616005)(52116002)(86362001)(6506007)(66476007)(66946007)(66556008)(8936002)(38100700002)(316002)(956004)(6666004)(6486002)(2906002)(38350700002)(4744005)(186003)(26005)(8676002)(5660300002)(6512007)(1076003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HNGqisuttPBRbboXECjR39CXcBPPVlNql9o1sP98MKNesEHXBelrHHZOuFWc?=
 =?us-ascii?Q?cB3RYeT5AP2Z0Ub86TSNgIwhx3RWwVm4I7KRmD27FwFsc9HghFd9NnkwVjNI?=
 =?us-ascii?Q?mteQqwjJtu/sAHN92XLoiwayg9kUBGOovJdHkfWVcMJzLueFN05kUimvzVp7?=
 =?us-ascii?Q?sVQYWCYRr2Sw/1+1CqgbSpIx/IKRrV+4Oq1Pu3f7+3Gi/Sq6yyZ6dJ59vWLB?=
 =?us-ascii?Q?V/+G4kNUU9yRRPIyphEiYzw5M0LKxvrgV01Yd2j46M8guqKAExLP71Vw4RaP?=
 =?us-ascii?Q?C6D5JBAuzxaWIv/TsQEi6pG3UABqkVfuOgs56rX3TOdyEHZoGZbaLHPkTdga?=
 =?us-ascii?Q?uIF2d3duBAaFDI1tU8yvY6JtNEZy36yfktJMn+DqtArGB0VBro96aoO8HtCD?=
 =?us-ascii?Q?yGQVPC9Poym2lwGaOBNAhwibv7YqIkRgU0VfHfuItg25jJuTgNY749KKPxh1?=
 =?us-ascii?Q?wRypPIRhCuLi97QUndwnqiDjyKLkCl6VGBpNxauH8QHxr/jRn7nH7ln/aZce?=
 =?us-ascii?Q?oFGDiCrGh3ys5UYWNg8/yDXerTUM9om47W/tOcXC8mk7kXOk5Fs0omH8nnOR?=
 =?us-ascii?Q?AMMGWSMCpvOiU2Yya9U0eX86IJH8PWROeeGgsGtFuRCjDRvUZc2trR5splU6?=
 =?us-ascii?Q?LjzyNTERLECjno8GRE52qRi4F8/SEtFYLgkF+WO69kzvrcK44L6Ex/Mm1nKt?=
 =?us-ascii?Q?tHm1iSLcML/PCUQf8QnAFu38xW9dtFcvtHhgBUx4yuISlDkDwFhmLHLJ3x0i?=
 =?us-ascii?Q?sPI2dexhBN9LL/6Y7lkRA2PLT1eZ3zDlHdNbQySVcmLzoPMt0mca/V9ScSbA?=
 =?us-ascii?Q?TlHlB1mGTPgjNe5SxsxNQjxnFmz2FmduN3i5kSvINcMhb7qadFLt1ksrvKpO?=
 =?us-ascii?Q?932qbh/qoxtfNXTZC/T1blmsTwaM+iWwnNSeT1GILtiV/B/XBwQcIO6w1KlN?=
 =?us-ascii?Q?Gl/nl+nVEu6RGwlUm3ycu3iob1az8uWnN/zRTusLGV7+zh619SC6HG3r3Jev?=
 =?us-ascii?Q?z01tKsw3T+GF0W0fMyDQ0DHMbC5pX/wfrNRv4HuV7RobVHjGj1ZNao1hZF2K?=
 =?us-ascii?Q?ywuV8beKKCndqw8YeCInby7QFsS7UZTZ6Tr0AnW32qZbRqve6ZAwCysmkUh7?=
 =?us-ascii?Q?3CatVfc7dWYTi1HMboKKJKV4HlqP4FuFuYTSCfP6z5/+gipLwhFDVSB7Estf?=
 =?us-ascii?Q?M85GIIHfU7eauFMW71gP7vWlwuEaBBq9CiILOenGzTTxYNZZMpNIsB6zCmf0?=
 =?us-ascii?Q?UIUMKHiNI/+xU4SmbBMZikY3ihR8c5yPyGHi4j7TRKxFAQDjJbbUGHghlYKw?=
 =?us-ascii?Q?MyQlLZOv5LsJg9V/hd24SydR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7669d50-4f18-4924-0d50-08d945d60919
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 08:13:03.1048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyNpFyph6qWsNaH7jPp3HRLPXgNEoq1iBE4n1PqlISIwCpqWDhoxOhgyu0181za4B0sm6JUlWp3viZFY26Dtyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6661
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

Driver which uses soc_device_to_device needs to be built as a module, so
export this API.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/base/soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 0af5363a582c..6b3db25611ee 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -41,6 +41,7 @@ struct device *soc_device_to_device(struct soc_device *soc_dev)
 {
 	return &soc_dev->dev;
 }
+EXPORT_SYMBOL_GPL(soc_device_to_device);
 
 static umode_t soc_attribute_mode(struct kobject *kobj,
 				struct attribute *attr,
-- 
2.17.1

