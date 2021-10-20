Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1004344DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 07:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJTFwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 01:52:49 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:31510 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229591AbhJTFwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 01:52:46 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K5nB7u013648;
        Wed, 20 Oct 2021 05:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=DW1AHNQbPfybsnklN5Bpm1Dqboju1y5KvRrx2F2ntxE=;
 b=D2MGjRO3mDjICgUVziKLJ37FiI0CPZYYGMiXWILQNcAAgWxyn4u0KZjqK7ky1Asq/nr7
 /yy0LOD72PSVxIyt5+f5VevQrqFKwNooi2DP6I9hzWYddxJPImmKO8MwJjjX0r7Cw0MJ
 bTaXY0gm7tNMUgCI1SjuTN7wi+XpHPC4PRkNdKi3PTVs9miWLV1NtdZgveOEcpcrRZ7A
 M3LDUBiPzO/S1Ox5Wnc0uuFiY5nLvkS7MujZsP6UzaC8jiQ858Tu5HgbD8JZ0gEAe2rJ
 PZutC1va836tWM0aaY0QFw5lVQWrju5icx+7ftpgzVbGHs22/5K7aV5jCk2tl92dm6d2 Ww== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bt3d18d8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 05:50:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHoHpW4PdTmrmQmVwRodJO5yUWRJjOPxFqfEDwnP/AJcjdJdHUJWDOt68kaIrnNDLsrf6oa6xYrO1dXc0W6GHkk1laOjtZFfHZXv+iNSZTSGE0DJYOtFypXwBnDXY06KF5KESeiOf7LmL11hsYQzz4IpLMjH+Na5LcwfDanEk3+CfK4AGltSAGJhZN4IsQV0rCos9xC1oH+2MtiNCJ/SM3mwKE4LGB89bcn8MZOQijFPt98hvGJ1dYQ74wxm4KIsjm7NX5e6SW+FUd88hQ/JEzB/5jqM0pg8OLtHjVRwV3kzil054Zf/P4sX0QVNMTGvqo2krO6l+HV0G6kf0ASq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DW1AHNQbPfybsnklN5Bpm1Dqboju1y5KvRrx2F2ntxE=;
 b=GqwRxeowxt41aBgfSoWOV3+C/qwb+y1PVMhXMjCLOEsRRF/rF/IuvT+UzXsaUaO1x+oVreDlWGJOmrDwdwyKB6kThyFbQ34olAL4noCc0bokpYFmSo4gw6gorHBMs5aFRMsK5UTbopWcnSO8SMJI8c9GlKwhWUdjneFqquxCgLBjDmAqin6EAPhY34etmVdc4U1/msYSXp1PvOhRO3GSFPtyKezXieyyLWXq5bnTLUpougbROGRqOkTqcVs6OJ9AbU+EE+OAISpsnvqcIEIQvxtSHUl659a9MOTafqMhyRnI00TuOxfb7YjlMruV56gbDUKVpTOkfyXeGIQpXo4HrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=none action=none
 header.from=windriver.com;
