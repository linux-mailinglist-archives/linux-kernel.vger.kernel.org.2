Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDEA437738
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 14:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhJVMlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 08:41:06 -0400
Received: from mail-eopbgr20075.outbound.protection.outlook.com ([40.107.2.75]:6908
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230408AbhJVMlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 08:41:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xta8E1pUjGzRaao6gML6MpT75sgSCmrGvzyK+GaeWrVhNyVAIrONOQVr0SiC3UXI2xkcC6Z/SL3nc9Bw3+ErGTfr5qRn4VfxdpQC2fQmC4mfLhgcnRJwuTiQN15jJRKNb1kB+bJKi8X/KekvjdGiuvbmyz5HjiPe3xntLrhBbpU80dsAHAVUybqB0uVejFn5O/ATAwtU6jbjfw8Wrsi/BLNUSeacA4xrBiyAvfZl+7RhwXmbkd0K8fz06A70M/A5VFdEWN0JsufAnnDol6puAeZlZs0ryL82wfOhj+lPwLXOzqxVayTrZfT/yGjBw6x8cDrJTa8yoF4D88B4FDuQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0bweevhAYfqJ93uSbstApZm3XKvHYUIiqzH6T++zZQ=;
 b=h3sU9+2X9mBfEEWcoLnzqhvc3COf9XZuQNEkbea+jDZWwCfOVA/L8RHtgLn1YK5QrMguTfKf00++FBNXD/K69fPf9fl01DPXAm+O6Qz7Lsy2aYlzAQ57hzA9nkPmCfO9S+rUyId+K1ooDqkePro5cwE5SOoglsnjPQLvOOZbYukGKeWU6/VQdNDiMQKjutWjsSIu4wZiR69XLqMI4MNUenjyXWlmNWFvlbuhdhcilhWVUn8n78kGawAErJmNU8IImPJW+iKWkC5qSdxjpothi2P60d3eGLEoHrQeJJcW9VWL4+Q46vquillFZLhSTfGRrAf8laqNX0x3etWJUrFwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0bweevhAYfqJ93uSbstApZm3XKvHYUIiqzH6T++zZQ=;
 b=C8nJr2U6aXcP60DnwGOL1h8Pf4AXn5I30I9pSxdFJ6ljWTPLwBdtYVMiMzWO5cEtdpJfKpijf42KkXiKgGFjIb5O2yPt8gVK0qupb2ZBzlwII/BVyZ1GuYOjLxNwGEgV0CBDXyns6wImtkw4cg8vDe0TArwP0HmTfo06knF5qZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9)
 by DU2PR04MB9212.eurprd04.prod.outlook.com (2603:10a6:10:2fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Fri, 22 Oct
 2021 12:38:43 +0000
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a]) by DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a%9]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 12:38:43 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, mturquette@baylibre.com, abel.vesa@nxp.com,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] clk: imx: imx8ulp: set suppress_bind_attrs to true
Date:   Fri, 22 Oct 2021 21:15:13 +0800
Message-Id: <20211022131513.17381-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To DU2PR04MB9020.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SI2PR01CA0043.apcprd01.prod.exchangelabs.com (2603:1096:4:193::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Fri, 22 Oct 2021 12:38:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a52b71e4-473e-4ef3-0472-08d99558e21d
X-MS-TrafficTypeDiagnostic: DU2PR04MB9212:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB92126A35F0BFF2E0FF03361FC9809@DU2PR04MB9212.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3p2CYu9nlFYti67a9j937OlqWkR4YuLoeVVLaFNDnwLqwtcOTMHkpC/lGkk/kreoK4YfFySu7ZddWiDH2Pl8fVzJLbYVHkPqXqv8/Zx2AMUmV6OsxNQOdXY1XHzX3Au2eMS8SzPAuYdkSFtTiNo8sfyeMgG8zZH6l9XGKKoCh8TGlBPMrAfp0kxyxYpytHe4m2rHjqPh5sONIH2jT/ADiBlz2N5ywaOAqKWubnVj8bUsVWTZ3ZJM3Yn2W0ewuGImBU58hDNfMOPsAN/uKQ2aLHjhyMcKP2v3xW1/FPmPUj1J0gLysDoPhsHGHLFkb3hhICM7ba+/DtAGjvrCwzPivBD69ogfEjKHWhJYHx80PO/Od2+ZJbens0VausSU+zwDc27EJnhquDeiIe+6ZdIunEoyWyYnj4x8/7YTsgLhAjReswst9hj+eA09XMUE9n8rYNOMBjP6+8IVMxiDlq0dQyOo7AchNmjl3slwyigEeZkmer2Uwb4fr9GuIpr+1rn5IwLXTHU2B2B+jbBZxmQtBRM5X6ZHnKrEPe7IFgelrde9CLNjlRB7Jo8CAputX4AMezPNQjwKYLW/mj4KgcQNmOeQeUr73aNwN3OMaMYxsVokvgf6xEyFGKGJlAfMsFI0aoC+9yCkh2Umy8wqNoPX54TSW/6qPP70s0Pqt/tB1zn+kyureY2hv5IXR6SK6dmVDfOx1obEkbt7u0PESN39zMMNJsqEdfT/RiYVXZai6XI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9020.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(5660300002)(38350700002)(6486002)(8676002)(6506007)(6666004)(4326008)(83380400001)(52116002)(66946007)(186003)(1076003)(4744005)(26005)(8936002)(86362001)(66556008)(956004)(2616005)(38100700002)(6512007)(66476007)(2906002)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pUl3R4o9a54RcGRkq3brE3mIgD5g5d6DSC/6pHOy3IYSTCrkJwwOfA+ELE53?=
 =?us-ascii?Q?qgeRP1qKAoc0MtDnXdZhTQo4ggcsWVCNLFil+TnAQ45VppXaFPaNwL8Pod9v?=
 =?us-ascii?Q?77jVDZeoCyka8WNo3AbfIr87htewWZWdiR0G5L35diN+6LTniGMofSXM4VsB?=
 =?us-ascii?Q?vSOWuQ4XBXHAPd4nr7tdu/pXPa/bX+Q7vdB7Av3bVsB/HLXSQy+m5NehaVIM?=
 =?us-ascii?Q?U2pbZ0qRQRYFRvYNEHHm/BqV9Xy1lQAjbYFY4E1athJRSCQOUI1OrAnHjXa3?=
 =?us-ascii?Q?K3oxJ9MM0qK+nfhPKsz0QAilnidFagJd5XVN3Z4guEeHGMkv9PA/pr17CCQ6?=
 =?us-ascii?Q?vcW0V5MoLsGRrj1HQxylwIMlRns8r5Z9ijYNfq9rKbLixp0KrvWEu05iReGf?=
 =?us-ascii?Q?72630YhfPf3HJK8ACFlw0gXdQEqMsYK35BKdrPcCMawv6yLRb0vFcAFjuGrk?=
 =?us-ascii?Q?ji3vDioeQZG267xI9PoiP9pwMfCSnWEl/vQkdqPvC04Xtxu1X/ocjWWSNm6U?=
 =?us-ascii?Q?iAll8dVxIVGiCxdAFt+N4TqEW6yJP0hsMpHqoRnwdywPpwbejKNGfPEf2Rft?=
 =?us-ascii?Q?0krI3aFrbqrZnKmyX2qJZbNO6KppWO13dFxQTW/lxBK/0avTKh2X55HyuwHN?=
 =?us-ascii?Q?xpxzh6BUWi2K1AdIr3FH1UcZ19XJKCltQQ/DPeeS1JQRhZ3IDTopjfcdHCMb?=
 =?us-ascii?Q?IoQoily+hbNsQ6ojvVuO24/FjMH5/te1a0A/2jiO3xUaU0KdRBZI1VGrzISp?=
 =?us-ascii?Q?9XSp8eeoT5xfF5DXd/IKi9i+Ey49f8JVvY2wMLLRicWS0bvuhUSL4mh2Jf6a?=
 =?us-ascii?Q?zSg9pMBvBy0KO5/P8VmGleSp91CAk1kaywSA3hMTx0scIJAmbF6valKiRVs2?=
 =?us-ascii?Q?4GnxLv7b0BzFFiShJxl0wZduexTZExTJfvQ3cR3AsbChP9B4NQIZIf13SDdK?=
 =?us-ascii?Q?teo/3BtU7YeZXwzTLOOL6JT2SBXKebRZM2yuJXuBj5qTd08/BgsRgb86q9SF?=
 =?us-ascii?Q?xwgbTRdQm1J+0k3rnqw+msjpHDhM/rJaSnIJRoXleSRlHsNOBDrHbsvNKd12?=
 =?us-ascii?Q?rjqGKpb4LPlTfLbDW9jKt8lyk8TPdJZmm5sq6JBnWjORfuzGc3V7DYawE42p?=
 =?us-ascii?Q?bO0E7NW8e3CY1uhuq4DcuUhscfSyQ6JOQNZXKKOArVb17cJsvnUpxx3dzDiD?=
 =?us-ascii?Q?TiSIHPu+h0NqB5Ax2L4LC7hNc4LRS6Fm+DKphZqQH8xAbiQy4FLIIh5lZlOj?=
 =?us-ascii?Q?m6SGw67pHVg3ZkyNBuIcjJyV5Wx7N7+KvraSCrpXMQ8xR208OBn2XZjr+kuy?=
 =?us-ascii?Q?BD/E4eA5wv21a4d7Oh+w10UhZNvgUMbIo8kUN5PdHP+SU8ePMThMq5vxa68B?=
 =?us-ascii?Q?WOYOwAOn9goqZavHOYitssJXWQVaHsEZHw54ct4rkbiQ9I8ug2QBqslP3Inl?=
 =?us-ascii?Q?iYDIQyt6Sq4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52b71e4-473e-4ef3-0472-08d99558e21d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9020.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 12:38:43.6094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9212
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The clock driver is registered as platform devices and
it is possible to reloading the driver at runtime.

But actually the clocks should never be removed to make system work,
attempting to bind again would result in a crash, because almost all
devices depends on clock to function well.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Update commit log to explain more

 drivers/clk/imx/clk-imx8ulp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
index 6699437e17b8..8eb1af2d6429 100644
--- a/drivers/clk/imx/clk-imx8ulp.c
+++ b/drivers/clk/imx/clk-imx8ulp.c
@@ -559,6 +559,7 @@ static struct platform_driver imx8ulp_clk_driver = {
 	.probe	= imx8ulp_clk_probe,
 	.driver = {
 		.name		= KBUILD_MODNAME,
+		.suppress_bind_attrs = true,
 		.of_match_table	= imx8ulp_clk_dt_ids,
 	},
 };
-- 
2.30.0

