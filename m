Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFAA40377F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348748AbhIHKFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:05:21 -0400
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:14657
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348771AbhIHKEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:04:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f93go9PkowKK1iIKx/UzTFJi7sQA4cMsH56z2/yppyVAuqOrG6rSYysI0aOW0r/vTUL8W15CrvfmZFnZhMLoJnhhaHUZTGIj4gft5SRScRD6VmCJS5nlFZw9kLDpwDIVw316V28dgvWJawUakm8VKGxjoo+88CwWnv5kMq8Y5zxCkO7BDqTMPegvYid523ffogg35sbDKHz0f7sIuVCFvrVcULfH8JKB31RA4zPQgmgTgBm0E0ZSCxbeNjt8qCULtXrAHIkso3LOJmi9PWLx0EKDv+DQADDGfa/FBssgOkW9pX8vox9x/z8iL3i6uMETsGnnN8FHauDRR4EXWDCKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TDgemKq6P1MdA7Kl2m3yyrwqgQfYCGz2XfTrDEpCyG0=;
 b=b+S1+9aUgQ/DbQz8xlnIB7ER6DnDc3EDIetWzZgqtq1o8I3dOCyaJiQVHtFo00Gie6pNT31PFLB7FTRjT3b4WkoZNF0JjQ086LI4M8Wn8TtuT8Vqim107uEMYhmkXPmxYmbg+PcjvzAiWPuxqo1VsMqWr3wf3SsBnv8vkfgdfm4ICpBP7kwIeo+nMzOX2RxFOfdELD3XTa5a03A5fZPMomNS3yVheJOxv8mkNKuuBT2CsDHxhdg+4KqPuu+ebSv8CHhMf4TbVBjqWKVq1EtPGyJQCQ+G6BLuf15foxb527t5pUc3hG1CtaMJ61M2FXmZ6i/6ee9GrmnI5/ltEXnH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDgemKq6P1MdA7Kl2m3yyrwqgQfYCGz2XfTrDEpCyG0=;
 b=XJHWQ2EnOfzyHeAndsDzylpklpiU8+LqEwtMFCctcn914x+2EcE2sH//oQTZoqX24JBRZg5IzBu3dmUuMNuVdRSW17fedMTyVW4Vuu9B9Bm9IlDPWt5EiOrpbrXYb1lR6vebM6M+cdvS1tXmOubIe8pgnG6lgPtt556nUXp8v9Y=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB5786.eurprd04.prod.outlook.com (2603:10a6:10:a8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 10:03:23 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 10:03:23 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arm64: dts: imx8m: remove unused "nvmem_macaddr_swap" property for FEC
