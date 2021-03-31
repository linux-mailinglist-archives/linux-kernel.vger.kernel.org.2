Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A101134F793
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhCaDnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:43:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32770 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhCaDmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:42:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3dx2k196241;
        Wed, 31 Mar 2021 03:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=kT4yumVSTTqahsAGndQv5xgVPOigCYOjMZ8SzrU+Ips=;
 b=bd+/X7WDTzvcYi4Ja48u3kO45sFmYMv3SC83Qz0DIU3OaeBz487Cjq75/vAf7HB/dnp2
 oxFyVpU8R6Sp8ky80UtKoym0zj4P1z5AoN4yiX6ns2zLeiQ8FbZCBQnvRwavGcQY3j9i
 9a3qlL2Xc95s1XRPx1cE/VHtnyLZgK1r/wfPKLcqEyAEqKx9lBaVihXhC/owzh5zUxYh
 wklaYgxeJU9eftUx6foSoY64gwSy+9jH3T0RU5mc7DVATgDChxwCACq+lrh9PWL9uTIK
 07hgpWLIQuAMd1572G06qMPOd/+S+4an3/TPW5W5CbCXf7Ov53mwE4/NBrSbPsnCKcSy DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37mad9rs09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3ddFr121881;
        Wed, 31 Mar 2021 03:42:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by aserp3030.oracle.com with ESMTP id 37mabnuyq7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCBmW9XpQo2fcOAFFLknzQGabNURIyANSM0K3FeNraoawYoBNeskqm8ATZUblknd95J0EEvSyhHYCJwRxHdelL/zj6YELSg9xb5n1LKoB4DIyllgTBIC/BWIP9p7adAnVRxcmGmCE4R9Jo19Bw2NA25EIwUX0scZVBz6RMjDPnR+324RYMh/l/20B4sirTGh104hIo1dgC1+htlWhIj6IrB426iIOnQAFuv0kCVR2bREkIoYJT43wd05xp27aFDUaxFbttdH/F8aD/VbLfAbgVTIhhwpqvkro+6HoX741Xj2bb9SA+C7W8QfLhZlRdE2tf2E5yRUUL1oH+UtnicgIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT4yumVSTTqahsAGndQv5xgVPOigCYOjMZ8SzrU+Ips=;
 b=h5v4iND4N52yehR6adE+fF3ELx4wv8A2Q65E80ZAW0u7TsNmhVfX7BhB3XcvRWO4SFAFBreHg+bbkNKvxzvishk43GFwzO6xcq0dEC5F/b+0BzbrXQhS5AdbN19u8eoKtgUwC5b1PfQpvSnvquVOMQ6U/gELh0ze9DHFv2284T3KkyNVM+MozdD+5K6WdesFLD2yDCoPNSRDoZd+Nbfvyg2mwzjU7dYTDlH9lZ6tA0y3aPy/gmhZ3Hc/mH8Wji3wV6ZYr81fHPEHz6m0oTz+v3Mn7b9GqOi0RSpCQ1KXozsi7CZ6DZCaMsfS0pKqSAbPAZE86f8RPS8CRBRIsZ9fLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT4yumVSTTqahsAGndQv5xgVPOigCYOjMZ8SzrU+Ips=;
 b=luQrMZ9PTk3i0kJUzlUP2FHjXZFYQduQ9iKU/SsbYThUXwnylFXIA7Gg6vo3SlGv+KJxNekYzxgbiYA88iVQE7mjeTb+lQChsxStzTR0vtayG+fpZ1RiP5Aw8NNf/9pPDGF0eCqSpq1CwDqrqqwJUQgWnXYrm07sjU2Ebf+uEmM=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 31 Mar
 2021 03:42:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 03:42:10 +0000
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 5/8] hugetlb: call update_and_free_page without hugetlb_lock
Date:   Tue, 30 Mar 2021 20:41:45 -0700
Message-Id: <20210331034148.112624-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331034148.112624-1-mike.kravetz@oracle.com>
References: <20210331034148.112624-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:104:5::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO2PR04CA0202.namprd04.prod.outlook.com (2603:10b6:104:5::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Wed, 31 Mar 2021 03:42:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 786a9967-ccd3-47d4-edb4-08d8f3f6f713
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4462A08489386021ABFED0B7E27C9@SJ0PR10MB4462.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkBYfJXbDs5aNYM5rZZZCbS+FNAc97uo6hG55mbhGSk9e4M7ocrCcQdugUmcA3NbUfEWyn8YS+HxRF0LxKxoW3KecaB2+dZrdV3IeMbzssVPOWPVEV4eq2xUYV/PjxTRaCqYTHo17zV5FqG9EkMvwhTcH7rlmI8Rj+7Y42F0s6we6PyL71JABRzzauVzL1wT8dJCbRNgcIawcOJXmq5xIGdTFFye7eEIiTDymNmKgNsPyW5EAeC++Qzp0y1XAPg1D9Gq28NxxtWoWBwQVYzvJr05uBofWGTOMuVQ5j4U2T/iephAWyDXQvzuqf1FoYIBd1S6itFvs/w42wbqFFBtGlnX+SfmFg8pGfAno4Y+o4uyUYEu8BY/TIoy/1zMhkwstxFZn2ONTYLNp/VkjPMqIcI1dcB+XtlWj7QmpNbukkTfOtUHpdc7wbqBSyYTjTvCSQ6ObV3bscPWAte9RpBXQBQ5SZ6pbEKNvFiE/L2sLwAmmQXoci0AHQ/z2IyKDXrL0TjzUOEs1Xf+6sxX10TF5ruXo0Tzu7yWwzr15T0c59dH1m877vh1y96kU0ynPTQ48C52BdTTMainxann0+F3f06QLLksZ+85JzrQibLr66Or8PRnfmUO3DcXWEZQSuaV95J41C4T+LytHOge9HwyWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(346002)(136003)(366004)(86362001)(36756003)(83380400001)(316002)(52116002)(7696005)(66946007)(54906003)(66476007)(66556008)(44832011)(7416002)(4326008)(8676002)(1076003)(8936002)(6666004)(956004)(2616005)(16526019)(15650500001)(6486002)(26005)(107886003)(2906002)(5660300002)(478600001)(38100700001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vPtNmo9ymXUNgayiTLJij2RohDNFXGUcbyXSGEsP3Tefcr0Kd1dFai8lnAIr?=
 =?us-ascii?Q?qKFZGWBOUiAyBB73dCGvsvOX+MdL/qF/54x2lbiONTYDSRb7rsMbHubodxWB?=
 =?us-ascii?Q?+jIS9ZZU3GD/wvPTNLEblKxIlI91tZ7tCLxklzFGkDdIW7slGIWU4Q47LO9i?=
 =?us-ascii?Q?t+Pdlec6zPlu2kdD0o6C/nA7yhMIh1TbOTFMEFbJCaE+1TntWwsoXJKqUbdh?=
 =?us-ascii?Q?kqKB2pE4poXqeDAA3su1+CNjMnEz7i56vTBdjuzJwhP/Ikbdhp/0ddkSu/XA?=
 =?us-ascii?Q?iZ5oaM3/nhi9yFcsiWOC9WSaqcgj9Lc8krhE6RrhPGeRuoactyJJdnBGuxm3?=
 =?us-ascii?Q?IHFvAK0ySV6XnEBCAvZDmnc4AkAZKX16iyId/Wk87OOrYlh8xduyDScsdaru?=
 =?us-ascii?Q?8wlbKdQNSa/MgJomBENvOcfTP6moLOZ5KtuojywJl9wFoBVg48r7RRBMLx5J?=
 =?us-ascii?Q?Mj795tQvjMZIRXKfaLcOn9KpEMWFV7CxINOGzcOojXzwzyWsn3MyWmRfN1F4?=
 =?us-ascii?Q?75tS6XThkR5UbeCZEbsP1kG+Kc6akuWeV8/pQpvZRkfy6iJGhGbXU7uh9ms3?=
 =?us-ascii?Q?854HnVeUHXXJzOTeArE0E5v7T7WZc3ptOKw8tGyd0uiaZlnreudKMq5lSlcO?=
 =?us-ascii?Q?ONWOlzUNTWmMKSVmNsnwSTCKImIeMPgURqArlUOySsgScgKgXK76qiGLYgfX?=
 =?us-ascii?Q?wlfLrtgRj0xYBisxp5qVx+zE4qVIalgHz0b/RtlNCxC8VohaLlm/IdGaoaRJ?=
 =?us-ascii?Q?NE5AKIlB4yLhRpuyhui5CzMheexw3hMrB3sApgiVHEES1sh3YpFml4V+hPxQ?=
 =?us-ascii?Q?2/aw3HxZR4H4oYlqw53CXgQhfmmdvldnItICe2VW0G20dmV7BW1OGgAOX5fe?=
 =?us-ascii?Q?ZCYfDXdtjPA2oYVURc7IksnQCeHxdDheQips8Kln8jYZyVm/nWMNegOGjFvy?=
 =?us-ascii?Q?w7zTeIxmTTI2Gwv4voewYszxXdPWkkiQxqnp9R59c3Ov+OBQEzcmDKkW/GWY?=
 =?us-ascii?Q?kDlh5E/Hcchij8k8eadT6rPT7e+6NTpt5Iat0p5koV5qxmyEl3n9Nw6rr6BT?=
 =?us-ascii?Q?o56amGdWTnGPdzUgONvevKMK52kZCv9NeE2zebrj/rPjOT9hDKW4JpMQOf1g?=
 =?us-ascii?Q?1xP6YsWbOpyi5DON6DpULWIEpM7pwWdrItroMlde6KN8oWMrXmHFXsvKFNtY?=
 =?us-ascii?Q?H8OPcPKMrNsf+8VSDVrafow1qx70SU8mSixXUJkRSneXhX5YBfh4TO3Nc8hW?=
 =?us-ascii?Q?Lsp8x8CI5n+Vy9JiBnwDwL7D2wRccAf6BrgXFwBRzV9hkDV2fneKDS0CPdEd?=
 =?us-ascii?Q?ZwE+RbfddHFoT5+ruvt8n9qx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786a9967-ccd3-47d4-edb4-08d8f3f6f713
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 03:42:10.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VvN193wgKmhwpDIsWZ+CTCwo0JQpd/zZErNo7LFCqI/wyOZeN2dmrvF/GKasWDMbifDURWrkBrN0tjDolqMroA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310025
X-Proofpoint-ORIG-GUID: jxbsYDuhH3M8Xi0LCJiFV71YySRna8T4
X-Proofpoint-GUID: jxbsYDuhH3M8Xi0LCJiFV71YySRna8T4
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310025
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
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 16beabbbbe49..ac4be941a3e5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1451,16 +1451,18 @@ static void __free_huge_page(struct page *page)
 
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
@@ -1741,7 +1743,13 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
@@ -1810,8 +1818,9 @@ int dissolve_free_huge_page(struct page *page)
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
@@ -2674,22 +2683,34 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 						nodemask_t *nodes_allowed)
 {
 	int i;
+	struct page *page, *next;
+	LIST_HEAD(page_list);
 
 	if (hstate_is_gigantic(h))
 		return;
 
+	/*
+	 * Collect pages to be freed on a list, and free after dropping lock
+	 */
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
+			list_add(&page->lru, &page_list);
 		}
 	}
+
+out:
+	spin_unlock(&hugetlb_lock);
+	list_for_each_entry_safe(page, next, &page_list, lru) {
+		update_and_free_page(h, page);
+		cond_resched();
+	}
+	spin_lock(&hugetlb_lock);
 }
 #else
 static inline void try_to_free_low(struct hstate *h, unsigned long count,
-- 
2.30.2

