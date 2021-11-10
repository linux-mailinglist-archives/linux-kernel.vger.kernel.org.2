Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3604A44BAA2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 04:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhKJDf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 22:35:28 -0500
Received: from mail-eopbgr1320133.outbound.protection.outlook.com ([40.107.132.133]:21834
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229963AbhKJDf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 22:35:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj7iruK1JO1cL8DHig2pl/G+Cn0Z3t+WokVVE82/0vDj37g6n8QKzL7wVUPbTi/yPP8p8lesRpqvNmMOH4KBc16uDqEL/3MgL0vz+Q13UXCkve1mqnWhHO0BKM2yr4HcODzC0oz3REaxHk22NIopdmyYAfycDWwzXQvEU2j4wVdl1oNb5NV3AmWa0RX5P7heH8Pme006Nm9637ARyRT60yA4lv6A+ga+O1q/pCMwZ3BFoVOiYWKZ25GdSL5mZtmlLJClx2tcsKtLsElGj9fSClwJHPuJcAqtJYVtWmD1dyuUzA3AM8p3+rH5ATnnDq4rPQFDdXMEw7usgLL5fliLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEuLafHLJ+BJvfEIWezSTw2gN8jB2jXlrw3X7atSMts=;
 b=fYue9zl9IHiL7BgGDHmGivHmDJjNXsrGFdI31ms3ilsFc9zo5uj7FYWEP7RUfznNtDFjKDS+WcywVsjr2/DbmSF+G7zSN9r/UdJu6F1wm+JQTtW8rUFlE1vi8nHInBJ9J4fKWUq/yBiDjf8Yt5PPeApjETZy+8d09Cu+U4DfCb8p5XbzXpCHMUF/A5cGjAgcxs3LK3b5v/gXbZS1eJQ3Vx3uXiQTV1PNtQ55zDKTX8YaucdUgLU+PEU4/syEml6/uEjSJw+2RPkdCnrrLiPa1f8mpPr0tR6w4qzxU0ENO5Zg8W9EPe02v/PYDRv3i99WNjtq0HBHA/fqTgppRMTGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEuLafHLJ+BJvfEIWezSTw2gN8jB2jXlrw3X7atSMts=;
 b=GJQajZTHGDAEKrCBe7zyjy1tozk4MHYFqUIk8RETfztmofh69LR2TJlQUYkaeKV3UQVqG9rtK0xnNIeQyEVa8amwHmcwPoxINjeiyELd55GZGuDEAQUFx33gWzaUmJGaBJ6En6bHAoUA+oM5Pt6dt83DU97wgp/ZOR5cU+zNgqg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TY2PR06MB3117.apcprd06.prod.outlook.com (2603:1096:404:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Wed, 10 Nov
 2021 03:32:37 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e%8]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 03:32:37 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] mm/damon/vaddr: use swap() to make code cleaner
