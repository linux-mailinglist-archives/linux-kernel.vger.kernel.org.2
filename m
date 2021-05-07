Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C928E37630A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhEGJs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:48:27 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:28032
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234506AbhEGJsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:48:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPR5gADUI1dTW/BXGeduJOGMYR6om99eHVJHsus++O5W8OJlr+XPJKHpOV+Tl/xRkzkzN4p5RuTFasZ7KGC8vUgVeA/GszFlFSAsQTjFxA0IRYz5rE0b8bnYnWjn+A7L+yZ/8hpnJd++0NhoiZud4WkJR17orYYc+mVfaXrQDBdjj+syJE1mSxHbHaD+bqhK4Pj/C/Va32qPjFc667fZNI+R6lDlQV8i7uHcsh8YDv9Hvnp5tSMpBen/sz+gR7/cfCGksnB9LYIowZmkJ3RxY/w89+UnSe8izzt8drn4c2/DmtTZZYGTE86XztvFMgfWdQMB3yaWQF20jidtwjSQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbo6I9nVg5O1Tj4+vLsYty5y7T3xN9Q2Z8CfZ4PFHQQ=;
 b=WNA+H3A3HNBtq83pmYIT5N8erCpnXKwQCEil2dmnH1i0Wb5dd9RecMUK3bnosps7LWW9QtV04cdKc6TOe47ogttnyGxeakp108uClNXkUyGZq4Y7IWKPy2uI9YCHsIpOyuQnco4N8mFfMdct+/ASpzP3Kjk5LxBJnjkswyg/eONjFFfc0ktCk6uROIu5m/RGpbVfJjdSyDoM2Szt8zmPwoh/9yP8X/2oal1z01GSsR95Qnecc8wVwx46i5ET2aTJ2GAA9UH31gfZQ8obwox7dVz+qjmoHOYyWJLc8yliFyx9lxPD/8T90hc1A3ZslJhrz0LAzhWK4QesyII/O+MM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbo6I9nVg5O1Tj4+vLsYty5y7T3xN9Q2Z8CfZ4PFHQQ=;
 b=bGGGtj4zcdmnqGMf/YJBYcA4/ihaFIh52LS+njMSKmv5eAR0O37wwUd8efh+5nYsKopLSzhQhpHDZUSvEOJfgxGmvVkHzdY4eElz8T6b10EzkDvbWiisTdS1UkGmYgUmSXS0mQhWOLWh3CCbGhZ3hbLGsXqLuCPn8XaNWi+/gSs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6857.eurprd04.prod.outlook.com (2603:10a6:10:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 09:47:16 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Fri, 7 May 2021
 09:47:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/4] mailbox: imx: add i.MX8ULP MU support
