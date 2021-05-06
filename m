Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD81C374C6A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhEFAeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 20:34:23 -0400
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:44676
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230308AbhEFAeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 20:34:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQYnMurrsQ9a9Sk5H9GFELuv6PfDqUkg7PCXEYCIAekWXcdqFbpRE5kqm23ceECOWG2U15dLhy+eSsWdHYlsElZ2ibZi+Zpr2CNK1IfdZpr6L9n4N64WTwvSfs/vETlwRLxSM5xhSO5xdUtIIsfVKfpjxaMsxYjsR4UJQmzxWbKG4eFu9V0PR4bFBRQKjNw3PhEKR69kSMJpiRcT5FP3WAPQlYQfe3xjR68j9guLXZjF7u1piVePMg2WsuSbUZc0EidNraGsmxLNQjymNF0FUsEiQV8ay3+PKYXuECtmhNDNarqLJ9edRW+qYOkoSmor4aO0Tli4ieAApzjXmhvwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFkEvPEwerxpXRsOXrSUzxy2F/JitvdWDQyJlv7Y9W8=;
 b=Y2xKhse/D6bw3XyPa9Vku8lGNSBX1+0NOurrOUThp0UHnOvLdc0XG1g0zTZmHyGAXPoHORyYL5xDnNqukt5Mnhbapqliv5tE02kwfx7X4MH0Ev0zcUf58HxeJDs89WgXnS55y0TPVGu31UT6VnsXv6DTd+fwDphn3SSXYthz3xLFUkfyU0cyAv7ZFiH0KFBZRwiEzeEZWbZ0w7Bn9uz0jOhDebzTumxyZREeS5YxKDvkYoWIM/LaHKmiS24lMgHTGb1f4ajRtieWtcuKWlmg2RFH9J6kKRXzbSgdXirLsmGCKNSTAE69Dx43tX045gGnfJ7Q83rTIlAB+EIwpnJ2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFkEvPEwerxpXRsOXrSUzxy2F/JitvdWDQyJlv7Y9W8=;
 b=hfU2W2+Y2DUf2FMqveFMuXVYUHojhRD6S/lZAM0xz7dBCAZJUaEimfYztHDkYXqCqaj81MiH/imorZywpk5QEIBKDBwqLFJULwdJVEDMVJOkvebA13ZbrcIqOr3zckHMt/tr857fffvvQuGgVWxlxl7TJ+QWMx/BQBh1fGCKz9M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7884.eurprd04.prod.outlook.com (2603:10a6:10:1f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Thu, 6 May
 2021 00:33:13 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 00:33:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 08/13] dt-bindings: imx: gpcv2: add support for optional resets
