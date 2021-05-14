Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AA0380AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhENNvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 09:51:41 -0400
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:26592
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230121AbhENNvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 09:51:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICXyzhgTT6+XTBwCIXpDuU2biFbmSZlO9s0u0J6M51O+vhDIRypUgmq5mJtzjd2HIx0gqovVeIqHC7g/FJjsjXgqKOyyIa1hLlgkQPEvFmedNmPtgE8tXUf7Xx+tym+uj8lpPpAde/7te+1vJP8skLW4PbDjWf99sdpyMVJDgnJe9s7X7YCmnJY01tqbexzy5jxuwfPCWFlOXhcn8PQynRuUCSP9l3Lbx5PNl0KFiMtOhVgS7uxLYn5bb4pak9Jsuo0ZjdYggFOod3qaaf0kpTjQfEOY/UclFqwyMdn4keA9PlGRC+dThojY5rpTn7o1y5PiampzK7J77/ZTtVlhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ce/De1IECszkmsDMuudAD4Xdx++LZyZ7ox7MvfSO1gE=;
 b=CVbaA8+rVjDy50W/+EeQRX198LA7+yRVzAlDRAKKy4Eh5sRgWs2/or2VjVNyL3eK/8ry5p0Gvcf3aOfI7izicVvLnuL8guwlLOkJBz/j9c6+vquCpdEUKTj4gjzCLc7oNWsEaRkRI83WPmCKqjpJPO5/kLtPgl8Px/Z+tX/3zCswtIPDnN+K4tf6Eq57xqF0mMfIjEFN69U3f/msoF67XuFV3MNu5S3C40G+R7XSISPmJ/X2xziF9hhDGwn29vyq8PAYGOccQGjKC0Szpti1c25LStz8cyKX12caEvNELUoXZcfAD8al8ypno+DvhoYWAOT4pozZHBt+FYYaMA7seg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ce/De1IECszkmsDMuudAD4Xdx++LZyZ7ox7MvfSO1gE=;
 b=LWv6fQBgUK8mPkykSazxBliT0RtJanFt+uOvbcXSZT9xp9LpT2rX6B7le98C+HjNpUTNjEtD5zG/ePVKWM6jRcoyv921VT4eg2jZd7wsfEq/8BffIl44z2AbCkTnzz8wU+NZyUBvgl3+1gTe7Aim46iiecSEtcBQIOF5gNHFXIdK31XUHWQ0IM8jjG5/3QfyfCG+C66T12FzJNmu4KpNPHRC5sMhb+rUV+N2ztK/oMJ9AAeH8R98w7mJ0dKkL6Dg+kDlwKiZKo/kbSCvDEkQBOr4ceIVWW0+1phbRLlqQEmwlkq40Ql4ox/j3AgbDZPgf3nS1zSoszV8nRbXXHJmRA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 13:50:25 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2%7]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 13:50:25 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     kirill.shutemov@linux.intel.com, wangyugui@e16-tech.com,
        hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: thp: check total_mapcount instead of page_mapcount
