Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EFB3323C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhCILPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:15:07 -0500
Received: from mail-vi1eur05on2072.outbound.protection.outlook.com ([40.107.21.72]:51648
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229799AbhCILO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:14:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jK0sj3PLSifU8q0Wa2PiG1GJ+ks4oJq1fMg6XhN4jcdf6H5JYhqI8RZq6njp217eU4wMQE8qa8mXliBrluSaqB1csP4eJex6YYXc5QU5lK9NndTvrjDP75TttT7vX2FsHQ2tVycu5HcujwMpQRlQq6SyX48SqIowW+IYwVcU+Ltbf4qc8erQPQDEpF6s3rNJD+rwfglbjpuO9Y/Z5Kuajd24/BcntqRQog9Lrnwf4cPzML7AqgA2iy8DDh3XG6AsFDF7dizlw4AugF3Ckv+L1v7jgXV8PTpIOFLmh175pYZW9hWeDY4YzahrxbYvXTxmM4mlfs18DwvLyArxP3SJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU5cxJRJxIVJwPWObQx8KFFMSuLUDsfgjxwxUDLMcNk=;
 b=RzUfLg4NshVjZ2lzXBxiuI0fkDv7Uf6npv7ZGxYSR7deL+D24+S4hC35XjfxfUj7dDD1ba3iIcf2U4pJssNX81cEcusR/EthDmLija2GBly1+bwNBD8XfiyAIgBZi1E6fPg1DHhS/K3v1fJCf3hhp17W8x08NZUv7rLSHtUIaeVHsBwkogTdvyzoLl+9FmC79bKYEcf/wEwp+Y8N4szY3H6yppYZrzUj8do0z5JhnorRjAKRsmbom0oD90r2tii1slpHOt8eM+WX3ogdJPjVKm3y5QZRDd4kzXpDQrxdz3jkHpmaUAofLI51GskGOG01E3GT2qlBpT6F6sxEjxk9zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU5cxJRJxIVJwPWObQx8KFFMSuLUDsfgjxwxUDLMcNk=;
 b=SK/7sunpopEKEHaybrQykGkHfZryDaxVb8ZZkqbYZYZdcLdriVlrGzw9FsIeQxPMpQcb9FeIIb9L2w0/2+NZJlK0q0E6aJWrxADpm4jREtLYfcqM6sRXhrL/NBQPb4OA5w40/XXk5241UnRBAkbpN0WRRGGMaajrdC5U7MdXGAI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB6PR0401MB2375.eurprd04.prod.outlook.com (2603:10a6:4:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Tue, 9 Mar
 2021 11:14:54 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.037; Tue, 9 Mar 2021
 11:14:54 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH 2/2] arm64: dts: imx8mn: Reorder flexspi clock-names entry
Date:   Tue,  9 Mar 2021 16:44:25 +0530
Message-Id: <20210309111425.3539755-3-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210309111425.3539755-1-kuldeep.singh@nxp.com>
References: <20210309111425.3539755-1-kuldeep.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: HK2PR03CA0044.apcprd03.prod.outlook.com
 (2603:1096:202:17::14) To DB6PR0402MB2758.eurprd04.prod.outlook.com
 (2603:10a6:4:96::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by HK2PR03CA0044.apcprd03.prod.outlook.com (2603:1096:202:17::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend Transport; Tue, 9 Mar 2021 11:14:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e6f14be-fd7a-4405-1985-08d8e2ec9097
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2375:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB23757113FACB630ABA4E819DE0929@DB6PR0401MB2375.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5AAWWX+piWHWanNTeAXWwHnneOMJyeHxc0R/I4dI/UQSYZwppHjdNmayJX7cCWhtSM69t+UY9KRtN7LjTSVMgezVttCOvDV2gXtVjE6jANHTjnvWMJpOeAOS4luOZIiLN2eTkvn2P1e3BLOt5L25H3V9wTYRtVcneWKoxqmZ1g5ojSl/SsTBz72RUagcvmUFLG10Elg2/h/p32OsahgAQmI0AwPduLy68QKVM027k66YXO75NnYNZ7fgZd1dq30qM46b9egsFO4303t26PmoUbNEGVE6seWH+stEkvek5JaA2GiondVfZiGdXeEAvirEX62wc4kVjbbAoXFZgrzPgxOV94MoRgf5Zd/BY3zP/cGZ5r34dIug3sP9zWohjdsvdeZ4PUoo1ECwJqWdTNgifXd/02YkWRT0Kh7jaZXq/Oz2/BqTolPwEFGUm1xp4NjFwQ1GkNgBwITbEPRAEhMJxCxbaleb8esVe0lN4ESSCP4w6YB82r0Bg3Uvshd4pNMBS+vNkNi4yJl08aYBOs90UGLb2M3CAWcCchaXcJJaiF8yAaoBCHfxPkNI3hGjcCcWqUlbxtwf1JFqJU9Et6HhvV5/mNaQgL842QKWpZ+YCqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(54906003)(26005)(1076003)(7696005)(2906002)(5660300002)(4326008)(478600001)(44832011)(52116002)(36756003)(4744005)(186003)(8676002)(2616005)(16526019)(6666004)(6486002)(956004)(66556008)(66476007)(83380400001)(66946007)(316002)(55236004)(1006002)(86362001)(8936002)(110426009)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?64sOO4zqmfvw59ecOGb0QyDjFai6WaJFOJ4jcyY/hAUz3VYJp4InWfqJc7Zf?=
 =?us-ascii?Q?gyrXxaieU3E3qz2V0ACp3PmMpXDw3CRQu0Ll+eSYE94jkp5gn9C1YGUGX3gW?=
 =?us-ascii?Q?ntCiHkvu8TGAp8qqOXPYQekIEc41xlcwZuSuYfuptWt+m9EWyKJE7AnCdswj?=
 =?us-ascii?Q?FpZLvFt+K3mwH+9EOYo5Nf4cI9Ie2iQ6ML9DwdfZKcaNJ1uJ0/4mRrgfs4j/?=
 =?us-ascii?Q?6CUnJ1LI73b6WJycgwJaGAMaCzmHHyQs6ycTooXkAPFFC88IDMI+m10N7FgL?=
 =?us-ascii?Q?NBTw8xNyz5rgk06CgBeQmWKKCbCL7osRrKjP6Jo+hye80HX4US2EZZiR9LEa?=
 =?us-ascii?Q?bxx2Nmz3kvC3BT9Sgr2uRgigugeU+L/SA+LNT18aNGrAsvOrxndBxijQ775g?=
 =?us-ascii?Q?XcHZFED+R5EyKJ/wX3ygGGYIiQ6JFA83g/x/yzxSHGrHoi0wjvuMV0qnKehp?=
 =?us-ascii?Q?fBHgCmkL94Ku7x+8LzYj+lVJKXFhhNwt5z0jDunVK1Aue7KyhKrzgVF4IOi/?=
 =?us-ascii?Q?vPvPmXslw/mPK3FAf1AWp8NlxL3JVkVnQ3xcHZbIPv7Bp7mMgLuhTglY5qer?=
 =?us-ascii?Q?39gAz1lo9i6Q8GXEMUxYXdsqCQ2WoQvdcfQuIRHYRLm7j2iY59Vdum8FnItf?=
 =?us-ascii?Q?NUjXMnnYJy8hWRuAlnG8KpxhLZzSSvQP/1u/4xGF53sdqlls3UzIcZVorJaE?=
 =?us-ascii?Q?BezJuOrCCQLzWA94ung0jOPeq6OYmiOnj//Cr2649s4+hIude6GbokmrLxLQ?=
 =?us-ascii?Q?VEkA1DvosluedbbhpZaldqtamVXEUKURcadYTY4FYgnoT3gASfnUScG0MwCu?=
 =?us-ascii?Q?kN/FjLGEyke3k+Ax1W352rAweEz9mLWWBva9Pa/yTyAhPd5rRifgTyYrYodw?=
 =?us-ascii?Q?5KSpHy6HBhu6v8VpBsmeL+p4UA13x/4RDfuGGm5AIWfpS937t4sEs1EyRTl/?=
 =?us-ascii?Q?y+3UoHcQEgLXypb1ds41srqzyPUsPshfDUXo2cWKisgtI18QNeUqzdhkBsCG?=
 =?us-ascii?Q?YiQKyQNu39ocUH9d7cXoa6kZdwR1o2rww2bx+l+/+fy8dCsKzQoTN96ts6yR?=
 =?us-ascii?Q?60LfWDkfHsQw+mCJP1vFh6R8c0YeFsCEJLKhSE5EXuUBZh+h9InNuk+hZllv?=
 =?us-ascii?Q?n6gILNKr78rMbH9cC9lZ0ZugkZeLiLEhKZE3gh8rMv+vsZahW4quBPC/eznu?=
 =?us-ascii?Q?03GUOrv08cFF/1QJPr3rjDAba59yP8ObPEy9CdbCPypz0G96aScE+3GH+BNe?=
 =?us-ascii?Q?xCRrEeKVtrsFnoJUKHuX8wvFPeFZDtg2yZkrfInoC5L5yOUvoqdBAQCh1c3A?=
 =?us-ascii?Q?IUkboUPNU1WmwsKNswEVg9OX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6f14be-fd7a-4405-1985-08d8e2ec9097
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 11:14:54.2784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCs88ZGYT+K0x9XfxQxBA6eYE+EoQdulqN+4iMqbYNPTot45ACMJQJRH48Ms1x6f2ivQwXrBLW6NMwDliHhTmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2375
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder flexspi clock-names entry to make it compliant with bindings.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 16ea50089567..4dac4da38f4c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -898,7 +898,7 @@ flexspi: spi@30bb0000 {
 				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MN_CLK_QSPI_ROOT>,
 					 <&clk IMX8MN_CLK_QSPI_ROOT>;
-				clock-names = "fspi", "fspi_en";
+				clock-names = "fspi_en", "fspi";
 				status = "disabled";
 			};
 
-- 
2.25.1