Received: from PH7PR11MB5819.namprd11.prod.outlook.com (2603:10b6:510:13b::9)
 by PH0PR11MB4936.namprd11.prod.outlook.com (2603:10b6:510:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 05:50:01 +0000
Received: from PH7PR11MB5819.namprd11.prod.outlook.com
 ([fe80::3508:ff4c:362d:579c]) by PH7PR11MB5819.namprd11.prod.outlook.com
 ([fe80::3508:ff4c:362d:579c%6]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 05:50:00 +0000
From:   quanyang.wang@windriver.com
To:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH] ARM: add BUILD_BUG_ON to check if fixmap range spans multiple pmds
Date:   Wed, 20 Oct 2021 13:49:42 +0800
Message-Id: <20211020054942.1608637-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To PH7PR11MB5819.namprd11.prod.outlook.com
 (2603:10b6:510:13b::9)
MIME-Version: 1.0
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK2PR02CA0148.apcprd02.prod.outlook.com (2603:1096:202:16::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Wed, 20 Oct 2021 05:49:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98483381-ec54-4672-d951-08d9938d7488
X-MS-TrafficTypeDiagnostic: PH0PR11MB4936:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR11MB493672A0BC13CD88902FD24FF0BE9@PH0PR11MB4936.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apbXEyx9eLgko9WcdZLQXPy2TdK1++ADLl4DhIw2yYSAtJb8+vNJWd/ExlsfacenUq5sUVM73qsCPuCNIOChepk150TyXAQT9tpIwxGmpVfVX/yOS1AMngH+YAdKsUKN58NYkPgGTjcFgT7TZAsRMCFCxViWAraDpi09p8QwSZYm4c25oOxwZmWdSjOvpn75qUDXoVfOGOvsBIDimPXXWMARez1rtEDC+FmkAr1yC58HeB0hZm1fAPzpppj6ypkUxhxT3bdXEe8H/M/S8RFh4HKsosqkfhgYX059h2NE1Kgi8xzDHA4wQ1EW15F50HrbfiO8CSY9ZsZdd4hLqvTptH8c99x0pguZIX9Qh1c8voOHCRW18R0Hne8XCmFXx8QbfyT7000hdoaxWCS2rCkIOURDxzVkQ3fTRNIswH76HnbLeTNVYtfvXQ1knA2cwQzMYbgfzGew0MVH905tiUjFZnexwNcdjqbIcj1//7jjqaUNB01Bs/I9rOGg/VjvGXiuZ7/cew77gZwHp1b0gXK2inuteX44/N5/Bw5a1D8qotkWCgD/kYD45a+CGt3Z6gcm+idh21DHRz7yDqOOgKqCqbjlp/1gFiPN1jmP0NaJhpeHgKWpJSZlRGoEgkXYsXUhs+7WipWNH13nDgGx7FbBwpoT8eOa4964HNhHfQnfs4y4RSNCAmJBPxIlXffqnzs83jDOOTumjeRijS9hg6qi6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(110136005)(107886003)(36756003)(5660300002)(2616005)(6666004)(6512007)(66946007)(956004)(9686003)(4744005)(38350700002)(38100700002)(1076003)(8936002)(508600001)(4326008)(6486002)(186003)(26005)(66476007)(66556008)(316002)(86362001)(52116002)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0qY7u0ktq4ES6ZYf8+1N6MsA3qSL1H1b5p4dU/92/Sov9a7hDbio05Jv1nYX?=
 =?us-ascii?Q?4nivHrIkh6UZgN0wfpW786kbGyR04gxLEh9CsdTEibyR5leJ3rZdtwWW7YNk?=
 =?us-ascii?Q?Vsen4xsAMNbvIzXiVIbb+fOaS11ciamUTpuBme7UkoigniNKNnj8RjTvqrZk?=
 =?us-ascii?Q?yqSKb+Rb9QCmebAFjDMzSNAupMVL1Z2TIz/PWPwjg59OM37XjEJGJNZZIzOY?=
 =?us-ascii?Q?4jz128cD3c6YAWrElRPh1Ky91mvy23Fl1HXWNA+l8OnA2muPTdzS/sgK2y8V?=
 =?us-ascii?Q?893vjOCWtOTbUHI4E6R8mzGyYIbovtNPWBftVx6LjMRyk2sLHA2CyALDSvHe?=
 =?us-ascii?Q?+e32sut22vtYqgJ31X8txJsZVlDrTAhUY0z9MROboKWTfBVmTotpjof+Mk5m?=
 =?us-ascii?Q?0g01jWoWQGqRaHGIQmeX3fl8slwiJVUYW4xTvTjlgohWuxNI54maIhTRX3C2?=
 =?us-ascii?Q?dP2fTsGQ1kIlN7yoootId3G/OWqQUBWntK7/O7nYrLwO2gy9u17noPbTvKgg?=
 =?us-ascii?Q?gL2xYASaJtVY6GH6EbBFX7/ttkfRbrvhwZd1tfJ3z/gw2qy8jEncj+EcnA1Z?=
 =?us-ascii?Q?URn1QvnuNyxHpI9ZFqsBrc4WD7pNXF5kxot0QQOaHx8Qu+bsp/ydbwhnlgVN?=
 =?us-ascii?Q?OGTbSKf2zVdnknA5RCCnFldhPvu8uY6WmeBF3PqRWdzAxgVA8OvzlLhppMBg?=
 =?us-ascii?Q?tdwVWAkbRDWcZnNi7dexueh/aBYRx/oJQhsKmBC6xidpH/s4HZcGufUmuQCi?=
 =?us-ascii?Q?qHxaXHmtPCt3a4y+TXHI8U755BgVEoEBi3HtFnEuGuFIyJLswdyLgv+Z9ydT?=
 =?us-ascii?Q?+eIQMDXJMwcaAqeI5DgUJzRQzb80OubRwV7t4aDit04biEmyC5r0vl2EPYYW?=
 =?us-ascii?Q?mc34LTAVOAMzpd9DIjft7wI4o5S0Q88ipToG4aNN9vqhroEuB+cKkkmJYlxG?=
 =?us-ascii?Q?pFLUJ/2jSFcsVh0CXaHhZpGZvZlbrCkhWThXfx/aLCc7mcOvA5G2wfX8yVZg?=
 =?us-ascii?Q?Nz6mcSd8trvaoduZCUgBv+Ew690tBC1tRwKmebjOSE2HjNm2j6lgPbDseL22?=
 =?us-ascii?Q?vi2sTDgoDOBiQ3/7+Nk2P9crY4LaMw9ZQ1mB0Y0Vmz72fBGD/S+DnHGOYVOe?=
 =?us-ascii?Q?Wpv7WNCUiVR561+TuZFPD+gsSjxBW3UFVoIo4oFW5TxVH3Qa1fIX8PgCFA8K?=
 =?us-ascii?Q?RPhD0+KGqu2LjJR1agDYXZrYz3O/NVx+EV93dPNw1bhLJPyY2+7vi+O+72w0?=
 =?us-ascii?Q?XH/RGx+G6gUxVaCdlAffkPubGI80XajKck6i/GcUVfXg/wPjAMhgHi4oOcAW?=
 =?us-ascii?Q?hMB1sGegHemYAZXup/GMt3vJ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98483381-ec54-4672-d951-08d9938d7488
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 05:50:00.7400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quanyang.wang@windriver.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4936
X-Proofpoint-GUID: OTii4oecVS7xiWMjgr4n-QrPniK7R7Ns
X-Proofpoint-ORIG-GUID: OTii4oecVS7xiWMjgr4n-QrPniK7R7Ns
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxlogscore=877 impostorscore=0 spamscore=0 clxscore=1011 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200030
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

Not only the early fixmap range, but also the fixmap range should be
checked if it spans multiple pmds. When enabling CONFIG_DEBUG_HIGHMEM,
some systems which contain up to 16 CPUs will crash.

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 arch/arm/mm/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index a4e0060051070..57eed92073a4a 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -369,6 +369,8 @@ void __init early_fixmap_init(void)
 	 */
 	BUILD_BUG_ON((__fix_to_virt(__end_of_early_ioremap_region) >> PMD_SHIFT)
 		     != FIXADDR_TOP >> PMD_SHIFT);
+	BUILD_BUG_ON((__fix_to_virt(__end_of_fixmap_region) >> PMD_SHIFT)
+		     != FIXADDR_TOP >> PMD_SHIFT);
 
 	pmd = fixmap_pmd(FIXADDR_TOP);
 	pmd_populate_kernel(&init_mm, pmd, bm_pte);
-- 
2.25.1

