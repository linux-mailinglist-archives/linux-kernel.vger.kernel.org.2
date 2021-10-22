Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64084374F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhJVJoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:44:55 -0400
Received: from mail-eopbgr00086.outbound.protection.outlook.com ([40.107.0.86]:4992
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231944AbhJVJox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:44:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JptPODAzHSRCm3Q4Xnp90eJHR5kh0xV4McdYZxhovNeVnBHM+tI7Ftoi7qir968TFHkOc/61RaZAXycGGiXgDgQxIr/F3erA4l2KfD/9tgebgbXn0aKPIe3TIu4+oPvlnBc2ecl1/0O4zp7Z8VpOrFEpwCaGkYoGzsRdI4AxGYlafm+6p6zRXYxOYSYyFUWLjtDVCJQS0WiW/zWmgkWONEDYFJzPhwvubK55eutU/TT/lfzq7Cu8IEV9z13Vu5XuXfIfIg1j2iJlHi/ukVviSzXbR5ig8p1wsvonBbG1BWvNPSdqrHTjnwskwokb4AqW+c0WVQGUz6PdeqKy9eEPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXvz8wMpUJmqDRy1QT2IQQKeK127WwPfhqT9cRhKZ18=;
 b=NkKF5zuy42KjFCBFhdruI5aA7SSN984DTVED4NqhGlizzqaJN+QJRu7cDeqXCwi8lnqrA+3Hf0l9Is9VDor9tI93Js3AHkkUZlnFKdIb7Xg+DdtlY+A36zKywpKhpHdoAqda7Dzyq+kbn4VpZ9iqF6Wk0ZDj7k92pUgrYnPkwjkOGmD7IRie2LGlA/LcnuRwYaY3YSYEw7L8z2LepdPfIakqtkBHMEzz/4RpM3ScMzYisfMVziKB9MsyY9uIbtJZEsMp4LOmRZh5IvlhDfER4LqD3773B/Q7h7NyqSCm+ks9SQ1AI+hFYfJtGyaGJChCgif/urlsx56J1z/rs54tkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXvz8wMpUJmqDRy1QT2IQQKeK127WwPfhqT9cRhKZ18=;
 b=SsAUQqlqrY6W6UN4mHdBtn8Fo4shdYKKaW8fjKPKWUN6RePIpYVadC6efxswFpbXhN5vKumaWBTMo4izOEJq+VvHnwI4Vni/MZvRu+40K4m8IRplQ3uUKZmwScOzi0+TVpLizSstKeaC6hkWiJdRCDT+YPogOwNm0/s01dLKQLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9)
 by DU2PR04MB8792.eurprd04.prod.outlook.com (2603:10a6:10:2e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 09:42:31 +0000
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a]) by DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a%9]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 09:42:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] mailbox: imx: support i.MX8ULP S400 MU
Date:   Fri, 22 Oct 2021 18:18:54 +0800
Message-Id: <20211022101856.8612-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To DU2PR04MB9020.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Fri, 22 Oct 2021 09:42:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53a9a3ae-6355-431a-0800-08d99540444a
X-MS-TrafficTypeDiagnostic: DU2PR04MB8792:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB879266248BF74A8DFCA0025BC9809@DU2PR04MB8792.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VrAUIG2ybnrD8+Wab+I3QHwIqr+VvuGKR8m3wgUA83cr81FczHPDcZcp2r31a8zTmC0BkOKYQ6ueKHViZBYVR+QVrN3v2JOYt6sqjq1u9TJkTDPUcy9IoVb5ST3AyC2DUW+GnCxsc9s+3pThsdRovI/SFXye4/AWZ7TM/gXupdb7yhwhdM73al/l1NQ4o52IB2Iuuhi4NADqHTVz0XSkUc/VR9EhKPqT8YDNwT3wnslfsfy9jnWjFYVm/hjkJhDybAI2XmsapmQjKCnapzqlAKn9/N1v5gwLiZ6+WBb8RyzP9DG/NVt8/1GgsiHpfVTqAk27e8ny2I3SiBHBTyFuW34wKgo4xUwDp3gCvNWfUT/AylBtzPKys83abUmrahTU0zRZNXaEFaeBDxvqUKcSOGHWiRZJXnyaHSM3/rwh7uq9LJ+wqow97upGn+jKB109JWyK05hSAsT/C36bl81H72Lopo7tSnzEA80/uHwYloiUG6Pu1gFEWBkbun1mLeI78XerdrrwmQmcWnvRBHzhg03mF10ZqbKu/xc4NQsCiaQhfAf3KKxgmSS9Lo7roRwssl1AnXWAC1V80yVhcvDK6N9n2t843srslo5p+i3OIaBEbwkh/Dr3pgAtxOyQ6VtIz62CCf+ti467IR0SVdZYiBUKTrhsZxYiO9WFtKcgdO2Xs5pmBRAGGYsq9Nb6heZTtlXwjp4ylSNYp2VFTxDDGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9020.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(186003)(508600001)(956004)(4744005)(66946007)(1076003)(83380400001)(26005)(6506007)(2906002)(7416002)(15650500001)(8936002)(6512007)(86362001)(66556008)(316002)(6486002)(2616005)(66476007)(4326008)(38100700002)(8676002)(6666004)(38350700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TuXkbhqEVKqRR2jSmvaigG2pAIzzeb6PC17aETkENhbGN5rAjuO0nCieENO2?=
 =?us-ascii?Q?7izwppDF1QU/2pDh+U3OaGUhDOvIDsROYcyM9E5dEDB/LlVhTmfEQaBb9NxK?=
 =?us-ascii?Q?ES5mIYr3BBHRd9AupWP9bNeUmQSG97jxRPBkthjm6VHa0EppYiC4mQ+8Wq8k?=
 =?us-ascii?Q?zwIeJY8Wo1wnZln9RgzY29JDCpZYxbNIT7MUzH1a3La8LtmFDlKccIGXBCqw?=
 =?us-ascii?Q?R16+Z4nSo+Ty/oCR6Xcg5rhComswjXen+uLA1v6YONHkIohI2sCcoC8jLijC?=
 =?us-ascii?Q?LD/0exiNLPZlDmnhOs0yV3cL3g49YFdcl+8Wly8zocBw+RzL2jdCplnSKKre?=
 =?us-ascii?Q?OyJA9T7avbWLF9FRP6hckSro/vp+Os74bSg/g3zvS6+9JRy47jAjJ872lEwQ?=
 =?us-ascii?Q?209c3UCjDJ9ME+Xp2lOkqnIJklgO23NVEo8YmmJ4Vwy6hCJVG05pn0m99x+N?=
 =?us-ascii?Q?s74KhG5gz70Nv7zLMymrA0SHz+7JrArysCh8dCQZ6a7aB1EVpxu1RpiLXXTK?=
 =?us-ascii?Q?lOKj8qs+ZNEWwBvM3hLjNflfrYFVJV6n7SlDRBWNFE2PeoSIMuUINHvo0pgv?=
 =?us-ascii?Q?N2auheorqv/XyLxzjbon+Lq3nQQqapVt7iiH6nwcIcKK9FZ4Tj0X0qKfC556?=
 =?us-ascii?Q?Ou3dMABImY8I3L33Z1u+sC9FPv/qMSGLQtkbvkqDJaHaEZYWxF/9q1YODK0C?=
 =?us-ascii?Q?GCKn/b17g9QwJ8D17K6jTb5QDQEP/vSE3FgJQuO8Nt36Npv5brnnFlTOaBuq?=
 =?us-ascii?Q?Kx/AH87DTLPgjg1VH3GWOGzUfLgJRhArTfKci45IlOvlGxkIwnWZbC6q8zO0?=
 =?us-ascii?Q?LcxHfKDVFYMxIwedE0WplZlpIZ2WH9EB0nRGpxxRp8JbqqT5ml14I43TbmNP?=
 =?us-ascii?Q?GJ6yB1Tp3gQIA3YKlGSetQA7ckyrskRApWUMAfhlr++M3y5DnFElJviTfmeU?=
 =?us-ascii?Q?1//sSB46Ilrg43ZLPJ8CZRI02ly+tkryHRj8uDsFYR+/1j8vBBV9b02CKDiC?=
 =?us-ascii?Q?IawI8GMMq4COvD3yZd3dbtUf1cZFwrkk1I2GfFPvFhF4C9K/xrHMeE7sKfAT?=
 =?us-ascii?Q?E4UHgv33H5od6YUZQPcbQukoqqhYc8mQijiPB7nBi+t59JKmCSrd5tcIl7Ta?=
 =?us-ascii?Q?VM92l308vmFRHatkELo/tZkEiEOFLtVEkvH/MhBOZN1BgxwkzcITcozXmGmD?=
 =?us-ascii?Q?RutJwFyEmaT/IZaPyDWjrjxopKaUiIUcviqaDWE7hjGuQFZIerbFqLbbmHQ3?=
 =?us-ascii?Q?9bNiDD92AA6DDNcBxyfqC00A2P15XoPNxeGCw65a+38QeoGCLKFMQSOMMoJ1?=
 =?us-ascii?Q?nHV/sUiObI7XbotsmgRunrBCxbJdXPjj9reQ7jcGXj0Uvn2yz3qP1czKW6c/?=
 =?us-ascii?Q?G4eDFxFMk4oQYXl2g0b4RDPyvY7wwVu28MxZbsu/oePrulJwIBcy90Ap7Gxz?=
 =?us-ascii?Q?BTYH8APi+Jo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a9a3ae-6355-431a-0800-08d99540444a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9020.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 09:42:31.0682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8792
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This patchset is to add i.MX8ULP S400 MU support for communication
between A35 Linux and S400 security core.

Peng Fan (2):
  dt-bindings: mailbox: imx-mu: add i.MX8ULP S400 MU support
  mailbox: imx: support i.MX8ULP S4 MU

 .../devicetree/bindings/mailbox/fsl,mu.yaml   |   1 +
 drivers/mailbox/imx-mailbox.c                 | 124 ++++++++++++------
 include/linux/firmware/imx/s4.h               |  20 +++
 3 files changed, 108 insertions(+), 37 deletions(-)
 create mode 100644 include/linux/firmware/imx/s4.h

-- 
2.30.0

