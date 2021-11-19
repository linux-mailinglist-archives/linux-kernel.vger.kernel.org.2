Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253294579A8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 00:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhKSXmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 18:42:46 -0500
Received: from mail-cusazon11021015.outbound.protection.outlook.com ([52.101.62.15]:1646
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229610AbhKSXmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 18:42:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6RozdnmdRQrl/EVs4ejphrZjBclYmdvNqY1Se5AGrqFSsOuWTaZ7LDnFquo9kF8o2y8WbtqOCTVJBhAH9UuBj2+FQc9SsDbzdccqK8mNUkJ7WBkJrkIsppcx+9fZwE6dFxcDu90ExS3n0ch3MmcCmb9mVgNdgHYEhr99jnzp3S5zS2EYFYnn+9tL8SKXi14uL7H0oLMRMLbb50bzNTho1k7Xf/6LwIHdA/PNbj1YjEaBz9KiVbcTHuBoRk9aTtQp2bFFO/AcY/isumf6E2L+mWtYhuhgCApibF22CAInbatfnbu5QTB35XLdQnX3XiMaRa3YBbi7KDSUh7FbTHlWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBcrA3GicMcPSiX1v4GySeuSNmJUZRkaDr3BIwU3pmE=;
 b=N6ZLbK9OYSVTTJ0tc50QWenRJSIlGa+71p+OY71wzZ+8uuYSp2uKzfJInDfP3/M026hcTVU/BRGJkS6lH9Yil0728WFiVJGjARzhea+F1xaKUf/R+NzziAmB/FuoFO4CGIfDa+PWGqmpLrooxdFS3g3QVRwj4kqB7zumVDrVAqo0IInQXQpu35S3LQ1AaOFonj6ITHNmHtlxkWGcE9ASKEu5InrqiLp11lyjRVKCrcDoUvDnBr5/wHERR6xXmsnvro/1I310sVB6WnAS3AUo79I2PRb0f0mjHq2AaWQC3utg54pmDic1W9KO+eMlvKE5T7fW1FnWkVPggUPv12h+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBcrA3GicMcPSiX1v4GySeuSNmJUZRkaDr3BIwU3pmE=;
 b=FKarZZoIdKTR/u78L8BShPaXD9WIzOXZfVSG+EmsCTVMVXCOYGIil5M4xvHfcn0ZwQDQsEwH/DTQOYLqsdYVO3EJfdI6/Z+Zx82Q3jwd13NcJRBdLg9+EWHo4JU0rin3cn4kipLVAdYqIFNDDqZBlNlcZdq/hYw9RpZDXupJv1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR21MB0507.namprd21.prod.outlook.com (2603:10b6:3:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.13; Fri, 19 Nov
 2021 23:39:39 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::289a:20fc:5d8c:9142]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::289a:20fc:5d8c:9142%3]) with mapi id 15.20.4713.009; Fri, 19 Nov 2021
 23:39:39 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, steven.price@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] firmware: smccc: Fix check for ARCH_SOC_ID not implemented