Date:   Fri, 14 May 2021 09:50:20 -0400
X-Mailer: MailMate (1.14r5804)
Message-ID: <1E27805A-EC1E-4FCF-8C68-DA66FAE14E07@nvidia.com>
In-Reply-To: <20210513212334.217424-1-shy828301@gmail.com>
References: <20210513212334.217424-1-shy828301@gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_5E37C9FB-9F95-4CDC-8939-07A1410F32EC_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: BL1PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:208:2be::31) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.60.96] (216.228.112.21) by BL1PR13CA0206.namprd13.prod.outlook.com (2603:10b6:208:2be::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Fri, 14 May 2021 13:50:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b57ca9ce-aa0a-4853-68a4-08d916df39f0
X-MS-TrafficTypeDiagnostic: BL0PR12MB4849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4849C20AF76137549A84459AC2509@BL0PR12MB4849.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHeuK6GyZr24cTApombGAcQZyS69QMpCQbCPiqcOw4rCcUfjTeK4TYqlsjPuehZ4LoXgzcJ/Kuo/s3hxZHc1Phx+KbSssZK5rUvxzJL4gBU+E/296+ZTcna3Dc4Z/S/WSv61mrbXWAfPncZUc04MbGBic0cMj2PcpN/zxYnUZzsbscfKcE82P/nvFy0c2a7LVZmYUEYK1TKnnjliohLFgPYTIDuc1IZAmLjqkc0pZr0HlKieOGso3TJI6jBhU5N0NBFJTh24EkG3lMy3rtadWJk3pCCQz41VpG4RX+CV5p9haPGZ+2G1DRl8mDKwO0QdGttERA3Ip9iKfSlWM+8rCdCCUeV9DVCpxOgw9f0tVlH1SdoPaTT24seharVB2ITqSSFF2T7Yv3NMLgQulyc2+3Co8fWQxJr/whjWQsxbazoX9efwLIQGRrf/Z+QydEroDAAceQLRllfr6HLacxzmygBIexcF5B52LEzaiT2jyYUXQwqEMUwLt+JRrRmJ/7ktCLkxAcfekqY4SqGZ6LV+7CBtGRYEY5L31Sec5+uL0FX08V3A9KwibES8KwPuXQoVe7Tz2/7x6Hj7fPUemqmnMIyMOtjGe9NpAv0l8oS7Tc5IIxdIiCtl0/1bTg5yMW7/qasNwfP9Pq3K6+QARRMa5g8fZKUZlzgXdUmFkzdlKGaRt2qEHVUacp+OiNsmYLvqrDEUz4mvBgvyw2n3/p73h27+NiC9UC/oogVjv/USolefIFLrukGFkBJotAAWEuqK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39850400004)(136003)(396003)(6486002)(4326008)(186003)(5660300002)(16526019)(86362001)(235185007)(8676002)(2906002)(8936002)(26005)(956004)(478600001)(33964004)(83380400001)(316002)(38100700002)(21480400003)(16576012)(966005)(33656002)(66946007)(36756003)(66556008)(66476007)(2616005)(6916009)(53546011)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NnNkelhkMlYvOU5CbEEraWlGR0hYRE1BNjNqeFhYQ0pGSFlIamRMVE05V29U?=
 =?utf-8?B?OERSMW4wUk44dVdFdjVJeC9vQnNjUWZURVBLM2d4eHlubzJZSUZEcnljTGRo?=
 =?utf-8?B?ZGtZbHBZcnVnNk03NnJxTnlsMFFoUXh3bWtXNzlsMjk5RWJSd0tmZjd5UzVE?=
 =?utf-8?B?TURBUldnRUxhblRjb1FLZUhRMzhOTVVscDRDMk9KYnFVY01BVCthZDRWdUlt?=
 =?utf-8?B?Y0dOK2N1OGx4Nzlib3UvdC90eHYzOGhrR21hL2svajZFNlBPRGhHTlppQnNh?=
 =?utf-8?B?eko2eDlTd3ZoZmE3ZWJlUEdIYnFHelRuNDJJTGx2bExUV2szZ0l2TFVBNTNK?=
 =?utf-8?B?SXZ1RlNTQmNGSHlvYXpONGFPWVJ4bTJocGhzMWdRZGJIR1dTYURiTnNBZlhX?=
 =?utf-8?B?NFdRYWJCWktuazhWQ05WTHc1NWJlQ2ZWZ0RqWFYweDFaMGRnSGRDdFJPYjh4?=
 =?utf-8?B?SUo3cm9ZWDlmVUNKbkhVUnhveHNlVU5HMUpMeUwyTDV5NU56bWFQTkpwVFBB?=
 =?utf-8?B?K2ttTm1vaVQrZnBVTDZCaTFRUTJhbzRkdlZUa25qYTJyYlNGaFQvM08vMklw?=
 =?utf-8?B?SFJORUVnR2pna1J0QWxUR3FsWVBESWdCdFJ3YUx2SEJKa08wakt0YWNUVFAy?=
 =?utf-8?B?RGxZc2hXN1N0dWh2ZmlFdjBmRGs0eWRNWS92QWFkYUJnZUdzV0RlYWFSVkw2?=
 =?utf-8?B?UkxtdWxacEZUWmdSZkg2TnVZbjNyN3krYXpzMm9NQWJHNGJKWlJudGg5dmxv?=
 =?utf-8?B?bVBJZ1JQei9rdHZOWk1LbnBPTnRSSldlVHJXMEdvbytUSFk4YmJ0K0pOZGdK?=
 =?utf-8?B?WHN1bnk5NytDRDh1dXdVRi9Qc3ZMRXgrc2pvT1VZS3Fwa25jWlNqcHV5eXN6?=
 =?utf-8?B?dW12dUNOYXVwelZmS0Q0SlNCSWd6UVlCTnF0Y1pJV3lETk9RZUJpaXpOajJC?=
 =?utf-8?B?SGpxOUQ5V0dzSGtXNjExWWZKd1lOUmRYZ2d1c2hrSnVidi9vdy9Hbm9YY0lG?=
 =?utf-8?B?TWRlUTRucFdwbFFDN3ltWnJkckljcmRBUFZCemN5V2xhV1hobkozaVMvUFcw?=
 =?utf-8?B?WGlmaUtRdWlxUGdiUVBKWTlJM2RFV2x3S3R2RUNFTW93R3hsMzRLQ3NQWUwr?=
 =?utf-8?B?YnVVdEQwN3EyRHpGL3hNSlA1Rm0xMnNIZGJTdDRZTkFxLzNjZXllajVJaWZn?=
 =?utf-8?B?V2hZdUVXc3VFQlRxUEdrL3RLckd3Q3dkL01XcUpmejVVelhzMGxDa2FwbTh3?=
 =?utf-8?B?SnVGei9qYjliL3d0anJISURaM1hCZVVFVHF2TElWejJhMjU3dmJLWlJRMjZK?=
 =?utf-8?B?ZjloWmZlUlJXNXpGUjd6K3hHbGFVQjg5clg1WjM5bTcxTUZZOTZvU0RkS3hw?=
 =?utf-8?B?QURSbmU4UHUzcjV4L0dnaUhnMnNOTVQxSVkrZUV0aWlGdEcvVWdjdU9zNTZS?=
 =?utf-8?B?UmFmRlNNemVQNVdTU0NOQlc0Rk1tRFVtWVNDanVwYlluZUE2TVNHeXorRGJS?=
 =?utf-8?B?Y2cxQmluQnBmNXFWVHF3cnF4WGIydlVRY09MYXdJQ29nNndyVC83ckNMcXlh?=
 =?utf-8?B?N1NtenRQcTdLN0pJVS9TQmtiZTVPMXdKNDdaaVpwbVJsY28yaXJoaG8xd0ZX?=
 =?utf-8?B?cUJGN3Zoa21PcldCTXVTWFR3NzJISEFlTW92RzBSMER4Tk9JbVNoS2RuSEZh?=
 =?utf-8?B?TVN3YkdDTlE2d3VZSXN1Z1cwNDlTdGxKM2tuemF5RTZFV1NXdlkxU1VLazJ6?=
 =?utf-8?Q?pKgXrf9sdxCcX780rrS1AEgL4ifFsRiWZR5Qwof?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57ca9ce-aa0a-4853-68a4-08d916df39f0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 13:50:25.6489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iglcdDbSzF/PF8cXdNyOXHNwi7qHkmrYauG2zEMD9Xj7f4XwY4VIVQwLHCUr/I5h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4849
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_5E37C9FB-9F95-4CDC-8939-07A1410F32EC_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 13 May 2021, at 17:23, Yang Shi wrote:

