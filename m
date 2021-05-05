Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC5F3738B8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 12:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhEEKne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 06:43:34 -0400
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]:45339
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229524AbhEEKnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 06:43:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsEBU0Hd3V3hduAtfVlvZM1Vp+YM8zG1/1xv2F7iug27+cOiB6SBslO2hsJU63TkVoZN2oAo+03k0jowkdu8ED/KX9W5gZXPrNJpsvPQOV0f3uuQVcXFRDHm01HvNRApGstr9etIiB0ef/P3gh287MoPTNRKMOzamQhv0ykwOGDIBQ+4XO2dFVX8u58Yw/gmJ8y0H9ErW0RQeSmAplL8S2N8RvoADnz0UsUPJx8g8JneOhkFqZdKOKZhyFt+CooAApVmMfw7Ai8irenJXcYuAzlLPJcS2Y2dKu25DYq/q7J4P+Yz87dvcopZiRBE99fkFbQnsibtgwBfeX1qIpxRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2WJ5Q42qE9K3t90ScsoKh6GI6ltGXeSrEBRvMgtnOQ=;
 b=e8bnqu0z+/bQFqXxElmGwmtv+qfUOD5BREI9CMyBkYwQxcQQLSxWCimRjgd7CPEe48HCyMPUNat8FKfnMCn9UwXQB5lp9ySXksXEtwG51aMJAmO5rXrOag2niwpZFDjvtz6yNqg9atbsMBzz/lYpQeoWNzd7jTuFB/XTdi33w4I75yaSOixjEJ7McxcLwxJwONzjJb3RRBO/FPMVFa/9rRYcUbSc2/8q4Gd/mbokOcdZpq41kAWFxeU2e+HGIPtUu4jaGvE7tgoiZJhkDDU5NqGY3aMOZ+r6TY2djjfhU/LRJLwwvsl+GhrEO7rQbQHDlekLIQTghy/gIYIoJ6cj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2WJ5Q42qE9K3t90ScsoKh6GI6ltGXeSrEBRvMgtnOQ=;
 b=W74rTo0IvhIMuBFYvBM/atnXnNSTQRizRYlIpSlXbtxm5FHaMl3jEb60gwxrvQG3UmpYbPynoZfHIeDzxthzCAZIvK4kpsfCFG/Y+SD6Rjq4hKwiy9+vErMKnVgPl8t0Fv9BSAcTvRjrLJ9uJ8sZ2x3E9PZpEGoPZPOIMfHPnerleBdbUzaYj7M3x9qXk/7dxDQmwpD0f6VqCmn7tGpD36R5h2owu4nBwdWhpGO9jZWEPCtNeFNRHKqAVXJjYzIczrnXxz1YJUC3aR0cuOH3RGUlmpfh6pydgtsa5NnNvEh+jBLMk+w1AsatPhQWoNWE7LOqVQG0k1uQeNdg1qu0ug==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0602MB3242.eurprd06.prod.outlook.com (2603:10a6:7:1b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Wed, 5 May
 2021 10:42:30 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::9ca0:8dd:38d7:c7d4]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::9ca0:8dd:38d7:c7d4%7]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 10:42:30 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>