Date:   Fri, 19 Nov 2021 15:39:01 -0800
Message-Id: <1637365141-16823-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0150.namprd04.prod.outlook.com (2603:10b6:104::28)
 To DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.147.144) by CO2PR04CA0150.namprd04.prod.outlook.com (2603:10b6:104::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Fri, 19 Nov 2021 23:39:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4105c54e-5c55-46c5-6a0f-08d9abb5daaa
X-MS-TrafficTypeDiagnostic: DM5PR21MB0507:
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR21MB0507AD153EC9FA962367ED7DD79C9@DM5PR21MB0507.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z+v7bbrErPeb/39RoNKb/bHExd5FzSx0k7y7zmyjLSYJS7Kq/Is7oqasgILhexPVmomGk+C7Pp0Grm70Qj02qDpuCptprvO7Jyfqy/MFUR1afhLg0iIAr2/getZ737adie2LEZOMo5T+liA8syYeI9s82EZys6dKwCFx321nhQDDHmoih8FibR7FMsSXclkmvovH9YSUvfYOS12QXVOiJ0dnlpOOx5dv2d/odw4+QrIhOsWqxkZxZtiwVn/eyM1z0HW7U+fdHtU52jhIh9B/vsq969T0g1450vSrz9C1I17LiBFyZQLogrBKp5TLns9HdThKaX9EaCYRY9qUGHc/5or4z72KIMO8aW6nwXF3uHvAhOVnqF58FoVjLDkzHQJn/JmU075NMLWmz8nyYJBbbGSkRHAbJ9I1+M+ed2e5/aL349Pvk/mXjXU61D9Ou0r4ISNu8oIJvSmzjIfFM8pT7Ojdx+gSZ5iZbMWn8mtCPfcPRPhieTHNqLzkbAYgFrhA29ds1bT2Tp0n3G7a5/HiD0HlowTsgoM8hOkY8EpbXqjFX7GQVYH8zA8vAHYpv8IpGLmBBH01c7qfF/eEOrggFw3mOEYSKPo3XQ4iyqFU2RtFJ5ELV0qYx6rHoBbD8f9zCo1AOu5Llm7HAvHiFEq4bgBuwfWowtkPeg+E5kbYK2iyAJ3GgoO7UrO5epD10xdX1fnbQGulv9AaBxp274t8Q3qS0pg3bjy6gcWlo+Os+x6jKcSvH4xPVNQ6KnSOJKY2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(4326008)(10290500003)(83380400001)(186003)(52116002)(6486002)(36756003)(508600001)(956004)(2616005)(6666004)(7696005)(107886003)(38350700002)(5660300002)(82950400001)(66946007)(2906002)(66556008)(316002)(86362001)(66476007)(8936002)(8676002)(38100700002)(82960400001)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IARyChbm7QJ/a5azSEG2n/5aJISPpVE+FT1S1UlKVeJmCFZMVfDyShkFIsof?=
 =?us-ascii?Q?ORxJV0gzmAWpmOjZSrsfvUtvtR+5j1m6U8eNEwzAjnwW2p66qa48v+V3uVk9?=
 =?us-ascii?Q?Vvs/eUYUx5InxXlBCpxSJKUu2lhw2JyYZuwCA234SGS3XgPnSSUXdBy+c2J6?=
 =?us-ascii?Q?A54B15kvKnYYnJQCuQeANPx+jsZrnQc7m0545v8udAlZ2X/rYSJ8hEaZYSEf?=
 =?us-ascii?Q?l5CM1nLYnKn9Mc0mmhpJG6ZWWcLNuyCLSpaZXHX1yKzU95hXe1ZmF6DWUN5H?=
 =?us-ascii?Q?38ivWlpW3sX937HX5jk0DWNLL97oW6lH+mOZYwkxmz6vPBgEqIgcJtNlbzdO?=
 =?us-ascii?Q?1M3ABSYuZgUQiGK/k6gm+wcDL7C9UtZVCrIVrg41sb+EFjDiytmh84kEnBCW?=
 =?us-ascii?Q?5Sb0nG9MLkgB5rwxjdHJU8ZdN1AumH8WM4sBqf4MQ42nf3R9eL7EN515hlfU?=
 =?us-ascii?Q?E2FxX9c2ptuEjJQtTNixcUoXlXHJJ0uQUjtRuAmKE/5C6dP8phy+8W0J1fUH?=
 =?us-ascii?Q?RvbaSZDuXwPx8woPiuXrTDUep0OtcYMnS5fpRRX84KlwvJq4zCVxk/RMewUh?=
 =?us-ascii?Q?AVXnRdwCD1OYN8Gf4jLZYlgPSCg/d83++hx4zi84lDYyiP3N7OAIXQgky4Yu?=
 =?us-ascii?Q?z6zWZgkPDm5cSUtFCB6qDBb17gQifTPQp1I/dtopLPicfwV5hMuUy8W+wZc4?=
 =?us-ascii?Q?1HklrT4ch7fyKTXSu1u5lc0FTF2PDmHGgP80spYK7ttOVXRVlus03OF1nkFV?=
 =?us-ascii?Q?FF+/IZuPWPoCm6QiTGY1atMYIDjO9mpJPHmQUUf0xPBjfdbphxYL33Dyyw3s?=
 =?us-ascii?Q?PKd/yKw6K6f1o+pf+KLWfqVYhdH85Kb09AKsH65j79H5hBumpEiG84Kqlx/V?=
 =?us-ascii?Q?K3x3/cgsBl4ozNyVJ5l1KIuIpTpQDmoJ3fshrNRIoY1+MkINWMy0TaWbRYav?=
 =?us-ascii?Q?2F8JVnOgnoS1YwhD7cnTKDc+bTPG5QFmCZC2/9T7ebPUOstZ3yC8iTRh3EgP?=
 =?us-ascii?Q?ExNZpOERmL83urbKvWdfQdP3NysgpoMvO7t2HLVhRDxmY6RzUwAz9ngU0jgl?=
 =?us-ascii?Q?P/wmQuQ9rRYgobF3rnriSEsSNdx8IEpegk+PM4J8LALxNSvNeIQR6V3HHZI0?=
 =?us-ascii?Q?ZUvUIFlh5YJU6FiFomGUEftin4iE563hgdyA9EVlKISdTgiXcwOA6SWyOoDd?=
 =?us-ascii?Q?wwKuFxpRmvIX9Dn18fCJr4uJBAo9us0JE0SKXsO1V5CwUFgbOPWMSNsPu49V?=
 =?us-ascii?Q?DHEu7H9uB6M1QFHFaXGGPmhCyvB3Nl2moEhiHj7uocqqydQxtCVnFd51lYP+?=
 =?us-ascii?Q?eKFcGHyNLefEbJgDkYaCm5k1+QAORg2Ln7oCI8oDHIRNLRFIar938sLuiV6G?=
 =?us-ascii?Q?inQ1n9T0CyinjEtbdh0X24Ylq2wQWzibBco1Oez/lYlKBaMA+rJvzSW8ZsUf?=
 =?us-ascii?Q?yoS/tOL7D20rxwC4jFZfHhGdPyGOA+Xozuj0mbTz7qaXc5RWnbkwiCu++gQG?=
 =?us-ascii?Q?Yr2ld2lInQYnhTxQAJ3fDa9zvQ7LqJC941+bBJegbefrdoiLpTDoouVWYtI1?=
 =?us-ascii?Q?GYjK0bkv5vUT9eRyInphBObusPjz/2SqWKLayRpXILcnJwgICpOXbyKQIZkQ?=
 =?us-ascii?Q?SrUkPpdDEvFHvUykuHQw9fQ=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4105c54e-5c55-46c5-6a0f-08d9abb5daaa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 23:39:39.6643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvTqc6sn17JoRnQXG/NBpnMFGLZSUPzvwpK35iNPiya+lh2eNZZR0SzCfuPt4S8IQ4ikErHDbWLR29m0C0KdUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0507
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARCH_FEATURES function ID is a 32-bit SMC call, which returns
a 32-bit result per the SMCCC spec.  Current code is doing a 64-bit
comparison against -1 (SMCCC_RET_NOT_SUPPORTED) to detect that the
feature is unimplemented.  That check doesn't work in a Hyper-V VM,
where the upper 32-bits are zero as allowed by the spec.

Cast the result as an 'int' so the comparison works. The change also
makes the code consistent with other similar checks in this file.

Fixes: 821b67fa4639 ("firmware: smccc: Add ARCH_SOC_ID support")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/firmware/smccc/soc_id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/smccc/soc_id.c b/drivers/firmware/smccc/soc_id.c
index 581aa5e..dd7c3d5 100644
--- a/drivers/firmware/smccc/soc_id.c
+++ b/drivers/firmware/smccc/soc_id.c
@@ -50,7 +50,7 @@ static int __init smccc_soc_init(void)
 	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 			     ARM_SMCCC_ARCH_SOC_ID, &res);
 
-	if (res.a0 == SMCCC_RET_NOT_SUPPORTED) {
+	if ((int)res.a0 == SMCCC_RET_NOT_SUPPORTED) {
 		pr_info("ARCH_SOC_ID not implemented, skipping ....\n");
 		return 0;
 	}
-- 
1.8.3.1

