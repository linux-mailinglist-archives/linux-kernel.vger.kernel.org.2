Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1546C34DC66
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhC2XZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:25:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43408 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhC2XZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:25:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNJUtW085997;
        Mon, 29 Mar 2021 23:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=sB3A7aiUtMRe5ib6VHFdFODXzOZyEuLNBcHaJG9eo54=;
 b=hVvxfCyaKFiFAqmT3AWu1ijytRAuLzmoat4OIPURK3TGXjoWgx9ZEVY8e9qsnw2rsBP6
 9KI5bQAGUBqWW6JHX4+95AXtvjqx8aSZGe8nROE5k9BOkRyeUZwAacBRgZMQoqGTY2iq
 Ct65x44SZmZGFTnSyNzmF5JGlvZujE4d64Q2CDEzgKExhwnPGsHBYh7ADBVUOoXIM9cd
 L4JblvlYLFVYymJQITYJDL6R2Hi//50ZkPhVCmqSX6uxfxrEgKohe6wmPOYvjU0IslY1
 dnZ1k5gNx3lWwiFFFPUv1JhsY7tEvWSAq4/t2IP3AaspOO1J7BOE59kqqMlQfEerySNQ tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37hv4r57tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNGW9J132701;
        Mon, 29 Mar 2021 23:24:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by userp3020.oracle.com with ESMTP id 37jefrct5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMv9pdDnlAX6igwAiWwKahToidOONpxi3rI1r+HqzBxDBfxH8oahwwKqxYeL7Nagzaii0jf4uto/aWdxTEkzsxOvTdJ96Wvl7MuZ7urlgh763YZTDAUS4HrvNgcsWREyBVEwdedNoKqW3XRbq2u6fmqHXBftLntiK/3BN8hN1/jHebJqIoXSqWLjY/6ZBhhVUDW7Mo5l9Gueb5aK5S+dC1HZDrtymynYN12IPPh8FRcenPovh5EgbdSIdLBlJ/OgsaRN3hqx7pPS9XtFXN6Nkd7ln4UhXepOhu0d/WQEbiqPhsuxStYp2gDWpraCFnKTvx2WY+FrPy8w1MJn88+FSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB3A7aiUtMRe5ib6VHFdFODXzOZyEuLNBcHaJG9eo54=;
 b=PGGV1OD/qfZDA7fC9ZeXg9sO9Xq6a7SissEKwJXAqtBQNIM8qb5Z5JumKwzyJCnd9RLjCZyRFjk7F7fVcH/HIIT0sUlAsQMdJ9AWEHRaWxEaG18WF++Ici6/RqFLHO2/Emseh+7zPtfWn70De8M4E8mwOiLbNrb4AlqSv/vSHv/mK7NQAFolGnydvaTk1F0R4T7I//nXK6S61Wo+QyrIMrw0v+V7/qGH004xO7U5MEeAaDpIPMcjAMsHT6yLJ6ELA0IvJG5dCaYlBe15kY695eHlrUWXuFGtrJUyTZAeMvuJ+x/ImY0h0UW0Ji7Lh9PkuVVwpuY9y+DeT3JADrYuag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB3A7aiUtMRe5ib6VHFdFODXzOZyEuLNBcHaJG9eo54=;
 b=vZ11gYsMOOym4wRFejV8OtU+16r6DB7+XFDP8+hA561/PUTK7W2LWDmuJdODD1ixdAvHcUlWz7Z293hgBqvALuWez7nZbCjZ3WkeensDyFm9AP7zLV7QJf+Dezgihz9vDUh/+2xtLurZrXMMxUTLK7BXH8PHokCDnrX+Ll/W8RU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Mon, 29 Mar
 2021 23:24:13 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 23:24:13 +0000
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
Subject: [PATCH v2 0/8] make hugetlb put_page safe for all calling contexts
Date:   Mon, 29 Mar 2021 16:23:54 -0700
Message-Id: <20210329232402.575396-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR10CA0065.namprd10.prod.outlook.com
 (2603:10b6:300:2c::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR10CA0065.namprd10.prod.outlook.com (2603:10b6:300:2c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 23:24:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e290e0ab-e3f4-4dfd-eae5-08d8f309c339
X-MS-TrafficTypeDiagnostic: BY5PR10MB4148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB4148914CBD6D729C5249C44EE27E9@BY5PR10MB4148.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGq3bh+bK675EJRQFISyrg/MFFjMXaFaB1oKsFWfSjeLFMhbnwMmHGH82lItDsuE8rGW/EdUqq/fBtdgXQiwURqd1PjSdFPhC53tYZJJ6w7GY4Tf0sZ9LCkNyHDAZ0th5xRRGfOOjPzDKQ0pZJp5sqYWIPob+cWHpTg0shgVDZ0bBYM0iK62ANlvs6V3Nvg9PqA0W1h/RUardGqRfMeuUyEyyO7qcZITYzFJkKVrfJqJ9dEvSs1joyo++vv1m2I2huBZyNsY1MX846B/CylrrssDoxu/pxHNTyprRaVuE/cKmW+7xAcGEZCXAhzN02d+lSyLSOM5fdcrlZE8VVuYhFtcEP8HIQBcM+cyw1pCnTzNsV/1ejNM/M0HE8kZ0CnOBEdhlcDVEGORk6DePnVmCcPT3wfVscAXmay1QhHEJ72z8yiFRxOSV1BepIEq74uaxkP6PLIXM0X3xmfMbljGxSpe58p1KvSNYIl2rZ8GIjRNDXgYeh+OvZ842OjCVlhD3pC1OXWZvxncAVnx2Hl6wi1g/oH/kRxEg2cvTHVTBotYygROZ9IeLfMpr52Mw3oV7ooQ2B6lsldYsMksrwWTCadT4/p5m61Z9M6PZj0HTOHUiW3AdxVUaeAp0Cxt5f+5LeBmA/29eAG6Xx+og2zWKaI/NpTG7QqHGeRc6V4MgRDg/APYwJTs+VcBs3XDDdgB3mVTxmxYf9YBdqNCnZYpVdCBpyD7L74yEwVyeafBAqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39860400002)(16526019)(44832011)(52116002)(26005)(2616005)(36756003)(186003)(7696005)(7416002)(956004)(478600001)(4326008)(6486002)(54906003)(6666004)(86362001)(5660300002)(66946007)(66556008)(1076003)(66476007)(83380400001)(38100700001)(8676002)(316002)(8936002)(966005)(2906002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aRVStHrfquRrypKS5BTGBH+MpVL1mCkz8jkwnaOZltMkDRfpmvaQpNYKVTqZ?=
 =?us-ascii?Q?TeXaVZcSTOhuA+xHm02bZq3Jx136iS5zfCdQKAoutsz3a0RgNqsk9QE2k98h?=
 =?us-ascii?Q?fEzyZ71/JPMF/nE4E2YawMPzNsepf8GtwWAZOwhKmKA5J1B9ysshrA6mskGj?=
 =?us-ascii?Q?x84D1D4wG4Ytn+mt7U+TjVgSxWtYDP32zbaxJcyz/JAn2qei5QVgBAqOm+A9?=
 =?us-ascii?Q?+qVPTe7p2Bye/R1KslOopvSOGeGdmZzhCcx4nkYeyTD2EYsUDQ0iRCl2hZQg?=
 =?us-ascii?Q?EsJ++aVZzy/4qMCYkOwTwRdigXeDVhJKxWeC717xfoliI3c06hwPom2PAFZU?=
 =?us-ascii?Q?GXtruTzprQnsbbD19R2EdiQaHezcRzoQl/YgeM+b05gOqdKQrknOjluI4npx?=
 =?us-ascii?Q?1W2cS7CQTn3R9u+oypKV8gt/OMsfRNDAGnmzyTRsG0+UHzMt150MFP590t2o?=
 =?us-ascii?Q?SqGBE6O7zZ+3TFKZw22StgCXVCZ2/8NXhIMs2yquSsQXiI+oUsoClSLW0z/O?=
 =?us-ascii?Q?1+yNwfQVGag6whXOm3qnoJH0qRjg550od6kWFXvGh2+ciguyFoOsetBynU5m?=
 =?us-ascii?Q?fg4Iz/fyXTeE9Qvawh5RDH2UtEriS/+pjPE1XOoL2JO89T3IaDLJNXVplVTy?=
 =?us-ascii?Q?b1JeYgeL2I2nVCl54pz/kCexOh40KTHx4CUtuNav8GKEkc6VzUOV7K47t5wO?=
 =?us-ascii?Q?CBPid68C+GaWCEmNRGDJZsOGroLhopIMcOodaZ+byuJhU4GBXffnNzc+0YS0?=
 =?us-ascii?Q?xdslzI0Q5D8MKA5Wp3KKD5wl633daz9waH/wU+/Z1jMg1U54wYhnvIEDuC5F?=
 =?us-ascii?Q?AfNfNN5+Eg1ycF7qZSpVQl/jznFTSkV1tV5IWcxZMkyBHSzD2DiNJeFsJkMt?=
 =?us-ascii?Q?l+vJYRO0AUiaCD0V/5jSOj5byZaiOKZistPS30fgfGzpwDF+YAgCA04RpsCk?=
 =?us-ascii?Q?xq8s5oE/LxpvJzL+elOFrk/I4A1Mv71w+46B1OWQZlWZaiMr6Vzwko4ezhNU?=
 =?us-ascii?Q?BxC04PKgNELWS5v8KU1Ul1lDCZoiRnYLlTtRwjNaj60vzbh/S4PbuBAj+zCk?=
 =?us-ascii?Q?bswdu1t+vY3G4bU09zUyPdiy1G8XNz90wpQRzL8mU5GAl71xN8vKgzBSF0pl?=
 =?us-ascii?Q?s1Q1bJQoZHCa5Ml7nxrYVqYIra7u/YrPugHCAv7FdY0Il588MhAi1DK4hs+H?=
 =?us-ascii?Q?69UndxWXL9FmOb71KRRF++O2UyJrrVAB/mG3juyf1l26gDILHE7wqduYN3Rs?=
 =?us-ascii?Q?YPae6m4GvSDjjWBWuNotZzhAMdqjdcFvG58wOUMhFxO3rhSh3B2JykvyvZux?=
 =?us-ascii?Q?B0wapK2SUfneNdIiyR9kLrv2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e290e0ab-e3f4-4dfd-eae5-08d8f309c339
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 23:24:13.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7lZH6+9GoKlRp+GYFtzQfJKcH+v0ug9h0hBP1sjXE9fawZUn968H7lz6u36+RkF6wTrAabs4s4KqCKg/achDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103290173
X-Proofpoint-ORIG-GUID: glj5-8FQHHIO4umLjiEhdbMQXx2vJypn
X-Proofpoint-GUID: glj5-8FQHHIO4umLjiEhdbMQXx2vJypn
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290173
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
 mm/cma.c                |  20 +--
 mm/cma.h                |   2 +-
 mm/cma_debug.c          |  10 +-
 mm/hugetlb.c            | 340 +++++++++++++++++++++-------------------
 mm/hugetlb_cgroup.c     |   8 +-
 6 files changed, 202 insertions(+), 179 deletions(-)

-- 
2.30.2

