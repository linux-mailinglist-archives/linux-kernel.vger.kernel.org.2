Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FCD3E5459
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhHJHfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:35:53 -0400
Received: from mail-eopbgr30046.outbound.protection.outlook.com ([40.107.3.46]:49280
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234153AbhHJHfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:35:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu35dRCpil+mazvvLAfW+4jpijIRJsXf4suVVG3AAFxRtckba61gjowoJGEyHYWA7RpeUFDEZkj0T9vwFivPiQtoiDHSTd8PRBlP8OaCdKUJOv9DBWZpKE3C/dHnd+Xx9jO7/ffUV5JeOEJn9Qhbo7cJFtOz7m6lWwKoz5209WBupeOcmm1tWOrvqFaUSXQ4ThzjvXeEedCL2jbjYu48Ijw1Bs2zx5GxtsZ/v6kA7o2XPcgWhWGDfYkliZKU4qddlZmpUyWMSJKBHoXh31qnLytpuAPnpzQ18gTiEgz0v6FpaovCXPgj/UigTamWlk3eUXuz2AQHKaTNcUoXf3emwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBDsOZ99JXA++clGy6YFpV4eXxdPgG7oeV8R0KKFx0Q=;
 b=ectRVH7uRbfI6RvsiAp+glSJxEfRL5IbGyotma5QLXuJ5L+i10E505pA5xV7o6swdgrVQKI1G3rIOJQ8ZuWC60boogOHpzDCY1/MzDLK9HZIelFpTgynDDdzEDtI5kFwW1FS8dQiTfHa8sZuwlwezxkZ5LAz5ua0TNdDLslCL+4RUG0LrXXt7f9KkZrxpbfx44YB+WC/HqJCGB6zKEdjhdcQLfxFReci7if5j4EkZUz45fUlmextDV5WBQNsUaJHS4YUNBoGc5eSqaxjW3dqu74L0+VIBk7E6q6b1Czl0AqhuUMKfENO+8i9VoQuHqnd0oRgJHZfFe6U7jF5ywANYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBDsOZ99JXA++clGy6YFpV4eXxdPgG7oeV8R0KKFx0Q=;
 b=PVM93M5LrSCA5otmqEWOp+sUYR8C3k3P8ClgpaGbYwCl8E4dr4p9b1UhVpvQwhkKJ8KGBdzy7Ne1FbUJwMDq8/tXeojNo+eAaZkPMrpb51aGfgWRx5QjtFfHnYfaPnxU709d8xmtpzWqIs7Os54NcA36SPyNN5WwVZ71EfdxRqM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB6793.eurprd04.prod.outlook.com (2603:10a6:10:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Tue, 10 Aug
 2021 07:35:22 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6969:eadc:6001:c0d]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6969:eadc:6001:c0d%6]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 07:35:22 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 0/4] nvmem: introduce "reverse-data" property
