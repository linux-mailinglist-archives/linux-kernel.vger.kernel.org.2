Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87175446889
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 19:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhKESlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 14:41:17 -0400
Received: from mail-bn8nam12on2070.outbound.protection.outlook.com ([40.107.237.70]:19520
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231842AbhKESlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 14:41:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbVqYkiicJHKf45C9ukwD0/3zSW5lsWWxdZVfjYABWSLE8oOH34FvazEZKyY5NeAXPoWEXOvq0v1/xdShEnekLbgtKBp2NsXS4SGR9nnr0fSqqn51tG8Qgp2k+UAGTYxkyCTIiJLlLeju0zgmkkO9Obf/VMcbEe9vBpBoelAjTuVaCDjPNY7DQbwDruzpvH2qZAZhLGDq/+UWI3ajK+agVTHQ4xY8Iaz5M24NlLIYYM4A5rKxQr5K5TUbTw8hOjxI2df1oeKj7K4Wbm3lWSvJnXBXKyiEYDjCPsNKykXfLPDpHfGM2rsHMUT3xlYKkE8WA+1YTSwBwk8xWTS8K391w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JB4Vii/p6r7jFdTzgXzs1PS6eIKMO8i4bRL7XICAce8=;
 b=lbEKHG2FNJ7WJq3d3HeB3A8bUlqMEToRR6at/TGyimFb3fA+x7oVD05dbS2HKQp8dYC0Kfvlf6XDe/18clcbhmABQnP7LzOsuyQ5deg2zJbgG91l9uAn5l5r07U8zzfy3beOHkwxV+YU+zN6cliAqRPpakjBJJdc0hCwHjHVUq6tM/4TdvfAhdhICpbSHOlg1Gb1BeYZVwgrkvMDU/Na0bKWMxFfT44nWBtKH/m0m0LewIu6c07TcXnfLqjlpNQtgKyiveXTA9Y/WYyzho0TAddzDGJT70rGrEq0t+kp6Qy5simrxmRyp4J0piA6F9Zat17bCMRJy3Dn1QUQhCFyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB4Vii/p6r7jFdTzgXzs1PS6eIKMO8i4bRL7XICAce8=;
 b=hZYobyHTLPr53vXAEt456KrTN6KcrsqdeqahYSLydhahpqZSEtrbUuLli9o3Pc8UAUtgQpUMYzPTVP3w0wVktwl7Eago74/gD1EC0n6RX1UCar+o8dGN792zmnnT4jt8oNjMYy8qWN57pBeW4dSQoNN5gstAihrJPP2Jh6IfYFc=
Received: from MWHPR1201MB0237.namprd12.prod.outlook.com
 (2603:10b6:301:56::23) by MW3PR12MB4427.namprd12.prod.outlook.com
 (2603:10b6:303:52::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 18:38:34 +0000
Received: from MWHPR1201MB0237.namprd12.prod.outlook.com
 ([fe80::5d76:cdc:c079:5037]) by MWHPR1201MB0237.namprd12.prod.outlook.com
 ([fe80::5d76:cdc:c079:5037%8]) with mapi id 15.20.4649.020; Fri, 5 Nov 2021
 18:38:33 +0000
From:   "Srinivasan, Sadagopan" <Sadagopan.Srinivasan@amd.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ramakrishnan, Krupa" <Krupa.Ramakrishnan@amd.com>
CC:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Thread-Topic: [PATCH] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Thread-Index: AQHXy/wpH7i0D+tSTEiFgskdiYCeQav1TFEAgAAESpA=
Date:   Fri, 5 Nov 2021 18:38:33 +0000
Message-ID: <MWHPR1201MB0237CC1B017C874CE5C11D51978E9@MWHPR1201MB0237.namprd12.prod.outlook.com>
References: <20211028130305.GS3959@techsingularity.net>
 <875yt6tqbn.mognet@arm.com>
In-Reply-To: <875yt6tqbn.mognet@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-05T18:38:31Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=851c3d6a-26eb-4391-8290-57aaf0ddca6e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fcffa69-132e-4222-b43b-08d9a08b78f2
x-ms-traffictypediagnostic: MW3PR12MB4427:
x-microsoft-antispam-prvs: <MW3PR12MB4427A978A4E658EF1D418D9F978E9@MW3PR12MB4427.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m0Shd+mrgNCSaynHmcgLgm3cg3OtxXbZZvSxXW20KJ0VddJ+32KhD5CaaErCYTPyEpAYSD7VnIzvKRHUQ8Op/Glpvq8pf7ji70G/LiWfqVtDWscpgcms12vI+pKkRwmaCV2bMpoeVqZzclxPvNeP0XeKGAOiNnnToLOCJazewQFnl+31RXf2rYKIDsu+Dz4lZt6nkVQYtQ4N2L0A8/EzgeASWy2VbmsZZQOZpNNvA0TF4/eRiF81wnylcCsDSXsm39Vlh8Lb0+XN9mnjQKb6Pio0biEeV6zHETqf38mkdS6fE1/ds2IJQYAPePGfwJzybAWf6nyI6hhW73qjmZBM0S7AQreLlNd1QLmM0yuKSzfzMBNewD4pE5rSTpVxVSswlaJlC06u26srYeLUaeJ2lgwIbideUu94FnzrJc8KxHU5pWH9hOe1n8YM+dnvjmMkyfVvTOPc1Za2BiP1dUxw64MJaN5tOvcsvzCCHTaOlEbF+aJVIgNbrToc46Na2KQcv63hVCdQ0y5l4VMZAg47sIX8BlIJyJ71aPgJk+6ujSp60uqBNyVaMqRk8Qve4MH2jBOMYTe3BXw6TJ2Nk+58Jb7KzHEf0YtJIfy4tLjfNcPyOzhWN4e6u30NJx4MYb8ZyiG9kDrYXYIFwLn9f1yTBK6OIPRVbdM6VFjfYdMNMIo0/s5HkLyw1DY1HwT7IHvkUot0Q46Yc/osL8BjBjguHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB0237.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(66476007)(66556008)(53546011)(6506007)(66946007)(6636002)(7696005)(5660300002)(2906002)(83380400001)(55016002)(122000001)(38070700005)(38100700002)(66446008)(76116006)(52536014)(33656002)(110136005)(54906003)(186003)(8936002)(508600001)(9686003)(8676002)(26005)(71200400001)(316002)(86362001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NxptWuqgHL/bVU3FMYo4E2AqXrso4ufYoVWaGislfXx3pEOywxnDdBZknZj9?=
 =?us-ascii?Q?AlWxwXIKvYRYaRo/a6cSHW/t3S9pebTRHeuK1fsOAd01YY/X5sCgrEM73qrh?=
 =?us-ascii?Q?BfY1F96IRUIWcw5srLiZcWT67xSc1a4NJLwx2PtK7a7qIvMYmcdBEk4LY4I/?=
 =?us-ascii?Q?fwtu3fdHcoWx+nYCeZtMWGC1W/5W/q8bfMwiArv0StGUTc2tEf96fubKw1Tz?=
 =?us-ascii?Q?SGwtCdsxeIyg9/7PKPhIAkDchzt1e9+37/vY7JbrGfPOHC1vWMe4jxs7SYj8?=
 =?us-ascii?Q?S84ppTzDdWiknH3HdmEeHTY4hGBhnH5vh32SDqODUCYugM/SDI7/jBAsHcmu?=
 =?us-ascii?Q?avLFzTgkfH99CcPXqfGtW7zB4vn7Qmi5p3pX1Lh53G0geEugTc8Vh8dvr1o8?=
 =?us-ascii?Q?HdwIk5FmK7uc9QcKRZnF7wpNWyjii/rRPty9ESyGpH1NS3M10TV3rTxXgqzC?=
 =?us-ascii?Q?1UG97D6oBgueReK7wpVKkL6oOl8MHQRAbkJuFKGeUEOF5f4q7ugAGVRGoIaV?=
 =?us-ascii?Q?kJX3yh9JBlHZFfL5GOUyF65NzcIS77lozqXtoRvQkzhyBnWRmvSnphI6H1NS?=
 =?us-ascii?Q?3jrJ4HalqA0Sb1/kaJRhR/17j/M4EYwRz4nJ33kJHkv40PW0ytutvspJXt1I?=
 =?us-ascii?Q?iWsQoJmmXLvjHiz6JImRiTpmdKYQDA+/t+aF5yA9EB7CF/0uJ5ZvF6Do1jeR?=
 =?us-ascii?Q?CK779vytz6jEaksN+GIzGLmh/OA8I/PK7phg4E8cy6KUxnJKrYPpvAbFA+L0?=
 =?us-ascii?Q?hwNBlOa04OZ1vvtCs/gT1TmZ+vch3SqQTL7vQjyRmcIvIX3+P23/S3t6i523?=
 =?us-ascii?Q?Nkn7PjffTaTvTUbzuBnK5G7Bl+Ikz03hltNiGo5vy8iidQwgc8Yzci27SjuV?=
 =?us-ascii?Q?LWF31GD9OgxYhG81pJScnJrkFBX3D4LeuxzZ4iQoSpb+cRYlDQt2E/8bVgWz?=
 =?us-ascii?Q?fGSGezUMu+sz6Y+Ln+g7rVEsDy5q+SY9OSxiOcLCg0ya3tbJyHOXKO2ZWiTF?=
 =?us-ascii?Q?R2tMHOtl3dWb9ReNXmOyI75oMGCZq/TolTtl1MVE6R90UQrLIYAgfq+w0XIF?=
 =?us-ascii?Q?2WgPdujoRA1k7iSjotLKMhapEnBoGrcehhIfipTjA6D1E3+mebpxbGGoqH20?=
 =?us-ascii?Q?nNxnjYvuOw9MGwghpsuo43pqkDBhlk+2V0uQ8MXGi3A7WLVvkNAxagdIAkZD?=
 =?us-ascii?Q?wu/y7Q/2Pe3aNPo9biKlMLMofsR8KkQBKY/FpkffZ7JQG4nF03F7bT1tUEp0?=
 =?us-ascii?Q?UzAYVx/GKg4JRMax8vv2Uqvd2ctV4+EaIA0RJP4+AZYg7iXKu9vOWkYkYgQW?=
 =?us-ascii?Q?n7XCni5WQUtPcINFlqjiIaAMVoKNoNVzg27t8mfNCyMQQCofBG5G6VN0WU4N?=
 =?us-ascii?Q?dQxhJe7oaPtjFgaNLVmTcKS1vkj1PBYZdeoo5MLqBQIGuROIgTSLvw70JdI6?=
 =?us-ascii?Q?l1WrGNnhK+w+D+faEepIFiRkqRjYhM9tDBcxBQ5nlteLrqNPUm09kCjt7dIg?=
 =?us-ascii?Q?psTgBqg9Rgf8HGQCZwk1G/FPOIMByGZeyDZmEqOlcH0T5I53E4oUXyShgEef?=
 =?us-ascii?Q?FSwBcci0iH/1SORWDRo1wkq0vesUKdcTwXlAj2JQYG1NPbeT0VkgUprtldBA?=
 =?us-ascii?Q?5A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcffa69-132e-4222-b43b-08d9a08b78f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 18:38:33.7346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BY8pNtChfcYE/qqvVKYwGtQLzJOfxUYVGelgte1e//bq16KhIhYNH4maQPu15VDgscrqOGk5QeCB7DdcKHhGyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]

+Krupa

-----Original Message-----
From: Valentin Schneider <valentin.schneider@arm.com>=20
Sent: Friday, November 5, 2021 1:23 PM
To: Mel Gorman <mgorman@techsingularity.net>; Peter Zijlstra <peterz@infrad=
ead.org>
Cc: Ingo Molnar <mingo@kernel.org>; Vincent Guittot <vincent.guittot@linaro=
.org>; Aubrey Li <aubrey.li@linux.intel.com>; Srinivasan, Sadagopan <Sadago=
pan.Srinivasan@amd.com>; LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Adjust the allowed NUMA imbalance when SD_=
NUMA spans multiple LLCs

[CAUTION: External Email]

On 28/10/21 14:03, Mel Gorman wrote:
> Commit 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between=20
> NUMA
> nodes") allowed an imbalance between NUMA nodes such that=20
> communicating tasks would not be pulled apart by the load balancer.=20
> This works fine when there is a 1:1 relationship between LLC and node=20
> but can be suboptimal for multiple LLCs if independent tasks prematurely =
use CPUs sharing cache.
>
> Zen* has multiple LLCs per node with local memory channels and due to=20
> the allowed imbalance, it's far harder to tune some workloads to run=20
> optimally than it is on hardware that has 1 LLC per node. This patch=20
> adjusts the imbalance on multi-LLC machines to allow an imbalance up=20
> to the point where LLCs should be balanced between nodes.
>

I've run out of brain juice for today and didn't get to decipher the logic =
you're implementing, but for now I do have a comment on the topology detect=
ion side of things (see inline).

> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -644,6 +644,7 @@ static void destroy_sched_domains(struct=20
> sched_domain *sd)  DEFINE_PER_CPU(struct sched_domain __rcu *,=20
> sd_llc);  DEFINE_PER_CPU(int, sd_llc_size);  DEFINE_PER_CPU(int,=20
> sd_llc_id);
> +DEFINE_PER_CPU(int, sd_numaimb_shift);
>  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared); =20
> DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa); =20
> DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing); @@=20
> -672,6 +673,20 @@ static void update_top_cache_domain(int cpu)
>       sd =3D lowest_flag_domain(cpu, SD_NUMA);
>       rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
>
> +     /*
> +      * Save the threshold where an imbalance is allowed between SD_NUMA
> +      * domains. If LLC spans the entire node, then imbalances are allow=
ed
> +      * until 25% of the domain is active. Otherwise, allow an imbalance
> +      * up to the point where LLCs between NUMA nodes should be balanced
> +      * to maximise cache and memory bandwidth utilisation.
> +      */
> +     if (sd) {
> +             if (sd->span_weight =3D=3D size)
> +                     per_cpu(sd_numaimb_shift, cpu) =3D 2;
> +             else
> +                     per_cpu(sd_numaimb_shift, cpu) =3D max(2, ilog2(sd-=
>span_weight / size * num_online_nodes()));
> +     }
> +

So nodes are covered by the NODE topology level which *doesn't* have SD_NUM=
A set. I always get confused on how MC/DIE/NODE is supposed to look on thos=
e sub-NUMA clustering thingies, but either way consider:

  NUMA-20 [              ]
  NODE    [      ][      ]
  DIE     [      ][      ]
  MC      [  ][  ][  ][  ]

NODE level gets degenerated, update_top_cache_domain() is invoked with:

  NUMA-20 [              ]
  DIE     [      ][      ]
  MC      [  ][  ][  ][  ]

That lowest_flag_domain(cpu, SD_NUMA) will span the entire system.

Conversely, with this topology where node =3D=3D LLC:

  NUMA-20 [              ]
  NODE    [      ][      ]
  DIE     [      ][      ]
  MC      [      ][      ]

You get

  NUMA-20 [              ]
  MC      [      ][      ]

lowest_flag_domain(cpu, SD_NUMA)->span_weight > size, even though LLC =3D n=
ode.

Long story short, I think you want to use sd->child here - that *should* po=
int to a domain that spans exactly one node (it's gonna be NODE, or some ot=
her domain that has the same span because NODE was degenerated).

>       sd =3D highest_flag_domain(cpu, SD_ASYM_PACKING);
>       rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
>
