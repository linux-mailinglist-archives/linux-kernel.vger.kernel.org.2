Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F3C35A827
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhDIUyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:54:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33400 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbhDIUyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:54:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139KoYvq128542;
        Fri, 9 Apr 2021 20:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=bt9Rgw2Wi1977yVo8yxhNFJ9syZSk12iVGxQE7xzr7g=;
 b=DOCtLnHK9Kraut3bf6SOVVcIIZpL6hhxF/kSj4ENTxQMElv5un242vrtBLz0Nii1x2Bm
 1zfufmryfWUVgxkigoeMyg/21vfQSuYEZSklUIoSp1ExTZ87UqY41Peeh8XFPI269eEP
 W1ZQB15A4RcyfkoXFGx0uz8mMckkp7Ptg/KLW28amdOOrVR2PcPwBRjZr+qOleEkdn24
 HbQtG4RQQLOYgVgSH6lXcISAjOvpulhez0OO4zonEP19xwZ/VL5+CyJfgEJpCnFZpGff
 ozeTNub16BLgM9LorlGXST+gRxJabSmojx0MM5KUUNXUcVh6NhkEjAFGZ/oqjous6lXQ vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37rva6apk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:53:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139KjSfU174393;
        Fri, 9 Apr 2021 20:53:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3020.oracle.com with ESMTP id 37rvb71qjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:53:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ihnz3nX559IqwtZLMlfUkRtMDDvQBExiyrX3g8dEhnRJSvPR76o2JDU8E0DLUeAKn6EOVQ9MHTyIbyHJ+t/3wC9HJ9ICzuwBfXH+GDUIXJogPXgsTUcbCfRXl5Deb/o6xBAbgy15WuC4sn1Ec5eRvVwwExx4P6M83iXRMWPHutBqxT+fmyu1gsNm1Jj5CAN0AdUXJ57Cy9g0fCxN4ka0VkC6QKEaE60Txve95+NYt6/BvNVsmn7LesDMB+esC0UeBpv/8Z26Ogrwi0qkc6ou7QW26nuetsT2TD2I5HtngbGZ9hb+T2up/dIJkTEUKwgNZHLJRAhBVYNkqsujDkVH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bt9Rgw2Wi1977yVo8yxhNFJ9syZSk12iVGxQE7xzr7g=;
 b=TQPYeWQEmwUvPuZefaxATnUuJtsRrb+rx54WRUBRRwpN/WAtTQZXB4QbM7KOCHo9R2nbm3w6j6jhnYg+UfR+mYIAOwPOaQ7HHOGH7rZOggz70WHClwYCBm779nnpFELrdyd/PdkAYPivV8Xady+hJfXA6ntBvru6dE9B2i/Dg+tbd9oHPYzJeAEKzhcq3RW9gHlmkPVYz1ywRYQIVtWDqXgI65SZ71otvMhc45a827DT7Mi1qFKWvswXuzeXxtIW9c1MlBMFrFvZgFLCGJOc4VblM4H5YzJ42WpnmFfB+OrYZ5WzoSfzOJdtXKLyixXEgpqeeIF9R3e7IQTNbAUpTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bt9Rgw2Wi1977yVo8yxhNFJ9syZSk12iVGxQE7xzr7g=;
 b=BNp8vIwiGZw8JFXBo7MxLadHzDoWONpBFQ1Nvl3TSWjzQoGcEtBgGzcnYO7zfuYc+9jdnqQkk0Q/IQziTKylAV2Z9Qfa0/Jke13HlzBtCbK15J/HMTpDcYuDx26wDK2WgDzfTfNO02Lsgb+4uxqyFLP9drgMvt+byq+xzZxPImc=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3972.namprd10.prod.outlook.com (2603:10b6:a03:1b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Fri, 9 Apr
 2021 20:53:13 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 20:53:13 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
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
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v5 2/8] hugetlb: no need to drop hugetlb_lock to call cma_release
Date:   Fri,  9 Apr 2021 13:52:48 -0700
Message-Id: <20210409205254.242291-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210409205254.242291-1-mike.kravetz@oracle.com>
References: <20210409205254.242291-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:101:1f::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0050.namprd15.prod.outlook.com (2603:10b6:101:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Fri, 9 Apr 2021 20:53:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 758335e7-909d-4e1e-ee17-08d8fb997da2
X-MS-TrafficTypeDiagnostic: BY5PR10MB3972:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3972F1E08CE50CAE41E3039FE2739@BY5PR10MB3972.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWFcgWBTToIP1DTNhdDflvAjfcrigng0wEZa/MTZR5ifLJyB3aD6c5EuPNKHI8iGYk/WI4qXyrCGOATYfu9X5nOjaK61g/PsbzS7mVmTVfnOdagcchqtCPrG1JL4l+NXAAT2QYw41JIHpbGkSxXVGWHUOysrPjN6ZpQs2JOxY1uSUhEytWOKJfok4+MmlKgROdAB3BZUr+eDcKBPayZFpcV4URZszleusZDEeemUoVbvXrjRxiq8JeDBiOAphEnRNCuqDnVQcggUaej0abBgiwRm605VOSOqP8SaJW5gQpEezJXjEixba/xNJmbQhTtk0OsSax3DMBqgKBeZ1migRXXU22q0Zi2i8bIlEOvxYr0vZiVRNRY8eXtfX4I7mEGwyXK8BzTeTw7hiFd8CT3h0guAVjUmn7mELl3DynqKYfxKbTQz+1dKB48F1ho+SBy9WS34D9jBmmevCpPo9LUXvT2zDz8uT2Edov5BfBmXG/Qm3h5OFq3qHC2zmeYgJ4tcwiUnUxrkHZFVdXAVEuqoYcF7qWN2/m1lz0kic9rLgpu829b2q9NdH9eaKwrDWrJBwtPpXZCdSVPKvsiLfcZlm9wC0vg+oGYUmpFrB/p3lVn4kpo/5hHc+jDO+ASSD/U+ol1P1USqB5XOmJFnQioRaRIhx1WDz7E62g8LQvtSziLR0hJM3g1pPIuxE9OAYmH9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(136003)(39860400002)(38100700001)(5660300002)(66946007)(7416002)(956004)(6486002)(83380400001)(66556008)(8936002)(66476007)(4326008)(316002)(6666004)(6916009)(54906003)(44832011)(7696005)(2906002)(478600001)(1076003)(52116002)(16526019)(38350700001)(107886003)(36756003)(26005)(86362001)(8676002)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tZEu7sr7r4Li06yIIrpnLJVXvm/pk7nImDQ/JlkW0IFzzbAQIjAMCIM1VIkL?=
 =?us-ascii?Q?1XXY60cpxi9ZSGDahLo7n9NQiwdQe3EkwsSJrfKkG3slx9STfGr/S9+IsX7D?=
 =?us-ascii?Q?RcK5I/wK/nQa7nYi2jDGkMRmkk1oPzIFYIQcHA/m1dRbFw1JpzrrWsNfSxOq?=
 =?us-ascii?Q?qPAPfgupHqAydt0wYANz6J/tzcw0I/AqpVvwUaSE8f0hP7J5iWCUfCgVdYOu?=
 =?us-ascii?Q?fgpjixIKDB6rnqolivFTwmPQ+EIPRPQ0faurK5Mrlzo3tj0QMDqrzHoT4k4w?=
 =?us-ascii?Q?oaT7HE1yw87GO2zNXVHZlAltkKeQk/BQ1d4Im797F3305kwnoA7EEkSImmoJ?=
 =?us-ascii?Q?SqPycIlz50J4GlRq6M0H1WI/FGX7bzzgg7Jl44i+dDyHTng7ao3me/wLnHik?=
 =?us-ascii?Q?OZyU/sQPaxJzKKIg0tU4/448UQQXiG/bpqhYnHX7BZYGeXBiF1W82nIT4eff?=
 =?us-ascii?Q?bfsj6Em3lwl5hj4afs1hz/kcXn56XmIVqdXHmT8gwE6qDBXgAO3lg6NcA4Lb?=
 =?us-ascii?Q?opz3DrZSJaKKPteB2qsKFQqSLPRab+utCBso0Dha60mASZM2YCDSEAlkQyQ4?=
 =?us-ascii?Q?HsEWNbl8ZC+raGmYg3PU34JyuG6B41KV3pNCHRfx474Oq3vKgSyoiyAP0i9U?=
 =?us-ascii?Q?p8OaaQERFst2RdlXyng5oiUHcI5PCzmaJnWqGi20ROeQMbaAv55YDLLz6wd+?=
 =?us-ascii?Q?QkxLBVmj1Ejf5DBGGBXCdj0YAfdtwp860CTSg3fChTY7/rQ0G4X680IYrJEe?=
 =?us-ascii?Q?+c/y6du1drzXFdsUnZezcEM/n56E3B7QB/pTuBt6FvJs2ityK2zzS5Q3k/7Y?=
 =?us-ascii?Q?jI3jnefyEByLbxg1gOJxUTK52TuECM5Hq5/sYTC+E9wvucs3Hdd2+HNGY3u7?=
 =?us-ascii?Q?2iTl0ms0qin6zs3apKmk6tlCITsddqELDEkg/Z4nfWr/lKoJY5ZatD2Ujnsj?=
 =?us-ascii?Q?UeLXWBF58abOIxc5fcur4B5a7ihcAIAUlPIjLDejVDYhabnBsyUVw2PkdnW0?=
 =?us-ascii?Q?Mk9vBEQ1zb7LoqRr6tPUgfz3SyxCOblcfihEn0PKEEvYBPpM9TKe3RCZtyKu?=
 =?us-ascii?Q?E1C9Iq7lz7Dz4MgZQ5h6jq3TjZ8ulhxPg1gC5GwGOuVI1fPvrqFAHbnYBuJ+?=
 =?us-ascii?Q?G8yfHfFcE1uRxg3HrlzyoQF43nTTbo0hBk/KoLQGxNidet+QSqLmBULNYtDD?=
 =?us-ascii?Q?ORorT8omL9JtbyFokkDKvEiPaqaNQaQplnFrkqyWkxuYHtp3VAI7JsG7iwI2?=
 =?us-ascii?Q?6WHwBgNX+R9/cVBT3I8y6hG32gGvp4muCiBTaiATNrCSBXJV0mPRNVPN4amq?=
 =?us-ascii?Q?rv3oNzGohn14fszfRmtKd/e+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758335e7-909d-4e1e-ee17-08d8fb997da2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 20:53:13.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPp/PjwDavGe/df5pzBVlGsvM8Zn5gX9InAesxBZ19VGpKwGNQ2UMbmgTCXiQ6k7kk5CRcOgeXgy9VidXYQHDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3972
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090152
X-Proofpoint-GUID: X_rOirQhibz4gh813l9hcsas-iZuZMDq
X-Proofpoint-ORIG-GUID: X_rOirQhibz4gh813l9hcsas-iZuZMDq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that cma_release is non-blocking and irq safe, there is no need to
drop hugetlb_lock before calling.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 07a95b8623ee..3a10b96a2124 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1348,14 +1348,8 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
-		/*
-		 * Temporarily drop the hugetlb_lock, because
-		 * we might block in free_gigantic_page().
-		 */
-		spin_unlock(&hugetlb_lock);
 		destroy_compound_gigantic_page(page, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
-		spin_lock(&hugetlb_lock);
 	} else {
 		__free_pages(page, huge_page_order(h));
 	}
-- 
2.30.2

