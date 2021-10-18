Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CFC43225B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhJRPN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:13:56 -0400
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:64975
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233355AbhJRPNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:13:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqHMR823ciymlDxBGnE6HqExJUiYRFinaMW8/Ouxn12CR+Dyndkov6Il50u7LUBSYEPcPsJlNVpE5s1dZXBwgYaQEk/TS+be684KJP2+Cbu2uTNGHUgsLsiBCNH+TZAGSboULP7Bjx+Nof4qH22IyZ+HP9CLVWcY7bHButgdutXAioZLiCBwZMtvLUzw8HyFd4S72zEt6oKO9l8cWcbAjtZDbUwTasBapGrt1FCyzwK+FHRqdKFsoQk4dl6cXpiecipmRNPNkAWpkBF/zd8rZumHgB5WkmMJVpLzqQVdRvdRBoX9qZHslUHTwbU8mIvbVarTzfnf6ickbi9SAj/NCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHMIEWqJC//rmnx3ifyqaC1Igdfdgq+KxBrEp/AAJPs=;
 b=ZPI4VLo8gA9j0z6e3nnxDyzT0YWsY52DeLudGXey7rfXizpdG/TYuOVPhO/joE56fvuLOd8mobH93wIJOAUmgQb4O6tvURQEe37F2LqDIgX5mZudFkuZB9U2ejFayUkVPg5iDfPSw8fldxuoxTj6sJSsZVGNu9ArBAWQSnIzdUNlilvchmfJ0H2nC4freD6PPT4SnBVEPVCbfCxx8ojnDbss+2XhcQCZNL9YVn74LKRcFAW/capqlpZ6odJanEYWc7snXnqPyL+lI1924RagsZFxSick/96DxyP8yJVnv3Xkp+ieO2/l+scHKIHTxEGhKBSlrdjE0jOErZHOx188Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHMIEWqJC//rmnx3ifyqaC1Igdfdgq+KxBrEp/AAJPs=;
 b=Xbrd3jsQFfzXcqdUZLu3tb7Z908qUPuSRPyaLaQlubtkAjnjNcdtgrOmOFMBQ30aiSuhyMM41lj2u1WpV3urb+EUWQ2bhmsm0yjwBy7vTCzJGUVdmtilHLsI1SOVg+b2u5SBDVI6A6ZhmELes0Xh15sLgxVK6St2sCucKsc5Ha8=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from AM4PR0401MB2308.eurprd04.prod.outlook.com
 (2603:10a6:200:4f::13) by AM8PR04MB7268.eurprd04.prod.outlook.com
 (2603:10a6:20b:1de::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 15:10:59 +0000
Received: from AM4PR0401MB2308.eurprd04.prod.outlook.com
 ([fe80::6476:5ddb:7bf2:e726]) by AM4PR0401MB2308.eurprd04.prod.outlook.com
 ([fe80::6476:5ddb:7bf2:e726%8]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 15:10:59 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     leoyang.li@nxp.com
Cc:     youri.querry_1@nxp.com, linux-kernel@vger.kernel.org,
        Diana Craciun <diana.craciun@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 4/5] soc: fsl: dpio: fix qbman alignment error in the virtualization context
Date:   Mon, 18 Oct 2021 18:10:33 +0300
Message-Id: <20211018151034.137918-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018151034.137918-1-ioana.ciornei@nxp.com>
References: <20211018151034.137918-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To AM4PR0401MB2308.eurprd04.prod.outlook.com
 (2603:10a6:200:4f::13)
MIME-Version: 1.0
Received: from yoga-910.localhost (188.26.184.231) by AM8P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Mon, 18 Oct 2021 15:10:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7efe8953-1761-40b2-1e63-08d992497df7
X-MS-TrafficTypeDiagnostic: AM8PR04MB7268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB7268BCF1ADBD25908A9C63FAE0BC9@AM8PR04MB7268.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVfLHiI40CLk5+slnZr3/i8YBO9vx59MTl2Ge1QVw4yauwjv0olcoBtGPvrW/Uk7LXUDNwYOckBIL5u18v4aX5GsKJ5vIpdN+h6/1i81jQZpz2mATyWUrDhyx6shABTmIdYihHah7thRnwchDMwhuUEYdE8m3MHp5zA28gp2CQgUptMEAIfTeKVCwAlhTTC3zZ7SNF8d5ur80rmdaxASy3E3Vh6vpNTTw9ppOtahzya1tD/5POHiE5k9hpuBZTcnsgoivxt2gktwy/XtM9+rEfIEC+Orx48BD/u9evJE9wr4HNPf//QGWlvSThqFUoxDxCXlCsjUNwEZ3SKosOGhYmvmrgUpqsPGrbnh6ZGpC+5PnAMe0m2x+eb4FIlRxJcO9M+h99MwG8IwqjgBaco/TtAd0CCFaXXKp+stKxDq1Z8zEstROsXmSoH87sntN2l0qyn0gVAv1s52Z9aDMix2PonGrwhu7+1itkYbZvE7JQhDM/coFN0l8WGL8NTcVxwYjqkJ4kn2/HW9dsl3f4SCwaAnftgL/MP2k+qhVSXv8/TZ8wYibhxQatih5C4vjWjqCczMmgW7MYHaXsn6UogmsK+8bm5ig+Gli0/aS4bWqafAzJSNbBMmK0BYSxBXJbSOWrCTirEMfAUxC+nreQlz5I7wk8z/KT3z8e/mTW/dNfEXt2F6SVKgdm/EYfK9qGOsZDsk3BYmfA5/Sjqy1XNNqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2308.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(1076003)(83380400001)(66946007)(66476007)(2616005)(956004)(86362001)(6512007)(508600001)(44832011)(6636002)(38100700002)(8936002)(186003)(4326008)(37006003)(8676002)(5660300002)(52116002)(2906002)(26005)(6506007)(38350700002)(6666004)(316002)(34206002)(54906003)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QwoUODWpRj9MmfgxQvpmZv+E174qIj/CB89xZQWlqUcjftAnzFb+oazbJ93A?=
 =?us-ascii?Q?ppgkXw1ipommv3Whree8Z5/sk1sd0jYwgl5yt+Gfnv/eLyUGw3VMvX5sTfBl?=
 =?us-ascii?Q?FSObUMp1Y8lYDhyOq0QtKxmyhSdep2XcTHjDlXgOe4FD10SEb71ULJVqJZpl?=
 =?us-ascii?Q?mpH7CFctTc2aoJsAyH+hF8eMykBKmsVYaQTJKEyXJWT4iZRn20iuiI2mjBQw?=
 =?us-ascii?Q?DP0MUTR/fbbF3az4YhMTARPQesLJEG/0M7JUIAD6IH4lqf3wBaW9ESbZRGhO?=
 =?us-ascii?Q?lxqsBLQjW3OtBzaQrpOCrbX4Sfy1PdX2Ni6fXpXaOYeKTyuScYth8Ly3FFY0?=
 =?us-ascii?Q?I28I4+dpqrK+fdK2l19siPt8KmOZLsknf5GqBjrWsAeRUoPaK31y3gq41+iK?=
 =?us-ascii?Q?kQqn9Le73iqM15YN6hEaatxd8T4LP8huuoN5vBrAR6D42+RnyQx9kohDeqoY?=
 =?us-ascii?Q?19GaYOhSr6u6d+0jWNRRMZbLCRmf0yjqhrbeGnSamh0829MFqFMumm9NAXN9?=
 =?us-ascii?Q?RSahDbItLwhymKUVvXz23qhucC+7RR2sv8+w9bdahbeYW/QZu3ExBuB09ShV?=
 =?us-ascii?Q?xg3RvI+wwOQbqdYN31fvdGVncMEzo7DX/ZLyAMh73Qwj8fVd4bjqcM398tOA?=
 =?us-ascii?Q?aMQH5N90o++Z63iyFjN3dOhMa5lp0gqaIYfUGEo1AaR594RRH5vnLPZP1j8u?=
 =?us-ascii?Q?HsI8DPseopQCWUDV7SXl/+/hPv0fRRXC+Sj0wPkdpQqN/iYyBx5EYSIWyYk4?=
 =?us-ascii?Q?n/z/jXovPfRhdEONeP8ogFlEindZNTI98x/mvn5nSWXtVDS+JcEmi9ynz8Rw?=
 =?us-ascii?Q?bfNnBkKDCNd+E4KlTTmLhjoBiZDerxdUMYGIeGgdPWwVtFQTtdZEgjN9sReq?=
 =?us-ascii?Q?vNFmk75laJiK1/cDOdeVMlEwQOX9TsHylPNusFJ94q/31DB0OkmW5PfUS4Kx?=
 =?us-ascii?Q?Z0e9yclxXbCz5E14ibJYE2Bma9+j5UY3WmgOBh3BXiQYKp1Eae/ozWbnRUS+?=
 =?us-ascii?Q?L21l7iUxPNdC/CFlRJNtXR/o5PuWAPCrc0i/g36ZGBR/LhptLV4A3DnqKy5H?=
 =?us-ascii?Q?E2PS1METoC8DKJW0Iiyt/Sy5Z5RbkZNzFEkF5MLOcxBP6hztINnm0bpjMI/r?=
 =?us-ascii?Q?qLAK2WaU4KNX86WYqmra/Y7l2qiBEv4rDyfdMRMUjXDow8lLIPxdCh62sK53?=
 =?us-ascii?Q?+lc4hUIWZmRaAQ+5jvoeBOSpiv40lxS51oliDqf6AP/mIvoYMPLGC1SkzIBN?=
 =?us-ascii?Q?Kho3W9l4iHEnZz4gcCAHB2mz/o9n0g/IxraxYemHe5mclMZE0P7fJKprh7v6?=
 =?us-ascii?Q?dyf32NeN5siaGkOvJ5vG0OCo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7efe8953-1761-40b2-1e63-08d992497df7
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2308.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 15:10:59.7689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvPNIkVxbw0raqgUSRMx6/QY51od7HYHgK+X7+kcarar1QjQvbRcaWvokfJmdqBVPYBT+wfGuNg3lXclANXT1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7268
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Diana Craciun <diana.craciun@nxp.com>

When running as a guest, under KVM, the CENA region is mapped as device
memory, so uncacheable. When the memory is mapped as device memory, the
unaligned accesses are not allowed.  Memcpy is optimized to transfer 8
bytes at a time regardless of the start address and might cause
alignment issues.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/soc/fsl/dpio/qbman-portal.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
index 3fd54611ed98..ef9cafd12534 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -679,9 +679,9 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
 	for (i = 0; i < num_enqueued; i++) {
 		p = (s->addr_cena + QBMAN_CENA_SWP_EQCR(eqcr_pi & half_mask));
 		/* Skip copying the verb */
-		memcpy(&p[1], &cl[1], EQ_DESC_SIZE_WITHOUT_FD - 1);
-		memcpy(&p[EQ_DESC_SIZE_FD_START/sizeof(uint32_t)],
-		       &fd[i], sizeof(*fd));
+		memcpy_toio((__iomem void *)&p[1], &cl[1], EQ_DESC_SIZE_WITHOUT_FD - 1);
+		memcpy_toio((__iomem void *)&p[EQ_DESC_SIZE_FD_START / sizeof(uint32_t)],
+			    &fd[i], sizeof(*fd));
 		eqcr_pi++;
 	}
 
@@ -763,9 +763,9 @@ int qbman_swp_enqueue_multiple_mem_back(struct qbman_swp *s,
 	for (i = 0; i < num_enqueued; i++) {
 		p = (s->addr_cena + QBMAN_CENA_SWP_EQCR(eqcr_pi & half_mask));
 		/* Skip copying the verb */
-		memcpy(&p[1], &cl[1], EQ_DESC_SIZE_WITHOUT_FD - 1);
-		memcpy(&p[EQ_DESC_SIZE_FD_START/sizeof(uint32_t)],
-		       &fd[i], sizeof(*fd));
+		memcpy_toio((__iomem void *)&p[1], &cl[1], EQ_DESC_SIZE_WITHOUT_FD - 1);
+		memcpy_toio((__iomem void *)&p[EQ_DESC_SIZE_FD_START / sizeof(uint32_t)],
+			    &fd[i], sizeof(*fd));
 		eqcr_pi++;
 	}
 
@@ -837,9 +837,9 @@ int qbman_swp_enqueue_multiple_desc_direct(struct qbman_swp *s,
 		p = (s->addr_cena + QBMAN_CENA_SWP_EQCR(eqcr_pi & half_mask));
 		cl = (uint32_t *)(&d[i]);
 		/* Skip copying the verb */
-		memcpy(&p[1], &cl[1], EQ_DESC_SIZE_WITHOUT_FD - 1);
-		memcpy(&p[EQ_DESC_SIZE_FD_START/sizeof(uint32_t)],
-		       &fd[i], sizeof(*fd));
+		memcpy_toio((__iomem void *)&p[1], &cl[1], EQ_DESC_SIZE_WITHOUT_FD - 1);
+		memcpy_toio((__iomem void *)&p[EQ_DESC_SIZE_FD_START / sizeof(uint32_t)],
+			    &fd[i], sizeof(*fd));
 		eqcr_pi++;
 	}
 
@@ -907,9 +907,9 @@ int qbman_swp_enqueue_multiple_desc_mem_back(struct qbman_swp *s,
 		p = (s->addr_cena + QBMAN_CENA_SWP_EQCR(eqcr_pi & half_mask));
 		cl = (uint32_t *)(&d[i]);
 		/* Skip copying the verb */
-		memcpy(&p[1], &cl[1], EQ_DESC_SIZE_WITHOUT_FD - 1);
-		memcpy(&p[EQ_DESC_SIZE_FD_START/sizeof(uint32_t)],
-		       &fd[i], sizeof(*fd));
+		memcpy_toio((__iomem void *)&p[1], &cl[1], EQ_DESC_SIZE_WITHOUT_FD - 1);
+		memcpy_toio((__iomem void *)&p[EQ_DESC_SIZE_FD_START / sizeof(uint32_t)],
+			    &fd[i], sizeof(*fd));
 		eqcr_pi++;
 	}
 
-- 
2.33.1

