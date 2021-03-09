Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D6E3323C4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhCILPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:15:05 -0500
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:27232
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229837AbhCILOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:14:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iguCun5PvHe7cm1w/r/mPA18Uctpc7vcwQvjYmXyNTkla8Df8FAGtdKtdQZw48mq8N4ibF1BipxvZ6m7K1UvUsh5t09i0Rtgi6H3NEpWUPDWgh9/8SuC+alqRy6B/PqYpJz7n4A8DnRLvjwY+sLqpeFV4yBCh+UIp+l+/al3EEE5FsbziQGeKRhTY9udSwZJREsS3XsWUnANoycywzTB0dCqIjJFsu6HQt2acdpM62WrvBCCXMJ9Kqb9YyRPEXR2dbhSLQSoV96ZV3FMCiUfJDGFuVdTYTm5cklLYj/Fx8jWzQy5T699aMwATH6My6BHzyEecIuqI+hb/lV/cGjDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdaRGsdTWyc19VONQNgxyd5+BtXmmo2d3px5No3fYaw=;
 b=e3Iaikqpe5Wyn0jK2K2j3tpxiH4UugqJxbihOPNGbWEU41tUXT32ikXTJFLyUbb1eA/I4Hb599kyEmfCeELfT4JivvezMGjJgpC6ZDPX2CSuUlqpPfU5iUcAZIVDnyAJ4nqLFMY6dj66Wgp510x6/gdu5c2+lVP3GjRCbxNZO2pPhfqJrGGAHUKLSnPdipKyinI/+GVVn/v57A4G89mNDTuqGs7uSLykbDk5SxcjzpkavdOCk3AIrmY/VLjOLXaO93rgpv5X2IsM4LLwXoig6/D8IQqUAiP0wfrOoVXK6VLo6pf4VjGtTS7vnxK937DFPEIqAFveh94hm1HRHuLqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdaRGsdTWyc19VONQNgxyd5+BtXmmo2d3px5No3fYaw=;
 b=onHw5hVjmqSxlKTQzde0zXiY+VJU6rvCp/MIqQWgLy2oaGWUqzdXsm4rQ+IwQC3Fvag8cjdvol90gIq7Pj8murZKtsOeMiIazbBJF1LKIH1nfKRZiEg2Jqv2iM0LcD6P1eyizA10T+ly+V1kzmFC+wIyyG4vkkgpNWotR44RoDo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB6PR0401MB2375.eurprd04.prod.outlook.com (2603:10a6:4:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Tue, 9 Mar
 2021 11:14:51 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.037; Tue, 9 Mar 2021
 11:14:51 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH 1/2] arm64: dts: imx8mm: Reorder flexspi clock-names entry
