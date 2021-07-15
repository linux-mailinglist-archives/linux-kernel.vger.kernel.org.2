Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2944F3CA048
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbhGOOKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:10:44 -0400
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:8580
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238423AbhGOOKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:10:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvzETUEG4LiZecCLrl7TYqg1Enn0YVEFiHZmlFK9qFVyoCwjAq2susGR+GCQMIMmz4jvjUD1Q7NlpYZ4UsG1/BbUO28s7S3IZD2SYObYtjyY9UHuo8K074JGH8Aa7Su54M4zsXoMBDuCJskAQPploe3Fv/h8GnqLMXkrRFooLhfmD6W9fp2+rPrmvuFF0ae78by+mZ4DOxh6b1/j+klEMJtPgRm08xfaNqaN+smZVXYf84ZIG2nTGSRrhPy+dVwCca2eCyYdI+whln2mQpmslMZR8caXVeWchEXlk/0ACQrKJfqq7l+TNOpZ4thdHB4/O51vzFN0OxJGflTxM1mX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycrY1OOO7TPTVvJmcQ9+8HNVFN6X0VCsxk+lSFy1Mqc=;
 b=SaIbRS0/EdQTLASNA0k85qHVTzIm3rrgxinIjp9hUq4oM3agW68k7PFLwU0k0tbpsIt5UEFq98jdP08YVn26ByUxY963uuUSfDZC5lgYQse5UpmAmdHtYiBzXqbxUOZ6r/e/OyHT4DE/dgJEThGc9waHxgB2K9qql5vlXHBddWqC0tlY8xSfmmvetzC+hawBgNZ4r6G23e9eB0hTALXuL9cdDtqjtrmRmY4VMlO8UA8C1tgPMx5T8JnqQK4/Sxi3rRSAEwsViAjdDq6Im+MrJJdvv6dJ+3Z2ql8zJVMG2rEUpt8xaBZusffoFCOZxQ9HsvieudHExXEE3V4MFLwdSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycrY1OOO7TPTVvJmcQ9+8HNVFN6X0VCsxk+lSFy1Mqc=;
 b=IvNSZTlg1n9eR59+cJ8NDoRgmU7nPDX/OYHv6NGrRTsxQlSNsKNKhVxBTSkXH0lVwkq+dd6SL0W41DNl8MQLSsb+RQCiy3Pt72rlCXXK1qUloGmekem4yioxMlixGYW8WEgR5y42j4fwppNGkSR8iVctM8hTbST/B6imQwtBjHI=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB6813.eurprd04.prod.outlook.com (2603:10a6:803:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 15 Jul
 2021 14:07:32 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 14:07:32 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     diana.craciun@nxp.com, ioana.ciornei@nxp.com, jon@solid-run.com,
        leoyang.li@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 6/8] bus: fsl-mc: pause the MC firmware when unloading
