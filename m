Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8A83C8459
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 14:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbhGNMQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 08:16:03 -0400
Received: from mail-am6eur05on2065.outbound.protection.outlook.com ([40.107.22.65]:1249
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239340AbhGNMQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:16:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXJ68Jd4+EobzaTGt19lRU82k1BX333VMoXcIvF3ynPHtWXqSR35Zl8GA2OodYU4SSxCuxqRq3O+zXlbh4eIKgxaa3Wb++bAqkZLYcTvei+IUAz1BR2jJfjV74ya+kLYq/7XeGLqE1Kz9+zUSs9ir9gjhAcpmkQ2umxk3LvY1Vv+LWk7p5ysp8wLLXysnWw7XwiF1YqteuolVcGQOtDCqlHqzxDEMsZLzYy4ijwIGFPXiFFi2HIRTDvLBZM2KIAIoKA7PS+SPBI9AYysd7q2Je/R01oLJT3lJbzACNyAdewawfSL/2Kdj9bDwQnXkFluP9CffxYnlp7Q0inDktpw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCkgUAN8OFPnMtfsjxf83Tg+ZzJugmgzdu7vGxwyTx8=;
 b=UaszzaSwGupt5Ly+w4w/40fkEPIRvkCi53U4PhdJHdBqhHx8m5Bopkc5pDRDhWRI/CGB5ycMCOxwoxqhzYnkonPiGFhK3k0DhEYNW4ZLahloHVie8H5RfjuzpWFcqgTyHk4KKWB76ulErrVMMs/uS6NGuHUQi9inFTo5xFLIM+y5VsH/OjaUL/h7gVrfWrXPNPfnC11zzLAeZOciNeJ0wqk4uf6iucgo98ronc0VxOD8cmGBYhtGD+JcCJHvRE5lH3k8bMnGJiSZRw1C2+lrCCBv5odb0aG1Ds92Y0yBpuOp6ps0+ngYobKK94HQI1x8duCMUP21rfNdWEjtMvsblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCkgUAN8OFPnMtfsjxf83Tg+ZzJugmgzdu7vGxwyTx8=;
 b=WouCyeGlO1mnpKy09aICcwORWtgd+0/qG0VYs5flJyhYPeINta5RA5Eu4xis+B8PgyEXVV2J8fyZbXGK56Jl8Ekk77Sh/vtKmbCcwi1wkNS4uEhq11hwkWn/FK7Jb6oJMEKFUkCQg+KbC472a8E4O4qrL8yMlMUEB0YmJv3ed/g=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=kococonnector.com;
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com (2603:10a6:20b:281::9)
 by AM4PR0902MB1748.eurprd09.prod.outlook.com (2603:10a6:200:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 12:13:09 +0000
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5]) by AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5%6]) with mapi id 15.20.4331.022; Wed, 14 Jul 2021
 12:13:09 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, aisheng.dong@nxp.com,
        fabio.estevam@nxp.com,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: imx8: added usbotg3 node to imx8qm-ss-conn.dtsi