Date:   Thu,  6 May 2021 09:04:35 +0800
Message-Id: <20210506010440.7016-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210506010440.7016-1-peng.fan@oss.nxp.com>
References: <20210506010440.7016-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 00:33:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 868959f2-6bf3-485e-57af-08d910268846
X-MS-TrafficTypeDiagnostic: DBBPR04MB7884:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7884C62AD76DC4F2C3AD6502C9589@DBBPR04MB7884.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0nCm4nzR7eTaEIgRVJC4RnpDW9+1Ajg1f/mchI7iGeQCQ5anWF87LRNf7yO6493q+wLO2gS13ma0qNHtU5DXb4pDwAycD87dnTJmWPbnt/aXlUrKcAv3gjWEfBxCEVQA2yblwmVdX/kINdLTpp3+QRDh+960ghLJnPnJeVdbcUG0X/vKAmRsz5EFwcrG+/yzdv6jd0AU/6vkv389O5ulNTPcR1EFE4xOsi1+xJkOz8G8HAnOCg0AEnOnU2s/OqvWnMV0I9aTZsNRT2wcjtt38uYvuSkt3OfTfWcqBhETkHHRYvhA9JCE9He58CQr0wkKcWOD7/JuevXjA0p0pj/JYlNx7cFiGN+fs1CoxxHco+Fy55iRm9Ktrd7NCJLVZ6sXUL3E3+M8EKBDqG8HNSrTgj0rSYEnD0rYBWRwNP/0+QTnwnq/BwH+1lmZo3J3bgmNK7Y9j/ekFeBguxOY7MbTeda/BaG/uZN/cwlJLGkQgwc9t4noQ6vp6CCMEOuRVq4OK1w1zmycjMI6wM4jy4oz+idd5OXKijapyhhBvc37wykeRL4EAezVIr3HqP05cIk35+JX2sbzNhEPWWmgDVhnShdkvqzyiAv3fdI4AbCaONFXdKPXk9LHc9Nrn7pw62Os1Fzyw8dq1L++AnBzJR0LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(52116002)(186003)(6666004)(5660300002)(6512007)(478600001)(2906002)(1076003)(26005)(6506007)(16526019)(6486002)(83380400001)(956004)(8936002)(86362001)(8676002)(38350700002)(316002)(38100700002)(66946007)(66476007)(2616005)(66556008)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?v0UdMTXAE4knzquRUQR5dx6puHp7h+OTV/oBlqqVbdenV8K3vRMUvuZV5y0J?=
 =?us-ascii?Q?EpDq1ER/TH/Xbt6WZPgce34t+3cHqsXkBPGHuRsknPmCtjmQgp9QZD/q15mS?=
 =?us-ascii?Q?GpzOAr3qf/LbdeI0A9ns+p1TqPT1ksC7/3gZTlScUpi1WAFoWBDkip+gE3eX?=
 =?us-ascii?Q?VG6DWic1ZL9ZZIoS4KVmJuzfu9ZQxv9hWPsXXC959mBsWtHKJ1vdOE8gI/13?=
 =?us-ascii?Q?ABjUjphGiQMCw9vbeb99DXhtsFOr9pqOLQpzdmUATova8NY3Z2AbVRr27f+p?=
 =?us-ascii?Q?uEDwCyX3BpVQGT4XMC2nJuTLLb9eY78cBLq7Jow/SEP6zTwDhR7Ou/PbgMxG?=
 =?us-ascii?Q?iZvPpiI1zuisAQWT/wQaWhIb5xSZyvOxM/p7T0BfQJz5CF1U4KaSaxeZKz7c?=
 =?us-ascii?Q?UH4tKb9pwTwftduGsy+cSFrr7PQvjvr7RpQtE/u/5AFgYwX5zjQRvrJVuYYc?=
 =?us-ascii?Q?2iN51C8eb+iXRPcXEjweYUscy7CVBWKLStJPh3GMuekmYjJRgVoXChKWuJaP?=
 =?us-ascii?Q?zvgmRp0e7iNrCzWQFFQqI++jh26DWxnOM1LnIUwksEuo99AVv1DB04VCSd5l?=
 =?us-ascii?Q?LzlHuq57wqw1slV8J6VV5Ud8zCjxHuL9LAGX1e3JweU2sS8LKd3lsqCkQjVX?=
 =?us-ascii?Q?yH/FpO2GySAPkP/PPWF2IfgOC5K6g2P2rfhL4U88HQwEhOgTsxjlSdmt1wyV?=
 =?us-ascii?Q?x3Zpf4jz2LC/lYcnQdfNpnB79tMCaqYI31u9ODx4wV44hY4K5syJScUfYSng?=
 =?us-ascii?Q?e+qwb2iZt2QjUHo9rjzJXQt6vDWbs+872XG85ETCJZ0HXD5YtuNtdSCPOJ/7?=
 =?us-ascii?Q?jUF5DoYJN5L1wPqFQ3kvQFz0RCdWB/0Wm6ncbFXylE3OaNj7wocrOpR0ySaf?=
 =?us-ascii?Q?8VWfgjaNTD0NhzRs0O4rJplPBnf7M+WhSbmufR+/vsJ64TrPQfj65oczrcsL?=
 =?us-ascii?Q?2u472O2Uq+vMSxi5L+h6KntyOUPVzZdNxfn8uQgBKsiaEwGqLqvf77QKih4l?=
 =?us-ascii?Q?lbxznf3WTiO1qWYc9ajFVd/kr1Nn+iLMqp01uOpRI2ZgPCFmbnCJBuhzFG8y?=
 =?us-ascii?Q?154xjDOlZtp10WnziELjZGi6cATCFQmJEkxSungltIYIZYP3XQDDMn22Yu+x?=
 =?us-ascii?Q?Dn6rCZWEedQnSpXQHWdaxHl3UFlVrcVHhImT2itCQy25OaBTiEjhy7FBvyBo?=
 =?us-ascii?Q?/0D3OzaVE7MCmlGhENJF0NZx6IUAw/aUHw9J26xfAEcV4ix+qmMFgJflb22k?=
 =?us-ascii?Q?xCm5L/taiXTqR/0codAKelaMQUgCItmjCq0V/7GBxs8BB54DndydsK9Wyzws?=
 =?us-ascii?Q?hJsFC3DcNlIxLwCpkEiRlq+b?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868959f2-6bf3-485e-57af-08d910268846
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:33:13.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5r/nmpAdsokCs/N4DN9t2TN+HK060bOCQz5Uf7yIY7i0lmsVCZDiqfRenVZ5V8H9zxEiVpJDyl4wnwX9+/rKqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7884
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

For some domains the resets of the devices in the domain are not
automatically triggered. Add an optional resets property to allow
the GPC driver to trigger those resets explicitly.

The resets belong to devices located inside the power domain,
which need to be held in reset across the power-up sequence. So we
have no means to specify what each reset is in a generic power-domain
binding. Same situation as with the clocks in this binding actually.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
index a96e6dbf1858..4330c73a2c30 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
@@ -66,6 +66,13 @@ properties:
 
           power-supply: true
 
+          resets:
+            description: |
+              A number of phandles to resets that need to be asserted during
+              power-up sequencing of the domain.
+            minItems: 1
+            maxItems: 4
+
         required:
           - '#power-domain-cells'
           - reg
-- 
2.30.0

