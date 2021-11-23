Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD54D459D70
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbhKWIIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:08:39 -0500
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:23110
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234703AbhKWIId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:08:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQNu893MdZS7T/qCJNM0lDsgoPsZM9NHr9ZMBWt+3RAvddLPRdyYf8pHiGIi4aQaEQ7hyQPfA/e5muNogVxXoxo1ZFNAY5XXuPW0DVxfjBL1z20K05Ca6M8ApJ+4E8sfzHK2jQ3KY7O1jKCf9/aXZsqlReylB2kIYCua/vM4XzATinCGP6DpbUWjcDuNsuRDCE2cCeosmzR7oPhTnV2A30X5NZ6rPbENuXgmBDype463NiK4VKaHnANKwbSr66dE/XULJZiwBYLUvt1FGG8Z5kOE8whnTN5TqAnhvmpFh4FSE+VvOpKpFHLxIbrz1jVtMOwvgOZyLOpTiV/sllGn/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sXzkYvdiXB/8Py4eoGJBIRPQRVnP7/r/4grNZZyNFo=;
 b=lwpn79uRuJ/0GCui32jT2NhRwyoMH5oc0H4lwZOkRypnw5h93BPkbxstb/HNihpqKPuqBYG//nIEwvqYC+BsPFiMJLwi7RC/XfDQAXCm9hLfi2DikKMcDG+LWZgt5y9TROq32wh++OcZgeFAScpVY03AMZKrLSYjGTNVeEkqfy/BIK3nxrrF2162rHXNsi5JYedBkCbb+uBn6FgIQpnlqNsi/Vaqeg6ajcnMg6rW9fiuBOsvjiv5nMs82f/VYa0Q5v0lw6aCrE2rDYu4CYEM2j6yMrqrQfBssDZ2KHVG38p88MkhwbRVPZHEQ2ZeBFFDM7hLIGCtXL0ef5xI5s0YRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sXzkYvdiXB/8Py4eoGJBIRPQRVnP7/r/4grNZZyNFo=;
 b=nvS1eqoQRuIyNaMjcm8Fwy3a2w0T38BhK1QZKWHQmt6olDow4dLyfzbwAQGERmdaZr5GtaOMmrX30WhkpGO9pByG/N0GtBz8cOk+80PpvqmGhqcQKx2T4gKg8ikAIccFI49RGAuh9lPsumR4psg8cJGcsE2P8/XKMtXmRCV5APE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB6971.eurprd04.prod.outlook.com (2603:10a6:10:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 08:05:23 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079%5]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 08:05:23 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] arm64: dts: imx8m: remove unused "nvmem_macaddr_swap" property for FEC
