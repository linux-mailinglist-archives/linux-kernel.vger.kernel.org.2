Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D2244D1FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 07:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhKKGtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 01:49:22 -0500
Received: from mail-eopbgr1320132.outbound.protection.outlook.com ([40.107.132.132]:43712
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229649AbhKKGtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 01:49:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuECx8DIEqNqb5mO9mwhuKXakqsv9T7RiQ12/IImB+W3DEJr9GuUjSrfxUHvmZuqOkNaI9EVXuC+Tw5PkWgzSxvhrPamBCU99ybRoWcjM4YrwFrWitW7MKussT10cd0cxcuAK3pz4PY5u87DXh7IQwCnebG6FX1U3l5TriT6soUaouG1uDHdvo6IkrMIy166Afnr3oLjQpCbg/27uQycAomtFj7WYXLHiklwh7yaLj3lQkUpJY8u1G7ZUxp9U+4CEaTXPso5T764AxbuO54UKICA+7KfWqHiam+BbW2SDSp+GKwja0zESbsP7qvmkKk9DwTv28LDunwCcHd2ERg/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Rb0fEVVPRfLkfggrMZ+0O9SFO104LaNF7gS+qQdrsU=;
 b=OU8boVi4Azea0YbjnvML/TxarmsYdmeBODGvZmeE+HRsIJLPw5Kv/asLpRXmhdBBwLhUGWoCMPnW2eEAF3xYUhbCS3SOx4PNY+cFYLB0/V1F2WYIB8PYDYLrYauAgtVNu5d3wjQb611o78jK3Je17ILTVvVxjNCJGYUUS43Wb7cr7Pc8vcynPq89Zad3ZEJQYAVI3QNXb/4CF38VgW/7BNlcYgRlTGMuXg4r/DMs4g5knOfft3e0ZMbMdxLDqZRJRh0MzGoUxqXJxrw0Bgy2FyKXvzmqON4VzTPRciKqydepI2eY95a4kZ91vtFmmxyL33THWphD4w2D5ei3yvWpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Rb0fEVVPRfLkfggrMZ+0O9SFO104LaNF7gS+qQdrsU=;
 b=O1/pv71+KHc71s+ysqs9Fkv39ac/+cDVspIMFYRATe/mcRebujbb3ESkZpxHyFaJXPSWCvzsy8luOLjRQiSfGt4+24w9SvdZTXzIyxVI0zp/ASd4m6xF3oLq7aVh1YY8v/8GbZ8MXrmpJ8XnPPmwYbKLgGb/uxwZwrsU3o1/Ucg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TY2PR06MB3648.apcprd06.prod.outlook.com (2603:1096:404:fa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 11 Nov
 2021 06:46:30 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e%8]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 06:46:30 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH v2] mm/damon/vaddr: remove swap_ranges() and replace it with swap()
