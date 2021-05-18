Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CDC387736
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348752AbhERLOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:14:35 -0400
Received: from mail-mw2nam08on2040.outbound.protection.outlook.com ([40.107.101.40]:11008
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348768AbhERLOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:14:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEBntS7wFFLX7aq1auyULFA7Q1hBIwJ7LF4+OUptBrw/aoMLioTouCHe6aPO7bPa4UOf0YbbXfZKilNyln3RClAK2wqDxjb/A52X1UFhYasRXK+HQQPoLXr/h9ASheDpv5DN5wz9dn8MOQGHGl/n+jAJ/NhcCtv1InWvYmkNmRP6oHEl93qBVM66Tu9jjwGUVGXjvcUiRhWa7SPLo083SmB9Xeo91vN8pKE5GFgkeGvUF327s/RT0Z5xcZXJWhlm95xvJrf4ZCU+sVJ9tRl1WzeJ8wOxyWsEC7/pW/cSF7X+Nid946ZR1VsUsGXazWi3S32/I+LzLCJXhWPLHLwPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAc6h7WJ92NjbGIokpVplkVOpFUx97A2cx3fXNl380c=;
 b=NnNBZvMTPXhxMBSG5Tmub+U5jFcHxnkM7hQVNwbCfa3VNK+Mk+5Efx9Em+aSGpIo7Fs+s22kIFOmx3gSsI3ab++S0v311YI/FDb9anoyPnF/+K4v6I+rH5nlYyMOQZptysNNKWHsyFc0Ks3ySShlNMxfaJfa8PYG9dfuTd1bOE+lPEi2ehYNE1b8/9lMZ+pHHA3qIMbKpiQjEtXcBuiXVEhfzdvpVBn4iZqjnKeM16ykCK4TSoAJnilOjFoBOx4KvrdM+hBqU7gxwVZV59PHzs3+QzWTNluUtJedJAB+V74o2deeK8iTv0kjJoG5EgB4pfVSGYTfpmswBr4EiQlhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAc6h7WJ92NjbGIokpVplkVOpFUx97A2cx3fXNl380c=;
 b=b0MPOWAFiWAn9o8lj1upsAgBH4Br6vkQqgVTZW+vFY5i84drCQ5JXCwPf7tiN0kC3A5k3juDUWT5+nY6rz5JCiNpaCq8ifrBmC4dfPpckLjfR9SISQyUgQNBBWRQtzWaGpevPzKang2wGoB231ht5dspahBVbcbxT0/Gs6O+wVo=
Authentication-Results: armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB3912.namprd11.prod.outlook.com (2603:10b6:a03:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 11:13:10 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 11:13:10 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     linux@armlinux.org.uk, rppt@kernel.org, ardb@kernel.org,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        carver4lio@163.com, tiantao6@hisilicon.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm: make the size of vmalloc in cmdline and meminfo uniform
Date:   Tue, 18 May 2021 19:12:54 +0800
Message-Id: <20210518111254.3820480-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0177.apcprd02.prod.outlook.com
 (2603:1096:201:21::13) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR02CA0177.apcprd02.prod.outlook.com (2603:1096:201:21::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31 via Frontend Transport; Tue, 18 May 2021 11:13:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da8366c0-168b-4203-6161-08d919edeb8c
X-MS-TrafficTypeDiagnostic: BY5PR11MB3912:
X-Microsoft-Antispam-PRVS: <BY5PR11MB3912D877ED2C15EF7C56F4DCE42C9@BY5PR11MB3912.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:338;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dzplt5Yu+cWpf14jeQM43TZKWqvXdmAn/izV7lts74D4GhaOY3fGDqngWrgDHocLnbw0wIRPuo5vqAqwc0dUk4jp6pSelPIkkQWpGQcKZIstSDqWnc8odM8goWBkPkSZ3L4As31TTH6MNPK4taTdG62sfUVo6DxpNdCFK4eSCQdXIBoEArFwsjUYvl6PzFOHN0YX+Z0PGDTCLwySDI0yVU9tjP5FnX/0BZKwABnYxWMBovSlJp54qf/7/UHLhtfRpYhDTAilMmj7L/BwuvLOXOswlGr7sxzijR049gFOVud9PfgnNmf60ecuVbAn9viP7IdDpIcOmCc158tSUPl0aHOacGJNHTRWz3jQs2+c9ggCZIwwggoIQhf4Wz8smEIiiNPZEC9MHNFvU7OWxTTChQMYWWk513Kw8FApqTDVrzjO+MVbj/TYFtTaikQE4NyOWyy12g+tTs+FN+UUNJxzDJsUwk+i/LSarH22UqKT75CA5puQ+pyLyOnK4rc1L4hiypuQl5QewOMTNRRO1Gm0yHsCsCthSUQAF35B2+vi98ayFYaD0vu6lXH2dz7EnieMVf5O8frUa0IaKjV22FSDRFe8zE4j4KuHUpUFbXYssLs7IWqpgR6QzaOwAxFIRVFwW4PzI6N0fijHHL8b3QpC8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(366004)(136003)(346002)(396003)(5660300002)(2616005)(6506007)(956004)(6666004)(186003)(16526019)(44832011)(38100700002)(86362001)(4326008)(38350700002)(66946007)(316002)(26005)(6486002)(8936002)(6512007)(52116002)(8676002)(83380400001)(2906002)(36756003)(478600001)(66476007)(66556008)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xgPYYIND9AVIjLPcV26T7Df/71ozgG0WplPlbTHtVtoRvvxLHtksWqv6oK3t?=
 =?us-ascii?Q?anZVuxVSxsguGW2Efn+nuf2yDPs05GNPkkeL/GRRI42k2412Ts+jB8qaEdcL?=
 =?us-ascii?Q?raIeVHGIVA7WmFUTgRWNXH/iTjzZ/TuvhG9KbPnPl3TeiDWSaBelREe460Za?=
 =?us-ascii?Q?BOPmZQX1DfSYatBFjfw+iIxt4zbMupPZyN66OGiPXXYAR0Fqw+PkzpVX+avW?=
 =?us-ascii?Q?LYKIKJG/sqC6MqO87lKWejYFDanK1GEfTzPLr+By0pCAYQNsEhjYXlpJJjaR?=
 =?us-ascii?Q?6o3So/YD5y9sVNDbfHIIfXYvhjTn3hAJvSCqpV/uOJ2YqgCQHlRnA5StELg0?=
 =?us-ascii?Q?4L2984aNOQbZ8z2BA/giOw7s8EOZJQLS2YTATOszsAP7UyMRYUVCqErShhbF?=
 =?us-ascii?Q?jRo58OgvNDpBqdPrVAS2DdGXzfuEiSCR8qedBiwy3CQHH+2Bc+bb2tD1gM0D?=
 =?us-ascii?Q?DeCag246CAG+rmKGJ5vfe9zYBkYVJ37izMbhVSN9QiYzXZIeZorGQLxHvus/?=
 =?us-ascii?Q?DMvcTNVC69oejkYBBOSIkO0/r1YrE2zvneZ90cq+zM2Sk+NUxK+TSNy4jYrK?=
 =?us-ascii?Q?1oWIqyk/7MAeqFgtqFa4E57K1zraAkgAiiYnjmS+n1ScRlGbgvWh3P56cAao?=
 =?us-ascii?Q?qmq+6tqjn5W+O+lSeDtl6zcMYe+2xQQRvzVHkFuPrTYuEgJf99dKN0/dr9HC?=
 =?us-ascii?Q?gRu6GFbsWub3vozeczrvdnf6pEAdTaGrIrGLUxIg0ZtwQVniPTnoAulrr4fM?=
 =?us-ascii?Q?W8dMFSUmNR9NlnNgIEA9/FdVNVSbqmEzznSKzU8ibASGmBq1NaTuggV/J8mb?=
 =?us-ascii?Q?mUaK8YpzqqHjxtowMBlgilPhgdJBgw0laPHJpI25BuAK+Ll2MH5HdNm3qGIX?=
 =?us-ascii?Q?PZ10xGg0EqXILaJEEtwzIwV6ISD+OagmYUO0j6iRqMOBKm2+hUQ6y/zRTklx?=
 =?us-ascii?Q?oTPgim+QeWZtZ+vi/5/C1jAc/5PY3ZHMmOB+8LTCIwFCOR1izLMhJAYJ3z5i?=
 =?us-ascii?Q?tr87fgGURfmJvtQakzq+j0dwBTVwxSFMu/VKXU1m7vpYVtUWeMt5hpKLpOo0?=
 =?us-ascii?Q?gz9sartFKEMfHsAU0hstdKPVDDhEwbHQbV0kDg9/DjM8Pz/2EKXn00OFKOiA?=
 =?us-ascii?Q?l7nckhMMzCK9UixwIoN8d7VOK4HcDmzfXXO59FgwK8S9mLV/l4w/BBRsqRmB?=
 =?us-ascii?Q?HVxRbjdwuAmxLgSXLhZQEEIKU+/NBq/2gRSEOcRvhmjmuJ3ZBf0xegic8OLN?=
 =?us-ascii?Q?KBLXJX/l5Z7oFDQuJ5elxVpyDO3NTbRYhSdj06DGQqpKfy49HUIi5AU7wQSd?=
 =?us-ascii?Q?wRwXb2xZ1C6AKTRqSpTbae2R?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8366c0-168b-4203-6161-08d919edeb8c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 11:13:10.1403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IID9p5ET9J38qadKvTaACnsHUcqMXjoUbSAWz7ios+dg0PwTEef823qDhYAOUVtLB51QDmnOmit+NtgPj1xuuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3912
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of "vmalloc=" set in cmdline is always 8M more than the value
of "VmallocTotal" in meminfo. When use the "vmalloc=" parameter, user
expect to get the size what they input, and no need to consider the 8M
"hole" hided in codes. This commit make real vmalloc size equal to value
of "vmalloc=" in cmdline.

Also, the commit will reduce the size of vmalloc printed in boot message
by 8M when the size set in cmdline is irrational.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 arch/arm/mm/mmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index c1e12aab67b8..287c5115af4d 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1133,19 +1133,20 @@ static int __init early_vmalloc(char *arg)
 {
 	unsigned long vmalloc_reserve = memparse(arg, NULL);
 
-	if (vmalloc_reserve < SZ_16M) {
-		vmalloc_reserve = SZ_16M;
+	vmalloc_reserve = ALIGN_DOWN(vmalloc_reserve, SZ_8M);
+	if (vmalloc_reserve < SZ_8M) {
+		vmalloc_reserve = SZ_8M;
 		pr_warn("vmalloc area too small, limiting to %luMB\n",
 			vmalloc_reserve >> 20);
 	}
 
 	if (vmalloc_reserve > VMALLOC_END - (PAGE_OFFSET + SZ_32M)) {
-		vmalloc_reserve = VMALLOC_END - (PAGE_OFFSET + SZ_32M);
+		vmalloc_reserve = VMALLOC_END - (PAGE_OFFSET + SZ_32M + VMALLOC_OFFSET);
 		pr_warn("vmalloc area is too big, limiting to %luMB\n",
 			vmalloc_reserve >> 20);
 	}
 
-	vmalloc_min = (void *)(VMALLOC_END - vmalloc_reserve);
+	vmalloc_min = (void *)(VMALLOC_END - vmalloc_reserve - VMALLOC_OFFSET);
 	return 0;
 }
 early_param("vmalloc", early_vmalloc);
-- 
2.27.0