Date:   Wed, 14 Jul 2021 14:09:21 +0200
Message-Id: <20210714120925.23571-6-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714120925.23571-1-oliver.graute@kococonnector.com>
References: <20210714120925.23571-1-oliver.graute@kococonnector.com>
X-Patchwork-Bot: notify
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0114.eurprd04.prod.outlook.com
 (2603:10a6:208:55::19) To AM9PR09MB4884.eurprd09.prod.outlook.com
 (2603:10a6:20b:281::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2.207.138.2) by AM0PR04CA0114.eurprd04.prod.outlook.com (2603:10a6:208:55::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 12:13:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aaaba0c-11bb-4578-c5df-08d946c0be62
X-MS-TrafficTypeDiagnostic: AM4PR0902MB1748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0902MB1748F3B59C5FC54FC1434CF5EB139@AM4PR0902MB1748.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14C1Koo9YJk7yUiVnIPd6Fqixh35LiE79lSNjF2Bsx80uHRSo6HqurfVkfcXiKgr1AoycTMf1zyc9iH14foafvc+/HQqpZtImlLHaPN+pSxrQ3qHWpt8fq3gcA89RZk2AtO0g08huFcYTS8H0B6rjeHLAVb34cEfs0wHJ1If/7LwjJfGYF1itcZO3Tpiw3diaSRhgocnALO8cChAaqLTX5d+FUeyFs+DnkoQo4cF5dtB3g1wEoYiuIz4xzFQ8Tlq9XGK5NxBCBs0h0heL7RDYR2qS61jleJnB+xjYykNeotxe6MMvc9+XrQxHHwFiKqDCrR6wWqnnJ/2we++5Izkc4jhNGziDuWtD55V9doqQFIYoaL5BOakcfwGyxeuY0RGSZgGDpgQnHWrmAZhKMC381gLu+SzeqvNkn5K9//SCJzAFmPSXxEwm6aqE5LU2CHAzBQK/6N67TMcjO5S5oJl84VDKnyhmUzI/CnQnqDfDdRLxmp0LvOq1NdAjDFiTKEVJ21S2o+zBt3QSYMCdprfApYxFx1ys79o1aJUqzmsx0WGDtHbhXIA5/wLcSGnq+m68Rl02RaZaQFVtMpUOCkyIeskchWVmhFfKMub+qmPaSSZNr/YX4Rj+67X3gMVGz8tfo0H6BFyVeEeMiQPIdWdo+rSFpfeoQh2Dx0YqlR+yjeIvqDY925sdW/qa99Qi7j4Z+tmV27oZYBNs85RWM15ZAEy8gA3bZKmqHhs5+A9KfA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4884.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(39830400003)(136003)(376002)(7416002)(1076003)(316002)(4744005)(6486002)(8676002)(54906003)(86362001)(38100700002)(478600001)(6666004)(956004)(6916009)(36756003)(38350700002)(6496006)(26005)(52116002)(4326008)(8936002)(66476007)(186003)(5660300002)(66556008)(44832011)(66946007)(2906002)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Z6vlxVKKdvNjdDB1mIPkmeNpVxXgHdOMmcn1HnBR3J1RxsUeTZrydQznrSW?=
 =?us-ascii?Q?H8rPoGdapFLpAWNfwwlIRddMXHOmsTCG6CFX08N/hP8B8eLZgQrYacGB0Luv?=
 =?us-ascii?Q?IjWyLew7qjy9Sl/Q58hzDGPnmXxvCE5c0GRti8Wv/Y5L1087oAnx56zl6AeY?=
 =?us-ascii?Q?F4MNzCod1jrXHbbP+36EVY1EZWTAR7bLQ2MeLWY8OPW784Ag3xDFPMhc7ujA?=
 =?us-ascii?Q?kfwIn9daPiKLjv37oiynYq6fV54bOplDA8HKko3L2q7FCOJLddzgLm+Li2nR?=
 =?us-ascii?Q?Vy5pKbCTejGzbNfRDTwappd46VlEs2lFJ0q2HCf2Ye1cUXxiDLv6rZKuJSxm?=
 =?us-ascii?Q?ZmaKHImEfiRcqBFe5oE7m8pjG+bDKtklFJYUcFzlIhyG5I/hPqnnHiUosQ+T?=
 =?us-ascii?Q?cwvMngFxFLp/v5kDY12wlmKGxzE06U2fFDKzZZiONk5ngDBKQ0zkwiky+4p+?=
 =?us-ascii?Q?ErSeQzMnrotcefu46eWXkcQI826dA2gl3VmxDlAPKgXgskA2HfnblzU86XT+?=
 =?us-ascii?Q?Q8TgLRFEIkOtnwweCKtU30fMurNxMFrysFVlH5cWDiNcV0kZ4lTYHM2HH14u?=
 =?us-ascii?Q?j86AzpX600Dt3B8kIjUm89L5IEccEHhJZt3s/14Ku4s7pkQak/xdbkMM2tGj?=
 =?us-ascii?Q?n6bBimBDwvDvqZ0vYBbfH52mWyyZQfaT8BDMXy8/h+m4ZiZC+Z8+gEzeGhT6?=
 =?us-ascii?Q?QvHNfK8NgYBYIFSLcf+tHx7/bTE0akn7tDGa4wtexEIBplJqNhGJ4+cn46LY?=
 =?us-ascii?Q?8TJYFpj/YHODQpV+DdE1lPnbjIS661gndk4UpC6lt0VVJXfC63b/FE9ty0AZ?=
 =?us-ascii?Q?h37D9+OWMm8DpQtR0+cQ0pm4Wcy/iPVsmE8y5pJH2bqLFaqaGG5aItoMIaCS?=
 =?us-ascii?Q?1HFDEwf+3b7+y/qwWkGVtW1X0ns3wvnEp5RQyyaaDq+UJku6j/2Q8TO5drHU?=
 =?us-ascii?Q?8INOEOW/sUYXoi0GHtR8Z4LPrZSEpDyMIEBJUx5ommTg3kJMHLy3BObgdfYq?=
 =?us-ascii?Q?kW0YUk5HkYvFnFRbO2Y66l5xkEpTELmxIf+9xosfXxm4KRIzw+x90aPfE695?=
 =?us-ascii?Q?ajULs6kJ72GF7y4Ls2d9Lj8sFLcnO7iC4HfHxhEyIn/Y5sj4FlH9B1Z8h01r?=
 =?us-ascii?Q?LDzNPD/EvxeI1RmvrZEHWR3MwJUN1BbaSOoWa98x000HDgxaJwGJBqLexi0N?=
 =?us-ascii?Q?MM9sRpPN6zvmKt9uRp728XNIoGp4LOo1NHKMsm7ZCXQ0KOmnyuAi9IOfJp14?=
 =?us-ascii?Q?r8Fc3Xwn4eVCSUlER6f7yufs/p5iKFjTk0iKA56z78vgskJCjQgtiuZ33Zqv?=
 =?us-ascii?Q?QirkvZ2lwiz7FS1C0lGZO87u?=
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaaba0c-11bb-4578-c5df-08d946c0be62
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4884.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 12:13:09.2410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xhvt919ujvbYkZmEMuMIcvYRarJbIIQwnuznOWkBgCCcjAHqmOSzaeaKas1LtZA03KjbQDKarrZDpaP13mNs2Qe8Xp4oDRV8mx95F9lAlok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0902MB1748
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set iommus for usbotg3

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
index 8c33edf0744f..3737dbb49e77 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
@@ -23,3 +23,7 @@
 &usdhc3 {
 	compatible = "fsl,imx8qm-usdhc", "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
 };
+
+&usbotg3 {
+	iommus = <&smmu 0x4 0x7f80>;
+};
-- 
2.17.1

