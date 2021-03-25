Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239AD3485E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 01:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbhCYA3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 20:29:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52480 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239241AbhCYA3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:29:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0RZiP145404;
        Thu, 25 Mar 2021 00:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=Cro/Wf0SYv8QvJk0OV0GcM/CxRDsAKj9w/NfO8ZjB78=;
 b=RWHp9dNtBkrzygU/aHZLUv1tMvYs7ZZMZOiRxzsqTh4KV0A9t1IO4mw2HCBDov0T6BZU
 NuTUr2aQBTecjXc8DRIv1R7OXWTRxU+B8JTee8Vr9dVyaxIjZABMqaxZJ67+HMqGal/7
 vnWA41bjCfvf4V11Uup6KY3DPjlVuhTeMHZwi+R0BGWB1QF4cz7Obq+e+T3hCahYINYD
 N8d4U6Gxo6Aj7478xiNNM+p7K2tq0BFr/0yDknpPtAX+yFm3Af77EmM1TvEw611MbmwG
 P3ydQ93k4vUXRKtpq7lTF4Miqurmw9DKtTGL5Hqp4KsCEumhQgRCpOrsQ0o/bmCU1iAd /g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37d9pn4k6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:28:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0QEKL076481;
        Thu, 25 Mar 2021 00:28:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by userp3020.oracle.com with ESMTP id 37dttu15ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:28:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7jL4RrlhnfbQbaqS0H2Om4KZR6XyzNW6E94gL8O2wGNDDhZrXyrZ8VyvsBa7NUSy4GFX0oZZ/g58OYztBnsY6ikVbRoSmSpBVCMgfOmrI4/bycLZikeNnMQja4UpPPz2ubLRz9pNv7fYoCP+8Z9hldT3zK3BYNm1VhQJ6ElWXlLbEESp/kWQ+UUW0oDNPDWCriGEgDhW2vYxH3Y+eiMYsmQK1pq/OUIaASGnE95n5OE80XUa42AJ4WU09sYknx08lVRANc7Gn9c4Df1uZIP5fJQT3jxXAdL7zOEYbLvojHgGucX6ZlRbJDFS3aL4TTvtmctEKq0TGNSbM4jKn1mYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cro/Wf0SYv8QvJk0OV0GcM/CxRDsAKj9w/NfO8ZjB78=;
 b=QUvHfyj0H8NklaG/U4JSBQtuyrasRWhpWadv/5nlLo2uBcTyIXZ02wZBZp5VdgL4X3OxKLDph7upkVIS7DIuBjAw4+qvNPL7WGmJdpcfyyyhnhqNRAYNrfCgZdztmrfHwAcaIK7pa1HJ7KYdJ4+1C0dCumj/518SOUJtmPeeoY2g/t4d1t1r1qQPN4c6Oj2Kvxz1QzGmZnJCRdGKQ/Pe1M2/CkYKKjUnJ/H+kdUGyhs2s+RNy/D0RWtpKxxAbFJANDaY4r93DRknVA61N5qdCEWmo5NVi8GTHpU1XDohfPVCZx4DHUyzPi+bVx6ub+sM5bS9mHO7GG9ZVAmnHam2/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cro/Wf0SYv8QvJk0OV0GcM/CxRDsAKj9w/NfO8ZjB78=;
 b=bq7X8eXIuZ8Z1X1+ar97iuxNKDEDhUyHkjEUbMQj0x4LJ5TrH25xic7T+BJ2BpdbShUKY77hlgsgjFZfPrnlwYx8W40xj/6OVhhWcQjf3XJLrSKQrmYYTFkJJaiNT/ovx6+dDoI7Xd1TqGeburoKYNl53DmmJhtkZ91Yq0L+UWA=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 00:28:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 00:28:49 +0000
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
Subject: [PATCH 0/8] make hugetlb put_page safe for all calling contexts
Date:   Wed, 24 Mar 2021 17:28:27 -0700
Message-Id: <20210325002835.216118-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR15CA0042.namprd15.prod.outlook.com
 (2603:10b6:300:ad::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR15CA0042.namprd15.prod.outlook.com (2603:10b6:300:ad::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Thu, 25 Mar 2021 00:28:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06a5e629-3656-452c-7129-08d8ef24f5c0
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44626365C418B266B0EE6C7CE2629@SJ0PR10MB4462.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jlC6QidcpXe2IpDsVwb9fdcTgcM5+ap/9Go/UFhee+ehwY6FdmHTbgLDysY8gnnrp41K5RZc+i0QCHDSVpL6q25edr0b/O9dTvP8xjuSKs4o+9zjdduWcWLYWWnztzOlnsHuBrayzoLLH4la09RBO8Zpe9MqNSER+NJMutWPkmq8jjj2cRCbKNzDnCK9axnmIYzFxZkEStIYurzJZV4XJWOMgl9E6F+KS1g1C9uUBafmMXKeinC8yAfyYzokw8dzsIypS64Gbkl1p94hBzgH2RE8J+zQ6UzMZxpLULvvc9F9gqKJHQLFV0c9JwZWLJmHo/0n3aNdm9ejQ+RpBRE32BJzF7b+7YRKRwf/EdXMkD2855D6cd+/+KJMkf0L1BuqQl3ym/4qC6U411K5X4euliagUghSKIMngMCVFNZn+onCwqVYzlM8OVy2yIKxsudt275KoIvJIgHLM1YxFQ0pq3OcBKOxbJ2yaaGmHUkCKuY54EOYnst5T/KyDMJVHNJ3wwFRSkKBQ4Kftqg3HVBcQ+NxQ8n5hUBODb8GVGkOzyCwvS45Ote5/JDlSx5f3nsrAMQMzGGSCWFgyTNJexixCbyTiX5BhcNPsGPTz1zvFH8LVOzmYkPaDuKudbTKALsxi5efvJXgBGFmo6cGBWeGW0g5Rf2MHxkWpoMGjmY1/RD3kOO7gRdhxqQexGpuGCOB7isM5iu6VLmsGmCNC1ru1BZhZ/1FH5WgrKPkKeL79QmHtMmN/9bMKwMPkfB1YKR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(396003)(376002)(39860400002)(8676002)(66476007)(66556008)(86362001)(6666004)(4326008)(66946007)(956004)(8936002)(107886003)(36756003)(44832011)(5660300002)(1076003)(2616005)(316002)(54906003)(38100700001)(7696005)(26005)(478600001)(186003)(83380400001)(2906002)(6486002)(52116002)(7416002)(966005)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PGy2CHrymRRN55wXfMQT1KtR2FQWFBLYYbF3vx0B+IvzZA4xYjXNL6MB608u?=
 =?us-ascii?Q?zeJnXipvX87LWTW5utfJL1yk/hPufRL49xejdc+UwXt01KASUwYOiBpWQtVH?=
 =?us-ascii?Q?dUJ2THDUvDS+jWjB8muRbn5cA1dn/TvXakL0KLsxVnSa+lK8MqC7x/uSbo1Y?=
 =?us-ascii?Q?s697dslBGFzjpslDsPT8DLRmTYtOqc+JAsHMEhXHomXJKUnZRzssYKd6bKZ6?=
 =?us-ascii?Q?04Su9it4Rs5lCy+7Z6t9hzwgdwzm3SH0Sqj7kNEe9Fa431cspciGxms7uz+r?=
 =?us-ascii?Q?kXPa5RouYObkcALLmsB+eoIcJFeqAuVIWvvq291My03q7OeN6P0YbjQYqF8g?=
 =?us-ascii?Q?1eoUK5jboF165HxGtWCPrwOi55R57RRbZilSxejmJaRcWe3jOfcxONR7nxUb?=
 =?us-ascii?Q?s6nXS6jImnZWdS60SSrVBj1ofa94oh2eySRChLv4HzfdoM9yaK+q1oD0plN3?=
 =?us-ascii?Q?eoWu4Gx2z0l828A5KySy8eFpC9z1DSJrG+MVXPWAyGfP3rOegYgz49/HdoWY?=
 =?us-ascii?Q?c51+xLqcs7CwjRB8OCt/myvq0eDOL/8etilkxrwxx1bNyGQyRZnDC3M1sEm9?=
 =?us-ascii?Q?Tz+HUlgZWylzGaBMI1lYClPqkPaFzrbtcIITAPnvmuYcIJK6YCgxy8LWnIbj?=
 =?us-ascii?Q?9Sy1mvdi1cK/WoI3TmWMEtPh6B/Wh9ETJ1KjDr1NSx/y1SWMoT/F4E7cyHwC?=
 =?us-ascii?Q?saydHHw0BJ2zSLd3/6fPP+0hTzySVAzRzxjeyenziHL17o5pvQR1LCrt+sPq?=
 =?us-ascii?Q?r4UwKMYm3tzWAt29Bf7bBKVa4VVH6Sqocr3RIAI4QDGMBTgVpSagjf+JL1G+?=
 =?us-ascii?Q?X5JQELBwa1VVhzTEymXyOnEUdfcTb3tsF8gVTpd9+nBifGyRo9x1reJnpcII?=
 =?us-ascii?Q?ij99clb2fG6CQrBA581q68kCyzwpTaam6dHUQG+wBLZtikImRieljLuxdhVy?=
 =?us-ascii?Q?vAMRCdvSFMlSnK5pRPaG6FXkTM6htDGLZWt4PgREBE6t3NgIc5p8XrRKMuOP?=
 =?us-ascii?Q?JdDbdIweKBVGlgFKOn0WxyDIqDS9Xj2fUmDOW+ngt7MqEMCfLYifiOr5yFgr?=
 =?us-ascii?Q?jQImJN73/9KTY7jPCPwfwS2l7gXLXorLtJxL5A0onbTVRpl94e5U74Y2kqu7?=
 =?us-ascii?Q?jo6DMXPWew0qK/ZlPIqFeiVgp+7gvN9dF61QKNtkyXcZqcP59dHY/sRFbeyZ?=
 =?us-ascii?Q?sVWPlVff+utYsrDkXz6hn2I06QKPUMF/V4JGDwq80vNDqQbMAizSfF7HcNS0?=
 =?us-ascii?Q?+K8NSR9WAC1OL3fhqXtsjVQuWuGW4I8MtWLaRV7ZBFoATyiNtKFTqsJ3gSaY?=
 =?us-ascii?Q?yPR7XgNX2D38bh26kb5Q+Qto?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a5e629-3656-452c-7129-08d8ef24f5c0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 00:28:49.5080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xq2LtyihO4nbDnPqjBx8AstGApOgBqS7/vbmZmAoA0IAygXpbiJqIXTqha3w+itAwmEfoDHnjgctOfgUzwyJZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This effort is the result a recent bug report [1].  In subsequent
discussions [2], it was deemed necessary to properly fix the hugetlb
put_page path (free_huge_page).  This RFC provides a possible way to
address the issue.  Comments are welcome/encouraged as several attempts
at this have been made in the past.

This series is based on v5.12-rc3-mmotm-2021-03-17-22-24.  At a high
level, the series provides:
- Patches 1 & 2 from Roman Gushchin provide cma_release_nowait()
- Patches 4, 5 & 6 are aimed at reducing lock hold times.  To be clear
  the goal is to eliminate single lock hold times of a long duration.
  Overall lock hold time is not addressed.
- Patch 7 makes hugetlb_lock and subpool lock IRQ safe.  It also reverts
  the code which defers calls to a workqueue if !in_task.
- Patch 8 adds some lockdep_assert_held() calls

[1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/
[2] http://lkml.kernel.org/r/20210311021321.127500-1-mike.kravetz@oracle.com

RFC -> v1
- Add Roman's cma_release_nowait() patches.  This eliminated the need
  to do a workqueue handoff in hugetlb code.
- Use Michal's suggestion to batch pages for freeing.  This eliminated
  the need to recalculate loop control variables when dropping the lock.
- Added lockdep_assert_held() calls
- Rebased to v5.12-rc3-mmotm-2021-03-17-22-24

Mike Kravetz (6):
  hugetlb: add per-hstate mutex to synchronize user adjustments
  hugetlb: create remove_hugetlb_page() to separate functionality
  hugetlb: call update_and_free_page without hugetlb_lock
  hugetlb: change free_pool_huge_page to remove_pool_huge_page
  hugetlb: make free_huge_page irq safe
  hugetlb: add lockdep_assert_held() calls for hugetlb_lock

Roman Gushchin (2):
  mm: cma: introduce cma_release_nowait()
  mm: hugetlb: don't drop hugetlb_lock around cma_release() call

 include/linux/cma.h     |   2 +
 include/linux/hugetlb.h |   1 +
 mm/cma.c                |  93 +++++++++++
 mm/cma.h                |   5 +
 mm/hugetlb.c            | 354 +++++++++++++++++++++-------------------
 mm/hugetlb_cgroup.c     |   8 +-
 6 files changed, 294 insertions(+), 169 deletions(-)

-- 
2.30.2

