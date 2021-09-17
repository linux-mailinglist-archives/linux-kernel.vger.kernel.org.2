Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7786F40F425
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245368AbhIQIbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:31:32 -0400
Received: from mail-co1nam11on2132.outbound.protection.outlook.com ([40.107.220.132]:55008
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244170AbhIQIba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:31:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCQbppP0giKQbdCO3a+iB5NZoY1qgufl3zj5t8vtDVE2Fb650XCm9e7qqbAAAezYavYsVlWXDrl6nVOj7RuYHRgv0yuRT7yiuAzQBEZT2PYiP+RFV3A21wIS++mA9AO16Ef4PaeGonhz006gmUcYjC2Q67os87yYGRvhVALgaktL3eXhz/rdDZ8W3GnfWmqOMFHPkqMNLmC1kFTED9HZeWZZz9CgeTiipZnefaUk2LNtB9bzpubD2vgpYmZle2JWGeSutNDEbuZjKnxFXvGhJRbIYCLIylumV2rBzJFfH7nYLYIZjsZQodEhOnFnyWge81nocZu/UIhR+9TEc0VWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xAIHhbmkdsXrC7RQqj3WKAa+pRSVG7holBeE9bDHoAc=;
 b=BILPgHRSdzuedny6S+5NX7FJU3KbnO3qkGgoGsyYwHW5tKxMHTgZ3cxVztkdekZ48q6VcRK9xPy1pLu2cVIszo9TDFM9JPZDnv1q5zI72zv4M6ElWRgdY+udGxt/zh23+m7g5X4Ufy2zm185Uq4WnEMRB1NM92cGYixATBJ3BsA6km78G0DTwK/4RTD67oXEoIkFR1Eo9Ols7l2bxTGTk05XN/q1qCp8FvWN0wvmzX1CU+d9PfM3xXqDModGbwXEIHJuHyjJI3rD4bejEqjnLkR0+qcQ2I38ec23+fza0paj45qbjZ8BDGeIRxA5/NDlmZI8WkgZUuirlpTdP1iugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAIHhbmkdsXrC7RQqj3WKAa+pRSVG7holBeE9bDHoAc=;
 b=GHmN3KBb3K+Bfz/C4ghwhpJ9sqwm1mAYOiCaZ+JEIaD9k0X40lXS49rkJZUjptrnzG3SkyW16B2bPp05k1bUiHQLpCJgmMWqVX39C7+SajDjMm/CL190EXBvZC7NyvRGLQBMUxgb/URkOHdfY7Kdju0oocz3XghW2KYolehLUEM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MW2PR0102MB3482.prod.exchangelabs.com (2603:10b6:302:c::32) by
 MW2PR0102MB3546.prod.exchangelabs.com (2603:10b6:302:2::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.16; Fri, 17 Sep 2021 08:30:05 +0000
Received: from MW2PR0102MB3482.prod.exchangelabs.com
 ([fe80::d9d6:d7bc:2f2e:932b]) by MW2PR0102MB3482.prod.exchangelabs.com
 ([fe80::d9d6:d7bc:2f2e:932b%7]) with mapi id 15.20.4523.015; Fri, 17 Sep 2021
 08:30:05 +0000
From:   Quan Nguyen <quan@os.amperecomputing.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: [PATCH v1] ARM: dts: aspeed: mtjade: Add some gpios
Date:   Fri, 17 Sep 2021 15:29:45 +0700
Message-Id: <20210917082945.19111-1-quan@os.amperecomputing.com>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0052.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::21)
 To MW2PR0102MB3482.prod.exchangelabs.com (2603:10b6:302:c::32)
MIME-Version: 1.0
Received: from hcm-sw-17.amperecomputing.com (118.69.219.201) by SG2P153CA0052.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Fri, 17 Sep 2021 08:30:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3f6eb6e-57a1-47c9-c02f-08d979b559e3
X-MS-TrafficTypeDiagnostic: MW2PR0102MB3546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR0102MB354665F68A519BDDF737C73FF2DD9@MW2PR0102MB3546.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpNyMqswhQSe11dcogxsJK/4p7a3xLmy7L+9wrtjDADlOhqvTi9EnQv73hGV0127pvIL3k/V2PQc+0BDS4WZxRhdAL59W2+CLEQD/gN/8SgDhARwpZdyWOT310H/b8m35XpC3cvoAHtB3G9kZ4n53foQ38YvrL+9CgQTBfJd9P6NpKK7pQzY05KXMvs3KjWEjmQ+KeNb7TVH3QksU4xPL7TN1mtM8SU/SD1U9R4kJzeazGJGjmhRLtynC4MrVt8u0Q1XpTqVQP1PJnwIV9Mk0DSxX4PJtUi8vOegClW7l7HNkFxuhRII7KuX9qhni4+tWq/kb9wB5iQW1YuJvWWDCZ8kog4tRuvJmStRekHI0Uk1gSkgVjdVHEvzF4fB8GVkTcL//XJuw3eV6kNQSNQvpR8UZQ9ozuAZWUvm1U60YwszatT+Y3YIGSdoszRurhK/RAjy/BtcjU/obn+SDIUDhVb0zER9IokPgZHFR/6HuinQmnQLakMne2mjCi0CHqlJEXVDgFSJ2B2ZuD/s6nrIdR0JMXkprkxyIY3IPbpwW9ai2gVGchtUcpws5tKOm1pVX0M1iwXz6qyfcGDouOhk0UzKQV1KL1juyS/MM0QNdTr0XPoz/YpRaH3MEW1m0SVeGAtXE8RR6RKr00dLqHHpaweQlRLYPe5CBYE8nvnRTPPoXoo0GPH/+SeATAI7TxbwoRNMCo6B2XvJIzYBg998EQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR0102MB3482.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(316002)(110136005)(2616005)(26005)(107886003)(83380400001)(6666004)(8676002)(38350700002)(38100700002)(66946007)(8936002)(956004)(186003)(1076003)(5660300002)(86362001)(508600001)(54906003)(6512007)(66476007)(66556008)(2906002)(52116002)(6506007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YaLfV5FcZ63uB/BsVgwMkPFyGY6Ypfp78hwXdXRPubmGzQFlhQBXIvhRyLG6?=
 =?us-ascii?Q?XKiQFE1jLktz7TWpDT6O4vFrlk2EUVVqUmkckFy/POC44XYKmbG67/clcH5X?=
 =?us-ascii?Q?+SI/GTpTrttuRXQVwVWyh8EU3zKTvY7lRywNQfEdU//jOHpYBlkS9dn0/n2f?=
 =?us-ascii?Q?7eWEcXcKqNULMdscjLn3VWA5lttmIfesUlD3TloZBUwXThytjC9U/wQR0S6m?=
 =?us-ascii?Q?bPD33l9KwVGD7Fna7jzDOvvr46/2uPnByxR6k26r9IxsZvoj6NWrSujcldzi?=
 =?us-ascii?Q?8AkWmjZDgcgD8/e4y4arQoPfEulx76Ap5RzeGrW1hn0dkzzjzFM2Jc/W+2Q8?=
 =?us-ascii?Q?s8TKX1SBmPRlUF4hqE4z93iippKixLvO3ZZP4D5Qgi/iawPYQAH7Owv+81Ok?=
 =?us-ascii?Q?deQFY2PrHh6lkkFBuoYnF4wc/kzkxdbIXcjtHwkl7ANHXvPXolDXwCNq0fSP?=
 =?us-ascii?Q?yqM9MMa+ZvT8tPAtCcZPVwAUUrjvV7nP80id4I0Eos0zE0cN58Y0jTDvMQO8?=
 =?us-ascii?Q?RSApP3l6MAFaXVTJ44D/mgvw6Og9nAlgTkHQJ691YpLmOf5WcgN36n6PaeRJ?=
 =?us-ascii?Q?/lNUaXINR9Uvkvum3/xHseUxhOLGvKf3xgspFJOwGQdbZX/8JQe/RNjrtqGS?=
 =?us-ascii?Q?pjEql6kzfN4CTc93YLNS4GOkxgvmScobgSRvXw8G94xpyd17Xek6btWQ08vi?=
 =?us-ascii?Q?YAPoGpPjgw9r7rmLcI95R6auOsrHkR1As9kYPTSb/KE0S++wjDsHmNfIPimp?=
 =?us-ascii?Q?+ywkR4FPLLe6Tj24G889uYUHCqEo4XJwBx9J2luzolS4PJqHny5t+/G8WcKp?=
 =?us-ascii?Q?rJpWkAnsTfVv8n0T29gci7e7iKrVf0GX4iub1MpbKTfTjIBULw4YcqfLhgm1?=
 =?us-ascii?Q?COuuZmzjnSQfjJrsq/g5OBLdDwQiEQGqhFdYfWwPDEYAG+b4or/IcRKOymU8?=
 =?us-ascii?Q?6qxbW7oMakzNsCgi9p0BdQHFQZ/ta7Nxf6iRenY9poWcsujK/tclKqdQ/8EN?=
 =?us-ascii?Q?bAfARAOijulWJ7y+1fOArkq3bLv9AwFzDBXkKHxRGYrRJ4TY1ptSyfzwM/qF?=
 =?us-ascii?Q?v/lSP9151t3Yq+17jrJi8fWDWZO9ScOcIimByBGXL+56/z28SMqww+fyF+7H?=
 =?us-ascii?Q?QnRmjSiVgMKchbfvhYRC6kGxR4lvlu8MkfwkmdoztBDBeBoGE5NvJGbjq+lg?=
 =?us-ascii?Q?lBGLBE9Ga4ln6R8j3sdexaCryZqIJQxIwQTb8suXkJtYF8ndtZDydK2B35wD?=
 =?us-ascii?Q?9lOYDZxQpEPW9hP50oZcaDo2p3+n+0BCLotlqv4nArOM8x5f7bijWBF8goEr?=
 =?us-ascii?Q?ZKprl6QG0M5rSLJBI077EVdb?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f6eb6e-57a1-47c9-c02f-08d979b559e3
X-MS-Exchange-CrossTenant-AuthSource: MW2PR0102MB3482.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 08:30:05.7373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7v2Xgv+xaMsgMCvLRf5TYLb93BQwXIDYxap3qS5qWmF5yHK41wxJrzcFYEXzshjxtyT/1y7RD6X1B5oPdmJwW7D/GL2PBeAfsha/TYYqjq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR0102MB3546
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add S0_SCP_AUTH_FAIL, S1_SCP_AUTH_FAIL gpios to indicates firmware
authentication fail on each socket.

Add gpio RTC_BAT_SEN_EN to enable RTC battery adc sensor.

Add BMC_I2C4_O_EN gpio to go high at boot to enable access to I2C4 bus.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
Signed-off-by: Thang Nguyen <thang@os.amperecomputing.com>
---
 .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
index 57b0c45a2298..3515d55bd312 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
@@ -86,6 +86,18 @@ S0_cpu_fault {
 			linux,code = <ASPEED_GPIO(J, 1)>;
 		};
 
+		S0_scp_auth_fail {
+			label = "S0_SCP_AUTH_FAIL";
+			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(J, 2)>;
+		};
+
+		S1_scp_auth_fail {
+			label = "S1_SCP_AUTH_FAIL";
+			gpios = <&gpio ASPEED_GPIO(Z, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(Z, 5)>;
+		};
+
 		S1_overtemp {
 			label = "S1_OVERTEMP";
 			gpios = <&gpio ASPEED_GPIO(Z, 6) GPIO_ACTIVE_LOW>;
@@ -590,7 +602,7 @@ &gpio {
 	/*Q0-Q7*/	"","","","","","UID_BUTTON","","",
 	/*R0-R7*/	"","","BMC_EXT_HIGHTEMP_L","OCP_AUX_PWREN",
 			"OCP_MAIN_PWREN","RESET_BUTTON","","",
-	/*S0-S7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","","RTC_BAT_SEN_EN","","","",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","","",
 	/*V0-V7*/	"","","","","","","","",
@@ -604,4 +616,11 @@ &gpio {
 			"S1_BMC_DDR_ADR","","","","",
 	/*AC0-AC7*/	"SYS_PWR_GD","","","","","BMC_READY","SLAVE_PRESENT_L",
 			"BMC_OCP_PG";
+
+	i2c4_o_en {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(Y, 2) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "BMC_I2C4_O_EN";
+	};
 };
-- 
2.28.0