Date:   Thu, 15 Jul 2021 17:07:16 +0300
Message-Id: <20210715140718.8513-6-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::11) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM4PR0101CA0043.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24 via Frontend Transport; Thu, 15 Jul 2021 14:07:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d35e053-fec8-4d4f-86aa-08d94799e383
X-MS-TrafficTypeDiagnostic: VI1PR04MB6813:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB68133FBB0D3797C8A7DCBC13EC129@VI1PR04MB6813.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VcaFmfKCldVYmtL69YVfXOw64gEJT1jWl7PxpUHAaCbzoZVR9KBW63oBnP6ma8a+NCwEp4JZgAU2Vr9MMAnybAFPjeLwg6fIDApx7a34JIVG7HxzjI+0lpVm/cbYbmdpya/+2IYuE2EYd2z4u6K4mhap9/9bh/LcKGBi/qNdS7a/R+DDdDYWhH8oefdqW8wIVp/PWB/InJDqxti19VSYKrniFAeMRQ22F9EloBb34akwG+rpr6sMG9ZKswTy3RChrGW1ADrWsTTdRMcG4aOyc4WT6ZYkfcRDAPyD4JokasL+D43VgFs34Zh6t4rPuXW+OtNwQdHZX8eK23BS3BgN/vUCaFpQKgxBYBCJ/3C+ENQGM6MXURXCgJhTB25GJpdchJfJuloqpx3kXg5+JT9nObz2RgZjlrV0NZetLqukh65ouSUSvqLAfTpUSggvad/1PKdQagLxIvr4rGfZvNcGpQg/IZ4S2PRiS8TEXFPEGLAdlVi8LVA4UUq6X0Wbmhgb8SfdU1b+p+oOBoHOEHMvSVBRb7O+m8nsLalkWUof52dXPZK1xEu6F2akv93arJ+U8FIlMnxkUXZ8dv7mHtxUo1KuSgtrKKReQGbsjOBjPZ9B4V5s6bRiO93NaiOGKdcrJCLodXt2kl/Vtf7YOMfbrohtrMpMdFd+t6w4kh3KGT0i6mGB4ce0cVnpFPe7QedbJIY7JrpEMKfKya4mxAE1rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(8676002)(6512007)(6486002)(478600001)(36756003)(2616005)(316002)(38350700002)(4326008)(38100700002)(956004)(8936002)(52116002)(9686003)(1076003)(5660300002)(6666004)(26005)(86362001)(4744005)(2906002)(66556008)(66946007)(66476007)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rClACnadxn5XgqnonHNKMf8LDWzzDYXrYeG4+A59hyodlYZ0t2WYX5Yumgxj?=
 =?us-ascii?Q?yCB1VopPyXR1T1jCZeYZAGKS92M9KD/Ox7to+6hhcuSnEa1KN/l3Y3u4hq5m?=
 =?us-ascii?Q?STz6uFaYQ9vxh95699Im9k+2Uk1+OX43UGq+rmQbSvfkzTKNlmO1iQgSUxU4?=
 =?us-ascii?Q?OWH+QwXqddFIjrtvY4K7bjEXzB1y6sTWP8LKnR9O/+IlV7E9DdXE3FuLl5PO?=
 =?us-ascii?Q?ydWYtCcSfZcWVx2VqEIKa/4zu3ijmiHOJgQ1Z1o0dqp8w7XMljvQzPdGtS4n?=
 =?us-ascii?Q?5ruvevlQ8TodEddUkeTeaTqvGklmPulMMsbhWH1AOu8qL9kIGLbFX/tRMXOt?=
 =?us-ascii?Q?L0PWIaE5g//h3YUMUjzphL2D1j+Y7RzSqgjVArdDEq9WubYjBEPeKSgNG03N?=
 =?us-ascii?Q?/lCbS/prfG0oylT0Tijc8fORep6bJtyqeK5nMtyIdIv8cEOySIN7gD6bk0NU?=
 =?us-ascii?Q?4ybpr64uXLm4J9HDHZLhq1dKXJs+I15RuYeVAnPVDHznJoFLoecaprD6y5/M?=
 =?us-ascii?Q?gvZVatMeIDeOqVpcRQDBc90e22jyTyIUB4+FSW81JJ9pK/Fg247gwUUUs9vz?=
 =?us-ascii?Q?XlXm/66lrDxeQ+5tUU2zzTvJk8Hi2+TeZr5iXW2X4oDMEmHgKWJfM5veUWcp?=
 =?us-ascii?Q?d3PvPvSI+zSZWy+RdpfG5T7s8vUvxLMLck6GUcGBriKEyL4zmS6WmxiCXkaj?=
 =?us-ascii?Q?9J9uqmsXXJ66mvRACfH/EEvtfZkTPqLZNEyWhkrQ2Xjn/fLWYWKSXGgCtBZZ?=
 =?us-ascii?Q?nwqpJrNHIxHSk4qlYp9UGxi3cELcnK2shGMom4dkQqNZFV4XbbsW9I/kbNhR?=
 =?us-ascii?Q?T83Zn3jEy3m2qcXRl46zLh2l3hlSj4LQcn7OFJjtTvVKYWu/PGSsHsa0b9E8?=
 =?us-ascii?Q?5JLfD4O3L+w/8TsrGPA1G6b+q8PCYyTz789V9FaUfagDnERmiqjOCpVUW/y0?=
 =?us-ascii?Q?mAc35bivtwK5h7KrDyZ6hypC29KkQSogC4XzHYjEcndmO6bPs7tjwYJZwI6i?=
 =?us-ascii?Q?x0DifqSCSnESnzTuUfwtPKD0MfzdcPbVG5iWCsZAGlITfZdRswXWTk41/Zda?=
 =?us-ascii?Q?E6V4r7Nw5QAnUCkfzWA1jUz96stflXzi9R15FjopgfcpIuMydGN6kV3fgN88?=
 =?us-ascii?Q?cYLGejCJJh/a6XVgLeEXer2H1NmBt2ERVhVwpjWmUjj25Cjh9Sn/PILjSsUP?=
 =?us-ascii?Q?UbxZIdvbTL2Aa8ooGqG2B9ygkX/j7STTK6nypqjo0yuKKuzcXU8gXZnhNlI0?=
 =?us-ascii?Q?yJ62ED14DoQIkGeILT6/DHsKtF3aDYpZOTZ5OeS2Eqry+/Mrw6C7Eq6dgpeK?=
 =?us-ascii?Q?O4yveeam2Y3uya2FrYkg1UXf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d35e053-fec8-4d4f-86aa-08d94799e383
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 14:07:32.4560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G70RGWNSxNrhhfttItq26Dk4qi/XcnPdRXVEVAYZUNGkyoCPs2oSzNwEXfy9p4QerUSPOdr6u93woaCgoMPjiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6813
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Pause the MC firmware when unloading the driver so that it doesn't
crash in certain scenarios, such as kexec.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 41861ca5c8f1..e5b4830cf3c5 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1207,6 +1207,16 @@ static int fsl_mc_bus_remove(struct platform_device *pdev)
 
 	bus_unregister_notifier(&fsl_mc_bus_type, &fsl_mc_nb);
 
+	if (mc->fsl_mc_regs) {
+		/*
+		 * Pause the MC firmware so that it doesn't crash in certain
+		 * scenarios, such as kexec.
+		 */
+		writel(readl(mc->fsl_mc_regs + FSL_MC_GCR1) |
+		       (GCR1_P1_STOP | GCR1_P2_STOP),
+		       mc->fsl_mc_regs + FSL_MC_GCR1);
+	}
+
 	return 0;
 }
 
-- 
2.17.1

