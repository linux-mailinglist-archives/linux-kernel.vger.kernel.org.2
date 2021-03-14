Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5283833A8A5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 23:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhCNWsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 18:48:46 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:12056
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229505AbhCNWse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 18:48:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwbPe3I88SURc1gL4Yra2U0VDLOh+ULEYyGW4e9ytqzO70JTfYrA1c8fTiRynig1Qwj1ZM+3w1hymq7HxaEy2o5vYUD8EOI3C2cmyEN78BcJrRhnRTmij3y5I3RvAICM/NWS2mvW6AERA68BksYZ+nNeErM5y8PPfCXdzssp2c6fDKZmEOMcNxnouj7lMEdJ1ldzkR1gdWggUTtV42zHV7UbN8uXQkJ2pTf63SqceM2ajs1Ak0ivuLtLXQeQ3jBZhE0m8h5pSMZxoGcH257rQ5TBw51uLrCfFh8hQO6Zofkh4sIe1lGKF+Z1xqUx8sAxjc00Xhi3F2ETnc6L6RwMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0X6rOH50bYM10Ua3RFwDWUoVU9xNzhc1VeqCwvXWpw=;
 b=QcWiOniv6Jz2bvPOfkVIb5+SB/bMgvBYw3feG5oxuaVUUkYlJt5p2Ob6aZEBgJtT60zUUoxX7eKxCudyfRvg1OhCeco1uMJsgcVLX4WDPmDBHvzmbNdR1DkDzUOf1cwxiHNz/qY4Q+oQ6lBSMhav1+bdn/m9cbTZynlir1a+5QN8qOhmw0beoeGUQp3fDAove0catU0JmuuaO5tQeSe2XBt7H5i5/NboHlH2Ol7KdPLhvn5U3rxUAiDZKNRoorIhATyFjPKmM3PwWJYKBgklQZv6EHKzyjadQRg4r4NtKz2q+/s1AeWUtvDen44MADWGUMlG5LsnaU1EXog9Qd8R2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0X6rOH50bYM10Ua3RFwDWUoVU9xNzhc1VeqCwvXWpw=;
 b=MdCXi5OZ9nHzsrdXg9zs5CFCTIGk1WT22uwkVPp98MQuvx3C1Q4LDq7FqLQhNX7K7QDIS+SS7hn0tq5F/v3dSth9TK6ai1B+A3axz9wFndsetEpf6PigL3P1i6XsOpj81sVvmCsF8SJEi6gOBux4L+qtHkXu8ZajW/nT7Mfd4N4adFLsMe3uDeCibwq7G9TIZIQYAjjNrzpHsHKZU3w+pbAnGtEu4DaIUlPrKkFMr1/TmqicrYi5ahcUDnJf+zf5ApIa635gFHHNn0j2ML2lq2am93IAcXckYcF2AUIsiPeyC+iFFuxPzCU0sbuBgFA0VUBSVjPW1/b6mq/sJmZxIA==
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4014.namprd12.prod.outlook.com (2603:10b6:208:16d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sun, 14 Mar
 2021 22:48:26 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3933.032; Sun, 14 Mar 2021
 22:48:26 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Yu Zhao" <yuzhao@google.com>
Cc:     linux-mm@kvack.org, "Alex Shi" <alex.shi@linux.alibaba.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Hillf Danton" <hdanton@sina.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>, "Michal Hocko" <mhocko@suse.com>,
        "Roman Gushchin" <guro@fb.com>, "Vlastimil Babka" <vbabka@suse.cz>,
        "Wei Yang" <richard.weiyang@linux.alibaba.com>,
        "Yang Shi" <shy828301@gmail.com>,
        "Ying Huang" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        page-reclaim@google.com
Subject: Re: [PATCH v1 00/14] Multigenerational LRU
Date:   Sun, 14 Mar 2021 18:48:17 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <B2FE37C5-85B7-43AC-B6B2-43660E13FDFF@nvidia.com>
In-Reply-To: <20210313075747.3781593-1-yuzhao@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_A66144AE-3E39-441C-BAD5-5A2B1AC101B8_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: BL0PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:208:91::14) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.54.46] (216.228.112.21) by BL0PR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:91::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend Transport; Sun, 14 Mar 2021 22:48:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40df103b-7c46-4945-fdee-08d8e73b475a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4014:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40140233A0A86B84EF0521B3C26D9@MN2PR12MB4014.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yiPEcDuttLj4DPHtjQh/0gaVh85MX8ybwdZCQpBwLHyLQpBRI3SI7MoQnrOHiX8pFI2jkk4qD6duahsbr5mHIvepsQ1pjYrxZM134CWmaAOWa61GhvSrZcn4RBhm9y8f1uK93lS6jgNhbWQ0QEnud1TwmQYTGJLSywEYcoIv/fNk9J3NeOCyfstuJTgmpezh3t5gw+1mZ0Krbgh7c3oFJ5UEst8OSwwXJWl9PJqt22LP2wEVM9YwFP9c6n9skp4j91SEc37NkZFlB85PzXfcGZzv7iVDziIWIND+k2Qk3xdpzqyTkV5GUqRx1uw75GnUtLvxlU7MXVjKXCLUAmx7lTsOzKP9Go6hcw4AUg+mTbOP2/Mbp35h5aEuQOEQGwChmKilJ/VWTjCwaNz9bUU/tkCvB47s5Ms4OKWipxjRjP/n2YJghofBq1LDxRDATeiiruHyvIF6yrHI4yvkpMxf6uH/dc8TyEWTnpC1bU0NaWCh1ow9X8lP3nkL7pJ4Q7k0QLIb4KJOlXxhNgnz5xx66ztFLvgCDaISZXVCr7EDA9ze8kTaN18OLae7f+Qir9SqTn6gT5LJMDWNgWUGoiDHjVwBxl37xWmqIMr+O9siSFITiAL1y3JvXW/5u4X9UKiVJdJo5SlHgIJHOhFSUTy5h+TQxXK9w+2op2N624aX5TWwXlnp27VNc+ocYNUla1xalDxLe1jmgWyzXyQFM+WHCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(33964004)(53546011)(8676002)(8936002)(66476007)(6486002)(33656002)(6666004)(7416002)(478600001)(6916009)(86362001)(83380400001)(2616005)(956004)(36756003)(316002)(66574015)(16576012)(186003)(5660300002)(235185007)(26005)(66946007)(16526019)(4326008)(54906003)(2906002)(66556008)(966005)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bzNyNExCL09DQllvR1c4ZnVoajNzV09VenlYMG5uWUdlbkJhaS9kaVBTMHUx?=
 =?utf-8?B?dk85NFB5R2thb0kxbkJxYTZydG1ZaUtZaUhRSGNlU1dYU0ZkcklXUXV1TnNr?=
 =?utf-8?B?Y3pnVFJWTzJjQUxjK1ErelJqOHBlSzc5N1BBYmp4VTBXdDFIRnk1Qm14eW4v?=
 =?utf-8?B?RFNTREhYKzNTdUQ5dTNNeExVKytuOFRrZFBSRGZkS0hXUzRJbFFyN0hHL1BQ?=
 =?utf-8?B?cGppTmNFVjEzSXVZNUp4L1RSemlKblpmdGhXK1lrWklFQnZXTGFwRlYrems5?=
 =?utf-8?B?N2crNGpORGFCSzBsblVGd0hXYnU3REZreE9qMUxKVHdsb3lLYTJQOVROOElw?=
 =?utf-8?B?VEthaXhqZnBrbVFBWnNuUWhaMzdCWmh0UXBUeEtvVVl6V3NaRGppd3F1YVJk?=
 =?utf-8?B?YTF6M0FKeTZ0eW5temUyYVJGZktvTmROckhwM2crMm1WNEN1VlErb2hJZklD?=
 =?utf-8?B?OWVzemhRMUNiMEtYU0RvbU5JWHdoZEgyM3B3OUdtcC85TEx6SDAxbURRc0hO?=
 =?utf-8?B?Znp4WEU2MGs5MTdqZmI4OWxScmNOSUxGSWRlZjV2dGgxNXlCekdReDNZOXlK?=
 =?utf-8?B?WDdwUThIYnAxZ3ZEMkZhRW1iWWt4K29RRXl5SWJrc2Y0ZEhsYVB1N1A0QTFz?=
 =?utf-8?B?c3V2MStqZzcwS053b1RYQlI2U21PL3p5Sk4veXFnYWNsdVJBWnVleFdBQlJY?=
 =?utf-8?B?ZW5vMUxtRHRUV1VxS1FHTGpkaXRZcWxvSVBaQTBiUnRoT3ZBNVVJTlhmcWV3?=
 =?utf-8?B?SUdkeVk0ZWphQUtGSWFJMExIeG5WT1FFaEZJeVBsL2I5NUx1anlkTTk1bTQ1?=
 =?utf-8?B?Z1lDdGpxaTJtWllNOEptclRLOXYvRVVCVnNOTmlreVFiUkptaUdRRnM5Lys4?=
 =?utf-8?B?cGdkelR1SEZXVThyT3BLN3YzRzNRb0tYK3N0ZVRzdFU5ZWVFclZYSG1hM2tE?=
 =?utf-8?B?aVlTeDZJa2Y4ZlRlL2cvandrNStwc1lhVnlnVlBLVWZpaXBHdksvNFg1SU5U?=
 =?utf-8?B?UU9TUkIwOFh1R0VlWEcxdTh4YTdtTjdRR3F4MlhVSFlBT2pnZzlTc25rMis0?=
 =?utf-8?B?U3pGVHI5TXhJbU5YWnBjMTFVUXVJdkllMFI2MGd0bk9VWkNBNGpMMGZvMmlR?=
 =?utf-8?B?QmM5U04zOHNQZnhkNFY1a0UzamxraE0zTDF6QVcvZEZFNk9DTjR2c2RxNi8v?=
 =?utf-8?B?bVJFMXlXTHh6VDh6Qml3WndMeFdjajNrZ2lhU0FLbVJOMldiOXRmWjJvRk9Q?=
 =?utf-8?B?alpzREtRQVRWK2ZUSEZvbTdUTHRuZW9RWXo1MldQaE8rWngrVkJrejUzdy9K?=
 =?utf-8?B?Y0UrYWw4Tk93SjJ4Y3BsNjc5dkZnYW9rN3o5L1Y4RDRGY2o2NGgrVk1GTURK?=
 =?utf-8?B?VVFRYndxUCtUditYRVRXaGFqVmZDQkNTRUI4YWhWS0VIZjZFVmt1ejUwSlpZ?=
 =?utf-8?B?d2ZWaFlPT0NFSzFHM0VIeG1tdnRmeXEzUDhlRERib0c5eDlsYXphVVFPRE5q?=
 =?utf-8?B?UE9EeEhLeitRcFFodG9sUVZYbTFXVDZXQUdPWjVBNjRtRGZHUjNlNWkxRWZS?=
 =?utf-8?B?QmlWdGl1Q0UzckI4SXAzNUV5VXEzOTgvMzlDWmJ3NXpFdGR6QklBbUJQSC95?=
 =?utf-8?B?bjI3ckpiUDlycTBlUlpVbytyci9EeFNhTE1rWFNlZEUrdUZOVmZ2eXdGbVo2?=
 =?utf-8?B?N1lrL2ZrL2RlLzlWTmd4akwrNnlMbTdLRWliTGhld0xzQ212ZzFXWXNYTC84?=
 =?utf-8?Q?9jWxar8PMFdgT/H6/HVcxrV67gX4b4C8Uk4ABSS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40df103b-7c46-4945-fdee-08d8e73b475a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2021 22:48:26.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqGjn6n64+lRYwZCLeJ9N3lBF0kUH4deUm3FsengAz4rDYNN5kaJ3YbR/xH5JPPZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4014
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_A66144AE-3E39-441C-BAD5-5A2B1AC101B8_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 13 Mar 2021, at 2:57, Yu Zhao wrote:

> TLDR
> =3D=3D=3D=3D
> The current page reclaim is too expensive in terms of CPU usage and
> often making poor choices about what to evict. We would like to offer
> a performant, versatile and straightforward augment.
>
> Repo
> =3D=3D=3D=3D
> git fetch https://linux-mm.googlesource.com/page-reclaim refs/changes/0=
1/1101/1
>
> Gerrit https://linux-mm-review.googlesource.com/c/page-reclaim/+/1101
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> DRAM is a major factor in total cost of ownership, and improving
> memory overcommit brings a high return on investment. Over the past
> decade of research and experimentation in memory overcommit, we
> observed a distinct trend across millions of servers and clients: the
> size of page cache has been decreasing because of the growing
> popularity of cloud storage. Nowadays anon pages account for more than
> 90% of our memory consumption and page cache contains mostly
> executable pages.
>
> Problems
> =3D=3D=3D=3D=3D=3D=3D=3D
> Notion of the active/inactive
> -----------------------------
> For servers equipped with hundreds of gigabytes of memory, the
> granularity of the active/inactive is too coarse to be useful for job
> scheduling. And false active/inactive rates are relatively high. In
> addition, scans of largely varying numbers of pages are unpredictable
> because inactive_is_low() is based on magic numbers.
>
> For phones and laptops, the eviction is biased toward file pages
> because the selection has to resort to heuristics as direct
> comparisons between anon and file types are infeasible. On Android and
> Chrome OS, executable pages are frequently evicted despite the fact
> that there are many less recently used anon pages. This causes "janks"
> (slow UI rendering) and negatively impacts user experience.
>
> For systems with multiple nodes and/or memcgs, it is impossible to
> compare lruvecs based on the notion of the active/inactive.
>
> Incremental scans via the rmap
> ------------------------------
> Each incremental scan picks up at where the last scan left off and
> stops after it has found a handful of unreferenced pages. For most of
> the systems running cloud workloads, incremental scans lose the
> advantage under sustained memory pressure due to high ratios of the
> number of scanned pages to the number of reclaimed pages. In our case,
> the average ratio of pgscan to pgsteal is about 7.
>
> On top of that, the rmap has poor memory locality due to its complex
> data structures. The combined effects typically result in a high
> amount of CPU usage in the reclaim path. For example, with zram, a
> typical kswapd profile on v5.11 looks like:
>   31.03%  page_vma_mapped_walk
>   25.59%  lzo1x_1_do_compress
>    4.63%  do_raw_spin_lock
>    3.89%  vma_interval_tree_iter_next
>    3.33%  vma_interval_tree_subtree_search
>
> And with real swap, it looks like:
>   45.16%  page_vma_mapped_walk
>    7.61%  do_raw_spin_lock
>    5.69%  vma_interval_tree_iter_next
>    4.91%  vma_interval_tree_subtree_search
>    3.71%  page_referenced_one
>
> Solutions
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> Notion of generation numbers
> ----------------------------
> The notion of generation numbers introduces a quantitative approach to
> memory overcommit. A larger number of pages can be spread out across
> configurable generations, and thus they have relatively low false
> active/inactive rates. Each generation includes all pages that have
> been referenced since the last generation.
>
> Given an lruvec, scans and the selections between anon and file types
> are all based on generation numbers, which are simple and yet
> effective. For different lruvecs, comparisons are still possible based
> on birth times of generations.
>
> Differential scans via page tables
> ----------------------------------
> Each differential scan discovers all pages that have been referenced
> since the last scan. Specifically, it walks the mm_struct list
> associated with an lruvec to scan page tables of processes that have
> been scheduled since the last scan. The cost of each differential scan
> is roughly proportional to the number of referenced pages it
> discovers. Unless address spaces are extremely sparse, page tables
> usually have better memory locality than the rmap. The end result is
> generally a significant reduction in CPU usage, for most of the
> systems running cloud workloads.
>
> On Chrome OS, our real-world benchmark that browses popular websites
> in multiple tabs demonstrates 51% less CPU usage from kswapd and 52%
> (full) less PSI on v5.11. And kswapd profile looks like:
>   49.36%  lzo1x_1_do_compress
>    4.54%  page_vma_mapped_walk
>    4.45%  memset_erms
>    3.47%  walk_pte_range
>    2.88%  zram_bvec_rw

