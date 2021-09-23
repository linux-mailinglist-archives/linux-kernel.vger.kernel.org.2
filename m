Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A9B4164AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242342AbhIWRzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:55:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51236 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241666AbhIWRzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:55:49 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NHmHPP012788;
        Thu, 23 Sep 2021 17:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=bMLhZ+ashyBqXKrhOuicGoF3N6JWLlVbc2h2uo9ROSY=;
 b=PwdE0cVP3Jveb7KL6VyarFW19byqdMLLw2mh7L481lwnl5NghOAEjW2bfOjJXsHrY6S7
 To2cKzYXemfrxxWPp2TryWi75nePvqxzBwikpN0LH32Q23ke/fjUcd4JikAWHY3Ik3ia
 VelVc7qpMrV+Rn6XOjIXfZqS0BUf3rQl/fu9B5SR8OTcUNeaaYsm8JkcyMcjMIoPn5AB
 ITdA8xE16sbTpQucy9pvzecnKm8hH3jqnBE2nMouOXJOUEgtHr5r2hFlC+TDk5is0qL6
 w9NYJSRw+vazsuetAVdlURiGWpb0uifR3pfbbU0iwi+bpl2Uqiy1rC/yaPfCOSqVehwC 8g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b8qkrayvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 17:54:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18NHptd9043308;
        Thu, 23 Sep 2021 17:54:01 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by userp3030.oracle.com with ESMTP id 3b7q5px1cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 17:54:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zc1hLINSh3aGpr/KpaA29kdtkvNNEyeAQo2oVMR9BU21I0KoxMPSMHzRaLcf9MHGRWg4ipJB3mYOXImBgsGoxY1RCJa3K2LzeSs7GvWN5rmpNhO3Lnr89xPagkhxlFVnZRDh4RxmMGcqtjt+edctTrT7nX+at3LlzsuU4h9dAvO66s0aHZ6dCLlKzyG6aGKco+2X3A3dzguURPGsOMBqMp1lIgX5fVHEwsyafcAMiwr9asrBu9TIEzjGxfO4+BFuLXfRMJ7fIMbyabpFv9hLNdzsCt5Ii/MoyaZgtR+3XK+jgS0w30CQ9VXrYLf+lctx9YRUZIo+M7O2nx6S0O1GOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bMLhZ+ashyBqXKrhOuicGoF3N6JWLlVbc2h2uo9ROSY=;
 b=V/X8/XK8CNGRmSptIk1wCgTv+Ux/nBUXiR13HIa38zfJsB3YYUuePuzsO8TZB8arYNdwfZRHINf3fW7jeGOBJEMAEZ62SSZJUcTEUtMO6hqGZqE+zsOOqn9AgzNroB/OCddvZ+7f0SXiggWwgH0A2GHLFiDUCm6Zy52Czi/z0JyPY5a4WFcpV88oiL1vIKkeOSag0g7vre/vEoU4C/Bncgj94YLhBMZ8EFzbxe//0MO3VPwHB7JAir8gsnrTl/9dn8GbjC1SuEmLsnA9vv1HJFzPtjyhLBk/yzUnwqaWuNsv9DPwVfJ0K4qdMkjXJMubWODgmUXniVd/+dRCa0Qhcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMLhZ+ashyBqXKrhOuicGoF3N6JWLlVbc2h2uo9ROSY=;
 b=V2L0RCbH23QGg4rLzRpxM9r0R3Y8ipIxO5w9YOgGqt6I96npyhDPW54Cdha0Hhu7eQAR4JrIp7/VoFKv+2pvPVKHBVh9m9hRb04kjZNM9+Fb+cL8/sfzSl/j0eNPgCdQiyhxSIPKPfCjtHOh8qJvfDBSwB67fQUUraDzk9PO2tM=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3447.namprd10.prod.outlook.com (2603:10b6:a03:8b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 17:53:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 17:53:59 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 0/4] hugetlb: add demote/split page functionality