Date:   Tue,  9 Nov 2021 19:32:21 -0800
Message-Id: <20211110033221.22083-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:203:b0::15) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK0PR03CA0099.apcprd03.prod.outlook.com (2603:1096:203:b0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend Transport; Wed, 10 Nov 2021 03:32:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dd1efe9-a63b-4ce9-40b4-08d9a3fabe02
X-MS-TrafficTypeDiagnostic: TY2PR06MB3117:
X-Microsoft-Antispam-PRVS: <TY2PR06MB31173DAF86C9B1D24E8A651CA2939@TY2PR06MB3117.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cayXTs/Lzt22SI08L0xOJhatSmiVketphSfhgsvfFsIlsBgXWYAd1+rmUU2s1+efL2IWi7a5sQBii6r8hQjCRiSzxQHdfISXzSiSUJ+zgr+Z6wJSBqQSzae1aFCwzTQNrO3jl2JgbXlGf9agAjJ/Njr5fMnqphi2U3SrOWR0bpiSqe2n4go67Gji6fhQGjBb7IRV2s8LK31TzPxBFX0F1WnTu21PnQcgoBKNmD0G92e50eu3NXl3vO4Cq3cgyIMCz53YaSRjqsnxCbDQEZZncNbAHHnrXmghINh521r0FTWzUsQVCZp1rx3f45jDqq+vawYMON3xxBZRCXdIM44NpVbcs0rDIwW1uN2FeuL4JJvfBm13J6+iVI6BFIPQb2czlh5OAd6kUGvO1FIDQSSkMslRTuIqypiWojJEGEvhxgdOHI4jMo7zoEwpn0s+ImgvTsxYFiLQyfjv0ahWrmgTdSTnctfV0S63z02P26nXmKJoyRkktU30vTYPOCItWjAEEYI3WF9DnNLzSZ4oEckv/CqaSHyYoC65QqWrmh3AJ/ObirYnxeecqRHxTQO7J0mnv5ekfr3mM3meGEZcevQW2tPtqjYBEcO1f1wIihOMPbs6oK1UZOKLuNXg1gbaXoKl9pj964yUgCuMvJGAuVsgf3nElR4EaSgq+DDUE62jdCYk1BiC1c1pTRSa0eZz53XAukrBjlwnq8VaXZYsxnPckg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(2906002)(66476007)(6512007)(83380400001)(38100700002)(956004)(36756003)(66946007)(2616005)(508600001)(6486002)(6506007)(5660300002)(66556008)(38350700002)(52116002)(26005)(316002)(186003)(4744005)(1076003)(86362001)(107886003)(8936002)(110136005)(8676002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TEXut5/U/Cug159P4PXELwhFAvFLbU+tIGesL08e9MNcQtbTPSwDVI7dYypP?=
 =?us-ascii?Q?aKRt77WPjQngKA/XXhmEaYcVvS7CiqcfdiK7kxVkkalCZxGPQ7bbCCE1YP4J?=
 =?us-ascii?Q?f2iDTkN0wt8MaEOIqN8CR/6XksMXeRCHkF5ngijPfBxO+OlaYJ04+MjQVc6g?=
 =?us-ascii?Q?nFgYwDw3ZNV8nShXoa1AD3JAUn0rttQijhQpLMuFajnn6eJxknPXRQ4wyZO9?=
 =?us-ascii?Q?oTIooPUs9vbsBi1WWoJcu4IqL3+T+ye0tO4sfufyOdYQH3op7WRtEFD6OD4D?=
 =?us-ascii?Q?eFiTKybT2eCoNQYGCYuN1Evr91EjJ/l+FsY+jZuFuGmkDckGdCUPAreZOl80?=
 =?us-ascii?Q?bZkT6kEPmvJuUOHxW1QQ0RrszAr1iBCrqltBmw8DWdidPYAoyCLy2zSiQzHE?=
 =?us-ascii?Q?/tuym3YuIi11rnNnMYj0QbVmuvn6V1hvfzSxKJ7Juvd0rwGZItgjQ3kQ1wxt?=
 =?us-ascii?Q?PG18VB+lrvOda1qOhMNAbi2dMtO/NdYc6lmIKYVU3mwHNmKmA2jCD6PH1QH3?=
 =?us-ascii?Q?R4g6WG3fPN5W+EYBnpqXwu4P8nSMIlOLZ9QnUc3f1zob/Wi+SltMBaTKFSEI?=
 =?us-ascii?Q?D7xbCueir6Syrnfh9ELFfS8SIL5eQl8ggGYnsxf2Si3kFDHaro+MRyQRy59m?=
 =?us-ascii?Q?m/N4oaU9dlm6B9ZPziqLEojnR6faHs/VPASANOWscNnubI3PX4XSYn7e0seh?=
 =?us-ascii?Q?I79uvGlAeN3uy0NEqt88jB0kRM75h1Y84/smC316KXimfpd1dZUlJ04PxiZ/?=
 =?us-ascii?Q?j+nui9ILZq5Ix8pPON/41FBaw3aFNr21mrlPHF7uclIP0IgSQ1bYV7rh+e1R?=
 =?us-ascii?Q?BAZBr8YkjoJsYvFZS+IVvfui/shZXF8yeNYD5qvfe7GqzfKYUMqH1SViYcA4?=
 =?us-ascii?Q?su5tL/QuqgVYTSuinjP8yH6dkPi52bks28xpyq5mLi1OnGNonvyJ7fDvF7+n?=
 =?us-ascii?Q?qIW389quEQEkcGIgD7YMPYE0NSb+Nd8kNO7ssctERkIMl/srCW5R7gbNTG8T?=
 =?us-ascii?Q?0JI2KJ4yvm44BEUxrDY2eG82NozM0niJJcFVtciLClq/dWBecfIo93XV2e6w?=
 =?us-ascii?Q?rpcCuZVCdfIlID6auzCiGJOsnZoBYsWOGaPpUQ10ALn0SzpVNDpIfJ3agaD7?=
 =?us-ascii?Q?NZdsLxmlj78fyOTUtZYM2oNxGy9GOqFVLvlU4/cUDJkrdeRjiT+EXFjK2YfZ?=
 =?us-ascii?Q?cu5vZqv2UonHB08vpzgaNcXHW2igNnN40ChZ3fjOgKDCvaqolhoNZ+o4yZT+?=
 =?us-ascii?Q?ycVpxjKpa6f7ZVhIIjhHjcwUkxiOzI+bdz8mhRAmEsnkbGlw5G8zuCTSr48W?=
 =?us-ascii?Q?cdCSCRNxpnF2O52naBPnF/E0OMDvnvjRVvvvr8P9IZrAELWteVKKjzOFUbkP?=
 =?us-ascii?Q?dcMZ0gIxMlirrRQDv+GYx3TIA/o+ssnj16ve22ne2GWsmURTehmvyue6ASe4?=
 =?us-ascii?Q?Gas2c67sde6OGjJDbA4uzOEW+igHsJ4MYhExT3qO/0T85ZR4wkLMSHaUuT+R?=
 =?us-ascii?Q?TzXatQuMNZKzuEh93yyr4PK5VFaj4cPw/Qvv1nYillwQWg834qIoaxfNDt3o?=
 =?us-ascii?Q?HF5vHC6E0IsxULt0BqFPphjazJ2+V8cV8kLzB/kiA+fpvcPNEBPHSCCuGF6f?=
 =?us-ascii?Q?eYLwOup+olE4P0wjZddqyVw=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd1efe9-a63b-4ce9-40b4-08d9a3fabe02
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 03:32:37.6268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OVJHGSN5DkJfn/H5iUTBEXe6rg+wWvVBg3bWQTko67Ttb5mzoqJgkn0GagoHuYdRhQsiEfRczyxZ51FF09sxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB3117
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 mm/damon/vaddr.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 35fe49080ee9..414d9fb9c827 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -100,11 +100,7 @@ static unsigned long sz_range(struct damon_addr_range *r)
 static void swap_ranges(struct damon_addr_range *r1,
 			struct damon_addr_range *r2)
 {
-	struct damon_addr_range tmp;
-
-	tmp = *r1;
-	*r1 = *r2;
-	*r2 = tmp;
+	swap(*r1, *r2);
 }
 
 /*
-- 
2.17.1

