Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BB6322714
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 09:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhBWI0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 03:26:51 -0500
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com ([40.107.223.44]:54497
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231971AbhBWI0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 03:26:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQIC1fHRSuq+QJmwuywpgGy3i+eMF/3Rs1xNrtpDxeg5CyKSydKDr88CoPHwDDQz3geOT3I7quHvjNZFS+xIebV8y0sB+RhTor9ySfwVPPfLQ10MgdAX74Kn7XhPlT7Z8OI2I8LwYI+Hoi5zE8TyVybD7VpZH7TZKP3zj5okG/Q2/469S2joBvX1ue25qASb4mgC+s+EqidqJtO4Fdfp/rIGOX99198KL9gVD/z1l9tqKI3xnbRiFE0irRfwHpjR8icF+SqVZrbMuiRmZ7nofz//gR7LskYIKvPfcPOvUBj3R/mPKuNBpZ8e8OSy+ablJAL6f+DijlJV8bEB3GlRVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uG0ykDZ8H6mxiQTiG4V1tyssG0q/P/1IinwL5ZcF+EM=;
 b=AZgSBTndLoHqaZ3LCid0gByUKGZQ0OdK1kq9EWiN+HAxgEjaH9ncp75FMhqXhuIHiLAQFk9g9x+Ou09gOuyVBvCtkQuHNBNQTtuTeLvyydGhJdTiviJFZ93ALD0J///03NamymaULCFcO1Pv3BP/ygCDlh8oJPn4A7CgrQQV+U+LTVUUx9Ka08ByvnyD3v7+cdKtHztZWytFiGQ4A4r6EimLGNvOdCMUDp0dsuBiepnorovJjA+h39pe1QTarCp4AWR16OJGD+dtHZMlUXgQFrFN2fcQczw88ppQ4RyH6aHlVDFbAHNz+mIEV4KeoSaIfQ/Qnc2us9X6w5IaT55+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uG0ykDZ8H6mxiQTiG4V1tyssG0q/P/1IinwL5ZcF+EM=;
 b=ZcrM56dvsR3NkYVno9ENvZTfD5F+IzCBOQ7Gfsms3TpZJzFUjmGs/FrTJdcHbom1b3QzIHJ11agGjd5s7ah8KrZMKq7PmRa+7+rNuVDfNigVbiQGjRjDeLpSTBXznogCiVa0HmjOinxKAFrvVC5SSJNRIXeegcExWVhRytM220o=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MWHPR11MB1679.namprd11.prod.outlook.com
 (2603:10b6:301:f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Tue, 23 Feb
 2021 08:25:58 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::ad02:3dcf:d3e5:b27d]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::ad02:3dcf:d3e5:b27d%10]) with mapi id 15.20.3868.033; Tue, 23 Feb
 2021 08:25:58 +0000
