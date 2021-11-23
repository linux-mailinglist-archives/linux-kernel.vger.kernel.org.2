Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED95459D67
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhKWIIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:08:25 -0500
Received: from mail-db8eur05on2076.outbound.protection.outlook.com ([40.107.20.76]:62593
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234660AbhKWIIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:08:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAV6iJDexp+IV5MqPZSx57t3VLqDHXXg3MPU63uZsmtNVLddNhBvs5fvvDvRoruBJiUkDadDp0nkFEHXarZaqbs5bMFoDbasFIF06bPJ/Nx3STn+2yeallYLCmkVJxK1QLvIEFfDQyTVcWE0IavsXBRAuwViTYeyfN9DbarXKcSNW644zKdvHs5lltT4FvIzIbvEPnRburPfTlcEsjgTPbJvmXg55jhJhL5O2lXCKl9TJR0nmsGf2l5UYhKXAgjnbHZWvbSWxQUBJRtMowTsf9+4yFgtfkb2pVPzXaxDlV4otXJ3g59haDZvVsEY04iaTSNq1PA3SreXy211xT0Svw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ld/drdikx6Fy8ZrnG0UaWc0QBQi8xNwb/RXPy53wFFo=;
 b=A8WgE0vGjSuHoitnMQVtYbsiDgIQEUtDsR+AfUuoy1zlpRBuwfssMCGqsmlPPUUpSIuNkIvkCwyc9sumNCm13n6/J8TMSx3y1Wo4hinzajmc+LUSQgj53NRk0/uCA5Ep621wZzsHZVTejbvhDd4+DZKXFumPwA+I4Kecn1P5sFOPzXFy7GtZGZ/7ws9NdZo4Nv9evXf7KyXWfDERcQJ2gO9zfgNW52aU/AzldGGJk/XgcdoXB55FJ4x9DiaXLE0yIJPMT4iPAWPrFh0fV1RiB9NeIF4Pmsdz3h8ti48ZgjH/0pmakvnudPBxDyY3/4uuUt4E/p2zkBilnjsY5l3ozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld/drdikx6Fy8ZrnG0UaWc0QBQi8xNwb/RXPy53wFFo=;
 b=GkmxxDYA9lOyGLE1SlTrNny6LMtYX0dU373zsNukzekt0n1Jvv7SdWEByzV0I1DVdw3tAz3osn+lY9n6ozR/ci88WkEwhFbbprYBJnHkIl37+F6ptNYuPW0JvkCpIK68g09BsWX1um0UqCKYOzTnEwaowhWoTWwWNff7Ymg4n0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4106.eurprd04.prod.outlook.com (2603:10a6:5:19::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Tue, 23 Nov
 2021 08:05:14 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079%5]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 08:05:14 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] arm64: dts: imx8m: disable smart eee for FEC PHY
