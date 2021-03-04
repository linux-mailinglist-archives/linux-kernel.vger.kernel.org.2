Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB8C32D79B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbhCDQXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:23:18 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14630 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbhCDQW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:22:57 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B604109380006>; Thu, 04 Mar 2021 08:22:16 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 16:22:08 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 4 Mar 2021 16:22:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ7bJedzl4+8WhWCi5hKsoEkstnzzJVmhwPFk1/YN6bFE7OIHWI6f+dnOjRnVFq1XHSmB9LsfY+Xore7rRf3GY6J4lT5gkwUb5SIcC50wtUocwMLSMHzgQ7+NUjYQXOKS2TN5XAyUeajmN2Yv3E+5ag7gTW2MidMQ3fqqHhsuxgtBYlJZGpR5mRmPxPwpH/H4aVUcYdJyS9CqRTpqNZyJzDUJnsJxJ9h+9+qkTx0VrBG9LCAIHO8pnr7LU6dFOACCuLcAsIeS5IB/ZOoFdWZKMicpAEjgEuIGohyMJ6gihnbJ0Drd65KLRAz9DW2VKVWqVbVL2ombrhYNeJ8Vsy78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB2XbUGRGAKXreWBQoW0yKPPORn+8H1pLVmFOmWTEXc=;
 b=MCNijZtmVxk4GLxCgqUe+taO1TShdMsDAJaUuNo6TaRVQjO83NENHMOi6FxN/if7I1z1AmTg1VhcxueCwEJ9ODw9kO7uHvXiZpc6WbfzXoTswwbR7l7ZdbKZBTwrszDc2ZYT2EXDqH76a5rmDZnK3NU2wBPIsWHd+bPL8e0LvjIKjYtDNWqQbXIJQilYisM5eqHdMJr6XWlWK3tsYJ3FOUtGMP0cOE9HtZelVNZ4nXltNpMM2uzvbnAirBgMwxiCgMokglCf7asWIsUmOGyN06hqDhmad3sFOnKdw2vAgeu3fCEI59dnKTwkOZroWNmCwinPfqQI6emgYDPF5QK+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 16:22:06 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.028; Thu, 4 Mar 2021
 16:22:06 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Zhou Guanghui <zhouguanghui1@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <mhocko@suse.com>,
        <hannes@cmpxchg.org>, <hughd@google.com>,
        <kirill.shutemov@linux.intel.com>, <npiggin@gmail.com>,
        <wangkefeng.wang@huawei.com>, <guohanjun@huawei.com>,
        <dingtianhong@huawei.com>, <chenweilong@huawei.com>,
        <rui.xiang@huawei.com>
Subject: Re: [PATCH v2 2/2] mm/memcg: set memcg when split page
Date:   Thu, 4 Mar 2021 11:22:00 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <30B45037-03C7-4211-B772-78CB5E349303@nvidia.com>
In-Reply-To: <20210304074053.65527-3-zhouguanghui1@huawei.com>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-3-zhouguanghui1@huawei.com>
Content-Type: multipart/signed;
        boundary="=_MailMate_E404728D-536A-4430-9BCD-536AC9330797_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BLAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:32b::10) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.62.13] (216.228.112.22) by BLAPR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:32b::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 16:22:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8f40629-5702-4d5f-b4b8-08d8df29a723
