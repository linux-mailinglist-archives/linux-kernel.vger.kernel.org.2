Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F99E39400A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbhE1Je7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:34:59 -0400
Received: from mail-eopbgr80040.outbound.protection.outlook.com ([40.107.8.40]:41127
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234618AbhE1Je4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:34:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJ1EEPzHKJt/1pZICYTDewGEZq51HPC7+mXtB4saNfvPDCd6OD3VMHSRdQTC7eCIQaepeWFknEeuN6H0AttLv9hZvnWxQROcUAPf5KijCBcQp0AE+tvz9riPHBmgmSs56bfWyex0yUAQSo30DfPe8pcKSbeEuw0GDVAbZeVwiAsmgws4Miog546dcLhDuPnSgiGZ20sH7xd8KbqJFTvPHQoMsY2/wGXWXgkzTHKLwZa8ZRqyA4ekwfH3huNyy8e1ohaNEBpTqzfOdblusQbE1wDID/Sj9ffgmCIC2SkHNAxxQTdPsmd0oPEq0pqudkONZg8lraVAEYiNjY7zR8tYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9Z3M2zYdIu9xaFJncZgEJKFHAzPu9nzJie1X4ZnMWU=;
 b=S8lO6/wSNIUeyCc4ShT2J9K0oB851RClz/iuaYasfhEDxTn0n/Odz+9Utl47cmkMe3XcV9ZZNSn3QXRdIDU3MKDpRyJMBZPT2/L02lm2lAS2gyyPfZ445ZMzgRAZiWuXtNhcDiXuZN2uIPxRTVmKmIvKYNTOgo8RDD90UoHPRfm5hebUPc908Zv/gPZxOg4xDH9ntqMFFx9Ky7d7gKmpECL4JBA18vtRUbu2qzMQxO2KBeyONcLserni0sfy6pbrpbhqJ6K5pIDKhxLdsWPd88Ueg2ZsquSI6QnbuElAeqb0k1641dEdYtgS0S0VQn22hor7ElByUpvfWARH7CIOkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9Z3M2zYdIu9xaFJncZgEJKFHAzPu9nzJie1X4ZnMWU=;
 b=e6hcdeuC7o53cCZ0Yq+9HUVgIZUmY7q3IPfzbeNHgaw98ZbAB9H131BYYF93+GXXR2JNwDiSZqgxKM9DuOoKLYAo2ze3+ZQ8eM4+tFjtU2Q7aPBgh4usFSF8341NtHOblkeBE0lIFCQAjmaXOnf0L0hKcUAxGKW0Sf7i+HjYIJw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBAPR04MB7302.eurprd04.prod.outlook.com (2603:10a6:10:1a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 09:33:19 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 09:33:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V2 1/4] dt-bindings: mailbox: imx-mu: add i.MX8ULP MU support
Date:   Fri, 28 May 2021 18:06:00 +0800
Message-Id: <20210528100603.21759-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210528100603.21759-1-peng.fan@oss.nxp.com>
References: <20210528100603.21759-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 09:33:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19ab49b2-f13d-4eab-d40c-08d921bba0ed
X-MS-TrafficTypeDiagnostic: DBAPR04MB7302:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB73027FE30CA35EF777C933D5C9229@DBAPR04MB7302.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JEeOEiiRkvJ/IX240E8LEMvaqTAODg7BnmW3Zns4QoEuj8SnszF8yFRBME7wV9UFNHYAKUQQHhCRE6Rn1RTBVpX+C9ANUMwARCvTg8hCN5B26REYpKSGxLSN3K0cYTogvXMs9pPGIvr2Us9Jb9MAv7JDRm4koK9HXQqVmHdeJuvdEgAiB9dtb+Slzs3+kzBCBTdMUw45czd5OlG/igdLQknXIrWrvbvLivs+119YZmF2rf/Jc3Z7AwcdCaYyd6BIippLqHrOZRfoaIeDtpFw40zDUvG9yyo1Sz+XqONTE+6tOgVe/Nef4jDSVrEbXQE7f76mPW4/bBZh+t5sCyaygjIj/YhYUsu43guKhhPLa+J2zNVM4xnu9UjOCWxTev97D+AWVMCoyp+WNfS429dfU3xlGjYFlEsYnzZZYOPJw8if9ECZ3ggEdVDhx/fC0jf3jRN5rzJp27sQxJ9+VJWtimmWL+VLz6Jibx2vl66Cm6OprAHABokhg/3Phbx3OXKAq8rSRAiAoYu0xg/6xadpTagsbMBfwIBsPJQPPNr9aA/VgR/jAv+PzTHAIMFBp/lasnEdY1cKCjirSftCtW9Jg+lYcEvw6oVXmYqMKyZTJ4l+T5nCRV2bh6XxeoudvnUXUsE033I0SPE+RrupxNGRH2cjjTq3xWiiLrYe5EHRqT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(2616005)(54906003)(26005)(38350700002)(186003)(86362001)(8936002)(6666004)(8676002)(316002)(4326008)(2906002)(83380400001)(66476007)(66556008)(15650500001)(4744005)(6486002)(6506007)(52116002)(38100700002)(7416002)(956004)(5660300002)(66946007)(16526019)(478600001)(6512007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DI4DMDbuCx4GcV97cudWSe+xsD+y0bR+54ScAHLPnIbKdcwxeQxkHQ6bj7V3?=
 =?us-ascii?Q?rkx2GKgfFG10cnciII2hqykMIShm0r6SqVRjVGPaKQASrmEKYs/eGrCEpBrs?=
 =?us-ascii?Q?T9MjTYyLCG4B34z/gEL3/phUMtG5C5Gd9vvYazhKaJ+N6Oezt3mzP2yFvQO+?=
 =?us-ascii?Q?1Fs9JzRr02YmHK28lvFYcVup871eDOirFYSLPsetbTHsEmV34Ay1U3dvh3il?=
 =?us-ascii?Q?TOWDXPlbi/104/YIC3IUEtIS5uOGURiflxrj6a+F+Q/AmjRPjbY9myDGZAKx?=
 =?us-ascii?Q?vis2i6mjv1k9U6UcJr2HN+VUCH55vrzc77ktsNYnRc7EMBB6m5JD8pTSamcC?=
 =?us-ascii?Q?lB229c4h/SxKmNoRlzvIk683y24DTGVjklqkgnNH0Wv7lkDDU0/0XrC3zw0X?=
 =?us-ascii?Q?7GHlAPGyaFO2YhdOvIbaGyLXDCcilkpqnXGRNC1Jy9kJaZdzzBb/idSiAEXt?=
 =?us-ascii?Q?SW5csuFf9es+6kmFvkq3eRcsA53C1fuPdMczHceAYOrKQq6tUIjoch9/5Bsz?=
 =?us-ascii?Q?3+k05AQNNFgssajrkC4IMg91s0n+SslYixE5N10dRlpmTpQq/GbvMuLxrYes?=
 =?us-ascii?Q?g1nV/QzjyER06XTjgie7tzYhH9+V2nOr9MCtZgf1kWfJarjfYR1RsIIBLtEP?=
 =?us-ascii?Q?+jqEdhLg3NrNkLaUaMPMzt5iqLRMrdFScWirRnu9HZkuTbcr7zkaThQ4Ou1j?=
 =?us-ascii?Q?iGaKegZksRBUIhSYJ34UC2VCei9tKaUv8cmEbyS+3bAlIjcPQFW4tug/NHoX?=
 =?us-ascii?Q?zuWRUNKgy6GQXd6RGvaEQv2i2yJuMSCsYW350bLXXS9c+7ZiL3PYR4pvlsbT?=
 =?us-ascii?Q?NDeLUHmjaDtJd/z/qmqbAVWoHOYPoTupfvalraAIo1+QGRZDPVw9sosZi+x/?=
 =?us-ascii?Q?TkT141Uyuy2eMg2CECYUsUKT3DVnXBVa50xeeA7n/KU9+P59inuP61fmvLG/?=
 =?us-ascii?Q?rtXAclxYFtqUx2fKdn89AVEmQ/ev/eAw0+SOOC9V5iOUsh/FIvxVias2ukUw?=
 =?us-ascii?Q?AqhoRiT+Kvh4eFPNwlTrzC4JMAaeCQWsvh8xdhgZNAqb35NkJRBDSYfNIFbe?=
 =?us-ascii?Q?TMtXPlQl4Fzn6g7vsmWoo/zpDRdUIWnPqnfOAo92mTloRQ5EqYIaGxhZjdQR?=
 =?us-ascii?Q?8I3f3Gur4SMeZ+cPRJg5/qMQhgv9608utVV6hCJsH7M3OIjPHngeM3A9uLtm?=
 =?us-ascii?Q?PEDLx6Rhl/moj+8+DQNPI+NEQn9iSwaHYkjBO65pQj64ZVdGKFv+1No6+G8d?=
 =?us-ascii?Q?d+Pi+ihSGkhugpzNvcwJofIQXZdiE9hSotLb5SgJfgBhGRz1+4VF3Nzq4Fim?=
 =?us-ascii?Q?mviUr8WJP+H6WxO1laji9HqOYaGuRNUEfw8hKGZR49QAiQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ab49b2-f13d-4eab-d40c-08d921bba0ed
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 09:33:19.5895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+BCzrdhfXvk+8wQbu7dTJWrvTzcRhbMgTmgCoJ/B82z7FE1AYCw9ApHtk3wPEoYWXPDcic1HOISMp1M0qfmhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7302
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The register layout and bits definition of i.MX8ULP MU is different
compared with others, let's add the compatible for the new MU.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 1a3dff277e2b..675ad9de15bb 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -26,6 +26,7 @@ properties:
     oneOf:
       - const: fsl,imx6sx-mu
       - const: fsl,imx7ulp-mu
+      - const: fsl,imx8ulp-mu
       - const: fsl,imx8-mu-scu
       - items:
           - enum:
-- 
2.30.0