Date:   Tue, 23 Nov 2021 16:05:02 +0800
Message-Id: <20211123080506.21424-4-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
References: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SI2PR02CA0045.apcprd02.prod.outlook.com (2603:1096:4:196::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Tue, 23 Nov 2021 08:05:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb80f00b-a04b-4331-e0d1-08d9ae57fad8
X-MS-TrafficTypeDiagnostic: DB7PR04MB4106:
X-Microsoft-Antispam-PRVS: <DB7PR04MB41065E7BB16595151E772556E6609@DB7PR04MB4106.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGBCqs5SpTCCKkjXnoQLiu8NOiOQzZBY0HBvfzMe9+EW275SB9/WF0Lb2uQNgYs204J5aIPQO6NK70qWwcwHLMWmErwKYg6eZ8Qh/hJEHRQBOBmZ+XF4EbuTHJwihPfx3p65AoCvnC5HBVQ3aIXPSjR9CPLAxFJumVdG+4LLDaoDfGI5OAkQxEjJjhfUiSjOFQcUMVrMWOPI3hrzLj6iurrF/gQibGBc5bEe1+WVWkU1cKMQyQSaYt/9d3Y/WmNlxr3jUl5O3OOHjNCK7dT62n+d5msIT9cE00K7F7I1xUFyBe2znaHhEGLdp/V/htOyyGwJVsEugGsaO/g+iqcZhZXdqvV3B8j2rPzgyC7Da6JaBMZ4RgWuXAej4oZx8KjftMXtjD1H/8xbuE+EjErhn3yi0v6Vvm1AdnkJkzKbol1uMCJnoQCEMWE0WIHzTsrt9HzEte3ITd+hAoM7zHKKhGwKD2vgyudBSuWPl8zINvrFTmI5gIMsDIKWT1vlt0NFxc3v6DuhbCF0CgxYz8jjHamH1D2DXqrh+7fXBsqTXBlzCU40yyeDXNB2KzbmjszOkF57O6eBiicOhMcvUyHs4A5derIx6FE5KVzHG34wMaCoL3Vv55P4hivMOoIuhLGmQckgbvm3BU3Ygz10NYtaBJxR/JCHXDdB21rd5iobhQgCbujO7miOcoV9tCzJTQmjLK15ozY6iRRmlTt7AEopubk/HswTMxcH+bhflXgzcPo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(6486002)(66476007)(2906002)(6512007)(66946007)(316002)(66556008)(4326008)(52116002)(8936002)(8676002)(6666004)(186003)(26005)(956004)(38100700002)(38350700002)(2616005)(5660300002)(36756003)(1076003)(86362001)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?opLNAPnp0Jczoudal658yakrWi4R2x3TuYYAFD26D1/cQ2It4AYuXlYy3EXP?=
 =?us-ascii?Q?DW4M4VYWh/JIzf8xl0O+6w4CE71seLN6F+ddL2g4wqPxcMqz3FpHYyIWrR6K?=
 =?us-ascii?Q?It7gRcy6j8CmMztSKCp/SgLDuDTBCkM9oi3Sx4L1e1ER0X4X+wPd/bUwvOYN?=
 =?us-ascii?Q?VH8QhBLP66nAmvV0foR5ZZNHA8IhyWBy03fsrHr5mxVa+6pUIPI+gfpXonkx?=
 =?us-ascii?Q?T9h5IgM2dsfSlqL8ec+Eq6fHF1zVqYKzYVf+Km+5s0q0QyQKzSiVhtMb3cWd?=
 =?us-ascii?Q?mFNIl+vn9zB8yV1LxRijO5gxvWtu/n7tHUblNuuXEkfCvZQ1VncnvPRrhxEe?=
 =?us-ascii?Q?EtD3Eqf66v62rdmJU6XZAtbWYbL/AmG+8ObE/xjH2shbHbQlvGChAt8Di66H?=
 =?us-ascii?Q?Xk8gQFyAB1QFz3PY8qOwa5KaKtKLSNFqDn/ojhTRNK5F/c3TvCls3OBXm6ft?=
 =?us-ascii?Q?s5r27CkjFfSSFOCCKtkXuhQI/vscqLZpQJSAymY4APpuvFKuWQSSDr3IAkKr?=
 =?us-ascii?Q?ghHBp2NL2S4u1YRsYL/MwtAS3DEt0rmM8gK9NrPempAYh251p59qdoM8Nf2k?=
 =?us-ascii?Q?y9CwuqzFIligsa1pVWLtXfhXYuUAMGFxkpFdp/WYL1JuNmBhaBYafrGpYr0h?=
 =?us-ascii?Q?iB+85rL/U9IJdSE5u0IY6fxLiGeU+EC08UVkXObLmFO/fvJwbVynyo1mq58N?=
 =?us-ascii?Q?qjYJNSLEIWHSCSgC3wCorMyRgiH0ME1rGdJPPto/EiyU9qNHSnYGuvsjRXAe?=
 =?us-ascii?Q?TRxm6QDO69W9s50wMeNd4XS8fO72iDgPJE1AjEO0uiIGZn9KlvzlRCFtZ0Do?=
 =?us-ascii?Q?SXtj133Lj9cecijO04yk1uBAdED0GDQUNIpVaMN2D0tKcqEfbqe7RWRVPcdp?=
 =?us-ascii?Q?EjY0U4s5IByYF3KrntxpUFV9DVK8gVRFb/9LsXnB8aKY2Ty09XIvgQpPmpS1?=
 =?us-ascii?Q?tFYHaRT/H0IVLkdhkmvfD3SRMRkP50sxJepXjzQMqhTvmibOQAzV87CfYLoM?=
 =?us-ascii?Q?QB5H25H/pj8REhJW6gJIUx4ScpSPzFkMbc2So3y2CROJrDCZ+1Csrs1JBUzZ?=
 =?us-ascii?Q?ulg00LbKpkRCcpD6kECT0FiHEROdTUU3ngWNBu0o30ye8bDxYWhPw0gvpOso?=
 =?us-ascii?Q?PkwA10zZNhdO6dxWMkTFvmIAa8JxknOOZVwkLqaoaf8dg3RYaNwQBoyf5KZr?=
 =?us-ascii?Q?kSVn8+z5+WhZESVymw7iM/31a+WpWd2E0nmLPUDUuR8Xvn0Gkn3a9GEy6nfw?=
 =?us-ascii?Q?YEw9Ku5EC7ZY4xFHxPnQ+JExFAJZlBxQk/VFswlMqmjTBy+5sisCMdweMhxF?=
 =?us-ascii?Q?1+ozVODYebohk1vV2okP0MVzZH0Kqyexcn4HnePHQNEo5kXe48sjuGMpzvPr?=
 =?us-ascii?Q?rUe4bme5rlSH2nLAXo30D/wPb/Nsxtuf9x7otxXTY6GAbuclHudVhTy2yZRx?=
 =?us-ascii?Q?3lSbxa1DUWIYcriXV1vUL7TsleA3KrAwEm5i5jU+z/u4XjCz4ePuQ+DpRj7G?=
 =?us-ascii?Q?MVJbeRwh0+YDXz6rnzedfkId0+O3nQXpDSwas2BcSuktARWswCJjOGBSpJXw?=
 =?us-ascii?Q?PrrclVpeOWWpf1n43gRj9N/B1Kkb9jGPai0Z/vamFcOG3WqcjTd7rJZenMOq?=
 =?us-ascii?Q?aqy7wdIThUlB8TZeqeoH340=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb80f00b-a04b-4331-e0d1-08d9ae57fad8
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 08:05:14.5601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8J0aMaRc+jMNieBaLL6gRubY0jWtzI9jLQcBNOahgvLUsmdQTqZUWU3Fxi1rr/XDeNpQVLpVvkwFPH0UjYo1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit 390b4cad8148 ("net: phy: at803x: add support for configuring SmartEEE")
described, disable PHY smart eee by default.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 1 +
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 1 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index e033d0257b5a..50b3bbb662d5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -116,6 +116,7 @@
 			reg = <0>;
 			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
+			qca,disable-smarteee;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 30e7c9d56090..342f57e8cf61 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -99,6 +99,7 @@
 			reg = <0>;
 			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
+			qca,disable-smarteee;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index b83df77195ec..a9e33548a2f3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -169,6 +169,7 @@
 			reg = <0>;
 			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
+			qca,disable-smarteee;
 		};
 	};
 };
-- 
2.17.1

