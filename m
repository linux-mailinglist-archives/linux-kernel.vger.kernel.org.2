Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD2A3AAA8F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 06:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhFQExj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 00:53:39 -0400
Received: from mail-mw2nam12on2094.outbound.protection.outlook.com ([40.107.244.94]:2464
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229580AbhFQExi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 00:53:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dV3dvmmnvTrmSMMnTG5tTKPQejHzYYsoP7A8suUR/DSnLakKlh0GtweXVmnTiQcDlR+NkKtTYvTwlv2y05Aq79kQNe0fbKSlhgZnOh7frV0bE1H6g2VGuI1fIfY0OXehguNgzQ1qDo9NZpY5wwdLPGxCoU4O8UJMMQrIXyoO8laOeVt3TrxoIhOu5pQfAuxR3pHaSnC3YVh64+d9ok0t7oS+A+ckONclUl+fcpyRY/B2Y6cKp2yYJijHAT9nHO1/HjjrVnLWtlIJ0DpuNM2gCHvF87YlebfnFDSxylXjMvTWALMPSMiY+FykV9sV0m/+K0AC9q4TF5YjbP3PwyllZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01tPiFkVWwTy4ToBI+/9F9a3egrEWligLQpH96Fucq8=;
 b=kXQOWlX5O7QxSq3Ki9pfJKWWWiluOZILOY/p0+91l5JH/ZCCJHOmDRfHWtSVIw0Nu+iadF8fFGJJWoSeG58t5t/dcbx2fkOokhYytFGqq/nXAQgGjARkM0mzX2sAjNBEGqNxFxLUSbkyErmVy9VeTlspho/bcgq+gjQDwHd29uFxKnPiMDxC+95byTWVx53jqi1AKhMfTQyIhe+gyjCwxjQi2/xi83jvKPRsJsTbBhTGcOM7yLavevzSI1Rul2Vj1swC8LYm+KhiT9C1Si8LQGGhUsH/6hvYDjj5OA64FNinP6NmzF00M1RT73VtoYdy4MJGcBoNiNAQmSmvNDIFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01tPiFkVWwTy4ToBI+/9F9a3egrEWligLQpH96Fucq8=;
 b=B3qc2Rq5T+RjVxcuLDhIFS7BCYiPvN9N7VbmGL4byjvhcUdbT5S2eAKsF+NYgljcqXzX6I3/g5L1rVcZkHyluh39Pk1tMtkzKmFduaequwTdbA01lOw2ugdGlVKzDjpKwmfbNGmPDfmSd+ET1i8ACPQx+9JAQtR15AzHSGPM6T0=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 MWHPR0101MB3181.prod.exchangelabs.com (2603:10b6:301:33::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.25; Thu, 17 Jun 2021 04:51:28 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98%3]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 04:51:28 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, pasha.tatashin@soleen.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com, zwang@amperecomputing.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] arm64: kexec: flush log to console in nmi_panic()
