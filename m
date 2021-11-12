Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A612644E1DF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 07:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhKLG36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 01:29:58 -0500
Received: from mail-vi1eur05on2066.outbound.protection.outlook.com ([40.107.21.66]:18625
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230187AbhKLG34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 01:29:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ck4PZAAiBfa8ippejYbb05Xk9cVZqXIaCvcGnnoOHQdydj8oEPnWO9nbB319rC150TMePkUpTQ7fMSIN22U57/zbiIFGC/nu1JT2HCl6UczMeCJx/9sPvW+9VLSUJYAfq03+i1LJVKzM7J8vyMYGW3Ckw5irpbXnCSnavzq6J1V+6K2B1MxEjBjV/wKF3I2VwaDhTYvUhuHdoYDrpPR89gwaSgxqTcyytwFOOEje7MPGOtiXPHoVP9vSjd7/kCcVLb8COvXJkxHvFAns0kWi65MqWwCzwZxUwA5NYFOY9CTqUdLgydoO2aDoNLlHTu9zFuBRzSWnH8DfgcqXkUiweg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbNyI9bYjXFt6APwglO8wT2/UnQoc4zlEjDitoG57JU=;
 b=FUPU5BgiFW1tLqeZon6lSMLcP2HHqELo7O1KWUaJ9qeP7tC6CMkGw3Xh/e7eZoQTOgop9pdZcXsz0nY5+YuHMYqwzfC+9zmskEHtA255zebaLBmQRoBjwAqYli8q02+CvTRpEaHBssYpM8HFOil2zSgIgj5zF+OPk0qzEZeoC4cBJgBZQydDjNP/IlKMOTd4K0radeUiCTIuJ9cfOSvaGqUdOZ/oSJ6Nw3Vpj8kkb5KdNLYuwtCd/SacY9qK+it9oXYK3dYfW/QKa7jrSYRFi2kwDzAMD7f1cxfLUFL1E0o5E4VYHPTaaZKybDccNcNqZ+bWZhv3lSkjwpJ/1F+pbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbNyI9bYjXFt6APwglO8wT2/UnQoc4zlEjDitoG57JU=;
 b=dzjUXoxHwkf73Pvrry7FAQphLRn+vybpQv/HPCvMukWjIiRZTCJxQEi9+ZrHeSOrFutQjTrbED5ngCnpzBdj863GqCIoOgy5Txq+1BEs9ztHaZF4g5Zv4mqA7xOKilkBjmzh93appbUKdcXa+m10lQLBzpzHSmckLcNuGREMR/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9473.eurprd04.prod.outlook.com (2603:10a6:10:369::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 12 Nov
 2021 06:27:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 06:27:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/3] arm64: dts: imx8: add cache info
Date:   Fri, 12 Nov 2021 14:26:01 +0800
Message-Id: <20211112062604.3485365-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 12 Nov 2021 06:26:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9d5c5d2-abaa-44c0-79b3-08d9a5a570bd
X-MS-TrafficTypeDiagnostic: DB9PR04MB9473:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB9473D264224BFBA3D2C4CB0DC9959@DB9PR04MB9473.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXQ0MxpnPtQgjh+6K5z12vYhsO8s0svDS3CEUAjTnt35C2/WRO/SFS1H1F+R9LXXH5lAvekdFGZJw5GJv3y1k9//tOTopl9QKuX+zSvtRbvRV1ICVfaogSSdV7qaGF8gTvH2NNkafOUKOTLUIAgFetvJUYTHIsJ1s4/ARkwUktNKy1bH1pYGJKxlS4T7YL7u2tJo8viPKG8Jtpw9ya6p0kvcwWhCb0YDQXQbrPp7deq3mkM5voNUNG4Y9fqHWP2tcX1OPPnLSQat3z78QkCUy39o3FuSFHIL5zmcU7mECe4MZv0lCUz4tK5EiOfTUndPivMSm9bzLQg9dZvJTMvpp8E07MQmQs8zfFsrUoTAn+4LN/UgnN+JTEXk8GjvG4PBYOJty8URwGG3xGUd5xpmW1w7I0IZdB4Kn1m5cIMHvr/5poRq1LbUEAEFxGybiIyNZP7Ut/WtoLLedN6EFosShD3S9KrLQ0EmnoDlp5y+eT4ZFbVT7gjbeBLP371o8Gbe2h0lz74nRcyUwfJvlraXcsHer8fNhyn1su3ZORQbaEGGLQLzS5L5/vgDlbiS4SLuHZx9CQXqur6Zgjd/pdLU4s3uAaCaiu2e/xD7eXfjhg1F7+FTqi3ojTjWveIW1XSYJkuLlFVLg98Fz7ET55Qmn25tG6utxaZvL1U3xMtgP4MJg8iEOzEJ4ZqDQhfOAttucITMBI/vlsZRHyN6YN8TiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(956004)(508600001)(316002)(86362001)(6506007)(66946007)(38100700002)(5660300002)(4326008)(6486002)(1076003)(38350700002)(186003)(4744005)(6512007)(7416002)(2906002)(66556008)(52116002)(66476007)(26005)(2616005)(8676002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DnAzUgvmsRsjKITVFbgkmMrboB+BTneOsMk5yt8BNNo1JEuCLne0IvGoZAJw?=
 =?us-ascii?Q?GVFqg3panix636ewnRFGOjAYPW+Qj7DTTxxWWZ02dqXCmjK2nLCzUy/tmD8F?=
 =?us-ascii?Q?j8pEw6TIVYT7qSwAaoKiX0Tr1trWBIjGSOP1wDWdE0QClEC8mO/GVbKJhFew?=
 =?us-ascii?Q?5f+b+C++vQgjMlfARl6lmSke0FX6cGNBOqfpKuLzvW4JBdHlfP/5Cm+e6Pp6?=
 =?us-ascii?Q?W2bfnF0N+ViSbhPACajC+XnSomEdDfXb29ALmcApz0111GwgUVJb4lzDda5P?=
 =?us-ascii?Q?CH6bZxAZ2/nVIqE6Drl17aamybeNsP+5zr8yJgUA6uI0csiOWGJV0eBrcon5?=
 =?us-ascii?Q?cmVc8p7fJqSwdXAxn1U/Ey9dzbBsysoSmVZ1wXmhMu9bjxDTCf+3Z+Fe8boS?=
 =?us-ascii?Q?xfttXC6oSzBexTRAwxeAalUpzLiR6IPquOPCqcraTKygcRAIbRKj9pYGwJTz?=
 =?us-ascii?Q?VaR5scfydKIitVxA0SAthEkNbuYa1G2RfI86g1uHsQ/xtnwR7e06kurqLKzh?=
 =?us-ascii?Q?Ctyt+PE/WXsyi2+8gsl9UofbeeyzVZQMDo6Mz76kaFU6OtkaVq6CnHJMBmMY?=
 =?us-ascii?Q?r2iFVww2+tXfyhFqaN/EItPqdr170ephSQcadg7O1Stu6L9HIjUcXct4jfKl?=
 =?us-ascii?Q?aQcNm19gUkryUClIBsYeWwT2IX2wFYpEv+Z2w/Ko/R7LZlAyFsKS/AZ94hxB?=
 =?us-ascii?Q?ozwCm+wCgwejrJneKBs7lBo5ftvJ+CzQ7v2QuWimjtrThQNkZxe2LH3s3ZNM?=
 =?us-ascii?Q?xFK6eT1jBpR8ROc1Q5FoqSIHnkFRCtXHn3itl7TvR/OWmHSY4ABLmQKKa/p8?=
 =?us-ascii?Q?X3dJoMXi+vR1qLD1YdOZ2nObBFFc4IHkgHAdX/GnBQlfXqZWPnQgxB1L8ntK?=
 =?us-ascii?Q?cp1ZV2/mJHv8QLP+bnoBMjvu2OBWD8I2O1CJUE1tXriBHnFsq9ra+LIl1EIR?=
 =?us-ascii?Q?Gc25vmHHPzl0PLG6QSYQfMzHIVDN7C1zdTk4iZwMo+7no6bQi43qbexyxXDX?=
 =?us-ascii?Q?PdWMDAfndv5vfoSSyxwG2iz6yDLeazWwsaCOuvY1hi2P4Dgxj5Fwu1VpgpMC?=
 =?us-ascii?Q?LVxnxDsfnHqLNQv7vEo/wfQ0bM6h28YE9715JtEIBT1HcJP+E18yhnerQktt?=
 =?us-ascii?Q?pmqoRN8lpNJV5WpeKWkvgOqmnJft4QyzlYN1F5xzlATtBCiZRPptujs8vIIB?=
 =?us-ascii?Q?lYj8496ttea1w3daId5rzUc0HEGOlBZlDH2sRimhh3yXMoGwapy5ZadGTs96?=
 =?us-ascii?Q?CkiL5tRkGN01INRt/ZsJuDA+9feFBegR2YhoW3/ydka4m656gT1W6GUVUI8e?=
 =?us-ascii?Q?uJCs/gXkkNeWYO5n0A7Sqdm2PjfaeJ3IndGnlYlAQPfUWmnfs3pW7+jYJDTy?=
 =?us-ascii?Q?JjVelZMEg8OV0t8OMH8Cy1vu9rdpk9X2x0/Q5p7DQ5C/GuVXDqL6GOC+/ktf?=
 =?us-ascii?Q?b0MnnV74O412edW5F8Vg4ii3DD15nDOdC25g/sKYvJgPf0O/tpLq47j1+jPh?=
 =?us-ascii?Q?uB4SlOgBxQmMijMszw+Ggu6qZA9a1Kj6Owe+ZTGflJDSkks8y7vmHNVIm7CE?=
 =?us-ascii?Q?/zi4iozPI4CoqFhu77XSIJ3/9YlM11W1T+ME8TUSArJCn4QzzX1dDTWahnSz?=
 =?us-ascii?Q?uJa67Bm3Otl26FUXXqZYLGc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d5c5d2-abaa-44c0-79b3-08d9a5a570bd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 06:27:03.5560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SypXmTmqhMbr2D9VDJvqQqhbkXDjN/IQ+csfeyR0IcS67yBFlG0OHvhlx5CWDF+OF4SCtoXzpZtHV8NzWXnrDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9473
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This patchset is to add cache info for i.MX8M*/QM/QXP, then
people could see the info from sysfs.

Peng Fan (3):
  arm64: dts: imx8m: add cache info
  arm64: dts: imx8qm: add cache info
  arm64: dts: imx8qxp: add cache info

 arch/arm64/boot/dts/freescale/imx8mm.dtsi  | 28 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi  | 28 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi  | 28 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi  | 28 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi  | 38 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 28 ++++++++++++++++
 6 files changed, 178 insertions(+)

-- 
2.25.1

