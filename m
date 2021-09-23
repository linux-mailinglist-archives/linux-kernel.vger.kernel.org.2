Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2149415C73
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 13:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbhIWLDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 07:03:01 -0400
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:54915
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240524AbhIWLC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 07:02:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUsd0m5PCserYG8OnRsgujwFL9kRUVFRXRY+WWofdP17tqoQjgONWcZNMX2CAOdtF3VF1PhL/jhXv9lMxI2h1qgQ/eHmd8huaPPdBGDBcw7d55lfnGex5Ksi8RRZhG1FSCwqwxtwcY9ZaxgJA99lpdu4bh7NYwh4+Kmu1oJOREAsztG+4QSS6nT2vBc/Y2Letn1NxrflyyhyKNIr96pyo31hhes5blxSwaWECZHGBbWkbaI37IoEFisZh3wVHOHRQOIh915EDtpfpQGYfT7eGab5QtTphi8COqq2THXUnEEnnpkdY2VgLCwoRAFj4CS3zGwyG5Q583eqnMSl/jj0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=juLkD8D17EkE5aTqndTUEZM1AQBvMSX7Bb8Bx6rJorw=;
 b=F9Wn/mSyJMnzSqQYsbEoPBkmrzYiS9/q7MmE2m05spzrfsVw3BtLrzDqvEDAnuc132FSpx6Ed+pLoy4dbrGWfKDzGALZ5mRONajxzwlSl8rGdqxwVYOQl7i1SeRHDq4KVe7tl4JV+evl6IF7GQoh+lqrde0kkvQjzQvPwduE7nZP0zQjA45uuxATTTL6Q2IBdMzbtyAR3P6MKQC1YPB/K+vM98X7gsLyg7sFEWfJHABBO3zZIyAgt6S3WH9xIZ6UDGnoeub8+bCTitURZSxjpFcy8yqIcdyOeU1cc9o/wXbycPAifYKdcSVoIEbHUXoGEuhikRSUxdIdN6cPhvl1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juLkD8D17EkE5aTqndTUEZM1AQBvMSX7Bb8Bx6rJorw=;
 b=SFsNpyAqiYHyop2Qnam1BOOpSeFlAjj7ZzcChF6MAXLdII7EiBFRYEKeCFyOOYD0GCWuooARWtmWkXsvafxYf4DheWAjJOCCd2ikdqjfSW92fcmmL2QHCjdXgqElA0V1+v9UHZDJCq8yO+OmapzkjyOlXJbP53njiJB8cD2WGcY=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 11:01:21 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4544.013; Thu, 23 Sep 2021
 11:01:21 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, a.fatoum@pengutronix.de
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 5/6] arm64: dts: imx8m: add "cell-type" property for mac-address
Date:   Thu, 23 Sep 2021 19:01:08 +0800
Message-Id: <20210923110109.29785-6-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
References: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:3:17::16) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0004.apcprd02.prod.outlook.com (2603:1096:3:17::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 11:01:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0785e62c-6080-4cfc-1a17-08d97e8179c4
X-MS-TrafficTypeDiagnostic: DBBPR04MB7836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB78362C8D3954E817C941E493E6A39@DBBPR04MB7836.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n0K+ZUZ0DK32UiN0g5pyj0d/ptm0axbvCdjEaT9PgpLGjsdjsJzelVtgBecHlahpl+AxB4KGqZtSa+umrXve95xYcEwdjyGjqoFSGRJQpvHHmdTXzCVJDeSnX1NvY8+RfRCxNmE09UPXD3dT+Iicr9GP8ZcxJFzQcCUR0IyMYUUzJfK10Bwjd969TOzKhosgLVM80kwkw0maJQov7WAmgYwJ5ReDFwUycIAMf5YlglwVcYuJQUD8Q2HVsSEmXqS3xCcr988hwd/qgMvUWp/NeF2Vir1OsAesFZZ/SvQWajnC5iFKCjw8zBGh4xRBBoTmlXbSEd6ff2unW0zuzBhx54RwZshi4a7Oy1OwyTNuxqW7NwNMCCEtk0jcdAU8OOVbzGvrJsNV5h6Lw3I8sisSIXKLk5b7BfIiB/Mdb2Y9Fvsi6dYCXZga5Aore+IAi5PsGHcu+pI68fdyBl0C20mt1C+lyWVhVY6STb92S6+e8tNoulZCV2PJlbrsMO9o75j3Egyw102Utq+daOiZUvc5xp0BTBerE71Bd4uYXrquwmsjRJ9HUjGtIXAFCjwrJDrITNcQEsVtK5Gm3D7kpoEYEKYpEk+xMhUvMIG8KVjnXlCSljMJNVULPFE9byeslKcQjJzhpRwXq6hQXNbDOBgYFtzLq+85Xb58MuQ0owbKj8gpfd2ljTg4fyd4WRHzjoHZbOFvqOIq5P2glIBYWdBxnC0FapF4Dn5sxZrlSFdhI6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(1076003)(36756003)(8936002)(86362001)(186003)(66946007)(2906002)(6512007)(38100700002)(38350700002)(26005)(8676002)(66476007)(6666004)(6506007)(5660300002)(66556008)(508600001)(2616005)(316002)(83380400001)(956004)(4326008)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C6Lwtm3YEhKGbUVw75TcS4lTu/fcc73MFgIeGPoaJTtB8cbXByygloayvP73?=
 =?us-ascii?Q?vMJIlYj7QHw2z+VkffUTp2GLuaq5vl33sn6MLj7YyW6gHSWdMe5eLp1Pw+Jh?=
 =?us-ascii?Q?X0+lhUGap8Z1rgGufbVwj6mDRym4k5C9DFyD5ByL4A91SUgW1wwxluOFPMVF?=
 =?us-ascii?Q?wMXtT58uCkZVnOtMIUbCtvyAXgeqs0YAFFLdouWZ2SQ5D8Xsl8iBLh+zjQCb?=
 =?us-ascii?Q?AAN9IKhcYaWiiVWo7KbWp80keSYNL/h7LfDAlJ52T0EhFWW35uvrH9A7Bbl7?=
 =?us-ascii?Q?MRhK+JmV+SKtkUGxp1YmIfe7TTpchtmjG/J9L2gCO+WqsHduYgkd1022EpyC?=
 =?us-ascii?Q?GZKYS5dcKR0qdtdaJQzQ8/fQzO5nNeUHRb+EXfAnndofnhBwiApzOPdKtZ/P?=
 =?us-ascii?Q?YdvW7qNnlRgdJuYHL6W43rO9c2OvA3mo+h418fPmsmw6nZRSo4uHWMiDla4s?=
 =?us-ascii?Q?V1T2IgvFuGW8OJZcj+tZ/b2NS1BcHjlcJUsh9NlrNJVZju96PwpmwLglvTpk?=
 =?us-ascii?Q?vMiS9Y3+oss0lYZXx+TaUUdxNpFRQnGW12/I9lOP/uYeuvwcJkJ3WRs4eVIs?=
 =?us-ascii?Q?qRSHRtHC4n+Ph+rew4I/XhN9xNYkGLpIC6SKQ1J7MnjX27DeAdPI8XF+E7Gu?=
 =?us-ascii?Q?gQmgR486hR4AMh2MxjV6ZRcG3iMTCtcWFRRkPwnW9dbE1g0f5elUq4qfgtg2?=
 =?us-ascii?Q?uAOD3GvNe6hHsI8GAQtxvn/8cEaVuWv52OzyHmIQ+49UYIlZ/Abbnr3bhHXx?=
 =?us-ascii?Q?Q2uvcLRZFMxMoBskZsDEDVQNZniz1ZO9lC8gIZ4AeDmKjeKo+ZYwWrkpRilZ?=
 =?us-ascii?Q?terYrXB+6g7h84r7V2IgOzfVNYsWb7p1juQQnrSj1OYoEoPViNf0PvIHWVkW?=
 =?us-ascii?Q?81O4yW8bkNrtW2aOpMXKcI965W2w+m4oOvB6/eAvXD++f5Iurr/E8cqbTzgS?=
 =?us-ascii?Q?a5cRjowPFfzXEOPku1kxSpYYQnzt5HStsNpYJm40z/bqrTu8NkGseClRpStl?=
 =?us-ascii?Q?umeOltEnfymDccdjo1f9G5EiAigHb720KeUZ8KmAgMBMo9wuO+mOfIj4jxyh?=
 =?us-ascii?Q?hb+C5q3SFc0X8yqwrWL/sG4U4Xf65CrSUBeofgY5CNTuG0JWh7NqJG9YRZNF?=
 =?us-ascii?Q?4H1yYQSk4HFapRs6DHlwK0+UNOIWtGAoHGwmB4hiwwgpISOyp/weOaig12a8?=
 =?us-ascii?Q?GbpkCvW5qfhO4ev5gU3zTkupBASk6rauJRW2hjyINWS2+Qtb2mabsSww33vA?=
 =?us-ascii?Q?ymKdrGJ32r4pS0wOY6lQNBeCXzxQpwSlSydPqbnPH8PniRKoUcab83rSWqCo?=
 =?us-ascii?Q?0xXjmXKNBJLWw82FxueNWP6q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0785e62c-6080-4cfc-1a17-08d97e8179c4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 11:01:20.9974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXPk912f/wW0J+OlBN/fpZSd/6M+GpYKC0QxiLvn6THttGeP9Gg2iI7n6LLDYGp7NYOh/oEBxI0tuq6kIpUfEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "cell-type" property for mac-address nvmem cell to supporting mac
address reverse byte.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 ++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 ++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 9 +++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 ++
 4 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index e7648c3b8390..fb14be932386 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/nvmem/nvmem.h>
 #include <dt-bindings/thermal/thermal.h>
 
 #include "imx8mm-pinfunc.h"
@@ -539,6 +540,7 @@
 
 				fec_mac_address: mac-address@90 {
 					reg = <0x90 6>;
+					cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index d4231e061403..0a994e6edc0b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/nvmem/nvmem.h>
 #include <dt-bindings/thermal/thermal.h>
 
 #include "imx8mn-pinfunc.h"
@@ -544,6 +545,7 @@
 
 				fec_mac_address: mac-address@90 {
 					reg = <0x90 6>;
+					cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9f7c7f587d38..37188ff07f21 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/nvmem/nvmem.h>
 #include <dt-bindings/thermal/thermal.h>
 
 #include "imx8mp-pinfunc.h"
@@ -358,6 +359,12 @@
 
 				eth_mac1: mac-address@90 {
 					reg = <0x90 6>;
+					cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
+				};
+
+				eth_mac2: mac-address@96 {
+					reg = <0x96 6>;
+					cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
 				};
 			};
 
@@ -836,6 +843,8 @@
 							 <&clk IMX8MP_SYS_PLL2_100M>,
 							 <&clk IMX8MP_SYS_PLL2_125M>;
 				assigned-clock-rates = <0>, <100000000>, <125000000>;
+				nvmem-cells = <&eth_mac2>;
+				nvmem-cell-names = "mac-address";
 				intf_mode = <&gpr 0x4>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 91df9c5350ae..1cb211e470ae 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include "dt-bindings/input/input.h"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/nvmem/nvmem.h>
 #include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/interconnect/imx8mq.h>
 #include "imx8mq-pinfunc.h"
@@ -570,6 +571,7 @@
 
 				fec_mac_address: mac-address@90 {
 					reg = <0x90 6>;
+					cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
 				};
 			};
 
-- 
2.17.1