> When debugging the bug reported by Wang Yugui [1], try_to_unmap() may
> return false positive for PTE-mapped THP since page_mapcount() is used
> to check if the THP is unmapped, but it just checks compound mapount an=
d
> head page's mapcount.  If the THP is PTE-mapped and head page is not
> mapped, it may return false positive.
>
> Use total_mapcount() instead of page_mapcount() for try_to_unmap() and
> do so for the VM_BUG_ON_PAGE in split_huge_page_to_list as well.
>
> This changed the semantic of try_to_unmap(), but I don't see there is
> any usecase that expects try_to_unmap() just unmap one subpage of a hug=
e
> page.  So using page_mapcount() seems like a bug.
>
> [1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-t=
ech.com/
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
> v2: Removed dead code and updated the comment of try_to_unmap() per Zi
>     Yan.
>
>  mm/huge_memory.c | 11 +----------
>  mm/rmap.c        | 10 ++++++----
>  2 files changed, 7 insertions(+), 14 deletions(-)

LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_5E37C9FB-9F95-4CDC-8939-07A1410F32EC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmCegBwPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKA80P/0KdZXSaJF8uO0L76EcWaym9B0ra8KvRdLE0
6vKvgL/yF1gM6ji0M51WuRv9C3SDc6G40UeHh0Yr6QVymw3Ig3Rh3arotHdWKNlW
tS3sJfTy/zWH6peE8+8+sRCWbRs97WBq27TwRi3ythGQLsLq0l6NwV4pRUVe9Twu
L77A0g92MbW6mUUjlfOy7mvZ6Nu1lFAEbiloObN6ObX249wwOfkGDDLmGA4aUZNk
3oArQklZjWMZpGzkuhLbfBv5p34VvBRvT/uRxrwM+f6huFwrtDoYbS2ER5ey3Zk+
mXddNXjBat/NB9fg9OHe8Z1ai8dI10qoIgXOQdotHmmFONcCdRlLwFEofkf53kFT
lH6itY+QyiMM6tvQ+D4HDuvNdhqAY9R5zwn6/aCQZoNrmtHcrlroH8GcqQjkLwtF
01Dy7SJ1zH2ZLl3RmlA1hlup/07+KkGRN6+MwMuczGM8qeNrtqyXxHufp81nvNR3
/NN7sfqFrlUuG/CSMyaJuwhLL2fFV6GBlWH0UYYtfkgibw/knzDQjJ4q861Z4NKW
9i/WJowjSxpDh/cXixpS0AgQfbQ21445nacGnimM+fibE7Aku38CEcrHdIY9lBmh
S4s0+ur5wEJ5Qcd2LrHQPmqhexgY6h1pgb+1z/4W5bLO6MVNjdwbtxvH4z/377TT
GwpikBDB
=qY49
-----END PGP SIGNATURE-----

--=_MailMate_5E37C9FB-9F95-4CDC-8939-07A1410F32EC_=--
