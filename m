Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB7E30BC7E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhBBLC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:02:57 -0500
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:47401
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229572AbhBBLCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:02:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJrgwiepmVNE8rYbFwSeXHOKugUiguJDs4FgQrH80NjTlyo8uFzwmSs+usIPyxrpF367BC5yCVKGjdhu/8KU03EDgxkqlzE957gUPrwUDbZMJaq4kPRFH7jrXOi+wwgU7BNLh1cWepHCSvndVICHVzDpPjqI+ixXCJwkcbcIb8uK7avwqHWQ7ntx5VAUsziFuU1EpCQ/bJNoNABwXau/HGCfBnj/mKi+ipS0DIGVlQAc8SJ08ye26IjL7lYXNQkrrpfY6/fcOtdwcnYTM5Ld3Cf7eKLDYENDG5SE+sofCUvAFIGG0h1k+pV7ieqd7sdmOn3aLS5uW3m/gTWkEbD0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+uHE5Qz9H2raBQAUMd8/MKlRKPLc8Czc9LdJosz0Yw=;
 b=BZsB77BbtXm8zmHcFvwXkB9xwRWyn/uZ4gWrVFYJKlnepwL3gz9OmnaomjYgeXCXYmlXdzBH2CHanRuRC5hubtww+b1NdIhHmEeYwCtTdojjkJ8vKlUb/73qGDOC+vV6IhPu6bmc9mHCd9Pis/Re0av1hlX3eOcPObjg1xV92556moPHbaBBfw4kezH62eVaVCJ/4/G1aS+PJw7UWYnGKP8iZJEbcy/r+9w5e3v26a1JfVJ7GIx+eG9BlQrOI2S25dZhPKGenetbtX4gjfgkUa8eDVmp9UWhTKpb4nhBUtBenbDRMwQ7dTMtRiYdaxMnQHME3BXQtHtiQYY0/jIk+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+uHE5Qz9H2raBQAUMd8/MKlRKPLc8Czc9LdJosz0Yw=;
 b=SpAtFrP3Ius6lYEWGw8w1QXptesXyQpiECydetX1V9pduvDq0FaO0yopJ2Q+kxVqfBV79X8VBQaXZk+J3UYJ+MyC7QvOa9BBqWoCIhjAGhxnJqXh3XX9xVQdlayWqae1Li/aHGSj0M2X1Iz5VsLXQrrga766k2ZD5oDU7a93nSQ=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB2678.namprd11.prod.outlook.com (2603:10b6:a02:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Tue, 2 Feb
 2021 11:02:04 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::95a3:653e:2078:fb4]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::95a3:653e:2078:fb4%6]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 11:02:04 +0000
