Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A828A3C2C07
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 02:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhGJA2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 20:28:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41196 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229854AbhGJA2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 20:28:09 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16A06iVm016569;
        Sat, 10 Jul 2021 00:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=mv+YLHT5ozjyssslwLvKDVloPcrXlhS+X96HUt0ai9I=;
 b=stYkJR9MUvqcbzqeVbK749Jg9S73B0z7Rr5C1FKfNkQ7LQNXPELN/fZRZDalCFo2qWhl
 KMLLjDhpK1Ar7n+dANnRfrMC8gwsqxBhPdCGDoPl4Vxl5S4DJ/yqTf6o4/7R9rJPsCjm
 kjOXm62eoGV+4cGVevWMaRTGXNuu6c2djNNkKdsDmSWFIbIcvUkHGOYQqkrBoqbOaz2Z
 rFBtLTGaUVHBcrV4DJex0PdAu6b2dFPU8fKwxR0tfl0lF4GdnHXiEYQXK90sfCEqY7LU
 Ni6eVUX14qQerI2QxiGTjPCa1OwBc2tMC/4D0g9M3Im1HeriPJ/5kjJ+Ab5QZejE9tQ8 ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39npbymemu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jul 2021 00:25:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16A06XUC021657;
        Sat, 10 Jul 2021 00:25:01 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by aserp3020.oracle.com with ESMTP id 39jfqkceyr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jul 2021 00:25:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwRs2WpZToDnPQKfszZuJKkUaCogEi5w3VoodvsYDalV08RABPu5TnFr0WA7GqoAz1bAI/n9fg/w0+jqTUV2uTW/71weOQQO36jZmS7C1DUA3jEhEyLqT842WEI8wWJjKx7Di/i5scOq7EGsNB3N8bL/OUa5lcNx4cz5Tb/6VPg0m8IQT1PoQx4liZCVA/KD7omMryRa5Bqt9l4OGrQJ4gtsry4ZKgxFyt3KrhAB6iX+h/hM1dVCyQ8IkoqK5YGVnD5pc0U7x5GUWuS0j/6qzd871MYUVbHEzRBDzc2hwwzTqVdjeJMLyTXObq8yMUc8/YaoOfYHIb2NaJGQxOL74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv+YLHT5ozjyssslwLvKDVloPcrXlhS+X96HUt0ai9I=;
 b=T5KT6viuVyOCiEqyyoCoDxXXOvWxLM4EeGlLIERq7HmwpWuZEs102WUW68cmjjm4P7dtKJlevNSwLEuAfjZqYoLT7dmZHPvh3eh8+gx5ktp2VoYRIUdl+ojb4NFHbS2kxKqacJkSDhO9uGtLlkeq0O2LrXMF11Gn0o5CvsBDcSpDkvFY+KxpAd6aJ+WuyyXHnxuo3pJy+wJlgKVcrEer8kuWXOkIfT1EKb6Jsx/gOrC6v9F2I2pJW7f+awXmhWny70NIFCNKz51csxU1AWr8fUKq+1vcSqSwkHaACs728YhNUvK5fO2hUyYxjzXkrek1g4zqdu+6bXyRA0ygQlh96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv+YLHT5ozjyssslwLvKDVloPcrXlhS+X96HUt0ai9I=;
 b=W9NJ2Cho01gOw7/urhHvfadCeQPn0buIZPW0JjTL6lCjcahLYntSAnvQXfg5kiz6ZXOoCcpYcepbg39T32Z6XjSH2ikQxdW65Mf9CKH4rDUdXH5NOKqH5pm+lb5TVz8Wmic2NBrcmTVT5PNd1wrduLgfki1DWQSngLfo39fFmzQ=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3810.namprd10.prod.outlook.com (2603:10b6:a03:1fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Sat, 10 Jul
 2021 00:24:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%5]) with mapi id 15.20.4308.023; Sat, 10 Jul 2021
 00:24:59 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 3/3] hugetlb: before freeing hugetlb page set dtor to appropriate value
