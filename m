Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4175425A8D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243580AbhJGSVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:21:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29004 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233844AbhJGSVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:21:45 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197I6QlJ026150;
        Thu, 7 Oct 2021 18:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=1xw0+xmSYkg3Eq4E9M7A0BAiaN4eH5rhMINQ4knE4WQ=;
 b=Xz2bzp9zHM+cnoOTKQKw3Ps6aKsQkopgALq5o43pGsonaRqINnX+9KMuJJAeHv41vNbe
 n6ScmP+KRJL9XuXV+tuxB3B4BFHiiNANP1yvaFibByodSvjrgKrgZ4GXp7TYeYYAeTRA
 2B7vPrKkwc6F+h/eQopLZSQvc4sJu4JhZttPFhQURYPkoOt/y8p8LZDbd2u/tr7I6wJc
 g55Sx2AJ73a3CHdZuA0Rx+tjirgBpgFRh2WO1+nH/LRxoTvKpNHvdlttSFr2TvUMbUj0
 5XKUTF3qZbJmb697J0LyDp1FF/unwqgo/GaC+N9H4rqZHUIAxz/81FVIDFcyPtV8prsL AQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bhy2db61n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 18:19:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197IA5eS046614;
        Thu, 7 Oct 2021 18:19:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3030.oracle.com with ESMTP id 3bev7ww3am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 18:19:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8gz7Wmysgp2uVvyvhkTAsmp/1pfFGpDjwHEGB0AkYbDliTAAjmH8V01Qj9Qd49iue7b3ili9wqS/pYJnEraqrpHY9vIV0YynYd4wmxTkwBLtMYuzMKw6IaRzYoa2TLOOdxZTneeNcXfFV+GHioyWEiXrsFSQ+esVqO/WHfEdikehu0Z6XtMxrZhCpVD6bYVvQnJhRa0j5e5reM5Oq7j6XGKjUO9bB3JvbKOcdPzr9RSqiJNWgiYw54LW6O8WXlOBLe5M37y+lFRdunwrctYaweL1N1BvpKMGb99TRmAENuNLcvP54hv7KnaGHkfmXqyIBIPuLvbDQvPia9JIbmFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xw0+xmSYkg3Eq4E9M7A0BAiaN4eH5rhMINQ4knE4WQ=;
 b=Ph/XD5qgcU+40yCtaS1dnGjConGBiJAMnDFeAo08j92rjX9qJ0XlSsw6ThfYHjJhI58TOmSSXvUJgOOh3k0kDzNUwg9d4t8hiPO7jFQsE7oQnMLcWK3oMBrvfDGq204kDE6uRsy3qEXX98tWRglpv6xKJ7CCJZPesdE+5Xe/7/jseQUhXbnye/5xEx/KKcbsy6GCRZlO2UG9/BjYNV0iof3a4W+0BazDoxgjF0oNk8kln3LiWdhZMh6JyrFJKoNk5tD8rOXnJysbaNzSr8vChMIs5/wPP7es+THdYhYwcGd11AT2wAF/jRdYoz2rQMus1azPK/RqNPzMlsXd3ff5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xw0+xmSYkg3Eq4E9M7A0BAiaN4eH5rhMINQ4knE4WQ=;
 b=pP4knUUqrpRxUw9PDLhtKgBDEBy5uyYP3jmeAbaHztcUyzbvqwo5eNOZum8r00Tpv0Nh5B6q5dn+vBnfJvKbCmFyPEHmZj8VhmARhyFqB+dBJ56NGjAGf70SAp0IEA3jKJzgbOq1qNKdAtSjj0QHVmpdVpK7r6sxBUjYTBeKHhs=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2552.namprd10.prod.outlook.com (2603:10b6:a02:ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 18:19:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%7]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 18:19:31 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Nghia Le <nghialm78@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v4 0/5] hugetlb: add demote/split page functionality
