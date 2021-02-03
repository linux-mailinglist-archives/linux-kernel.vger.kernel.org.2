Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA72F30D2A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 05:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhBCEZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 23:25:18 -0500
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:24512
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232629AbhBCEYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 23:24:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VObtyokFobYKfWgi3YF3KhMOICmrzdzuadzb+3VNAifiyxdhIkys2g49Nz0OOiGle8vWwCHZagToYzqrv8j7B5mmPvL2OiH5L67tQfZpJ72UKI0Uh/gSqc48sgCk+7qebsPcvHR0DzDNCAXLTZhSRny9BNhSvZ3E4J7PR2M893WT4yajaESnmpvsydaxDqo8FFAp+9va+ZkNHkuUNIeXWhNWk8sDsYyjxi2fuZzxcudvty0X1EEOYEIt4KhN75GhuED827VHkPm7QsIBcYw3Zi7lMrFdRGV81AcyXmLltar1krrSBidnBht/8xEdnSXSuvW+aNSYk45+pKHx13YxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xy2ievFtS8mlw6+04NHXBrHLNcWQXHvdLt2t/yoBg20=;
 b=JCuxSW74gYhp4t+i+1EOWn8ivdy0Ko20sU5GysCSgKJrBjfPxtg33sr5lE+KeLmxViw7DNFZJpODG7EClyQaoH09b5gn2USx5Yv4Rq4pBJcfCKgxw6Xg51BjOllEu7VzU+s+AHAm/xwQcyXzSQf+HmJjhp7DvTuexiU55SfuiVEVmcrnsYAYs1PCrlMU5oVyNkf/vtkwU4cBn22gwZQnKMZOmpjP32AJ3vQGKGN+rXoSjtL7d+w9BR2hz53kEuV1jdqigWLocZSfC+Ezmkhtdm71923pwRcWxF7nIZBvd+eAIZNFxqPz4TUaMinIZBF+cffe9G5EiOwRb8xaJKu72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xy2ievFtS8mlw6+04NHXBrHLNcWQXHvdLt2t/yoBg20=;
 b=mKoBNkmOsg5384ROC4v0eHM/Q2EDN2mzHMc8IAOm6AUGEO5wIOlMlwSyCASrI6dlxyxq+SnwHj8hClkCv0r7fjdDoCUcdfM+RSuBTZSppii2oKvWisHB8XpS1SSkaaVRTdyPnYlO48wJJfL+m8o6+3Gmx5lrN6wWBJ5wx8E0lSY=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by SJ0PR11MB5069.namprd11.prod.outlook.com (2603:10b6:a03:2ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 3 Feb
 2021 04:22:56 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::95a3:653e:2078:fb4]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::95a3:653e:2078:fb4%6]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 04:22:56 +0000