Date:   Thu, 23 Sep 2021 10:53:43 -0700
Message-Id: <20210923175347.10727-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:303:85::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MW4PR04CA0164.namprd04.prod.outlook.com (2603:10b6:303:85::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Thu, 23 Sep 2021 17:53:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e7cca7c-7f2d-4484-7e9b-08d97ebb1edd
X-MS-TrafficTypeDiagnostic: BYAPR10MB3447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB344751B5043D893FE48B693FE2A39@BYAPR10MB3447.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5PQ6dSNP/JULCEwmtNZEdWkcNN7peiuSRWKnydSaFHm7+DYksIMOI/Q0s0Fgob3+J7rBDcUNvP0nljC3TM0jFVYjhdnE/TWAAk3LNIsJ8bZhDWv/wqu8qPn4F4TCUplEQ72Fj0K4oHZT+Ox4tnXDdszmO/MsAnyIMQ9WQ0svPw0LDqgQcouIzaWNK1Yb77pC7SZtNVm/by53sHchPJmOGX9UjpfDdalbpyMipkBEC6MeBC/btX6cvYl4jkbtVyNVN7v/jBixd6R8IQ754gDIqNj8fnB1E3Kjwy+f0U/aKIewdKvwJKTI8h+pJ8nQs1KEXCcbPZsyLznFOYkrpj+UpyvgggXHwwmkdYUsueggTYtw2NLUVgfXp/e+9eCjc1TsOVt35s91oCr0DLqsDDr3aRFtVybb06k1q2hf9nIJ5O6tkhm23Yiaa3HnhbiDEk0toG78WgVQtIBdPXwlpjXy0tiTQvotiMC0VPDJ6VZg8UyH9qyWDKO0tgAf94HhtiIYIXxkQWHP5TZOrdsbNQSGSuLVHqWxplv1GeWOPRSTC7btJQn+VNxTyNqSpdmrkHy+ipSb6Lms7zYQMePLR3D/K6bIoncizTp5TriV1jSLkxzUsJKiZjsIXtVdvdrANSWUJpbssJ03tG4b7jwpu5p3JnegKypYTG9EOUYxxcR6qn4LGpvBuoQlB2Dzh0DsXwAmqHQXnVR0sA2TkmSX2ot3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(38350700002)(508600001)(26005)(6486002)(1076003)(7416002)(36756003)(186003)(52116002)(83380400001)(2906002)(66476007)(5660300002)(8936002)(4326008)(66556008)(2616005)(956004)(44832011)(54906003)(7696005)(66946007)(6666004)(107886003)(316002)(86362001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cpSoEVM+e8prtDboGEsszNCFSBNoNLzSPFmJqX9tBQVsH5PyWDaQPhwuK+n2?=
 =?us-ascii?Q?QFo18mgl/2cUfkYEJDX+XV4/yua+vYyGrGHA5ElPm9Z+ceBNvliGwOmRc8ml?=
 =?us-ascii?Q?aFMso8exhXvlDsVSG88RIhBYBjFdcX4+DKL8xSzWKpZFgpLwayg/5QxzOpFJ?=
 =?us-ascii?Q?b9Xm8aGc+VewIB8z7iwvbQYYyG5qT6AnRvE9bnyKTP4iH79lrHLoILe6SOgZ?=
 =?us-ascii?Q?v+cUaWGeGxYFp4kEJH+oBTc09hMLXeYJqJp5y6PFBPHDUNgC+Q+GMG09CtOG?=
 =?us-ascii?Q?jO6NVadYkAN/9vUEB9fFN+jxFcykivF9OHse2FxBXDrWiTVngW5TLVARHebl?=
 =?us-ascii?Q?/AtLvNGugV35Y69KLXUxA7eC1KHEsQVLYem5zTCkt5csbs8GGqFFJ2Mc0icz?=
 =?us-ascii?Q?87C1Ww539WM2udUi0eiGInfQB3M5j0lzcpwVH2tcCxz26RYdX5bswOv2cd7X?=
 =?us-ascii?Q?9/mIZi7iavi01ft0S0vW1Und6cfUEnh52eLrKJJ/byWwuv7OxSfw8GXWa8JV?=
 =?us-ascii?Q?fWEwsTpbLus26W2Iz9HXhMSMQmldBBGw2K24THGjj+VJxePciLhOkysJ8Fvb?=
 =?us-ascii?Q?uTVc9YjvCBehaFqyeMzWVCjN8yMr/9DyIyJp1l6Fr+sK9nbmIkNFw71SDfnX?=
 =?us-ascii?Q?g4lH77+3UbuFusAngRyaEboRwR/o8O4wbAVaQOOC6M1u+qLUP2a0QBV1j82n?=
 =?us-ascii?Q?Z6wewE9OVc69MSmwvSRtmJQSbqBdPJNd0Jfz3D/RnG4c/AOeshs4wgsoXIJj?=
 =?us-ascii?Q?00rO5pXSeD0bBHQCYKEJSsNQnFDGQA/u6Gmjoz9kQ8fbCkHXocwlY++hbm+K?=
 =?us-ascii?Q?LCrTBloglqceBANxEGANJoXI1XsCVPoPi8vsPNv07LTZBScTZbV8i0DB9u+J?=
 =?us-ascii?Q?Q4kz+o7FyctfAkqa0dd1GesrRq1cF09OIadJ5Yhpzgfk8u6GLfpAOYFaF6zq?=
 =?us-ascii?Q?7lSB5jxO1MseVhXBDX3xOTFJd9ESrm1DGxu1bYsmwwM6XbQPHJ4GBhmKErEc?=
 =?us-ascii?Q?l0eZDxne71TY9YPQUde5w/pFJNEAmpsL9vVCxvCAWzqUS/hbWm3l2839jII7?=
 =?us-ascii?Q?xYYBQkIuhmgMO1HNC4YT9VR9jXrQMtxbkVO/q1Lyz9huWb1iXcR1rcijlnI4?=
 =?us-ascii?Q?x5LDe9MV02tbyDV6E3vxPeNx574dARP5xNy60E9Kg20c8O1RBMvsoiA9TKlR?=
 =?us-ascii?Q?MumqZvurArweyEC3VnNIDvFRdjf+inhI5jFNHi6+tMpjilvpkiNlXH92TtM/?=
 =?us-ascii?Q?5oSVhQxdN8BDkbp+Oinem0uUmb2ieYzufxZkckJ1c/S7gkGG5i63jSjxBK4j?=
 =?us-ascii?Q?67SX6+pNCut9bZyr3AKZaa+/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7cca7c-7f2d-4484-7e9b-08d97ebb1edd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 17:53:59.4668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +66ryq+cBJPTRDx8v6NHmqMtbESEyhLST3EN7jOnR0MQL45AhATATDEGLYvZv/6DzsK6HrlhFAlCwR+r148H/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3447
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10116 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230107
X-Proofpoint-ORIG-GUID: fePGK73IFtyqGdAr7a2p40f6PPlBYvAp
X-Proofpoint-GUID: fePGK73IFtyqGdAr7a2p40f6PPlBYvAp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The concurrent use of multiple hugetlb page sizes on a single system
is becoming more common.  One of the reasons is better TLB support for
gigantic page sizes on x86 hardware.  In addition, hugetlb pages are
being used to back VMs in hosting environments.

When using hugetlb pages to back VMs, it is often desirable to
preallocate hugetlb pools.  This avoids the delay and uncertainty of
allocating hugetlb pages at VM startup.  In addition, preallocating
huge pages minimizes the issue of memory fragmentation that increases
the longer the system is up and running.

In such environments, a combination of larger and smaller hugetlb pages
are preallocated in anticipation of backing VMs of various sizes.  Over
time, the preallocated pool of smaller hugetlb pages may become
depleted while larger hugetlb pages still remain.  In such situations,
it is desirable to convert larger hugetlb pages to smaller hugetlb pages.

Converting larger to smaller hugetlb pages can be accomplished today by
first freeing the larger page to the buddy allocator and then allocating
the smaller pages.  For example, to convert 50 GB pages on x86:
gb_pages=`cat .../hugepages-1048576kB/nr_hugepages`
m2_pages=`cat .../hugepages-2048kB/nr_hugepages`
echo $(($gb_pages - 50)) > .../hugepages-1048576kB/nr_hugepages
echo $(($m2_pages + 25600)) > .../hugepages-2048kB/nr_hugepages

On an idle system this operation is fairly reliable and results are as
expected.  The number of 2MB pages is increased as expected and the time
of the operation is a second or two.

However, when there is activity on the system the following issues
arise:
1) This process can take quite some time, especially if allocation of
   the smaller pages is not immediate and requires migration/compaction.
2) There is no guarantee that the total size of smaller pages allocated
   will match the size of the larger page which was freed.  This is
   because the area freed by the larger page could quickly be
   fragmented.

