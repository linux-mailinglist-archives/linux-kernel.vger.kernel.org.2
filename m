Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854FB345ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhCWJ2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:28:01 -0400
Received: from mail-bn8nam12on2043.outbound.protection.outlook.com ([40.107.237.43]:3552
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229576AbhCWJ1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:27:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dL08+fX+pLbGFmWyxXXklcz+VV7Eo8LDYMrj72wC9DI04NAI93d/r8nAaOSG6No8YNeG7olxeMK+PlqSFS2MfNyJ2COS1lXbeNGgCCDPbn+Ku91evJT+P5C5oWH0Xlu4PoKKj80WeWfiBn2AhYfYORDcjN3enyMvtJD/ojIMElcyBRGvgY/Ehu/HCcJD6TorkL4xrYPtaTYclfqwQhf25jIRmc9prghOle73x9+D7XCudV6YWhVOeah/P7gOVtsPVhB/OTNHVLIIWlEtgr85noF1hTFb/APp2Jsdr54fs2IGC8wL2yPfUpzUZU8Bg4t6AYMOsuqTS07+zDdP5DWa9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qfFFy+hl39K6X2FaWO/Lnpul/4AWUBHCp4AiM3i6/k=;
 b=gFmgM9LZ4z+EZyXd3e8pXFxM+5cwFQsM/YcURV1Yfq5pVLkThcQTwRuH+ASrtnXDGKC51RA4p78OKGoex3yUQDtmQm3wEV8ZSjWd3e815dPcXGc1qzcsqjRDUqVdjv4Thz4ZoeLw4q21AYaNSklnScL+n85umRmkpvn2KKNql3LOj9TwrFQdw5UrGdrfhR3LKGcJ65zRni3BQs1JQqPczQ4QteQTn/3LSSWJnPBUCKEZeQL5x7qkvOb9XQ/5Va3AGoaw22GqAH/28N7U3FRzMxBO4z10GvkMaHJCemJTVZazw1GFHZXc0Xp1/EDgnBD7VEiZl4xbq6O6BuxwLsGuwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qfFFy+hl39K6X2FaWO/Lnpul/4AWUBHCp4AiM3i6/k=;
 b=S+Cnfb6gOGucleUhDo3z9CDwXyMpdLXjg4PBxyDvEIjKDut7F2WvOyUcf6Z2SisvkZGH1vPsqbFr26v4Bo6iok21iOJ+sIYbutjIrHcdYIER43WiNzfOsX163w5GgwyDMG8QxGzPQv4/1LyLcDjnn4FYX9XuqJ6yp11HPLProBM=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB2536.namprd11.prod.outlook.com (2603:10b6:a02:c4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Tue, 23 Mar
 2021 09:27:44 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 09:27:43 +0000
From:   yanfei.xu@windriver.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] khugepaged: Raplace barrier() with READ_ONCE() for a selective variable
Date:   Tue, 23 Mar 2021 17:27:30 +0800
Message-Id: <20210323092730.247583-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:202:17::32) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR03CA0062.apcprd03.prod.outlook.com (2603:1096:202:17::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.14 via Frontend Transport; Tue, 23 Mar 2021 09:27:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4962ecd-af53-4dee-0c91-08d8eddde96b
X-MS-TrafficTypeDiagnostic: BYAPR11MB2536:
X-Microsoft-Antispam-PRVS: <BYAPR11MB25361E5F1AF20496439D5D46E4649@BYAPR11MB2536.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mlmYl/6BtvaNff3TazjwPJz67WGuWL8AonzGZkknRTvqRFvfn6ScxgoQLr2HFuN3berd/aXbE1xdqNftUh7R+xK3NY/AiXp/tHbSWFkH1XiiJQ1crastff3zJOtaqAbkWtn2qy8P8TAbttSEEGDoGkajrpN2466EC28BlvDSKMr2fojc/8CG31DZbW5i80KQ4csRbS4dYyuZlwOZ6hK+eMhVVuBlttqakvxiOSpp5l7083NfSk2pOKjDnuJFoOBmylcRtoY9wsqCZyKA3tnihl8TNiZbOUrVBjZkUE5tPTmqlpzlHdxRDH1DX0mj3Fs/78EtOIirYcX0j3AoW2G47HSsWuf5ZRb0eloEPHSEr7lmXXjHQ4KzBhz+2PB1NnJm8aafKEc2nrYv9aDmLFmECimogOSFDtFu+zYtH7UTuy/yEuPN2/d79gw/u0plaGUlu/3NTULwzjP09vlTSJ6Tn9CQ8smF/9S/GymXA6ga+564ekVpq5/e8p7i45yE6O3sreMzejAyWKo2S9vVA4bf2bjhD5pmcPLLXLovb6zLTEdTQ44Ico4gY0mLHQeLuhY86S1EVVKIQna9ZaeiN2k/BpK4/kaqPqxzJ6I2A2z+SmgCY6g6ywl2okmQRau4DH0c34gqyCMgJU6Oz6x7xHb22ETGI4756gUEB46MEwqT0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39850400004)(4744005)(1076003)(6506007)(5660300002)(316002)(6916009)(86362001)(478600001)(38100700001)(6666004)(52116002)(6486002)(26005)(8936002)(66476007)(16526019)(186003)(8676002)(36756003)(66946007)(9686003)(6512007)(4326008)(83380400001)(66556008)(2906002)(2616005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?w0NSu2rViGPHhbHPKs3luXOUGtQPz+oIQvKUJXojCPmLz4v+lipjZRlJAcCE?=
 =?us-ascii?Q?lsPsjmx/IqpH2J1/bOh+epAoJwwiiMBaUBiPlTnbAvcX7mSyWLCMZnmcZoDg?=
 =?us-ascii?Q?GhQzv7VPWddZx4sH2QDIgcoQ6/4nslcKlUpiDW51kcKPGu5+7dj2Ucz6NZbp?=
 =?us-ascii?Q?QGtoVUOtWqBn/LqCk9dl0pOREQUL4FbV5a50CQw/ac0X+lK107w6jBDVHoNZ?=
 =?us-ascii?Q?xaVaeVqb0obi1aUjPb7hvmWj75sbOoXGeyP+ZKHwTHtl+T3gTr7o8l3OkBYU?=
 =?us-ascii?Q?5nTY87xdafP1GhyeUoOtjSJ2WvKamEGvHjUU/cizwqrSTnoW9DWaqzCJdXSh?=
 =?us-ascii?Q?tlAihDiiJWHY+aF613z71AulOSbP9YmVMMEeZ2DibDa+NBWMv6ln7Eb85+H1?=
 =?us-ascii?Q?YbJF0MVaSkGSMuWX2/5pafOYzIVlBhbRrnTuHmAoNXYRHS+7aOQKtALNhFTM?=
 =?us-ascii?Q?lpvCnqnczPOlRpIjQ4t3qkIN4mKARlifm3Gungh/50nENZZdIWKosrn2o18I?=
 =?us-ascii?Q?PohIUnR0tiStc1WYSmiMOSb4fAxuPIdkCzZbmM7h6Ylxfub36zX/oGLXa/HC?=
 =?us-ascii?Q?SkyxUdbD/uLQt0xk5Zwvme05s6IElbU9F5DFEiEBFYKlzymUQq2fvh6zoN6w?=
 =?us-ascii?Q?/ZEApDpIpQnXTtnInmYbbVCHe/ZRn7spUxmaNrgUuHDzP1Ohah9FZW+WLhMI?=
 =?us-ascii?Q?eDTzsxk3oQ98kw98o8TMOULj6JX9lRIzFgFpoGBAJ5vtcefWHjEFZnzi5d9j?=
 =?us-ascii?Q?BKUeRhAE8C9iSPXAoLCLccTyb9Ehqfcf31dqrTZWnBqacoNhfu7aR1C4/RGE?=
 =?us-ascii?Q?sEnCoc0fLYZdsqW+FvodPnkTQMSjMV4xEfGZlXzfEXVildsEH/PEI6w21Y6D?=
 =?us-ascii?Q?6aalBKe48MGlKfC6V0UgOAXgQlX/gBuVKKRc7AKvgeuchEE56jDi6/Tu6O32?=
 =?us-ascii?Q?Eeq0MebsQ9nRCuW1lEw9j+m2Pf4ADPQ8HH0wJr8yarjCd0YHC80R4G5VjFfe?=
 =?us-ascii?Q?hBHK9Za7R3NaU6EqNsziKZQ1INk8eEunQUFxxYig43qJvUlW8ecOTtpYYYnt?=
 =?us-ascii?Q?FplGW5lWvZSJjKGRa4uvUubBE8waoZiS6s++aBxHuYV1iDCjflLSsN9S0FoH?=
 =?us-ascii?Q?AwHKk30f/LqEsYhw/vu+9pPrSBZJsTfNS0SsAdBnDtxM/+82xiuIjHXWGv5r?=
 =?us-ascii?Q?7tDiPz6U2NTgh3VKiGhLxcyEx0KVZoJSa8vJRY7jFtamfoOuwGFxmHlpwXl1?=
 =?us-ascii?Q?AqiySEKzyrYHB2NlINydsOfcqwbDu+zeGsG9i5DNkYPM+cHE3BwUGjpP8hXc?=
 =?us-ascii?Q?avOmLpEGCnrI+6tX0cwsggPh?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4962ecd-af53-4dee-0c91-08d8eddde96b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 09:27:43.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AW0AucTovcUQzqRoPgApREsHf36jmMi7Ni9WRoafU4m9kpRsuD98caPic3JBolg9RSqbkvU3MT0pFXAq0oD/Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2536
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

READ_ONCE() is more selective and lightweight. It is more appropriate that
using a READ_ONCE() for the certain variable to prevent the compiler from
reordering.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/khugepaged.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b81521dfbb1a..034d05a26cb0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2202,11 +2202,9 @@ static void khugepaged_do_scan(void)
 {
 	struct page *hpage = NULL;
 	unsigned int progress = 0, pass_through_head = 0;
-	unsigned int pages = khugepaged_pages_to_scan;
+	unsigned int pages = READ_ONCE(khugepaged_pages_to_scan);
 	bool wait = true;
 
-	barrier(); /* write khugepaged_pages_to_scan to local stack */
-
 	lru_add_drain_all();
 
 	while (progress < pages) {
-- 
2.27.0

