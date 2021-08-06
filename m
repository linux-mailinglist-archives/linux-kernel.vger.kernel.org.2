Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576CA3E2ED7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 19:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbhHFRTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 13:19:34 -0400
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:19328
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229480AbhHFRTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 13:19:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VM+hJMcI2Fcc0gWaDw3jcf4SKts4YxFhvYjwAUl+gm+nVjElKGBt/rI0sWAloUIhuOLGYZdpBDwDBoJkNHgKMcbjh54ycOgCyourOPUiwC02ayv/Z+wPs5Gd4wkDwEW1qzsbqDPxHkqpsucIFSO6fJwrEe1RkpZPqHHgXtdMO/kfivQRtNhZ8tOpZ5bhX/0ZwtG/7e4UlHtApyrWl3PbFQ2WTDUZoofdLYcthGjc8xb+aXsPwXbsVvYg7CJpGPbJhMArvhC6jtb9TRvpItNE0EZS7M4oj3Re0Q43fIW1mYRvzd5kZth+lM73QXuaC7G9uafgSws789FITOelAkyrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5jzpZKtT2r5Ol/ZExFEho396ajSa5q15LGMXIvFE2k=;
 b=iapu7+3dP/WbD93D1+VFe5pX6euKp52XWGA2hUAoD8xKZ1oO8uSg0qVlg19OLwokc5mqrp4bucSs0GWj0NGI+L5RGOuASmfvBMyqUS6gq2tGcaIXjo3kwGMg7R9VS2vI88lxrza+5sHK74CVdNQh/PY7yW+LGkdKTA6BFeONN5CCgdmqsxWoSHr8ExinrHtC+eKUrvNK42nyEe4ryVqt9Lf7sGPMTl3NZrIfMZHcvHxSTAI7HyK5BfEItJkkMuOQ0eY9c9gqq9xfu6dAnkEzxBlz6T09qV1etkCuoaa7rHIcNb2rxWqPHGJ8KyD1TDTwJ8SU4ObviEC/jwVgNmrRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5jzpZKtT2r5Ol/ZExFEho396ajSa5q15LGMXIvFE2k=;
 b=jo0fVVVxFgdmnJTOSwhOKgYVqDMFau2Lq/cT4pwcQ/AU/m7BcgYcJPv6Jhife2tNLUXsAnha8hMu2mS1ZUrOqDH2RCL2woSIGKSmlkgPkQ4PlsU/cj81ShsgEUJwL8SJX4h5wO+Hs/+ATrdrFK+3VSjGQ6S5BO9t9OXYfG0iv+aiYpquCH8SSwST0GTxcgQ0rEjlV2P5zC5yv4lPTKyLikAN1ebz0IR5S3WXJiXMcIf1qiH0s6xrZx1cOBf2D/IVSlbotFg7fM82DMyn1Vw6F06PrnrXnk2k71is30Xge46vfIX7pv5kOhDjW//jvu621dBju/t5bn+lLTkqGeiGEw==
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Fri, 6 Aug
 2021 17:19:16 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4394.017; Fri, 6 Aug 2021
 17:19:16 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/15] Make MAX_ORDER adjustable as a kernel boot time parameter.
