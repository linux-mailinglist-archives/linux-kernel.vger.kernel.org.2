Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ED93CA4C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhGOR4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:56:00 -0400
Received: from mail-mw2nam10on2042.outbound.protection.outlook.com ([40.107.94.42]:22881
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235859AbhGORz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:55:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRsnjl2GLuacc+aRYpGlOh6S0msNKYMNCdmfpzM0iJyLq5OTwIFqi19LsQ1/3Bc9xpB3m71wjr6uNaJyCQQVDZnRUnsB6NH8xN+TZC3iY3m53u+GDtHrvr4SRljQLKcwH8Pl9zK59ZWNMFbXxPRoeCVN6F/HRX/Fv59HnRQRKl52TnV02AqIJjL5K28Yvm03sJNnHm89mZTkhLOyR73mamtrgK6+TerTCo56VnYHYx/AKghQ0vEjzDUo5VdaxLyRhf83gpvAi3tOQ4Qi6Pvv4MoCOB5JfYHmHfueTjOoTp+Xth29X/byM54KvsgzlULWa42uu0WN3ZhwHh7wffSiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHGbjgat4NFqgkyB/3j90mnnuhFQHp9NaeBgzZdzN+c=;
 b=Zu4La3KinhAjyOYJ0GhNC3kMzvL73W53kMFak3VUzwuhZgECMVuD7suiZwfyWB1Er/3DClgQmoTvMKQMD2TgrdFjmRcPz/CeDe9tLyaWbyzWMGesOsP7Hev6ZteeGyZtdY17/jAKowUqm44fENdd2Yb1kLIHrk6Af1oc5F/GBRkuE4ZVRKKIUl034zthiRwRXYVtfhYjdtwybGldK/uK7FzITc/S2hmalhCPaqrJ7U8r7pkMdAvvQOt6TMF0YQgYqx9aJG53C84yRP0SvzwQuloNGUslld4SwO/DyY1GevKRZzR3vXUbfr8wj5d9QOcDRq6PzDHsF/Gg7HGz/1L5rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHGbjgat4NFqgkyB/3j90mnnuhFQHp9NaeBgzZdzN+c=;
 b=fWeewICmVjlXXjfS6lFWle8IDUoh4kV8JUyZ0FxqRD8ZqBrzVchfKZiVsUXG9H1PDAqJrtXtBo/FbS8IXKQYhjZNHPXNr1sEQhPu1ZmVPfIMys0SKAcknv9FkHnUOB7+nHOfORr4r96TosGI6Lz07wkt4S5U0nr1KLerV8WWN34X+yaCzRT+ZotqRq3WXgm3rl28WGvlT7ITWXlnTKikKjwF9Llfqy0zwKfWlDCs8fKa16CfS+/rxCPUO7mB7allCRGsnM3L9CM8jApqNCkFgiwsIEHPOA6BUXAj60DT0FuhaiwBevq7GJmZW6uINDMB1gwhEqAoiqFT6BEQpXHrug==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 17:53:04 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 17:53:04 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH -V10 1/9] mm/numa: automatically generate node migration order
