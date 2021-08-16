Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4830B3EE01D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 00:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhHPWvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 18:51:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26096 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234080AbhHPWvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 18:51:07 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GMmKIa029214;
        Mon, 16 Aug 2021 22:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Zw5ULP+Lfflz7uyYnSO4JR8S10OYQiow+gaHUf8TpWo=;
 b=jfPdtbnttw2JRlDgkvCtNRCwBbEL9FzmDYW/d16k/rJz8EqHtcSVEm4pc1iBShneX8Do
 e9YRVlAwDks+rwNDO98vU+OuKX0lJLmZl7RPWrBt/KHAY5xwYExw9VBwmLAWcjfwwW2G
 MvJQcc+zvCkGhoq8bEaFawX2cNkn7tiVu9VgGHb76AMF8O3edNkIMzmN+l7yM2/7xVs+
 kN4hh73ufkpDJj9xwOczzAv5MHN3cRoO5BEgF97j2VPIHeD0GIjtBnMnzGWsPiYV7uw1
 dDJ7fBMQHt7MYz3ikKf4d2AfRCD70Q7pOi03dSwoledsC+gdoDGCrFSRFs4FI06ouBfo hw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=Zw5ULP+Lfflz7uyYnSO4JR8S10OYQiow+gaHUf8TpWo=;
 b=pYRof05wu6XTDPCsJ74jfze1JE9sPSh+maqThC/+TvAtHwK4hFMOhpWL4sdtEWNxYowG
 RWATKtSZYaWPCRVH82tAV/f3Dyt58yocArLo0Q7y7sjleIiX09GgHAe9/KlTlyMaY0GP
 cAmCkUuVgWW0AmlMLb5A+eDIs12kkL0tSWiU17P9kdoSYUzurXCOziZ792G9kNAnfqfC
 OJtgEVGaTJe4bFKio5L9mZbMPAAS4MfOvfCWYkSpb1BQcbCG3e/G7gljAZ0p2qydEEdt
 PDGnszygehBPqgYivGns+2zeSQTdFV5Nyg4rLHI4T6NCqWwLNQTYuhuaDgZwxVwI1qZg 6w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmbabbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GMiu5x040103;
        Mon, 16 Aug 2021 22:50:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3030.oracle.com with ESMTP id 3ae2xy1427-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHTRMVw0oltdYQfl7PrrAUECYM38lT96ScvCuwb3rR1NlZw27emjruxLUYKBgf1HQUPrnZLoUBlgDDkzE+JLLLZWI+ViiI5LUVVt9pT3cgeNiv+6iWGdkQsRASmCOWfGwxFgY1yGYHLQ3xUOCErcJojvBow3uKtp6fNw2cmzCdRvBYd8xyROCqdD4tjggqBakSMEH526hGBIkLXtEZpogdzldRSxCYXrywbU/h8FO9pCNr81BO09wGl+dJvyNVg7j3xeh99ZGPzeuDoLv3dJz6Y+1a80tCBCHiZypDCzz5q4tQvqGUNXusSQOvMQf7WeIeeF825gAQinNktuaio+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zw5ULP+Lfflz7uyYnSO4JR8S10OYQiow+gaHUf8TpWo=;
 b=cVhKQYaX0yW+gP4NzPViUM1Bwypzl9AY7aSWlNeo1AcKQMIV50KG3gFIHmC3PRKPv8RdWDelx44XqOehH3DGjYakVRIMsZ+ESb/1/bpnD5wDj/UfsfajNYUecLy1mDEO4sxzfbD06zQ5Sm6SL/NCwwNj2IbiNIkiyMpyqEOAG4wAjcFK89kxmZWB9DqvGkLLxvHo0x9hBas1r3cNlcas7hS0AFqLTfweIhw9Yv1xa00Bj9zMMWgq63D4BAp7TaAJKicaPa6HrRDpqIsI9+GMJnxDDFyS9JmvppdBuAQN+++FT2kvFsSC7f5xRbELH48xTHWG3NfRVkpXd+HayK4/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zw5ULP+Lfflz7uyYnSO4JR8S10OYQiow+gaHUf8TpWo=;
 b=SRwhje2Iwv+Yd/wELhY9XMrvT8hcpqQet8f666pcn3ad9FGLcDNPAE1FgghyIYUFLIvUePExwMDWdrymgMPIRFWBVpcyGT2F5CMK4AMeGoosL+kxT78Ffy6er3tuWbo0MRL4+Jl7mjRa7KfJPyiJt8E//OodpqRNxHNwUZ1847I=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3397.namprd10.prod.outlook.com (2603:10b6:a03:154::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 22:50:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 22:50:21 +0000
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
Date:   Mon, 16 Aug 2021 15:49:53 -0700
Message-Id: <20210816224953.157796-9-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816224953.157796-1-mike.kravetz@oracle.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:303:2a::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 22:50:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dd8e10f-70be-482a-e7c6-08d9610839e4
X-MS-TrafficTypeDiagnostic: BYAPR10MB3397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3397ABAC6A6DEC0D23D0C138E2FD9@BYAPR10MB3397.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4eGgo0DEXmJ/T2rD7uymOcSDMEKS18xpED/LIDPwy6NozDelWr7O6n9bLpOr/YB74mEpi0LoBWZZ4RZz7tuScsc/+lvNeeamH69314LQXpumQpRnU9zkZZlsDVDJ9zvsESULvHcY9ccZT509l0Wg2hvSHs9cDEoxPEtL8P2ywo633F8KnDqd+kATgyA6UAVSPIa4HbccD/s3osi+kbQN4JNnLO+e6u3HfBSPj31Bdddynen8OIDEqDAIl0W0Q6FUsD6fi9p+t4T4a4ba8UoT8K+pEDu+kM87VxzFdDaxWXqXFjC9TPV15j3CYLoz3F8HGb2/MekYhjJM2QatdtkCsVoaLqAR9RBt5yL9pry5AGajm7nB80f6d1w5zdGJgk1O8Dm7x4kiPh/y6/gr5Dvrs1Gu8bX8NARFocuNBUXRcu+pYljHpQ9Xv6Vptb5fTmBHZZ4ctKdoX7TXL9MZhtqgSJqikf5vOibzOdQorUHbINir7SefaNJsu6SN8pfpbCqHmQToW0xrXjO6HGKzUV7YWvEFJTPwxXDQQPbMusynoiFYKERmZOil7VcJ18Sg+NaRmZoKx09kVV5868M4cK1MnpKUs3a+FF0WqA2benCfeoqztkJ5xslXnE8fIeVEjGIAEBa5NTCc6e9ij64yW/hc8UhmgW4m4JSUmPQu+/jQzgwXsVvvkqUX/cuOkDqgpeBywnjpDoB+NiHe9dfXpSuaRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(376002)(39860400002)(4326008)(54906003)(6486002)(956004)(2616005)(107886003)(44832011)(316002)(7696005)(8936002)(8676002)(52116002)(1076003)(83380400001)(38350700002)(38100700002)(2906002)(6666004)(86362001)(26005)(66556008)(66476007)(478600001)(186003)(36756003)(5660300002)(7416002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AUzY9/XDSB804j84EDZJ3VVT4eSG06eKyFBAsIYOA9B9NXrdzcSb3OQllAXG?=
 =?us-ascii?Q?LtNGiKjNLE8qR1E6d468rHYTlTP59I/wcEZhtOmdMEh7i+T7VZ/itq2rfr96?=
 =?us-ascii?Q?RFtoCja1F5T7UIhMBFY0V0h+zML6c7L259HudPV552ChPANDV/W3E3AQHPBv?=
 =?us-ascii?Q?ZbITBQGIExBqQf0U/JozpLPF8uU5yYvMaR/toasvA0gR2g5vFgGWOKfY9QKl?=
 =?us-ascii?Q?x/CNkCVGa7OJvbsv5O7fu4tZ/MjaLqkTS/LQ27v4XySfdlnTLG5gKooHizry?=
 =?us-ascii?Q?N3Y0NEqVJXE3H89OksbltdfwEq2/Kj5B9H24RwIuaRIW+QFRsBEDB25JWM5C?=
 =?us-ascii?Q?ZLllPYjOTo1Ed6tBFhM2JAEFd1IU4ASwnLJ5EpIi6BHft0eB83CCiDsVqgjY?=
 =?us-ascii?Q?0hjEMXN85NxUvnf+/otF5A7NqMTfp3vPR7zJsd4PdNCuOZiDNR3PMthG6fGv?=
 =?us-ascii?Q?IalmdNYVQ0tyEkdb3EKKGfjT9XeR9TmOzW0Sdjp9fGMm8s5B7fLg8S+KQsQL?=
 =?us-ascii?Q?PO6rGX3H7wSZmShaFdHe68sI0+5f3Slbd54Im1VaYzlPt9JzswkXtmAipgdx?=
 =?us-ascii?Q?hawmpZ8iOdomeFjc+E5A9OjzNdOrGvLV9/3ZlHUKoEUWrYUkTm+q5tmfyhXe?=
 =?us-ascii?Q?w3e5c59ewvrTnIXPva0Ag4mNyGwVhdVaSuMTYWAUiMZVNgfRxPNwnM518S5r?=
 =?us-ascii?Q?bN1zJrlAd0ykL9qV19v4DbnO8kA0opD8mXLkIbO37P0fHnL5E86mB7Wu12Qy?=
 =?us-ascii?Q?UNECbqf/qkblKRGTQpt6Q0Z70yvhWfAnbwJjkUfY7M1vtxs4HN0CA3f5kfrs?=
 =?us-ascii?Q?yrSjGEfUWbiHTgAC93LcGHLC9A21neVQ8IBIEAKsYXxxlfNbfJVtwa9nAxBK?=
 =?us-ascii?Q?nxNpgwYGWEVv9NFMrx0laqssVxpbIJ9CfWkIGN5tmNDcVWN8WkZDchblzC2Q?=
 =?us-ascii?Q?Einxgrc8dfYysP0YTrHPZOQ/A+V0ZulU6UbRl5aWOBN1gnDoARi2qE8ytyJG?=
 =?us-ascii?Q?3vJB9bbTPAwTtovvPZtTTiEn9A3IYdE91IBYn/DMadRR2bW0cUIFMX8IQIKu?=
 =?us-ascii?Q?veV1Be74ZL7zaYGKgBi4YFvJz3+zqw9+CBgLPizoy4fR5okUN/e418xsEflK?=
 =?us-ascii?Q?+b+M+dD5wckhqoHoh0PQKm8iyDuMPJSu1DsNdeogX7JQmXq4K1XP0Sdg3D3L?=
 =?us-ascii?Q?JMICMwgdfedn7Gcw2tl4aABM9EnBfUD2xM9hTl+yFt+E5xcVPLTtPLFNDIty?=
 =?us-ascii?Q?DwMgimYv7CYujJUi7QWuYVAMkoUf6KOAYmCUiBjeL8lLYayQbjbYPjfas2Qx?=
 =?us-ascii?Q?oIkIDrwz+07VtLCpDxJdF7YF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd8e10f-70be-482a-e7c6-08d9610839e4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 22:50:21.1229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wlji959zyBnJC2S8Ds0TDwKk5iyHM/xZonHskNGKTckPNvFMbl4uWWjR0lCjNbFQ1cyPijJ2MFz7My09USUvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3397
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160142
X-Proofpoint-ORIG-GUID: lJQNXD2hfqatuX9hzDjJb_zPMwVy9Br9
X-Proofpoint-GUID: lJQNXD2hfqatuX9hzDjJb_zPMwVy9Br9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put all the pieces together to optimize the process of demoting vmemmap
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
index 259b840718f1..77052ab464b1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3330,13 +3330,14 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
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
@@ -3348,16 +3349,36 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
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

