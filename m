Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9B4432258
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhJRPNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:13:49 -0400
Received: from mail-am6eur05on2079.outbound.protection.outlook.com ([40.107.22.79]:23649
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232634AbhJRPNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:13:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4X0CbcnalFFgk+VhB85s+RLS16spuI6pUzcXbdrR1TSQ9475hmSWTISC1YMNE1jSMnSuAjFE8B8UYX4hyF+6g/cUHAs7rCTOvekPETycEtrW4sNCdptL4VXi+3uldkOByv8DGNgqC7KkuSCzXPTgTlw8ax/k0Ri+/9BNbnnWkk1872GjqD0yZiWSUwuuQLs7OLDRY9gACNAEqeunFNgRwvxDFzIqkxsFpSSId1+hw9bKnYk2Ezp62YI3F2j9YdaWESsswQzgISQU5kLefWJ+HD1HzN3bUB6CARzvJZdbzqyLUWW5I84LZ3ePhoblgeAbmuCBzVDsBpHxuMFzGDIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duDcE51cmXB6iiuz0X6mIpv6TB9EU2iHqV9RM6mydFw=;
 b=a5BzibPXAG+mv+vyLifI/bHPHDEz9jwzIIkiP6RI1eaAn+C3A5NV5CTHYXEF0L0FPA/sghi7iffxBoLouBfY8ohU4jx2uHhrT+mrNfuwQ6pNKMrga3vgOaE+vql2MUOmvd5ywQF1oDTJx90CGn3zfHWVp+o1QIBbQyRiHMGQ8wFrkrwBU2a6oPGmilJACYcrq6VYY82FVntJIstcSkroMHb+DAjicxHSMcFXX9bu1HvcTniBkdaxDpI6EArd/q/MaCyGTt5NrtLU2HgCsacNRfVvjHXAsOCKFcAzBSGY/P2CFML30CE8wBrQRtVw/aWkLBwTc5pCU28ffdDx6qBiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duDcE51cmXB6iiuz0X6mIpv6TB9EU2iHqV9RM6mydFw=;
 b=my7aZpWz79ImhqE68XUzfN9JSmu/DtDrSRvptXLFiklxwOta67D9v/SoNuENbe4c9aRiRcLGUmepR70WQF97WC2Ghd70AnH+WUOk4nESTuCFQ8ICqjOF7D2CRogEbXr81SWOn+JZSca9R/HwrL+yOPq3f47Jtwtq1H62lrIorrg=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from AM4PR0401MB2308.eurprd04.prod.outlook.com
 (2603:10a6:200:4f::13) by AM8PR04MB7268.eurprd04.prod.outlook.com
 (2603:10a6:20b:1de::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 15:10:57 +0000
Received: from AM4PR0401MB2308.eurprd04.prod.outlook.com
 ([fe80::6476:5ddb:7bf2:e726]) by AM4PR0401MB2308.eurprd04.prod.outlook.com
 ([fe80::6476:5ddb:7bf2:e726%8]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 15:10:57 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     leoyang.li@nxp.com
Cc:     youri.querry_1@nxp.com, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/5] soc: fsl: dpio: rename the enqueue descriptor variable
Date:   Mon, 18 Oct 2021 18:10:31 +0300
Message-Id: <20211018151034.137918-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018151034.137918-1-ioana.ciornei@nxp.com>
References: <20211018151034.137918-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To AM4PR0401MB2308.eurprd04.prod.outlook.com
 (2603:10a6:200:4f::13)
MIME-Version: 1.0
Received: from yoga-910.localhost (188.26.184.231) by AM8P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Mon, 18 Oct 2021 15:10:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86163dc0-62ef-4c20-61c0-08d992497c7e
X-MS-TrafficTypeDiagnostic: AM8PR04MB7268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB7268BEBC82E55218C4919E24E0BC9@AM8PR04MB7268.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:238;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtm3CoIZ8ilGJOfrdvuWlw55fyJhUwX85pjpxb/lc3d83XOazncC3rDlnpF1Fvjvk/PYjkz0jQ0SbLcoJoVA2XwDvnP/nyt7+3qpN3OgfPIqNS9oFiWSwXm5QE8PEcqTguZ1VKoXWBXTc9GK4t4hmjp9hzKd8CTtLJFfa5hNTVY/1ietwWRtEzJVm5ZR8GmoY90rw111hlo8JhXYXqiroEaLAi0JIn75Lk/KDL0vyqMBPPIYt4Bjt7UV8lyoodcbL0PJU3HF/R/+xya0mr6OM00BtFrYFdQU0l3XmpkBgJP2o690H5BQ1pY4sgIZBjEkXoCCe8bPXEvcRpdGVxXmckcINC+xBqeGLwjWjBGygjYi9CURAI5amuT9gB/t+KWT6l7NVBCbEKJIUlzCbOas8uNmEAidqMsBPNSLYNyi/LhU/QUfs/K/0bu2I0Bg+e9NIEdsf4pjWcMtUAvNGROuJ5DeAQq11dNic4MnPVVoM7ys9Mm1wRsFAFuo58s/e/y4Pqfa1VZSY8n02FWpAw2MLhDF/vjCJSItG85hvlRtP++iakUnzJrnANLSlc7mh9Ex4FJ2EU94F9OOtRPk2//cnOptzbUQu54pdC2vTQyhzB7ma4/Dqnym0hQ4hkxPRRJGd8wRMEyS2ynaUsHjkdxEpAz8VhDBfgJ9s/DB32fG46D1ykrCdtkNy6MOKqpgbA0xOJoMWkmdjymsaMRnpXXuSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2308.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(1076003)(83380400001)(66946007)(66476007)(2616005)(956004)(86362001)(6512007)(508600001)(44832011)(6636002)(38100700002)(8936002)(186003)(4326008)(37006003)(8676002)(5660300002)(52116002)(2906002)(26005)(6506007)(38350700002)(6666004)(316002)(34206002)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+3HsTKngZSzEDjJIyCfy7UtZNGn1yea9aYK9NR33/yX9T/MnJTqRGDcMb3HO?=
 =?us-ascii?Q?PEJbL208aKSDJMMRVudN8rUCD4zjARUY6glS0tQrEC49ZJKdnTOG+i2WANEp?=
 =?us-ascii?Q?GslIKK73sNn2/IuoK+kwiBj/5cgWv4OoeMCP3+9oRGfY/DE/anF5l7VTGGpk?=
 =?us-ascii?Q?3HMr3p8hWvaABbc+kbDXcMLE/d2egp7AvLJhALd94+mL+6q7vBX4D8aefhVC?=
 =?us-ascii?Q?VVU2KIiLAqnBcsvB0KWvKO/qMEIbMufnwt+oBWO/+/u7S/+cq3rXC/OnqWfL?=
 =?us-ascii?Q?LOy6OtIuaWXze7yBs3VQ4stoe69TehSSOyHq9BKuA1/6srBCkoCE57ur8e1t?=
 =?us-ascii?Q?9XDLr8D7HfnxAhRAPvsrTD1XqgYW6zFQjmW89LRsE4UojUMIeFYB8ydZEX3V?=
 =?us-ascii?Q?76itYXYjDkZnobwj+Hkw53gUnHIRc+IaNFjkwR/1KDRI1XQEZoUSApTxGnl8?=
 =?us-ascii?Q?+bpUNMKSOXVqUJGLaGWF3ZoDFSW5XMV4ylfVlf8Sp1Op080z+4xW6wFl3J0A?=
 =?us-ascii?Q?bP2frFW9khvyDbggdNvQiZ1V3nT36r5Aix13faFK0kyCvrCxAGWSUNiNiudG?=
 =?us-ascii?Q?pU6PLjPrf95aF9ufhZAYwiIbbbdA8jSa4KGKEI0hBSb0VGTWg38etzOHNy8y?=
 =?us-ascii?Q?Lh0SkJjn3XKy7IK0doHFMd4U30ei6KA9acLXAQmrhkMNCtaRywe6y5qEekDJ?=
 =?us-ascii?Q?hkzFKPtSR4LVM1ztKH6Wa97/d45IPWNO1Y996ac144fn65kQcROsEPd3UBTo?=
 =?us-ascii?Q?WQaNrLSLuEFG6Zq6xF5l2hA/1OdF+eHrq8w1M4Wq/Oz976kX15Ht7jKjCxaN?=
 =?us-ascii?Q?nVh8xF4f/AgzTnk6itlMN2b9mEl6yAAwWQD7JdzuoRAvKHx1zhVKQrPb/d1T?=
 =?us-ascii?Q?r/6jKdJVWQ+YOSRLUprtgIShY4IXrtWFov990NlXj6s8VKIfduaKuVXhJEUT?=
 =?us-ascii?Q?VQAABki7juVEKJrOqqxi+0wQVRaSMJSNmlXJnil32PoqiaJypEWf9DBCOLKx?=
 =?us-ascii?Q?0mxk+w5CSeKRMTMjEFs4JBBzdMEvLTdycwABGvGWPUlmLVmqFHM/TwzKTUgo?=
 =?us-ascii?Q?WRGK5aqfh2O5nPv96+4rvLe1xhnAi9GeoQST8XnpOFA+Jnlkp3rwTlxUjqwX?=
 =?us-ascii?Q?pFn60tkX1j/k+bdpkqigm2vVFlKDNcbHyBsEDCCWAx8ObgAbIv5uwbt4xAGD?=
 =?us-ascii?Q?EJBA6Dm3m0oz8qRpQ9eZF1jUIMrm2XWyfRY+uvlWweSQ7wvF1SubmosMPBSp?=
 =?us-ascii?Q?BpKlXL7OktXMWjp0/7MNisfPZx2f0QtihHGiQx4L6ithNt9FJDQvu4Xw6Uqh?=
 =?us-ascii?Q?kT6I3TPjmd6IpJI1KdBnBHxg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86163dc0-62ef-4c20-61c0-08d992497c7e
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2308.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 15:10:57.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onf+no1tIBznqUI1Hd7Hc0ksqCgqo6kYKcZXhdiWo9zV+vwEWgRfRKH0ljxeGFQ1PeC1Kzh//tsOCJZar1uVWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7268
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youri Querry <youri.querry_1@nxp.com>

The struct qbman_eq_desc 'd' variable declaration is covering one of the
function parameters. This has no functional impact since this function
parameter was not used after the new declaration.
Even so, rename the variable so that we make the code more readable.

Fixes: 3b2abda7d28c ("soc: fsl: dpio: Replace QMAN array mode with ring mode enqueue")
Signed-off-by: Youri Querry <youri.querry_1@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/soc/fsl/dpio/qbman-portal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
index d3c58df6240d..eeefd1f19f0c 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -693,9 +693,9 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
 		p = (s->addr_cena + QBMAN_CENA_SWP_EQCR(eqcr_pi & half_mask));
 		p[0] = cl[0] | s->eqcr.pi_vb;
 		if (flags && (flags[i] & QBMAN_ENQUEUE_FLAG_DCA)) {
-			struct qbman_eq_desc *d = (struct qbman_eq_desc *)p;
+			struct qbman_eq_desc *eq_desc = (struct qbman_eq_desc *)p;
 
-			d->dca = (1 << QB_ENQUEUE_CMD_DCA_EN_SHIFT) |
+			eq_desc->dca = (1 << QB_ENQUEUE_CMD_DCA_EN_SHIFT) |
 				((flags[i]) & QBMAN_EQCR_DCA_IDXMASK);
 		}
 		eqcr_pi++;
@@ -775,9 +775,9 @@ int qbman_swp_enqueue_multiple_mem_back(struct qbman_swp *s,
 		p = (s->addr_cena + QBMAN_CENA_SWP_EQCR(eqcr_pi & half_mask));
 		p[0] = cl[0] | s->eqcr.pi_vb;
 		if (flags && (flags[i] & QBMAN_ENQUEUE_FLAG_DCA)) {
-			struct qbman_eq_desc *d = (struct qbman_eq_desc *)p;
+			struct qbman_eq_desc *eq_desc = (struct qbman_eq_desc *)p;
 
-			d->dca = (1 << QB_ENQUEUE_CMD_DCA_EN_SHIFT) |
+			eq_desc->dca = (1 << QB_ENQUEUE_CMD_DCA_EN_SHIFT) |
 				((flags[i]) & QBMAN_EQCR_DCA_IDXMASK);
 		}
 		eqcr_pi++;
-- 
2.33.1

