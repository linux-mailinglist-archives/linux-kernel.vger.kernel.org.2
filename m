Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40806403779
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348620AbhIHKEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:04:55 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:63650
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234142AbhIHKEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:04:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX8mCiqiXgG1ZISvRNXfkvEbM4y0n1/Umq+RIuaKzCx1xm3n3OGdWKKCPOF/zhdCBGtRrs1qzveAfhj/zYxSTXaC5BEkz486nEFa+p3vwwMr4i8K6+jRqbYSF2SlhRTJzROhD8+vPX2EI0McYWc5Q9BLWMfcr+D3yRWBGbf5Cqj3k56r3hNXOjPHapgniFzOvHAZ+5qJaMoyuopXcWsd5tB4b7upgBOz5EvjIcyHUAXiXbrk1ZgAGPOHE0uwwC/1lQK/FcfaSOdhx0zhUdaH6fcyIAcXqXDLDizQPSI1tdbNBvB12MyzzZWxOl2NpZJdomSqy5M2kSGS0ahIvXZ0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hWohYEeeaKnShD72NgqkDJiMeuhLSP+yvIlHI9fZeL8=;
 b=M11LWEyMhoMz0jeqGsY63vKsuYpuZIk3OlOgEy/x/EcVT5zND1QjGTyOVrdgqHTg/Dy3x011ThpBzTtvp8PsXZrfPPJLt9sUEalosLRWMai/OV4yMy4VRuowiA7E8ecTSA6pfDDs0NVCgmYZN/mlDyLfBhtiQIgsQrIlEta0ZvJ68XDGe7QO4A5fmsvLCHmN79Oif/tsbpsstWFjROoi+4Fjr67SKXv5/uZFpJgMgHerbrauSPthF8j3HkHdNhR4i9Q4nHS9JH6tZTXgRnLeyD/jIE+/5KJV7EMt0i7DXaUbo3lJKQ3C69x5u6DkFk+aZJTf9AMvSJZxBz/ot7EIeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWohYEeeaKnShD72NgqkDJiMeuhLSP+yvIlHI9fZeL8=;
 b=AtDvc5EA0Xa43lSYnVjsIg+4O3+j9say2bJ+A68eXNXf6JBfUBvvRdmf0QayCBFGh7995l1LKVelTvTIZzSnc0j/Y8rKhHXGQq8jYf2++i/DgoOSXTSwsjR0QhSGX1/tQ+4hQKz+/oHSws7KNACvUyzP3Q6+5WDIBERuL1r0sJ0=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0402MB2726.eurprd04.prod.outlook.com (2603:10a6:4:94::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 10:03:07 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 10:03:06 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] nvmem: add "cell-type" property to support mac-address
