Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D6E3E5457
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhHJHfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:35:51 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:25934
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233697AbhHJHfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:35:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQ/Iciaulr10HSTmFe6w51RQpPCTIJcKplraJKOXGsKWfPxJrZDr/T/P9gVTzQ8OAjPcLx+hK3DuDuIOOScoRXMa+QFUfpESrhh1TYSgV1qbNghtuc14/XT/BrZNZRSkoWb9gfDyML5NN4utXX1gT3Nor1Tn7YQPy+buGacrXzIYIbiitVuP4rKLHttZZ37uSNLW8CDerAIqSyVd343jAvHnl7Ypyf7Zmj18c6E0mLQDPdrecszG+SLKTMig4aHWQiFBcg/Kjh5kr0Wh1tJfxzwsPqWy+bfV3HsZAG9gAxfasgrnfYn4goUnMDeT2+PywGWHo1Etc7N5h4i/ArhOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHxwMUMHEUcM8OGAihjIwC3g5VXogttyWNMD9d07uf0=;
 b=dYydD2OIv8kDDuBvZLNi6fJVaOa6wXVv7+VuSNHk/pzcVe22S6ykC39Yiik9N7IGOZcU/0ri36kF4Ry+dt2xdl3BAGRmL9CsKPw0Se0C75FhaGNB45hfVWg6D1rkViO6owxFOo7zNuRnU59SzBS3nnUIOEOimX9Z88xSx/qNXiqfyLKIDU97ADZSwq/lLrVWR13GRy3NW3xnjUNxhn3G2FIowWE+ZTnKbSQjvF3xC6I6Gr6zUAVznXoFdHYlOIlgtHCysaGBj68589/t6UDhmIqKnwr45BCU+k+TPymmSnqZLAVgHqp5CNwT6C1zcPJ3Fed3/LRC0Gf7kyUHqCHWUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHxwMUMHEUcM8OGAihjIwC3g5VXogttyWNMD9d07uf0=;
 b=ZzzJHldotlaZBaHBCy6/yJdHn5o/iV6ySxzkthbZNIIRkdJwzNQiH6cFosL8Ng+nIGvDhcFRnXO34v59g21lE84AgRZqXeS3KVSI1RcD/mKtK4nty0+8BQWtJTT2KwIhHJb8HSLE0q2lF98OprvXmeJjzLF6PXKp0Eq2cw/2n/A=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB9PR04MB8430.eurprd04.prod.outlook.com (2603:10a6:10:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 10 Aug
 2021 07:35:25 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6969:eadc:6001:c0d]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6969:eadc:6001:c0d%6]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 07:35:24 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data" property