Date:   Thu, 17 Jun 2021 12:50:23 +0000
Message-Id: <20210617125023.7288-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [180.167.209.74]
X-ClientProxiedBy: CY4PR18CA0058.namprd18.prod.outlook.com
 (2603:10b6:903:13f::20) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj.amperecomputing.com (180.167.209.74) by CY4PR18CA0058.namprd18.prod.outlook.com (2603:10b6:903:13f::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 17 Jun 2021 04:51:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba1fca7f-cf6d-498b-5ca1-08d9314b9101
X-MS-TrafficTypeDiagnostic: MWHPR0101MB3181:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0101MB31816FB5DE7F689A1CAFD17FED0E9@MWHPR0101MB3181.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ReJ64yIkhQeK4t62Tu7iTQZiUKwssT4Ai9UJiW/Bk3779MtDKnviXEVR0RATN4ghRK3DV/n8OgylzKD2aMLHOYW77kZdes2OoMGGbSk8DHBIfYBnPKCPGjc7C+3SLKB+ULumwtMsHqrxbTB+iet6QsUFraYevgGPOog1Q8LT6BsnWoaAG1scdEXkbbxi/HOnr+AM253tKbGFxhc6CZ3jH+oS8nmypfARifKbDNIaK6ZG5hU5Xd2FIRU/Vb6Agrd1Y9Y9olr4FB0sdaWxwxy59ki4myDgp4NaC9g8RIu4yCS/fVh1ndT15gK6zklDGLsRNr8WsrpjJLsyFPDW6q9gm95r0GfqvwKw3Tn8Y96X13/HReEdWOe2wv4oHj08lLC3GMSYS0a2O7toVfoUwMnkRHv2coVptXQJLmfWlODZEC/ymQeWjj7NxzfCIODCWleAQIa3wWnBwGkYNrE+HsnI5/wzPQ/UW8Ge0fRuLI4X7ep4eeXk08Mm2NdfqvA5c+/ZlYTpg5O6VHHleATplSVmksGMhhiYe2NXqt3XmtQ6hlGYi9/17pAxCec0ZNa7u4+sOllILm3ey6RNOX2AMfBUl4m5n5Itffj+M+GWHb5YiIa4o2kU4gz0YdH0q7Hj/50nGN7ZEW2z6iz/5JeS1D0eoP/2C14qdG8vaqs0x3HMJIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39850400004)(376002)(136003)(86362001)(2906002)(66946007)(8936002)(5660300002)(478600001)(8676002)(6486002)(38100700002)(52116002)(316002)(26005)(4326008)(66476007)(83380400001)(956004)(6916009)(1076003)(2616005)(6506007)(38350700002)(66556008)(6512007)(16526019)(107886003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dylFzI0zz1OJG0U0W6EfnI9sCpsVm5PvTO9eeo1BVKzcoFCRDKhVgOdEm9YO?=
 =?us-ascii?Q?dcyZ7NQCTBqipkx9DtQQfUwyHPwtMdcuMe+0DPivzhwHmAGbItJ2qZeqh6PQ?=
 =?us-ascii?Q?x/AlrwxSgwGvD3yBcFTXhk5is+UeD1BZjTSWoTp3s2vBKMSTsN54EKbHuUFC?=
 =?us-ascii?Q?7eFlk+Bbzi9IYP+lVKn47CgrI5TKi5fXT1oudwYNrjfFn6Spne3dKfGJqdbZ?=
 =?us-ascii?Q?g33BIoCF4RaoTNVJ0O9Q4avVqxjndXxJ8FxRBnamANfCYB8bKtUHHg2jT1BK?=
 =?us-ascii?Q?3e9uMoIaLWLWcIFhvB9mSD/mt1XnN0vh5vSQv1ENC+EBsTZTHWwHxX2SxZ3D?=
 =?us-ascii?Q?K6echfJROl/Fer+yKU0JoFTtQ972fgPRnfmgUfC/rIeKurpejN6pQxPlKD78?=
 =?us-ascii?Q?+u15p74GnQEzWKm1yVONbl67xaTcT1DcEMp4nRt/xNqHyHLjGdhCZezqJW5n?=
 =?us-ascii?Q?+2xy4Nn12pcKddJuq8QPbBUEGJ0+lxtGjSOvI6Bne1O5nkYdLjIpNrorUoSL?=
 =?us-ascii?Q?B9pZYXbqaVzXrb6Y5E7A9TP6iMk1UgpQbH5Cs/tF6H4PmQ5lyPabnMvcxAjm?=
 =?us-ascii?Q?XSyp8H6KenfpLI59SfpHQ3fZQBtVmw6nEzD9XOpcQ/qSG8ScdlSranReGCSB?=
 =?us-ascii?Q?Aof96iVnez4zIyiTAxntNSH9CfdN+aGYSqrLubHbC0Z/ZPPaTbqXLHDhzn1T?=
 =?us-ascii?Q?MYul2h4ZJSBRXZdJOrvLWudelOP8efCRV8N5IKmNPFogzzWDtkBcGG6tm4ex?=
 =?us-ascii?Q?zm1g9DUB3NDKhHkUVkWe4mSjHWWyP7kUngUfe67B+T+aF3QK+CRd0u9Z84HN?=
 =?us-ascii?Q?qYeb3sfIXeszTwDbnBDgq8ru1voa8oYcBPim/ksEC/NR117HVeU1aFZRBo1e?=
 =?us-ascii?Q?f2yKO6dwPHC6fYAgiB6O/fYVAfdhhdr/r2k88kCGLPD8t+4yTeafM6CKqyrq?=
 =?us-ascii?Q?fs4On3bTB38g49bDfD9AiSegFrbvgH/5So6SXAiXo1lMetBXUWUVSNkK3EJG?=
 =?us-ascii?Q?L9ECrIPXdLRSFRbCCyH/FgsBv+IgyrDhPaGeoyVvCpoM3WWcYbctfAIKGzrF?=
 =?us-ascii?Q?TyJhpI2zN8bo1n49mI1IlKnVi1LZlDIx65ae9o5ovszDI0GrInWXk6xM8F2n?=
 =?us-ascii?Q?J4LvbHLiMUrimnLf+NiHjW27OAwtygHKoXxY9cNAav8E3CreGPCsRewR3A7e?=
 =?us-ascii?Q?hHUKAMCdgMgXCBR6JFR3oF4qqlTa8krr2p/vnuhrMbbR/CdH3G+S/V3sdD07?=
 =?us-ascii?Q?9UxNl2tMJGNuSGgBEyPAnV5tYoaiYxHg3al7MhutVX2/3k2uNJXZll7FkXrW?=
 =?us-ascii?Q?OwV098u0Ux3bDQ6n1sUJ6cGk?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1fca7f-cf6d-498b-5ca1-08d9314b9101
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 04:51:28.3374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSL0nMG3idIXSIzsLjC+ifVkESWj7tkSVIIdzmB9PuvYM1o03RrxTH02d3GelNMU9MxvvutpusDRSbOm0WPZiF49eke0lX2nGhTk56A2h0pTecH91KXdNp1MzynezsPG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0101MB3181
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kdump is configured, nmi_panic() may run to machine_kexec().

But in NMI context, the log is put in PER-CPU nmi_print_seq.
So we can not see any log on the console since we entered the NMI context,
such as the "Bye!" in previous line.

This patch fixes this issue by two steps:
	1) Uses printk_safe_flush_on_panic() to flush the log from
             nmi_print_seq to global printk ring buffer,
        2) Then uses console_flush_on_panic() to flush to console.

After this patch, we can see the "Bye!" log in the panic console.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 arch/arm64/kernel/machine_kexec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 213d56c14f60..0ab841dab9db 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -6,6 +6,7 @@
  * Copyright (C) Huawei Futurewei Technologies.
  */
 
+#include <linux/console.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -189,6 +190,12 @@ void machine_kexec(struct kimage *kimage)
 
 	pr_info("Bye!\n");
 
+	if (in_nmi()) {
+		/* Flush the log to console if we are in NMI context */
+		printk_safe_flush_on_panic();
+		console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+	}
+
 	local_daif_mask();
 
 	/*
-- 
2.30.2