Date:   Wed,  8 Sep 2021 18:02:51 +0800
Message-Id: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0105.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::31) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0105.apcprd01.prod.exchangelabs.com (2603:1096:3:15::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 10:03:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74ec5538-19af-4a5c-f36c-08d972afdac3
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2726:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB272681B6800C1F315F093C1CE6D49@DB6PR0402MB2726.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0lygmInjR5pyIX7WhFRn+MXKf7uQD6RNLz+XbHIBxALGC71g9Am7bxMpwlWLg1jWakLwTaZNdmcL+T0vdelgGT/alBfRsyQ1sc5khZtbwtMc8tVTuc2ayBSKGeicI39sOcX6fzd25CPcb+QM8W4SzF+D5meMEEqpixsTRyWFXAl8bzwmzT0Ialr3zR+xtQtbKoJGJWU7gg/SY/I4aFUd+3n2rdGP0Nm9eH2sIol2eAcmgqdazKyEIjLFIAVGy/UleGKYLxS+TY+za2jV8DLjx7KbZ/w3iJMyIq5r3yjBIj7OmpfCGiZrWX2pqqOR7Brv3S66u+/sYFFWq6Dj5+TMBIRWLyiodbMXhuKYOh0RkguqQkY7t8oUkLiUmYE5Ci7JQ1mA9ox1qBWFXw02FQb3/O++30YrWoPyUOHE1U/oofLR2CWi6DTElnIupTaTY55w6UiAq7DOej6xZjPwEKl99fFi0X0cs9zlkXbkClsogJ1jX/X5VJ/31q+ZC0D9N4TrIpGhdzZxtgWWoyBmWk9W5QdFP9Xb9Aa/qfBwW5L48R2e3wMtBxGcV6gdcqkluij5tce/S3eVRLJr0TwAOhbl9nTarZIrXFIivoNf1fGJQxqFncNsHF5dKtUftKaQwfQh+4pqw541QOSB3BaUlzUQsJAEnsqmJBA/w7F0wa19YC2QPiTNu+j1lLX5PqXWGh3fCuYqFaAUktWyKFkuzq6S0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(2906002)(52116002)(86362001)(6666004)(8936002)(5660300002)(8676002)(478600001)(316002)(4326008)(38100700002)(83380400001)(1076003)(6512007)(956004)(2616005)(36756003)(6486002)(66476007)(66946007)(6506007)(66556008)(186003)(38350700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rQBwVCJ7OFxO4atti0L5YIdhqgi6qEg2qzYgU8e/SwmMfG6iDOvXHN0scGtz?=
 =?us-ascii?Q?dsyPPd4Xsm4LwZv2b+ugjnccSP4NsojKIMU6Ndn9g1FcGd8b1r42dymiMyNL?=
 =?us-ascii?Q?85ymsvweOx+GNQAsz8sn+jd7oHUkLRLNEY3a6wkxpRXZCWOfn/iO4WDvqbal?=
 =?us-ascii?Q?zpHk/oLazZ1UsXriVhVjXL/OqOxWB85IUpHkbCBAb5H9fUZ4lHQ52iK+v1SU?=
 =?us-ascii?Q?qCWNkJXKxADXUJ/FOA1IpuiJiQhmmXfQFc6XFbeH3oJ3wbbT3xAN6tHJ+RRT?=
 =?us-ascii?Q?MziqxZ+izh1zRvAGLUfTGhRWZNi9oOQx+7vEtGDxezL61lMO2geYL+aCndA9?=
 =?us-ascii?Q?Q8Pzqzr4wuxYNUbCcGJzUaent3te+Iyq3q4Szxqss2Uj6D0Bb0vNFv/dA056?=
 =?us-ascii?Q?pyJ6k/a6BP9O2y9oHw88w+a54ft5z2HpHnWYmwCrJ5nCfxsSN/i1vuC9Q4fK?=
 =?us-ascii?Q?0CYtAZJZ9zHktiSaRoC6YZI/AreS1WqPu/Oozrxoc/WDKy5ntGlspVRsESXs?=
 =?us-ascii?Q?wFwbMQavtKlQj7EIZCIWQ9DzOxuOOE4S0mLjx/CHVr+64m6ydZnBLTNQXciZ?=
 =?us-ascii?Q?ItDp3CRRwMx4C1iy3b6WgahQU0IVFRQs9CM5zQ965oNQFEnU+PmACGRUOLw2?=
 =?us-ascii?Q?k1++Hxs53EvM5hJ7GJv6SgPg1qM9xtmwMIeNDlGeFKBXZL+YlkdAwcIyV8cK?=
 =?us-ascii?Q?XX5Yr5hRgLR66cK7Qn8Zua0iPObW5adkbYltqiEbCO6qtbp35cbJkrzwgKcw?=
 =?us-ascii?Q?RkYYQ4dLu0CP0PmFkL4gEX74piyXcc7+unuJX6HKkzF3DIC5Twrck/05M2uD?=
 =?us-ascii?Q?MBFELwCP6HREAV/TazVKYRHcAuD6e7paoepKkoXy92XmqE5FqHZLL0f3+R7E?=
 =?us-ascii?Q?UdhIVKmA0zUyRZ9S/3lKr15oZ5CY9t6F9vt6heWE41/bgtEaqUiBW3UAtZQb?=
 =?us-ascii?Q?VMh+ORYYuk5ZN5dhJc/qM81Fkz1h0n6c8KevAWrCOyUfbLC2rl4827RwCAhN?=
 =?us-ascii?Q?VieCGiQUzld7SvEPwy6OCwJOtXqLcNSFsAX55T0N+J00fCoOe4f+cIFrttSh?=
 =?us-ascii?Q?DcNuHuNXA49GyPcEabQtaKiMRYyn7MJT4uPnHuwwPXRLKe89PCrBilPG3TvA?=
 =?us-ascii?Q?FBENH1X9RGH9dsZyGUum2pf6XltFip4Mgas4xthRcLCHn+9uYAdwYIw+IQwj?=
 =?us-ascii?Q?oqvaoDHH7fGIr1i+hFo5Ncb9oIj4lZfqavy/JYSKemCg0zncCxiIBbmytN5s?=
 =?us-ascii?Q?XpLKox7TUVQ4bGYI/YSJhejmIC8fQowbs7Ijh60+UFslctqPjinXaNfeaLjW?=
 =?us-ascii?Q?nORYgx4JMPo6dQpPkJHPGq3E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ec5538-19af-4a5c-f36c-08d972afdac3
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 10:03:06.8079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNiCg/gGLn7fA4fx3bjqA+OVpSkmvLoryCinprx6WU2LwXbgnoNZN+17uMu6QU7f6YS35Gje+qcBXc7pFkE4DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2726
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds "cell-type" property to parse mac address, take i.MX
as an example, which need reverse byte for mac address.

Joakim Zhang (2):
  arm64: dts: imx8mm: add "cell-type" property for mac-address
  arm64: dts: imx8m: remove unused "nvmem_macaddr_swap" property for FEC

Srinivas Kandagatla (4):
  dt-bindings: nvmem: add cell-type to nvmem cells
  nvmem: core: parse nvmem cell-type from device tree
  nvmem: core: add nvmem cell post processing callback
  nvmem: imx-ocotp: add support for post porcessing.

 .../devicetree/bindings/nvmem/nvmem.yaml      | 11 +++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  3 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  3 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 10 ++++++-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  3 +-
 drivers/nvmem/core.c                          | 12 ++++++++
 drivers/nvmem/imx-ocotp.c                     | 30 +++++++++++++++++++
 include/dt-bindings/nvmem/nvmem.h             |  8 +++++
 include/linux/nvmem-provider.h                |  5 ++++
 9 files changed, 81 insertions(+), 4 deletions(-)
 create mode 100644 include/dt-bindings/nvmem/nvmem.h

-- 
2.17.1