Date:   Tue, 10 Aug 2021 15:35:06 +0800
Message-Id: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:4:7c::26) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR03CA0098.apcprd03.prod.outlook.com (2603:1096:4:7c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Tue, 10 Aug 2021 07:35:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a36be38f-ceef-498a-fc62-08d95bd168e0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6793:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6793D1ADB84157BED8160671E6F79@DB8PR04MB6793.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qw2N364onawivhn0m7wnRNHngd3bgTAcSGe6dO5NQQXU6osMhWsQqSO1DxjYdnffSlZSF6q/z2lduNenLanY1UlXGdgBOYJj4mYw8+rgjqGwRxf/5WdHZGXihGyZ8dxJVyeHrOjuWtYMD4AmkCXJDtMy0wZOm1xiSujPfyFpGP8cxvgGMdXXjzS1ynZzK/yQpaU660x5YdaKlYAKWWavx59QL8Eh1klIMvkKlOc4n+kusnQuRkMf/PbZsYSIJFnnUQpVYxJqfabWU12Mb26aSUUbIXQtnx3+eh45DLNrd/rDImGxSFAYe9C81WZL7CwYmpYwSyvRd7OO2TdEDsi/z/SxjJAOz4dovTjZH1iJD9i7eQHQib5XGVr7dcbsU2rr0PA8d4Q8M7ct0kzPsZgz0a4cwTMwmBXciEKZHWcZ1szSi0u8u0SJm7BNfnTWxDZd3bYiAZvwYDmfpeZpeG0wd7GYqBKXf6JIXBEjwobtH0NwNgRlQ9UwZc+gKjJDBjpT1vxbQbvEIhDSeyZu23hvIXFaQiFq0O4sGcUrxhUV1Km7kjURRnriRnxtSaL4i9GLS8Axg1Zq5DTlBfNd3m8TJRluDvdOkQ1Su+AZhTvVnCAPNnlzKWbdcy4CMje5iREjhIU04VL2bxfvbGEq0PzTZ9aiBKD7+GJT9L2v7qWj3E4Egug+Gtr/9l5qbKHLld0MdJxb/TipcCUUKL1YptBFght1u2sFCAfnpAplxU7RdRnFwD7UEzGHH6CfRM45j1dXA806YmUvzB+aec4kzFaDSUP37wzfLLXT2b6hhfD7uIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39850400004)(376002)(346002)(2906002)(26005)(66556008)(8936002)(86362001)(66946007)(38350700002)(38100700002)(66476007)(8676002)(6666004)(4744005)(6506007)(1076003)(966005)(186003)(316002)(5660300002)(83380400001)(36756003)(2616005)(956004)(52116002)(4326008)(6512007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ANuqYWAJ9S5xtqhF0KxxMtHNXIUeYR+fBDUsYjfx2FFIL9suWhdhROF6Ig1m?=
 =?us-ascii?Q?/IAVBonTVpPWVChNgwp6xxOXfWHFwqkqgf0Iauc0wBL76EihrBfb+OkvXH2i?=
 =?us-ascii?Q?QnqhrupAb4LlptkCORrOPzB42B5+UTWOXhAseIHAz7xw/YTplrwHocOZLnPC?=
 =?us-ascii?Q?VlmogWVHTwFG3UxAKmhGHc8kPcRyQrn3SCjZEJTDXlUrCVgl44sNys1hNdTR?=
 =?us-ascii?Q?wQKL9X9KqygUhm+H0oqiFV1mV+5vZoVR3yLSlWsUEWQ+84DCJME4gH6v5X8O?=
 =?us-ascii?Q?cqMDA3YHyY2Nx/21IAOSMk1tjMFYvwugztvF7fYZ+3RgcdGjzGGjMNx6a50A?=
 =?us-ascii?Q?96yCadKYE+gyMizWv1S1/ibu48CpFm9Ne7gpctQ9tntOQhUXL65rIOjgdrSR?=
 =?us-ascii?Q?Kw1OncQhpJhrHNTMo1/5wN70waTzFQ3bVofj8NgslibZlORzuuCZcz0YpG2p?=
 =?us-ascii?Q?qHHxOxFkc0prO6ppDe4zBd7Mk8xpUtjB02s8fWKcByNktRo55plikKCz5JDU?=
 =?us-ascii?Q?OpRzV3Nfp5VKaNgPXwEHC+uFzZFUEsuUDfIDwEYlix3MRN9dSMBtVusRERvh?=
 =?us-ascii?Q?Qy9LEK1F1RPQ7kVzb1ssV9A1/34/BYgvb8yAGM29tmfi5+CKRhkpSDA8g+/K?=
 =?us-ascii?Q?JAxMm2nFp7VVpsXwzOa0K6T4YyAt1ujnP+910AVOyEFnQDzMGyld5EVxFNry?=
 =?us-ascii?Q?Ta7UxgLh0QFIyBjPL8r6LRbEMYLwui2DRhfL1rpEU6AS4vuEE5dGW3KviAp7?=
 =?us-ascii?Q?Zs734BcmLAOP7LF2A5j0E0ioFHVjAT57hW72Z4uWnLCUfFo19gOpS9xGglGT?=
 =?us-ascii?Q?6CB0i+qfnLI+2LZsOTDfkRB202W5hoTjE7GN3UC02TokOYdapPctc/kw5cAY?=
 =?us-ascii?Q?24PZhHcZEodFtwc5RCzD3qEaF+W8dMeKdFiL0+0qfMal028TYW5QlvNAYkBA?=
 =?us-ascii?Q?MNg48XHRarhwOI3cMUHqjd3JXqCsqINWFT/RQPEU9xRxfyE1NhGP7HPihaGc?=
 =?us-ascii?Q?9pKNaUajQhkwFlx0KN7T5BeEzMfscI6wrV04vVl9+2r4yeVztnwXdO8f/Lws?=
 =?us-ascii?Q?u05GepW5AdfKfnRURM3qDY/LYdq0edLchbaHLN9CmcCSVv22eq4j+tEK5ttP?=
 =?us-ascii?Q?cq6Zfsp6vtL0bYtCWkM3rAH6ML357vzXmT9imxBmQyLFq01/4VZjyrUHan7+?=
 =?us-ascii?Q?sGI/Bf6LYn9+eukKTWDI1X2tdjKa3kUvWsom1YJvwm6h089tet02akFw4lpz?=
 =?us-ascii?Q?o5f/6UGiAEfOYbe4UedqD76Q6rcH9kHb9+rOUg8nRy2Pf1uDrj6ZE9xje4Ir?=
 =?us-ascii?Q?T+JyqMKE3IC7mhsek44t0/N3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36be38f-ceef-498a-fc62-08d95bd168e0
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 07:35:21.9406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSCZAEAkOY9+QerAnyYdJaLyYb2xXaHxTU9etxz3QuKJB5LI6dg6pWEyE2TA5Qc0yeuNUsz4uDf4uzm1Ysw1dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6793
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds "reverse-data" property at nvmem provider to reverse
buffer if nvmem consumer needed.

Please refer to [1] which reverse data at consumer side, but already
rejected by Rob Herring.

[1] https://lkml.org/lkml/2021/4/9/352

Joakim Zhang (4):
  bindings: nvmem: introduce "reverse-data" property
  nvmem: core: introduce "reverse-data" property to reverse buffer
  arm64: dts: imx8m: add "reverse-data" property for MAC ocopt
  arm64: dts: imx8m: remove unused "nvmem_macaddr_swap" property for FEC

 .../devicetree/bindings/nvmem/nvmem.yaml      |  5 ++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  2 +-
 drivers/nvmem/core.c                          | 30 +++++++++++++++++++
 include/linux/nvmem-provider.h                |  2 ++
 7 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.17.1