Date:   Tue, 23 Nov 2021 16:05:05 +0800
Message-Id: <20211123080506.21424-7-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
References: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SI2PR02CA0045.apcprd02.prod.outlook.com (2603:1096:4:196::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Tue, 23 Nov 2021 08:05:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19eb67f4-6645-480b-c6ed-08d9ae580029
X-MS-TrafficTypeDiagnostic: DB8PR04MB6971:
X-Microsoft-Antispam-PRVS: <DB8PR04MB69712F80CCB26DD2987EA3D4E6609@DB8PR04MB6971.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4nwnUu4L+Ry478kfQ/EtL0s0cZm8EtW5VD/Z5tRnnmzdnL3YGpuUX4dLNLnAxCvMMqVuACpuFzu8Adu7mUHTHrJslA2hTHUffMaNblf3d58OT1aAnH9T5SaYHyL3P7Ud6S+8dQ/PmZXSG0Ju9ZlM9UpjF0vrA2cdYv6Vr53vCglewPw4OUfJU81SARYzUSqXG4+8OkYbfWUD0YIRhMWSDAFZz4/tAtqdNrwt6+NAku+6CfzLNt8QdCEEWUgeLklRbgSlRIMznWRafK5naxgqmHm07aeuhwwN46TWuVvNcRvG8g+aZnw3K0Z9qgWPh1/faHl9gwrqDExNPsE69GzIYd7DDzBBlTAPf4B0gEx7wgZwcjOqPhQdpahcReETXU/Kl9yMWvUT5b/J3+cnwbSX+0WVEPd1dpPTjYzGJkDdnqKybSF59V5EMfCFmlXjFTW+SXp8M66wLI2Wa79x2lG51yaIAz0R8umTR6KeHP0ilSBspk8jKjnp/zfE08UPI8GAF1wmIIsoTwolx/JE53W0i/v0IFJiKP7tOXmHNqxY469Wq5FL99nzQ/NVC+Xey0waDTmpVoOjnxlDBaAgBNjmJ4SdOWG9aG4imv9cKsCS5g+/9Crb35WqId7GYBREYtOTOmAbAHuGZpAP5O0dDTNTw1bLO3n6m6Q+IQa+TWGY9H4Prt7hiKy7E73hmteknK4ggROpzPM1IL5f+s8wPz+6Udn3W8W8nV9wlP7uz9OqvPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8676002)(508600001)(2906002)(316002)(1076003)(66476007)(6666004)(36756003)(66556008)(6512007)(956004)(2616005)(6486002)(66946007)(38100700002)(186003)(26005)(86362001)(83380400001)(38350700002)(6506007)(4326008)(52116002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sT8fsFuGfvb2IcCbE++pOwG1F1hvYf+gTl9tpRojXNMB03TZ3Yl/RzPGNrEe?=
 =?us-ascii?Q?63vL+jbzy0/qDVarofYUJ8cy3oSE7LhTAgvYABNgoEbjGt0LatqehUoglXlm?=
 =?us-ascii?Q?NZStcw0cRBQUKpiSBk5stF0WU5b0mBS4NlfgrNwiiq5UFGAUsTQ+J2NXCSTG?=
 =?us-ascii?Q?JxqIvY9uX9jD8tqZWiP6aXzZg43eL/ySB1ux8o7MBdsNHLkk8OZzLs1MKK82?=
 =?us-ascii?Q?E7Ua8KAsFmHhWSnRwyiq0l0k5UlQJOdjhFYCXFX5ZAEeTxcRLYGsTcpMK/y/?=
 =?us-ascii?Q?LRBhwlUEEFu6HI0DNWrnHSx6Ir5YQIgsk9Jnpt5C5doTrXlszFULdXmcX2Ri?=
 =?us-ascii?Q?xd2jem1fnelrvmYeJVnhFplNLOvC98T//6Zrf03lh86xcoqt2fTh0X+KR90a?=
 =?us-ascii?Q?qMqxpYWRmCccjo+mBKort5I0IRimPNkydF9hXEWeMqtv/3INYX0ZFcxvDDlQ?=
 =?us-ascii?Q?xW1vCpY30UUMUUEHWigtf/0/AgQBNW9RE4pIS7bRWI/cPAR5bxniYiBtYYw5?=
 =?us-ascii?Q?CjvWvmMy1JhfPqwo4UjR+dsFfjKXcT1bzGYGpqowCjyw8ZGQLjq368i5QlOm?=
 =?us-ascii?Q?rIcD4en1ilh8tOFpOqxstiJRa9R4pQ5d30Hg334A5GUls0hu1j6t5YMHlZiZ?=
 =?us-ascii?Q?NfDG47pAa8/G0XiL16W26DDfcLP8YGDBnCKjUKxw3NVFQeyxM3BJXGxlvTPj?=
 =?us-ascii?Q?niqxgDIV2G8L2M1vfNHZshmyhtkrWqJPH8n7vtn5yoJ7DWXjsgzxg0jbeaQA?=
 =?us-ascii?Q?XoIleQ9tDx4ReXyTaJbWmjinr6t+PSDpai1sMFZnmWm7YXcIVUjVEx/Tjdzw?=
 =?us-ascii?Q?x1T6Vu4/XRVHyaSGJNQ02YoNJejegdM6/G5eiKPQQ5ZYI5Kkfhr0ZMVZlhTh?=
 =?us-ascii?Q?ALFOFX2bVlHFzvWbLNTIFSjka5bjR4TKFWxnl0a2bRpRVF1i/k+2tzrF0BPe?=
 =?us-ascii?Q?+GZSr39pMuoEhzXOKi1fd3WGaxcN3HBw76eBY8oXZI8QUbcA7eKlNodGJ/0Q?=
 =?us-ascii?Q?CwHV2bp6YdTmyBmO0jvumW7gMX5A2iu5EIn1mrXHOG93i7m84U15+S+NSejs?=
 =?us-ascii?Q?P1OyYXAbLQDGLd6Gq2KtdZBdtZOJl3cpDpl5sIRANaIyBdq2efioY9gKBlCB?=
 =?us-ascii?Q?NwcAuv/a95YNsTd+oLoVGq3jKoSI5H0I5CaHXzjoTv7rce3ZsGQfUxIzCqWs?=
 =?us-ascii?Q?Jhy29EUjvVc85pgikm6pnQbQwtQomWGn5QPhRu/K7R+oQplbMT+udbt2MWWE?=
 =?us-ascii?Q?tQ9w92+aon2ovaGL9h+UTvfH1TI3jrG3KsAVS4rKbh/IeZIxZfyiON5jT+JU?=
 =?us-ascii?Q?T2SArTIPCzcZ9De8Z4BlwbBE14z8qRWZd5Av4EygnZinm1M3IaSnsIg36V2b?=
 =?us-ascii?Q?yO5k7px/rIBvsqVg2ovWcCC0nkhDcBGlk2VvPbnXXp19r8OjpVTAUOrdQzL3?=
 =?us-ascii?Q?IJZI94wbasfuVwxP0/ccbwGwXpNuqsTuJek8HAYVEozco87dsToRF7TSy9LK?=
 =?us-ascii?Q?7sWo3eogJhdBtsbRFLS4KVWy1XkkxlGFxDhL+vLInqHsE9u1vFE3XjChpkct?=
 =?us-ascii?Q?2VKD6bDNXChnTAHHJ+XUCrh9LhYu0LeMmHZcSVor9pggmwA6okCwy1Z5GD6R?=
 =?us-ascii?Q?SgxEeQxBPeEEi4GB6vo2s/E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19eb67f4-6645-480b-c6ed-08d9ae580029
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 08:05:23.4451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dh/47tCeCw6+zq1GkrW7jIyBt6P0p6xYylbBdX+piU/RlMKn1CMgUTotNnBjPBfWl/N1C6mU8VU3LkJvBrwAbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6971
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused "nvmem_macaddr_swap" property for FEC, there is no info in both
dt-binding and driver, so it's safe to remove it.

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index c2f3f118f82e..3de86e2e471c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1054,7 +1054,6 @@
 				fsl,num-rx-queues = <3>;
 				nvmem-cells = <&fec_mac_address>;
 				nvmem-cell-names = "mac-address";
-				nvmem_macaddr_swap;
 				fsl,stop-mode = <&gpr 0x10 3>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index da6c942fb7f9..8cc69b26cfed 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -948,7 +948,6 @@
 				fsl,num-rx-queues = <3>;
 				nvmem-cells = <&fec_mac_address>;
 				nvmem-cell-names = "mac-address";
-				nvmem_macaddr_swap;
 				fsl,stop-mode = <&gpr 0x10 3>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 04d259de5667..ec178c5fa99c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -832,7 +832,6 @@
 				nvmem-cells = <&eth_mac1>;
 				nvmem-cell-names = "mac-address";
 				fsl,stop-mode = <&gpr 0x10 3>;
-				nvmem_macaddr_swap;
 				status = "disabled";
 			};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 972766b67a15..cf3600b4fea6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1292,7 +1292,6 @@
 				fsl,num-rx-queues = <3>;
 				nvmem-cells = <&fec_mac_address>;
 				nvmem-cell-names = "mac-address";
-				nvmem_macaddr_swap;
 				fsl,stop-mode = <&iomuxc_gpr 0x10 3>;
 				status = "disabled";
 			};
-- 
2.17.1

