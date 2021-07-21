Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB7E3D1A30
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 01:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhGUWZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 18:25:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48854 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230453AbhGUWZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:25:25 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LMvacT031904;
        Wed, 21 Jul 2021 23:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=buzV1+L2Y2ONcY0CLrJ1pQYw1k0vHhcGd6Zvf9Ttln0=;
 b=mxnXyuhN62yrDfddRWd9RR0nP0x6tUa9Yc2JPiiZajurwL2/47YWcXLNankF7lH4OnqM
 X8tie+ltDX4xw+lBV7A+PpNHZSFMv7j6ziEWb5wTZe/DP3pYY5ulyqUUhEVwFhBW67iy
 H/fSm3cWoC0tQzrK89DVtLlMXcJmOMrhGcRRlxeDQ13JhDnj8Mwsc2ooTPcAm0O7u2ex
 KRTbKJLuaunqcLz9emJDh8MEr6xq2GH3z0VTqnrcwXyfgKgkp0B2gnzcx0/90aujJRjo
 SPcYCtENvVv0Y1go0tS6aVBtz98Hv5u+xstKPuMBYq28egHs3dPuk2qOeoqkk3JgbH56 5g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=buzV1+L2Y2ONcY0CLrJ1pQYw1k0vHhcGd6Zvf9Ttln0=;
 b=ozoiLXdhbc1Qfpsm6TDWSv1b2mJoSBTqQNMuKiarmsn/YWJS9jmHu48M6sbKD83BOvbW
 lGhkgEHd2f+F+aWy8OGRBUw215OiAcFEq7llvNeRO/SjFLZ/0xsvBMmDVhgHoYLHQ1Go
 A1AQn2CpxQ5T+yGQsbD6ISbLWAveIu4sYuB9Z3RlA0vnEvzcgCa/+KS8VHzbGFspxSjl
 zyEjNa/2E0XHhVx3Th0iKuxPKVo7TAzC4qmOuqY6i6JHFhOguJewWENHGq1jQLauFb2P
 MxKYy++mEMyTB5UpmRUMal0srUxTX7PzJR6z8fsitFs9tDHlktSujUJd9nvf9mHivZzV 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39wwmtuxr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16LN0T2E098889;
        Wed, 21 Jul 2021 23:05:42 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by userp3020.oracle.com with ESMTP id 39v8yycrpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=am/K3UDp7yai39RL8eW7PO3rj0GxfjJWFttpwm/I2/nh70Qb1F+gt/6m29ZjY+52dXfA7E7y8SA5kJoT0yKTnc28Q0UzR1Ksjca/sz7jQTdcbFG69uM/4IXnVfIJJB76VA53SzWmR50D2HojESKVqzJhNqxUEOg/faszO0XeHC+EgecUZIFWy6HXAhIk1g4cUsQWeYA76fvR/l3SN6LeIzFpAL6LoVUytXm7fMvDO6ji1gyJj5W+OI3Kex4CdconOGgqCaJK+0GiUhOIPMw4hV48WiMXH5h1NROuEwniSUpjrPThd3YgcVkSCik8MVAxSsV0eRTfnwfbpH+KJtiXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buzV1+L2Y2ONcY0CLrJ1pQYw1k0vHhcGd6Zvf9Ttln0=;
 b=lhDhgJeX2n3NXzxd1ajrus0HIYxcuItHMPLstC1JU/MO80cQgrT/z4ODIAqM/ijARlymbwZ9qFW8BYm1CucL86IZCS8clLGrMH5LvhuSoK5DglurcAzsFhEawq2PHkoTeH891EXo+WyxdYtOPVpUeWCrXu69wTka9hCWUsXFNQEdpNL6ehnlhD/nYFVQoZfq4CmF12XrDRjgnIGXocWzEVmXC4A+lrcUeuzihruCUjP1d0FHF+hc4TU+tGvYC1qTXBk1+ZUmV4V+XciU9Q4YOVlFRSVgC892ZFf2tilnnLAHU50z3/9t3OeiNjx+dnmCpWNZdR94qHwKEI/oJKO3Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buzV1+L2Y2ONcY0CLrJ1pQYw1k0vHhcGd6Zvf9Ttln0=;
 b=Adc7CCaT/us9PeC6py7QOkk1XPelw2y1baQ9KBT+3uoj4y+s6m/4mZbRn5PJKiWR+tq3p1NZ9MIDACDyOeortw8c4OExT+pVMuh4XsNwowGSwiPk9MZ4y1/rfoZdddpxXe82s6n5EZE5ZRhsqSVRJEW92LNoI4mjYnsRuJ3rxiA=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3735.namprd10.prod.outlook.com (2603:10b6:a03:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 23:05:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%5]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 23:05:38 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 8/8] hugetlb: Optimized demote vmemmap optimizatized pages