Is this profile from a system with this patchset applied or not?
Do you mind sharing some profiling data with before and after applying
the patchset? So it would be easier to see the improvement brought by
this patchset.

>
> In addition, direct reclaim latency is reduced by 22% at 99th
> percentile and the number of refaults is reduced 7%. These metrics are
> important to phones and laptops as they are correlated to user
> experience.
>
> Workflow
> =3D=3D=3D=3D=3D=3D=3D=3D
> Evictable pages are divided into multiple generations for each lruvec.
> The youngest generation number is stored in lruvec->evictable.max_seq
> for both anon and file types as they are aged on an equal footing. The
> oldest generation numbers are stored in lruvec->evictable.min_seq[2]
> separately for anon and file types as clean file pages can be evicted
> regardless of may_swap or may_writepage. Generation numbers are
> truncated into ilog2(MAX_NR_GENS)+1 bits in order to fit into
> page->flags. The sliding window technique is used to prevent truncated
> generation numbers from overlapping. Each truncated generation number
> is an index to
> lruvec->evictable.lists[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES].
> Evictable pages are added to the per-zone lists indexed by max_seq or
> min_seq[2] (modulo MAX_NR_GENS), depending on whether they are being
> faulted in or read ahead. The workflow comprises two conceptually
> independent functions: the aging and the eviction.
>
> Aging
> -----
> The aging produces young generations. Given an lruvec, the aging scans
> page tables for referenced pages of this lruvec. Upon finding one, the
> aging updates its generation number to max_seq. After each round of
> scan, the aging increments max_seq. The aging maintains either a
> system-wide mm_struct list or per-memcg mm_struct lists and tracks
> whether an mm_struct is being used on any CPUs or has been used since
> the last scan. Multiple threads can concurrently work on the same
> mm_struct list, and each of them will be given a different mm_struct
> belonging to a process that has been scheduled since the last scan.
>
> Eviction
> --------
> The eviction consumes old generations. Given an lruvec, the eviction
> scans the pages on the per-zone lists indexed by either of min_seq[2].
> It selects a type according to the values of min_seq[2] and
> swappiness. During a scan, the eviction either sorts or isolates a
> page, depending on whether the aging has updated its generation
> number. When it finds all the per-zone lists are empty, the eviction
> increments min_seq[2] indexed by this selected type. The eviction
> triggers the aging when both of min_seq[2] reaches max_seq-1, assuming
> both anon and file types are reclaimable.
>
> Use cases
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> On Android, our most advanced simulation that generates memory
> pressure from realistic user behavior shows 18% fewer low-memory
> kills, which in turn reduces cold starts by 16%.
>
> On Borg, a similar approach enables us to identify jobs that
> underutilize their memory and downsize them considerably without
> compromising any of our service level indicators.
>
> On Chrome OS, our field telemetry reports 96% fewer low-memory tab
> discards and 59% fewer OOM kills from fully-utilized devices and no UX
> regressions from underutilized devices.
>
> For other use cases include working set estimation, proactive reclaim,
> far memory tiering and NUMA-aware job scheduling, please refer to the
> documentation included in this series and the following references.

