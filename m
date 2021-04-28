Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA80036D8E0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 15:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbhD1Nvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 09:51:40 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:34482
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235096AbhD1Nvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:51:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju5y6SwFnVuOJ0Mg4DftNS4XyH6+JC11RuaD0q36lAQnLKlZNyChf4GKx4/YwWj0L0QL0OVz8RdfKktNXe3S99j4KLkCFPHr87FW8JOCOybNS66Cxw2kqmkV/D3MB6C4i7mlGqAl53U/onFFvW5Zr+btdHFsDhZoGyaVkoqGPv0FuDBlNDUtQgMKIu4EGHpJY7Wyd5ODCmLgRu5TK5pi1yeho9fM0VyLvLxsBObUU2TtN6xju+p8JG/mZTB01+/IWL+CzNsxDQsst4u0pnmQx0KaFwcEjJxxCCxliEivH2IAkiQv3gmOWQc43W+y+O4z5uTF2apBO+GUmw2DIBHsrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV7QI55NATf9Qurv7uuoXWsktldXYo67+eIWtguw+fg=;
 b=hNPHnVASHks6Wv4Ake5PCtyrVmBKBNBwgnVs+o1tDnZic7qrNNHiV9veBO+v8uoe2V58UNHpxFblc3Dq8p7F9q2OCRGoApsNm0kxXsazyP9DPglduTIKAEvzwETcMbNRTViH3dX6bYk84q1MpMdpMaexNXJ86dNNT7gZcsQj7Y93hJvSdZ1NdhPK8o+hxLCik+OpvtwvWlhIgoZjwpq63iTLR46SynndJ7sWZaG5s503DhKPtiO376THHOW1hGhiC+viL8Ohs025JskbuW07vbMCcb1XHyQiWSvxvDOFr+blsDnr/fbfpgdJHTNomvYVdBjItgJXp8uViuz6JqmmkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV7QI55NATf9Qurv7uuoXWsktldXYo67+eIWtguw+fg=;
 b=MGVHjd/tyWlqsgrE/855motsUWGy+Tr2nMkALe1bk5xAxApTk/K75cv5dNwOWwuIXQrgC11GSKh1M4BioQFDbfbV5xWqWzdK0iTg4IJTq4ANgJNjBT9kbgzLrsFn6UEri4ZQoIB6mMs6TJETZ8Q4Xy+3gMXLe0mbLaSTrRY/ykfl9nMRBoHfekIlWTl+DFfc21nP+kLmFcfj8LBaiVvqOkXlhh6Lvb1IdR+NPoXvU6v6kY28QIN/2WNo2v+O9j4nPw1MnJQsKK6E/wkD57ePMzqJSxiVPjiG0suCW8Fuks33yhPYQJzAOWKRwGYQdjqJe0teCAU99bOTX2Ox4stZRw==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0601MB2361.eurprd06.prod.outlook.com (2603:10a6:3:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Wed, 28 Apr
 2021 13:50:50 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d%5]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 13:50:50 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>
