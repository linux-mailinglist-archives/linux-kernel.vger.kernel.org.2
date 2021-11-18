Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32149455EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 16:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhKRPEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 10:04:39 -0500
Received: from mail-sn1anam02on2043.outbound.protection.outlook.com ([40.107.96.43]:18933
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231215AbhKRPEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 10:04:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPkgDh5T0kfmN12vIUhGjLtKFX4Kgj4JVaQ43ueUA0OJxwUlWY+wpTMigc3e+Yz9JaVlfZwdhTwZwnd3GPl8QM2Y+n6p3xYgltAOcUOKnaOZJZoTzvoy6/mZCFGa3pPMAkV29H1HW5XcykPaL7SOt9C59RrK7hS5mlNG+TDmc5gruYKXvMcFNN+DvvQycQuDmPbDpHxOMGSqH+lVKI72hsI5gMQhpc6FKJWu2Q8YFwvnsmXbAotJiG0OCubjpUP/dy+3IpOzL4d562eWxJqga2tAyr01xaYCQuizKZvbe7Us/AfZYAZ3+9icXdrYAnGxerRN8qEfTEp78yqb2y9yJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhwq1c0Ub3gkhCsCGjhhB8OkpaCrbGxRDk/Si1+2520=;
 b=oCRIdCaKdTENpJLuebogvqvG56AQ88V0Eqi32MAVLgSBLo7JfyCOGBm9pq42cMMC8LZAQzJ9ztaLJQhZLyYqMUYUWSxQ/1qQ9CmPjFhDV2kaTHXJSNznNuIe59o2cPNFZJxjdeTwnuNAQch1wpmCkwChlITDHtjsp1tX7tkKdICAoAJXxwbMs8DMU0ZsSwybgZNcTsCxuLBSBRwRmdCb5n+tuBoe54a8XQMhEf6zSKVdBNEbJOAbmpLhiowGYdn+xcSpdZ5q5DaOIROSTzu1603sRarr7rplbwV5uF3aKRWTCbxdRpdr6fR+6/lBBRaXH+++mc3HbOz2lus/G2RsBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhwq1c0Ub3gkhCsCGjhhB8OkpaCrbGxRDk/Si1+2520=;
 b=U4IvNMtnMWReacmxEj+ZmnJne4ODuPNQGLHoIZPmhAybA/KE5hInpgA3+U25mVMMig0ehk1i5g5oh93+zkt7WX/vBRif8RPKeyhAwtXmH14lI+P5H4m4/I+ayYVjXSH8HxwIPQO/M5tsrrkbVd3vCUwVvjMX2FQ4q6p6zKDnFFiWuejnszhNe24hKZOCRoYyPTLjIqGsh8mfOvo4ioRH5uCNorT8uwj/OFV67tz2Z5fojHJF54p0DMFXLKeAp/iNPi2/b2drn6AUuEf86aFwa9gaRF19hqmKTnXuaycJM7rKH9vB/QN3xxcWusrlk25qfHk79sCS8/qi8cwOcpZhMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3819.namprd12.prod.outlook.com (2603:10b6:5:1c6::20)
 by DM6PR12MB4893.namprd12.prod.outlook.com (2603:10b6:5:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 15:01:34 +0000
Received: from DM6PR12MB3819.namprd12.prod.outlook.com
 ([fe80::8dfd:f3e4:3935:2207]) by DM6PR12MB3819.namprd12.prod.outlook.com
 ([fe80::8dfd:f3e4:3935:2207%7]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 15:01:34 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        osalvador <osalvador@suse.de>, Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH -V10 2/6] NUMA balancing: optimize page placement for memory tiering system
Date:   Thu, 18 Nov 2021 10:01:26 -0500
X-Mailer: MailMate (1.14r5846)
Message-ID: <C9EB54B4-AA86-4473-AE04-95E3CC6F6E94@nvidia.com>
In-Reply-To: <20211116013522.140575-3-ying.huang@intel.com>
References: <20211116013522.140575-1-ying.huang@intel.com>
 <20211116013522.140575-3-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_D82A1751-6FD0-4576-B144-3B93524ACFDA_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:208:d4::19) To DM6PR12MB3819.namprd12.prod.outlook.com
 (2603:10b6:5:1c6::20)
MIME-Version: 1.0
Received: from [10.2.52.6] (216.228.112.21) by MN2PR04CA0006.namprd04.prod.outlook.com (2603:10b6:208:d4::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Thu, 18 Nov 2021 15:01:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55f5ce5d-ffc6-4e7e-4fca-08d9aaa45009
X-MS-TrafficTypeDiagnostic: DM6PR12MB4893:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4893610487A9B9237D482D6CC29B9@DM6PR12MB4893.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2twXRiGjwn0WAdUMB85YjIoTqhAlL6V2LPfglwi29AYrvFcnlhx8hA10z7vmWnYJ8Goc4jLwmwAnoT7k8Q2E7gExS1Swdz6291BQWGl5EWPMsBTcxM9HmHZfMb175ScDFy6HD6OG8j8SA0lzeWf0qaaVMvQQStryyVUMDKj1yprfFflhe8w7I+QhpCgKnBQaI6zTVZhFf2BkKufDcqsR/7Yewe9WXgCYzVIL8cmyTu4kHZcuAKdcCvgedJx6qw9fC2RGdu+ACL6ILojxc7GikqqBcYhgjYU2orsNSubM3FRrMt7N6tAkcMcj2FkxG0Q8oh6c0o6ZDqFJGBY04Xo5H4wAWPBZON6i5/tQeAS7NsaOxL+4A1NqSVmnkxLxy0HbfHoQuNwiFDsL0BcKTHXqLg/k/PqTJVmc8RN/Fpz0ch2pdUhxxTpsNle69AbEhx7CB0NsEMo7zFPH0tTjY8DyXKqvWDyHIEnKibZh57sHclW2KShMaZuTd00Qwr8mD+YK3Fy6JM/1Q1lfSYMAE7Lr2Th/HSAnoqH19qvv6UcEobK3oJwWValmLjfdhpAexw8HklyG1fmMXicRmapvXwyOu3+5aEuURiNzI3QaXa+QVs4k7uxnZC1PLEsiLw2f+P6enRqf+NSs1v3MyhUje8k5G/M9YuqfjEqlci6XtymuFKuGTE2PdqOYGBIdxqwaBVdpoXcJ9XDBxYKJxTHocNBQDlU3Hnk53f0UcHcX4acts2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3819.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6486002)(6666004)(8676002)(86362001)(186003)(2616005)(66946007)(316002)(54906003)(956004)(4326008)(16576012)(66556008)(66476007)(7416002)(5660300002)(83380400001)(6916009)(33656002)(30864003)(235185007)(36756003)(508600001)(8936002)(26005)(38100700002)(21480400003)(53546011)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X9Teo5vTQ0lKwSVMeuRoubgjilt71W5jvWKDxb/mwxWnXPgBW2r58PMUqye8?=
 =?us-ascii?Q?NfNlSWjg3ITl8yXGSZJ8z3VVuSbjAvMpSznu+i1LxXjce7tuCHrG6v2xGhpB?=
 =?us-ascii?Q?a8cBCKejn7OSDZj3rnN0N7GKEIqrtX5f8JlYjS/Kiv/jPrTam5ht0twuu6BY?=
 =?us-ascii?Q?OWhPmBNGecGf3w08OjP0d2lAxPCy6DoBjPGtNUDOYZwqFsr76OYZXpsR4Jr2?=
 =?us-ascii?Q?9HD2dtrdJ7+notnqImAmjLPyxoW/VJTUyP6VBGMOiGKGz3qGVTclNwN1dnLx?=
 =?us-ascii?Q?blZocsbl31qZgJVyVjNxKVjqQD+HY4GH4nP2Vz+sH//nI2D7r8yYWrGXNQoS?=
 =?us-ascii?Q?neJSwSnQSeGV4gxKW+0a0e9kEKQBPuTA422wbsgMepyo7tOkSPOZhkJumZyW?=
 =?us-ascii?Q?wNl9Uasis9Q26x4yDMD0GqWcL3k9aoCgEPQJETOBoYZBu5ixg4RAp3hyq8Pf?=
 =?us-ascii?Q?6VQu8cuDO6MTox1ALZjlcgdwn0987ZRv/TfXWM85HGtJlhj+j1+OQUtHj0JE?=
 =?us-ascii?Q?ertlncg9ODTMJZN5HjXNyRqUzxtw2VXbKvImKafVBIdg04oif8Ia0lGmuMtb?=
 =?us-ascii?Q?ZIOOPPqtQBoSunUwwJhrjPnX9GjDC/HQPffWOi3pepFKyykKj/qNXZckMP6E?=
 =?us-ascii?Q?Jljetj7A9BHuVuQZGjPXSKzTjkXCWgOtCPiYTrKBChEMIks45I7StSXq/qlz?=
 =?us-ascii?Q?Gpbrxj9emASRyx/XGfUy/znW7oGDsatYkPfeZuiXp82X1UO3mbCIaV2HzZ7p?=
 =?us-ascii?Q?21iCzfcbKFHsB4d4UTuoVjdpZHA0M6i2NL8VhU5FZXRqq2iVZ3+2FEpw0jtI?=
 =?us-ascii?Q?KopQZc+72tWFI39sq/wpUCrKp/iDAzDDa+HKsdUp/ErB6wWWNFvRBxO5apPa?=
 =?us-ascii?Q?FeMGShAA4cfBo7d8O75nxW3BZxuUjAUoHZnJpux/1kPbNr4/XRUhiYEuB0AU?=
 =?us-ascii?Q?2jXI8NDHXv1EkRingapUzBt5ojD0e8FOivxZQ9R/Xjlo6A72QBxV9+I/yJ1d?=
 =?us-ascii?Q?QkzyGi6gbgu36X35hTHlETw8V8C16hyGSwjinrvfQPi6rTlKDHFsdCF/N6Lq?=
 =?us-ascii?Q?qk0j/QLR0eg8NpQfLe4TQPQaMxRJ10x8UGM42pGtmfK2+dbPihmy0wTgClkb?=
 =?us-ascii?Q?5BfnSGui6aqZ57SAyq1SqfZKaqH9jOUFABUQyojU6FccSAcuQ8WVC0Pc26Zp?=
 =?us-ascii?Q?07b3cjJgt8rXcrDDpd2zCGxXK1DvaZi8elfGU8nPFOG57rlduO9iJHscuK08?=
 =?us-ascii?Q?lBdBm6t9tJkVhVU+Nv9lnrMZPpppkmVpzs4ajf9fAWAgxwIfZI0jFiu53DMw?=
 =?us-ascii?Q?H3fx0T1JIr0pJ9Ipdta4YfE/av3hs/BPt6uT7fKYCTlsgpykPJ9YoS9Z6wXJ?=
 =?us-ascii?Q?Ed3lejCq4yky5s92AatU5C1kWWgOheE7k1y7ueWSru9Sa+Pfmgm6Ekab9XUF?=
 =?us-ascii?Q?AXie19lWPcgsgvrFzqFRI5OB3gsEMHzfMYM4kf/2t/DPGNxI2doNAUHhtyJE?=
 =?us-ascii?Q?kEVL92X/Qr7ZL/omjyE/wWpOsgmiYU6fK1WhiHgcjxGI8s3X5TCT23sfLRB/?=
 =?us-ascii?Q?KfYq9xNogqjbuKcjQAY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f5ce5d-ffc6-4e7e-4fca-08d9aaa45009
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3819.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 15:01:34.5840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Z0jg59hvCyoAg05wlyn2rcuBST7fNbs+pnR3ZHM5scvUnhrRWOiXuby49iGqrlK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4893
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_D82A1751-6FD0-4576-B144-3B93524ACFDA_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 15 Nov 2021, at 20:35, Huang Ying wrote:

> With the advent of various new memory types, some machines will have
> multiple types of memory, e.g. DRAM and PMEM (persistent memory).  The
> memory subsystem of these machines can be called memory tiering
> system, because the performance of the different types of memory are
> usually different.
>
> In such system, because of the memory accessing pattern changing etc,
> some pages in the slow memory may become hot globally.  So in this
> patch, the NUMA balancing mechanism is enhanced to optimize the page
> placement among the different memory types according to hot/cold
> dynamically.
>
> In a typical memory tiering system, there are CPUs, fast memory and
> slow memory in each physical NUMA node.  The CPUs and the fast memory
> will be put in one logical node (called fast memory node), while the
> slow memory will be put in another (faked) logical node (called slow
> memory node).  That is, the fast memory is regarded as local while the
> slow memory is regarded as remote.  So it's possible for the recently
> accessed pages in the slow memory node to be promoted to the fast
> memory node via the existing NUMA balancing mechanism.
>
> The original NUMA balancing mechanism will stop to migrate pages if the=
 free
> memory of the target node will become below the high watermark.  This
> is a reasonable policy if there's only one memory type.  But this
> makes the original NUMA balancing mechanism almost not work to optimize=
 page
> placement among different memory types.  Details are as follows.
>
> It's the common cases that the working-set size of the workload is
> larger than the size of the fast memory nodes.  Otherwise, it's
> unnecessary to use the slow memory at all.  So in the common cases,
> there are almost always no enough free pages in the fast memory nodes,
> so that the globally hot pages in the slow memory node cannot be
> promoted to the fast memory node.  To solve the issue, we have 2
> choices as follows,
>
> a. Ignore the free pages watermark checking when promoting hot pages
>    from the slow memory node to the fast memory node.  This will
>    create some memory pressure in the fast memory node, thus trigger
>    the memory reclaiming.  So that, the cold pages in the fast memory
>    node will be demoted to the slow memory node.
>
> b. Make kswapd of the fast memory node to reclaim pages until the free
>    pages are a little more (about 10MB) than the high watermark.  Then,=

>    if the free pages of the fast memory node reaches high watermark, an=
d
>    some hot pages need to be promoted, kswapd of the fast memory node
>    will be waken up to demote some cold pages in the fast memory node t=
o
>    the slow memory node.  This will free some extra space in the fast
>    memory node, so the hot pages in the slow memory node can be
>    promoted to the fast memory node.

Why 10MB? Is 10MB big enough to avoid creating memory pressure on fast
memory? This number seems pretty ad-hoc and may only work well on your
test machine.

In theory, this extra free memory space should be related to page promoti=
on
throughput and kswapd demotion throughput, right? Patch 5 allows user
to adjust page promotion throughput, NUMA_BALANCING_PROMOTE_WATERMARK
at least can be something like X * numa_balancing_rate_limit_mbps.
Also, is there any way of measuring kswapd demotion throughput at boot
time? So we can take it into account too. Does this make sense?

>
> The choice "a" will create the memory pressure in the fast memory
> node.  If the memory pressure of the workload is high, the memory
> pressure may become so high that the memory allocation latency of the
> workload is influenced, e.g. the direct reclaiming may be triggered.
>
> The choice "b" works much better at this aspect.  If the memory
> pressure of the workload is high, the hot pages promotion will stop
> earlier because its allocation watermark is higher than that of the
> normal memory allocation.  So in this patch, choice "b" is
> implemented.
>
> In addition to the original page placement optimization among sockets,
> the NUMA balancing mechanism is extended to be used to optimize page
> placement according to hot/cold among different memory types.  So the
> sysctl user space interface (numa_balancing) is extended in a backward
> compatible way as follow, so that the users can enable/disable these
> functionality individually.
>
> The sysctl is converted from a Boolean value to a bits field.  The
> definition of the flags is,
>
> - 0x0: NUMA_BALANCING_DISABLED
> - 0x1: NUMA_BALANCING_NORMAL
> - 0x2: NUMA_BALANCING_MEMORY_TIERING
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: osalvador <osalvador@suse.de>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 29 ++++++++++++++-------=

>  include/linux/sched/sysctl.h                | 10 +++++++
>  kernel/sched/core.c                         | 21 ++++++++++++---
>  kernel/sysctl.c                             |  3 ++-
>  mm/migrate.c                                | 19 ++++++++++++--
>  mm/vmscan.c                                 | 16 ++++++++++++
>  6 files changed, 82 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentatio=
n/admin-guide/sysctl/kernel.rst
> index 426162009ce9..1974a559c10b 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -595,16 +595,23 @@ Documentation/admin-guide/kernel-parameters.rst).=

