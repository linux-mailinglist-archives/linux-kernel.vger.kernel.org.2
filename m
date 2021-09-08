Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD02B40377A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348859AbhIHKFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:05:00 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:63650
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244283AbhIHKEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:04:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilz0f+qHzKrQKjSNWVjLn3s4mpHP3J1DMmq/bRqcaRWopgUhSSrLVGPLENIlzfSf/ttbrU41EQF8BOB+jRuZhbflkFojRN/kr7jujMzD8CarMbrec9l7+FU8mFw37cYFJlEdbnHWPhKPU7KOsCwkbGRQVNyakDaH86pUlD00qjh1vGuFSPeNDmnjEKgSsCSSpYg7PJWIjjjjWgtGiTCb/vUuBxxq0sK1cgObdvdXYuemUBw2P58HerFcIjaN1tRs3yKIkLH/I2ldeleTr1cAZuPyPztHJLJ7Ez/emE8EOrYG0dpjSjYL1e+LVjoN6HggJD+u3DFas/m+CuHV8h448g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gGed3XtF7ZstaxT41kwc7HAW9psN9+JQ6PZrwDGc6iY=;
 b=AyLyHSFU7JdQNBZ6WjKoxMKXTmmBZcAG4Da0ri+va4bfFVLCgI5v1vixOoUSrAL6QSNDXZQr9QFwn78I1p35jXKIe95KyObYID3Mmf1ucvSTL9maLavlTl7Trhj/qHRgKQJ/IFZqHtXF5AtUcK0ctOdpAu9lLJfFDkFkpN+QKvE1lGhRcuT5r8d3DW6bpnFpJjuv1MQ8wBTif5R8cvzgD7CoKFNwEc5RZCEM32A5jcRIOfnxBzeOGn4aBYrR2MMqJWKaCImrVzfvuQ7RurzU3uuiz+QcIvqgXerX4VQFgbpxttAfMbJj5F12FGnULRu9t0XBsAYLTkydlOB7qc3Y5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGed3XtF7ZstaxT41kwc7HAW9psN9+JQ6PZrwDGc6iY=;
 b=ULrWL+QxA4m84T+d9pKlpmQRoPAR0ThRqxOqGIskcPYoCqqDMVq7PY82SSpvwxx4mpjMpz78F16Kz1Uvd/azPu4add22BL9gYhYpS+FpA5aHGvDGR6xcM6GJG37S7sej+q6/aubbaKGRz5+lA+aDUkhK6sJBGwrqA9pqHo3MCSY=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0402MB2726.eurprd04.prod.outlook.com (2603:10a6:4:94::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 10:03:09 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 10:03:09 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: nvmem: add cell-type to nvmem cells
Date:   Wed,  8 Sep 2021 18:02:52 +0800
Message-Id: <20210908100257.17833-2-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0105.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::31) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0105.apcprd01.prod.exchangelabs.com (2603:1096:3:15::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 10:03:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dddb7b2e-2442-4daf-3d71-08d972afdc7a
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2726:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB27263C97ED068D6CB7650CC3E6D49@DB6PR0402MB2726.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3SReSV393aY5whzCsqEAcGDllDjQCaeE7X+qdkCsDxcXUXs0s/HLfD70tjrqqwV4uPAWeYpOYSvJeUXakf2vlbGs72Il4TjIl0TU2LmOnIAcE4Av1P5RXJ8O5Vc+Up+o4Zn0JAfs/v52DGlYxyWgVLpb2mdHR4BwM3bEkKFJJsg440cQnTiGE4/sprGNsXeduzWtbeVJEsTfpVusbOirjaRHBS/U1j9Aale2yNyD3NPhn5Iyx/rS5y2tqqUChO5yntaV/szTo04zo/WvXGJ8O5Fm6b2M97wiIdXzlMGEmHWwf+2zliXftvbgKaD4k5B+8FCfT5C8vwmg4nN/6/hhs0OKE4y4r5RBcdzdYZ9jiJSz6xgFTaAl12yRcbviEs3w1ump4Ehu3aI477cpnGgABEa/3x38fuSPSMkMuU83NXJaWvg+Nwmnx90eCORWPSxJbCY7K/FsZjpynj+PgFslLD473/UZxH0l8r0Tx4kUiMLZsfabuho0RrfGfe0IRbCdhA7LaGquXlWVnyjjsHPit2q+Hk42N6UpD1hBxgWvmJkZroG1P9gwnUQD+o62Rt69yL/LrYU1li/+XLWJtCZ7yJpMYgzjN3SNlZhnXEWdt8Xlq0/iu/otTd54z3G+V2cBugvc2HTqrMW/mFLHgA+4cjke7ATtfx5G8vOIsBuklO77Msw0QRPnujTqFdaF8T9FbfKz76ISCqulP+Ax6+jQkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(2906002)(52116002)(86362001)(6666004)(8936002)(5660300002)(8676002)(478600001)(316002)(4326008)(38100700002)(83380400001)(1076003)(6512007)(956004)(2616005)(36756003)(6486002)(66476007)(66946007)(6506007)(66556008)(186003)(38350700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DLfsEKK3FJf/8LCMBcmKp2fCz7bufHJuRNTaqINAVnVKku0OmEIoi8R8K5vt?=
 =?us-ascii?Q?Gw4L68ylTE6cwoWS/QdojriEkn+kRYWEArd5w9aXzmjTqTAV6JWD3YtGO2Er?=
 =?us-ascii?Q?Myq6o87oWis9jniSixvdu3LiLQ+sp6UXcKpilI+A6XDFnaA+V4AueJrTp3uY?=
 =?us-ascii?Q?WAofNXVU5r+b3siO3HqDUAaHM/hM+yAj4GsMkPl8KpPm87KwNf41KsiknK2G?=
 =?us-ascii?Q?zTYeUx0dRnOLPOkHHY3zQJaEwmYpxhVnMn9awg+ljY/CnF5ADBuKSNkhH1a2?=
 =?us-ascii?Q?lhtMiEsMmiWhr7jyA/+oqHykbS++03YJHvWF12njvsJepemZgTSjZ86xYpby?=
 =?us-ascii?Q?0vqrVyPLrIS0O4BQUE+SVJByvW9fQj7dp+lYRxM0jDcCRmrExTF5DbLwETHi?=
 =?us-ascii?Q?9iYjOS8YOEWMamblBc9adMuGKO/PsOQQilRVzZLylZNrJZSIy5Q6ofzt5UUP?=
 =?us-ascii?Q?Pg7kgh4xQnAz4/0DfqgNUbQW+Bx1gT7gL3vxJH2Hrz24Qqcv5BFFMH6pWlO+?=
 =?us-ascii?Q?Lxekmg1R4as/KikI9/O3oYIku2TMVKnhHhpYsgRqwC2z4vKuemIU1gKMoHrI?=
 =?us-ascii?Q?p5vgxNAx/ujDPu3N5kBcNNiKV7vsvBASJZWyHdVm499CfmjVxrDy+p2rMhac?=
 =?us-ascii?Q?TdcHidoNhxTWPuGIDTa/qvy+OLYbHmhsrei5ShLbbSJ4fapIfdsQmjU2rRI5?=
 =?us-ascii?Q?I/e3apsrzJM7FXrVJudfe9jHzZFyc/2NTp1zytfV9ihvr/Uip9hMDuvKaZYH?=
 =?us-ascii?Q?XjsWAM5HwDeCLoqc2MfDc7AF1vNEbr9RnwN9V1iEbgIwbhniBX5wUxqAEljU?=
 =?us-ascii?Q?4QB+wqhCrW6Q8itnRPAXZWFY9UVCj4OKKg3HIF/q0rDAFNl32hBGP5UURFp2?=
 =?us-ascii?Q?dvYSHC/2bsfFOtfk2vqK2Hz0KRJh3mmcQn0NrsOgSATztietHBmaf+HKLuPw?=
 =?us-ascii?Q?vzPerP+uhIcBYD8NjAHvxHFoYqJlzUZLU2SwjVrCLJTQrKjADGhpAlcWsZXC?=
 =?us-ascii?Q?xPIQOxstaRJYq9YEDdNRxxHC/PZDEHSDy214BllnPvkYS00HohcDPmp3dfaH?=
 =?us-ascii?Q?RCXzz/2+eKcjirSrAkuVY8anik4+6o5aY14qbAupfRx0dpNsSLaY5nzCGqQv?=
 =?us-ascii?Q?et8mmWXGIS2S2BH0yk9HR6YYuB6rm9XOEZaB+jd+FNpnBlk6a23zbukp98J0?=
 =?us-ascii?Q?usTWnCLZ//ofGpb3O4QkO1jK8HrVCd9pnfTJNzGGI0Bn9gZZX9RviENIYxOf?=
 =?us-ascii?Q?smFHr4P9zSrAdkDvQbAfoC6YppCpgD2ETKC/dD/LJvpapuTZIBkpQmPpXrHU?=
 =?us-ascii?Q?43jqtmFdi8jA4zsMfR0FSOGC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dddb7b2e-2442-4daf-3d71-08d972afdc7a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 10:03:09.4891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86NOh04YHHGlWMzddX8A36fBhCBndW2bWhBYAztNFCXLXukVanBgzA4JyH//gQIWKtrbxQ07uG/uex5fw0TJDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2726
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Some of the nvmem providers encode data for certain type of nvmem cell,
example mac-address is stored in ascii or with delimiter or in reverse order.

This is much specific to vendor, so having a cell-type would allow nvmem
provider drivers to post-process this before using it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 11 +++++++++++
 include/dt-bindings/nvmem/nvmem.h                  |  8 ++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 include/dt-bindings/nvmem/nvmem.h

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index b8dc3d2b6e92..8cf6c7e72b0a 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -60,6 +60,11 @@ patternProperties:
             - minimum: 1
               description:
                 Size in bit within the address range specified by reg.
+      cell-type:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maxItems: 1
+        description:
+          Type of nvmem, Use defines in dt-bindings/nvmem/nvmem.h.
 
     required:
       - reg
@@ -69,6 +74,7 @@ additionalProperties: true
 examples:
   - |
       #include <dt-bindings/gpio/gpio.h>
+      #include <dt-bindings/nvmem/nvmem.h>
 
       qfprom: eeprom@700000 {
           #address-cells = <1>;
@@ -98,6 +104,11 @@ examples:
               reg = <0xc 0x1>;
               bits = <2 3>;
           };
+
+          mac_addr: mac-addr@90{
+              reg = <0x90 0x6>;
+              cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
+          };
       };
 
 ...
diff --git a/include/dt-bindings/nvmem/nvmem.h b/include/dt-bindings/nvmem/nvmem.h
new file mode 100644
index 000000000000..eed0478f6bfd
--- /dev/null
+++ b/include/dt-bindings/nvmem/nvmem.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_NVMMEM_H
+#define __DT_NVMMEM_H
+
+#define NVMEM_CELL_TYPE_UNKNOWN		0
+#define NVMEM_CELL_TYPE_MAC_ADDRESS	1
+
+#endif /* __DT_NVMMEM_H */
-- 
2.17.1

