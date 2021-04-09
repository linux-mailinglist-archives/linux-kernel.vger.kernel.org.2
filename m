Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8C335A82C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhDIUyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:54:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48096 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbhDIUy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:54:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139KoTMn167127;
        Fri, 9 Apr 2021 20:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=hg8jrWwqmPvOZIu8LB0JSYAfzGBS/AoZ7XCZf8h0a2I=;
 b=d26m7W6bcaNvj54vmtw7VRsLGgM+PPctukvpKh20LPcbH+2ibYnnvplD15aeJ4Pr5hmt
 6Z7MzJZFe+sBeA8jM1q/kt/HH/6UVkeaWAfg2o3NOyTR77wFwl5uhgOwaWgnYwjXBW2i
 XWc+nqljUPfelWoOh2sgCx5a1/HHWyCTO91nYhBflBhoROI0X5ym/J5HnE5W4IXCfkU/
 lKZDtaO5EJn4K908dq2dRS7HNnOlYndnvaIqf2wyD0t7Van/ihXKwTwkKt6EK7Ss6/uJ
 QgxvOrlAoSRiUI9FeaEs+Wzfk9D8TTxZNjo+oXhAPTRNHw4FSMrz3JKEfmbep/8QdMQz vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37rvagjqe9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:53:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139KkFoE178983;
        Fri, 9 Apr 2021 20:53:10 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by aserp3030.oracle.com with ESMTP id 37rvbj1pgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzORvRo0bbmjTy+4y/+pdCNYjpiP+S9tFuqikrDC3LMORcc/if78mthdd0PDqjIVguqcswf8wfVGoi5B7t0tSfgkL5Dy9KlArrrMxBo6NrojGVKQhe+BFs6rejxxBuJXf6Vmq/NAGCLMUDADmSmEeg39ZtoZPUeH1BMSMxQsNDUiEO0ZXUHr+PbD1ApydAnxRyAZlIUycpVy4DCQ0frrO6QTlYO5cfHvE/O8fyscOpBsNveNVG8kLrR67UOeZ5vDC3v6vHUysctd0P3MlmChp3GglcE/FzAEsAvbIXWwWP8D9a9ewC1MugfejvQlNF+ZaoHUGHYn/dXlno0VwkvJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hg8jrWwqmPvOZIu8LB0JSYAfzGBS/AoZ7XCZf8h0a2I=;
 b=MSeE4FV6rrQBjvTRb24HLJICECYl/x7SSmwZxwL80WHx2TKVkFaKPCkklVW6t6MybsCVR71G0NVSwvZnZLsagB1eeaZIniu7Nuw+ha6SCiVT/5jtoSzKAs8XrVuYsqtYNUM+dc1fh/0BzIROeB4a9V15KQmzw3QoEUNV+iov/FpZRsosX2SJRY6pbM0MvpJ9KzewA2b1kXlyXRm0RJ0ZOmZfgcaq6R001WkhjOASwkuCGASQU8TGv/NgG77T1jjRSGjfdXb05zZcYk5zwQ9bQS008WatX5uRxGJ+Ztns9dMA2eKoAldT5YL0JsymGJmV0cB2nYLlyS6T0cmwZ95wYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hg8jrWwqmPvOZIu8LB0JSYAfzGBS/AoZ7XCZf8h0a2I=;
 b=Y8evfCzRup2cUF97UeyO12gVmP7niMPQQQOeJmRZ8SwIHsiniGIFY4ygu8/TbZmkmfeUzAZmpMceMjGsrxhMKVqNmNYm+AGrxa406ua3Use68JHSMSr/MFZQhMIpWdhx4t4LaRnfXaiqGDiXDH71FNjt3CFdnLEVm9NzYI7d9DQ=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3988.namprd10.prod.outlook.com (2603:10b6:a03:1b1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Fri, 9 Apr
 2021 20:53:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 20:53:07 +0000
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
Subject: [PATCH v5 0/8] make hugetlb put_page safe for all calling contexts
Date:   Fri,  9 Apr 2021 13:52:46 -0700
Message-Id: <20210409205254.242291-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:101:1f::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0050.namprd15.prod.outlook.com (2603:10b6:101:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Fri, 9 Apr 2021 20:53:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04932739-ac5d-4eef-5d26-08d8fb997a59
X-MS-TrafficTypeDiagnostic: BY5PR10MB3988:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB398829B86CF2241F2687E8FDE2739@BY5PR10MB3988.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iZxiiec5OdqxVslLHuDNAoipPvltBIiu1NvvDTi1t9x1mx54kb0ANu/NJHMdBXY87dQHrSpkOGTcr1ZPx7KKQbLSRQqUuemp7tNvfxFS5J1uLdOYkzpOYoX2ZyMyEXDm8NB0LZAerAc7OzeJdvK/lC7+7YJiY2wXamFxr3WYE2hl8LdP1lFWgMCWhBSoZf21J/hlqs063sLVlD5GlY5TH0Jq7vNVWpy0Oit7vK7+tU1atekLYo067ge+rFcpAhQv6AvHl3Z4x6zBtHb2969guLnJvHKbBMM6f13aJZstZZxAk2CK3iqOsd7d1NLWZJ42amlnMZcLdlZcSOf/hUx4//us/oFikXfbYZQYbejGnGlMW3quH7FPB/2TK4Czis9lPJGwbS0nuNAkhV1oTJBS6YpFLCMpgXpdX9H2DL+AP7kUo8tZG9HGHG8ai8Hm7ZovcTNRoNhCMRgmaOwEeEb/lLfi5N4G52XoioNDKv7E9E9sMYMikci2KRVB38yvayibirKCQA5nqcb6jrJfBs/VtVy8m+/CSk0sfb12Jv2FxpCrFO8qsv2I9ET1vdzn7bYjr72Tdn9cisx8ug8vZunpvSs0ou7lYT8J295kjNfSwiLhOyJ6OQGepFpGWufEjyyoJwUtqMneQwKHlazjbAcjC4X+5wHCm3FKPRQ7M/Fud5bPyKWiC0ZVxbMbzQKUyrWLUP/9HVz+/DjeTIFgOZVqvWWqZU2AwrzUrrOZSAoclOfiA70+Mwxb+JiZttwMlL7OCaOtd76InADLekRiDgr7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(366004)(39860400002)(7416002)(478600001)(8936002)(107886003)(966005)(83380400001)(36756003)(956004)(6486002)(52116002)(8676002)(2616005)(44832011)(4326008)(38100700001)(38350700001)(2906002)(86362001)(66946007)(26005)(66556008)(7696005)(16526019)(6666004)(186003)(316002)(1076003)(6916009)(54906003)(5660300002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YAKrkhkz5x5DwbumRBPvpkiplv3vn5Hsv/b0MHtjfZHJmhyf3jIjxfJ+wWf9?=
 =?us-ascii?Q?StnkESc6+p075cLf6VggAt2T3w8yo57y0/riuChzKP7AiPSq+7V00bI/DrnI?=
 =?us-ascii?Q?LADXH7rWFx7KK8PAxfy6lIgMwI3apq8502tJEog1PlFnQ3px5srcHQVkc9Kv?=
 =?us-ascii?Q?SNE1ZregLN3SmS+2jNR5+kXNSwZW9cjjHLNuEqXuQtDL/v2lNqcWnKQI0Fz0?=
 =?us-ascii?Q?tjYKhTj5NieAMVfrCbPyJgmPqJgjbiZf4HCdc3NL6Nrwab6FQM4oHCCk1FaX?=
 =?us-ascii?Q?cX1reQLzI5/rqdORkr2h24x0wQJeSPe0XS9iPqVdWmbRCDlljMtmy+e80PAY?=
 =?us-ascii?Q?gUiMTKVjOqkOIiVuuPaRCn1/owg1Rbrgch+nWy86kMwEHc6v+xHLc1WFiBue?=
 =?us-ascii?Q?5terRWHKdrmeowpO8ZDZGiQ81H0Q9o5ch2U5wDeerSBesdbx+FwvLcksxpdd?=
 =?us-ascii?Q?mLYkP9cJ451Tl7Ez/Znr+8ZfUErI40lpMKNWe+hf0PlAXUxqSEAp2U0HEqi7?=
 =?us-ascii?Q?yCa9itmuSffP+LjiVb5R59Oa9RIu9Vt7Dfv8gplf8PwFUdeBrThgJqzBBV0w?=
 =?us-ascii?Q?0EHqGL3+ZRfGfEzLjP2HufRogH5NH0NI6eYR9JlBrY0VC4eb21KQA7VcXbQq?=
 =?us-ascii?Q?uGSLj65qAyt+pQXI+xAr3EPfnWBPXOs6bh0ndWS2QJpyTXQ193Ml73/24Wn0?=
 =?us-ascii?Q?3aEKCFG8N3TUpVFmI1EeUtsS8NWZLcyR7VIIpyKVSRl0gEZyZzqoGlq5SLFo?=
 =?us-ascii?Q?5SOPtGDdz4ib3TfKAbmKCv+bnOM/MEwlOf2h/Ixhs/pqVboRqmNrww5E+Inc?=
 =?us-ascii?Q?BcVPRPeeJYYD6lJPzWduw11stJbxI5HHehnmZJ7jIAzKvji2MYnGyHdjvf+Z?=
 =?us-ascii?Q?QgnP71zRiqfXypN9NGqOT6a5U+flRxP3IEPUTYBoujRiYfMAy28TMQUHDJsY?=
 =?us-ascii?Q?Yy5UIXoIs11njXk7Yd1aV6WTRZ4jy8ftYtuz3Xc1gj6YxNNtgMO3wnAcphUa?=
 =?us-ascii?Q?px1z1oHh4M7aV7h7hB8FEFVpLuGQyscgHGdgc6cCEl7E6D5B8HcXdErA8+jI?=
 =?us-ascii?Q?m1CLcff1+1HK8y3qxSnyOt82P5D1dBycb62NQxMblOGX8JYXJ3G9oODqASNW?=
 =?us-ascii?Q?f82+9M/u6slxpkjoNTJyOgL+GjjQ8+kJ0S85hOYga40eaLdcHFQk7hIPbQB1?=
 =?us-ascii?Q?4WWnvB01OgR8slwjUFn9u0WrrVtZNs7IzEEa3nldGoeZ6FxsecQpztYBlc46?=
 =?us-ascii?Q?W1wEwtPZz5tyQ/4MJH0iiaDVKn5Xvqjhzqr0+F6FgtKijv0+ohLSvDBAXfQI?=
 =?us-ascii?Q?5yKpmH+0QYqyAvNLJZz9R3Ip?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04932739-ac5d-4eef-5d26-08d8fb997a59
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 20:53:07.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLZ2aJy+PPL/uCtOXVCDNkTRlsY3gQaY525IrplfJsyidAyiZZmRTILZw1SvspDVGmZQTl4qIzbw5MGFPcwP9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3988
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090152
X-Proofpoint-GUID: 59VwMsDGv1B4-g1JxUvd_m13PJdrMHXS
X-Proofpoint-ORIG-GUID: 59VwMsDGv1B4-g1JxUvd_m13PJdrMHXS
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMPORTANT NOTE FOR REVIEWERS:  Andrew has removed Oscar Salvador's series
"Make alloc_contig_range handle Hugetlb pages" so that this series can
go in first.  Most issues discussed in v4 of this series do not apply
until Oscar's series is added and will be addressed then.  This could be
more accurately described as v3.2.  Changes from v3 only include:
- Trivial context changes
- Oscar's suggestions to move some VM_BUG_ON_PAGE calls and remove
  unnecessary HPage flag clearing in remove_hugetlb_page.
- Add a missing spin_lock to spin_lock_irq conversion in
  set_max_huge_pages.
- Acked-by: and Reviewed-by: tags from v3 remain with those from v4 that
  also apply.

Original cover letter follows:
This effort is the result a recent bug report [1].  Syzbot found a
potential deadlock in the hugetlb put_page/free_huge_page_path.
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
Since the free_huge_page_path already has code to 'hand off' page
free requests to a workqueue, a suggestion was proposed to make
the in_irq() detection accurate by always enabling PREEMPT_COUNT [2].
The outcome of that discussion was that the hugetlb put_page path
(free_huge_page) path should be properly fixed and safe for all calling
contexts.

This series is based on v5.12-rc3-mmotm-2021-03-17-22-24.  At a high
level, the series provides:
- Patches 1 & 2 change CMA bitmap mutex to an irq safe spinlock
- Patch 3 adds a mutex for proc/sysfs interfaces changing hugetlb counts
- Patches 4, 5 & 6 are aimed at reducing lock hold times.  To be clear
  the goal is to eliminate single lock hold times of a long duration.
  Overall lock hold time is not addressed.
- Patch 7 makes hugetlb_lock and subpool lock IRQ safe.  It also reverts
  the code which defers calls to a workqueue if !in_task.
- Patch 8 adds some lockdep_assert_held() calls

[1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/
[2] http://lkml.kernel.org/r/20210311021321.127500-1-mike.kravetz@oracle.com

v4 -> v5
- Do not take the series "Make alloc_contig_range handle Hugetlb pages"
  into account.  It will be added after this series.
- In remove_hugetlb_page, move VM_BUG_ON_PAGE calls and remove
  unnecessary HPage flag clearing as suggested by Oscar.
- Add all collected Acked-by: and Reviewed-by:

v3 -> v4
- Add changes needed for the series "Make alloc_contig_range handle
  Hugetlb pages"

v2 -> v3
- Update commit message in patch 1 as suggested by Michal
- Do not use spin_lock_irqsave/spin_unlock_irqrestore when we know we
  are in task context as suggested by Michal
- Remove unnecessary INIT_LIST_HEAD() as suggested by Muchun

v1 -> v2
- Drop Roman's cma_release_nowait() patches and just change CMA mutex
  to an IRQ safe spinlock.
- Cleanups to variable names, commets and commit messages as suggested
  by Michal, Oscar, Miaohe and Muchun.
- Dropped unnecessary INIT_LIST_HEAD as suggested by Michal and list_del
  as suggested by Muchun.
- Created update_and_free_pages_bulk helper as suggested by Michal.
- Rebased on v5.12-rc4-mmotm-2021-03-28-16-37
- Added Acked-by: and Reviewed-by: from v1

RFC -> v1
- Add Roman's cma_release_nowait() patches.  This eliminated the need
  to do a workqueue handoff in hugetlb code.
- Use Michal's suggestion to batch pages for freeing.  This eliminated
  the need to recalculate loop control variables when dropping the lock.
- Added lockdep_assert_held() calls
- Rebased to v5.12-rc3-mmotm-2021-03-17-22-24

Mike Kravetz (8):
  mm/cma: change cma mutex to irq safe spinlock
  hugetlb: no need to drop hugetlb_lock to call cma_release
  hugetlb: add per-hstate mutex to synchronize user adjustments
  hugetlb: create remove_hugetlb_page() to separate functionality
  hugetlb: call update_and_free_page without hugetlb_lock
  hugetlb: change free_pool_huge_page to remove_pool_huge_page
  hugetlb: make free_huge_page irq safe
  hugetlb: add lockdep_assert_held() calls for hugetlb_lock

 include/linux/hugetlb.h |   1 +
 mm/cma.c                |  18 +--
 mm/cma.h                |   2 +-
 mm/cma_debug.c          |   8 +-
 mm/hugetlb.c            | 337 +++++++++++++++++++++-------------------
 mm/hugetlb_cgroup.c     |   8 +-
 6 files changed, 194 insertions(+), 180 deletions(-)

-- 
2.30.2

