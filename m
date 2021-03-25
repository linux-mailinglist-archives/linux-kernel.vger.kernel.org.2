Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830853485E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 01:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbhCYA36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 20:29:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52492 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239250AbhCYA3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:29:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0O4e0143453;
        Thu, 25 Mar 2021 00:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=hPG9oS1yYoYLCZVPq76cD+6Ob4xYB8uw+7PBpGF3Plo=;
 b=IJ9xfV0FbH6JdbwDevke5vrAKD7HlzcfcgMbP9TvJjHWZ+EnyBqxKmEyDSl7Z8G7HtyK
 0iCrOEKYhn4bqzk6RqNIwZp6OHUPHgVUP1RCnObgSRg7yML4Pgw/nPtEr+AkiYN2nF3e
 a5+l0EQEIKtyOCV+iYj8ugbvcsirc/NnqYkJhh4wnlaPmlGkDJ1JcXbuNgCRuyCG5K/L
 7s4TfLjuZywnUp1AhEJUmHUQepxKadhXOf7fBzy14vAEYx8dfLkvrSsu16A8ktZKd9co
 wonlfQrumaqfYLlndoox2OpjkWHVYG70HqnoZfDSxWi9cWVA+NLjWAnkTDre6Q6mAXDz fQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37d9pn4k75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:29:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0QTDP040331;
        Thu, 25 Mar 2021 00:29:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3020.oracle.com with ESMTP id 37dty18p2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:29:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wqjb7gLp1EX4k0feSmoJa9MBLd7DMye2Jfl8eaiucyBUZ7TJXm3E0RdwRA0Gzu2NE2SW/CE0TwQxgH+nqSFF6th2kNpK+iTze3RD9FRLX73IsNzwdZ3omhwUxhV8PWboCsT45DqVciRtcfyldaP5EWdSVQUWqcYeGFKTZVVx+Xoph/e2GD7gpqv1cGTGpztI9OI0rIUMELqnYw4pj4teCaFJHLwEcq5ggF0c9krEWOQYF4/SCDLLGjj48czriV/CC/VUtZcgQqlgwDjius+CRoUNWC1XPXsEzpyL7Da4MGRLafaqk9JcialnvziFnVuZ19o6daP+eNMcbhnERku8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPG9oS1yYoYLCZVPq76cD+6Ob4xYB8uw+7PBpGF3Plo=;
 b=a7B9Ck/KrSGgs6gyR25ON+TWPJdfEpFURoBkUoyTWR+BeNbzHrAzdoR9vcXO++swPatNmBsAzkdaPVFeCwCSAPVrrFeA+4R+QmISkV9OKjSpag7w0Jdczs68JE2+LzD/mm2ow6zIY6XLyFk6vvWH5kCsiFU9kmDQns4l07swFOrvsrhNgZ7FuEOsS+W5E2HUj/6w8knwHGfOMpn2cEvnoEDjC7M5epYIgL85RvKwqDXP9HTSVExlg+Tt+qn3uN/to5QP7E+VJKFrV19c6XKTSd0BUYK9v6Mvxt7LuHpjL1iEUUqelwP3OhL/Ifl3UVCu1pCptLD2LwUebR4ec4+8cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPG9oS1yYoYLCZVPq76cD+6Ob4xYB8uw+7PBpGF3Plo=;
 b=H0mqz+pmFsSjr/ClhUfHzHDUj1CagIbF4QKD0e7qGjlYYu3KnCvo/tu+0ytwpletIX+lkgnjHanXLJXZDyoxjp6eO3DKo6SY/BkvtYv3i8OxnOki4wymH5O9xd0NiQWG5X/Ie8rPRpvcqj/a9JP4ItygcuoKw+cTOac4XNK7QMI=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3875.namprd10.prod.outlook.com (2603:10b6:a03:1f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 00:29:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 00:29:06 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 5/8] hugetlb: call update_and_free_page without hugetlb_lock