>  numa_balancing
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -Enables/disables automatic page fault based NUMA memory
> -balancing. Memory is moved automatically to nodes
> -that access it often.
> +Enables/disables and configure automatic page fault based NUMA memory
> +balancing.  Memory is moved automatically to nodes that access it
> +often.  The value to set can be the result to OR the following,
>
> -Enables/disables automatic NUMA memory balancing. On NUMA machines, th=
ere
> -is a performance penalty if remote memory is accessed by a CPU. When t=
his
> -feature is enabled the kernel samples what task thread is accessing me=
mory
> -by periodically unmapping pages and later trapping a page fault. At th=
e
> -time of the page fault, it is determined if the data being accessed sh=
ould
> -be migrated to a local memory node.
> +=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +0x0 NUMA_BALANCING_DISABLED
> +0x1 NUMA_BALANCING_NORMAL
> +0x2 NUMA_BALANCING_MEMORY_TIERING
> +=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Or NUMA_BALANCING_NORMAL to optimize page placement among different
> +NUMA nodes to reduce remote accessing.  On NUMA machines, there is a
> +performance penalty if remote memory is accessed by a CPU. When this
> +feature is enabled the kernel samples what task thread is accessing
> +memory by periodically unmapping pages and later trapping a page
> +fault. At the time of the page fault, it is determined if the data
> +being accessed should be migrated to a local memory node.
>
>  The unmapping of pages and trapping faults incur additional overhead t=
hat
>  ideally is offset by improved memory locality but there is no universa=
l
> @@ -615,6 +622,10 @@ faults may be controlled by the `numa_balancing_sc=
an_period_min_ms,
>  numa_balancing_scan_delay_ms, numa_balancing_scan_period_max_ms,
>  numa_balancing_scan_size_mb`_, and numa_balancing_settle_count sysctls=
=2E
>
> +Or NUMA_BALANCING_MEMORY_TIERING to optimize page placement among
> +different types of memory (represented as different NUMA nodes) to
> +place the hot pages in the fast memory.  This is implemented based on
> +unmapping and page fault too.
>
>  numa_balancing_scan_period_min_ms, numa_balancing_scan_delay_ms, numa_=
balancing_scan_period_max_ms, numa_balancing_scan_size_mb
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.=
h
> index 304f431178fd..bc54c1d75d6d 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -35,6 +35,16 @@ enum sched_tunable_scaling {
>  	SCHED_TUNABLESCALING_END,
>  };
>
> +#define NUMA_BALANCING_DISABLED		0x0
> +#define NUMA_BALANCING_NORMAL		0x1
> +#define NUMA_BALANCING_MEMORY_TIERING	0x2
> +
> +#ifdef CONFIG_NUMA_BALANCING
> +extern int sysctl_numa_balancing_mode;
> +#else
> +#define sysctl_numa_balancing_mode	0
> +#endif
> +
>  /*
>   *  control realtime throttling:
>   *
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3c9b0fda64ac..5dcabc98432f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4265,7 +4265,9 @@ DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
>
>  #ifdef CONFIG_NUMA_BALANCING
>
> -void set_numabalancing_state(bool enabled)
> +int sysctl_numa_balancing_mode;
> +
> +static void __set_numabalancing_state(bool enabled)
>  {
>  	if (enabled)
>  		static_branch_enable(&sched_numa_balancing);
> @@ -4273,13 +4275,22 @@ void set_numabalancing_state(bool enabled)
>  		static_branch_disable(&sched_numa_balancing);
>  }
>
> +void set_numabalancing_state(bool enabled)
> +{
> +	if (enabled)
> +		sysctl_numa_balancing_mode =3D NUMA_BALANCING_NORMAL;
> +	else
> +		sysctl_numa_balancing_mode =3D NUMA_BALANCING_DISABLED;
> +	__set_numabalancing_state(enabled);
> +}
> +
>  #ifdef CONFIG_PROC_SYSCTL
>  int sysctl_numa_balancing(struct ctl_table *table, int write,
>  			  void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	struct ctl_table t;
>  	int err;
> -	int state =3D static_branch_likely(&sched_numa_balancing);
> +	int state =3D sysctl_numa_balancing_mode;
>
>  	if (write && !capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> @@ -4289,8 +4300,10 @@ int sysctl_numa_balancing(struct ctl_table *tabl=
e, int write,
>  	err =3D proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
>  	if (err < 0)
>  		return err;
> -	if (write)
> -		set_numabalancing_state(state);
> +	if (write) {
> +		sysctl_numa_balancing_mode =3D state;
> +		__set_numabalancing_state(state);
> +	}
>  	return err;
>  }
>  #endif
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 083be6af29d7..a1be94ea80ba 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -115,6 +115,7 @@ static int sixty =3D 60;
>
>  static int __maybe_unused neg_one =3D -1;
>  static int __maybe_unused two =3D 2;
> +static int __maybe_unused three =3D 3;
>  static int __maybe_unused four =3D 4;
>  static unsigned long zero_ul;
>  static unsigned long one_ul =3D 1;
> @@ -1808,7 +1809,7 @@ static struct ctl_table kern_table[] =3D {
>  		.mode		=3D 0644,
>  		.proc_handler	=3D sysctl_numa_balancing,
>  		.extra1		=3D SYSCTL_ZERO,
> -		.extra2		=3D SYSCTL_ONE,
> +		.extra2		=3D &three,
>  	},
>  #endif /* CONFIG_NUMA_BALANCING */
>  	{
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b7c27abb0e5c..286c84c014dd 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -50,6 +50,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/oom.h>
>  #include <linux/memory.h>
> +#include <linux/sched/sysctl.h>
>
>  #include <asm/tlbflush.h>
>
> @@ -2103,16 +2104,30 @@ static int numamigrate_isolate_page(pg_data_t *=
pgdat, struct page *page)
>  {
>  	int page_lru;
>  	int nr_pages =3D thp_nr_pages(page);
> +	int order =3D compound_order(page);
>
> -	VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
> +	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
>
>  	/* Do not migrate THP mapped by multiple processes */
>  	if (PageTransHuge(page) && total_mapcount(page) > 1)
>  		return 0;
>
>  	/* Avoid migrating to a node that is nearly full */
> -	if (!migrate_balanced_pgdat(pgdat, nr_pages))
> +	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
> +		int z;
> +
> +		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||=

> +		    !numa_demotion_enabled)
> +			return 0;
> +		if (next_demotion_node(pgdat->node_id) =3D=3D NUMA_NO_NODE)
> +			return 0;
> +		for (z =3D pgdat->nr_zones - 1; z >=3D 0; z--) {
> +			if (populated_zone(pgdat->node_zones + z))
> +				break;
> +		}
> +		wakeup_kswapd(pgdat->node_zones + z, 0, order, ZONE_MOVABLE);
>  		return 0;
> +	}
>
>  	if (isolate_lru_page(page))
>  		return 0;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fb9584641ac7..8ec955404bd1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -56,6 +56,7 @@
>
>  #include <linux/swapops.h>
>  #include <linux/balloon_compaction.h>
> +#include <linux/sched/sysctl.h>
>
>  #include "internal.h"
>
> @@ -3908,6 +3909,12 @@ static bool pgdat_watermark_boosted(pg_data_t *p=
gdat, int highest_zoneidx)
>  	return false;
>  }
>
> +/*
> + * Keep the free pages on fast memory node a little more than the high=

> + * watermark to accommodate the promoted pages.
> + */
> +#define NUMA_BALANCING_PROMOTE_WATERMARK	(10UL * 1024 * 1024 >> PAGE_S=
HIFT)
> +
>  /*
>   * Returns true if there is an eligible zone balanced for the request =
order
>   * and highest_zoneidx
> @@ -3929,6 +3936,15 @@ static bool pgdat_balanced(pg_data_t *pgdat, int=
 order, int highest_zoneidx)
>  			continue;
>
>  		mark =3D high_wmark_pages(zone);
> +		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
> +		    numa_demotion_enabled &&
> +		    next_demotion_node(pgdat->node_id) !=3D NUMA_NO_NODE) {
> +			unsigned long promote_mark;
> +
> +			promote_mark =3D min(NUMA_BALANCING_PROMOTE_WATERMARK,
> +					   pgdat->node_present_pages >> 6);
> +			mark +=3D promote_mark;
> +		}
>  		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
>  			return true;
>  	}
> -- =

> 2.30.2

--
Best Regards,
Yan, Zi

--=_MailMate_D82A1751-6FD0-4576-B144-3B93524ACFDA_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmGWascPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKSsUP/A3na8W+RQ8f3j1JTSxFU4FizwG/QK5p4Vp3
I2XohSK+/ExAJwBE+/hepp9gSTYAzE2TUMUIGh1kytxnecBGqjs2FKFzf4XDiZUP
liZpaja/vRul/d+GpK8WWM90sOgass9K8v9W57NrR4kmBe3U3pBv9htR3ldGNX6b
1XJv1ikVQhlfWFvCZaQO/UsMD1w613a4kvI1HUW+OM/L48PmcoqpFIFfOt8H0eIv
LXfoTAbYBQPPpKk0U8wN5eztLvkCU93S8PHNFPFcZd/7keyF5z5PRYxWrfxw/Xxt
mrpYy16OKD39ETJMIgNDy3wjCQgo6n7M6w82Yr7XNf4Nm2UitXuZDGhaXjsujVWQ
pzylZe/BZe2ASv0k2A5Zy2IvKIIanY1EwgumTFjHatUScaWvSQ9743lEsR/+izKT
gaaTvEqborMpkEXdcqWtwYFZ1OhaEiuGW0YvFV1QFCcMgpgrJvtvch+vhiJAVBlz
varWIiYaVth2zFRQaFM8uaBSkgW1Y2qMjrVpg1ydbsYMO+HjSLUzgyg8kT1hJnet
7BsMDLHIy3+nwkyxNqqLOz7oZXYwxFY2lqsajL0EthtdEnP1LAckLJMlUquj3pCd
vc0uO2jJnMuJ9azwyV5MFnGdojF4RN8Rlb7nC4UN/fqfDTsJ8JWGEpB8ic+2ZVcr
hXNaN9BN
=2SEO
-----END PGP SIGNATURE-----

--=_MailMate_D82A1751-6FD0-4576-B144-3B93524ACFDA_=--