Date:   Fri,  7 May 2021 18:19:22 +0800
Message-Id: <20210507101926.25631-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR02CA0085.apcprd02.prod.outlook.com
 (2603:1096:4:90::25) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR02CA0085.apcprd02.prod.outlook.com (2603:1096:4:90::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 09:47:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ac2e171-53b7-4ec0-b21b-08d9113d1880
X-MS-TrafficTypeDiagnostic: DB8PR04MB6857:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6857E7981C64B9797BEDF262C9579@DB8PR04MB6857.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHw9lebp3BCLJgInmb8qh9HAlKrRoEtn0SFlOGRWyr7KMFx7mTcSlhwIeJfM6jPBfgw1Yr37z+/TxymxLb/JH6JzzGhzUC3+1T0GGJyWPeWdVs/9Emi5U49wdCeVVkO2op8FxZo0t7Hhc8dzCPrs1j1+NSwNaWV4W1HmgrqQ2PO/Tby4obbImz+i3v68pOy7/22dKcJ4IF178zOxjtahWPsRrDj0Vu+URkvh1uke14O/jGyrWqztLj9m+bmr6kPicD97qIieRxxuN6dQSwFEZ7Ap7dPI88uLaHg7+FVmk5P2OFzWSB6jLayGOS/qde4AwSy91U3H9kKLnj9y0lxESfXD1regt2QttyOcduHpuSNTfHBSAnSEBRid0AiOMKGUV+XQakXz5V61XPvOhThFQX2Vwp7iBWjWemEgwLt4cOFDorZOBGv9S6q4Btgu/EUerNUBvJt8BFkcdG04L2iNs7AX9wMZt4zOmwgDL6wWqAEiejrEI5GqdyqLtoeIm6W+uIQXO7KunUHqY4hvufRiM5qTkvRgWvN+TkfAE5ImO6xNHPFn+XF7hAV1Ia951PGz0GjsSl/z9xzFimKfw8EoFOhVdVtQHmMb1hdu5t95RONye9MGX2XGFVAhED8K1/6kbhkyNhdylE/njSiRYEHSdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(86362001)(4326008)(478600001)(4744005)(26005)(7416002)(6486002)(83380400001)(6666004)(8936002)(316002)(38100700002)(5660300002)(66946007)(2616005)(956004)(1076003)(8676002)(2906002)(15650500001)(6512007)(16526019)(66556008)(66476007)(52116002)(6506007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zu9sA9mrNzg+fS2Aa0m1fT2NukmtEAiN0DzI24EQQ/MWKemwJ/huFYxPJ38a?=
 =?us-ascii?Q?FceUIZs54tAYIGldvFxBcKNhRbvu9RcoC19sk3daheVVP2CiDs7XvO+qqhAa?=
 =?us-ascii?Q?vfSVMdtAjC8VLzL64BMjc4CzItKZCq76+voW7DUX9dHufbuePJyMVHTEDii3?=
 =?us-ascii?Q?cbs4+AWWuayTuteSdE0ZsqXK/wjudcFCngoCH/DPQJ+5J8J8eDNLw8hXDAd+?=
 =?us-ascii?Q?wX2xRu6RWNeI+/79xYsOkcxFne9OavSQp6UtBi2rJFJ+41A8y2EwjyE5tXPF?=
 =?us-ascii?Q?YKf8EQRD9xghXB/fYsej3FqgOt1Rseb8ntn+VJJcULhmuCY6OWbp1ZLlOB1y?=
 =?us-ascii?Q?X2Zd8SPQosfrcG4xDx93ATRb8PHoTuTR1TvAeN9CF7SyZiY//26fRFg22e8q?=
 =?us-ascii?Q?0rbjUOeUzq6w7CXzigl17VD4/0p89qpdnblZy0DEOOfyIwz6ooHpzfZhT7Rc?=
 =?us-ascii?Q?9gvsKjUjgmOWoQZ52PuxzYZ9QU6rwZFQA0yrD74xLfMptAV6aSsC8l5Y3umU?=
 =?us-ascii?Q?W4tDlPLiXcorTH56uzmH/5A+M8xFZ4gwyKKRRQ5voUZbK3i0el0VC4VzQHkz?=
 =?us-ascii?Q?IN5gU+18IeGnE74Ng+cIg6ecGh12ll0Eb7T4ktv1lqn04GTQ8ifrtxfkfUIH?=
 =?us-ascii?Q?j2NlBJXlXlsNN1dFJtYp9xH+8/pEPzM0gzZBRlgoGFEFuc9EJI8vPoHRqs1y?=
 =?us-ascii?Q?MHeTCnZBSc4o5Ow+VVjc+MT/XWzYUsfhmTMJqRLHWExVn0cncCvV2pPjZGPO?=
 =?us-ascii?Q?KW3CieAL4XVi32ANd6VJmrjLnaiwvre/MwRhvXdsIoFckMFiZ+l3YNVygfiu?=
 =?us-ascii?Q?Lc+Hwv+oxEATtC8+U/tbiryAO7KMphpkXUzL16eWJdTmAlK8WJCqaqDJmKh9?=
 =?us-ascii?Q?D1nXvBrosnax+Jp7GqhMHjarp2xX0UHGtaH4LUwHtGNzfMUvCurBHinR487h?=
 =?us-ascii?Q?dMxYWLy761rIwBw0+Dz17PuldAY8dSetWt8x91QxLn9KoqpsJCnHBf3jQXFh?=
 =?us-ascii?Q?y5/CAK+rzruYHYR+QsaGTwpC2ybXY7gCZ4+ot4UVaoeatLct2wNKfZ7mpoPZ?=
 =?us-ascii?Q?UYppTKZOLw9Zr3GN4aKWF6Hi7u9/fi086wux/FBj9fdRX7I1L41KYWC+4oOb?=
 =?us-ascii?Q?qYGRtumGRIryuW212aidwJbmOn3JeG3ykMCU8aIOll5yJjN3E+D+zQc4hzK8?=
 =?us-ascii?Q?WAeYKlrQTxGIAfR+ssxOwG8j2DracQ0/AsdGMim0j6xvQ4GIPN2op3cPMd2q?=
 =?us-ascii?Q?IXJmeTSNJ6wH1XJyBuSNIRCzF/WwIGxgOGQM/Lr1DcVgQ/cWb4nkcsPohPd8?=
 =?us-ascii?Q?/kUmgejzNhHfH4ZbSX4TR529?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac2e171-53b7-4ec0-b21b-08d9113d1880
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 09:47:15.7397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/02cm6xTS5xq/Ppsqr1j7YRLOsUchAQJo9bw/LOr/jQ+tsQGraQH2+a+o0MmnB8XUk7RBJz0BJBLPwD3O6XrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6857
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8ULP generic MU is a different IP compared with previous i.MX chips.
It has different register layout and bit position, but the register name
and bit definitions are almost same with previous i.MX MU.

So we extend the current imx-mailbox driver to support i.MX8ULP.

Peng Fan (4):
  dt-bindings: mailbox: imx-mu: add i.MX8ULP MU support
  mailbox: imx: replace the xTR/xRR array with single register
  mailbox: imx: add xSR/xCR register array
  mailbox: imx-mailbox: support i.MX8ULP MU

 .../devicetree/bindings/mailbox/fsl,mu.yaml   |   1 +
 drivers/mailbox/imx-mailbox.c                 | 196 +++++++++++-------
 2 files changed, 123 insertions(+), 74 deletions(-)

-- 
2.30.0

