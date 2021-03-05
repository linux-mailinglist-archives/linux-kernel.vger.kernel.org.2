Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1F532E3BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 09:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCEIez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 03:34:55 -0500
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:50147
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229497AbhCEIe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:34:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R44kC5duUcQdhGj7NfVRq1Hh2ofuflBw6MOGtGd+XaIU8lzv/hhAk3G9ED4MheXpp/jZ9tL0Qriay1dPTOjRSGeUcdm2AeHPicKmXzMl6XbAWLdGtSos88ek2yxd+BSLfXOf4PrhcjLNOCbkWj2S+aSr9g0D92YJOKZmSqsGjaTq2l6p0fvZB8ezjiUy9w+IVo49OnUB+3ZbZenCGDNnlNwAiWz0S3kfMAid3if4INo6jwFX0S6BvA3uoQ94BGOTsF73pimJOGZvq+hU9XDEat9NgT8jo8uqtAqIcp/Ew6/eA7pNVA+6hK5gHlImrCvzsLX5aCD6yHONG7vn398Krg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCSedFIDIkHRsWQfpwuBI4tP/8nDYr+XIFOwWgteIrc=;
 b=j0wE0JAVdsf7eWWV8jOrZGVkL2rlDGYHJGFGKO/yxUCZZOMsLOjqpsvK3/OAs3OMT7KxWv3s6+rK0GTuAyi6d3duEwrDB0Vmp/puTfqEnwKIG6Lix8k1In4e6tRdrzgNQT/DWqN2NrtvoTi7USN64rVu7J+2q3MjoQ2HtPx8DbeQayAZFUlxQLEObg678pGe051f2p7cDerJ4MqL9t0yWPEZ5RFnXB5u2jkDkobG7Mwni24QRqlcI7r3apigDIUQ/fGTf5/q10DrDRP1w6L8yF4s5xQ/ovG2X+Y73XnNvaw8lxJzU7FxncwSIgC3K5Jj1xCe6X4m1WUa5aqPcS6bWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCSedFIDIkHRsWQfpwuBI4tP/8nDYr+XIFOwWgteIrc=;
 b=CYZ4FzyYBEEOile2rvsVb560jK96VvX+KXbiALJdh/WNjWYVGd/h4mJBE3WF4ZwqfDUWCx6gOacN/TuV7rqJ1Xr/9uvVL8a3xcEJ5tepd/mj0Ms015cDWLO+wiAQEYvCrti+L+EIrm1owKqFAswKrPOUKiqnOsqgHMz/1gDQOuQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB7PR04MB5322.eurprd04.prod.outlook.com (2603:10a6:10:1f::15)
 by DB8PR04MB6940.eurprd04.prod.outlook.com (2603:10a6:10:11a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 08:34:24 +0000
Received: from DB7PR04MB5322.eurprd04.prod.outlook.com
 ([fe80::7c4b:7e9d:a414:d34]) by DB7PR04MB5322.eurprd04.prod.outlook.com
 ([fe80::7c4b:7e9d:a414:d34%3]) with mapi id 15.20.3890.029; Fri, 5 Mar 2021
 08:34:24 +0000
From:   Sahil Malhotra <sahil.malhotra@oss.nxp.com>
To:     shawnguo@kernel.org
Cc:     sahil.malhotra@oss.nxp.com,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE
        LAYERSCAPE ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: ls1028a: enable optee node
Date:   Fri,  5 Mar 2021 14:03:51 +0530
Message-Id: <20210305083351.13598-1-sahil.malhotra@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: MA1PR0101CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::27) To DB7PR04MB5322.eurprd04.prod.outlook.com
 (2603:10a6:10:1f::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03303.swis.in-blr01.nxp.com (14.142.151.118) by MA1PR0101CA0041.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 08:34:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa6a1914-f1f4-4b37-2fb7-08d8dfb17abf
X-MS-TrafficTypeDiagnostic: DB8PR04MB6940:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6940B67C37FAC041EBFC201FC3969@DB8PR04MB6940.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3JltZBELjW9fao6g8pLiV2Ec1K6JgLe/t+vXZwOzN2WqMfGAlmkWXJbMdzEikB9MFvJ1cMIYKQJPZtRdU34TdF04I+3wUm4FSWMQGWz6TWN9DPiFSRDPiYeC4Etotqk1bxLnM8wGHJT7wDQv/PYg4MU+8W01GC+uYijZD+wPvV/lKgzugip97elyvgFrSJAomCJQbhPPIiDFjxIxnQbRIVyo9bBRqiq2XGpF0wKPAyXjBqcPkXcthljFVwl6l/5BboxwfMXKFGU6S78VB4CUO6DoWIELVeOYvI0oWP70F6pLVHvN3d/tHrPgh/yQINvlQhBApZkc26KtEjjL306UpZBjAcyVKeiwOg3cQ2bxvZU1zUi4LhOKOVGe7oXVRzwqkt2e0NynPaeliZVf4Pr+cpwO/nbQ1yoadVG52KtjfRP/Qv8PUgI/LTRBUpaOHByPpugLjdQrLg3Q/CsPAJ7Cokndl9QeSDkuYqN8Gwfm+4ZahlqXz//WChHfjVLWDd++FpF9rxdbDa6VOj3TmNFLSpye5kaTYAPkoxooX0vGn5hY73ITEHEDhaHLzuHsdlsvGN+hrABFTc1Ooa4otinyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5322.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(66556008)(86362001)(66946007)(83380400001)(5660300002)(54906003)(6506007)(4326008)(66476007)(6666004)(1006002)(4744005)(8936002)(2906002)(52116002)(6916009)(478600001)(55236004)(26005)(16526019)(2616005)(956004)(44832011)(6486002)(8676002)(1076003)(6512007)(186003)(316002)(110426009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AzutoYRCioaE5mXgUjnAqGsVR2bNLVOHb3djcQqFeviBzyyibZD7ks36HRD5?=
 =?us-ascii?Q?OB2N/kIP2VkEWb+YUWwZHwKpu0V3Ma37Iaj2iyndB8rFYOyoIM6FGfhfe0t2?=
 =?us-ascii?Q?q9NUETP6JqW0pkfTOUBAyvh8V2syljohxENmSuR4CA67EpZsCDiWc9sABLYT?=
 =?us-ascii?Q?HF5Hp4w2KtQTMGXYY7+XJm7OEUEsFh46Hhe1NlEeN6h+TFhVIqolH6u7OhJc?=
 =?us-ascii?Q?1aCSTeVPHkG0Y0hjJD0q3vzDk1tuqEUFMmdjOzX35od8fw8IrKl/UGdaF7UQ?=
 =?us-ascii?Q?M7gsaU8u/tdcAvkUdFI16DVt6UZKSjCOfG5/YxyxzALn4lPELdrcYiSY7wua?=
 =?us-ascii?Q?Piv/Btpgo51g9+KJdeBJIro6p1oGpLet1B3UrFQantqrZRNssWoEpeCZZn9e?=
 =?us-ascii?Q?5vrMexHj4FWUee3VwA0mbynDnpr4O/WXyDs6gZ5nW3L2XFdi4RrBSO4qYjJ1?=
 =?us-ascii?Q?vWbklOvvAtoOrWXkPPGq6etEn7a7HQdyrlf0rg/HbBR63by54z4qLuL+dKm/?=
 =?us-ascii?Q?x08X3Y5G2chQHdaTbvOqraohQvmEDXm/Ut0AvgUT/zKAvN1oJ7+xgK7BJ8fR?=
 =?us-ascii?Q?HF7ciBw29UCCiv+qvF1DfJtqlQbSFMoOVxlj4EIOrwyJF596tKL41o9IZOiw?=
 =?us-ascii?Q?ArXShVey6VwK498PkVcAk28Rq9jik0Rx29tp7iBfX/FUqQ3KwYAGpReHAXpp?=
 =?us-ascii?Q?wuxR/CZ5K6N/h4yI2PbEd192OacDf6vgEWxKJd5jzVN52rSkuwknBzGkK7al?=
 =?us-ascii?Q?LmMtYlfYU5y/gP97d8RSiK2MH6BbN/rpHeQ14+yAIDWVx0yL/QU6w8y8Vv1S?=
 =?us-ascii?Q?jHIzVTT7/TcTXWKrGp2ooEQBjypz4U2E9yt/lglvKjnYAYDds7oqcuEZM11G?=
 =?us-ascii?Q?ZBAPo6IhUKkiokAHb7R2oZLhVSqbhTdZcmVBMBtQX1jP/gFWlrT3lQNo6jkK?=
 =?us-ascii?Q?mFVBz9wwnnO4+0Csl6f+FFixGUdWJJPWGkuAZKn3GAQjFix5eR6W2QrtM9z+?=
 =?us-ascii?Q?PvXkHLNdftMSh93mwqTEZiFiNWYTt/uyMtCJSv/CCyw4sKgYf1yUdZUedHRp?=
 =?us-ascii?Q?QgTOvYdbBikyZ+241Goxt+Cy8VZIcri6ltEsfrIQJqs8WCcxFZY0qQA1v2dF?=
 =?us-ascii?Q?0Pwiy25onWfSxFPvN7q8wIxfy9CZPiMGYT+XoRPx8PppkUW9GMMS6XY7mY9p?=
 =?us-ascii?Q?bGvscEErq/7Y5olmKktBghemKReBuBRj+BacLxdgiJa6GmiLK/TfTb0ZGo/P?=
 =?us-ascii?Q?LU+W/5LteLBG0FDEhpx9zQuHkPYIxA9vEmP9IZfI2sgeD22pHC+xa9XoRe/b?=
 =?us-ascii?Q?plnriFcsGE4xx3pNWzL7CsNR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6a1914-f1f4-4b37-2fb7-08d8dfb17abf
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5322.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 08:34:24.8072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LA4VEdk1S1mQ0tTeN+jdLl2e6OXKlHuVhX+qMbZZ73loAFFPBeq05eQnOrSwyiJC5f+Nx1AF9G222vIiM8Nbgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6940
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sahil Malhotra <sahil.malhotra@nxp.com>

optee node was disabled in ls1028a.dtsi, enabling it by default.

Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 262fbad8f0ec..762fbccaf586 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -95,7 +95,6 @@
 		optee {
 			compatible = "linaro,optee-tz";
 			method = "smc";
-			status = "disabled";
 		};
 	};
 
-- 
2.17.1

