Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C7A3ACE62
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhFRPQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:16:38 -0400
Received: from mail-dm3nam07on2067.outbound.protection.outlook.com ([40.107.95.67]:13089
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231461AbhFRPQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:16:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1GFXIfJ5K1sTWvOwn6GSN6FDI1L9u1yajq7DL3dpeWI0AqaL4rJQCfZ2PPengjKn6T20UpqCyYGRm7GFWzlwlnIHZfPt7SCI61giLDl2jA+9By9IMAuWYsmrZCy5rXq/RhhjkqzUNh4yh3CYoeTjWuGyanwGaCQlKoHEdfHdYAXwV/9dcVAhci0bOv32DF8m1upE7KWm9gSXNgtVq1q3JGvULKc07/BkdBxLMkIVuqA39eMvVnie3kaowVooVpTSMFXT8bX34619GOZTUc4G56JMQ9/hsWVuWUpsAjVLN6OR6/BdWpfVeDxrXM37aW6dNGjodulMEOxmHShVC8oWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxSNDh4uIz4Z+Z0J1aNZO4Q+26YpxgcZkVZ8gfDHLDc=;
 b=bVgQFSbawsK4+sJ0FX2LD28UTtuSc6u3saA/m0G3n0uoGI+V7fMIarxxteQWuObzcfZLGUzcVqaMbVVb4F0lh67pwUmQ8XWCMdvM4RQ1yuiLW5QOx2YNzO8v7/ZuAmHEBQ/hfdHvYsREAHsF4Bc/YdpFpzKb1eYnTSMT9sSPm5djE5nRtpwyWKsmNFFs7pqM1zr2U+74nK0Rk9UNW3Z7BVLLDYSLfIhHsCbMZbGYAb30yy3wv5rEPBGYTsO3OjmfhuD3i6FGAMaXiNPtKQVQ/SfgAe7vC3sZL9URr+1+RRL7zF/GRl98kLsfl/0shFRAdhmlA/vUpSzTzNZ/8JIJsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxSNDh4uIz4Z+Z0J1aNZO4Q+26YpxgcZkVZ8gfDHLDc=;
 b=nDQGqfBEFqyHk0cEuLKNVJi0CdZ32+mgyjampp3hsoG9LuDcv544USJezCspZ3qix/Eiqc7wlzTQCBt6t/Ds3eaTchP0q/ekFK2eLWVF8ZIZGzQvGPEA8Jg9+LKWeBwfrj0XF97qur8pN8poUKVAQb500YH/kJBGhSj56eAZcqxbT0gJfVvUqHNlh6oV05KltU9RM2WqyykI0LR69NKQn7DWZ9ccwUtOR60saE8m40Wpf8gIQ9BaRZk4yarhfyjBLSo8+1mErQ0ejWdse34FE5n5U+yLuoEq7Cp/QX2wkYNTa8QLMSA+MKTnVCFhcR9BXSt9KfZsgvodkgVZYjYQhQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4519.namprd12.prod.outlook.com (2603:10b6:208:262::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Fri, 18 Jun
 2021 15:14:23 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 15:14:23 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        osalvador <osalvador@suse.de>
Subject: Re: [PATCH -V8 02/10] mm/numa: automatically generate node migration order
Date:   Fri, 18 Jun 2021 11:14:16 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <79397FE3-4B08-4DE5-8468-C5CAE36A3E39@nvidia.com>
In-Reply-To: <20210618061537.434999-3-ying.huang@intel.com>
References: <20210618061537.434999-1-ying.huang@intel.com>
 <20210618061537.434999-3-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_71124D38-3150-41F9-B972-94840D494E3E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: MN2PR16CA0035.namprd16.prod.outlook.com
 (2603:10b6:208:134::48) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.58.56] (216.228.112.21) by MN2PR16CA0035.namprd16.prod.outlook.com (2603:10b6:208:134::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 15:14:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0c33d78-54c1-4c21-df93-08d9326bc108
X-MS-TrafficTypeDiagnostic: MN2PR12MB4519:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45192D367E700ECA7C8CB1EDC20D9@MN2PR12MB4519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YpGqzxHvbpn3gQiHQ3/rHCTOG1e8O35vP489lBvwlefsJpEGi4McpNScnd+RZt4u5y7bCpW6T1WKJEvlfeIScjAwxOqDsbIZ0DtQr2z9uxzQSp+iykMSLT1w/UZQbxw9sLv+QkFJr3oJRSose3+B71eja5HlsWHFr9+9gfEZoqJBuia8Y8eJ7KWqs1OwdMyspSpgkwGbeTM+kyXrMAk4+X+TNeru7ip8zaGDAubNjRPruhjBj6v0E11OYcM+/XfdjCprHIoe7UtKCiil78OL2ET7Gzjot+0rzb0NKQX5dsZwwejGs+Ck5w8m4QRP/6Mcy6D4mkjsRo440RtFfwxrZQskrTYTHF+aXqShI2h6dPFiVnHyl4fLnrQ7q1ZrUaNDQUReZ2vzrTzZqEdeu5HE0+zUUJHJBQFkvrk0vZQctz2PEPjm7iNj6fNfclJeJR1/Xb5/Zs6d0SHTvZ/0FccZSyea6SNkyODcBSWkuia1bfAMxiqvZwfriY6XOo0ciYlw1kjzviBsku0lKIvz5SkvqnDSdSMy0wBBvaJnjAicc5EdJGgkuCShnzL+BwCCw6ZUutYr11OM4nuyGDRCh3/SGoiPCIEucOiQNUbRI78AZ4+SDFp7q5i9HE8FJJnwTSet8Hi2NDA0GQojWlEQBqme9he0J2oKmvEUFXRiTK9owX0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(186003)(16526019)(6916009)(66556008)(33964004)(66946007)(66476007)(7416002)(2616005)(956004)(21480400003)(235185007)(26005)(5660300002)(8936002)(33656002)(6666004)(54906003)(478600001)(53546011)(86362001)(316002)(30864003)(83380400001)(6486002)(36756003)(16576012)(4326008)(2906002)(8676002)(38100700002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHNNV0FhNHJwNzl3ZWtIRFl0TnJrcUEvRHZNalFvSGJFbnFRck8vaGRqMElE?=
 =?utf-8?B?Qks0Yk4vcVpQMzdrbkoxdElPNU1vNlB4ZHdmbHljeVcrZEJrWW5OUVVWWU03?=
 =?utf-8?B?b21PUWJyaEhRR2k0cEtsSTFNMWE5RHBUaVlYaW9xS2w5OU84V0VrK2FZTElJ?=
 =?utf-8?B?RmZSQkVtZzJsYjhtTU9wRmFWb0pjTWFrNTNzN2ZRYXlVV25tMlBZbWNtT0Yy?=
 =?utf-8?B?WVhaNG9sTVpyTWkwOEFSS0o3VENFV1pPRUpJeWpIcFV4SUhMT21mL0l4NUtn?=
 =?utf-8?B?N1A2ZzFaaDVtUjFLclUwSDBLNjR2SEl2Z1RvcGhPekViWHpIeW5jYlR0WjUx?=
 =?utf-8?B?Z1FpTUdTS0FzYlNSLzFLMm9xS01PQVhaR21BTms0R0RwUXRZUE1ETGt3OTJV?=
 =?utf-8?B?SDRKVVFZeFBnR3ZhTzZ4aXIrYTVER2ZsWS9pRkcya0ozUDQ1NHU2ZGYxMHJM?=
 =?utf-8?B?UU9WQW43ZGhXUmg0QXA4VnZHWW15amtuNnpJeUczeXAxY3hwUS9yekVBdjV6?=
 =?utf-8?B?Sk96Sk5hYlpuYXlpQTdUWlc2TG1NcllWN1ZXNnA5Mm4yWUtXTkxObmZFbmhO?=
 =?utf-8?B?RjVaME5tSjFMVmpDUDNkWmZEVE9kTzhTVDcrc2hwRExPNER0QStRQkwzRWhS?=
 =?utf-8?B?YXpOWmwxUENPKzdrbUtrZmIvKy9hMGNvNHJaY3FLYWw3QmxqSER5R05NU0ZH?=
 =?utf-8?B?cVVzL0RheVlzSTZ1dGNqL3VzbmJ1WVluRWNRTFZuNUVtbk5vSG16cFd1cFQz?=
 =?utf-8?B?SjYyUW1BWnkxcDN4aGZiNXRTU1F5Q1hrajBSSzVMQlViUldSR3dMNWhnbUU3?=
 =?utf-8?B?MU9xMkphL1VNYWZMYzhmcS9yQTRzVVFRWG5tZXJ5ZTVwdVlDc1Fuc1JuYXN2?=
 =?utf-8?B?Y2tqZ0dra3FUWUViTEEzQ2oxSlJzZzJUcEZYTFNhbzBodG9jQ2hOMkQyVmhj?=
 =?utf-8?B?MHZOV2R0bS9vRnk4S1ZsWjh3V1ZyL1o2VHpoTHdSOXdkUm5CRlJUQlgzbCsw?=
 =?utf-8?B?NHQzOEprazMyWFJlQzlsck9QY1VyVFBPT3JKME5Jb3BIVjJxNGJESHlZblFI?=
 =?utf-8?B?QmxWT1FnV1ZyMTZhVHNCUmtPdm1EUEc5eGNsdGxTOExrU2k3VFFhMHBDUWFC?=
 =?utf-8?B?M1BXRVN4SVVYTmYyUE5LTlFNOTBLaERjM1dWMy9QTGRKci94VGxYSURZejVW?=
 =?utf-8?B?Z05qYzJHMmNpNWl3OGc2eURtREYxeFdudm01eDVLSDBhU0taMmZwY2piMEVS?=
 =?utf-8?B?cEE0R0hmTVZQb21nWFRLV3prTkpqQUg0RDBIVnlqcW91K0ZIeWRkUG5Tb2hE?=
 =?utf-8?B?Q2hFZ2FiK0thMnExbVVOeEdTWUdZemF0c1V6K0tmdG5VVmtadTF0ejZmdG9x?=
 =?utf-8?B?UGNkcW54VThFNGEzMXVYdUh3OGsyQzVGb3RxaFBHUU5jVmJ5TmU1V0RYeURN?=
 =?utf-8?B?eStmSHQwUGJHODVxYUwzSVJpWXpRWTFOaGJsdXc2MkR0NHVZT1E1djR1RXlZ?=
 =?utf-8?B?SEJ6MWZuS0xRenF0M21LSERPQXBqS3JhbVZTK0IvZW4rMHFvN2FGV1l2bVFR?=
 =?utf-8?B?a0xHcmN6VVpTOEY1WnlDcXVRS1dGRFdBQVc4SG4xcHY2K2loMkRkd0xrZFZW?=
 =?utf-8?B?RFZ0WmduUmprai9oUSs2RlRnc3NiS0tzU091WDFkRUJodTJ6UjlTZGJ6N2s1?=
 =?utf-8?B?Qm9ld09kYkNNRVJkbDZydzNpNFByKzN1YUZsaVlMbkg4aTNYdkJ1MnhJMFpB?=
 =?utf-8?Q?Ka4C4xalj4nI+D/zDU6S6GSJ+p0Ce0zIh3ukXpI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c33d78-54c1-4c21-df93-08d9326bc108
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 15:14:23.4037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5ZPqpd6G/d8QVzm8mqpiWPbm/lSHKNpnz0BnWiq2yTKKbjkmoTHpa4k2UQVsvX3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4519
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_71124D38-3150-41F9-B972-94840D494E3E_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 18 Jun 2021, at 2:15, Huang Ying wrote:

> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> When memory fills up on a node, memory contents can be
> automatically migrated to another node.  The biggest problems are
> knowing when to migrate and to where the migration should be
> targeted.
>
> The most straightforward way to generate the "to where" list would
> be to follow the page allocator fallback lists.  Those lists
> already tell us if memory is full where to look next.  It would
> also be logical to move memory in that order.
>
> But, the allocator fallback lists have a fatal flaw: most nodes
> appear in all the lists.  This would potentially lead to migration
> cycles (A->B, B->A, A->B, ...).
>
> Instead of using the allocator fallback lists directly, keep a
> separate node migration ordering.  But, reuse the same data used
> to generate page allocator fallback in the first place:
> find_next_best_node().
>
> This means that the firmware data used to populate node distances
> essentially dictates the ordering for now.  It should also be
> architecture-neutral since all NUMA architectures have a working
> find_next_best_node().
>
> The protocol for node_demotion[] access and writing is not
> standard.  It has no specific locking and is intended to be read
> locklessly.  Readers must take care to avoid observing changes
> that appear incoherent.  This was done so that node_demotion[]
> locking has no chance of becoming a bottleneck on large systems
> with lots of CPUs in direct reclaim.
>
> This code is unused for now.  It will be called later in the
> series.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>
>
> --
>
> Changes from 20200122:
>  * Add big node_demotion[] comment
> Changes from 20210302:
>  * Fix typo in node_demotion[] comment
> ---
>  mm/internal.h   |   5 ++
>  mm/migrate.c    | 175 +++++++++++++++++++++++++++++++++++++++++++++++-=

>  mm/page_alloc.c |   2 +-
>  3 files changed, 180 insertions(+), 2 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 2f1182948aa6..0344cd78e170 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -522,12 +522,17 @@ static inline void mminit_validate_memmodel_limit=
s(unsigned long *start_pfn,
>
>  #ifdef CONFIG_NUMA
>  extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
> +extern int find_next_best_node(int node, nodemask_t *used_node_mask);
>  #else
>  static inline int node_reclaim(struct pglist_data *pgdat, gfp_t mask,
>  				unsigned int order)
>  {
>  	return NODE_RECLAIM_NOSCAN;
>  }
> +static inline int find_next_best_node(int node, nodemask_t *used_node_=
mask)
> +{
> +	return NUMA_NO_NODE;
> +}
>  #endif
>
>  extern int hwpoison_filter(struct page *p);
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 6cab668132f9..111f8565f75d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1136,6 +1136,44 @@ static int __unmap_and_move(struct page *page, s=
truct page *newpage,
>  	return rc;
>  }
>
> +
> +/*
> + * node_demotion[] example:
> + *
> + * Consider a system with two sockets.  Each socket has
> + * three classes of memory attached: fast, medium and slow.
> + * Each memory class is placed in its own NUMA node.  The
> + * CPUs are placed in the node with the "fast" memory.  The
> + * 6 NUMA nodes (0-5) might be split among the sockets like
> + * this:
> + *
> + *	Socket A: 0, 1, 2
> + *	Socket B: 3, 4, 5
> + *
> + * When Node 0 fills up, its memory should be migrated to
> + * Node 1.  When Node 1 fills up, it should be migrated to
> + * Node 2.  The migration path start on the nodes with the
> + * processors (since allocations default to this node) and
> + * fast memory, progress through medium and end with the
> + * slow memory:
> + *
> + *	0 -> 1 -> 2 -> stop
> + *	3 -> 4 -> 5 -> stop
> + *
> + * This is represented in the node_demotion[] like this:
> + *
> + *	{  1, // Node 0 migrates to 1
> + *	   2, // Node 1 migrates to 2
> + *	  -1, // Node 2 does not migrate
> + *	   4, // Node 3 migrates to 4
> + *	   5, // Node 4 migrates to 5
> + *	  -1} // Node 5 does not migrate
> + */
> +
> +/*
> + * Writes to this array occur without locking.  READ_ONCE()
> + * is recommended for readers to ensure consistent reads.
> + */
>  static int node_demotion[MAX_NUMNODES] __read_mostly =3D
>  	{[0 ...  MAX_NUMNODES - 1] =3D NUMA_NO_NODE};
>
> @@ -1150,7 +1188,13 @@ static int node_demotion[MAX_NUMNODES] __read_mo=
stly =3D
>   */
>  int next_demotion_node(int node)
>  {
> -	return node_demotion[node];
> +	/*
> +	 * node_demotion[] is updated without excluding
> +	 * this function from running.  READ_ONCE() avoids
> +	 * reading multiple, inconsistent 'node' values
> +	 * during an update.
> +	 */
> +	return READ_ONCE(node_demotion[node]);
>  }

Is it necessary to have two separate patches to add node_demotion and
next_demotion_node() then modify it immediately? Maybe merge Patch 1 into=
 2?

Hmm, I just checked Patch 3 and it changes node_demotion again and uses R=
CU.
I guess it might be much simpler to just introduce node_demotion with RCU=

in this patch and Patch 3 only takes care of hotplug events.

>
>  /*
> @@ -3144,3 +3188,132 @@ void migrate_vma_finalize(struct migrate_vma *m=
igrate)
>  }
>  EXPORT_SYMBOL(migrate_vma_finalize);
>  #endif /* CONFIG_DEVICE_PRIVATE */
> +
> +/* Disable reclaim-based migration. */
> +static void disable_all_migrate_targets(void)
> +{
> +	int node;
> +
> +	for_each_online_node(node)
> +		node_demotion[node] =3D NUMA_NO_NODE;
> +}
> +
> +/*
> + * Find an automatic demotion target for 'node'.
> + * Failing here is OK.  It might just indicate
> + * being at the end of a chain.
> + */
> +static int establish_migrate_target(int node, nodemask_t *used)
> +{
> +	int migration_target;
> +
> +	/*
> +	 * Can not set a migration target on a
> +	 * node with it already set.
> +	 *
> +	 * No need for READ_ONCE() here since this
> +	 * in the write path for node_demotion[].
> +	 * This should be the only thread writing.
> +	 */
> +	if (node_demotion[node] !=3D NUMA_NO_NODE)
> +		return NUMA_NO_NODE;
> +
> +	migration_target =3D find_next_best_node(node, used);
> +	if (migration_target =3D=3D NUMA_NO_NODE)
> +		return NUMA_NO_NODE;
> +
> +	node_demotion[node] =3D migration_target;
> +
> +	return migration_target;
> +}
> +
> +/*
> + * When memory fills up on a node, memory contents can be
> + * automatically migrated to another node instead of
> + * discarded at reclaim.
> + *
> + * Establish a "migration path" which will start at nodes
> + * with CPUs and will follow the priorities used to build the
> + * page allocator zonelists.
> + *
> + * The difference here is that cycles must be avoided.  If
> + * node0 migrates to node1, then neither node1, nor anything
> + * node1 migrates to can migrate to node0.
> + *
> + * This function can run simultaneously with readers of
> + * node_demotion[].  However, it can not run simultaneously
> + * with itself.  Exclusion is provided by memory hotplug events
> + * being single-threaded.
> + */
> +static void __set_migration_target_nodes(void)
> +{
> +	nodemask_t next_pass	=3D NODE_MASK_NONE;
> +	nodemask_t this_pass	=3D NODE_MASK_NONE;
> +	nodemask_t used_targets =3D NODE_MASK_NONE;
> +	int node;
> +
> +	/*
> +	 * Avoid any oddities like cycles that could occur
> +	 * from changes in the topology.  This will leave
> +	 * a momentary gap when migration is disabled.
> +	 */
> +	disable_all_migrate_targets();
> +
> +	/*
> +	 * Ensure that the "disable" is visible across the system.
> +	 * Readers will see either a combination of before+disable
> +	 * state or disable+after.  They will never see before and
> +	 * after state together.
> +	 *
> +	 * The before+after state together might have cycles and
> +	 * could cause readers to do things like loop until this
> +	 * function finishes.  This ensures they can only see a
> +	 * single "bad" read and would, for instance, only loop
> +	 * once.
> +	 */
> +	smp_wmb();
> +
> +	/*
> +	 * Allocations go close to CPUs, first.  Assume that
> +	 * the migration path starts at the nodes with CPUs.
> +	 */
> +	next_pass =3D node_states[N_CPU];

Is there a plan of allowing user to change where the migration
path starts? Or maybe one step further providing an interface
to allow user to specify the demotion path. Something like
/sys/devices/system/node/node*/node_demotion.


> +again:
> +	this_pass =3D next_pass;
> +	next_pass =3D NODE_MASK_NONE;
> +	/*
> +	 * To avoid cycles in the migration "graph", ensure
> +	 * that migration sources are not future targets by
> +	 * setting them in 'used_targets'.  Do this only
> +	 * once per pass so that multiple source nodes can
> +	 * share a target node.
> +	 *
> +	 * 'used_targets' will become unavailable in future
> +	 * passes.  This limits some opportunities for
> +	 * multiple source nodes to share a destination.
> +	 */
> +	nodes_or(used_targets, used_targets, this_pass);
> +	for_each_node_mask(node, this_pass) {
> +		int target_node =3D establish_migrate_target(node, &used_targets);
> +
> +		if (target_node =3D=3D NUMA_NO_NODE)
> +			continue;
> +
> +		/* Visit targets from this pass in the next pass: */
> +		node_set(target_node, next_pass);
> +	}
> +	/* Is another pass necessary? */
> +	if (!nodes_empty(next_pass))
> +		goto again;
> +}
> +
> +/*
> + * For callers that do not hold get_online_mems() already.
> + */
> +__maybe_unused // <- temporay to prevent warnings during bisects
> +static void set_migration_target_nodes(void)
> +{
> +	get_online_mems();
> +	__set_migration_target_nodes();
> +	put_online_mems();
> +}
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d1f5de1c1283..e033ae2e8bce 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5973,7 +5973,7 @@ static int node_load[MAX_NUMNODES];
>   *
>   * Return: node id of the found node or %NUMA_NO_NODE if no node is fo=
und.
>   */
> -static int find_next_best_node(int node, nodemask_t *used_node_mask)
> +int find_next_best_node(int node, nodemask_t *used_node_mask)
>  {
>  	int n, val;
>  	int min_val =3D INT_MAX;
> -- =

> 2.30.2


=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_71124D38-3150-41F9-B972-94840D494E3E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmDMuEkPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKTCoQAJkLbt25Z2lznoge944fugJzEh7ihLSUfn9N
5Oj3flvSutw17u8QCCenljNwW1YIU/fHG2j1Ggp3+ZgV3YoiT3U/oouu15O9zC1u
qGfP6Emv7rqre9mtVP7WAhbWk+FGoK5pY5YtYqsXHXZLmItO1OqAdci+AzpoP5NW
18VgsyFRPcpPGlb9st2WeZWMNXXXgI6BwqKnci18AEeocP+gXbM1WkdOxDt+zXTC
ghkeKlaU5yfKMXl81DV4Vw76weCDvpd7l27Irl4hJP1yF0VqsWy1WTxrtg7DrQ8j
UUOkPh8rdUxFWlhmgzlJiDY/wNC2ru5wl1PDy3qvgD0gVGZlIlum2QyCysfco4UB
crLbhgSn86rzpn2E9Ck64KNwHwnTNl/PiVw8YTg0izeqU+r7RyKAX1PKizOWPdVF
c40wCbSlpyIz19CmhqiqVQZssdE1bSxiRl45s/u2q2txJ7KfKFYSyZmJt09DoMhn
fO4jI18xSOufwg44T2HH9IdKIOiF97k4sSu+c6mn1cNy78W9sBNEyRw2eMPc6zHh
c/NsmhvZfc9AGzSSHak5WA7Wl+ol0nP0judY4TPIdV+4OMvEc0mq+wsXgpD+5YWu
R2bwtdzf0jPgSZM56Q0WAJ6Hw05DAh/5zfA+98kJNR1sHIgI/0QeH1gtxK2D1zbp
vxJPWamU
=+TRi
-----END PGP SIGNATURE-----

--=_MailMate_71124D38-3150-41F9-B972-94840D494E3E_=--