Date:   Fri,  9 Jul 2021 17:24:41 -0700
Message-Id: <20210710002441.167759-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210710002441.167759-1-mike.kravetz@oracle.com>
References: <20210710002441.167759-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR14CA0041.namprd14.prod.outlook.com
 (2603:10b6:300:12b::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR14CA0041.namprd14.prod.outlook.com (2603:10b6:300:12b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Sat, 10 Jul 2021 00:24:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34889300-85f9-4032-241e-08d9433926b1
X-MS-TrafficTypeDiagnostic: BY5PR10MB3810:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3810ED3B6B3100A2D1B56E6CE2179@BY5PR10MB3810.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3alEj0/KMSIAShI1sDH67r7H5GrAlm1IVfeh6tCFGFveC6SVh2SnbLlRzJuNttnk5zeiwl/7KG0k/29AINHpqlMcFdbUKPiXmwBmBY8N3Gc/zlLUv6EG/y/yFKa2q/w5M+0nnWfZYt7h2WEp+wstUxcucHJnMqaHpD0mAAf1FIhIbZqj0w87ymkFl2vBRLNYe73koNbzl5BzEvHGddBoFcIt4A+InjZp/eNcOVNqiZrgADnvEeNeqlNRLXRvAKPlXuNTtpVyD5KpQPsEAHczeWegLH4d0HC5XcnUBPGeKQcXJlLnhXtOalYPM5CjOiCF3UiGYV3u7Url4cBQPLYUVLd+mNxrDANMxfXrF0wOBNX3QqrCRNwFfgLwC3t43jcmKzMl+31apnnfQasIEc+nkn+ofUEGghFWNiiIAFxtKXTgcyNJ5hbtBHzRH4wK9aQvY2OrSzwVK3TmF48RJethXdYtHCQOJBjEwJd0uFLz9Hh1SrnH1Cki6M1fKMY+sGlrqiQPenDJXRdTE43bnNAVWqqxI6Qp4jx/fC5BJw5ebwiH4PFRIzJ1poLWp/LmChvB7Y6xv+vhq6NOBLfDiX/Y96LIMCZzg00khp2FmU3/FCtnMMQw1kitCxc1vk0UFUEoLLCF7NKks9lqAyqTEgr8QZboXnSeeUNeIz8dTx+lJ5lyoITWEHNBxz2Sa024ZW55
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(39860400002)(346002)(366004)(66476007)(2616005)(8676002)(107886003)(66946007)(186003)(38350700002)(316002)(86362001)(38100700002)(8936002)(956004)(66556008)(478600001)(36756003)(26005)(44832011)(4326008)(1076003)(52116002)(83380400001)(54906003)(2906002)(6486002)(6666004)(7696005)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?215ozdSJsLflD6kitJsr9o2cPa79VosgtsPbzKcw6WtbXn3mIhLkE+WJt4a3?=
 =?us-ascii?Q?4pZC9T9R45w2Okq7To8v2j0Crb097NWcGEU3/yEtPdY8TO0m1aom7XipkHZZ?=
 =?us-ascii?Q?5GMqhA84xYscwHXZemi0sIjyvTKimA7QWwvtO5hs0UdKWM//KfQTqiWorupI?=
 =?us-ascii?Q?mp80ZY8sdoi6d/s+mF7TXG4rHJCFfMwOC/i/yqq1e8cfzHoNU6LkA+MBP7hH?=
 =?us-ascii?Q?DBlBNcnxV3frHWRRQJhUuKoFYe4bTzt5U2gWUjd/M6n6bKYjTff7DPWb1Gkr?=
 =?us-ascii?Q?3/D4fDKT+u7LY7IJ0VQVJa5f5uMZydRumRH2sy+Rj27pEDKACzxOx5mB6YqB?=
 =?us-ascii?Q?qjAVOi0h8ihQL5Tx4bMEZNuO2MbIwhQcPwBk589/3FACG56Pvi9G8+G8RTmf?=
 =?us-ascii?Q?WK75kZkV6EAYoSBblzvwc7hZzjgrpFz8v8a15OkDSSav5yepuezpZuENzBQy?=
 =?us-ascii?Q?9iA7C3MQJxE6/EmBXjEhdtBx66VkFpZlteyDXP7vETAi9hsvVjcJgGaOSkw6?=
 =?us-ascii?Q?fOzYPU+EgX6bMPLntvSMbHgBGbPFczgaKJHBwPRBvpUq8R6BZQdzEerjuydR?=
 =?us-ascii?Q?YjN/LhrkNoPqJWhPV2ZYCmW0RjjqQKeBOJ7RCbr3gSx2S7mNeJhdsd2HXyf3?=
 =?us-ascii?Q?GAcawWtN0CDYnEyy/1tplR8UWeFGo3/GPnsj4GaGMYPZrLTXmJzmuvcUk5hM?=
 =?us-ascii?Q?JeRcEMuKSAr2N7smdCGoZv4JPURKDH0pLIcAgKiPl9ezHqxa4ixCvwPhB2yw?=
 =?us-ascii?Q?kPoXxVpQrg+wnceFPQGtRC+K6ZuQ2T7OBGbFU3E4T8ewI2mNYCsGEdHadocY?=
 =?us-ascii?Q?o3m4c49bJnnNebb/jyrbzb3RXgNZxKWPf/E+aY1ccmmbHOs+leY6Jp9insNp?=
 =?us-ascii?Q?pLx2bNb5rbYEU0c0XhE9Gcfism0Rx8DZaFljY1cnspAIyuTtG9uiYSg/cCCh?=
 =?us-ascii?Q?nuoIM7bHMExIjmsCeFwg+CeytJ5wF9tXlSc6PdaHWH7YJHaaBRRIOSwg5i1v?=
 =?us-ascii?Q?0Ds8J7R+8tKxUuPKXvi2KOVrJ8gMgVpgBUaV0kFwCO2hAzR5NTJIzaUG3rrd?=
 =?us-ascii?Q?Dh8tMWGn7z1CNr18D+c70FjMbJih2VQ/CHiTfefmTk8nGbuddETo/0KfRD17?=
 =?us-ascii?Q?skT98Nii+78GdS4SlZl7V4Tzedqpg05kd2t/PiGIaui500RyIvBb9OL46Rpu?=
 =?us-ascii?Q?bs/iEGCjOmspFKHX+eoP8zjd70+TZCvWQu1cv+XzO73cd8LuiHypzZUni8Q2?=
 =?us-ascii?Q?Ns5qqTIbXEL7GWPbigVEn35B9Xuxaj3fb3ACkDXd99KUjZcd1P40xUsyQBMU?=
 =?us-ascii?Q?E4JV6iraMKvBbx0/BtQ/wTBg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34889300-85f9-4032-241e-08d9433926b1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2021 00:24:59.3763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkEPkarli7bDVDXeGVe1EsLYKKsTuYEGI1uN4kn6mwbKsKcCilZIpmMBpR4Psw2IgOq4qSxGDCQiPe7vqDM83w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3810
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10040 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107090126
X-Proofpoint-GUID: smOJxBCrx1LXFx-QAxHclgtU-gkdQ3cW
X-Proofpoint-ORIG-GUID: smOJxBCrx1LXFx-QAxHclgtU-gkdQ3cW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When removing a hugetlb page from the pool the ref count is set to
one (as the free page has no ref count) and compound page destructor
is set to NULL_COMPOUND_DTOR.  Since a subsequent call to free the
hugetlb page will call __free_pages for non-gigantic pages and
free_gigantic_page for gigantic pages the destructor is not used.

However, consider the following race with code taking a speculative
reference on the page:

Thread 0				Thread 1
--------				--------
remove_hugetlb_page
  set_page_refcounted(page);
  set_compound_page_dtor(page,
           NULL_COMPOUND_DTOR);
					get_page_unless_zero(page)
__update_and_free_page
  __free_pages(page,
           huge_page_order(h));

		/* Note that __free_pages() will simply drop
		   the reference to the page. */

					put_page(page)
					  __put_compound_page()
					    destroy_compound_page
					      NULL_COMPOUND_DTOR
						BUG: kernel NULL pointer
						dereference, address:
						0000000000000000

To address this race, set the dtor to the normal compound page dtor
for non-gigantic pages.  The dtor for gigantic pages does not matter
as gigantic pages are changed from a compound page to 'just a group of
pages' before freeing.  Hence, the destructor is not used.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3132c7395743..fa8ec2072949 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1370,8 +1370,28 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 		h->surplus_huge_pages_node[nid]--;
 	}
 
+	/*
+	 * Very subtle
+	 *
+	 * For non-gigantic pages set the destructor to the normal compound
+	 * page dtor.  This is needed in case someone takes an additional
+	 * temporary ref to the page, and freeing is delayed until they drop
+	 * their reference.
+	 *
+	 * For gigantic pages set the destructor to the null dtor.  This
+	 * destructor will never be called.  Before freeing the gigantic
+	 * page destroy_compound_gigantic_page will turn the compound page
+	 * into a simple group of pages.  After this the destructor does not
+	 * apply.
+	 *
+	 * This handles the case where more than one ref is held when and
+	 * after update_and_free_page is called.
+	 */
 	set_page_refcounted(page);
-	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
+	if (hstate_is_gigantic(h))
+		set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
+	else
+		set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
 
 	h->nr_huge_pages--;
 	h->nr_huge_pages_node[nid]--;
-- 
2.31.1

