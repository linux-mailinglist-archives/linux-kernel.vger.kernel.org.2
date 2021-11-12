Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB75644E1EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 07:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhKLGdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 01:33:21 -0500
Received: from mail-eopbgr150050.outbound.protection.outlook.com ([40.107.15.50]:30183
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230187AbhKLGdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 01:33:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfaSbVLBvl9iIAbg6+FpskyJjj9+CYQ/qxJRwM43t1FRyZ3vuTGJGjje8cttKzxkmQQ9ow1zn5KF16GYS7Xr8ZRWiPSTxsMu5rux8lUbj/ihbSAu1ypC2LiBmyFAULlBYFMqBKZX/aUtrgPmY1gOZaAMDWXxrhz/JwiQ+76RojTW/gRz5/7BE1NllUr+n6qT0NyvrfQlhAekA6cg7Wtbuq4JtAhrE02nkrt5t47lQGPNibfYXpbEOOYOdS52wlL9Z8iVQmpccYO93bpID/IDAepDT3PwczmIzGOwINTiFlF/ohsCY0sAH20h7RBmWO31t11IJM1SeJwS/tEkzOGRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/QCZaIJ3foHoJUTcuhxxs03b4E/YoVZuAUwhob69WQ=;
 b=hLbWjdYFr7zhIXr8MTcegpqMwT7JE1QUDR/P4EAcC3r7G/3r8tivbaLhC1ovgIx7doiH60pFqF6JHLo0yAwpbr027VZHwntgu3d2zfohIORzYBuRqF4/elDHk1DDsNq84FzBZ+Su95eYvBDoHD9ZugHR30/wQo8Wj9GukxAjzTKeBVe00wMkj6wcFLK8C7kYYhtIurWY2sMNQmizJFwL7iUCoHkAwj98y496asWMoUE+AoxkaTgrXvuAeWiv6ZKJd4QfC430NDTwJCDsS276TlUYRhVtVW+s94MOZ4wfZhki32tZJW3fjPY20yyHQ8EIsVGYdKVRZ9LU7r0nTcbTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/QCZaIJ3foHoJUTcuhxxs03b4E/YoVZuAUwhob69WQ=;
 b=BCQCa2JKSD89xtVJl+gikM+Kt/BqrZRIy5gfTZGtjgKOMlmnKy4uIDkq9ZoSoSZDPZjiN/+PgsbnyuAXt+M+tiyyGV0iVWzhm86TcXTvBGiYTfaVArIOnTZ/NIFx+ScvxUB3MCHvWW8v3vI2F2RwfRqqlmxgl60Jrl08G4fWeas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8886.eurprd04.prod.outlook.com (2603:10a6:10:2e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Fri, 12 Nov
 2021 06:30:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 06:30:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, leoyang.li@nxp.com
Cc:     yogeshnarayan.gaur@nxp.com, sriram.dash@nxp.com,
        vabhav.sharma@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: lx2160a: correct cache-sets info
Date:   Fri, 12 Nov 2021 14:29:37 +0800
Message-Id: <20211112062937.3485694-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.15 via Frontend Transport; Fri, 12 Nov 2021 06:30:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5625ee50-3acd-48b0-0053-08d9a5a5ea60
X-MS-TrafficTypeDiagnostic: DU2PR04MB8886:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB88867F81E90DC0E621601DE9C9959@DU2PR04MB8886.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6N7et38gJKBVJvN3cbavL8ptCjwwlF2N+G0Q2eGjLHrg7ggS5zCpjNRKanfOLeOjggKejzRhOVcyNpWtH0pEusHu5vbh+AbAgE/AiKPglN24YrvHZf6Dse1kE9UdCCWXWn3cUSpm0HaLdDhfq3t/XrLvaPWuStstmz4hew/EwDgBMvsNi0LPRufIH0FrmYqV+D4FD4Z0UuOgZ1N+8WK3lQV7+lqRpfSO9jdYc+DsID7gJlOapl86z7jAafWSAYVJEKisfrbhdxUaJRKQRTyKML0bZC6CkjlP6wS7o5H0bpZjUHo7JpJs4yJdD7eaS8o2YuQaw6hhOieRbTr++96u2Li6V15+8nsRHnGqFZH87W5h1mFLW6nDr7C7+K2vXRLwMr4TMwhpAphBwqVn7h8LTSEYUOHYOLeyFrWqOKlxGWYHnSwQWcp2dUtz8vw4znMA3v2a9xhtNjhe5B3oIOiMtqmE09pcL0tN5K0hr91hxl+B/YHlJd8cZaE7MWRY3kJGqlAuV9XyhCwCCh8eKn3kaqMSBe7phIndxSwjLExnq7UgCmxh4ZW1eDXR7daR+53t9L3As6BFZ1k2ptipAATfFw6BEk6fFrePVbNjIXeZ5ovwu04wdGwa0X4wHm+aZI/fe5nbhBQjfpPEFty0hptoZQ5LdcMiYIPC2PaHWS4ANPF51XukIhdepK/KdhrpS+GKNOdvl5K78/amUOyDAa/Hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(83380400001)(8936002)(2906002)(66556008)(4326008)(8676002)(52116002)(2616005)(6506007)(956004)(1076003)(5660300002)(316002)(86362001)(38100700002)(186003)(38350700002)(26005)(6512007)(66476007)(6486002)(66946007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fDIAYMpc71jb8laP7fwZUfJzVm1Jd2Enu3BLy8y/6fD1IgaM8PAk1mAQhybh?=
 =?us-ascii?Q?+VIO4sRqKkCCjxZuDf73LsIN4Pb34tIK78kf9HCYVm+kjkAiRU9ZHcj6kEXs?=
 =?us-ascii?Q?rM/d+lKH8Mq9WB3eN6e98cyxbStKGNc9icz40wTkmmgGyzbrTRVK8XF32BaR?=
 =?us-ascii?Q?Y8NDkYz8vYyWH2V6eEkzL7dq9Vnge9sELoQDdgYrO4F41uKpJMQPbG8QebCe?=
 =?us-ascii?Q?H1QrCGn7KOrAJpb5OvUkUpRG2dOckPiTchJwpDreDPyY7yi6O5e847CSHebu?=
 =?us-ascii?Q?VGCtqvliDzCCbjPaM8rx8X5E5NEybnpKcABnv4icJKztslftQYgPiW0FjnHq?=
 =?us-ascii?Q?kgsaFru14zb0aAwUT4LjX2YMaHV9OgKN0a9YjcXMV7zV3MtaWP1nfq23AUhL?=
 =?us-ascii?Q?3snJzVHCmOm/pf7YNB89j/5kAl3HlDkl6vMaP0Fke7CA3njw8/aHkRLPeEiO?=
 =?us-ascii?Q?lxyNRa3L3XevgDIip91VT4TIc6BXAIEMu6dJcv/essII4Gr9VTFn6EpkFMg1?=
 =?us-ascii?Q?Z3ysxikw4OyShzWCPYlVW9KHMMYcV0Gmp95/ZZfzqN9BN/r82b+hMpbN/TmE?=
 =?us-ascii?Q?AvRySMrpGTG72DBgAbLoqsHVRErTGfMWfWwGQBZ6rr1YkMPaVMHAUIvoixFP?=
 =?us-ascii?Q?LVeDb/5znfCrCS8bzstyrsKeIoh3GcOlN+r9GL0GYUZaml58sGo3TfMfnnLR?=
 =?us-ascii?Q?EcfKWQjsWwFS/IBZ6Nk6SsUJlE2KvW4B9CQtbRQ/ML9tfGEYQ3GW3ame+Bbe?=
 =?us-ascii?Q?j19Sg1j9sPjJwmhyl3Y05Yp4qmLLr+gJvy8ill2hc5kM7hUqI40vOdIXcQ+b?=
 =?us-ascii?Q?VtyH9iAjE53VLfvD/modcD0ijhawgOxI0LSqmhAAZrChBR68On4ZFw5mXsJA?=
 =?us-ascii?Q?VVE1MleI7qDxlyIc+JI2DViXrYTN3xbpnzKYzPo9RjYPhpwNvAilzy2+R4S5?=
 =?us-ascii?Q?onH5fNnuWwKLsH75bPkKxeUl4Hfg+tYhSh4I/ghQ5htwnpIl5fkXuZGFdFs2?=
 =?us-ascii?Q?ZNBEf/aQ+Ypo9m3GTJat4ylyvq3jO88KpVtQH5Y+PUTPINnUlu+Qh61K9Nk3?=
 =?us-ascii?Q?Yttmf8T5l6IjQzRjQ2ESw+7xAsFYBZn2vZomrnmPumR3JEgsRmP6kNAeC7GQ?=
 =?us-ascii?Q?Kw0y2Jcf8if3cSpwpHVWHTS4M5xY8QSZ35vRW6BZXOISuYFalu8UXd6ggqxO?=
 =?us-ascii?Q?7u275oWMAdDMbWHSf0S5TRCuO4DcQWn+Hepb+qiqXc9zgN8dVr/DVRR1NlgO?=
 =?us-ascii?Q?x4RvkqaNPVXsjqlyuKGshue4RFGwoTPW1z9QqCDXMnsxXDP0CopzpNk5hpi2?=
 =?us-ascii?Q?bUAUo3+l7hP/TFV8RAgNvhwrPSqd6sjJ5Y7cZxUdch7VLSYaaEOpDgIblxlj?=
 =?us-ascii?Q?/DwVS59ClI+8usVQymQfsawum2/FQ5iZrAdCu85fhudyh9zwouciaen6ZyPj?=
 =?us-ascii?Q?gJRVTvO7YRJRTxeP7OsiTxOGUR9lvM0Vax73B77akKfD9zGWUi3RKuduNsO3?=
 =?us-ascii?Q?yn3EV+z0Ib0dXYV7U3cDbBuweXOb4eHF/QEmnk/EH6vZ/DdwSQLzSAaipFUW?=
 =?us-ascii?Q?FmcwOcl4o9bBHzOuCYw1QKCsQNxLibjnVbqnQ6unfCUCiaSSgoIENNvOJQ/2?=
 =?us-ascii?Q?6x2yMbivX3HW+xAXwq0RCKU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5625ee50-3acd-48b0-0053-08d9a5a5ea60
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 06:30:27.2143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgwdAoNMVKPwhzWE6fni4/yNRXTnncfYL7y3fRFq5j46UtkZSKOrAbbliDd+yc1kHik47BLoHKtAXWaZ6+dZjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8886
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

A72 Cluster has 48KB Icache, 32KB Dcache and 1MB L2 Cache
 - ICache is 3-way set-associative
 - Dcache is 2-way set-associative
 - Line size are 64bytes

So correct the cache-sets info.

Fixes: d548c217c6a3c ("arm64: dts: add QorIQ LX2160A SoC support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 I am not sure whether this is intentional or not using the original cache
 sets value. If the original value is correct, please drop this patch.

 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 64 +++++++++----------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index dc8661ebd1f6..e1a10bc4c5a9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -34,10 +34,10 @@ cpu0: cpu@0 {
 			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
-			i-cache-sets = <192>;
+			i-cache-sets = <256>;
 			next-level-cache = <&cluster0_l2>;
 			cpu-idle-states = <&cpu_pw15>;
 			#cooling-cells = <2>;
@@ -51,10 +51,10 @@ cpu1: cpu@1 {
 			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
-			i-cache-sets = <192>;
+			i-cache-sets = <256>;
 			next-level-cache = <&cluster0_l2>;
 			cpu-idle-states = <&cpu_pw15>;
 			#cooling-cells = <2>;
@@ -68,10 +68,10 @@ cpu100: cpu@100 {
 			clocks = <&clockgen QORIQ_CLK_CMUX 1>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
-			i-cache-sets = <192>;
+			i-cache-sets = <256>;
 			next-level-cache = <&cluster1_l2>;
 			cpu-idle-states = <&cpu_pw15>;
 			#cooling-cells = <2>;
@@ -85,10 +85,10 @@ cpu101: cpu@101 {
 			clocks = <&clockgen QORIQ_CLK_CMUX 1>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
-			i-cache-sets = <192>;
+			i-cache-sets = <256>;
 			next-level-cache = <&cluster1_l2>;
 			cpu-idle-states = <&cpu_pw15>;
 			#cooling-cells = <2>;
@@ -102,10 +102,10 @@ cpu200: cpu@200 {
 			clocks = <&clockgen QORIQ_CLK_CMUX 2>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
-			i-cache-sets = <192>;
+			i-cache-sets = <256>;
 			next-level-cache = <&cluster2_l2>;
 			cpu-idle-states = <&cpu_pw15>;
 			#cooling-cells = <2>;
@@ -119,10 +119,10 @@ cpu201: cpu@201 {
 			clocks = <&clockgen QORIQ_CLK_CMUX 2>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
-			i-cache-sets = <192>;
+			i-cache-sets = <256>;
 			next-level-cache = <&cluster2_l2>;
 			cpu-idle-states = <&cpu_pw15>;
 			#cooling-cells = <2>;
@@ -136,10 +136,10 @@ cpu300: cpu@300 {
 			clocks = <&clockgen QORIQ_CLK_CMUX 3>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
-			i-cache-sets = <192>;
+			i-cache-sets = <256>;
 			next-level-cache = <&cluster3_l2>;
 			cpu-idle-states = <&cpu_pw15>;
 			#cooling-cells = <2>;
@@ -153,10 +153,10 @@ cpu301: cpu@301 {
 			clocks = <&clockgen QORIQ_CLK_CMUX 3>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
-			i-cache-sets = <192>;
+			i-cache-sets = <256>;
 			next-level-cache = <&cluster3_l2>;
 			cpu-idle-states = <&cpu_pw15>;
 			#cooling-cells = <2>;
@@ -170,10 +170,10 @@ cpu400: cpu@400 {
 			clocks = <&clockgen QORIQ_CLK_CMUX 4>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
-			i-cache-sets = <192>;
+			i-cache-sets = <256>;
 			next-level-cache = <&cluster4_l2>;
 			cpu-idle-states = <&cpu_pw15>;
 			#cooling-cells = <2>;
@@ -187,10 +187,10 @@ cpu401: cpu@401 {
 			clocks = <&clockgen QORIQ_CLK_CMUX 4>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
-			i-cache-sets = <192>;
+			i-cache-sets = <256>;
 			next-level-cache = <&cluster4_l2>;
 			cpu-idle-states = <&cpu_pw15>;
 			#cooling-cells = <2>;
@@ -204,10 +204,10 @@ cpu500: cpu@500 {
 			clocks = <&clockgen QORIQ_CLK_CMUX 5>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
-			i-cache-sets = <192>;
+			i-cache-sets = <256>;
 			next-level-cache = <&cluster5_l2>;
 			cpu-idle-states = <&cpu_pw15>;
 			#cooling-cells = <2>;
@@ -221,10 +221,10 @@ cpu501: cpu@501 {
 			clocks = <&clockgen QORIQ_CLK_CMUX 5>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
-			i-cache-sets = <192>;
+			i-cache-sets = <256>;
 			next-level-cache = <&cluster5_l2>;
 			cpu-idle-states = <&cpu_pw15>;
 			#cooling-cells = <2>;
@@ -238,10 +238,10 @@ cpu600: cpu@600 {
 			clocks = <&clockgen QORIQ_CLK_CMUX 6>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
-			i-cache-sets = <192>;
+			i-cache-sets = <256>;
 			next-level-cache = <&cluster6_l2>;
 			cpu-idle-states = <&cpu_pw15>;
 			#cooling-cells = <2>;
@@ -255,10 +255,10 @@ cpu601: cpu@601 {
 			clocks = <&clockgen QORIQ_CLK_CMUX 6>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
-			i-cache-sets = <192>;
+			i-cache-sets = <256>;
 			next-level-cache = <&cluster6_l2>;
 			cpu-idle-states = <&cpu_pw15>;
 			#cooling-cells = <2>;
@@ -272,10 +272,10 @@ cpu700: cpu@700 {
 			clocks = <&clockgen QORIQ_CLK_CMUX 7>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
-			i-cache-sets = <192>;
+			i-cache-sets = <256>;
 			next-level-cache = <&cluster7_l2>;
 			cpu-idle-states = <&cpu_pw15>;
 			#cooling-cells = <2>;
@@ -289,10 +289,10 @@ cpu701: cpu@701 {
 			clocks = <&clockgen QORIQ_CLK_CMUX 7>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
-			i-cache-sets = <192>;
+			i-cache-sets = <256>;
 			next-level-cache = <&cluster7_l2>;
 			cpu-idle-states = <&cpu_pw15>;
 			#cooling-cells = <2>;
-- 
2.25.1

