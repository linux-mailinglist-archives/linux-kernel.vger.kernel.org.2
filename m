Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E663E144F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241218AbhHEMBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:01:41 -0400
Received: from mail-db8eur05on2074.outbound.protection.outlook.com ([40.107.20.74]:53409
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241204AbhHEMBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:01:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWTeH/9hLFzd/Dx7z+xFkrK3s+seIB1z/RCfy3rmUJducCwuwnbu6PuCuvbm8GfKpHYBIZOa2CFLau02Uu/O3q4UtkWaAkwfIzRA7Sj5/MuPgF6MJ7kAE75QEBqYW436le8r/xLBnmF/j/7EHKpVyUJKioNKWejp9uQGjWc+zNWX90rPCdyFiTPM1a3Zzv1PlJWkHFLeUk6qRGqDXaJleFivvbYoVqLsrG9IwKfu/K8KNDC5S5Dn6lp67v1l8taPni+CouBlakYdRiCmPEsVlq6qZ3UxB57RlUzYVL/t0uu7Peb8/eJDCi2Q/qrNPJ81CdjaKx9r3cl3NCRS6J/1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgPrtAKvIr0Sj36Daks0th7gyBNOeuaqo1nv9a8DuJY=;
 b=lgxQ6bC2TnxGN0mRUoJXw8QHROawVUzOso1cTmRxODqWReQCw9uu/zYkr/2mf5i/xwPUGwrE9jYuolekwrXQjP2T0V8Dsa35zDkRF5O6RQxZFRtk6BXFuEeDzyb23CrKggIWX9lyhawFnWq7ZdK0x5ZIdi9RrbsY1PHNM0pES05wH55MARrkaLCbe522FB2RdYcDuuyAWOgexPrK05lTuNUnBn2KgwWrBkAWwlVnkxQ5TwenhK+UemQ2/fy1ubGEQ7T9QUi/jkzl6uY8jX0gI1B9XYVqDe+C/7wR+2Ofw4El6iMK2Q0mLQ8ReOUBZpF+FIBxrY/V+oG8F6Dm3HrhKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgPrtAKvIr0Sj36Daks0th7gyBNOeuaqo1nv9a8DuJY=;
 b=zZBPDSpkbwbgtV7Da7ikWC6wXduUl6AQlbiap2y19pnmugj/SP3uG3uFSUFLutgQARMo6Q09bSvW8mhTAMCLJa1kmMvxjmO9TEt4n27At4PKq1xy2LTWnx2jH7RmK6/JKj3rDK0/Jxmq/y1Pd7+viB5xcDaQtXhO2rkooFtGRaI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB8PR08MB5419.eurprd08.prod.outlook.com (2603:10a6:10:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Thu, 5 Aug
 2021 12:01:24 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4394.016; Thu, 5 Aug 2021
 12:01:24 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Simon Xue <xxm@rock-chips.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 1/7] dt-bindings: power: add rk3568-pmu-io-domain support
Date:   Thu,  5 Aug 2021 14:01:01 +0200
Message-Id: <20210805120107.27007-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805120107.27007-1-michael.riesch@wolfvision.net>
References: <20210805120107.27007-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0099.eurprd04.prod.outlook.com
 (2603:10a6:803:64::34) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by VI1PR04CA0099.eurprd04.prod.outlook.com (2603:10a6:803:64::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Thu, 5 Aug 2021 12:01:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d10bf73f-9ce0-452a-fb45-08d95808bf3f
X-MS-TrafficTypeDiagnostic: DB8PR08MB5419:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB5419943DB24EEADBF3C659D9F2F29@DB8PR08MB5419.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDzhTEl6+dHKrSsoZlqHrBuD1Ut1/TTQjQ+VwWQ0d3HdDZElqCpuPcmoN98dqIzOBs/8V7apYsGf2/5Bi/XefhKFqeDKCIfAnGZ7YvcnDuqqnf6cyF1QJvXBjLe9vLeLBRdxuEX6UvsP7ZoFEEbSGahUU+FEv8tkMcdEYkFmQfnPJrI7aWxlznjQ/2ixvEzrDaHPpiHoTLUOPqxRuOd4jHetBWjDAs1zjM5IHzKkxC9aAPeBhpL7N3s4x0azSRW4Ymi5jYrbfhpWwDFkALvxiTf/FRlAMZ1qBik5KNJIDJ7yhQNLZoSuL8ZGT3modtuZTX6kbg+kvr+wTrrk//85C87U/5ZNUMPrMCF3xDouis0dDNMrUQ2+t18PCXypX+lcSy2jnENIaT7eBS70RiHtecqRoSuyenFq+eW70JNizky0Z6CAC8WqYCUH2HgByJkWBJ5lkpxE1xwY6+bPuq7FytZsz41ivwgasrEtqXyAEYVGDCcKyPNXOf+Ml+CxXMRtQY/I91dQTYMU88N2BoQKiodF7rHW3exlxqsEg2ahPA9SuxX4cyHQcvVa1wUEfdmS7vyjCuMcx8zV3fzSw1lvQAqvWZ5wtyTRUGuvxDUeJbz4xHO6ajZxk3OhohajtAyR3XCaulWp9N0DP7hekzOKnC/MqftfRHw3CSRF5y/Y8S4w9axGq8rkWEdTpG1nsiJBUrieGuaurdlsEE4Z8RLLQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39840400004)(396003)(376002)(346002)(6512007)(8936002)(66946007)(38100700002)(7416002)(66476007)(6486002)(66556008)(52116002)(1076003)(2906002)(8676002)(4326008)(54906003)(478600001)(44832011)(316002)(36756003)(38350700002)(2616005)(6666004)(186003)(6506007)(956004)(86362001)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y18M0bLRdu/JynVHn+8gtGpGndONQ4sxbBSvyZMHbKTomxMmEBWYhCVsuj1i?=
 =?us-ascii?Q?w8iFOnt8s0DC/YcsTVloSWSd38Fwef9iHWLODSW7QfapjFqCkiwiVMeycvfg?=
 =?us-ascii?Q?PNfbndwuaHb7SuEvhNLCY9rK+xPvLGy4YlVC7vvO5Ceb3e/pXzn5BdDwyozM?=
 =?us-ascii?Q?s3jb167ZRN0+2mVz9raQRXuosqGtcM9Otjk68F3THZPYcPALOze+nUQO8kGW?=
 =?us-ascii?Q?1qnn+UWx2MUtX80/HFrxinxfqJONvgUm0YKAI5Ye4AROk9kITwKQnhVv96Tp?=
 =?us-ascii?Q?fy8jW9lkZb21YH1XS/U7RD6iZsswJXMGinlFUmCCWwAH8IGquQFgh48vmjwk?=
 =?us-ascii?Q?q0v51d02QbpLRj5CkY3IREgJZq2wsmNDo7yHZccNLcyWaJNpyV/+3K1wcW3q?=
 =?us-ascii?Q?mh40o+S0WPmq124GUlJKCLtYRdhG+EK6qbWpRNJYnJqkVlMFaf7FZdOfxIkQ?=
 =?us-ascii?Q?tRWo1mRyfH13L8W483CWl0MyNWm79DHwc9JFtJBwUChjblYpBoRsFdCp9Y6q?=
 =?us-ascii?Q?idpiFFYPNZFNdCFloQjiVM7yj2HzcS3qoBaX4+WOjGubxWd/iKqUqKmblY/y?=
 =?us-ascii?Q?rJ9DRakVjtP2b/eO5kfLe37IPKDvgOEnxe2cPo9qupuXIVy8zAv6RN1UIN2C?=
 =?us-ascii?Q?Z99IvV35RgPOAd4RWmKe0+fArvPjewfAuJqFBd03uAoW2nB0CyzklKfHDZTD?=
 =?us-ascii?Q?uVzdkr+kBr7QKCXlfJZEtd5bsHnTLJ7CgGeQ2wRtCvNtqQ+rnF09rkP5LNBW?=
 =?us-ascii?Q?Ch/iJZq7Sd0GwXJ1HyoG/2VP/5wA1yIZI6D/Fsl+gWa7oqKD5Ad8PkIY6qMl?=
 =?us-ascii?Q?/y8Sguc3elLhJgZ+X+L0XWGjoJGmDwVlQl+rEWqEnaxthxZO/ZczAWKdJf3u?=
 =?us-ascii?Q?19tG75VNkimg5Hyh3fsfvBwH3xQ8jkNT7nOxg+vNa4T7SVQR8LCl0lydWqfX?=
 =?us-ascii?Q?h5AedQCIV72Prar4vC8YBXBqjB3ndFgPkceMLMugQ7jIYGnjruV/ToQt1TWN?=
 =?us-ascii?Q?VNjAa1MHcoA/5YYAyqhSxMKJFtOiC2MRJ8M3Pg1Mf0lOXNKnNM2Z7IVOE3Aq?=
 =?us-ascii?Q?E2ow4QQmwP0vJ9QSG0VZGTPR+mGDBoOOWy6zhajAtokz4eTQis6SRR3614pq?=
 =?us-ascii?Q?RnQVfncsUSJAzBi25CckXUNLI6kmXYGkMZwp1zW5bexRd1JgNVqLhyYkiP0k?=
 =?us-ascii?Q?jyKt6RWy/J4fae28TEIxVwiVNapU/9MCHj3VA597JqMexWQheX8pYjR29EsD?=
 =?us-ascii?Q?Y9mpjrrbLPssswytV6Q9bGzG3/g4EK4PNWOxQ7Il02GLwjp2MvJNebtNplwj?=
 =?us-ascii?Q?cQmluCW3F9ibp5HRRtEmHjIh?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d10bf73f-9ce0-452a-fb45-08d95808bf3f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 12:01:24.2619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqsuTMkvJktS852smNCtXkpbhXtUatLrIj4LpbTJ+5fYYtSbM6yNqObm+RAgvwOQ0+1tPEA0HRTEAMQRWJv7V7vxlqhthBlYWMcXEEZcirk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5419
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the RK3568 along a SoC-specific description of
voltage supplies.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
[add soc-specific section]
Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
v3:
- add missing compatible for the rk3568 to grf.yaml

 .../bindings/power/rockchip-io-domain.yaml    | 30 +++++++++++++++++++
 .../devicetree/bindings/soc/rockchip/grf.yaml |  1 +
 2 files changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain.yaml b/Documentation/devicetree/bindings/power/rockchip-io-domain.yaml
index 121bec56b2b0..1727bf108979 100644
--- a/Documentation/devicetree/bindings/power/rockchip-io-domain.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip-io-domain.yaml
@@ -55,6 +55,7 @@ properties:
       - rockchip,rk3368-pmu-io-voltage-domain
       - rockchip,rk3399-io-voltage-domain
       - rockchip,rk3399-pmu-io-voltage-domain
+      - rockchip,rk3568-pmu-io-voltage-domain
       - rockchip,rv1108-io-voltage-domain
       - rockchip,rv1108-pmu-io-voltage-domain
 
@@ -74,6 +75,7 @@ allOf:
   - $ref: "#/$defs/rk3368-pmu"
   - $ref: "#/$defs/rk3399"
   - $ref: "#/$defs/rk3399-pmu"
+  - $ref: "#/$defs/rk3568-pmu"
   - $ref: "#/$defs/rv1108"
   - $ref: "#/$defs/rv1108-pmu"
 
@@ -282,6 +284,34 @@ $defs:
         pmu1830-supply:
           description: The supply connected to PMUIO2_VDD.
 
+  rk3568-pmu:
+    if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-pmu-io-voltage-domain
+
+    then:
+      properties:
+        pmuio1-supply:
+          description: The supply connected to PMUIO1.
+        pmuio2-supply:
+          description: The supply connected to PMUIO2.
+        vccio1-supply:
+          description: The supply connected to VCCIO1.
+        vccio2-supply:
+          description: The supply connected to VCCIO2.
+        vccio3-supply:
+          description: The supply connected to VCCIO3.
+        vccio4-supply:
+          description: The supply connected to VCCIO4.
+        vccio5-supply:
+          description: The supply connected to VCCIO5.
+        vccio6-supply:
+          description: The supply connected to VCCIO6.
+        vccio7-supply:
+          description: The supply connected to VCCIO7.
+
   rv1108:
     if:
       properties:
diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index fa010df51a5c..dfebf425ca49 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -208,6 +208,7 @@ allOf:
               - rockchip,rk3368-pmugrf
               - rockchip,rk3399-grf
               - rockchip,rk3399-pmugrf
+              - rockchip,rk3568-pmugrf
               - rockchip,rv1108-grf
               - rockchip,rv1108-pmugrf
 
-- 
2.17.1