From:   yanfei.xu@windriver.com
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hugetlb: remove duplicate codes of setting compound_nr
Date:   Wed,  3 Feb 2021 12:40:55 +0800
Message-Id: <20210203044055.89618-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:202:2::12) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core1.wrs.com (60.247.85.82) by HK2PR0401CA0002.apcprd04.prod.outlook.com (2603:1096:202:2::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 04:22:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39f42c72-5bdf-4771-e2ad-08d8c7fb618a
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5069:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5069904D83667183CA0D6DE8E4B49@SJ0PR11MB5069.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:274;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4n/F5GbA41sy2ggmUq2dKSL8sutayBGeLscemaXvsMkdN0qG8BxtqCWo0AOlB0QN/o//4OPlSMvL01EFzixe/+p70/Emydvn+NjGiGTidoors8p/1Tpq16m8UMO6bPmonq6Nq6Scxay1dcHXtGrjMCnp5zmuQzx43D3psYKi9Y0AKWB1XKtLCeBuh0flNlRzOkXkYjmrbzB1EPPAxVYxVTTYGCbrIFXPn7RnZoDuhxMETA6wbxDljIwKhC4RwsMJhBTGOatRmiTVrR8w7jVB0m0KVvYzlfBf9rnD70P0z0RaE2jlZGhZPnkrNic+xCJgdtEVrw2Rk7HZ+OODVlsAoYJSfnoPhsNk7DHgDoFDgxJyEXEWDFvU1imOrLnUHgPlijoiz+q8vggIACAOU/gVtnoDanCtixYYDiXNDpS6FQyIKfEV78m250+E0rfNoyurgVpCzwfWv3jOFZ8ZlL2cP1LEiUOLf95Z5htwzVdJkOcNyNuwkz6QNogbtFODvHMtcY7aXo5ZiE459YhDFfOCbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(346002)(366004)(376002)(136003)(2906002)(66476007)(86362001)(6506007)(1076003)(4744005)(8676002)(66946007)(5660300002)(478600001)(26005)(4326008)(66556008)(16526019)(83380400001)(6512007)(36756003)(52116002)(316002)(9686003)(6486002)(186003)(956004)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4AsfG6GQM4EUHyEWsE1n/MbY47Ai+QqqMeVvP/faVvGVlwxD8e9AvUo/sgzT?=
 =?us-ascii?Q?pcfq1nb+gga0lBwqTdy+iwb7w11O19cEqibJWDNCBg5SNPYKNkqXfo6vnwgW?=
 =?us-ascii?Q?aLvBs/25/hT+hAeq726TBBf1ZSZezzoff/IJ4gF5S7CxWkFV9xu2YFqPJkrY?=
 =?us-ascii?Q?fusv5OS6i3tZpTWpoHqn1sWHf+025rFJABXhCjvGOuOGWWnGg09YOrHJYPYp?=
 =?us-ascii?Q?WCc3/Bid8Duvxs63y7huDtVOFAy++njTnlt9KFZQao/0m6amhv/Q+xUG++ZK?=
 =?us-ascii?Q?R8idzVFroV3woUjRsuFBieB+uOLgkKkAWtRjAEqxzTSrjpt9xh452NC9hXf6?=
 =?us-ascii?Q?TBgsQ4YpxIBNMRfZLVJuJPpa9hfo7Q3a+c+S0LhN3MjBcyY8+pQZqmlnwGRz?=
 =?us-ascii?Q?psi7Vm3WTKGIbvhSryG3PGofgONAzUOXUpgm4rvSKYGFGJ1KXRu6lijU7lyb?=
 =?us-ascii?Q?kTZKf/IZNd6V/URUiMdCVAF1Z3ac00vnDSMOPTfM3CIQhbWEB7LyLOxLVph4?=
 =?us-ascii?Q?4BZgn4LxLV+OZEoINC4DyP52smtRqe507N9amN0C0cgE8v2EkDDzMRHxmA0Z?=
 =?us-ascii?Q?C5VOb+p/lmz9gRf/JvJZSM3ojf9qphXAy6OpzeEp1KtSS42wPIdEsMcJRRFo?=
 =?us-ascii?Q?bYhmqIfTwSHHWvqFrim7oSe5e97TsMCsRc7hxPCJeSPCFijQKB7tGiXSyQIt?=
 =?us-ascii?Q?uzhK+WmOhgle7SODDIJc2sy0+VuJAZjmVR3OyXFfPmKl7Uf1WrkbgoNh1sTW?=
 =?us-ascii?Q?cQ7PWls0wNP+H4ZTo8PjqFaBs4w8NbUxUCrQhDyLc4QXFRQJKg/66ggL2wFv?=
 =?us-ascii?Q?BAN2VDP/1gxwF7KS/7InYaefx8dHHX1DH/zcQibrNW2/UnW+JTw4cutYtVKi?=
 =?us-ascii?Q?/zKqlVbb7BflwHfHDFvmZZjE4t2Lj5Rm+srP2FHrM6a4So+4ZOuCWCZ/voTn?=
 =?us-ascii?Q?P3h5AAUmuxaPlyVuTnT6E0p/hDnX2mWGuHTcFCZ9RUCLKTejwuKCh1DmyMWW?=
 =?us-ascii?Q?Bbh3a+94jHvo4kVtI7YZCNXatIt7GcbZYy3/XARovy3ELIjeUZIQ4vfdHfMf?=
 =?us-ascii?Q?LDDO9/z2?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f42c72-5bdf-4771-e2ad-08d8c7fb618a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 04:22:56.5572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9PBCGRknBaSh2HpjM8pYmFAZGtEX8wQK8Sau1CFUzGkX73i76Mo9pQStPoSznwtgAymwuTOHSLaySR3s7rgzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

set_compound_order() set both of page's compound_order and
compound_nr. It's no need to assign to compound_nr again, so
remove it.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/hugetlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a3e4fa2c5e94..ac249b1583de 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1228,7 +1228,6 @@ static void destroy_compound_gigantic_page(struct page *page,
 	}
 
 	set_compound_order(page, 0);
-	page[1].compound_nr = 0;
 	__ClearPageHead(page);
 }
 
-- 
2.27.0