Date:   Tue, 10 Aug 2021 15:35:07 +0800
Message-Id: <20210810073510.18218-2-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
References: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:4:7c::26) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR03CA0098.apcprd03.prod.outlook.com (2603:1096:4:7c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Tue, 10 Aug 2021 07:35:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecb3dc65-0dab-4a5b-d1fa-08d95bd16aa2
X-MS-TrafficTypeDiagnostic: DB9PR04MB8430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB843088600C34E9F23E4F5BBFE6F79@DB9PR04MB8430.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZCJTTxunza9dFAHJsc5jDZAZkAJhXMoZjocdicGUUOZkw3Uj+x0q6WR7CEtL1cVLPiYTMG+SGXNDc69Tk3ILcf561ja7xJJCRJKvXpTT7gi0hjCgKY0CB5naHcLhnkIqXtlW2NZgSgOw5B46ThK/enMXwFweiYfV3o1IA9+XB0bR9ru/3S3hsLqw5kPpNvwcF+fjU/5m357Wgv7a/DRMJ8Tcffhaqp9K7+ndLQ6qoHNBImOXMAYx+4pP5WumfVV1PPT28RCh6cXZA1NA6D/9ZqPNHbbVonMLacLcgoGuZitDH1MzJCY/estPLQvnaIuoCBFMh6ykD3sucklWkgLzWbvTcb30NUdMfRw3hcG7tV+6gARJYF1YIhRMMkPtloJG7AA8ghvCXirG428EeRnHR3uhM4hrLVbhROtSBJEFUmC14QpvmvKfUX+T9Jl4S4tubv/0Lj2rofh/vHeoo1EwknGHGlzrMMTNQlqMz2vUT1iPKyGTSAl7eF/0gTkYqQJhcDpRF6RNsujUfFmr9yEOJSY5P/55+telrR4zxPywiiCcCJEFP/A+pgWFPpVjGgtvEw+vtQ7ic/qaHHJKMhHvV5RJBxuJoNJh8qr9hatguX9YGNGw4fI5sHkciZXPciNNeR6KNAfAxnDZXGzWD7gdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(316002)(6666004)(956004)(2616005)(508600001)(2906002)(86362001)(4326008)(66476007)(66556008)(66946007)(36756003)(6486002)(6506007)(186003)(26005)(8936002)(6512007)(8676002)(1076003)(5660300002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hxSfTOY64ypmFY1KYBHztBsJ6n9ztmaOg4umFa7NxLoXZmwBtPIU1mnQqwTM?=
 =?us-ascii?Q?RVVH6pis0Kh8TtyhZt6IaE7ctQSeyM+BH2XovTzs4DnO0Vuj0ApfsHspPMZS?=
 =?us-ascii?Q?mcDAKLU4Lw589zXYq53mH9juzFWTC9eFDobENZt7btAKTp0Beq2Ybnf0+zc/?=
 =?us-ascii?Q?z1gOt+DqzypIGwbHGLMJFIZf3rJ+k54OK06PExE5jd/wp9kufq8R6M5W/jQJ?=
 =?us-ascii?Q?RyWhyVCT5Ia8NY89BKQ6jJnluug+X4PDC5jLw/KpueYbGmnN4Tu++1qpqjZ2?=
 =?us-ascii?Q?6KOjQ2RLXOvWtENGWUnjiSQ1qDaD6o0v+vm5GuhEZigDwVAvUsA9gFuxp7mJ?=
 =?us-ascii?Q?UpGWx4ARUWMI51Y9fI7MFFEGYZJ6nG5WgczH48ezfGdtw+1PjJCB+Rq71Ct6?=
 =?us-ascii?Q?ZcQ9jO6WdA3RdvgsupGFkWw01ElbVJfWZt3chroLiVlT92Tk3kcK8wQLH6ig?=
 =?us-ascii?Q?JP0sGACNiKxzyH8wOAvuXGDpFSTA94IOUez+dE1CTHYVoIeU2XaE5GvNIGrd?=
 =?us-ascii?Q?E1kpIVHNPztPoIf2BTjiBUTCArw4+qayTF1jf7zezFGEwrmOQnbhFDATUCmv?=
 =?us-ascii?Q?HhJx4Kjv6GKxeoYmixtrUUpkXm2CNalsXT3TmDOFMbiQZwsytmBqyAFw04st?=
 =?us-ascii?Q?STIzW+6Dgd44DGytIzF+4r7QA4MBc6IL6+8ewF3tAkzEOOchUC5rMVTyUnpf?=
 =?us-ascii?Q?mrBaRQYS42Fz6TKnl1HdkowL7aBTSokgWc3qi4Rso+WUHB4swBhNYlLGDOlW?=
 =?us-ascii?Q?X/0Ta0VPbotpRyQ3O4Zx9UfP6g11QAF1iYy5dzUApNOo4Lo03hB4RrZ4iAoY?=
 =?us-ascii?Q?THrcsqOKY80pC6ZhODQiGwB6QQyb8Bho2OPSrH4tcQSj+WTyl+ywItDkEvAz?=
 =?us-ascii?Q?ZAFBco3DiifYrZM0Q2tFZW4wxBK+Z7UQHNq0DLGgfXIPLJKvxl+OK9lkiZb2?=
 =?us-ascii?Q?J6J4H4C5xMbTwVio82kRt7YSj/WJ88EdsEtakr3GK47DWiV5o5Hu9jum71oc?=
 =?us-ascii?Q?5mkmmmD/5WCCsGUv6ukMkRK+rsGampwrP5DAdeNRKGH6L5p8imlQuA0WZRVy?=
 =?us-ascii?Q?RBodbQuj+dXx79Bp+Fu8d4nl+oR77Ul0Gqm+xZEOrBvdo32WtmboVVVGcqsR?=
 =?us-ascii?Q?31gYESjIr5Jc38A4xPaZ5AG/0YXOgz9w8lwbUJ1O7mn1+grxi8Yr7KSW5YQV?=
 =?us-ascii?Q?q6zIO3xULhRCYVyK/PgDCG0C2IRafd8Zbs8ChARBBgzriQ+yBvuCKNK/wM4O?=
 =?us-ascii?Q?ZO5+4w+Da/3fkIfgSccCnWC6n1byC9zwrnOXpNwwl0mY+M0MewMyg+HtlLmR?=
 =?us-ascii?Q?Wa/N8rpfUNgWsOS1woKMOd/P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb3dc65-0dab-4a5b-d1fa-08d95bd16aa2
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 07:35:24.7970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orLuM8yC30AGkojuaxCBWC01kKJ/HV2haO4H0fPGIFo+FztPX/edQ7houEjHZ3N7se+NYkPPmuhoKQ/DhNvzfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8430
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce "reverse-data" property for nvmem provider to reverse buffer.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index b8dc3d2b6e92..bc745083fc64 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -61,6 +61,11 @@ patternProperties:
               description:
                 Size in bit within the address range specified by reg.
 
+      reverse-data:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Reverse the data that read from the storage device.
+
     required:
       - reg
 
-- 
2.17.1

