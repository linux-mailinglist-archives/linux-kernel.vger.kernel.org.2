Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E993CA4DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 20:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbhGOSDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 14:03:52 -0400
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com ([40.107.223.67]:42697
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236602AbhGOSDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 14:03:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNXRG1MMagK0yFFNrr1VbS65E2D2dG3hOOFD/Lveasf4dC9r2ltfcZXuxH/+mD9e757iuigIXaOQ/1eZUlNB2kQh0AII3DOEJ5Yj3LHIQRFifyOfqg7E1HdpR6Npi5iNN6PGQn2ffT7YV9lE79ilnXrKRwPo4MZuIjE6rt5wyCUp5Q7IA8JuKO3XFwwhPLjYCgNtLSZqdXvVbmMSsmuPVAvS95iWHgSkPBCCBGmXQez6B+f21j62q0AbBcCqjlzDHvnVRXj9IfoQK+WHQKF667hdUYoPwugEakYsaSz5N3SEti7PFZnCSLudrVRI5u0WxiDu3Fy7UOrvx1n8xyLLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAJWGrK8tFdv4aLpki1sredKrnyfO77m4obO0zX79ZI=;
 b=aRe8uxrBptssZXnMbuiOyPbLh/syYEmyh1f6qiXoVcqltBsOs4RUsTFDWBy2e0nt4CnDBay6sCB5BkVobZpH33JouHwg0J65+cUMI4eHL2TBVsxiWhjLqK23G0ikrqlBvTiyh8X/lhT99pgVBoIiXRGDbPULXbyry5U6CdfcJxPtrv9E2G46MNUHz+onJzt1YyEBvHuTsWFnbiimAczqiXXlT05pwTcKgnZDiMIhtsYcHG+k4DghzgdfAFegca+RKjtxEedrkP10iOdv1K2e/sCLG/JhwgZFbupERc2FYugdxpfZLB4XjwwJ1p0YhtH7eftn4E4RgjplbwL30XB3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAJWGrK8tFdv4aLpki1sredKrnyfO77m4obO0zX79ZI=;
 b=Fhn41f0BuofHZsAD0k/zpXonY/uQxvxo0DXRyDDNnQ9sUHd3016W1GVacIikd/uAwN88yZX+XJuiQ1t+JMzBkukDvLYsWDSkuK0mbkJ/gWkhzSX1/khfM1Cmn9vxznDFMiecswHvMnPEOJQeCIIHkzr6USctmRP9/7Hh/GPAm8LyhJZZkkESCnj3ugF+IM/UY0AxNgtq58Eqt1Z8IJpTS+Ty9qvav7EUveF/Ib8Mqj0z9dVEeUUMXlB5E+P9gEhs0xEG3fOueKIeArRWc4kAjlpfUGD9ny1Cidq/kwgrknI/RfT18CKcd0wsMuqG6yOD2MXRpR9BcybphAG994XQIQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4990.namprd12.prod.outlook.com (2603:10b6:208:fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 18:00:55 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 18:00:55 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH -V10 2/9] mm/migrate: update node demotion order on hotplug events
Date:   Thu, 15 Jul 2021 14:00:49 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <FDEEF381-7672-458B-949D-9F5D8D9003B5@nvidia.com>
In-Reply-To: <20210715055145.195411-3-ying.huang@intel.com>
References: <20210715055145.195411-1-ying.huang@intel.com>
 <20210715055145.195411-3-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_5BA34E9C-1F8E-4D7B-AA47-2D4663136405_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:208:120::22) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [169.254.198.0] (216.228.112.22) by MN2PR10CA0009.namprd10.prod.outlook.com (2603:10b6:208:120::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Thu, 15 Jul 2021 18:00:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6687d97b-e1dd-4f69-ed12-08d947ba7dcb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4990:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4990F156B51FA8C7230D77CDC2129@MN2PR12MB4990.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rtcofyFdK8WUVMexeaeEhrUFrtauoKKe0+gZEd93bBrSD4mLeGyxaZ6wbs8egp8w0/dF6zzh/MjzkzL44PBB0Vh+RQDcIyEAvYcbdSOUMCPm37kOwUOTbnwXkIc4lEj1tghDVq554Rq94hHV/L7PwU0tnpchRveB1PlWISB0qgVoVA6VruXIO4ILdbWRTXwbuI3iIxSO0ns06C3oZ37HPLSPCIjR8S/B7qAfr6XBKCH/uxbw6zJ7gD2+rqod3H+HuqDYbuBE2P9OwnacHgxfjJUzaiFlwp9xfa9VvVueIgB+q+OmciwUnv9pB8GxpjZKmERetcemG5BNdcXgacQCRpeklxUikW4rTJc5/1bfpEy8MaVr4drxpw5iE2OyRaDXUpzmyAUGRKPGXnXttlaK5V4+8jLQiBHLLufimGa2shiIb/l8wUhJPjFnuVzGVNrFBvQtL8Gwfe7XR4YeYHIp1IVf7b80OCr2xfxHoPOlJFr0zOP1ux5ILi12YXA4+DhlaxCl8gaEqunesBgqV2xiNWFQ22/41gZsl8PrLEqa4HlKdF9SpO/eszMRyCs1qhPI7BaRLLs0OF+7U7VEyCmKR49Oat7MxbdpGDxCnWbQG1ZakolJ3S9K8gwaCKFIjkHuO0jZOgC3i0npomNEFRLGHTQ8GYBp/gbj3abg6AAFG2sFWpyzGLRuoKuGjhrJQdolC1aHdxId5oi3E+stdk8BjmRonAN8MlBdKILyVK60FKsfVwHSO/+ROAthYYlQ6oD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(66556008)(66476007)(6666004)(956004)(38100700002)(8676002)(66946007)(2616005)(7416002)(53546011)(33656002)(478600001)(33964004)(86362001)(8936002)(6486002)(16576012)(83380400001)(26005)(4326008)(186003)(2906002)(6916009)(21480400003)(54906003)(235185007)(316002)(36756003)(5660300002)(78286007)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3NvbW9WM0k3dmYvaWd0UjZad3lLK1lEWlVvWHIvYXgxZUliK0VPdTIyMFNO?=
 =?utf-8?B?V2JzelpwS0JrNklRS1RVT09odVhHaWgrV3I0c0JERVZBeVFQZUlyL3YxOG92?=
 =?utf-8?B?ZFc0VmUycTZQVnp3QW1raGZrbGhZb2pER2RuTGtVM3BjNkdPV01UYUpWUW1z?=
 =?utf-8?B?Q2NHaVBsclVsOVBFSlhkUnBLQ0pHYzdoQzlOWk52L0dURFJHRkQ1UDVNSytP?=
 =?utf-8?B?Wm1tSDNtRXpjZS8yUVh3Tm9UMVl6OE5Kd0JqWCtoMXdEZWpwb09iSXJVZVdW?=
 =?utf-8?B?ZFdnOHpqaEhlV29SYzdDdzBiakZEeWpNMi8xRWZoN2ttcEdTcnpqUkJ0dTVa?=
 =?utf-8?B?NW5YaDlva1lJSWpyM3JLdXRETDBJWjBDeDdUQlFqRDQzL2xiYmpWM0N5bnRx?=
 =?utf-8?B?d3cxaFY4OURjN0NWTU13Sm5PVjlrN0g4bnlVaWd6dzdqaTJNcDVFdHM5RU9m?=
 =?utf-8?B?L2ZmZVhNdU9BenNDRWh3SE9MUFFEN0JjTVZ3dlZvLzROUThQVW1kVXJjVklI?=
 =?utf-8?B?UkUvc3dpRVc3aDR4SkJaUzFNNUQwMlJPeEhudi84Y2VOVGV4V1FRYXhzOTMw?=
 =?utf-8?B?dEY4TGQ3ek82aDljQkZkNWZMSnVOVmR2cFlzMmpyZWVtOFBnZXB1Q3RKWHE0?=
 =?utf-8?B?S050NHphWGhjM2hsVmhpK2VZeHV6aXdvYXFXOEhsU2lmQWNkVStSSm1BaGJM?=
 =?utf-8?B?TTM5ZTlnU0R5R1FTbWdhc3N5ZjB2SUlpYkRpa0Fqa3Vlc3JVT0pnM0YwOVJF?=
 =?utf-8?B?R1hiSGFSSEVWZnZVSXBHUlJOWnZ5alg5di96cGJVOXArU1RCUVNUNC82cEFo?=
 =?utf-8?B?WUVvUmdNRzZxUW9SOSt1OU04RS9YVE1ySjZENGNiVHlaQmwwVm5ZUE5qcFRO?=
 =?utf-8?B?Ni8rOG1memtjTGJlOG4yTEhrYWpPVHBqYkI1dWdjUUszYXpkYVVUNzhjdmlh?=
 =?utf-8?B?anNCOGg4azFQSUl5M1dRQ2pvOGNOeDFzajNkdHIrYUpCanVPTlZ3M0RxU2Qx?=
 =?utf-8?B?aTNqeUxLZjVHdVdnRkg0QTVSell1TEdkcmp1SkwzOGVhdWJFS0cvNVpBNUJI?=
 =?utf-8?B?b0NXMHZ6OUlubm9ZYlpobkdNRVNtYThyZHltYW9CNXlDRHNxZXRQUExrQjNC?=
 =?utf-8?B?YURWenhOcTM2d3hsV2VKdVBFTFAwMVhHM2dma1hFMWkyWHcyanR6cVkyN1Mw?=
 =?utf-8?B?a0c2RXNVUnNUTnRHOEtDK045R0orQ2hpN2lSdG5xc3lJbUVGNThzV2NvZitu?=
 =?utf-8?B?NEk5RWs0YmFxckR0MmJ2MHBSMmx6WFltODAyeUE1TlE5ZnRMRlNBL0FRSkMr?=
 =?utf-8?B?Sk9oTThqbXNYcVlyTy8yRWUxR0RvVXFKZ0FqVWZxNjJhRG9QamZLM2lTeE51?=
 =?utf-8?B?L2hJRlZHNlhoUkJzb1p1eUZQVjBaVnNlWVFOR3VDWjUyNHpYaTJkSjh0Tjk3?=
 =?utf-8?B?NE02cVdqQWZDYUR5S3lVandTZHpHNThtcUtYcXNUQmlEQm83Q1UxMUNoVjZU?=
 =?utf-8?B?WlFMbCtjeVlhaWs5bzJYUFEzRDdOZkwwQ052RCt4UTFmQkQyY0h5YTFOVkxS?=
 =?utf-8?B?NXF5NHRSczlRY3QreUwxZlRoT3E5Z3VDbXVBNUNLY2xDTS85VEl6MjNRMXBk?=
 =?utf-8?B?ZzJIdERmeEY0VmJSamJtVUhqL1ViUzJCTjFpdytrOTJDVWN1ZzBTZ1hBRnpM?=
 =?utf-8?B?UFFlakF0N2ZzdURZd2dFZ0MveSt5aXA5enczZzF4STNDemVQazBWbFp5cFVv?=
 =?utf-8?Q?9kwuJkpCTdYM/AWC6AoG9wnEP33O1chnHRDncEy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6687d97b-e1dd-4f69-ed12-08d947ba7dcb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 18:00:55.0720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IINczKVusrvMDPOxlzY6jszmmJGfpc51hWvLSRVP/Moq1lmnHyMiXYJZcxEK2DFw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4990
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_5BA34E9C-1F8E-4D7B-AA47-2D4663136405_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15 Jul 2021, at 1:51, Huang Ying wrote:

> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Reclaim-based migration is attempting to optimize data placement in
> memory based on the system topology.  If the system changes, so must
> the migration ordering.
>
> The implementation is conceptually simple and entirely unoptimized.
> On any memory or CPU hotplug events, assume that a node was added or
> removed and recalculate all migration targets.  This ensures that the
> node_demotion[] array is always ready to be used in case the new
> reclaim mode is enabled.
>
> This recalculation is far from optimal, most glaringly that it does
> not even attempt to figure out the hotplug event would have some
> *actual* effect on the demotion order.  But, given the expected
> paucity of hotplug events, this should be fine.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: osalvador <osalvador@suse.de>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
>
> --
>
> Changes since 20210618:
>  * moved RCU part to the prev patch in series.
>
> Changes since 20210302:
>  * remove duplicate synchronize_rcu()
> ---
>  mm/migrate.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++-=

>  1 file changed, 89 insertions(+), 1 deletion(-)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>


=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_5BA34E9C-1F8E-4D7B-AA47-2D4663136405_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmDwd9EPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKskAP/iUqilPDEBKS5wAjBgK69ejtVlSr3ZP3D/mV
271u84qU2iHeAfTDBTwLJy8NMgTMz4IK+tBnEm9ar5NHQce2QZhw/ECNIA9gL/FY
zs4YVTDQ319kXBuJP1qDRtrrrmPhKA3XZGvs8KL8ujIOYbiZu88QI9RWidLOdQB8
cu6wZqkpwBlV9QXeNG9Dir9GWbZh7Fnug0A6osn6xs4XvEDkrBRB67whJnYhhYBI
XuKK0JSlnBv1DMpVEgi6k6A+NbRZNG2J1ksJMHPdHgjB8fweBL2XY0CUL1LWN0Wn
xhThFW22E786B3YM7Wh1PrqVlnEGWQJd1KYshZ5t/iHkAJtta0bPo+PYByIECo4v
TPeSET0QmQ5SO6KpxsvoSEmmWQIsC/Ak1h6/MrvaFUTRYp8ZWq8j050sUtor8yCT
kQeveng6AOaDWhGmtBPe/r2/9vtujz2Hwo0D3rnh/mj3fLrXBzaLjzo8+cK7iMD4
wZpR8h5unGS7W80B5ZigUMnR0dBLIblxH0uGcXWSSDxVIi4+YFvVUQJwvA5DmBj9
o2p5AHVqalXPHKWTXtjmF4/uJiWlW7FeX1ChvGmyOOznGGiWlbfAbwM/8TEleFpE
HfBZ+Wf0kLnHNz+NI85WuguSDLeWdUdA75fQEkii4JWaN5iIA4bLm3mfu2e5dsoH
Y0PvJ8XE
=1Ijp
-----END PGP SIGNATURE-----

--=_MailMate_5BA34E9C-1F8E-4D7B-AA47-2D4663136405_=--
