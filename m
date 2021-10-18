Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3407D432A70
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 01:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhJRXvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 19:51:51 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:24790
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231450AbhJRXvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 19:51:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F30ev+o0sxWyZ/sDjRyJVnIZT7kImv/nTJY3l4FbUMJdqF4Q2mxksX5eEBWTRxfrsi/d/RmvwDyjDPHqGONm5uPw1D0tXR+jX0D8BoMSdO8elRwr9Y4+G/kHXuCBx73XSvCdnKRxB7G9DL0fi9DPJjlQ1Exc0eiZbylG88P59v3RNBJ1TnjaMLYz2HSUaVJ37Zs/RLbJskT+yOYrVeWg0k56bQGtTrGGGocn5M1LQGOfgaIer0BYrqc9ciPs4SMH6iiYjb8UojgvbotiFhekJUj7wP9di9rN1pN7uJV3B4kVUCVV2sKwMNiiqs9VBtgpqdGtzaoxcOKTk/ld7Vnqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBnJqXk0H7yWsYjo+zq8X1FwqEf6LZVgxgxMI9zNKuo=;
 b=CHFFjUXpJTEc8eM+Qpe5LHHrcruuwHBxv9KDFWUCOVNRTkbZ8zo+MLkzF0G8X/208djBeUvODWxzS+kVclm83SbVVHRLKpssXZuB1BOLmflDW8pwooAF37J7G8VqR7UdNDQo2YOAWPlt97c6QjoRcP9jRKf0qU2VMcC9qc84J80szSgQYCP4bBlkqntHSb1qRXg9IFdo/U3La9ICqswuMvgi+xhdqVqSv7aiBZblUBqY+j6NWfFD4/6YN6BTmg4vb/HWZdK6P6P0YD16UR7TsWWM3otbvPyi4o5+rviww7qp8UvfRS6/qvHbcLKYvnODLttEQKvPgTml0LLxXdjtjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBnJqXk0H7yWsYjo+zq8X1FwqEf6LZVgxgxMI9zNKuo=;
 b=6TbHHcMYYXcYtd05ffXmB/QQCvHhm5FMIZiHWtYWxwYmQ83tnYUS1+Cew0YMDNQNMXdrt1V5webAkLK7FfBwfsJ97NTQqaEGkZ2slv6vYDa+CXapg8XyUnkp6o3C1EQl7UXxP5Me6yUZQf5eWeMZaMBoXcuu1OaTwy3XQndgXC8=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB6025.eurprd03.prod.outlook.com (2603:10a6:10:ed::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Mon, 18 Oct
 2021 23:49:33 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 23:49:33 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: reset: Add generic GPIO reset binding
Date:   Mon, 18 Oct 2021 19:49:21 -0400
Message-Id: <20211018234923.1769028-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:23a::27) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:23a::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 23:49:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 721ef881-9dcd-44f6-e82e-08d99291ef33
X-MS-TrafficTypeDiagnostic: DB8PR03MB6025:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR03MB60254D8564AFC9D87F03F22C96BC9@DB8PR03MB6025.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8VvdFsq2KitA0+6Qoyc6/MhndzoMMi0h3ZUH4YzNRsAGvKgun3zP/NoLdlH1CZ0IEqrQwTejGln+YDxPnaPNM33fYVLf5srauVvkexWJoFl+Q7hliD+hGjui+Ps9KkMChVnu4cV0x9/PSzUo+G6Yi4rzOGYhhjNLGKs83i6HeMAMfifLbE5PHZd9iXu+BBTt+TFc3lSzsKEhLlx5DS9gxMOrunPu/LJHTP697hK+6h8EEhiiGO15RCS/NvY8jL9lp0P6gSUPunBPWOHbSxoEtf5yW5GL0QApQwCHWUxqHplHlsavLWP0hFShvNl4KdzePkxHt8svZGN1PAvg9uohLZFOHRGD+mZ3b+0wYsq+P1LCkGvKtfnT5hGjjXMW7LqFqbgCr2Jx8uaW4ja5LlquVwPxzpbXeiWCHhI6nJirMA75WG1jret3xID5jrDVUDx9Mi/OqF/I9B8FXKzH/FFJMPmd++pvdCf/AACkBTcQ18Rs11a/3DAKSRakbQ+xWO6W0KHPUn14AaYfmgnoh70CcyCYG3HPJMTmDuxXWjX8D5IeTYg2fo1GR7BCAlZdFX78RvYeiDObn+BoSqQxxB+o7YQJMRNrDvCV61dxHKIhrtOPl2PnhU8I6IJ+Kul0Rt+4DaoW69B7mqShffe3o4H8AH72S2noL94ZsOefuO3h6S4k1m/s4uKdUIE9mE1qEvg/+4TgE7Foav2zKLRnushIibmBapGBdiSUufRCLwjE9E+sHGURuu0c4zClmCfmHN6L5ktrNGVas0HLSIyBIYVhzm1OVBn5V0n8lOAN5EP3Y+EW4wmG7YYDGhd+BM+5U7Ly
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(956004)(38350700002)(38100700002)(6916009)(966005)(8936002)(186003)(2616005)(6506007)(4326008)(54906003)(1076003)(44832011)(52116002)(316002)(6512007)(86362001)(2906002)(83380400001)(66476007)(66556008)(66946007)(6486002)(508600001)(8676002)(5660300002)(26005)(36756003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jS2N4A5JuQP0jYS3yCGfpXHd72Xzm0yeD6uib52m1TLzTZnKsJvOK8L7BCEv?=
 =?us-ascii?Q?LichaCV+rMNv4IE5gwyyn7bpItPvP61hwzdj2ARoITlosQSvkuJHTtxN25+9?=
 =?us-ascii?Q?3dvkSvszlyDulPm7WgI2C6LMckrOozzH3ye6DTZHjtaIoq++d8x70x5YyWHv?=
 =?us-ascii?Q?rzsyoL1IumQ0kS3MF2rITWhXh5I7IqON1OhIaFMz2gSSRTInoLFulYhQh6sc?=
 =?us-ascii?Q?3w4TYEecK5j/jNFP93yCuuYcRtYwNw2yz44xYsh8OFh3w2VVmw7vsJHSu3jt?=
 =?us-ascii?Q?hgm3qtKu5WaVpCkLMCpsPEm51eCbaCD69vFhe6YoHX6gkw3jXtvAeRR4ulXv?=
 =?us-ascii?Q?IgrqdkMA4bYZeq+KBEiVtVqRAR+krhukbtczAZTGQBx+RIyqBBD26Py5s7Il?=
 =?us-ascii?Q?H9nlcgunbiW+pimhzkUr0fPbEY8jYUL6aKBW4NB3RzWwL7nB4hT0SrgJmywZ?=
 =?us-ascii?Q?wu5F4qZCrrgdTIcbOmVYwFJI28G+1qTyvene7tcqCaVRa4yQKZdBkGMBkeN2?=
 =?us-ascii?Q?DqCrv8BQWw1NjY+Azd4fruNH3HEfmTA+tcyfwvsv7w5TTsGdnQDeR2T2oHnM?=
 =?us-ascii?Q?huU4+f4OD0KyjqR0ezWtjH+mFvKyfgqonjjAYkGs7t8wbwtIjkpC41+zcBkL?=
 =?us-ascii?Q?mRC1TpJA9PLpkn3ZjdnRxh7/obM5CYnxjT1eSaHysPCzAmBFsnv+20fvioDn?=
 =?us-ascii?Q?sns6EApkvXy/gZVicyzvM8qFWcnRUNLuRh3/HEuAX4E7bIEg/3PFSjRK4vJr?=
 =?us-ascii?Q?CgJhBu0THTWDC7oVc9hWAhF3ulx8ZRwdRnW+lnhKeMYRUD2r5pImFpdrxdSK?=
 =?us-ascii?Q?kZ8Vx8WtyO5in4Kugn0di1nE/2RTgg95fuiw+Q6lHXfO90pLJmvyf7xGprl9?=
 =?us-ascii?Q?I631qJXJkMJsNMGEzgSp9Eoh9GBcm1AhyHexOHSx8zWHCXC8ON5tB4OWLsxd?=
 =?us-ascii?Q?nEWZLURXSDeBolDQotJqRcUqM2XpLo3kJz/rV3pj/YIGblgz+65z3q06wgGU?=
 =?us-ascii?Q?7cn8tc/dKDlz64KWvRbtP9K8aD4t5QCx2Ifv1W5/1JYSfxPle4OEZ+d5JpsE?=
 =?us-ascii?Q?ndbhbOuDnCtz6x319TfIby4oCjR8WKePdSTK/diGY+RxTsbq96biBOyiB/om?=
 =?us-ascii?Q?PwrJLwVYoSnXClqE5oMLyCYYX/uTUMLuKzNeEClAy3gcr3+CAbz8dW5qEzIT?=
 =?us-ascii?Q?hiL/5aesBBv0Jbq/ZY3R7R5TPZdIie/xwSJ8ZOTuZt51meBiH2hSCPbgUaRb?=
 =?us-ascii?Q?VzvzYQnEr7s44CX64hlIIVE4ghwJHXonoOO57G/32swAJQntKTYa3zEZzEIA?=
 =?us-ascii?Q?W77EbuMtI8ZC34ldApEL6+6q?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721ef881-9dcd-44f6-e82e-08d99291ef33
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 23:49:33.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jorp56jl/zeslxCCNP+KUC042nej4o9uNgUuIKIokgyEVujjwzTaZOPl85klwwViNNLOGgjTauxOB9c3tKyCpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a binding for a generic GPIO reset driver. This driver is
designed to easily add a GPIO-based reset to a driver which expected a
reset controller. It offers greater flexibility than a reset-gpios
property, and allows for one code path to be shared for GPIO resets and
MMIO-based resets.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 .../devicetree/bindings/reset/gpio-reset.yaml | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/gpio-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/gpio-reset.yaml b/Documentation/devicetree/bindings/reset/gpio-reset.yaml
new file mode 100644
index 000000000000..de2ab074cea3
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/gpio-reset.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/gpio-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic GPIO reset driver
+
+maintainers:
+  - Sean Anderson <seanga2@gmail.com>
+
+description: |
+  This is a generic GPIO reset driver which can provide a reset-controller
+  interface for GPIO-based reset lines. This driver always operates with
+  logical GPIO values; to invert the polarity, specify GPIO_ACTIVE_LOW in the
+  GPIO's flags.
+
+properties:
+  compatible:
+    const: gpio-reset
+
+  '#reset-cells':
+    const: 1
+
+  reset-gpios:
+    description: |
+      GPIOs to assert when asserting a reset. There is a one-to-one mapping
+      between the reset specifier and the index of the GPIO in this list to
+      assert.
+
+  done-gpios:
+    description: |
+      GPIOs which indicate that the device controlled by the GPIO has exited
+      reset. There must be one done GPIO for each reset GPIO, or no done GPIOs
+      at all. The driver will wait for up to done-timeout-us for the
+      corresponding done GPIO to assert before returning.
+
+  pre-assert-us:
+    default: 0
+    description: |
+      Microseconds to delay between when the reset was requested to be
+      asserted, and asserting the reset GPIO
+
+  post-assert-us:
+    default: 0
+    description: |
+      Microseconds to delay after asserting the reset GPIO and before returning
+      to the caller.
+
+  pre-deassert-us:
+    default: 0
+    description: |
+      Microseconds to delay between when the reset was requested to be
+      deasserted, and asserting the reset GPIO
+
+  post-deassert-us:
+    default: 0
+    description: |
+      Microseconds to delay after deasserting the reset GPIO and before
+      returning to the caller. This delay is always present, even if the done
+      GPIO goes high earlier.
+
+  done-timeout-us:
+    default: 1000
+    description:
+      Microseconds to wait for the done GPIO to assert after deasserting the
+      reset GPIO. If post-deassert-us is present, this property defaults to 10
+      times that delay. The timeout starts after waiting for the post deassert
+      delay.
+
+required:
+  - '#reset-cells'
+  - compatible
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    pcs_reset: reset-pcs {
+        #reset-cells = <1>;
+        compatible = "gpio-reset";
+        reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>,
+                      <&gpio 1 GPIO_ACTIVE_LOW>,
+                      <&gpio 2 GPIO_ACTIVE_LOW>,
+                      <&gpio 3 GPIO_ACTIVE_LOW>;
+        done-gpios = <&gpio 4 GPIO_ACTIVE_HIGH>,
+                     <&gpio 5 GPIO_ACTIVE_HIGH>,
+                     <&gpio 6 GPIO_ACTIVE_HIGH>,
+                     <&gpio 7 GPIO_ACTIVE_HIGH>;
+        post-deassert-us = <100>;
+    };
-- 
2.25.1

