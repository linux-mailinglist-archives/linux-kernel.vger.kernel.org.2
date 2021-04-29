Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE0636EC10
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbhD2OIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:08:24 -0400
Received: from mail-db8eur05on2062.outbound.protection.outlook.com ([40.107.20.62]:22880
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234862AbhD2OIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:08:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UerlRoYq69d4eIj12h8EQa0DKa5n06tv7yCaVPIySx1TZ2DQeCcNnIN9STNR3XT6WnumCafG/euZZfUkECTAeZ0zPQfInlBbOLCVaNHWHPdm5e+i8iJUeqIY1lRipZytWw/k8E0rlx/kdfvlJhMi+8C/9lZkkemw4VcYs8+ewYe+5j+adKKcYCNjRryeklRVJD3IsON+Lv8j7NEIJz8dqYpy3e2jCj8V0gLXIje4k1bvQ9s6HF2/Z6cmCuPMGLvvjCw9pDLG7xCTpztCjR8ph439i5oLXYTxQcGx5X9EPyt6zxVmZuSpi5As9WLdOmFle2G6KvYI462UDGkk+ueQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQtW6kbB7WF4id7egs34EzDLfmnwvZ0SSVLWt6c+JSE=;
 b=Q66DfJNbTZNhHnF/2Fb7g8B4rP47nKTl5sguuJKNfHbWfPrDkVuzXLs1rUQbGI+7PvwPhQ/2Vo2d621oSQY8aNZb62t947tIcjSB+2M+5ja3JEu3rZgLotSJW3YD0FcaBUGILIjNPdWBggV/mvBj2cede/b4+l1HqNBSYMgaXtsTiCTqHwRXiC1CMgWRhdweW+kJZI4VfUvBttEDhWwE4CLdcV6JDCxF3LqFakmtC0hxJspC7C2exwfdx7v14DeLeKbnL+WhzDVBjMWH2i5lxGluy4u3BIOKPrJuDBlLhVsSWm8ktYz8fncvHCswYcGt7Sm5p9MSu35K9n0ATe407A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQtW6kbB7WF4id7egs34EzDLfmnwvZ0SSVLWt6c+JSE=;
 b=NrCkQ3jF2yfkJC4FYX58vzKLptHmfcvhCvd8M5f/yCTuyY0mNEU4yK0lrf/ActyIzgocT5AFtEZho9m0HQyGoATN/9qPzYoDPPLeGTkXPAfH0wTDFvbYPNyqSpeG1Dq3pL2HYNq+rlMF/dp1j7TObO0PX3OkQy0rZxvwZ/rQeBrukJAik+J01WyIggNdFBi1qhkkSO1AYtfk9BrBVTiahCvtTClMWFoOnmBJ51N4uv6W6j9fc8akfHAQDC+tjUmj8YFqJEGLH3qH29BSNEnVc5doDwdFwwCoQ2UVq5Sz3dsMXFa3xLIQzD28X89XEI7l9DkW/U2Pcd7ThYJP0Y/NeQ==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0601MB2315.eurprd06.prod.outlook.com (2603:10a6:3:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 14:07:34 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 14:07:34 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>
Subject: [PATCH v3 1/4] dt-bindings: nvmem: Add bootcount-nvmem
Date:   Thu, 29 Apr 2021 17:07:22 +0300
Message-Id: <72d57494594fe9c1d1c226f54be6ddf59764cd56.1619704986.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619704986.git.nandor.han@vaisala.com>
References: <cover.1619704986.git.nandor.han@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [176.93.24.30]
X-ClientProxiedBy: HE1PR0902CA0016.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::26) To HE1PR0602MB3449.eurprd06.prod.outlook.com
 (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.vaisala.com (176.93.24.30) by HE1PR0902CA0016.eurprd09.prod.outlook.com (2603:10a6:3:e5::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Thu, 29 Apr 2021 14:07:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 545ce56e-91be-466c-5599-08d90b1822ed
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2315:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0601MB23151354CFA03CE12BFB8E47855F9@HE1PR0601MB2315.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+5dt/YOgE2ceT/k86gwIfb/cgxbEmjgoXirG5sPcKveXOuPQJHkdukNwgEoG9+fQX/seCwAupPlnYZal5nyJOorDydD9LPHCu7T8m6O9slQZBXNMLzPdkM7r7VSaBIfJ6AgopyjK7VNY8ZnRjnSDSENgkIhe7VwT2Xu3RWstODoRzkrQRF/zQk4NCZv0FR4yJK0f5fTiB1CAVfab8wUbEAk63ttU3RMknljJrV808IeuPbFiEtsvdDAuA744YbDYrqGPjNWB7VWqH4eqpjI8tQ3POBbA63xRjOBiXlSk9gRE+XxeO+oj5B377HI5NfDJCVPIQNhTHIDaSHBZv8rDfDZzdpBE7az0WzpSKMx6rsBstMzHMcB004Lu5MwXVy0sJGeGRu/xGBVZvnRhx5PeW3gxK2Db+sEub7N/wWsTGpHbmpQGwOQD0m2rMw8twYc2lJNMehdeKc6WS74Xe6fSYjeiRb1EvsnjZh97C4E1wBhchRipYiXQCrs/ZW7KQQFZExubaE9hbJvfPCKvPPR8EtP0wl+JrgaWQeFqr04j7IKY5WBrOKwKijEZxkoBHE5401Sc1vc6SEhUdshPygrvTE0QGLZ/h1oZi2ffL1wKiGydFVrMBxIsGbjLWipQqZJmAFKviZSKss9iFNzNCSi2pg2fPUSfYujzHyfaBp7g9l8JqlrI4BeSGDrVObM3uS9huuqoWCQYt8bpURuZHuKQfUI+NYG9pRjnUPXD48LGEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39850400004)(366004)(86362001)(6486002)(36756003)(4326008)(2906002)(956004)(38350700002)(52116002)(38100700002)(8676002)(107886003)(44832011)(7696005)(2616005)(6666004)(16526019)(26005)(5660300002)(66476007)(316002)(966005)(66946007)(186003)(66556008)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZPfHdXqbAJ5ax5/msRCsDfl+Dn0bXocwpuyHdA3qKztEGZ/jLoHApYKLoOcu?=
 =?us-ascii?Q?gfRMFcYkdELvGO1/SBoaqoeHHeY2RqkRMcWoRXdmivXnvhg4sJDhQ0t8jWGq?=
 =?us-ascii?Q?gkXIHt+4cBmF+mu/mMkaas4cUW+tIvI7f0ncN6aL7JpegmnA0bRel7AtKCxt?=
 =?us-ascii?Q?sudDxOFGcqiBhVLF0QJjOnJ6aI1Ao26EmQv/B0VSfe4vJVQ4E/lNHWTDNTwE?=
 =?us-ascii?Q?RR++e0HS9oGyu6gzr55e3WooHjbi0dXZHlGtcjxOiRgX2T4FIE5p1Cd+CWIV?=
 =?us-ascii?Q?TtN2fj3uula4aQGeGB8U683B7IE+x9ZlDhZJ92GD4kwrNESFJshFowXnJba7?=
 =?us-ascii?Q?cG+faz30+VUzcW+En9JPPX3wP7FWczmSFJewE/AlZlMNfFvQUrW/SUz7vmpf?=
 =?us-ascii?Q?DZgqzZlm3Gr/ORqQHI8gcH5RFJfkv8cegPK+ofEoyIwA2p8QVtlZkeBGdrE+?=
 =?us-ascii?Q?u/Al5LsUg2JvBXzajQkodRwpgHofrp01FvsM5jWZ2E/UXK7plhpfDvmdqpM2?=
 =?us-ascii?Q?K6sVnrAQLd2ul0KseS3G17/YbX2kAKY3hLCNczeuI8Gv7DSS+rj9B9xxYQu6?=
 =?us-ascii?Q?kflY7mb2CYKa64jd8DvLqYC0/IRg/1QdrLETGSw2GezdgVNEQv9ReCG69AgT?=
 =?us-ascii?Q?bGWB1AwmPXME8StXexlrwYLfktIBoz8u1KggMBAKL8+2V3DotNcDvCQEn9qP?=
 =?us-ascii?Q?vfGxqDRjGEsYfsp1Xju4YA8JATbGE3AYPmn+hXJx67njTlAyJ5I6nEnT04bJ?=
 =?us-ascii?Q?uyyH4ofmlR73vVHmh2Opp2MuMLRIZ6sOQyHeHxNtDCfkb3uuO0u8GZ7whVvN?=
 =?us-ascii?Q?Lq9Ad2JxYuZUf91OhQnsdAeDcuu5XUHEACv6x8PjMDiy65Y9yuZGGn8VrqB4?=
 =?us-ascii?Q?ucODNAnQTAa+jK9m/yq/tQNyAdSOTTO0RP1/7tpXe3Pl/U0SglIRGNpoWET8?=
 =?us-ascii?Q?KVsuUDJGw6sSHlSfk+AYkR+jmqr3f3n+7MVwFY/hAXLmbDrC1G+lKz6WL/7R?=
 =?us-ascii?Q?B1LqB+9kAJM3OS/7RxzioStYAblN54mzOUcBLyjqT2QmZgutcU5f7jeUI4FC?=
 =?us-ascii?Q?I+kJ0lMhVAq1XEeIzIO6Rl9aLV3iJ36v5D3K6eCfjpadkmD2PSYep2+JdEo5?=
 =?us-ascii?Q?MqVT0h6FpsjaFwGYEpZ2INv68AQ1gxnQNmPcqcGjhqiVEfQtdGxxROisWdQZ?=
 =?us-ascii?Q?heHEbC2Gdw3UDRHicXRkHmXl4bbtQTxT+Ro5dEgJGs5jB48oWqsAxYvkrJp0?=
 =?us-ascii?Q?+obg/R5wClBGgAXCBdShYonUKBGzGcR4UyVusYBNm5RMy/Lq+cBU4BORttFD?=
 =?us-ascii?Q?hJQkUf/VPM4fl6jozGgFHAM3?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545ce56e-91be-466c-5599-08d90b1822ed
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:07:34.4414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/3LpWXDWMwk4HumuIIIfKLEEJh8dW7s3YkXJWKUG2HvWkTL7Je6M8F4SAGOfPJfGoOtV8rUXAUDA2/J+7zWwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2315
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documents the device tree bindings for `bootcount-nvmem` driver.

Signed-off-by: Nandor Han <nandor.han@vaisala.com>
---
 .../bindings/nvmem/bootcount-nvmem.yaml       | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
new file mode 100644
index 000000000000..d17406449c6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
@@ -0,0 +1,74 @@
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