Date:   Fri, 06 Aug 2021 13:19:11 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <F34DBD0A-22DE-4CF2-B784-BBDD80A8E85A@nvidia.com>
In-Reply-To: <0d374eed-cc52-a656-b338-1156782bdf7e@suse.cz>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <0d374eed-cc52-a656-b338-1156782bdf7e@suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_A6778D4C-44BF-4F9E-8C75-FB63A0CA9E09_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:208:a8::21) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.50.235] (216.228.112.22) by MN2PR12CA0008.namprd12.prod.outlook.com (2603:10b6:208:a8::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 17:19:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dfc7970-abd5-4be2-9706-08d958fe51b6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4487B28B8C251760FAAD888FC2F39@MN2PR12MB4487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNnwhdN30p05CvXXR1pv9TqYn2i7dvPaFHkLxkn/nhYU0ZduB0e8X/6WNfHlotAo0WNNToMtvLdsGyRNJNTyDoifKYRUQ5b7TrrjaA9od8vj6/7V2+fdA5/w7+/bz4PHWgPR95GCjvDQiEWrdu3FWmMIMHoBpzsZBSG70cwSoHbdY77//84WTer1q+oEe3m+k+5IcWiaVWobfNGdr2PvmAdQbMaJckKUDKKx+rmEP6p5Rt8PU1WsHzh7TNoC0YS/ZwjEGWfO5gWjMfySbvC8TOlUwt3pYxQRzEI3xALex4gJmVoldVkVNkC2kB49YV45lD+JgZ2GlRwoljlQ4kGrW3KjmqX7rtY/y0pdioGE1Qfm9F2ek+YRIaV0o5hixUkneyEyk2KKMfp87tfPWAHUh1dAKagEDYZx+gXIhdokqlUU2R7+bvtgUWMLPKd1zrJrJBDvZKy1znmZrsI+5LsWk5geQOYjr88c1zjRjHKQS4D4dt92wrprexsQw261OFN0uBM5SRNmXktDkDcFuuKw3kYYYBUCxQnA4MIsWqDjX5cbUIt1P3I1tflRD/rmzyQW87+W3nTRx2jciRw2iJXRELeQ1ZSvvF0fwptSlNCO7D0T4v/3TZvnDdqLHY4y9k8REUc3UdSy34tTaIA7j+E24xkcfxGLpzPjjKPezjxYdSsoH7nZ7sHeXXhuXT6axMXVVCmm10LsxGZjx9lPm328TnyjYDSbP7RGo4/lxLAPC0dJrZ6SyA8i+e3KZn9rD/nF+xA//iwqaO8K8q+q//eA28lsUsWce1n0kN/UzCQ3NDNSHmGw1GrOCNt+aObgbDi5cYCVs4ab59hRfmiekhyUfsuFer1Z8FfmN41T7QARvFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(16576012)(4326008)(8676002)(26005)(33964004)(8936002)(6916009)(53546011)(86362001)(186003)(38100700002)(966005)(2906002)(66946007)(316002)(21480400003)(83380400001)(33656002)(5660300002)(6486002)(478600001)(2616005)(36756003)(235185007)(6666004)(66556008)(66476007)(54906003)(956004)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkdGOW8yK2FLZ093Q0NwSEJwN244MTBTWEU3cHA5RWJlbEFoeXJYZkgrWktY?=
 =?utf-8?B?R3ByMlpTcTNCL2pLYnMrdFVpUnJQaVlCb0sxYzBjSkNHcjNmY2dpVVVLRitG?=
 =?utf-8?B?UXJld1VUbTVRTzVMNHJQRHl6VnhLRjNDUVdTQlpkdkNTdktvZ0l0TlJrU3Ro?=
 =?utf-8?B?djJWdDN6bFNOOSt5SUE3bHBmdVNPLzZ3QmhzS0tzT0RNczJ5dGlhaWR3bndI?=
 =?utf-8?B?QTlwaFNFQlpXU2dQOEQwVnFsVzVLYzIrUENobXFOUS9ZSEFMSzBmb2hBNnMv?=
 =?utf-8?B?WUt6d0VkZ3BhaTJNa2R4L0JBcXFGVHpNSHJHNWo0K3ZhUTI2QnQrZGRSMGZP?=
 =?utf-8?B?aEZldXIyUHdmMmgwOGgvYjN0azRiMW50UnN0WmRJaFBTNnBONmEzTWZKWDY1?=
 =?utf-8?B?ZWN3b21BN3RydmlTUFcwazIvNmp5K01qRjZlMUdpZUpqWElka2srcjJBbGxB?=
 =?utf-8?B?YVhseWdhMlpKUE1JR3FMWGpYTWpoSzQ2dXh0N0ZEODJYRzdMTFBPR1VweTRG?=
 =?utf-8?B?S2k5VW94dC8zU1BXVHd6L0dJdHNGYngzMmtJN2ZIeWllZnJiMVVzSkg5T0hi?=
 =?utf-8?B?WElwQldUb1BLZGVUcHk2M1ZsdlRJUjVWeFpMZjRhd3d4ZmZjV0t6REZEUmhK?=
 =?utf-8?B?N1VRR1RnYjYvVkRBQmE2ejJzTDJ3RDdySnErenFhTm51dFpDa2NhNGF3WnJn?=
 =?utf-8?B?RkZ1WmkvVWxkd2pXVjJFbWIzcmRVejlpSGcyZDVRcUdUcUZNTHEwVXpKdUlG?=
 =?utf-8?B?aDJOMnIrSHJ4NktuNEkwUytvMkMyVlMzSFJ1cjZkZVpmQ0drenJuNmR2K0tz?=
 =?utf-8?B?aXdpa3hSWFdwNkNXU1l3dmovR1BFa2RkTWUyT29jSy9xbVB6cEI0b1ZrU0tZ?=
 =?utf-8?B?NnRGTHB4d0dZL3dXVk5lUms1dWZ0ckcybDNwbFdaOHlEU1NtbGNXNzBibmQ5?=
 =?utf-8?B?WTMrMVIyaldzRit1bnJZVGp4bGF1NHJleitYcFlNa241Z05TSU5pTzFuY3h4?=
 =?utf-8?B?QlV6SUNwbGNHRHJYalJiRHhScFpkV1JlMk9NUitwL0g1MWx4Q0pLRUNDTE4v?=
 =?utf-8?B?ZU9abWNPZ1lDcnBibG5aNmxreGhreTYrRGZMYWNuanJ4RW0wYnNJR1ovK3F5?=
 =?utf-8?B?V2FIRHg3cWFucS9wb3gzNmNXUmhOb0ovOC9abUlXKzNySGs1emxKWm9LcmE5?=
 =?utf-8?B?VGRuVlNQWDYwTVVNMVhTVG1PbWRyank2UG1qVTRwb0t0V0xxdFY0SlhPSVBn?=
 =?utf-8?B?VWlmd3R2c29UWElUTTJxdnJRZEJ6eTFaa0NEZnNZK3RKUTNSR3RhaXRDbzFq?=
 =?utf-8?B?dzFrV1ZxQmlTTW5XaXN3WTRNRHR6Z1NHRXFQVzdqQXZkRXBhSWlvekU3aDZC?=
 =?utf-8?B?VHVRRU13dVNLOHNVcDNodEw0cG16d3l5R0FIbXRBN2tJbWpUK0pUTFdocVlq?=
 =?utf-8?B?bXBud1BNTzhpWFpPSk1YSGl4ak5LbEpxa1RGOThsQUcyaWl3VUFRdTh2VlF1?=
 =?utf-8?B?WGd0eC9SLzYzVzRiNENLOWErWHlqQW1JOUtvNVdJRUVTdmswcmk4Nm1QUzFC?=
 =?utf-8?B?WGFjN0lGZjZ6UmorT1FBb1ZNa1FrSm5GZ3B4MFNoVVM3eTRBa1NvQU0xbTdn?=
 =?utf-8?B?U1BGREJHeHp5bnU2WGpZU0V1MHJiUFdyM0djMTA1UTRYTDI1NDJ0UTNJZld0?=
 =?utf-8?B?Q0M2bm5PMkcyL3VVcDRJVm9GWU90WjFWWEtsRkZ6Q2pyMUZORDBWaGJPcDc1?=
 =?utf-8?Q?WaVn3WLsHifRrbz2bHXB7pWykjdJLZzbwcIZrrU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfc7970-abd5-4be2-9706-08d958fe51b6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 17:19:16.6833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2px1NJNA10GMTaVzUcpTTP3fEgKXZrABryFPTwPseubauJ39Ob07B24MrCZCUWS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_A6778D4C-44BF-4F9E-8C75-FB63A0CA9E09_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 6 Aug 2021, at 12:32, Vlastimil Babka wrote:

> On 8/5/21 9:02 PM, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Hi all,
>>
>> This patchset add support for kernel boot time adjustable MAX_ORDER, s=
o that
>> user can change the largest size of pages obtained from buddy allocato=
r. It also
>> removes the restriction on MAX_ORDER based on SECTION_SIZE_BITS, so th=
at
>> buddy allocator can merge PFNs across memory sections when SPARSEMEM_V=
MEMMAP is
>> set. It is on top of v5.14-rc4-mmotm-2021-08-02-18-51.
>>
>> Motivation
>> =3D=3D=3D
>>
>> This enables kernel to allocate 1GB pages and is necessary for my ongo=
ing work
>> on adding support for 1GB PUD THP[1]. This is also the conclusion I ca=
me up with
>> after some discussion with David Hildenbrand on what methods should be=
 used for
>> allocating gigantic pages[2], since other approaches like using CMA al=
locator or
>> alloc_contig_pages() are regarded as suboptimal.
>
> I see references [1] [2] etc but no list of links at the end, did you
> forgot to include?
Ah, I missed that. Sorry.

Here are the links:

[1] https://lore.kernel.org/linux-mm/20200928175428.4110504-1-zi.yan@sent=
=2Ecom/
[2] https://lore.kernel.org/linux-mm/e132fdd9-65af-1cad-8a6e-71844ebfe6a2=
@redhat.com/
[3] https://lore.kernel.org/linux-mm/289DA3C0-9AE5-4992-A35A-C13FCE4D8544=
@nvidia.com/

BTW, [3] is the performance test I did to compare MAX_ORDER=3D11 and MAX_=
ORDER=3D20,
which showed no performance impact of increasing MAX_ORDER.

In addition, I would like to share more detail on my plan on supporting 1=
GB PUD THP.
This patchset is the first step, enabling kernel to allocate 1GB pages, s=
o that
user can get 1GB THPs from ZONE_NORMAL and ZONE_MOVABLE without using
alloc_contig_pages() or CMA allocator. The next step is to improve kernel=
 memory
fragmentation handling for pages up to MAX_ORDER, since currently pageblo=
ck size
is still limited by memory section size. As a result, I will explore solu=
tions
like having additional larger pageblocks (up to MAX_ORDER) to counter mem=
ory
fragmentation. I will discover what else needs to be solved as I graduall=
y improve
1GB PUD THP support.

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_A6778D4C-44BF-4F9E-8C75-FB63A0CA9E09_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmENbw8PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKuZAP/3VtTs9hAFSke3zV5bH1XOfP8eW+Y0LzgpyV
CHiwalvOPYVMOWjXJO8rczXiOXKpJRu7NJi9Cxresdz04lTm4qt2Fsz8fV+lzbMM
gF+asqmqiBNRTxI98FDKJ5rDCJPgxLIFeRK2wjWn42OKcFVP8sGXvFlAudiRyWUM
nfRe46TKDWB1Va3SJA7yG6KDidsbSSEtBVN5o8DG9r6MGQMt5E3jesiAKTHQBxcn
RiYUs+wynJFl01oyW/xsFwDYtfemVGfCjxSiGFAnX4CQOsgxNPAc93oc1CTJSqVB
BeSkYcS6CpPNP+DpUqubRiV1NOmpFMSLp+/ChFldUQEAEKn74+ruQBr4wEN/D86E
+Jxw7uluM8A3aMPZexxB12aSU0cnp/bLfYMjy1s9bkP455PtB5FI356hhkzj6+IC
M9a3X6AMaOrojLgrsdkNZEb1QlOAkCAqCWoYta9jhngsmVJtqfTh8b0VITbjHrUQ
jnaLEH+dM/yXLqo4YmVHyTYUOMFrmTI0PzNDkTkO/xMk+JAY8vlB6zkgKiwzLOb+
lpzLfUc5kAXjr0bPtVEdJ0sV2y3NnnN5FYg0HfsWTYTrmjLaEK6XNNYcg+cw5O2b
LSsFdHC/3z72veGr2LvaqWMaOQO7oiGL0GPC2V3uowXJ7Up8KYVklbr82vRYjU1g
yYnFscdD
=ozDo
-----END PGP SIGNATURE-----

--=_MailMate_A6778D4C-44BF-4F9E-8C75-FB63A0CA9E09_=--