X-MS-TrafficTypeDiagnostic: MN2PR12MB4423:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4423278205030FAAC103D53EC2979@MN2PR12MB4423.namprd12.prod.outlook.com>
X-Header: ProcessedBy-CMR-outbound
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SOv49k2OdAi0OJG9PQETaeshhCRPjjx/UB34PP3rYvLoScpVf8rs52mw68IqmzX64RF02Ahq5KQVcauyBiHG2W27gVL+IfwaLJx3vfa9cTmvIvB0vyQjBWxpEeLXwizobdCJVjDmyHcXTQUldKOGV7hklZl6gKNWwZAOBYuDiOV9EGEj2SzCPRS47w3EnVIMg+qdzd8x3HEIa7i3q10AizJjS7mMJI9UiOqzgDNbIaQ2I2GKw3EjNZaF09oHf7/hFRwgkHN4qdmLeHgJCuw3fJ3r4efHN/XAuWzaPhmzbpIJDyEtpmiFtNJzolc2/QzCopMXSMmjNbqU4R+vGagIICYRFzeju4kz9mW6QfB86AogGqgxZRPR10a4JOcxUKGOSs/0ehFyDhADNPm0Af4OZWAmhEReX/9hnr21JbrCdUubPghWiHXm1L7r6X4ioyB5yspcObDUbvfRVz7JX24r3OV+BWGYPV3kMVlflIueok110ubN1GRpqd7EKCEoybQGO9E13IXWFKhDq1ZKJHV7FAopVM5jqfSMR0c1uzWckD1t6AB9imLM26Ca8TbZnjB4w7L8qPWLXjaDgX4OS3dnaNgFLhv0WaRvxFWopvcOur8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(53546011)(33964004)(7416002)(33656002)(16576012)(235185007)(86362001)(26005)(66556008)(6916009)(5660300002)(66946007)(6486002)(316002)(16526019)(4326008)(186003)(478600001)(66476007)(956004)(2616005)(2906002)(8936002)(36756003)(83380400001)(8676002)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZUtLRFRCa3R6NUhyamZHMTQ4RFU2QVVCdTR0MWZ3UE01MXA4QUhhNTFBQWxB?=
 =?utf-8?B?WHdlditqUDU4Q3d4S1RXNDE0N1lnNEJZeFNpZkVTSmVWaU9CYTdoZEJHZnh0?=
 =?utf-8?B?QlY3QUdPY3NIaVREWFErK0FHR0I3cTZ5RkF3a1RKczAzTlBvODduZkJFdk1Q?=
 =?utf-8?B?QzJyYkMrMSs1U2VXY244TnhQNGtiT2VTeEIxYzU3eTlJOGMxSTJUdWMyTXhh?=
 =?utf-8?B?Vmp3cWpiL09ZMEFqeGJXa2l0c3I0eEl1TWxicXp1M2dycWdYVkJzYVd2eUFy?=
 =?utf-8?B?REgwc3pJaGd4dGNqcDRJWW9LYzRIWjhaK3Yxd0JtMk9OTEx6NEJJT1VRYkF5?=
 =?utf-8?B?bFNRa0QrY2RQRk9aY3J6N1crbjlpVm52RDdvM2FpWTc1eWJGTjRPZzl3SjBX?=
 =?utf-8?B?ZFMvNzdCWEZjSHRmN29hQXRBT3BmQUxtd2ttRU1vZ1pxNGRlc3REWHVxVU5D?=
 =?utf-8?B?WEdlZFhiSWlrcWdSRStsYXNoeFlWbUU3RU5UeUZLd24vei9oQ1JxUnBjRnZG?=
 =?utf-8?B?ejdhMysvS3hQbk9GNGJhazBQZ0M2Q1RLcVRINHM4dVo2NUVyeGZVcUFLU2hr?=
 =?utf-8?B?eWo3OHRBY3ZiVVVOMjdhSWl4VW16NlVNdWNHbndlaThjNklYWHNGcy8zU0NG?=
 =?utf-8?B?TlZtV1VNZ3VvamY2T0ptcXNTeWJTbVhzS2NJZ20zZFFNdXdwWUFaSWtKRVYz?=
 =?utf-8?B?YzI1S3I1ZDY0a09mNEo2Zm1sS3E4R28rMjhkVm9hRzJ3VHFob3FYWjkvT0lh?=
 =?utf-8?B?YWhxYkVWMUQyMTA4NFo4TGx6WVFFUWZuSlhrMDBlRHBwdjJrUVV5UHNudjVm?=
 =?utf-8?B?VlYvUHZPWTYxWGQ1UmRWcVdDTldmRnRjWDluZzN4TGtGd0Z0dUZ1NFFSalor?=
 =?utf-8?B?VjdHNmdMRUtaNDhuRmFLRUttaVQyS005dFl0UHdwdndaeFo4ZDFFSGZyM3VG?=
 =?utf-8?B?ZGNZWmx4cWN0c1N3MnhNOXhaVDZXQ1diVXVsUTFZekhBaXd1dENMamEzTk5E?=
 =?utf-8?B?MWMzMFNqMlFoQWVmRG9HYWdwVUwwVitUZXM0b2FhOHBlZDVwOTFmSXhoc2dZ?=
 =?utf-8?B?emhlRXNSSVdMR2ZuM0FoemtHclJYcTlSSnR5b0R5eTduOGxwWmRQdUZDWjkv?=
 =?utf-8?B?YlFQeGFGYllaeVN2NThBZ0JPd1g2UVNRWkN1bUZmOTF5RTZ5TUhxdDJ3c2Qr?=
 =?utf-8?B?NzlneXF5OGRieG9FOUlKeGZoSW9xOW1udEgxMW92YTdBdFVONHFHSk9LYU9Q?=
 =?utf-8?B?dFVwUjFJcDZYTnVnc0lVeXFScDd2bElpUlpTSnBDNnpHakwreHQ4WnZFUFBw?=
 =?utf-8?B?MUZyUEJMdDBJR25HKzdEVkVwN2RtMTVpbVRQRHpZMjI3MCsvdk9xY1M3c2pN?=
 =?utf-8?B?ZnBrdzBLWkdwOEhzNjIwSEdvTlJPL252Z1BKUlgxOHBhWEhmemNDZ0g1Sm10?=
 =?utf-8?B?akFZL05DaUlWUmhvV1pZQXdDMDRVZ0tGVkVLS0IxUy9VS29TRUxoRGNiYnBZ?=
 =?utf-8?B?SmFFQ2ZPUTRZV3hnM2JWWDFjTFRJNXpIVDA2VjNzUVg2RjZLNmtBSVF6Z1F5?=
 =?utf-8?B?ZkZEbnAvKys3UVBNSzgvd1ZndVdhaWNkTndnTmE2dGpqYXVSY3NmZFo0R3l0?=
 =?utf-8?B?NURIUENBaGxnOExMS0lLSjRqcm1kSDRFVGtaOUEzMENIdHBxeDRuK2ZDaGhk?=
 =?utf-8?B?c3k5eSttUmFRcUlxeWdLd2F3THI0MTBOTDJyL1h4dkdXbURXR0czbUp1aVZM?=
 =?utf-8?Q?7V3KYNk0r2ZkMfAMVGwQbg4Wstd6WmkUFVKQSMj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f40629-5702-4d5f-b4b8-08d8df29a723
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 16:22:06.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jjxmEaCgbrGPcmPpeClJc3a+Yl5NOZP4VmsiMODNYqbl6AJkx2fhj4TNAzkC4xl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614874936; bh=5+Ct6tatiEapXwVFje/AI9hyxfOcM3p406Scb4BgrlU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:Content-Type:X-Originating-IP:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:X-Header:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=EAkX7dJciNlglQ7dJhwwV6wJRRF29UBicBReOoK6sSgtA3yriEtIMxXZvi02EoSSn
         dwg38dpJn2qYr3rNniDey7NpkLKw5LbPNcBPSWuLFLaRv6a4N7pe1R8FQb94ssg9cQ
         1MhfUGQewjVge+H+ko+MBKv8maCwaOTZrYm1E8VH0FMs1A37ULf+D8lkaAaQp7eD8v
         3RXJh3qIT8jm4e+W7KtXtv0XbT0ioQu/1yV8vmT3SujtlN8eyIVaMzQFTYjpjV1Iz7
         Rw2tA3rM0NtIJiVkKQ3na0wdZVRyiazye6BK8iGhgumsnmjEtXdJPsEA9XcO6SoIWg
         mbhWtXuJO6Aow==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_E404728D-536A-4430-9BCD-536AC9330797_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 4 Mar 2021, at 2:40, Zhou Guanghui wrote:

> As described in the split_page function comment, for the non-compound
> high order page, the sub-pages must be freed individually. If the
> memcg of the fisrt page is valid, the tail pages cannot be uncharged

s/fisrt/first/

> when be freed.
>
> For example, when alloc_pages_exact is used to allocate 1MB continuous
> physical memory, 2MB is charged(kmemcg is enabled and __GFP_ACCOUNT is
> set). When make_alloc_exact free the unused 1MB and free_pages_exact
> free the applied 1MB, actually, only 4KB(one page) is uncharged.
>
> Therefore, the memcg of the tail page needs to be set when split page.
>
> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
> ---
>  mm/page_alloc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3e4b29ee2b1e..3ed783e25c3c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3310,6 +3310,7 @@ void split_page(struct page *page, unsigned int o=
rder)
>  	for (i =3D 1; i < (1 << order); i++)
>  		set_page_refcounted(page + i);
>  	split_page_owner(page, 1 << order);
> +	split_page_memcg(page, 1 << order);
>  }
>  EXPORT_SYMBOL_GPL(split_page);
>
> -- =

> 2.25.0

LGTM. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_E404728D-536A-4430-9BCD-536AC9330797_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBBCSgPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKuEQP/iZMWuDDrCrlaFuI5wt0/wbidNpW3946bXRI
ZjjlrIoNLFI7ueByBvbqkgobZbd6FdNh8dsXBCT4aW8KNRTrlX9Hpvs6aZitLN2B
i5M3F2J2R3rt6Fjih2o9lV3jxurPoNBUFpxjpUIuLc4OTvnKaj2vBcAptyNCi3uh
b1EVYs9wxf6BBDfAKWfuPgMYgGTHYfNWEAvK6lfusdAED0UAggITjAhXqJFBjVqm
bOGABCvl5d7Hg7le1VJNAYsOUwqwAKEyKuHnoGieYmqBbgrdnplha4ftPBKUAS/L
PhbuGRzCiaznUpq2JvshZsCy8E0yYtAiTQLCTTEAaOsWITbuvNxTtk1yA6MVF2A2
KE0f2CYyUdcKjdAJFD4KYeHwd+2iGxfSbYXrvHowg4o42iDu5Pw8iQjHQ9Y2nk/U
3Vs0RtQA1OL3fJPcTVdoRx9zhET+R4C+DPWufK1/HIypXDlcEpiyb7TK4l8+Qt1/
bTHNuosyBY9BqH4ka2QbM+VwUj3diXplV4xPr/sFQL6BCd+5tjr5GwEGJJ0cH0GK
zGhtvfmdKi3Pp4fR5Z1yoe9LJyTs2fufZInQftR8456IOwP7Y/reW19NMdVHocc9
Cq3rvmB8de1XAwEMQ6bdZvmoR5nzCEU4A2XFK1ww1Z3A/RlN0degRN+2qY5cWcAG
1eYNvmf5
=fTCS
-----END PGP SIGNATURE-----

--=_MailMate_E404728D-536A-4430-9BCD-536AC9330797_=--