From:   yanfei.xu@windriver.com
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/hugetlb: remove redundant check in preparing and destroying gigantic page
Date:   Tue,  2 Feb 2021 19:20:02 +0800
Message-Id: <20210202112002.73170-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:202:2e::31) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core1.wrs.com (60.247.85.82) by HK2PR06CA0019.apcprd06.prod.outlook.com (2603:1096:202:2e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 2 Feb 2021 11:02:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1f705e9-2318-4625-a836-08d8c769f8d0
X-MS-TrafficTypeDiagnostic: BYAPR11MB2678:
X-Microsoft-Antispam-PRVS: <BYAPR11MB2678C27ED0687FD84721246DE4B59@BYAPR11MB2678.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:72;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b1InoGjty0fAtESrLElYCxGiY9fFI1PSX0304pN9pnXgI5QDlSqdTZEAH+aLwM5oHKqgm2NaFu2iomlP482i+BUQEgq5Hq0n6Yk52g8lDzkNMSY8ssmoCzqqwvJsbm0BRYC0Gob+Z9umuu86w6yHWnjZ2SZF8O43oB7CmzCB8x5gHIkgWxjzw9Qc/0k5OeEaLnld8CjqhJFzLMEIDlPAt+J+kz4iWeOjjs8PLQ3XJlW9Gsepkdp/JtR+X1keaKjURycQlqHTK9eMWPfUiSxeG6icye6HE8MG478KMUCzeDuc9Gl8Yj7FcOl9453HvDCTLYHpuoEJAtWKvAqtHDRWn7d0gZNfQMMr4kSWC65rmfmQiSHcmpq2OBox+ltZeYLMvApd7ED00pK/4WzeU4MDO7BHlkhsMubF1cQC+LZiUM15UhC2/TcaNBVwXEh4dtwStGkgWqygwFyWmj/cV6B1hslS8VR69EPklFN7ssDCjMqdpV6BsBYAkTjbh1jG6Gdzmhz9cIBSzPxByl8bYYnnag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39850400004)(136003)(366004)(16526019)(186003)(2616005)(956004)(8676002)(86362001)(2906002)(6486002)(83380400001)(26005)(8936002)(6506007)(36756003)(478600001)(5660300002)(316002)(52116002)(66556008)(1076003)(66476007)(66946007)(4326008)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+3hX7QG71unt8zjZlUB8zUAWOMZOLNQi1H81LdVKpDVIEP8Tvqn933FjUten?=
 =?us-ascii?Q?RLCQELRMs1LHv54UyQbkkl56GnBbBJhe+v8Mt1FVLbP1uS012RM22LbkKmX7?=
 =?us-ascii?Q?FlrwtBtm4cjCmvRLWRG6t9joXJ3u0sdKZI3lIGAxMM4zv3pKzHIISR61QEDb?=
 =?us-ascii?Q?AuZm4KOttArfncky7b89B4HtABZ3gUwTLTEG3F3M4KWtGRQvDiklvy1s76GG?=
 =?us-ascii?Q?uqAGt6tj/j7dbW2z+Va9Ao2vVQDjsgMfpUJjWtD/Z5OzlN3/GX0mqKZTa2Qr?=
 =?us-ascii?Q?Plk+asgcMPD3WtlTnspaDLQvwOJwS+ZlwKecDKwYHDSjc4suGmQx3BAPiRy8?=
 =?us-ascii?Q?BriSgMoAJ2abtJhjlXEJ9yaJPqMIWkn9TdtZMYRHL2SbN4fu0TXAiPnIx19b?=
 =?us-ascii?Q?jaeOSXHBUh+njJ1E/0Zl13zxACS2W9eAxMrPagGmn9TQWiBdICLQ6+OTctqz?=
 =?us-ascii?Q?HwS2dcJDvd3Yva6uu0PlB4HKbuoRGtMqmCqFedDXdkHXBExSfG9XHbW1w8SN?=
 =?us-ascii?Q?jm+cQHPehVZVLMoKLs5dgdGk1/wBaV+6MzAPC5cCFiRkTohhO26ZhBbmsRzg?=
 =?us-ascii?Q?URx1OnTmxJdPVpVJxm6H5kHMnZSvG9u0/WpLGGcZMMPxmm3jslyZu24VbzwW?=
 =?us-ascii?Q?yWW7Q+8H+hF7mDwgIpwR/ciblFaS9l+ZU7DhIgEtIHbxgF0nUusit5rhL3l/?=
 =?us-ascii?Q?4FwX0YV2siV5qNa9KthKRvzYgUBnbYndO5/w2nSgLCP2J94rvENwOHtmjm5n?=
 =?us-ascii?Q?vzLuGwSUAemEfG6jyGPGBZnbHp5ctyPIWjghdY/2MW68WCQNJciWm1utE43o?=
 =?us-ascii?Q?dlle/9ZJuHsJYErZqkFQyj1rfWf3U6KI+gt35G3kREsU2NWoLfK7NF2wPvw5?=
 =?us-ascii?Q?7k7rb8vO+jBUh/rsKy3bedcZmmmu4ZbQZG0jJgD9LjTMPh23ywxrrThTSjSN?=
 =?us-ascii?Q?9xQ9j2xt0R6sX2O83IaVc1sSTthHzC0qRyoOb59FApSCzw9PMuOQPc95D+P/?=
 =?us-ascii?Q?a4Gj7suGPaIQC8WHC5foUss5IkSbrp0h49s9kjrJlhq4/49FHKuQJaP3k3vQ?=
 =?us-ascii?Q?5JDxsq6k?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f705e9-2318-4625-a836-08d8c769f8d0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 11:02:03.7849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJB4/AxIJX+7KlVyh+/Fs4G7sxkN/oHSsZsJiM1jjqCEMbclN4YF3Yb4m7YS7mcrMYuHc6mtgK4w3yiDaWGkRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2678
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

Gigantic page is a compound page and its order is more than 1.
Thus it must be available for hpage_pincount. Let's remove the
redundant check for gigantic page.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/hugetlb.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a3e4fa2c5e94..dac5db569ccb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1219,8 +1219,7 @@ static void destroy_compound_gigantic_page(struct page *page,
 	struct page *p = page + 1;
 
 	atomic_set(compound_mapcount_ptr(page), 0);
-	if (hpage_pincount_available(page))
-		atomic_set(compound_pincount_ptr(page), 0);
+	atomic_set(compound_pincount_ptr(page), 0);
 
 	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
 		clear_compound_head(p);
@@ -1501,9 +1500,7 @@ static void prep_compound_gigantic_page(struct page *page, unsigned int order)
 		set_compound_head(p, page);
 	}
 	atomic_set(compound_mapcount_ptr(page), -1);
-
-	if (hpage_pincount_available(page))
-		atomic_set(compound_pincount_ptr(page), 0);
+	atomic_set(compound_pincount_ptr(page), 0);
 }
 
 /*
-- 
2.27.0

