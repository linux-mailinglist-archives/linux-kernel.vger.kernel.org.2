Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4467C34F795
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhCaDnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:43:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49836 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbhCaDmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:42:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3eT0J037958;
        Wed, 31 Mar 2021 03:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=FT+T6/k+cKO4O9DttlGsJD1RrQ06+beDT/m3Mq4DxaY=;
 b=Ej4JCcZMuvv2eEVVcQuMoiGZwfGALJrVZHqYPZKzOnc/hN7iqHqvJ5Dmop+1NBHO5Rlz
 H4LSCFgP7YYxyv8HTDV3La5TM7i4G/YDmtjCXczEn4i9dPv04praxfH/gEibNjGHLh6d
 gKvhRPwUhzAnYuyIvozviDpcxGs3AoRvFPwckgymEev3p8tTclKkvb3bQL67IvQWmOaD
 XKMxOlGDb3rgiC7sgT6xkLA7Q897qmxLv99ZwwrhmJ672aWgvWKkQXrVMcLybzj8lJsB
 8ZHzCur4tYWuTD7Xd7cXuAH4Fk6xS83hbCbimi2dnhzIPODOuN89GY2tYLK5adyzT1Ul 5g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37mab3gskx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3ddMa121928;
        Wed, 31 Mar 2021 03:42:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 37mabnuygw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIJ+2gFkYPiiZi4vlzgNPBYNYQ3r4Mo3/OvUiXv3Tie+5lgBDcmG2lQ97C1g3bmOtQ1c+ZWiMe8jYxiPU6ovu/ebj+uK/ZdXIRzawC1uejLFGT+aDX0kqr03+3OpOQpSNJt6cfIhsWQlWkbBigygC5i5nDfT/ZbsionzZnq6et6emmGRJdqVgoR458vtbiOP+UEZTBAnjABN7r3+ADrnYo2RqbtFJ+EnfU10MvAKmI5e1N6uAyV/HgQ5QuMSig9IEgMa9xwWexGacZH6+a3bTF2N0n7R/wgagxltgljQsNxqonnG3JSCGVGOUF8wF6Cwk+WqfE65aeYH8IY+7GogCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT+T6/k+cKO4O9DttlGsJD1RrQ06+beDT/m3Mq4DxaY=;
 b=jcyM2lr7JWAbn+skJv67ub8OLCQ9ZskW27Osu6wOl3ibICDxfGC7rs7SDfXoHkVwuv9FeL7fnTwzib4G8wJFyRsHC36sGFR/Yeow6D68X1++Im3og5rvdnLSpUjdPNo4YZu8IycYhmJgaKakpb92JPJz3ZKOlF47hTlvUUOxogOfDs+bVpsjbHg4J/D7xG3IjlDFVQS19DRG8659Uq5yeD1jDA+q7XRujX4/+8p/qlPMqLkz0/C343SikbotMNkZE9vLKO99EarsQYPFBWuWA1Gqb8nltX+IA6iS+QbsRKS5i6XM8KYduLGUfPU4Fnp/zBxbsjjXnFazwiQDQqYHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT+T6/k+cKO4O9DttlGsJD1RrQ06+beDT/m3Mq4DxaY=;
 b=yu0HMPW8YZMLXPPNY17RVh6LMAeytiYqhZfBUsrM2I3i7+J3N1p9HE46hca1sQSkwUetVOfbPfXxktjcoVAjEMN5fj2L9ycVfVYY7kWboxoByo3q1yUQtC1jFcoGHhtkRtxWKRM1jde7cS5yKqyo3IbBYrXgpO9eoGqmwR1UFzc=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 31 Mar
 2021 03:41:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 03:41:59 +0000
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
Subject: [PATCH v3 0/8] make hugetlb put_page safe for all calling contexts
Date:   Tue, 30 Mar 2021 20:41:40 -0700
Message-Id: <20210331034148.112624-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:104:5::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO2PR04CA0202.namprd04.prod.outlook.com (2603:10b6:104:5::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Wed, 31 Mar 2021 03:41:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fabecfd8-205d-4c63-6da8-08d8f3f6f024
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB446254F726B766FF7C535FB7E27C9@SJ0PR10MB4462.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcc4ewF/IXZP25wWVR5PFsSz0WSTIauMdToVKdexnnguQmvNerpeyInnWn18E+bU/n2JBsnqhVUVE00H69Bd3EMXnn1Hw7PktZk6tzX+fmhXLNRl5BtrYLBueD3rPpYOIfrhIIGez9/gPlqN5lWmtLc/Il90SM0N4icgGYYbS66J7WvhrO872P+AzVA9SOGGEcXDVreZQsR+c+9txhqrEyEKuY0EiqoKuVluKZjSzifb/F1ntWit+YpaGDxlUY/qy42HZukTbNVuwoyWW0Xsb8nZSan970B9qwSOKjqvk6cs0/qlyV+M9SJ2Cco3r0mwIotT3KsuKUkmE5uLz1SEicrMh9quZWyIHWzyJyycEQ332tuiiG8zd8wbHEJH037HvN+iegvX7OS8XsSzXpgwDuy2cKnzWEJnaSYup70fjLu1ZQzGJrYrybPBgd0kr3v6A9JaHgNVoZ7GsAQOvxY/pfRQdCghDsWadeu89SmGiXDA10w3u6geuZTk/3+FpZQLLSW22tQXoMDBlXyHpK9ELF/pqY6RBuCBYm/3IAAgIi5BCDntmQqYLxmpGbcT2+gAqerHOmA//3h+np+3Dc+wU+EgF7Uxb7B77g0Cgr0cxPETu4V1z2zraZBWKer2PYNSA3H3jqqQqDmjfK4yPTHZHm7PGccr8VbBLQFlENyRPsQzNs0nN1LUvM+oUoPScdAjH/I8CFFV0D/ySPlBuVfpEQzwza/FLReYVdfZZbQdYvM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(346002)(136003)(366004)(86362001)(36756003)(83380400001)(316002)(52116002)(7696005)(66946007)(54906003)(66476007)(66556008)(44832011)(7416002)(4326008)(966005)(8676002)(1076003)(8936002)(6666004)(956004)(2616005)(16526019)(6486002)(26005)(107886003)(2906002)(5660300002)(478600001)(38100700001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vA2mSpMty4O3QWWE8UrE1oOvmKe2sDBsahriYh9y5KOLan/eOTEd/ZDE66CQ?=
 =?us-ascii?Q?lHYvmsrnRTiMVaaBMYg4FX7lGXmWxFH6RIXiAB7m3tnJHy6Auon0nklOVS2K?=
 =?us-ascii?Q?8Lh3BQy+SH2jDHs7D8aAjxPLMWBIamOSBsewztX/H+iLtU+vtLBI8R3bz+ND?=
 =?us-ascii?Q?xWKsSMKTM2RIT1PCNqsfcChT8Bq7LvOJx5slOIpXUpSsjoyY5RZtyMADDpa8?=
 =?us-ascii?Q?h5j3MgcCKBQrs7QepZMBthTHnkQfNlyLFoXXggAseH/aD/PFihz1hwDD8IwK?=
 =?us-ascii?Q?UqHTnBuNiIbAqrnxInFcqt9oM8M/A3ZMJxoW1odU/lqPjEj2Wcp9esxre9eL?=
 =?us-ascii?Q?3HHdWIPe3jkVLEG4C4x2GIZZNOFhXxgpp2xEjsulUwFLMQ7UbpG3Ovt/bHAt?=
 =?us-ascii?Q?0DCqkl+H9xoHxYEKSVcsTDT5XtauC/Rx4EMHZDCXCNcEk5ffzMCn90ToqPZ8?=
 =?us-ascii?Q?1rMPM15lCXySKxAewW6P8Da36V7lGqW4FsgM1bsrFb1ThL/2r803f1LlSn54?=
 =?us-ascii?Q?qL9h3G/OURWGyABlY0Bhoegm/6esJL2kkrZsg9m1dIR86YO7YxUL1Z2EudjW?=
 =?us-ascii?Q?e8X25lEXhAryD3rqipnBaaGx7IQO9Jkgn4zq7JnB/ocRQ9Mom9PWdlkDsdbh?=
 =?us-ascii?Q?MGqr7r7VogP4DQB4jmK+h/4lJ54N1O1PrWdu7Vx37uIax187jPKpf8nm7ipy?=
 =?us-ascii?Q?TwOlWaqi+2+iawiyAKp166D41ly4JbgQbgkZVcOxlDYRQ1XmADWl8zDVgiOz?=
 =?us-ascii?Q?PuJ4yUmI6Lj/lGhZRFUbnarnfsUMZ/0NEVBJpyrJ00m7EFM4cBZ7lQoPrclb?=
 =?us-ascii?Q?n9tPlVBGJjEnHSe5MA2GST1jWjE/FtXSVkoiRp81sxkx9+k5mWA16LktMxaF?=
 =?us-ascii?Q?m3HTSeAtV7EROHZ9lsI7XhCYSHIQjR/dCdeu6zGdAzSdMrcIMIAjHJIzZEl0?=
 =?us-ascii?Q?dLgjw2X78XdlQ1jyXtUs+2hpOWYpykmiIW1IYMcqEHVwXJ8k3UN4ei9jHawg?=
 =?us-ascii?Q?iq4VakcrIwo3RIpL9PL2zTlXyoaagPXrdGs/ccBUSxjZWLUZeMmwaHKmD4Vl?=
 =?us-ascii?Q?ZYG6OFYB5/F4em2qzb5XdIgZvaVqUCMMK6hEgdve6REC8WArMe7EDaBSbnnx?=
 =?us-ascii?Q?NimttyZjrhrOaf2p9S5czOhoxz1NIHBi0Lzs5PBWUfoP1TZ9Trb4SmNINc0Z?=
 =?us-ascii?Q?z4HwPfK+nUwlz2wcCIELlBYmAGk9Qzm9HiIC9E+JYCuzSOR/yLGDIEo5M1Q7?=
 =?us-ascii?Q?fJ5ltuLSIczYsrIBUfdF0ykHaqzZXaAhS+4pOU5TBiaur74VJP6Z/4EBHDyi?=
 =?us-ascii?Q?06a+HT5Ji0Q6CQsTWdwwQP1F?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fabecfd8-205d-4c63-6da8-08d8f3f6f024
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 03:41:59.1190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9xS0Q1ibEyndVuE4JplUFd0XCGB8Lz19zhLZDcWD51KHRJad8FIVmR/pNAo0Q6KfqVQtQyiXYtED4jMoVMd3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310025
X-Proofpoint-ORIG-GUID: sDUURV1CqZASB2Uf9pXA3RwiJdpzv1-8
X-Proofpoint-GUID: sDUURV1CqZASB2Uf9pXA3RwiJdpzv1-8
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 6 files changed, 195 insertions(+), 179 deletions(-)

-- 
2.30.2