Subject: [PATCH v4 1/4] dt-bindings: nvmem: Add bootcount-nvmem
Date:   Wed,  5 May 2021 13:42:18 +0300
Message-Id: <a64b743e665baabc9ed9caed57b998bbae6d4e67.1620211180.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1620211180.git.nandor.han@vaisala.com>
References: <cover.1620211180.git.nandor.han@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [193.143.230.131]
X-ClientProxiedBy: HE1P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::33)
 To HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (193.143.230.131) by HE1P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 10:42:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5fc4188-3734-420e-6a93-08d90fb27ba4
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3242:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0602MB324245BCC48CFB83C39CD98C85599@HE1PR0602MB3242.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wuFDT4nLGdcyZ1JRDr00XAfd13ZWD+EIyeHGSrXlMJY9X/85DAukXfzhK04/mfmNi4klwhagEGLCSZz16YLfLZVW2YLvrLyU8koFlKFGSVO4dUWQFBo2oNA4Tq9O86vhDjefxWalIi7EymAxKpXsip3ctA5GUSrEGq5pzCnI2zCIfAM2ZEwvAWBveltg2bi0SNJfObtwfdpg+ufQ27vRPfg4QwxcpQ7bgjXsuJvdwJf9sUsv/mI1mHikzR/aA+Xx/HoZAZzbJmWNtUF9iEk8AxNEba6KkVhzyDRbm5CW70TWlQ/GeXP/JoIA4gQ1s3DUt5s93sToxV4fAl7Vy1zpIw6NyrIVlixh5vTKxEl1bHLcfZr6h8I69ojNCLWXWmrqgJAT7u8R88g3xHYD3qiNVkOkj5sDS+pgJ2o/9fqht3+8Pp1QrFkyfkhQYYJbdaEQ9AsZLCBf8cIe2SXoPeqrOH0vedZ3eQ7LHDm61rYmg89k2F20ATGxk5syXlw3KwumiE42qAUizGkQkMIHK5qMNhy4LronXAAnxzPx8PvOYug+FfHuuqGqCLPpMg+TMyQ5AxtL6s+iBTYX4rK36fdQgVPdE+iS4ghzQc2wBycu/GyVIKlrgdkgaE1uOcCQhBcdtFHmLk97Djvu2WrLF4xjvNnq5310lqw8++EVc+hUUFaTzizz1OgRAgsThRjl4U5dSMoA0GtUUpsyeQ7qa4J4/ObJRIdJ7ZSrZ8Oi6QY+/8nR3AtroHFp2k2mTd3I7eDBY3rAn9QpupLNN63EsuOmzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(39850400004)(136003)(6666004)(8676002)(2906002)(956004)(26005)(16526019)(8936002)(186003)(478600001)(107886003)(44832011)(66946007)(4326008)(6486002)(966005)(6512007)(66556008)(316002)(66476007)(5660300002)(52116002)(6506007)(38350700002)(38100700002)(86362001)(36756003)(2616005)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WiPmjE7noRdxpgBLg70Zar+varfV54HauTfq9E/ho6v91NOODsb2xZEKYZYT?=
 =?us-ascii?Q?oZngS4nnDmYw0JqPjYY8XhiH/JOLHGnXaWY2KGkHdPJCwPEl76L8SzSTdleo?=
 =?us-ascii?Q?BEg+0z2CA5IuiR//O1Mh4tXLXzLrzKijMNbEp0adczeOvPkPXi+iFRSBHXZ6?=
 =?us-ascii?Q?BmDKYsIs5t8oO8OVNa6Zxh40qxEW9gbwpQbRi221dnrJ10KTApBclUQVkcbx?=
 =?us-ascii?Q?7A3a7cMpDOTHgWVA900w2beQaHP5BqV386efA/GwTncVvT+234DD6oyK3xu6?=
 =?us-ascii?Q?/QlNfqx5AXmdmzKvpcKa9SDxyKu32kS7PDx516ZOPqz2jBG3q3FCFHsmCU+F?=
 =?us-ascii?Q?GDPa0Oyt9GUoioThfeEaU3u4WOX3oESDHiOMhhCzQW22yiCApAorUakAnF8l?=
 =?us-ascii?Q?fdkH2Dho4MwVwk/HJFTfwjAGHgG9XMVT6EdqX1CQWLRJCuO99i0t/XPrc+j/?=
 =?us-ascii?Q?YYXfXVxI0fZJGPPoIyeGzrugZuAYJI7X4zsW8YFoh7myWu3eX1SLBfr8GQZd?=
 =?us-ascii?Q?+HJd/KBCrUMf0sKuvyYAL/nXLs3XBtWquzTLYXZHl6QK2ARUjQDAlnEp8Exk?=
 =?us-ascii?Q?B8YliCNiSzdtO1CH2gr34x5uagaulpx2HixQ5D3neLuCKwpokJV2t2kj3Yqk?=
 =?us-ascii?Q?njGNU2S80+Levc6fYmAeUjuytGl3oK7tpY2b5dfRUDiJvfa5/FYEK7J7hhFV?=
 =?us-ascii?Q?lWAmRee59lFuIFY7mFA/UXomAxb8TCrxwN1RSUOTXbt0Ewsc7Y7ordWK1oI0?=
 =?us-ascii?Q?iUXuYa9f/e18Ss9mMs9zwAc9mt88Iqhfd+aXwcZZb84BYpuMp7b5ulRWhZ3E?=
 =?us-ascii?Q?hMGTCtsdExabAq+vIOy39jt+6N+2wZUmeg4dNXZq+gmFSLvqkVQ/nIW99x0A?=
 =?us-ascii?Q?nObC7tF2Ux1TcIqCcxOjMN5qjYLk4/ybUh6h72KvhfixKwrOIGKyptSxmZPL?=
 =?us-ascii?Q?Vx46j7iGtJ8omGotCR7tCOsKEEdP6RFP9hGJVS0y3qbV4gFjxPskP2gwiRTt?=
 =?us-ascii?Q?LikfIO540/FhTbbKoKh+nS4Q8vbIe6/j2hzKuAGSE9l3/yjSp5nug3dAo+FZ?=
 =?us-ascii?Q?N1Lv0QNeYv5MVtaMtM//xejsgjR9sm6K1vuLUeQvp+xfjWJVmZot+w/JHLzN?=
 =?us-ascii?Q?ThHgSOtyvbzDA1cmfM8m1FSymKaNBIyEsWfs+SYBt7QxlbiMAyRksXdJMdtj?=
 =?us-ascii?Q?eR2UC+Lr9wgIdT0xyDaw0TtbVFArRrflBnFaAT/7IcuTyuQziFX46iSYJbnG?=
 =?us-ascii?Q?EP9oXWyG67px3+ApwVojZt/qDz+ii3po2QwVWWDLBXuI3AUnLU6gfNIZq5Wr?=
 =?us-ascii?Q?sE4RArUeXahQdqOOU2Pf8Sl0?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fc4188-3734-420e-6a93-08d90fb27ba4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 10:42:30.3851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8LTrGsYQizuaqCeJFXoetFrdPxzlNjeb9NpbuprwHZBW7jNfKdl0dJdlixjpDZ8IZovR9Xfj29b7gB/JN7JVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB3242
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documents the device tree bindings for `bootcount-nvmem` driver.

Signed-off-by: Nandor Han <nandor.han@vaisala.com>
---
 .../bindings/nvmem/bootcount-nvmem.yaml       | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
new file mode 100644
index 000000000000..1200ef906843
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
@@ -0,0 +1,71 @@
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
+    description: Override the default magic value.
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
+        compatible = "linux,bootcount-nvmem";
+        nvmem-cells = <&bootcount_regs>;
+        nvmem-cell-names = "bootcount-regs";
+    };
+
+    rtc: rtc@68 {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        reg = <0x68 0x10>;
+
+        bootcount_regs: bootcount_nvmem_regs@e {
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            reg = <0x0e 0x2>;
+        };
+    };
+
+...
-- 
2.26.3