In a test environment with a load that continually fills the page cache
with clean pages, results such as the following can be observed:

Unexpected number of 2MB pages allocated: Expected 25600, have 19944
real    0m42.092s
user    0m0.008s
sys     0m41.467s

To address these issues, introduce the concept of hugetlb page demotion.
Demotion provides a means of 'in place' splitting of a hugetlb page to
pages of a smaller size.  This avoids freeing pages to buddy and then
trying to allocate from buddy.

Page demotion is controlled via sysfs files that reside in the per-hugetlb
page size and per node directories.
- demote_size   Target page size for demotion, a smaller huge page size.
		File can be written to chose a smaller huge page size if
		multiple are available.
- demote        Writable number of hugetlb pages to be demoted

To demote 50 GB huge pages, one would:
cat .../hugepages-1048576kB/free_hugepages   /* optional, verify free pages */
cat .../hugepages-1048576kB/demote_size      /* optional, verify target size */
echo 50 > .../hugepages-1048576kB/demote

Only hugetlb pages which are free at the time of the request can be demoted.
Demotion does not add to the complexity of surplus pages and honors reserved
huge pages.  Therefore, when a value is written to the sysfs demote file,
that value is only the maximum number of pages which will be demoted.  It
is possible fewer will actually be demoted.  The recently introduced
per-hstate mutex is used to synchronize demote operations with other
operations that modify hugetlb pools.