Date:   Thu,  7 Oct 2021 11:19:13 -0700
Message-Id: <20211007181918.136982-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR1701CA0012.namprd17.prod.outlook.com
 (2603:10b6:301:14::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MWHPR1701CA0012.namprd17.prod.outlook.com (2603:10b6:301:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend Transport; Thu, 7 Oct 2021 18:19:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b75d04d5-106b-4f87-f088-08d989bf0193
X-MS-TrafficTypeDiagnostic: BYAPR10MB2552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB25527E3E43900FB4C6EC7D20E2B19@BYAPR10MB2552.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ahkjvybx9sSmbgIoiQKfYGL5wwOOqOj8C4uuN5iDKmbMI2gT1mgz6FBVOw8R0Q9burKu8SEgm3SY2sUoeHKav7XufD3Nb7eQGbGKBB4J1L67/0JyBAjVEyHwPDHLE83tzNj4g9niVu9UMb3qMtbS5JZt/DC4UyDImR8+nk474JW7vGMgyGqfCbF5v8CXEhzK6TRRgRor9Bhy3cwutUsRWxzpmltYPF6ncjD5pJ5T/msqSvukD/c/LMGOpQp8E4aYwTMMe1b6FG2MZIoMiSdQ5K9emcCflfhWTQ4VY7fsHvfsXOZIUh7zkxj9P1+fup0Il0SSMcDCZQOo78J0zqnJjAb5YdCqeppbX3bCBMLbUeYo0FJHBs/7xrIbVq9qr18iAGmfxW5v5OLdWOXo8ICqcVkWLMQTY4OHXhVIKJCZtf9hz/X+xMUy7PmMlf4A/gOMGN96jQS+9OmUPcI+6EjxM1HFD05uioC8RgBrg8av1Oav8+vrRdwDl4nMVCSNjkhcgeWYwgMSJ58ZsdSW+UGfgF8o4zMRVyQ27jpkO/5fr8p+trt6QSK9j2s+V8q6ZuhtPpsSJg99+zv6aSrnqrvrHhlmlNbhHqhn4MwO//Y1Ah3z87JXkkgHBA+6PTxsmMwh+DYlNZfr8Qvo8npsEdb363Sa9dxplNt4VY3WT9wHepSb946p16vhQk1SEu8tKbNJjnIgj8uff28tmRSn3COyYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(38350700002)(316002)(7416002)(44832011)(5660300002)(6486002)(107886003)(2906002)(1076003)(186003)(508600001)(54906003)(38100700002)(6666004)(66476007)(36756003)(66946007)(4326008)(66556008)(52116002)(7696005)(956004)(2616005)(26005)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eQje2irVpbx2ylXIzmsdmDsOQpHqwAl0YCy1OFObb1AzBIvaO2D8G7zn285v?=
 =?us-ascii?Q?vazLvH5w+IoTlBNk5cN064qdpcSHMnAv8H0cQ4A0lrHcmQnnULW7V8KPxayo?=
 =?us-ascii?Q?Aw+i0ehUGpktGAe1gsI/1L3hcbojDOMvcdGOfqvX7Zo+5hQv3bcMWIOdZ9Xg?=
 =?us-ascii?Q?BHI8b4dIby4DwMeBiKjOQPBc0Ao9i55kZA20qp9l6RGJqtmwOGkGk/H3P98t?=
 =?us-ascii?Q?Q5RJwknUQYxaBd4tAdG47U9vUhxKzxx/KCIlgf8uK1WPcPtfWJWgmmykNK2q?=
 =?us-ascii?Q?+UFeqnk4faMmGPwO7lCjZbywh5yzFBOL3tW2H7bq+LBOr+FiwEXRFoPTRC7G?=
 =?us-ascii?Q?v5M4j9Xff56YOPKwYLi1MTs2dMxx94d2pJiZYfifmkJ4oTbk1+1z8Bb1bowR?=
 =?us-ascii?Q?QRtzoA9iWhqaGi2CYukeinfCenhdzQ0lX2tBUNUBydl0Y9/yDLW38sljRknT?=
 =?us-ascii?Q?FNHlw/VlCysJ+a72PZyyUti0Xij5NCbe1qA1FaPw+RZPI/A+LnSzTxEST+3s?=
 =?us-ascii?Q?KKRTMk0vK9x1yprZ5torQLmwdO//6UgZ+UgPL5mDinYIbLBGnlBk+8bVNq/s?=
 =?us-ascii?Q?Vcgh3wfMZ5n5QJHe388yhPCIEDkhQUYs5MfcVpkqCYSp3mQ/mMIZPpKwddpF?=
 =?us-ascii?Q?DN9Z0sV2ek3gUqtLCbYFGEgdZW+vrXMEKe1A+nm2t6JGca/iL/uzeQhCx5Og?=
 =?us-ascii?Q?cAyZTP2nDzYPpMvtRUjK1wXMyQcR5T3FjUTPbhhD6RRQDcG1DyaSgRI+jQiK?=
 =?us-ascii?Q?iT4KxOeesoBNuNZaXOa1e8W7LTR6BuR5CqXzvsmaBwSi7tbFI5sx968T0biZ?=
 =?us-ascii?Q?25egOvpLqPAu1S0iTKg/1xvNWrCrVoWCgYTpKndch1t6KiK7ttTyaNUJn7rG?=
 =?us-ascii?Q?ECjuSIfWV9iKEinAg40i7uc1vXHKgEKVuki3m1lfw01fw9Hh38KDx9hEhpsE?=
 =?us-ascii?Q?dgZwyBPfy8RH4Pubw2jdl0K1O2Azc1wU+t78Wa7ZMzeMrHcSWeGGfYCmYtm7?=
 =?us-ascii?Q?Xj9X0D17x5glWkiSJMGOWWHBG6uxBY3Xh16bY9o9oPA5SH4AB8XxlwZ+87qC?=
 =?us-ascii?Q?iqyHP3xHxE+V/1ahKx9ki/IynrvIi+iukIH5n3NTi6oJxjW2Hw4yNv2ritTp?=
 =?us-ascii?Q?MtEPEEha5YVvpc0hLhf6HMkKfgDhf7GxIGxnxQpE+oETLFz36EhtPt1nhL1M?=
 =?us-ascii?Q?4ZskNZu4YFxPL0Y3+Sq3i3EhSHUT74yRVbl/AqLmeBmbaPRtkbNW2+qmS1l2?=
 =?us-ascii?Q?NYPr3hS+yXF9YRGhIamL10ctw4YMZLUkbSlbaygpVk8Pased5Kq2W8RNcnMu?=
 =?us-ascii?Q?nNrRFkSjaxRBA9Fo6YOpjpZz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75d04d5-106b-4f87-f088-08d989bf0193
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 18:19:30.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffdwjLMhQM+dFW9zuPxIyTtE1HUN8T111npSng6K8GY0wrk4HY+DJQVQJLXwPDcFqyjjLgAILjWcfOiNFU4MWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2552
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070118
X-Proofpoint-ORIG-GUID: 28ygwXWai5zKyPXbwTSjpx0nsyIDvPU1
X-Proofpoint-GUID: 28ygwXWai5zKyPXbwTSjpx0nsyIDvPU1
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

v3 -> v4
  - Fix dead store in demote_size_show and rewrite to look better
  - Fix documentation typo
  - Make code setting up per-hstate demote orders more clear
  - Add warning if demote_pool_huge_page passed null demote order
  - Acquired hugetlb_lock lock later in demote_store
  - Restored cma_release debug message
  - Updated commit message for the need of using HUGETLB_PAGE_ORDER
  - Renamed function to destroy hugetlb pages for demote
  - Made sure error codes are passed all the way back to user

v2 -> v3
  - Require gigantic_page_runtime_supported for demote
  - Simplify code in demote_store and update comment
  - Remove hugetlb specific cma flag, add cma_pages_valid interface
  - Retain error return code in demote_free_huge_page

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

Mike Kravetz (5):
  hugetlb: add demote hugetlb page sysfs interfaces
  mm/cma: add cma_pages_valid to determine if pages are in CMA
  hugetlb: be sure to free demoted CMA pages to CMA
  hugetlb: add demote bool to gigantic page routines
  hugetlb: add hugetlb demote page support

 Documentation/admin-guide/mm/hugetlbpage.rst |  30 +-
 include/linux/cma.h                          |   1 +
 include/linux/hugetlb.h                      |   1 +
 mm/cma.c                                     |  24 +-
 mm/hugetlb.c                                 | 318 ++++++++++++++++++-
 5 files changed, 353 insertions(+), 21 deletions(-)

-- 
2.31.1