Date:   Tue,  9 Mar 2021 16:44:24 +0530
Message-Id: <20210309111425.3539755-2-kuldeep.singh@nxp.com>
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
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by HK2PR03CA0044.apcprd03.prod.outlook.com (2603:1096:202:17::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend Transport; Tue, 9 Mar 2021 11:14:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ca0d8fe2-aa1e-408a-f883-08d8e2ec8efc
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2375:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB23755AC0B2A5991AA39C3F05E0929@DB6PR0401MB2375.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xyUrSmD/Hzf8oBhVgJBHRCxRRssZMPzsm8MwzZiP2Ikbr66UH3M+VT3DPPzUGA3wgYWsj0ByxaF/A5122ccLibaTCTdNjOnmcJX57SNTJzkxG0sytUt833WKkjbbz8crsQEnFo4sQTHqnJwME0W82jqFcUezWdDzHTsk5CrzKRde45q3KkT+xlXFbi0I0rwcVHucFOM6+T6f0r+g4KID0sNqrG9iZfU4DjElkGSJfBa/JgVIKJHzdrkc/LclNGCvoMqfDjztASpjYk8MAkRRqOtFkCwO4OTOLcH5tfve67jR7gm6kvjAN3aLZj2n3boX2/+KJaF+jBc2HnDpeSARss/Ynp5Kiw9twMDrBQSm2bhql4WdINSftjykApAeDrtv2CwZ012QD/LeIA212riYgGpMlpGy2U2fkX9XdEgcvUO25OtMYU7xJLGiaRAdaf58gzpI6OC8Wt9usN6US0x7E5P4Ngzw9XF5myYrN1qms+V1JJG4SIrekVNEYW2pJy6HWK4mFgHxjIJn0l4YmxZCXQ0HLTrqwks+Lv009qCkI7YpPmNspmkCei1sfeWRwlwIfmg/LxRsQJUlZsH+7tuXFkaf7p9rAPVoHPTN08lUIXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(54906003)(26005)(1076003)(7696005)(2906002)(5660300002)(4326008)(478600001)(44832011)(52116002)(36756003)(4744005)(186003)(8676002)(2616005)(16526019)(6666004)(6486002)(956004)(66556008)(66476007)(83380400001)(66946007)(316002)(55236004)(1006002)(86362001)(8936002)(110426009)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NT1HIunqBnbS5geHpZrk/LxxR1eOW6YmMq99e7jxAeKwFinmHQm+fXBBBrDo?=
 =?us-ascii?Q?12g86ySmWyJQcFRvEJqnx4J95OcHt2emYKo8bGXr0Nw3rVb8c/kBCC1iDbt7?=
 =?us-ascii?Q?VJ0Cb95LRUtLNuzFV4AUOLiKIE8XdaeIcxewDFqyyfbyTNYyA7C7KxColpU4?=
 =?us-ascii?Q?SN47mM8IAc2BZO0aiOlv/NiyPHCTvsSP1kNDouj1kjpXEr8A6ITvzK/Wkdy1?=
 =?us-ascii?Q?3EPj8RodnlDBnPTdyxSdUB5dtDngGyN7DnFqDXmyEEM3Zf04DnTRPf/O3HSI?=
 =?us-ascii?Q?oQyHByDGlXv4wL/ksEnvnc9u9zl+LM4XjIPkJygy56rgfhOzx+Hnz+O5OD3g?=
 =?us-ascii?Q?lzByk9/ajmANr6bSCz5Pne4G71VxKgCQNyII8AlMVQKe2it9pz32amx0OhJQ?=
 =?us-ascii?Q?KoTvECRqlKrDWQ4/HESlAtgYYBOs3Np2R3Opplmj9vAERiGQFF1EfYkeLOWb?=
 =?us-ascii?Q?YcJ7qF+vVvWLoFEdjrDLtIpswUu6Lghd3fkR81K5K0T+u1d8tYDinDKXwxZD?=
 =?us-ascii?Q?LCZKd2cymXq4QcTVvhVO4QY1Ldl+c/So9CodJoUGD/BI2DRL3WYLHfhlJI+h?=
 =?us-ascii?Q?cjHpaMJfDLSVNaUtGyyD0/kZGdGjajNeB175KwGyhAH/ajwh3dlOsBJyoke8?=
 =?us-ascii?Q?SVM7gUgNMGftJU9jQZ2IEW5fJhVFi1xtrBwqVHBZNXMpKIgTFHjMu0xUMlLf?=
 =?us-ascii?Q?0CXUNpBS7XtLKUvdRGvZwz2cTNYIFpOZMHsp+rnDdzYUmk3F7N1TAGuY/Bj2?=
 =?us-ascii?Q?rMQU38c/YpHkqjjga5MauXmA41kPnvyag7QYuYt/yW0cE/B6V/oF3APAcl9Y?=
 =?us-ascii?Q?q5Pk/26xys8wmku0xYFjLK5I/P3YBlNQXng0Hie7wPgYym5UqdOVRlB1U91i?=
 =?us-ascii?Q?VVdlBl2vta1p/4lDDN+z/t2g++MgeiCw/YtnltNZ84i+ly/20BKjFTPCePZT?=
 =?us-ascii?Q?uBZjvCnG5CveZeGRdQNOOhqg+zTBVuZ/XEsSaZLjvbh8C9Auucskq42Suqgf?=
 =?us-ascii?Q?ydb5FLcnB6jwIcsJVMdhFnTZGb4NdjBxeTVW5k4Vz4K9j8WmVPNrfnBmlon2?=
 =?us-ascii?Q?RqeLZnTDDOxuZt/S/oOkhD/ro9/F6TbaOq7dxTI62L6Y/Ss4GB+6uG3eOgcd?=
 =?us-ascii?Q?BlTeS/WwAfjDLxdSGTQqTTKGovgiLvA4FVwFWqy5XWsSQ2huygpeIdGkmFKN?=
 =?us-ascii?Q?McUA43wsS0G9Tgf45CeClXKuwuf4SCrzzJAO2+phk2gY5mVO26eNfOibO60S?=
 =?us-ascii?Q?ouD9PkrOCprzsyfwH9pOeFAuKOOLDTy7SMWV78V5+4gEFbMKFt5Mnh3CFWpI?=
 =?us-ascii?Q?9fUArI+NfEXWL51bRebnRxf/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0d8fe2-aa1e-408a-f883-08d8e2ec8efc
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 11:14:51.5636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DP2sE/DI65z/djkT4B+OOozR3OcoG7uJIwZcqDod/Z0BYaoX2OyuxfJcfQk0mrfd7M7jIhWWNUhTavrZJnaGfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2375
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder flexspi clock-names entry to make it compliant with bindings.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 6bf1d15ba16a..a27e02bee6b4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -887,7 +887,7 @@ flexspi: spi@30bb0000 {
 				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_QSPI_ROOT>,
 					 <&clk IMX8MM_CLK_QSPI_ROOT>;
-				clock-names = "fspi", "fspi_en";
+				clock-names = "fspi_en", "fspi";
 				status = "disabled";
 			};
 
-- 
2.25.1