Date:   Wed, 24 Mar 2021 17:28:32 -0700
Message-Id: <20210325002835.216118-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325002835.216118-1-mike.kravetz@oracle.com>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR15CA0042.namprd15.prod.outlook.com
 (2603:10b6:300:ad::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR15CA0042.namprd15.prod.outlook.com (2603:10b6:300:ad::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Thu, 25 Mar 2021 00:29:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c70f952-fd41-4b62-58aa-08d8ef24fcf7
X-MS-TrafficTypeDiagnostic: BY5PR10MB3875:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB38757571915F3CF0AA8406AEE2629@BY5PR10MB3875.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCKbYXBIPx9z7RZ8nK00WJQMFBbGN9GKGLj5hf19JIdlos/I07vW+jzF2zfB5V93Gwh+cYutcTRdt41KcPlQ30ORhgNUEV8aqiQeflPyBzUOKHbrzcp6WJ8d/6KlaaPGsUkbRS/NKD9ycFa1qf6xzbkWg9zNK4wtnZ0V8CuuxBl8t5pQcrBlM6hXVhuAEgswJyJL+dh4cqACSk3717nnui1BwGr5tFhkJHd8EjaYVzZp9g7oiT8MsXbi5mu1xcj2w/SdSP4grnuKJ3yksJq+RpP7r7J7aWi4s9yiUGsAcLHArI5GkuiN9xzySKfm8YD1n0YIgknN9fpM6gQ+CQ01/66dkRJbqLs4PZejJm+92qs5s1dJ3y9/1EJJavl8deQkvop0xgLTGmuy9VeBi33s0ilKu8NESZstqWipoTd1rHPScKBk1u506fVbynZtmrMmk2+cNIfdq91qVkplrCEAaP9dbPQtd1MzVXV3DhhZHkQK0K9QustnVPvq2876S+E+FLmFFzLk7PKkOSjiBaTLyi9ue43OdO06S3S+e6ZVyZZyEFsKzAi+rgk8v3dINJvKsp9f3k6ae7v1KZjLvnVU+n/O5zFCiVXo7+/3Js9bSLIsAj9Pa9hj/JL3d6Jl/jMybjUHdORXQHmzmRhVO1S88A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(376002)(366004)(136003)(83380400001)(6486002)(52116002)(186003)(4326008)(66946007)(7696005)(2906002)(26005)(16526019)(66556008)(6666004)(5660300002)(66476007)(8936002)(44832011)(36756003)(316002)(478600001)(54906003)(2616005)(8676002)(1076003)(15650500001)(86362001)(38100700001)(956004)(7416002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kbmSrKtqTCb2u+JX1AJJoP0PtzDlSJazY5VoW9Zqzivx6DYhPWqQAOwk9uYj?=
 =?us-ascii?Q?QiY/HarZChDbDwNB1f/EKqN/BXgi3ScelvihUnPuL3BULbf4B1UeiPD11egC?=
 =?us-ascii?Q?VaHljPVKbJtBXqUxCJmXE8KW0xBa8N8dUyCLnHXM7OMuiizVbdTpoo9Yzieb?=
 =?us-ascii?Q?lkzm6vU6VpUuBoG42/OF8//JemreUeeLFtBB2ryNgyey8D0dk9Cp8JguFMF5?=
 =?us-ascii?Q?tejcfIE0oUkaSJj3bZ4w+4zxx/iR+M+mm3B3eVkbhDkDhXuHd6jFR4McB+yw?=
 =?us-ascii?Q?Sa9x4kav+TCEEuxDoKSuUxxEletB2ffStUrCfFaV+lzCxXeAIM57DIKpX2FB?=
 =?us-ascii?Q?G+avo+S3CkpFt361ts4WGFYXp53uRatk+tdrvriCH9Ik/zaH3XWbGuZbOnIQ?=
 =?us-ascii?Q?Lxxi3iOEhGeCnjBtchbrmO/4D6nflPESr8DbmPgyBKYhPBTaUxfpnypOCC0d?=
 =?us-ascii?Q?Rsd3wYUT063QprKpK9oudG1z22pKH3vXeVOSKRluadYQfdTnWYW0HVJkeqMQ?=
 =?us-ascii?Q?bX3bgUI4yNw3aRV8uBzOw/3Lj4Iy5oyqovDUEet4FYzcnqFbQjPTZbffUPPx?=
 =?us-ascii?Q?BQbICKLkCipVYrFoD6VEui/M2qZQyE2DcgKsq/VESYGFcNoAyKkXzVkphBSZ?=
 =?us-ascii?Q?JEl/++Pgp/dajYQSG37FxEwrnK7WriMI7go6jABlqf2JMoDfJ27uucTFqBRa?=
 =?us-ascii?Q?RcwDnElHmOboVVPkpJD/r5NOmw/k+mLqOVmrJgD/+Rh4FDcGQbQQtL0BO3R7?=
 =?us-ascii?Q?emL68rf0O3ogMTPSI72uakc2smMGac13PgtRE4HIYdoXQhSe5Zq2xj7AeBnN?=
 =?us-ascii?Q?7Bfr5thJbDhbuomr9lxd1DBACZ7U0CAn3yTDkT8MWl7rMgEPPg8urbkA0m7R?=
 =?us-ascii?Q?Wvh2Q3UxLjvKys09N3WWihAoTfhlKf5XvIKx6jfZEvV3WVFDOeDoayFTerbJ?=
 =?us-ascii?Q?2gbwbWOWYUJkWID2uBn1Cr82T/mK3tOZF/andK1QZp0P5hDs60M5NmKdqcNz?=
 =?us-ascii?Q?g1GmECMSwEL9Qs+kQ2JqbHLmHxQQ2q2BNndo4Qhbt0UNCawjabtSQkegbnZp?=
 =?us-ascii?Q?k0qtAM2gVUpVYcnOzhNuK9yFGVBmIXwWna/+FAq2AgXL5wPyw7/dNXuJQRjD?=
 =?us-ascii?Q?/0Eg5TvNm17XPuw8XDg3/8GOUUcVZnT2qfCEkI4Zivg9I2e38nf2LpIjaXXg?=
 =?us-ascii?Q?R5aBn78Ys3PgoSfq1Nt7AIgrUwyprdq4o+nTlgd3v8Pk5J4KOD6zJaT64EmB?=
 =?us-ascii?Q?D+GRevh8iDUiBezchfWi6bTXUlkgeACyfYxRDGpQxUfV9dTv8r5g38pYMWVq?=
 =?us-ascii?Q?k4zB1p9ip8uBx9rZnkBahj+M?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c70f952-fd41-4b62-58aa-08d8ef24fcf7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 00:29:01.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJM2qJ1CbnxQ3VIh1+2A6k42ViMKNno2gDT7HV0WfgwExGsVP6KLZaEF5s4RFuT7WzFCRQJxKO1lbe1gC/HOKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3875
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of remove_hugetlb_page(), there is no need for
update_and_free_page to hold the hugetlb lock.  Change all callers to
drop the lock before calling.

With additional code modifications, this will allow loops which decrease
the huge page pool to drop the hugetlb_lock with each page to reduce
long hold times.

The ugly unlock/lock cycle in free_pool_huge_page will be removed in
a subsequent patch which restructures free_pool_huge_page.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3938ec086b5c..fae7f034d1eb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1450,16 +1450,18 @@ static void __free_huge_page(struct page *page)
 
 	if (HPageTemporary(page)) {
 		remove_hugetlb_page(h, page, false);
+		spin_unlock(&hugetlb_lock);
 		update_and_free_page(h, page);
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
 		remove_hugetlb_page(h, page, true);
+		spin_unlock(&hugetlb_lock);
 		update_and_free_page(h, page);
 	} else {
 		arch_clear_hugepage_flags(page);
 		enqueue_huge_page(h, page);
+		spin_unlock(&hugetlb_lock);
 	}
-	spin_unlock(&hugetlb_lock);
 }
 
 /*
@@ -1740,7 +1742,13 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 				list_entry(h->hugepage_freelists[node].next,
 					  struct page, lru);
 			remove_hugetlb_page(h, page, acct_surplus);
+			/*
+			 * unlock/lock around update_and_free_page is temporary
+			 * and will be removed with subsequent patch.
+			 */
+			spin_unlock(&hugetlb_lock);
 			update_and_free_page(h, page);
+			spin_lock(&hugetlb_lock);
 			ret = 1;
 			break;
 		}
@@ -1809,8 +1817,9 @@ int dissolve_free_huge_page(struct page *page)
 		}
 		remove_hugetlb_page(h, page, false);
 		h->max_huge_pages--;