Subject: [PATCH v2 1/4] dt-bindings: nvmem: Add bootcount-nvmem
Date:   Wed, 28 Apr 2021 16:50:38 +0300
Message-Id: <e0f9c2629ad651817a4726cd4f2d8e1775201595.1619617498.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619617498.git.nandor.han@vaisala.com>
References: <cover.1619617498.git.nandor.han@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [37.136.150.171]
X-ClientProxiedBy: HE1PR0701CA0067.eurprd07.prod.outlook.com
 (2603:10a6:3:64::11) To HE1PR0602MB3449.eurprd06.prod.outlook.com
 (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.vaisala.com (37.136.150.171) by HE1PR0701CA0067.eurprd07.prod.outlook.com (2603:10a6:3:64::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.17 via Frontend Transport; Wed, 28 Apr 2021 13:50:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 885c7171-522a-4c80-e8eb-08d90a4ca1e5
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2361:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0601MB23613DEBDEDEBB2D3DFFA57085409@HE1PR0601MB2361.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opddtT7a5SFhMpk4GCQQGSxKQLVDWhjWDw7n2pSqoIWTIP87usbLJmpGqkhMFAtpdn55oaaHTnn8udH1eWwHVI9fl8ZUwochOiGQmXo3FDs9XJDdi5z3Gd67FO/mCRIEYcn8Gsi5m3PEi/Mw1eE8zvnFSuRZ3Xmq21/UIy/ogNzgM+X+Abm3N3CLj4uh51/n9+CVwtvI/N+gfnl+Cs0+1hBDBL14B/C8d0Mw4qaidGMzBgU9sHlkMuSuo7JD25b1Alkix0pt3kjI0Bes1nPrAy9hNDr+1LkrosaHO7WvClnmTBXlP3JVqItWu29bYrDFgYm3i6Wm05rDrIDyhIzzanStelGFzzrcriB5OlIJEld7JSH8y6HZyUnqtoBNj7xf3Q5U+nSh7UeKxb0PzrprNWlnybWx4h1NQeO7Mt4BEQjrgo8Uu9yJlRVJ4P+d6o5m82h0hyrewGsdq5+UqasWKVS8E9zyh6aV48zu3PZQxpm/zNGpS1W0WkJbXtU2GknsVQbcLQPYD/JjLQrGi9iQUbr+72BlhyRjz7qinHLdUER0X3AvAfnEgPvHDhLeaRBkDuueIjzvtGXuaioS+ngGQP7nItTxAUMg8CfDspXZxw3P8OGMWWdZGVTaRhlvxHYKM3rE00wjmEIRHeK45gMxJb6da5xcTyP4eEyNOD3Ge3ESdqSwLfXx8Tm3pHZ/92lXches4+0sfmTpL/YsqI9qC26BgPdGSE2ePEr2GTuCVbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(346002)(396003)(376002)(136003)(5660300002)(2616005)(86362001)(6486002)(66556008)(26005)(2906002)(107886003)(66476007)(44832011)(8676002)(956004)(8936002)(4326008)(186003)(966005)(52116002)(316002)(38100700002)(66946007)(36756003)(7696005)(6666004)(16526019)(478600001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?L0OFOqqBWOlXQHJ18fKZm8XdecwB73KGp85Rj35zSQL7l55TrjX1qnSPj9Gm?=
 =?us-ascii?Q?dP/VFToX3/Nqpo8etTo9b5am6GBfdYUBwj9dhXKNS3utfePEEeB6cTPNv/1n?=
 =?us-ascii?Q?Acnng7iF8HEzBvjTyY/pLE7X1ZlapSAHuur8s+oG0Ljk5dpc+KK59kkbm65n?=
 =?us-ascii?Q?HFYidMrgCnu3pNiC1Mo1DJ0QuExN4fldcnLzShPnBXnS6+bvUHJRSK2t88fm?=
 =?us-ascii?Q?NNh5168c2JrdOm+p/rtZZgAY7l1r6xpaW/+FwbP1GQk14xohSHlroqDvRU+L?=
 =?us-ascii?Q?ScWHXOKy0DTTXLgQHLys4MmA0xlImOe3i6fdUxoHtHLojMswA5O/JdfymPj5?=
 =?us-ascii?Q?C+osY13p+fqeO7NDym1U2N+e9v/cKRd03d3y+b41O70azpjgxhawzYnaoHZj?=
 =?us-ascii?Q?46s7EKG4GM17CJz5XUr7cR8hLc9R3dhPR5GiAI8uyIe7pRD+ri+4yVHj6pmB?=
 =?us-ascii?Q?vzHs9gjkuIlX1zDRa2iav45U9QVijH9gPVxC0S4XdBk9IW3zRaEI2/PhMZov?=
 =?us-ascii?Q?ySYDGQ6DEcrG+mB+Ocjoh6/z2EbRbLmuonbqku+cIab2NaZRGt4S7cOn1zLu?=
 =?us-ascii?Q?5VUCphs0vIul9zIXEkW5fEp50NSwsbD7Vaf9Ja0KJuTBa+ULAS0+c3GSrjcu?=
 =?us-ascii?Q?nKz68T45nKxpXhC4eLyfCBD8ue4bg8Om9d2/mErWojz2osLld4fo7Emkez/2?=
 =?us-ascii?Q?rDGVnov1roddXy/dttlo+aEhhTxIav1iGtnVpt5/Q5WmZoOnM5QFFhtEd8n3?=
 =?us-ascii?Q?fvAsCEzs+gMxP7mJJ0rk8A7ziSkzX4gAJ+hMmic1PxJZiKNg7kLCazC2SOs8?=
 =?us-ascii?Q?SUy2MhyihJbo9EJ6+cvY5SOaLYn2V8ff6N6LjtButXtkWqi+XVp91Rfdbqkv?=
 =?us-ascii?Q?UPwPDPJKTFY0dUIkU5TT4RE6/2NpXkXG1TqRdKaziKXZyYOnyVdP6ZnFWuHt?=
 =?us-ascii?Q?a6dhMqdt7DQ3EdeWfZ5KRXIH1USfV8jjq+Opo24AKUBMmFyhcuc8+2RBbYcz?=
 =?us-ascii?Q?bSxdkSpdSAlebBLaUHOose+0nXAJbsdHxSmRSCRaBAOsofA0YWDh4xrmtqFN?=
 =?us-ascii?Q?ZoWJO4Vgrqt5WsO0HymEGhlh7DG2aogVEb0pywl8pFHx3ZOIxwC/08p6WLl+?=
 =?us-ascii?Q?vwBhqeWq9+OEZYtW30jS2NTVOj0GwYwquRuIZO85HIcZzCNu2G23Ig/fCPiH?=
 =?us-ascii?Q?S6AnRq0d1kQW4XjspurqtAacGF2orJQKLX//Dw7E1Dvu2k2sI8aqCXe4mR2/?=
 =?us-ascii?Q?m+KSDbjXSloJdi0HbV49exWvDbHqplUs7lUmWf4b2IvWD2qb64m3soUm1vHU?=
 =?us-ascii?Q?NIAVX+rEaTTkGj6AOx5+aBga?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885c7171-522a-4c80-e8eb-08d90a4ca1e5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 13:50:50.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6SkwNtYkGYH1pB26EL2UQf6UamOyBr6JlHXVC39wjhuGMnee1m/QTlPm1PfHhNW3co/HkmAwnBmlO/7MFeg5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2361
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documents the device tree bindings for `bootcount-nvmem` driver.

Signed-off-by: Nandor Han <nandor.han@vaisala.com>
---
 .../bindings/nvmem/bootcount-nvmem.yaml       | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
new file mode 100644
index 000000000000..cc673452fe0f
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
@@ -0,0 +1,66 @@
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
+allOf:
+  - $ref: "nvmem-consumer.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - linux,bootcount-nvmem
+
+  nvmem-cells:
+    description: Phandle to reboot mode nvmem data cell.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+  nvmem-cell-names:
+    description: Name of the NVMEM cell.
+    $ref: /schemas/types.yaml#/definitions/string-array
+    enum:
+      - bootcount-regs
+
+  linux,bootcount-magic:
+    description: Override default mask value.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+dependencies:
+  nvmem-cell-names: [ nvmem-cells ]
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
+        compatible = "linux,bootcount-nvmem";
+        nvmem-cells = <&bootcount_regs>;
+        nvmem-cell-names = "bootcount-regs";
+    };
+
+    rtc: rtc@68 {
+        bootcount_regs: bootcount_nvmem_regs@e {
+            reg = <0x0e 0x2>;
+        };
+    };
+
+...
-- 
2.26.3