From:   He Zhe <zhe.he@windriver.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: uprobe: Return EOPNOTSUPP for AARCH32 instruction probing
Date:   Tue, 23 Feb 2021 16:25:34 +0800
Message-Id: <20210223082535.48730-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:203:c8::8) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core2.corp.ad.wrs.com (60.247.85.82) by HKAPR03CA0003.apcprd03.prod.outlook.com (2603:1096:203:c8::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.8 via Frontend Transport; Tue, 23 Feb 2021 08:25:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fa3b015-c74d-458a-524d-08d8d7d4a51c
X-MS-TrafficTypeDiagnostic: MWHPR11MB1679:
X-Microsoft-Antispam-PRVS: <MWHPR11MB16792F9A173767989F14694D8F809@MWHPR11MB1679.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpw9Is1cS6DLRpATMwesCwgWwMpZ/hjf+pw5J0gPDA3MUJjO2zZN2VZFdtQlHTbiYy3Lk1ia4UDSzuyrczPrcgsK7epGOnKlGBLR8B0RmbLOT91DC4T4rqeHe2/WqgujajK9k1qlcsn3qtLLxH1dmB6M5b0DlGPizbl+PSctItfRDlFKFnnoJ2cwTJdBf0IroUClawOswekv63ixYFtrI36U9iI88rhfDGrdxBsLMZuARhcufaU+PG1dbkYdjIRCQa88O484/j0ml2PZJQI2UFaIxQFJP1RXZEzOUSbCep1Z+Qv07aRItki+i+NxjCsWuURdRjztqhnko27r8uhgDhlu5oRATfcFMxxNyWcQao1n1Ra0TEb+ZIF8zRoIv0WwAFwYUCAv3cbpBjDxmvyVC5+u/kxgchUD+Qs/D0B0KLH3VwbnGdI2NzB11X5gDG/mQ6yK2M387FZuqjcXm17p9H/Ve1C6BrPWec/SE2vRhzFET/+29m5rfGtlYq7CKRE6+Rq6BOpvg6GP/r8v78PbMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(39850400004)(346002)(136003)(186003)(26005)(1076003)(8936002)(6512007)(6506007)(66946007)(16526019)(478600001)(6666004)(36756003)(5660300002)(8676002)(2616005)(83380400001)(52116002)(66556008)(2906002)(86362001)(956004)(66476007)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2TMwiCPOljYoHHAufbLPxy/zcOd70kz4EyCw15hakLteVpA6brExhPkjdxQP?=
 =?us-ascii?Q?ATy5hU14bXxJwTAImGByWV3s1lWj8ZIlVI4y6buLj4fdxkTaodVHuAlNw2GG?=
 =?us-ascii?Q?LelSmXUz/xcEFWU3S/IIgZhm2P8Hmce+UA9z+bwR+HqRbQs90VB8qsrqB6sp?=
 =?us-ascii?Q?K+7XLHZjXb6idiu9bU2CzW7kvOiLL5A2ml3l3VeNlmd3vXOIqwxmUuExb1yU?=
 =?us-ascii?Q?xm3BhAcxSq5VdtMWHK4a7/3gRf4mEbY8kgHfSjHpabUxfPWoGYd/CFbrJcTT?=
 =?us-ascii?Q?8eqkJuGjkPDPXM+kwMN0H2dH4PjJaw68g15kxWED/uId6BMxLvPaGbbXxfwh?=
 =?us-ascii?Q?tXWY9M2LNraVvKxGguy9/gGjIqRVHH7SM4pgH+OMMiFiS6wy/loNCK+yyIJN?=
 =?us-ascii?Q?zt4Dtu+3gqOOI+RWjzUN/jy7xc+/7g+RwPHDBQ8ijF6VzEaBCefrD8gjdGQI?=
 =?us-ascii?Q?PAhQrzn7i0jf3iGKU42K3RfFX4a8znsGhV9OBofJ1y7ODYYJf40I3kbCPNuA?=
 =?us-ascii?Q?il082GKqCfybg/XFDFc7R4xpuT54n9+LzO0qzdnuUa/ziRb89ndGvdvEh4w3?=
 =?us-ascii?Q?rMsaGZxYjL2qVXgw3hGhM9IdoTxOXSasDSjXuw3DDgxBVvIrQajVJZfDdkZ5?=
 =?us-ascii?Q?qoOzbo5IgDdBeeuwTkwUglIQn7j0l3CpBVY7jXcmoX0V/GdQpnxNESLJmvNz?=
 =?us-ascii?Q?fDY5WmMpWr4hFhC75X++9wJ2VNfxGGB/Gxfr7m7/+WDpG8iIGpdpLL19njSG?=
 =?us-ascii?Q?RPhzYlETn1KP+FQIOU9LhdSw1AX6YN1AC7HRSX5ZDG1bTMjUSGUkMzAY9PFh?=
 =?us-ascii?Q?N7SdcftEooz+/1FkTO8QaA2VLiY24n0e77R1XXw07AYGB0noFLxLcNDNbS9R?=
 =?us-ascii?Q?+/PyL5INrywAF475/Zk1wN/dO4gOo/4XSnhtoWBGs4cZ3BCbwHf0fmHa7/pM?=
 =?us-ascii?Q?uNoN4G8i9a6k/iTw/horOEfHsBYZIZXmqVOXcG3O5EYa6P+7Ae0dzpxgq6DF?=
 =?us-ascii?Q?uHmQWrmHwgIYI9nk1jSNGA3wwC3XZJZq6Q6+iRNWzheFIwCK+ZRHs/yVGR0C?=
 =?us-ascii?Q?BqipjCML8NpBF7UCsRnZPo8fYqZuZYzI1haDqKiZDMAlmWVaydMWvBiPY0Vw?=
 =?us-ascii?Q?AqdNZ9S4Xjo2GgT0pJnFZ8WSGtVjjk0S17WsqKhSYERc5WbfHfsb7WBderyS?=
 =?us-ascii?Q?8SC+PziPiXHh88WxfvL4uh4mb2yvAyn+MmJ+ajtzbm9DXJm/FxEQbZbe4Ayr?=
 =?us-ascii?Q?xW14awAO5ZiiauVUQFagiQWMhlkr5cPtgDGdUojLwrjdLdwVe5H8JncArEQv?=
 =?us-ascii?Q?K0xOnMta8hAapfO/ZkO7Pb1E?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa3b015-c74d-458a-524d-08d8d7d4a51c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 08:25:58.0388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //7UqtIbyK4/9Q47CTY0GSEyV5g+PFBJHhrpPJRpCyvqIYp7framXuGTzyZHRo+YFrNzIedEw82QloHsBMWl7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1679
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in linux/errno.h, ENOTSUPP should never be seen by user programs.
When we set up uprobe with 32-bit perf and arm64 kernel, we would see the
following vague error without useful hint.

The sys_perf_event_open() syscall returned with 524 (INTERNAL ERROR:
strerror_r(524, [buf], 128)=22)

Use EOPNOTSUPP instead to indicate such cases.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 arch/arm64/kernel/probes/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index a412d8edbcd2..2c247634552b 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -38,7 +38,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 	/* TODO: Currently we do not support AARCH32 instruction probing */
 	if (mm->context.flags & MMCF_AARCH32)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	else if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
 		return -EINVAL;
 
-- 
2.17.1

