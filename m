Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA7032D789
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbhCDQVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:21:41 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10930 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbhCDQVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:21:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B604108d80000>; Thu, 04 Mar 2021 08:20:40 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 16:20:39 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 16:20:32 +0000
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 4 Mar 2021 16:20:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WV1OX2OT0VnMRqNPJ4eiM6rHyOKyg+v3pC6YbllpglagiSxJQWvWI8kZjN53K1tzbMCunXC1+CQCnAOuJnYGn/p8hJngD+foZ1XQd8IKijKLaWtk3/SVmy0PU8kdCpqditCMiMzO0LnkRI4q5M9ul+NcUFBqqxzECeewyzqKxOkz7bbKgOYms3PaIxrtpQ/r0eHbXaoXXcWtCsWEKueMeCu/MIGAGK9OfV/tsqorYR02zReNumyaMoDBrQwX4lbsRtKm7CAJoQ9173zDRuviFP6MnHHPTEP2pm2WM4JIRFQDRknESa3SMfHgQqK1vmMS90k7KlvfJ4ngUyzLNZSYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+niv7yLNt/1GAK3OZRjlXgXIa7nNCBY6ghM8KT+C3E=;
 b=WIlGVW0mawd+xMDLm6Uju0JfSWDVlVigZ/0sRWokibvywKFHVyuPDjA+LSo2KRmUltL2X+fA8R/hNXhrse9/yBYQp9WJ57ntdx6Pw+gluuqoN/uZDIdb+lg8Ic4Qh44tWu+57GCWmonLGoD+iEgcEALlSejmaTzrQaAt9AJqeyKb50M7AQPasKKkzrjUhI7PxbVnYdLuvvfocuyTmazZdN1+prwMdRI1guaR7Kg2ilDHVYvNwHPc4vfaN7vbSm6Xoi71Lf0h2yfuctXl3yf23NMk3WvRVBuLSGJd+mrTCbssMU2Vgna81Vn/+lkVYcdmRNezEH36pDWr+XY+Kpef1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 4 Mar
 2021 16:20:29 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.028; Thu, 4 Mar 2021
 16:20:29 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Zhou Guanghui <zhouguanghui1@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <mhocko@suse.com>,
        <hannes@cmpxchg.org>, <hughd@google.com>,
        <kirill.shutemov@linux.intel.com>, <npiggin@gmail.com>,
        <wangkefeng.wang@huawei.com>, <guohanjun@huawei.com>,
        <dingtianhong@huawei.com>, <chenweilong@huawei.com>,
        <rui.xiang@huawei.com>
Subject: Re: [PATCH v2 1/2] mm/memcg: rename mem_cgroup_split_huge_fixup to
 split_page_memcg
Date:   Thu, 4 Mar 2021 11:20:22 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <56EC63B5-B20A-4C3D-8FE5-35A54D1526AF@nvidia.com>
In-Reply-To: <20210304074053.65527-2-zhouguanghui1@huawei.com>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-2-zhouguanghui1@huawei.com>
Content-Type: multipart/signed;
        boundary="=_MailMate_DA2F89F5-222D-4A82-8B97-C37934588D4B_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BL1PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:208:257::16) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.62.13] (216.228.112.22) by BL1PR13CA0041.namprd13.prod.outlook.com (2603:10b6:208:257::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.16 via Frontend Transport; Thu, 4 Mar 2021 16:20:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48977f3c-3693-46d7-78ef-08d8df296d04