Date:   Wed, 10 Nov 2021 22:46:17 -0800
Message-Id: <20211111064617.4729-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0203.apcprd02.prod.outlook.com
 (2603:1096:201:20::15) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0203.apcprd02.prod.outlook.com (2603:1096:201:20::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 06:46:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80a05415-eed5-4698-5e63-08d9a4defe21
X-MS-TrafficTypeDiagnostic: TY2PR06MB3648:
X-Microsoft-Antispam-PRVS: <TY2PR06MB36489FF7EF5D33DA4E45E354A2949@TY2PR06MB3648.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2lHn6KxF9l65Di3T/PMC8djIE1N41fW1NWRpVlMvGbhOR43FzWU8LcKHxyyUPbw6C4sBZI3pTfAAK6sWKbPXpGPOwRiluTO2fVa3YhHdJ/mX3L4xCIVYnft+1XTSSClh67xIJA/jJjaCWRdjaLGom2rv2dhJHeXT6UNBlmmUd0f0fwOcmizqSFOkEFoSWVTGrV9ZdTKhHDAahMRZa8CXF+3bynve15FLtiWiLd8piy90fKtOWUCIJtgEQkYGFlhee2fasgH589xsudoNj8T0DKv/i6U9ZvmU/l8c2Mi/EEMNWtfKdoTYm22zmw+PHRXRkxTYoYIwz4wWm/5I6xIvbSqe2uIoW/pObCLDdNo9VqqXt8BpmPbAvVB9K9XLSkA5iVsVcLO5cSUdmXSCiFSH+Jbzmws8otArMeWVzVntLUPTRf+GUH716alaBXjAfAwR5vH6rZgwnIjHaNzrTmQgnOkMKZ80JyBs0zR12vyu/X/c+Fr2KR4/wN3ukPfGf8gm9peQwFoq0DZDn9lqduZGBJJKcd5wVYD9he70MgqAGEcMG4VreF3RcutuQQuxkIE0oOYc0fPeXMDIEUk5pmHi4sHkC11FR9CJqhf4MN20VWBZSVNesOOG6BW/u1KeEFzCmLGXgk0DE03+iYucTZTrZ1/LAq6pQfP7bXIws8dROpNaBvtROD2N4/WDVQ3HmZ8Llca7rPxAYhiUNPM/CyzkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(6512007)(316002)(38100700002)(1076003)(4326008)(66946007)(8676002)(6506007)(107886003)(2906002)(26005)(2616005)(5660300002)(83380400001)(956004)(52116002)(508600001)(66556008)(6666004)(186003)(86362001)(8936002)(66476007)(6486002)(38350700002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YlJ1nUoovEWy3a6H6FQf19xNvZ1otwFeN1sfu43S79xxMw7lOLG4VKi/OaHj?=
 =?us-ascii?Q?EBgU1Ddip8CWD69ME8FMsM2ODN5AvrjCgZlqdUDPJ1ydMD1YUWgQVE+kX2Yk?=
 =?us-ascii?Q?xm9m10Qs7TUxu1QmPUA+fUCYgwD6huu81CkdkB4eF23CyOiTC9gCOYug7d0b?=
 =?us-ascii?Q?SsaX8x5AO2u2yeuvj9ytxe7DRHlMzHY1rPaqU5jTzUPOnqx8aF/TMnguPzkp?=
 =?us-ascii?Q?bOpuI5YKoeGZPPoiPQujmjToGY7bKccP2aqR9q4KuzbkdI3HoO/iW3xzuv8q?=
 =?us-ascii?Q?RdWxDNpYzqZXDYfV+pA3fC5LEDA7JEhMaVzlfao5Q9prUiVXw0cH5h2O0aWr?=
 =?us-ascii?Q?oK9rvQ8aCRYq9y1wvmXQD+iiXCmZX+wBU2CJCUBUnXBi6J+TaYGTKXfoDJVa?=
 =?us-ascii?Q?nVX+Ul76X424ZlHRuOVQeHoOJ/6kvt/NsWtZJWYUJxd7j6QW19pIoX+64VxT?=
 =?us-ascii?Q?4zBZ0q0VYtTL0ys80600y0t6VVNVDwn5IGE5MNxk67f+jmtjuug7jsqYZvMV?=
 =?us-ascii?Q?Pc5JHkwCSPiCueebksSqfNLezMQyc6FV2Vw4AFLO1JYYGR5pgFdgJ4JD13rI?=
 =?us-ascii?Q?HMrS8bNc3JSfI//1qVGlBCpRKpbkaqdMejfESm2CcX8hDy6gs/t66pny+g2E?=
 =?us-ascii?Q?uWmLGZspai86ooOcpDRlaArpb0psXnw+HHa6bwi30c8fte8Z8ShVJbfhP+mG?=
 =?us-ascii?Q?z/jnIb46Nt15C0A5RlD/XayQ+m3cpTdNPRNcYQVtZRYbCWqntlaletRNlqjY?=
 =?us-ascii?Q?kt9d2XRX72sPFtX/RYfZRhp1I0VIF+Yzlr3pgq14oxZOlx2zZGxadtC75ahw?=
 =?us-ascii?Q?Uch+EyhAwHZVryiiDW+GeT+m4qfMZXIra7+NRSRiOyj7pYyEShaFR7PhxBSr?=
 =?us-ascii?Q?CVxb6m80VKCoovEFduQgai6xxlaYRPr91ZgnmfzjaTy2V7bh6m12KQqHZaan?=
 =?us-ascii?Q?ltTJoa+pfp2OiLWtA0VikPo4w1p4JGkwF/9jO6kK0TCK+oQ0fp4OtExHixBD?=
 =?us-ascii?Q?a5vDDwOoTR3hK3o+A96tRuaMKo1xshNRmRFC3vECS6kqKNaSJIDw0Hpd9s6F?=
 =?us-ascii?Q?d4xVjoGbCQJvh4W5mQ0upSjvTaKCa+DQD07xbLr4rHTgvNubzpF2J3l8hSP8?=
 =?us-ascii?Q?Fh1tEJsyIMaU7K+ZC1zLRLK67eOzy2Dmd99YYqGVlWDXafbXI4w1rGQVSUrG?=
 =?us-ascii?Q?0pjtle3umlvNtXoLCkexMJaFFzD8GxtZaXeIp+OT7u2jBuUCaoJZJveAwckz?=
 =?us-ascii?Q?TJ9mc/p18/KuTQ2l+TcDOR6eXJ9GiH5peACEmYVhuiwI2UoaXsVAN8vtts0I?=
 =?us-ascii?Q?SFPAM50RSAOAHjHEv0Ytrxm94dgpoVZcpYvQ0Xuq6hp1L2zyqrMvRWsg0ZZI?=
 =?us-ascii?Q?x0Yl0h+eNz4AjOmQFD+BBIfN9WbMgHixWX3hMnoeTvUgvzvFMJ7BV6tXpbrX?=
 =?us-ascii?Q?LQLYOuSH586fECRzcPAxmRMdn3RB8RJ6dQoHjsRgu6A0Ptad9JlQ4zGMO0Pi?=
 =?us-ascii?Q?48WVAr/FLMvOx10Q0RCmNKhkJY2znYrjmaiDkKo7cjcGoUXJtD7uUVXiTMJm?=
 =?us-ascii?Q?yDtALadrRoN6ZH/M670DatM9NRllZ+unG5+3Il44dwVFKEDXAr+Di7ZHlsmN?=
 =?us-ascii?Q?6L0xZr1WHFJ24BoMRQAWwCA=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a05415-eed5-4698-5e63-08d9a4defe21
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 06:46:30.3886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPk1PeP2g3FWwNIvF7LYdyA+x+bymG/lw01nQzOa/4t/9L6XaYGkQtpO5UfgsHAtcV4iZZdJ80yqNJ9d3408GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB3648
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 'swap_ranges()' and replace it with the macro 'swap()'
defined in 'include/linux/minmax.h' to simplify code and improve efficiency

Changes in v2:
- Remove the 'swap_ranges()' function and replace it with 'swap()' 
rather than changing the 'swap_ranges()' itself

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 mm/damon/vaddr.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 35fe49080ee9..814dc811d7c4 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -97,16 +97,6 @@ static unsigned long sz_range(struct damon_addr_range *r)
 	return r->end - r->start;
 }
 
-static void swap_ranges(struct damon_addr_range *r1,
-			struct damon_addr_range *r2)
-{
-	struct damon_addr_range tmp;
-
-	tmp = *r1;
-	*r1 = *r2;
-	*r2 = tmp;
-}
-
 /*
  * Find three regions separated by two biggest unmapped regions
  *
@@ -145,9 +135,9 @@ static int __damon_va_three_regions(struct vm_area_struct *vma,
 		gap.start = last_vma->vm_end;
 		gap.end = vma->vm_start;
 		if (sz_range(&gap) > sz_range(&second_gap)) {
-			swap_ranges(&gap, &second_gap);
+			swap(gap, second_gap);
 			if (sz_range(&second_gap) > sz_range(&first_gap))
-				swap_ranges(&second_gap, &first_gap);
+				swap(second_gap, first_gap);
 		}
 next:
 		last_vma = vma;
@@ -158,7 +148,7 @@ static int __damon_va_three_regions(struct vm_area_struct *vma,
 
 	/* Sort the two biggest gaps by address */
 	if (first_gap.start > second_gap.start)
-		swap_ranges(&first_gap, &second_gap);
+		swap(first_gap, second_gap);
 
 	/* Store the result */
 	regions[0].start = ALIGN(start, DAMON_MIN_REGION);
-- 
2.17.1