Date:   Wed, 21 Jul 2021 16:05:11 -0700
Message-Id: <20210721230511.201823-9-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210721230511.201823-1-mike.kravetz@oracle.com>
References: <20210721230511.201823-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR1201CA0021.namprd12.prod.outlook.com
 (2603:10b6:301:4a::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR1201CA0021.namprd12.prod.outlook.com (2603:10b6:301:4a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 21 Jul 2021 23:05:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6631d343-6ae6-42ce-80e4-08d94c9c0db3
X-MS-TrafficTypeDiagnostic: BYAPR10MB3735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3735D5F1804C72A73455F576E2E39@BYAPR10MB3735.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ev/9vW5jbGZZbZnjYqRRZksDR8kUh+gccRkvsNV71AjAclRMka3re6xW3JwAV7DX+KeCyagchIwy2aJtkjTKkOxIA5HCyCps8zkm2NV3FM42PKnoocMhRp2+GP8OcCnEBAmzDugi/uSL0CLo9Nob220D58VO5rj84cTbmK4+cpyC75ZvcADKJzFHUiSY9RJUX/r/YP2RZjcVQMT4wkTNkZg0T1YMk9qTsn4RxXZnn2PnW8sBq8OHzrRvIY6t3a8w/joPPtA89kdi8kenr6AnyvqLDYfgkvKpqqZ0AHHvs318gA874nuhe+mN4nyXGl45+MiEq4a2hoiE/rgME53Vbl2881U5KIlO/jR23I5pFnX79dKek5CBixZDrUQgJxs2bCfH2INScAXzu8i/RVFtd2vyLZ9niaCmz6xAycwxyNeUCgSO2iqT8DJ150VQCKKel7wgpLeCqEvFd8ZmI9OLalke1Wi/6ed0nRTu5HDEbXE8xWzLI2QY+MTWk35mXTN2C4Z1XhGPaqXqhd8Su+AqxrzvG1iBcGtxFQ6AGe4iLDvKc05vPfL8JCirjPoUsL8/fYstT5n7l45mQf230uL8P77asGu9jK1UGs3OeQZV/X/GoB19z97uE8hl1cziGBcpYK9xyLRrud3mvInbFNDnEqv+O8ZFs2rKYRU8lnlQhCUyUY3CR48ySp3hou56CBghoWfMFjxE1fFSJyDBgiqHpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(396003)(136003)(376002)(186003)(66556008)(478600001)(52116002)(86362001)(2616005)(107886003)(8936002)(5660300002)(1076003)(4326008)(6486002)(2906002)(66946007)(66476007)(956004)(6666004)(26005)(316002)(38350700002)(38100700002)(7416002)(36756003)(83380400001)(7696005)(54906003)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WggjKh0Tyxy+hgAqmEFfNi7WvLPcNhSIswkoQ9W6NS50EDmunJWGkbe3H0Wd?=
 =?us-ascii?Q?o1Pl/6jr9/qnccasKXrIVdpTpk1Jd2aM+XR2Usc8uonhrvVgzIDkImkTG4kd?=
 =?us-ascii?Q?XBFqHR8mKi8OvWU1BGwTsVKPrrQOx0oVkDGUFytVn6Fg/cGjaFbbIyvTlH6e?=
 =?us-ascii?Q?944/KXJHbMNKjOXC8mpdW/Ls3f6Njr+TlWy6nyQj9OwBKoro1d4+3pfMK5P+?=
 =?us-ascii?Q?cqVS6+2B+6SLNGKbgjkeKIUtzYj6QdpZQXdR0OwQ5EhqrXO2kQ29UwQGm9o5?=
 =?us-ascii?Q?sPh2ary8Y2/1eUu0PhwydGi6LgDLYhp0HddJHLhls2HG3PrS0vZ0AXkKP+gO?=
 =?us-ascii?Q?zCtNcUT/tfhCTmGjMfrzh5n/mAySrqPgFoq9L1Y/KA5hlfjtuUCJ/yM6qIxa?=
 =?us-ascii?Q?UnGzt8p3wiJ+C1D8EuqjR7UgH7lI7SQrDF4ncXmtfSU0yM+JgAtuCdpKNbIw?=
 =?us-ascii?Q?zFeENVOwNuegoPHgCXb/+8zB3iY2LiH0pgBSgEQZxPcDgX/mvsFHAPdJpl0v?=
 =?us-ascii?Q?Yv9dIMAEDvj0gomEhQ3E/PwLvgHo7WljfDSeZMtbHOTT83xYJtRCwIm7R+WE?=
 =?us-ascii?Q?e93JExGunCiqpujqGGQFNJ1LtB9D6XypubDVCGydBuAqjpk7pOZH0EdcPwP8?=
 =?us-ascii?Q?8q3ULVQ7NOllbElhM3Nzi24emZfhOGRt4LGIFuV8N70KJ/FIIRupIsXBy06t?=
 =?us-ascii?Q?A1sLXx8IIUPgYVUTscfzsWO+hQgDSFydClzzINeTH6za4V90eXJDEPz79tMB?=
 =?us-ascii?Q?ltqNf4W8s/2UylelpsAFWdbj4e7yCCeoBeGIgNlGF1XX8cbZYo6vlIT1m2Mz?=
 =?us-ascii?Q?aL9rT2s7Hkk3urrl6lu6bHUvqXMhZr3XNN1/LbblSFbg2yX/ZV9XQm/MZ+LK?=
 =?us-ascii?Q?Q0w3I5wMZFtGCmBzWUJpKk64V/CudXeSFQLQpEEM+zPbS2PtXe9058zo5DNB?=
 =?us-ascii?Q?0H/K/lZ3UhKLVCPIZ2wEdxisGeZGtUi8NS4YnCR6XytIyFS2M9ExBRPg0Dh0?=
 =?us-ascii?Q?TUgXgXGNuZT59UU7ElWToNhFbxs9oITdQSsZCi+OAJD7QQPBECPDqaLoHOnz?=
 =?us-ascii?Q?5SHcPunYKFlxN9Vdbl9aLTJ3fIF0CA37L7Pw+8ndNSW7O0cQtlBpasS816Ma?=
 =?us-ascii?Q?akbAm4Hb1ZWewNrsSgi+ccKE/TQqWMFDGQAIzi5qSJC2gT9dseCoW62vOnQL?=
 =?us-ascii?Q?b3bX9Q+uk+NKEVReaLlnx7X+I1xvIyLjT5lRCz1CdTbcIHsWOTUIip5aigiP?=
 =?us-ascii?Q?GMFkl469NSPI77bq92oU/YYQs8Gs51loxRGs58BDIWWs3jZ/vFfV+KpStJtv?=
 =?us-ascii?Q?wD8TCCQWsIgL6cMzfGLs++6I?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6631d343-6ae6-42ce-80e4-08d94c9c0db3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 23:05:38.2503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rict4WaCU1DQ5NYurgeD2xrzvaMpIFR014t0P6zaPRtp9hXGeexPS8zU1L3QspKzhz0XCYSpXQIgSyYhcnWWGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3735
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10052 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210137
X-Proofpoint-ORIG-GUID: FN1_UjeeCocJbyzeKN9SE_DOFfM_c1oG
X-Proofpoint-GUID: FN1_UjeeCocJbyzeKN9SE_DOFfM_c1oG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put all the pieces together to optimize dthe process of demoting vmemmap
optimized pages.

Instead of allocating all vmemmap pages for a page to be demoted, use
the demote_huge_page_vmemmap routine which will only allocate/map
pages needed for the demoted pages.

For vmemmap optimized pages, use the destroy_compound_gigantic_page and
prep_compound_gigantic_page routines during demote.  These routines can
deal with vmemmap optimized pages, and know which page structs are
writable.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4040dd3c6fe3..893406282c53 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3307,13 +3307,14 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	int i, nid = page_to_nid(page);
 	struct hstate *target_hstate;
 	bool cma_page = HPageCma(page);
+	bool vmemmap_optimized = HPageVmemmapOptimized(page);
 
 	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
 
 	remove_hugetlb_page_for_demote(h, page, false);
 	spin_unlock_irq(&hugetlb_lock);
 
-	if (alloc_huge_page_vmemmap(h, page)) {
+	if (demote_huge_page_vmemmap(h, page)) {
 		/* Allocation of vmemmmap failed, we can not demote page */
 		spin_lock_irq(&hugetlb_lock);
 		set_page_refcounted(page);
@@ -3325,16 +3326,36 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	 * Use destroy_compound_gigantic_page_for_demote for all huge page
 	 * sizes as it will not ref count pages.
 	 */
-	destroy_compound_gigantic_page_for_demote(page, huge_page_order(h));
+	if (vmemmap_optimized)
+		/*
+		 * If page is vmemmmap optimized, then demote_huge_page_vmemmap
+		 * added vmammap for each smaller page of target order size.
+		 * We must update/destroy all each of these smaller pages.
+		 */
+		for (i = 0; i < pages_per_huge_page(h);
+					i += pages_per_huge_page(target_hstate))
+			destroy_compound_gigantic_page_for_demote(page + i,
+					huge_page_order(target_hstate));
+	else
+		destroy_compound_gigantic_page_for_demote(page,
+							huge_page_order(h));
 
 	for (i = 0; i < pages_per_huge_page(h);
 				i += pages_per_huge_page(target_hstate)) {
-		if (hstate_is_gigantic(target_hstate))
+		/*
+		 * Use gigantic page prep for vmemmap_optimized pages of
+		 * all sizes as it has special vmemmap logic.  The generic
+		 * prep routine does not and should not know about hugetlb
+		 * vmemmap optimizations.
+		 */
+		if (hstate_is_gigantic(target_hstate) || vmemmap_optimized)
 			prep_compound_gigantic_page_for_demote(page + i,
 							target_hstate->order);
 		else
 			prep_compound_page(page + i, target_hstate->order);
 		set_page_private(page + i, 0);
+		if (vmemmap_optimized)
+			SetHPageVmemmapOptimized(page + i);
 		set_page_refcounted(page + i);
 		prep_new_huge_page(target_hstate, page + i, nid);
 		if (cma_page)
-- 
2.31.1