X-MS-TrafficTypeDiagnostic: MN2PR12MB4485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44855D7FC20B05A8E4C8C108C2979@MN2PR12MB4485.namprd12.prod.outlook.com>
X-Header: ProcessedBy-CMR-outbound
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2tHsGXLD73cFVjMzpwDWVBuJq0VSvJptgqsr9mT1k3PY3P3TBSSyFS7YDSC24lRopBOKcFx121iOJu00zy/pmku4bBj0ZRmvBa8E07xM8E2ULFDcgaILyYlTA3m+rYRC82I3PN8wKt3c9xFzjzqnSD1+rJDi62XEFORlH6GqEAldb47Vk4gIZWB+ekta2n8FVpVNsV9WFAvqDJ6JNBJ43u8Eg1EcJQfVfKX03nTRebPSOsGDSyPtexsG9plGMb3hyT7pmbLQ0tc0hX9C+skdXpGB+/IwjLAMp568Ffuji6h7sg/1NgUlxJyyHE4vBDxNi/rXhbS0bBOifc5WHCSzB9WhvqbvlpAGxtcn7EVJJHkPn1VhoS6VgB5acqKlxhAhwOHj1y4tmRg746cJdxTuiyYuisku3I16HilwyxufijQlEaKWKCWe8ObvNIjMSuQL7RKDNbAZNSdLltjAx9tmwrzp0qJmEhtkZjxFt8IFsh6NfMFs43+ogU7lopBtTnXCj2nhipx0jZueOEY3+2dfOh0F4SLTFBPTyhI5aN7axd2FazFZ7D4xiIL2J1Ex1PdVTsLWio6yxqKk+E7Lwf9HuDNnOC6MOxX9+RzZPzILtRNb4i1HI3Gt50jUK7I8+0A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(956004)(83380400001)(7416002)(6666004)(16576012)(6916009)(4326008)(2616005)(316002)(86362001)(33656002)(33964004)(478600001)(36756003)(16526019)(66946007)(8936002)(5660300002)(2906002)(235185007)(66476007)(53546011)(66556008)(186003)(8676002)(6486002)(26005)(14583001)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M3IxNHZ4WkcvZm5FNFBPNzFmRWpMQ0k1VGZod01iSGYyZGU1MnRXbTNiQVZn?=
 =?utf-8?B?UW14NjQ3bVhWV2p6bTR6enR2cHg1WEVvakZnUUk2VWNqamNjeW5PZ0hmSWlz?=
 =?utf-8?B?WUgxMGloZkkzbnJFbDNoWlovTUpyTjErR0V3VXBQRHlXNk5WWmFQQkxMSDF6?=
 =?utf-8?B?dFRPR0l1L1Fwb0FKZmYwTFFnRGl4dk9BVGptZlM0cTFWTFp0TXhMUGVVZ3hJ?=
 =?utf-8?B?VUJpWlFlcjNKOTY2MEtLajVYcjhiK1hRMDhTQy9WN2tsdTFRUmxTTDRmd3dH?=
 =?utf-8?B?Nkx1NGJ4citoMVlsbXhjeElPd2JZUDZJT3pJUFJKdkp1ZnkvbmpNSW1BYWRm?=
 =?utf-8?B?cEdHMldiS0RyS1NtUUFxM3JVUnFpVzVYTVFVRFlOcXNDVEJMRkxBOFdwUDM4?=
 =?utf-8?B?QWpjb0Evclp4VXY0cWVFYXRQSnNOeTZrRzVNWEtmZkhkTmJIR3hGSVhHWHBJ?=
 =?utf-8?B?T2xHVXBhTVBLeEdlK1lkeWs1RGF3eC9vUElsZHNUczc3WEp0d096RjEwbmhk?=
 =?utf-8?B?Um56NE5la0w1cXEzSXNuMDZmTkR4V0JXNkk4TGZVejIxZ1BSN0RFZGVqMlJS?=
 =?utf-8?B?RXQxS0l0K0cweG9Hd1RUN1VWNk9ldzNYMkZHaW1VYWVQZWQrUk9DVnQrTEJD?=
 =?utf-8?B?TWc3TlBsbktlbnkzMm80bzdpUnZ5VVRsTFAzR2RWbExCMmxzbG5GcXJxQlNX?=
 =?utf-8?B?bnZld2RDUzl2enVydUtlZk8xcU1zeVZieXdsWTNKdmhCTHBrSDY4UnZocXlR?=
 =?utf-8?B?azBWcTV5WmdKMGZTYTlFMmh6ckdOLzg2UytNa2V1ZUVzTmlIMml4ZVJTenBW?=
 =?utf-8?B?ejJqRzYvZ3Z2VUhpaFExb05UOW02N1ZoTGF6RWtqYXJGTXhkM1ZDdks0YzYv?=
 =?utf-8?B?bFZDTVcyWTFjbkwyTk9TZUNvL1VRYkx5M3VpblBFMUQvTDJnRUo1amF2SjU2?=
 =?utf-8?B?bTNDcmErV243SVdNVVZsc1RxaVhlWEtUZ1NSdWQ2RDZmK3B5T2hxWVI2dWhG?=
 =?utf-8?B?dmJsOXRGcTN5dTVUMmFLNVdaaUFTR0dreU43UDBFK0RxT2djUWVrSnFiYlA4?=
 =?utf-8?B?MmFNT1JIblBPQlNCbGkxc3FGWjYxYlV5RkQ4S1c4NUgrSVZ0NCt4QTlibjFq?=
 =?utf-8?B?QVpjUm9nL3VqSUh2R1czQVlZMDB1dytGTE91S0k1VHJzdjlLVVpaMXQxS0o2?=
 =?utf-8?B?NkFPanRUdnNlWWc3V1lCK0lZL0pFYWxWRnFXTERBbjJxL0diekJnOE41M3Zw?=
 =?utf-8?B?cHZtc2RuVDZ2ZXNlSWdITHJ6cnduemtKdnB0eXJMeHhqL1BiZklHV1I1d2U0?=
 =?utf-8?B?dFdocllHVTRsWE5jZ1E3SGR6bXhHa29TTGZaNVBaaTN6TjVUbE9iLzlPWFBp?=
 =?utf-8?B?dUQ1ZGVKVC9PbTNLbzk3K2ZOaTdvSWI4WU5ZNmpjdzQvbjFWbGN5dkM3ZjR6?=
 =?utf-8?B?VHM1TmsyMWw1Z2ttN3pWdVVXajBQU3c4blhnSGVLUTR2TGZmSW1BN2IyRStn?=
 =?utf-8?B?d3ZRb3FWYTFmVWFxT1ljVDVHWDNTQm1OU1lvcTdLUDhzeUhyTXNrMzBLRlY5?=
 =?utf-8?B?K21ldjJ0OWFRSG5aV2o1NHBHNDVkc1M5NkJPVjJMTE4reUYxZlVGdHJVVDRk?=
 =?utf-8?B?V2ZyK1N1Nnp5ZFplU3pZdGhXUmNrcHQ3djdCd0E3bzkxeHBLSTR0SUJlUEtr?=
 =?utf-8?B?ZUJOWWZzakhNVUtnK25ZSUJvQWVVV3VYSEwvS3p3bHlOQnFwU0ZHcnFIREpq?=
 =?utf-8?Q?9KX3QCU/7U4KmEldB4TRNjEfxDVGELJB5OXCJfC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48977f3c-3693-46d7-78ef-08d8df296d04
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 16:20:29.3775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBUb5TdPcdHLjGUsGaYKnLLs8jo3qRkyxVN7FTArDAt529oB/H90IfVVz5JYtkFE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614874840; bh=BfMgdh+4pt2ks//gd8xbwLXM8pYEpMYy1iiwxJVldlA=;
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
        b=Ae4uePqq/ADDQWajVge9lUwO54fUxewGEz4zVJmF6tzhk+q8wy/GNAkVG5vvkwy6x
         fGwc27cGkJp6+dwD1Z9uRekHsQ2JG9tEB39jfvxprVFGa6VWD6jiWfMvsLwaODC8iE
         48MZGuGX1G8rQ/IB5kPlZi2lXwPsfjZarU9BnrMkwn8zlfllaDcH5kN8s2+16nB7wL
         urZtQdzeVL4yDHXlF0PC6MgsU46leuodGseFN6KRCXVhuSsC3CI1iKDPpqdXpL9xyt
         Xk96ZYH1RtMEZuf1whrdin2xv0RuRNcO/+8g8LSJyry6FqjE12jl0ZnDTxQqti1vzP
         D9GZuQwKL+CdA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_DA2F89F5-222D-4A82-8B97-C37934588D4B_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 4 Mar 2021, at 2:40, Zhou Guanghui wrote:

> Rename mem_cgroup_split_huge_fixup to split_page_memcg and explicitly
> pass in page number argument.
>
> In this way, the interface name is more common and can be used by
> potential users. In addition, the complete info(memcg and flag) of
> the memcg needs to be set to the tail pages.
>
> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
> ---
>  include/linux/memcontrol.h |  6 ++----
>  mm/huge_memory.c           |  2 +-
>  mm/memcontrol.c            | 15 ++++++---------
>  3 files changed, 9 insertions(+), 14 deletions(-)
>
LGTM. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_DA2F89F5-222D-4A82-8B97-C37934588D4B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBBCMYPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKeZYQAK+ICNWqKOGHnQX+KhHm6JsKcRdJ1gP8dYrt
F5DgPmM8nh7e2l9gkC33y1BixgiSqP6VDFqpcVdBhRdstzTfqAS5WDxlK9KoEWgD
roe86GOTwux0/u6jZ3rvOsX3vf/zc5JtK88KaeWPXWZ62Ojz3+wXZgc0S5QRiJRP
x8Q2o0phxUz419ELXQsfTB+UihYMzw8g9LHFjPFvhhGUjwadhSlEnHXIRFgsmXmu
T0XgkXsRFjFZbNO+1CEPgxQcCmp1GCUJ427rak2kVRcqipQ5WW2I7uvoayw0/RCE
x2pEmhBcZ9bj4iF41UeFicVoyc/W1cTfTT1wSoMBJDMe8vmYQQ/MC/B3Q02oxvEM
VEMtXyTRflPxST18lodA/ZfFigTgdD4IVCgtDSx8VtgHAVSZKCPKe6d2ngVlCShZ
VI/ONXss1Yt0fzpLBeywn09jqdDFpjnPOuYvlfzuzq3InNMqcDymOcYvhlIHD1eI
0QW4NEAt4fIJl9ZRqczqA+8ZNUEgXeR8cznJH7/DegWwpF3QUqbQKzPCG0qMrbvK
11PT6636A/XtSPtxaeavv06jlBxMLSgcAx+UJYdPj7OfH4i66BwKvYWEIUmFYHov
TFI8BLiJkSV8KTMbJiIKIfl8kjacPukZcM6heveecT/bGMLkiYHhCz+LAwV8wceQ
Hm++B/rh
=3Yj5
-----END PGP SIGNATURE-----

--=_MailMate_DA2F89F5-222D-4A82-8B97-C37934588D4B_=--
