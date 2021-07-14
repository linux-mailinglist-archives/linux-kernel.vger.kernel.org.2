Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4BF3C844E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 14:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbhGNMPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 08:15:15 -0400
Received: from mail-vi1eur05on2087.outbound.protection.outlook.com ([40.107.21.87]:5728
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230492AbhGNMPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:15:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKOaKRcL583rznPimSuzMfaxKeYMGCqpfVnvs1uPJGkFt0TmeSY/vyVcVeQ+z6pJi8Wf4LbKfukRwpXn+9c3HxA5w5BZ+tMqiVwrqqVVpFg6lg8Vao5bya9XCXtts7UvUIYhY/SrKMvGbnp+PJUQB5VjFAne4+cVrWoppXI4N/6cxyQ4cj7mJG+9wjBYwjR4thcLx38S0GV5BWWR15AmBbaUrM56tv3SNAeGpgc36e2dwj0MZx4lwcFyolIMfG90rtq6G7CnqBcwpzXsdvc4uiTtX538UIoAh2w4kWBzABf6p1K0cFFmeMZvhrnNZLn+xRcVMMCRiBKQjLZKNkWFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egPTD6dVq3rStzhk+ouh9WWtfcIaWQVfu19UjR5XfOE=;
 b=ZfMteKMvXw4DEg6+OJTT+5119TuLsGcJowHz1VZhUcI+s2RtRqLNa4eLZqMl40ZBJMiZbooM7h66wtu+dAYPBr76h2AQf62uom1TGhsKCq08ZfZ48Q8HvrBpjtngUbSP/F7CsKV7vqt3z8fY3YOb/5iZDOxkMB+E4nlTfq0+JKwO15fvrEDnS6rvEmauXwSKYD/zTraJ7XfdT0ibldF6kJvKsCTvztJP1XneYFC/T2nMf3YuhIozKSZxlo4qxIHhh+Ad3XYCy272N5PNyiGTG5hZNTmeGVrDBrXhDexX8rlreqw9r6GWJzwkq7XLxQUG+gSxUuqUvtcuR0wjf8J/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egPTD6dVq3rStzhk+ouh9WWtfcIaWQVfu19UjR5XfOE=;
 b=XII/pmPueD5lhxeQywkDwBkQahrU9d7v6niOo4xqQFLitTB+D1DGpy6utQdRPNEvoWiEM8GMFgH2re5UO4+JdkeQnyjOphC5SFf8OA76CeOFdc2+e+x72n/YEjkakexb5rDtm1z7RZv9imkR2/Lo/rWmU/JBZ0/NZ+wkAYvgJYA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=kococonnector.com;
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com (2603:10a6:20b:281::9)
 by AM4PR0902MB1748.eurprd09.prod.outlook.com (2603:10a6:200:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 12:12:20 +0000
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5]) by AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5%6]) with mapi id 15.20.4331.022; Wed, 14 Jul 2021
 12:12:19 +0000
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
Subject: [PATCH v2] arm64: dts: imx8qm: add compatible string for usdhc3
Date:   Wed, 14 Jul 2021 14:09:16 +0200
Message-Id: <20210714120925.23571-1-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
X-Patchwork-Bot: notify
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0140.eurprd05.prod.outlook.com
 (2603:10a6:207:3::18) To AM9PR09MB4884.eurprd09.prod.outlook.com
 (2603:10a6:20b:281::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2.207.138.2) by AM3PR05CA0140.eurprd05.prod.outlook.com (2603:10a6:207:3::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 14 Jul 2021 12:12:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9900fada-8ed8-45c7-01da-08d946c0a0c6
X-MS-TrafficTypeDiagnostic: AM4PR0902MB1748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0902MB17487CF4BA2E13017A902354EB139@AM4PR0902MB1748.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1BePl+bDiYYyYQwJgxESy+5a8wm2PCcKJarhihS0bPFdln7tI99K3fyBaE7Gxg5/KVLvlUp1DzrWz6GxnyA7NFcQyNczS1IdQucW3JkIaF6Y6rRvxoNtyn9w+EogAqLJ2wA/qrraP7SiTXlijojG4fP5h0hM4TrRSFsuOTVFWk6hoHVwC9sNa6NiecBF1DsgGDstscgkSIMiTPAD3zXrhPt8rd62SSqIYEESmrKZsLge3jstRTGGoNnSkNnUBsD5VQMi0cPYKGoC4FqoT2Su3Ra8NidIJLnS5Pv7LCW7NiNMjAq1GBda76Us29C6OT3mx8NKabB5CBZoh55dbDoqqnsyxVCiS4vq0U0EFF37wfunw7p80XeNmjFoofaArUB+7E5GcMjFO76KoaoHOaw5T70LN8pPY2+JfuxQq1IHNKLAnATUkMemxCXKC2VOS7NSAsvYrF2CyDhbKzwEmxrYcdxMfnJ57V/DU5mjGmiPVC2UJJgmhCOTefmtA/XtHQUHrNS12614MRCuaD5WZYt1zDJGLFA/5xvBJcCILVAjP4h8kwldePmlbeOSM6QzsqmEbOqIm1tOIvA/tq61Ha6HbqHvLwR+iRR86e+j8PSUb/J2cz3NvkXra0UwrPiUNEDALTj04qhuDzzOTEhQwDOwTBb/p09kAfnjlC762AkhyarQlyP6iltTfBW2tWO7duBvWtbs9lT7iXV0fhFCvL7QC3puHIOAQ1ek5RJM7hzcu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4884.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(39830400003)(136003)(376002)(7416002)(1076003)(316002)(4744005)(6486002)(8676002)(54906003)(86362001)(38100700002)(478600001)(6666004)(956004)(6916009)(36756003)(38350700002)(6496006)(26005)(52116002)(4326008)(8936002)(66476007)(186003)(5660300002)(66556008)(44832011)(66946007)(2906002)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wZLjoY5pzUR3WlTkNDL2RQ+KvK+aMEAdPYKnXgfhA+7If70PYeD7rb5mF2VW?=
 =?us-ascii?Q?uYj6yr6PQfCixmyOvF5/uDKF7HCMlc8fbf7mJitkxO48dcje8yi/e1o1URlB?=
 =?us-ascii?Q?zxUGs7i13bqLm0SQKq4hzPEcLYXcHwth87y1npsn6wuPFL7KWd+Ec7ncJ7Sj?=
 =?us-ascii?Q?YZmW8dxB6Q7kkMqttINT2Nm109g+eyatqMim1ZWUvSHl8HiigEDgRYGGMSM9?=
 =?us-ascii?Q?KPz7rh91CbnNhKpNtr73mx8xV7plylYeNnl5kNxumFERHpeBQ5DG8fal5eqZ?=
 =?us-ascii?Q?sC+8q33XOIQZGUYTNPUiZI7Mi+6nyk3vkySy+ZugcjNsbSJaSaQaD/3QaomR?=
 =?us-ascii?Q?5tRoQK0Wy8tC4sYzX2pX56Eq5hBY8piRW3G8FPXI+pVOYA4A0mNEubBjrJCb?=
 =?us-ascii?Q?LxJFA5Stxd5zIvXI6UeAef5FX3YAGsU7j73oV5M5r9zR7Okd+EbhNnehHgpX?=
 =?us-ascii?Q?Km4NQLpKJME6AP3Tsn705Gk5makXmuCsCZAB1Y07becEAQQ7LBQZeCGHufHE?=
 =?us-ascii?Q?07bTTzH/M6zrLXLA5dUyX59r4IWLAQUXSEHDrDoaGM5zLpgO9ylORk7hgUTF?=
 =?us-ascii?Q?6Jj6mdMY+7OtZJD7Tjj32DIh3PlJWg1/+XXKMK++ywLkt46EjCP5m5MOZgty?=
 =?us-ascii?Q?qIsuQRgKeFtl21mh+Qcxi8VdZmov0GFGfUbdsGrtNGe2ecty0u2F3QxxF8WC?=
 =?us-ascii?Q?2Of6OsO5FfSUiRkg72Y8Z8/CQJEGKDoMRA062F5pwvxYyt/qPZYQMkqJLSLs?=
 =?us-ascii?Q?TomzQG7b/VQb0L2whN0yHKyNNePwnHSEb8+KIDiS/GPnOca44fhIiCxuJ/2l?=
 =?us-ascii?Q?hEu7ltB0gvgciJs2FyKEDvz/E5o/lDXpvIXXlqBeJiCQANFV52lbsKvWXYEJ?=
 =?us-ascii?Q?97nSjgidAkC9uDsWnYJfDARqboynvX5mAXsfXIejckrISPzS0wpUNvnDbq97?=
 =?us-ascii?Q?OlN/MJ0gBO0q/0eNcOVovM0Iq84ZYOgaslArCRc1RW9cNlSVlF+Dnw47nj7E?=
 =?us-ascii?Q?wNEnKLwlDvj5CIK2+0GSelkjoe+/ebytF85Vy9RRITujCcLKEbvDWGKD1iyw?=
 =?us-ascii?Q?//G9gZHgRPTyhk1jElzhIBSqUk7tcMjdXknDzSgdTYBbhZIL1jzASW7hQLy1?=
 =?us-ascii?Q?RBq8IdNbukDb2Nbo2avbGfPmORg3EoQbwZ26HrE5VKSPC0j3B92sNlHUNlVm?=
 =?us-ascii?Q?9gwdLTgdlmkowP8hJESX3hgzMY3UFz04zOdauTomKdtGs0IbEoMC3Nt+9PCk?=
 =?us-ascii?Q?Hkagp25UzDkhTZC9pA1gp021OPwRYnndDCT1Q2VsLP7h4euxXz4D/iJTwURk?=
 =?us-ascii?Q?4SR+CGR3Mflq+eaWsQErHhOg?=
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9900fada-8ed8-45c7-01da-08d946c0a0c6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4884.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 12:12:19.6712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVnRUnUMMGaDTSbP/0IEYEyXJ9whh1UQ7IeV0tH9R6QM/Cll2c0yLYQZ6KMvSXID4rMD9WHqkahvbFeWPE0yqjMPj9M+WFrCGicdu7RUwEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0902MB1748
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add compatible string for usdhc3

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
index 00ae820d5175..8c33edf0744f 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
@@ -19,3 +19,7 @@
 &usdhc2 {
 	compatible = "fsl,imx8qm-usdhc", "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
 };
+
+&usdhc3 {
+	compatible = "fsl,imx8qm-usdhc", "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+};
-- 
2.17.1

