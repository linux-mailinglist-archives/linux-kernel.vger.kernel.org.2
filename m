Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1BB415C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 13:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbhIWLCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 07:02:43 -0400
Received: from mail-eopbgr40058.outbound.protection.outlook.com ([40.107.4.58]:22754
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240442AbhIWLCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 07:02:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWE+JjQVb09kTM5gSZMZ+HnoyW4eTpJPOji5yCaH5IFJzyFpJJPoxwUnciYabB2amcbjs3VQP9Mr6hQuawGDTpFIHrrgnZiqoXVVBIvbgglaMyHhpLGFK7QTZtB4cwHjB7Jj2tCsePHc3TAcFy408ucYmXxZVaUq4mYsAkO7/3RimLSDGciZ/WkB4Yuc3DWpCpF/LzR0J8Tj6pzTdjENHg1DD23TaH7RqKZTi1pa0JJmBXMrC7/s89yP3EoEoBX2PFnwle84dhsDSgWFJKKSFoCRUHpdcDDsvfGKvkC7LfEcohqhViuiLM7AlvdTRjzXfRbLC/X9Pska4CYqaBEOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gGed3XtF7ZstaxT41kwc7HAW9psN9+JQ6PZrwDGc6iY=;
 b=FDq42Vn0QGm+S5gz0/DGikrucJA2g1pshAn1VZLtUvzqTpk0Rzd5XNa+HUbR7TqvRkadDYIElKHGL7x5lghGo5rJqTujXE2gbfkcH8RaeiE6WSD6wpjVcCu7yKN3ZI317Xibal/lbD3z+YrP6zX11OolvUJ1fklXbUsWoCWCn1s8eEF31jBd57cSwcaMFEJgf21Q42crgumEIPo6wL7XydGb1ecTQNRxYe9dVH+21ExLhBVfCjCjEJTnCLbDHQE3HPuoEEYn1CXEcVfo0ryhNaWwQ9tHcNzbNINXRwtWtoNrTu/0hJvpU9V21g/XPhSeEF0oT99dIua6RD56QBQjIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGed3XtF7ZstaxT41kwc7HAW9psN9+JQ6PZrwDGc6iY=;
 b=ByBTTA3BqtfIyURDtrxuX4RuOzurvwDMZyYcJdNSXKksJGffpM+rCVoPQlG/c39H5EzOBUe0TIayC3St9aPv8qamN43Ua7r4pvNfe6VynllHXSaVa9Ltls3FCEURtXngPoY+RHGkIltz0O9BP01fDz8Y9jQ9GlEnmaljc+A3XYE=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 11:01:09 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4544.013; Thu, 23 Sep 2021
 11:01:09 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, a.fatoum@pengutronix.de
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 1/6] dt-bindings: nvmem: add cell-type to nvmem cells
Date:   Thu, 23 Sep 2021 19:01:04 +0800
Message-Id: <20210923110109.29785-2-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
References: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:3:17::16) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0004.apcprd02.prod.outlook.com (2603:1096:3:17::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 11:01:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e95733f4-6fa8-48cd-348a-08d97e8172b8
X-MS-TrafficTypeDiagnostic: DBBPR04MB7836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7836CB5290C717E63F040BE4E6A39@DBBPR04MB7836.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JVeOhoSwioHPOls42JdCt3QJFny7oYYyeahr2Mvpg4vjTTgRMDMqaL8+ILe8r7scZ1G9l/tZg0gMLyfCr5XYOfQmkEKxEfktWKUaweJdIMkXduTE37WohZ/Y4tl8M7BJOs5baDEXR4lmwc/M8EgrquH0bwZPmBdvpMXaNidxBb4Xp90XMvGMQjMqrxHHEC2w281vk4clSAF8L27MU6UEiEiMTeLRFIyG30IU3kFaxHCQbp+QUoyogGHzwlQFjKOMeBwBcYPgiPl7hu+o7QycvkNNZagikiSWovL952lO9M/dKR2cEmWmSJS1Gy+hdvmMZhpAEcgGgdC6S7TFviWPzpxgumW0tEFdBqVc3h6ZxlvsT1qfKoRzQuvBnSvqFiZc+FAMUjKgOTi6UTjLOiWR8oXxgEz7lDtD0GIU55QMqtrwnHEAHmiipTPTUyzPjSiUtQcO0FCEjVWjqq6o4dSh1AJpkMaPLbE1XdN2cYQHjG2ZwI50AejQbdmm1n7zg5O9sintroE14PZTjYP7Il/1U5g9cEM+wptIJn0OBNHZ9sXZzp1KbXdXqaanO/8Ro2g4ROv/3lEkgi5v1tfEF3+xwrnCzBnjMUCvN0qzt1Wjoq+bOXXVrtfGoPW97pyu1T+CvvExGnm2Erv42GaHYnedoM2JyoibseHCnXfhaEAG09K0xDovLtOOSUrFzI+MoqmKF2bvqSnYsgn7AjvSE8yQPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(1076003)(36756003)(8936002)(86362001)(186003)(66946007)(2906002)(6512007)(38100700002)(38350700002)(26005)(8676002)(66476007)(6506007)(5660300002)(66556008)(508600001)(2616005)(316002)(83380400001)(956004)(4326008)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hUQIQWm6Oy2hxG1lHAq9oHBLKaHwfTjXACbENvbW8goddZ8m5NJ6C1qX2gbJ?=
 =?us-ascii?Q?bjZiXitgmCyugpP0Lqk1bpsR+QO9HGcdq+UqVEBWtDmJKf9kHM6DTeubBY4M?=
 =?us-ascii?Q?3MCByb9iNHCg2s69jG//i/RSWLEw+Ek4k1uJyYJLbc52HntFbYOTEr8CnPnD?=
 =?us-ascii?Q?93PIC+Ukg4YAvRaxeSUZjWq83aS6K0SZ/VTGdFUTPwhmjzimXb5saPz1WMZC?=
 =?us-ascii?Q?6jxML2J/NlaGg+LyU99Vu3e76Mfj0nNTHtwxzJRY7UV/BQHcUO9dihqcP1Sp?=
 =?us-ascii?Q?+LToL78RCNg5ykhTWE3nSAD1VGiXQ0/6AT0b4UpCOPRluApc8Rjm8UJiC89a?=
 =?us-ascii?Q?+jRepUbfqWAIBvqJ9f70zFTHzk0NMNynXeSXdwDffvHMlnwTVqqVcmFDWDxg?=
 =?us-ascii?Q?8EfsJB8GE/rVuPOBIWU3VmLuzhmDid/NnIzmgRnGAfrv8M7BXhQy4ZyJvXAK?=
 =?us-ascii?Q?/J/q1h5m1YgRhMcSBD3YnXe+hsMQAthLluQfeen13kvClAZYcChWUOdWzy7W?=
 =?us-ascii?Q?U9/X6qRPgis+uaQ9otSgJLq4RwqUCxxgTe0tAkT8THlCv1P3H2f795S+x0Ts?=
 =?us-ascii?Q?1e+OoAChsJl/EOneo2617sqYCot0FZ3IoxiFriFxyReYC2866yFjzw1S2U8V?=
 =?us-ascii?Q?HvHi3jITWOnd5FzMlGxzfqje9ETW/Dmsaw8FpAJwzeYszHBqG2jOYrp/f+1L?=
 =?us-ascii?Q?jWnTEZxlP/s2UoB63+8XnWlXG/ysO0/UD7bF3iTLeOs/I30ZemjUAHlmLS3g?=
 =?us-ascii?Q?YM6TspIrY/eT/U3mr9J7K7oHIa6VGwrvZcx8L1cEVFZARCwRY9XC8NFVDvCo?=
 =?us-ascii?Q?RKLFLvuISctFHYRP/FddFgBrTRH5Cqirfc05K5nNpUcfxSKbD7EhuMK8Yoyu?=
 =?us-ascii?Q?YtufBpl+h9IMSuJ4GvKcXkT0y38GJdaglOrMk5oUnP6ltDCi1iAWM/Er/jeJ?=
 =?us-ascii?Q?Y2r62SncI6yCiXaJWKbMtuv9WG0ZlKC0GoSOMpfcoPQ0cL+I+RIUrxhopytL?=
 =?us-ascii?Q?e8F1ngttDqcFHOhI/tbgrN4ymzyrtLDbnx5zFeeRlwgE2mTmK/A7yn9LHaL3?=
 =?us-ascii?Q?GQ6LJpbKoyInqslsFkHPTlsFFTLRimw1i0i+j22hGt83ink3s7xygI0l6oe0?=
 =?us-ascii?Q?Ap4QbY8Kxcf52Tf/ljGxly3ZXR1acxALtDvOUDH5AkMSRE5XuV4MZ1Anpe/2?=
 =?us-ascii?Q?Heg/KQvON3i45ytHTh104TWTAeRmjtvoFljMeeAzKsiH54ok0Ygve0qEjnK8?=
 =?us-ascii?Q?YHmxbsvIOM8wftbWrWoho1UZNMQHSt+ZWtEyIejHQlN3SzZhpw3KiMEmO8+2?=
 =?us-ascii?Q?zvS8ASw4hHE3uYF2l9SxqdUy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95733f4-6fa8-48cd-348a-08d97e8172b8
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 11:01:09.1784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFIuvgOJ24y/D/1Q+MT8eD7q1b09ty8sx9I3sI4iOywTjqSrXx2p8OXul4b48Y74VxR94ReHxCkecwZoL//XHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836
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