Date:   Thu, 15 Jul 2021 13:52:46 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <54FB91E8-C415-439F-988C-292B85F9794D@nvidia.com>
In-Reply-To: <20210715055145.195411-2-ying.huang@intel.com>
References: <20210715055145.195411-1-ying.huang@intel.com>
 <20210715055145.195411-2-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_57AFD51D-3D2E-469C-8555-7D6896C16678_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:208:236::27) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [169.254.198.0] (216.228.112.22) by MN2PR05CA0058.namprd05.prod.outlook.com (2603:10b6:208:236::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend Transport; Thu, 15 Jul 2021 17:53:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 056bd9aa-3aa4-45c1-51a5-08d947b96514
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB404681317ABD0C9C0C79C40EC2129@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5O1nM+P/L0g2W9P06A32WY2G18kqXxbeaLk3/DdWDpg0Lj3YQpsmrt5fUnSQC+7XRsApDoUZ5JSMuLwSun1TX04ueCVKBJS8CYNFRgTZ71vwflVhseajMGwJQURa6jQuZ56QXkv7yHNKKQ48nUFAGtlRbCBBxpsfjVOVx3+MqHjpVb1NKA/hxMzApfzh+LDcy4Zkxf2miCXAaBk+SZZ+WSd0Oe6jlxAQFVL+A0NxYj2po662Lg7jXUO85DxE/viRM4ztFSZ/eJQHhYzH1ccAi8K3G2gKP+gD7Z67Uoqna6oeYisjH43oTuq7VgTpEmaq8SnLPfrBBEAlXxBbhQdbtVHChE4W2J1dEk4PPAGdG27/cbqoisrYgdu79a9FLvctPNLW5yZDyriGRrr4LXX7NUtYwaXbpKz/XfHG1oUf0inH74CcHAkfjO1sPwthCc3ZFKcmeOrWX+zKxQqVtnRO4Jde5D9rmu5je0LzasYvt04VIdA9Kmuf5XX+w+9U3hicjXvkF+1IyrVzne1sil5joRFsPaBBFTWJvJy9SCazKYO6J2neR0CxrR94pD/uSKIHkYtSSzmMShuPFNQoVXAQMlpjcyIsesXjEq/J41yLtbK/rwi2uk8fTzB3LrtWr/4UmjnNyanRWbusCpaOvnCUCJLTIVeZfN+SovTUiyTz2zCBXXh0FlcZAvh+YmklIqN3tVIiOI10rl+RoywglA5391m1GEdC+Y2YBESOZJ05q1fltL9hEic0bTf75qp+ugR49Xk9NrhdcZZeG/xqNJNQ+tpeDfF0JupFLt8Wsklrgff/uBNICrLQovj6RS23Q2lx/tyaoJhnC2ROanPT1J2ByQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(66946007)(21480400003)(8676002)(7416002)(316002)(26005)(6916009)(6486002)(53546011)(36756003)(66556008)(66476007)(86362001)(6666004)(186003)(33656002)(83380400001)(38100700002)(956004)(5660300002)(2616005)(478600001)(2906002)(966005)(235185007)(8936002)(54906003)(33964004)(4326008)(16576012)(78286007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3NGaWpmcXBpYkh3ejYrVWpTRGRwNUtNQWFOM0NDSkhsRDQ4NFVkTGNjZ0R0?=
 =?utf-8?B?MTlndGRLZk1YaXV6SnVRc1BjUkhwSkowcW5qZmRYa29BaWYxL2M2eDZRTTQ5?=
 =?utf-8?B?THEzUlkyREhkVi9HbWJNZitnRGVSNXpRV0JGRTRYU3FmUFAvdkJyWGlkU1Nm?=
 =?utf-8?B?Yk4zaFV1N3FVMEpoSGYwMmFNQ3dITVdoOXRuVUZYem5NZGwyR3NkcFVnOUMr?=
 =?utf-8?B?OGd6a3doOUFTM3VyV2NoZlRnVmhpbnFVM1ZKbVNGLzJVd0dGM0JCSk01VExj?=
 =?utf-8?B?S2VCcWdhOTlWSmtZZ00zYUZOUXJWL0xISUJxanJQNkpMQ28wbUNtYTBBbFNl?=
 =?utf-8?B?Zy9kMm9MNlNicDVyRWVHWmtObUNTOU0yTGhoVkxIK0ZoZjhqT2E1b01HM01Q?=
 =?utf-8?B?QlJRY0JCUE9taDl3WHFZY2JoQk9kcXZqdmhKNW1UQkJ3K0s5MWNPVUJsdVhR?=
 =?utf-8?B?NGVReEJiSXlSU09wZnozMXRVbDE0RVlVblluSlBDTWl1TnloeWZudXVGUCt1?=
 =?utf-8?B?ZGZsM01kMHFXcUVCVnFqSFlHVTFRR2M2ZTVMK0RKMm1BOVhLV2VveU5OelZt?=
 =?utf-8?B?RzEvWHY3RlZMemIrY2Joa3NMNnkwcG1mU2QyUWM0V3paK0RSSnlqNFYydHZP?=
 =?utf-8?B?TnVQQzkyTEQ5L2hlRHFvTHJSWWZvL0JzdkdmWUxVMHR3UGtNTDZwL3M1OUpx?=
 =?utf-8?B?T2tCUUZsdXYyZXZIZ2FURnpoYXVsU1NBcGJabDl1K2dMSzJlNHh2Q3VlczBy?=
 =?utf-8?B?UVZxUzlHWmtzcVViNEdMUFo1MVVmTitNUXhCNUV5ZVNVUmlPS01ibHZPdlI5?=
 =?utf-8?B?OHhKTXJVVVdncU1JdUR3cHlBb21Delh1V0dyQkVEUFlza2ExM3hXRlBuZDd3?=
 =?utf-8?B?aHFPa1pWN1lBYzRFam9SWlN3RklxVFFXWDJlcEtCbmJzSi9GTlo0Z1lDNHFV?=
 =?utf-8?B?LzUwOGtqRi9waURnVzJLdmZjVTF0VUN3SW5maWFXb2wvZnRpbVh6dWQ4d1BB?=
 =?utf-8?B?OEtKZktGdjV6Q1FYSXFqT0p6bEFhN0xid0xteUpnMkpSS1NSY0NscDlybGVm?=
 =?utf-8?B?QzlpK0RhL1N1cGlWYytkcW90OHJvTURKeW1CaGJBY0VVUjBYNno0VStVaEZp?=
 =?utf-8?B?TjRVaGp1eEk1SWd0aGNoQm0xV216ZlVwejhscHBFdUU5d2pTRFZuNHFzQWF3?=
 =?utf-8?B?bzhxK05RNlpqeTRINVo4Z1o5YVVPOHEyaFFsSDg1RkovL3RaN3VNZ2pxUEdP?=
 =?utf-8?B?TjRabXJVS0dCM3gwaDZ3U2tzd2pYekJEM1JnVEE2ZU8vY2dFT0N0ZHViTmty?=
 =?utf-8?B?bW9sdUhGbFFVZTl2bzFOc1B0cHZOUTBNVmJiUStLdG85VFJ4Wkdvb216eGR4?=
 =?utf-8?B?YnVISkppRTBiZEhqM3JhT0NxSzFvVUs5OGZuaFN1NDRYZXFFaVFWZGRYQUtn?=
 =?utf-8?B?N3VTYVZpdUJFY2xDajNxdWRBSEVVdzhzbUZra1N0N2V4N3BSN0N3Z2ZCUU1j?=
 =?utf-8?B?T2FZMCtRMlRNMHhsanB2Q09RRk9DQnd0ZVloMUZLMmJlNUd5czJiVExsd1pX?=
 =?utf-8?B?aFZ2dHlSSjFBTCswdGsxZlZxT3o4M1BQbVREVlB4bmJpZWhrdk9JTzlHcjRz?=
 =?utf-8?B?UllmRjZDMlBaMW5pTU13eFZjMVhwNXUvZW95eHd3bkdkVDlXNUtJOVhIWkx6?=
 =?utf-8?B?ZTZqR0tQVjdRUm53dzBWZEwrTTNKdjRNcmVZdE9WdW9rRG5BVlBUVFdkY2g4?=
 =?utf-8?Q?qGkV8LQpklsTIgROhhFpCnOy18NXgA9McKMYzqZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056bd9aa-3aa4-45c1-51a5-08d947b96514
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 17:53:04.1267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YokXL7jAzqKEtM+Fphl2cPOlUNyxUJ+5BXq4dt8XQ10vtcupEkBV8wOTzwVqha0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_57AFD51D-3D2E-469C-8555-7D6896C16678_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15 Jul 2021, at 1:51, Huang Ying wrote:

> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Prepare for the kernel to auto-migrate pages to other memory nodes
> with a node migration table. This allows creating single migration
> target for each NUMA node to enable the kernel to do NUMA page
> migrations instead of simply discarding colder pages. A node with no
> target is a "terminal node", so reclaim acts normally there.  The
> migration target does not fundamentally _need_ to be a single node,
> but this implementation starts there to limit complexity.
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
> RCU is used to allow lock-less read of node_demotion[] and prevent
> demotion cycles been observed.  If multiple reads of node_demotion[]
> are performed, a single rcu_read_lock() must be held over all reads to
> ensure no cycles are observed.  Details are as follows.
>
> =3D=3D=3D What does RCU provide? =3D=3D=3D
>
> Imaginge a simple loop which walks down the demotion path looking

s/Imaginge/Imagine

> for the last node:
>
>         terminal_node =3D start_node;
>         while (node_demotion[terminal_node] !=3D NUMA_NO_NODE) {
>                 terminal_node =3D node_demotion[terminal_node];
>         }
>
> The initial values are:
>
>         node_demotion[0] =3D 1;
>         node_demotion[1] =3D NUMA_NO_NODE;
>
> and are updated to:
>
>         node_demotion[0] =3D NUMA_NO_NODE;
>         node_demotion[1] =3D 0;
>
> What guarantees that the cycle is not observed:
>
>         node_demotion[0] =3D 1;
>         node_demotion[1] =3D 0;
>
> and would loop forever?
>
> With RCU, a rcu_read_lock/unlock() can be placed around the
> loop.  Since the write side does a synchronize_rcu(), the loop
> that observed the old contents is known to be complete before the
> synchronize_rcu() has completed.
>
> RCU, combined with disable_all_migrate_targets(), ensures that
> the old migration state is not visible by the time
> __set_migration_target_nodes() is called.
>
> =3D=3D=3D What does READ_ONCE() provide? =3D=3D=3D
>
> READ_ONCE() forbids the compiler from merging or reordering
> successive reads of node_demotion[].  This ensures that any
> updates are *eventually* observed.
>
> Consider the above loop again.  The compiler could theoretically
> read the entirety of node_demotion[] into local storage
> (registers) and never go back to memory, and *permanently*
> observe bad values for node_demotion[].
>
> Note: RCU does not provide any universal compiler-ordering
> guarantees:
>
> 	https://lore.kernel.org/lkml/20150921204327.GH4029@linux.vnet.ibm.com/=

>
> This code is unused for now.  It will be called later in the
> series.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
>
> --
>
> Changes from 20210618:
>  * Merge patches for data structure definition and initialization
>  * Move RCU usage from the next patch in series per Zi's comments
>
> Changes from 20210302:
>  * Fix typo in node_demotion[] comment
>
> Changes since 20200122:
>  * Make node_demotion[] __read_mostly
>  * Add big node_demotion[] comment
>
> Changes in July 2020:
>  - Remove loop from next_demotion_node() and get_online_mems().
>    This means that the node returned by next_demotion_node()
>    might now be offline, but the worst case is that the
>    allocation fails.  That's fine since it is transient.
> ---
>  mm/internal.h   |   5 ++
>  mm/migrate.c    | 216 ++++++++++++++++++++++++++++++++++++++++++++++++=

>  mm/page_alloc.c |   2 +-
>  3 files changed, 222 insertions(+), 1 deletion(-)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>


=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_57AFD51D-3D2E-469C-8555-7D6896C16678_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmDwde4PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKq+wQAJTMu8rhEmJPI8kL1eEXoqaI9EM4y35TaEe8
TR9RJdoDPeuUENnL0kaS5L1ZdklVGMYbn4Yb2/zMIvvsLDEOzb0LYOZM/6S8df3e
dWsSEqwHHTHK2qFf79irxl5YPosfDJ49jyybXxafGYqbbm/mQK12h6OQu5nf/tp+
hVduIhFoVmK4oU+yz0ZhqwkPv4ej89YJv0BmfNe+43mwd/M12saPBZCdJV3Mcb1N
ImiivCNnbrt/Die1o6uBAP6qUhmd12c9sREqFk35nV0xo2x3p2KJKVRLSMYnoKjI
Dk7gURqv5r7oUXKmADoY1uq7i22IHDK+sXtzXXGtOMAWaCEcxtHMaJNOhj+BkL+K
1lbO3Dda8uLcUOeS3jdJQK6owXpTHclB2pKwsJxgdzoEcR40am6lmCZ5/KyGlSmI
Iwc/7KnvvBYstZ2/0l2hZJja7wp5ZvUqtvE2RRDchnYH0YSxcpL8PUr3l4EFTn9L
l4VsL3benuYkJFpmXrC9GLtfmQFpZ2rsj4CvhQtrkBJnu3nZKGBpy5SlbSG7/2Zn
rJSQARIhW8kiPs5Me0zrpRzDDbvZz63RFAX6Kpd74BX5UwGNzTbs4SnzOp+T7jnp
SuxtkMGelrQZzIZaf5NoyghZif13RJB/EJA/s6DFAwj1fziF+x497d8uiR2ziPkY
2hFgb25R
=hx1V
-----END PGP SIGNATURE-----

--=_MailMate_57AFD51D-3D2E-469C-8555-7D6896C16678_=--
