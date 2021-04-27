Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BC836C0C6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbhD0I1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:27:39 -0400
Received: from mail-db8eur05on2089.outbound.protection.outlook.com ([40.107.20.89]:21985
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230325AbhD0I1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:27:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bT2dzHpu0CrTEXaI0367//rWnrfpxZ19WLP5csvFn8RhHf2kIjunjC97vxTYHtvHTseFJN19HKcCz7h81phGHzXOtK6lCCl50UTMnh74INZLleR/9qtNRc7TbW7yDJURM0llzsnj5zd8YeF/QKpXZarF13ZBLM56j8wtx64Sy6YRqYELTdsGIHabtXeDTu3VSZfVuTkE2e/nm5e1MTVtD0nbecjfO/dCWcaHn1J5Dqo7rU96g4ia9yZ1Tgp/xJeWHbDEMkAW1YkrAZCzjk9yAeMHSoLRj/gnYI7fyQ94h5Seg+5/TeW9S+Ao9tbm8CHoB59ubkLMM1QROWhBMVqzrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlCclEezubNv5Kq575f5HX52LhamHBQmQlflpVtnMwE=;
 b=Z8l2ZcWdHcd1Ifms0HZO+BUQezxN4OotPiYMtMp/3YJFDIZUfrc4tkaiJX+SB6d/UryacLhRstjcVYpIl4ygyFvgUPX+H+QdpizGMb81bRYh6ozZeSm3WRCcfeJwSZ5mlHd2/QNFgZIfqvHgPxVybu2bDQrWpzGOAXtja3STh4rIlUHV4ncRBzxh9dzQBVENoKPna3SKmdOBdQiPy8mKrUE1e9NRwTDc/BUmq4qGI4M/nfS+w8CXInFbnkM6CdHT5TEERXrYC2FGkRQPwAsat1n2r1wPv9gpfanNi5rgZ1oZCNAZ5yADL8PrNsQBkP0PK8OoC7fOM/40HhH2SayrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlCclEezubNv5Kq575f5HX52LhamHBQmQlflpVtnMwE=;
 b=hLemokCJiWjbUTNGUULp5nNsfWfeIamhQy6tX3Typ4xSeDZEZRxiMQ8GG54eA2vmD4CnHnA9kQ5ik0qCMlk22+UeVnUkmkr2F5fg7TsjzXIRugx1cX8fVoP5ZmsYFdDHH9cqqzbYMHsQVgn1HzJIl+lKSMPwGZkrGU82i+6jp/XcwEeqCfF7yXggJZOh7qDQlNLltvM7IRQ857raGRwwg2TzV3xiF+URMjoOx93k1IkJsy6Y1GGO+PK6apnowAa8O4OPJCfN1D8BjvPQ2PVUEMlKm5+21+0DhoZmrYCbEpOstXx1LP8w+or5O5neIse/1vFNwxTlymSFFDo26+JMZQ==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0601MB2315.eurprd06.prod.outlook.com (2603:10a6:3:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Tue, 27 Apr
 2021 08:26:52 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d%5]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 08:26:51 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>
Subject: [PATCH 1/4] dt-bindings: nvmem: Add bootcount-nvmem
Date:   Tue, 27 Apr 2021 11:26:31 +0300
Message-Id: <942aacf1c51861e5a09db6a6d322666709695df2.1619511801.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619511801.git.nandor.han@vaisala.com>
References: <cover.1619511801.git.nandor.han@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [37.136.150.171]
X-ClientProxiedBy: HE1PR05CA0162.eurprd05.prod.outlook.com
 (2603:10a6:7:28::49) To HE1PR0602MB3449.eurprd06.prod.outlook.com
 (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.vaisala.com (37.136.150.171) by HE1PR05CA0162.eurprd05.prod.outlook.com (2603:10a6:7:28::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend Transport; Tue, 27 Apr 2021 08:26:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 297db6f1-8666-403b-7d4d-08d90956353a
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2315:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0601MB23159641F3A43524DB72B23385419@HE1PR0601MB2315.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0ldrd6tas4NFcedlfV0PTM6766ps9mRa8dIu5gKxRv/qZRXzgdU5iZe0AiT3oOX9euNBvPH0E1y+EKrO6F706OPEpBScfI8i7Mxf0MOblS4mDU3jQhy+xCkyi/NhOW1AVv3JkcOdVhuJRH2PEcilOgMYV31DxLo5bQV4sNftu6NwmHXvH4uS6rePWbGtitOYoH7ndTo+1yDej1jL0v+nSMvBQBSJL4iibQZKH3IQyF+qQwTG85S6/XyGacr7IKM8pOoimMHetnsCOVJuOt5ZuIQZpzrLB5C0FpBGGXyfdT3KilgAnhA0TfODAjAgcQ1bHCSbolLV1hTeD6hl81qHlWVp26QH9IQdSdAbd2gHuu6AOi+HnOuT+Mm28MNxkao7TZJpau9Z8c7LjVMx3pGURwq1J9TjiLgQYGodSzPqEOabSeI0/UffgPJbigL2IVnB1BIvEY7BuhFsaM3eMgABO132rMdwTAeUqIxYs+enveFj/yl/XsPSsIkXDRO3VHYybrO8uGcgp4W7j0/HNFJ6Ff6Lc/JkBXHvwbTba7UVwykiwMmY0Rdwqk88VFQJW2ERZcl4GInijlVfHdGlt9GFj0Bpw0CwPFqoIZYtiNN8OssrnNtBXMMslKt8YMLJBf3oIky5ftp+FZ4WV6597KoEmDO25ghHPugsTzLc1FqZ10O+P8TBMbHC/W6f00q+ZazBmoK+nwcOWZdw/ChWQsBJB0oBM8w/DzYPNlr1JlklXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(39850400004)(346002)(136003)(966005)(66556008)(66476007)(5660300002)(44832011)(478600001)(26005)(6486002)(107886003)(16526019)(186003)(6666004)(2616005)(316002)(36756003)(956004)(2906002)(4326008)(38350700002)(38100700002)(8676002)(8936002)(52116002)(66946007)(86362001)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?O8ebeaJkYs1PcKqXkavKt8n48ax8XUqU6uVKW/97fitGk+BbMA6jnknbuyct?=
 =?us-ascii?Q?qPjqQCmoMxDKOgQie0BTDoDsxzOSWof3AYlPB6vyNEzsewMWYWiR5hHy+Xal?=
 =?us-ascii?Q?WP7CJoyVty1AE+L7Sedh1OORQ31r7IaB7hC5VCxz0VXOekjVvRb1FHlKiirc?=
 =?us-ascii?Q?3oekdPg3I5uy/Iropo9yFQz0Jf9ny3sWLlS/bkG8RyJcAh5OIrQhJ+rdxo0C?=
 =?us-ascii?Q?AlKdCDl3XtmzbSUwaevXIVMZM7vk5HfRRJ7DJuvGvFXOmE92LiyexyKfmsCZ?=
 =?us-ascii?Q?7pFnuubtl6iB3JXGR0Scn+hG3IpIWkIcPpza70OmEGeDrMC9+jNDsonRHAUS?=
 =?us-ascii?Q?jkd68hqiHdRAmR7/AwLrXK5zDZQkkzkILCu16CyLXWe6Nx4k65v027/Std5g?=
 =?us-ascii?Q?4VMnUEgUudfmNYSnrX4S1KQnkMemns3W4WPVMRmGX+37In7/l8JZXe9msB2s?=
 =?us-ascii?Q?BUom7xIWOmGx9RXjKyqNARNVkRJju+4gIhifBZGSS43A5CaJhqLPIQ1ugOSU?=
 =?us-ascii?Q?h8maCx4eiYaGOKLRaOr1ihsT5G+mCXOxTuEZZoY1G34hDve3eCDxri75N65P?=
 =?us-ascii?Q?0SHgzy/jseFJilSiiNaBFbPVPNpA3T1dkwV80rXcFs6HilJCoJ6JIQmcGTao?=
 =?us-ascii?Q?VzuzZYV9YJTCPxoZNTgjJHXWg/qeGPwjsPlqJTkj88rFGQOw/MRLkw183Rk/?=
 =?us-ascii?Q?kJtLUcLmkUisvgsw3LTAmqycFPQhCfeoYBoFuc+mtiE3X4eWBSLHvus8ypY6?=
 =?us-ascii?Q?yuVkM18+MxXxLfEWxwMlX9AxaAD6I8npoA8V9spX04IKA0jI1i4gt9zr/Ibs?=
 =?us-ascii?Q?jYXR5hKfeqAb7d5Z8o+EMs0cdD5QVwqX7ijWRF9frJ82TkV9OnKJhfJ91SWt?=
 =?us-ascii?Q?osQ7YkVR1OUGI4l5FaLlt3CaosI9P+QJ7dZQf18u14XTN4gQYQ0JwUN5ap8m?=
 =?us-ascii?Q?qcIEfjhM+y+TBur59ygfLkGZzeKyMa6p/l7X5C9uo6IIgF+Oy1htY4CyQgqo?=
 =?us-ascii?Q?1eZkC7JnBQZ9yFThNEuGuc4Cb/BESRT30oLzjhPn7h6RzXA28+P+XthntCvj?=
 =?us-ascii?Q?87WFL8siXSV8SmJe0f3DNgJ2Lb0ZHx5BSSvJOLIo17jYT8V1zssGq7wqGDNn?=
 =?us-ascii?Q?PUphCRrMCMPzdzbO2jEj1vlGZf9LgvEunNwe9GaSyGqxmeEod04edJcwTkgs?=
 =?us-ascii?Q?Z++lcVcTZYrvD0BU/n32DDBuY0ezOLTSmKlIix3I9J0LG4ZHEhYClgtwDdzn?=
 =?us-ascii?Q?nA29i9INRiJBTXnqZoxwLg/cau6ZjUZk3nQdDFA5xdirv1lUY1xoKWrfkpHj?=
 =?us-ascii?Q?+uQG2Vc3LCqv5DxEdhmXmLFX?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297db6f1-8666-403b-7d4d-08d90956353a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 08:26:51.6297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hOF4570fXSq98ABqPN4eEaAIluo0e7ALmnu66Os28TXQNMq7bzpTC43AppsdfFPgSgcEWf9NIvHtyNsSV7gbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2315
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documents the device tree bindings for `bootcount-nvmem` driver.

Signed-off-by: Nandor Han <nandor.han@vaisala.com>
---
 .../bindings/nvmem/bootcount-nvmem.yaml       | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
new file mode 100644
index 000000000000..adbcb2db93a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright (c) Vaisala Oyj. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/bootcount-nvmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bootcount NVMEM bindings
+
+maintainers:
+  - Nandor Han <nandor.han@vaisala.com>
+
+description: |
+  This binding is intendent to describe the hardware location for
+  storing the bootcount value and magic combo.
+
+  The NVMEM cell size should be 2 or 4 bytes.
+
+properties:
+  compatible:
+    enum:
+      - linux,bootcount-nvmem
+
+  nvmem-cells:
+    description: Phandle to reboot mode nvmem data cell.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  nvmem-cell-names:
+    description: Name of the NVMEM cell.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - bootcount-regs
+
+  linux,bootcount-magic:
+    description: Override default mask value.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  # example with 16 bit nvram cell:
+  - |
+    bootcount {
+      compatible = "linux,bootcount-nvmem";
+      nvmem-cells = <&bootcount_regs>;
+      nvmem-cell-names = "bootcount-regs";
+    };
+
+    rtc@68 {
+      bootcount_regs: bootcount_nvmem_regs@e {
+      reg = <0x0e 0x2>;
+    };
+
+  # example with 32 bit nvram cell:
+  - |
+    bootcount {
+      compatible = "linux,bootcount-nvmem";
+      nvmem-cells = <&bootcount_regs>;
+      nvmem-cell-names = "bootcount-regs";
+    };
+
+    rtc@68 {
+      bootcount_regs: bootcount_nvmem_regs@e {
+      reg = <0x0e 0x4>;
+    };
+
+...
-- 
2.26.3