Date:   Wed,  8 Sep 2021 18:02:57 +0800
Message-Id: <20210908100257.17833-7-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0105.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::31) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0105.apcprd01.prod.exchangelabs.com (2603:1096:3:15::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 10:03:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 290994af-bf16-405a-069d-08d972afe4a6
X-MS-TrafficTypeDiagnostic: DB8PR04MB5786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB578698471808A005AD85C7D9E6D49@DB8PR04MB5786.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5pN+qk+rnuQ2Sk7nA01IOzNwzMzAFuBVMUbYA+2i8ukXR/qxV2e4vPcPCQGNTrDy/kANjQwf0HEfk56sQENMZgluhQiv4r1v2VxgEzNAOt1OqmnHbI8mmI2VAyC02FRlKdhM74Trq8hnFCfZK0sjYGzWuN2jE222mD5q/ygVCYPH1wiC6gEDiXVVxrixs3vfTsoxgfSf5LDNJW55S4nqFWYyswlXKb7VaSmwHS5f1A58BqDCf7ia0IUAv3Jc0+gGVG1qsUDAJR4B2fJEAroftShWxqbyhYiz/9ZU0MtUHBFutsUzx+7+z0hFPiF+g8SCSX5eGZuqijMNYuu5+wHDPm5+ZetQC9LrPyTpKutgKjkhhnK76ijAPQ7MBxHEm0lKH+cQhWHhLXKkqKsY7lvIR/5u1irlkSiY4ozKjwp5U3oSu7Jvry7pJyjwkrlZw8MIEHrGqIbM/FDlIRAp2rROFseQFTQvcZ7oLmNy0seWbLR/996d+ug7I5SQ6kkEDdxtrUNk1SgEWak2V6NKlxFzvyurNFoWsNn1Ff43595EBHBjRkS+tTtp5fBGTeJO4ffDOoc3H4Yfn2kO3JT4JDR+4IQNF+vwYigW4qJQ0pq7SogjNbdJt5RwK6rbPo3kqstBj5k9Gwh8ONOJ/eX/S2l0I8b9yTnGEQXr0SDydkYFwCzT1gshsHwgHJOG06N/1YuNEaqSz3Q1YCmOfqmF2aKRXv3hSEOJyXoSmW7TbwshnA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(86362001)(8936002)(66556008)(6486002)(8676002)(38100700002)(2616005)(66476007)(956004)(478600001)(38350700002)(66946007)(6506007)(316002)(36756003)(52116002)(26005)(5660300002)(83380400001)(1076003)(6512007)(4326008)(6666004)(2906002)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FJs+f6X7831aP0MlKbbIsWhDr0TSmWCFbA0RNpkZccJCGf0X3k3fZDTAW2e6?=
 =?us-ascii?Q?uQlHBeU2uCk0sXqB3lbhdfJT7cdtZnRenQuA1HmOUQgMvvSSNNwTt2kmtD/B?=
 =?us-ascii?Q?1H8tUaGUxTQuhdBQHExWwAP7eTe1NUsyMe8V8wf8nrzigHOXGusR3iOyE1Mm?=
 =?us-ascii?Q?+0V+SKpGkPs9+l9oXkaN0NsbYGkf+FieyBHUbLhzJ3pUGfAPrMyuCxCMXgW8?=
 =?us-ascii?Q?CgJhZJFA4NElHzPd+fw259QoedXTPMT6VYoPgUY0FvXxaJpvU9xvfSP/zi2l?=
 =?us-ascii?Q?tH/dj6gefxYjwUmIJjwm545c42k3dgLXth6AFu/x6YnZhUxXBIA4AtJnUzpa?=
 =?us-ascii?Q?H/wxHJKX4LOYFjBXD6LsftRKv4dpwFFiGfIxc/sRMYzG6j9hlZ2LTqgvKkHM?=
 =?us-ascii?Q?7UnCAchhy8bveiHXBrIfwYOtpuVk0HePQG/gA6eOcPpkgh287ZcEZJYXr2r0?=
 =?us-ascii?Q?WJBABfBUtalWee/D6W21Bo884eE9mLlgXJcduh8z4AYAHdqQU9iFKsHfNryk?=
 =?us-ascii?Q?XLrZiJdn6qXDjWY/MvsqPZc3Ah6bvppBDBDIbeXnTGTab6+OCrsoiTAizAJq?=
 =?us-ascii?Q?fYdZkCVEUGSOi4hQxdcnINaSe9vSmUvKAUftSnqNlbHXM0Y3OYGu+FI/LMtK?=
 =?us-ascii?Q?HuHIPnwAwjtsUA9+9wzXDIKnbj/K5d6DQtq+1l+Esh11fWio75oTLnJmXt4w?=
 =?us-ascii?Q?N7xiDQPNup15k70vEp8ITvTw5PzulaZfcQsjtpggAjEHkdWkpNIayT6rXQR5?=
 =?us-ascii?Q?YWMrFTFz86dNk1W4S/7Xl1EfI8k1ViGV7E/so+F74BY06vvCKd7WNIQ/TmKS?=
 =?us-ascii?Q?tqcieCF1iijhpbPTs4+V7N9pOip+FctRr7dvDmrF44CSTi9UkUDOUQaOmqyY?=
 =?us-ascii?Q?14RZ54v8KhVyr28JrrLUU/SBoz/3aumA/LwuBFAl5suj0IocISnZaqPDjg0J?=
 =?us-ascii?Q?Y8fyjuj2Pc0hDHpYeQuaFDXAeWe+islPVN27lXBSPKgMNnfzJpVI32VxeAJv?=
 =?us-ascii?Q?3M3JwUSRKaY0rShZ9Yb5FIpWCEtERUxQPo6/hSaXnld+bBOZcjMYA4MRfy/3?=
 =?us-ascii?Q?p67COBiwrfiXdbp7uT+25NwQn4dmRM8O6dh6u0bONIFJxQez3UxNARSLCnI3?=
 =?us-ascii?Q?KJ4Y3mfz7ouemf69lL8qjo22bLY0dc9b1MHHbaCAAB9yLXsJ8XF+E2klIvVf?=
 =?us-ascii?Q?V/rdK0w+UDptxenqsNjlOWAXkgknKo2gBFZBuSyut3G+P8q1qtuZLtWcuaXT?=
 =?us-ascii?Q?W4PtFn0hQ2qeR9fo/xjqpVaLcPIYUWxK7QtVNxW3BSkZqvYQ4ZzvKQAfHWX5?=
 =?us-ascii?Q?5U7PjuE58fGUbcjw4090gfl+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290994af-bf16-405a-069d-08d972afe4a6
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 10:03:23.2098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVsQwHAmp/kw0tMW7LMnl5wNHPKAHvFJtyxkTaWkjrEq6JOq8D3Fkp2dfS1GDmtL3vKvHyYapDx/YEa02C6hww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5786
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused "nvmem_macaddr_swap" property for FEC, there is no info in both
dt-binding and driver, so it's safe to remove it.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index fb14be932386..2210cfda4e60 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -948,7 +948,6 @@
 				fsl,num-rx-queues = <3>;
 				nvmem-cells = <&fec_mac_address>;
 				nvmem-cell-names = "mac-address";
-				nvmem_macaddr_swap;
 				fsl,stop-mode = <&gpr 0x10 3>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 0a994e6edc0b..408024426315 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -951,7 +951,6 @@
 				fsl,num-rx-queues = <3>;
 				nvmem-cells = <&fec_mac_address>;
 				nvmem-cell-names = "mac-address";
-				nvmem_macaddr_swap;
 				fsl,stop-mode = <&gpr 0x10 3>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 37188ff07f21..cb7867791d05 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -821,7 +821,6 @@
 				nvmem-cells = <&eth_mac1>;
 				nvmem-cell-names = "mac-address";
 				fsl,stop-mode = <&gpr 0x10 3>;
-				nvmem_macaddr_swap;
 				status = "disabled";
 			};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 1cb211e470ae..dc4e39ef9d39 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1191,7 +1191,6 @@
 				fsl,num-rx-queues = <3>;
 				nvmem-cells = <&fec_mac_address>;
 				nvmem-cell-names = "mac-address";
-				nvmem_macaddr_swap;
 				fsl,stop-mode = <&iomuxc_gpr 0x10 3>;
 				status = "disabled";
 			};
-- 
2.17.1