Are there any performance numbers for specific application (before and
after applying the patches) you can show to demonstrate the improvement?

Thanks.

>
> References
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. Long-term SLOs for reclaimed cloud computing resources
>   https://research.google/pubs/pub43017/
> 2. Profiling a warehouse-scale computer
>   https://research.google/pubs/pub44271/
> 3. Evaluation of NUMA-Aware Scheduling in Warehouse-Scale Clusters
>   https://research.google/pubs/pub48329/
> 4. Software-defined far memory in warehouse-scale computers
>   https://research.google/pubs/pub48551/
> 5. Borg: the Next Generation
>   https://research.google/pubs/pub49065/
>


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_A66144AE-3E39-441C-BAD5-5A2B1AC101B8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBOkrEPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKWAYP/3Sqj049dw2rOlKwOUcKi0FCBcQ+AHV3Thpm
Pl73Q4d/dKO4X8+d/PeioTOf/Jr15H2LiIW7gojVJ1r3eJwPhmocW2yuGbmD0VCo
DjyLxLqTdIHTLWIlS07TnAYtbeXikAbDxc4Od3TR1gPBMn+bwT+re7do18hLmE4F
HvhaQKF0AKI4cHF0QyJCiml9C4ZYiFZRae+1ZFFoJcpFYjsE3fYNnrdkdZi4Ic4R
YRH3Xh28X3jhP6I4iIxHw0AHA7KGPFawHvMgfpMVJ/m+2q5FOeuCkH0OUDkjDyoB
z4pa5nRGRhzdPIIWoqEyXgN0fI3G/J/YJFWVDmlRL9lzXuK2LjvEgbCyvkoTegHL
60QP3gY8+ujyRfKIpHIvtrJuZ099jQFlm1SPA4wbFEBXCMUyoiN86EzD63PMQdVm
1hIF6tZ1Id6wcv0+QtIdsPzfT3LZaE5pOneXRbcbZtuCheml8JL26TLm8nJO9mQN
dBHRd9SnWNHoxlx9awZZGpBkfGbIMEEuMf+Wzajpcgfzzk3pX3Km9ZZCi+aCVO6B
dP83Zt+1l4XDINx7jxXqtMfJjPjPoZxySAlaSVmDvPg2qqFqjFpVTBD4Z+IQawDa
5tSh2lNFzJpdFsfsMFEK75tyOD4OttmshbnEoovWgIA0tltEF91BYKBLxIAH/QwI
wyH8JQcT
=AXYl
-----END PGP SIGNATURE-----

--=_MailMate_A66144AE-3E39-441C-BAD5-5A2B1AC101B8_=--