Real world use cases
--------------------
The above scenario describes a real world use case where hugetlb pages are
used to back VMs on x86.  Both issues of long allocation times and not
necessarily getting the expected number of smaller huge pages after a free
and allocate cycle have been experienced.  The occurrence of these issues
is dependent on other activity within the host and can not be predicted.

RESEND -> v2
  - Removed optimizations for vmemmap optimized pages
  - Make demote_size writable
  - Removed demote interfaces for smallest huge page size
  - Updated documentation and commit messages
  - Fixed build break for !CONFIG_ARCH_HAS_GIGANTIC_PAGE

v1 -> RESEND
  - Rebase on next-20210816
  - Fix a few typos in commit messages
RFC -> v1
  - Provides basic support for vmemmap optimized pages
  - Takes speculative page references into account
  - Updated Documentation file
  - Added optimizations for vmemmap optimized pages

Mike Kravetz (4):
  hugetlb: add demote hugetlb page sysfs interfaces
  hugetlb: add HPageCma flag and code to free non-gigantic pages in CMA
  hugetlb: add demote bool to gigantic page routines
  hugetlb: add hugetlb demote page support

 Documentation/admin-guide/mm/hugetlbpage.rst |  30 +-
 include/linux/hugetlb.h                      |   8 +
 mm/hugetlb.c                                 | 332 +++++++++++++++++--
 3 files changed, 344 insertions(+), 26 deletions(-)

-- 
2.31.1