+		spin_unlock(&hugetlb_lock);
 		update_and_free_page(h, head);
-		rc = 0;
+		return 0;
 	}
 out:
 	spin_unlock(&hugetlb_lock);
@@ -2563,22 +2572,37 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 						nodemask_t *nodes_allowed)
 {
 	int i;
+	struct list_head page_list;
+	struct page *page, *next;
 
 	if (hstate_is_gigantic(h))
 		return;
 
+	/*
+	 * Collect pages to be freed on a list, and free after dropping lock
+	 */
+	INIT_LIST_HEAD(&page_list);
 	for_each_node_mask(i, *nodes_allowed) {
-		struct page *page, *next;
 		struct list_head *freel = &h->hugepage_freelists[i];
 		list_for_each_entry_safe(page, next, freel, lru) {
 			if (count >= h->nr_huge_pages)
-				return;
+				goto out;
 			if (PageHighMem(page))
 				continue;
 			remove_hugetlb_page(h, page, false);
-			update_and_free_page(h, page);
+			INIT_LIST_HEAD(&page->lru);
+			list_add(&page->lru, &page_list);
 		}
 	}
+
+out:
+	spin_unlock(&hugetlb_lock);
+	list_for_each_entry_safe(page, next, &page_list, lru) {
+		list_del(&page->lru);
+		update_and_free_page(h, page);
+		cond_resched();
+	}
+	spin_lock(&hugetlb_lock);
 }
 #else
 static inline void try_to_free_low(struct hstate *h, unsigned long count,
-- 
2.30.2

