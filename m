Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4F83E4854
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhHIPIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:08:40 -0400
Received: from mail-dm6nam10on2041.outbound.protection.outlook.com ([40.107.93.41]:61719
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234400AbhHIPIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:08:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMSYyyzbphaIja1/5GfbxunBdd5iaplDQsQkGELDwQVwIlgYJRE4+pwSmlJzSRdhS7czOqXs5UwnlD72PzA1K0C9j4tFoF661gT7E9XhMOnFMDzlP87OB16klDwLSuPnBURzWzQLLj89r+oZLpy7xd6WE8d2MAk7abw6Uv4krmF/ThNxVb7KTa4DjIEyTvkeSfBV1D1Q9UE92VCAjP1Yl3xUguhRPeSaNDFgYlckKYqf0c65H1FJYcM3LTkuL9t/cgL70TQCFdDsyqi+BoVol2saskVmxUHkOkHgb8OyUD6oMsHVkBfULQUaYp6JhIZT+obmefoxZFqsBAoIWiBSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6tvZqcTTnnGTs4gcrwgl4GGJvFPJB90gD51nk0L0cc=;
 b=axrJ/Vz/U20PhxZGqu3Ezcrs/DHOkyGzlZjcz/0pCVmc02URAZ+wbE0GNYnm31RxIjd9zqp4nI/1pkG2d/klhQjo2o2sFbTnq4e4rorxTd8XFECpLVCfBgjGRRJKHnl3k1qTQExNBtOb5t4ARd2CI8qHfE3OCSiPoFyAOCqtfhBRo0R2wJhNvSxOvnZIkhGdQgfT05UulKnA1jObkfvDZekgZ7O//L1633D6oZ+MrSSsjd9Go4NFrKOWMEcs4c8s4Uk6WYk1e8C1wpJw6eWush1otyCQR9B2EIA0xWWgEGQwf+6KUZS10GqWLFl32C+geWIklPcWsTaPejzo3UwCdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6tvZqcTTnnGTs4gcrwgl4GGJvFPJB90gD51nk0L0cc=;
 b=cAyJsjci3HGHA6NB7ZIR5OGq8vKfijMzI7vw1chQATFXAsOVKGDAlF3uabczM1BwAkfBn2A9trR2GBjfs+azvCJKcVeL+M67EsY93XDfvINgoaoiRSbdS2oVQQcRjtafox8TB+EPiFV9ddxK/0NrvUK1IYpU6z+zv+iFddBP+CYCpnjecXPPjjPzOM0CTYA0eSsinIFFULG/dr97PYPwq+pJY5aS9yIuz22mMwZN8mxvr+DQn0AyNenYIO7vh0lW48lDmOk4Baqx2C/C6FEF/0H9xxHNzm6IofHwaIqokMtG5/FvLvEi8tSTFBCamP6tioqGcgkRcg2AuJ+BloTEFg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 15:08:15 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 15:08:15 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 11/15] mm/page_reporting: report pages at section size instead of MAX_ORDER.
Date:   Mon, 09 Aug 2021 11:08:09 -0400
X-Mailer: MailMate (1.14r5820)
Message-ID: <42FD7031-5C3D-4EED-BD54-2F5839823E22@nvidia.com>
In-Reply-To: <CAKgT0UdCVTYiiGHuhBv7VnyJeD3ZAijBcZPLEPc=r7QD=9veNA@mail.gmail.com>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <20210805190253.2795604-12-zi.yan@sent.com>
 <c2fa6c99-ac48-bf0b-a8ca-d1c0ffb633b6@redhat.com>
 <CAKgT0UdCVTYiiGHuhBv7VnyJeD3ZAijBcZPLEPc=r7QD=9veNA@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_87B91D44-3DB8-422F-A980-8FFF8CFC8204_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0291.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::26) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.60.152] (216.228.112.21) by BL1PR13CA0291.namprd13.prod.outlook.com (2603:10b6:208:2bc::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.6 via Frontend Transport; Mon, 9 Aug 2021 15:08:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf15a8bf-96c0-43ac-b236-08d95b4782e8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4454673D76C62DCE25861341C2F69@MN2PR12MB4454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 715LmmtPrytlkY+ym6f3RKQwRbafEXETxRepr/zeiDJfkOyOaWIdLTY6TyR7RoPtHreMhpCRbJbpP+VCjUMTazMrLiPwRS8DywxFhYeHIAtwk7q9RAWnF9CElhCM22mn/y8d1pMmXMR3H40PvD/JBENcTZU/q+tF08O9kIr7RfkaH2I0Aiw4w/51Vh9iYrpIieIydCw0G/y8Zf2vjVoJXPj4Ucp370vtxQE2GaOB4zTpdxd0a5IMmoUEOra/KHbYGyksU8QenlRQdhw1ouSICkZFztBiXgjPAvUcpIR5dJEHl6PYLea6BKN6sBKcDh07mNvvUqVMtfAjocUnmXNwAhh0Efr49TrT9QnAWjlij40Kmw/4WHcSFpdzribAN0kbCLuFLuevql6Vz1ntAqlfBbX7VTgm3AXBxIB5bMltDbgbV1N14oBAoaolzQIj4iQuTtFCOC0LPfFBSvq4nFMic6Q/Ym2VuaumYI/eUp2AshfCmeo0mpeZ0SuzoTFKTgcznUTJdtSDmi819tMFsOBs33MGh2/x3KM07tVpD7915inz6gv5ECtg/D1HSpx2cIyWVuHgxQxWhZf8L1gtAOMRICcBGWRMqW3W78Sh3OC1Y3PzA5/oZW2u/+j8Tm3dkQSxx/lLFiuxxhpHu94enHBwANeNeNTCNdTfS2TW8Te991k+B3Bc2/bM4LqOrYEWjKkQMWRVY2UC/8P5ZsKugZJTb9OHFoamFBuQJDHr6PDkvv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(508600001)(66946007)(4326008)(33656002)(956004)(83380400001)(2616005)(8936002)(53546011)(33964004)(6486002)(54906003)(5660300002)(86362001)(2906002)(38100700002)(6916009)(8676002)(316002)(6666004)(36756003)(16576012)(186003)(235185007)(66476007)(66556008)(21480400003)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R294NTVGNTJaZFRLWEpPMHlHTi9zY2w2enFVM1JaOHdETlR6Z0g5NHUyWFd1?=
 =?utf-8?B?TnIyOWk2ckhHSFh0ZmVSQitoSER6MEU1NjBuTFR0aFh1bHZoQUk2bys2bWs4?=
 =?utf-8?B?clZKK29Fd01wZi93aExWamwxMGlXRHMyVi8vYUZlbmRHZ25ZWjZPc2J0NEVG?=
 =?utf-8?B?Zm5ReFZ6WDcxMUVxcXJDdGJPd3hDUVRwY1V5cWFaZXo3L2l3aFhhUDJqTm9k?=
 =?utf-8?B?MXRCNVNaZkRyQytoWEVidk9YV2h1YjNXelYzaUx2VVYyZTRxbmNReFRSZGNt?=
 =?utf-8?B?OGNLRUFMZXl4WmcxK1hmbWNFa3BEZDFxNG5Ma2pDQXNIRFh5SDE0UjQ1S21O?=
 =?utf-8?B?YzNTNy8xemI5b21QSG0yeGR0OWVBY1ZjMHpld2t1ajg2cVNaNVprdXFJdEts?=
 =?utf-8?B?ZjZXWUdPQlNaMGlFWU5DQVRld3ZKYSs3b3pxQkFjai9mVGI0anRQZkgxanZS?=
 =?utf-8?B?Z09vT2tMdUNFSmxuWWQvOXVTT2h2ZnV6TTM4VnJXUWMyVFBUT2ZhRm5kRVFq?=
 =?utf-8?B?L3NoSGRaQmZTTGJBcFE5QlVtdk5nejhETzM0NG04RHBYdWIyMWZBYW5mbU9r?=
 =?utf-8?B?V2hJWmtlQVdwdDJMK3ROdHZjRW9menZmeEJKTWM3Tjc0a1BpQzZ5UFcxMDNu?=
 =?utf-8?B?aGhpTkJKSlBvZ09xNmhsS0FVUzJnempVQS9pNXhBMHR1RTBQRkVuczZBZm1J?=
 =?utf-8?B?TEFWR0VTcytKbTJwZVFUZTVPUTg2L1VhRUpRbld5MEN4OHh3SnJxK01BOVpt?=
 =?utf-8?B?SEtnSmNOVGFnSk9pTTBPYTUyd3BtbkcxNW1kQjJqZ1FNM2J5dVVmdmJqRzJS?=
 =?utf-8?B?OXY5ekVDWDZLWVBHNEtuQlVVMTZJWkh6OE0rTlBlRW9VbG1aYi9VTlRFOW1Q?=
 =?utf-8?B?QnIvcklDS3VMUDVRcituaDMzUm1KY0h5U1gzd0hFTGdDbERmdVpVYk1RWGdL?=
 =?utf-8?B?R3lKNW44YVB1SlMxYlFvaGI2cWJmazQ3STlVeFQzaFhGWDdlU0FRTGtFaFZi?=
 =?utf-8?B?anpSWEU5N0ZGMVEvT1ovSlIvb1VyNUNXU1dqR2t3L2puQm1pODNQcHdkV1kr?=
 =?utf-8?B?K0gyaUdueFhTeUxTL3lIZnNjUDVLNzFlbTVzVE4vR1JWcG8wZ0tkczIwQ3l2?=
 =?utf-8?B?aTFvYzZXaCs4VzBHaTdqckFOb21jWTZaVkxndDFEdmc1STFnQTB3K3dUWjVy?=
 =?utf-8?B?Zi83dEZ1a0E4K1o1QU05WkhSdlJmYmwwYy9EbzAxbkFnN2M2YklkRmgraTE5?=
 =?utf-8?B?RGdmZmtkSkxXNjZmc29udnBMMWMyRkE1YnZQZklEaEtYVXZubXdpTHgxNlFi?=
 =?utf-8?B?YjRQVjYxRjlCay9tSHZvQ1VHTW5qbFduOUg2eG4wVm9VOFhEM1V2dzFvMFVQ?=
 =?utf-8?B?Q2dhWGJkdXdIS2pWMXc4emRYMmRFbTZ5OXRrVEl4V0dsMEVwSUkvYVdlREN6?=
 =?utf-8?B?VlF1eFhEbmNlZHdJMGJTS2E3dkluSkNOU0JxUnh1SXNhRWxKM1NzN0tyYnYv?=
 =?utf-8?B?OUh6L2o2RC8xMmphOExnK3hMbGhOd1FBR1FmL0tKVlM5cGhEc0N5WWFMcGo3?=
 =?utf-8?B?ZEtlbExRbXNtZ0d3cDdKZXV4MXlJUWc1UFlGVkNxcFpvQkxYekIycWg3S1Z5?=
 =?utf-8?B?UUNaTWhjMW5jcHE2QkIyVDRaUjBFRFdwTjhyc3liMTlGV1FQRXRnL2hsaVBR?=
 =?utf-8?B?SnZlR1BnQ2xkTDlTZ1FRNERXM3pyQXY3NnI4NkI5TnVnTk05Mk5yWGJOY000?=
 =?utf-8?Q?wnEq/Y0bzTr7zmAAddf4Iq6DAJQIrVN+y4v9nL8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf15a8bf-96c0-43ac-b236-08d95b4782e8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 15:08:14.8998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSf6rVt8dGbNpskyk0Ls9l1d2jnlHT4ZY7lJQzrXbv94EDJP8jZEd7hl0ZWSvjQc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_87B91D44-3DB8-422F-A980-8FFF8CFC8204_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9 Aug 2021, at 10:12, Alexander Duyck wrote:

> On Mon, Aug 9, 2021 at 12:25 AM David Hildenbrand <david@redhat.com> wr=
ote:
>>
>> On 05.08.21 21:02, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> page_reporting_order was set to MAX_ORDER, which is always smaller th=
an
>>> a memory section size. An upcoming change will make MAX_ORDER larger
>>> than a memory section size. Set page_reporting_order to
>>> PFN_SECTION_SHIFT to match existing size assumption.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>   mm/page_reporting.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
>>> index 382958eef8a9..dc4a2d699862 100644
>>> --- a/mm/page_reporting.c
>>> +++ b/mm/page_reporting.c
>>> @@ -11,7 +11,8 @@
>>>   #include "page_reporting.h"
>>>   #include "internal.h"
>>>
>>> -unsigned int page_reporting_order =3D MAX_ORDER;
>>> +/* Set page_reporting_order at section size */
>>> +unsigned int page_reporting_order =3D PFN_SECTION_SHIFT;
>>>   module_param(page_reporting_order, uint, 0644);
>>>   MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");=

>>>
>>>
>>
>> If you look closely, this is only a placeholder and will get overwritt=
en
>> in page_reporting_register(). I don't recall why we have the module
>> parameter at all. Most probably, to adjust the reporting order after w=
e
>> already registered a user. Can't we just initialize that to 0 ?
>
> Yeah, it is pretty much there for debugging in the event that we are
> on an architecture that is misconfigured.

MAX_ORDER is changed to a boot time variable in Patch 15, thus cannot be =
used
for page_reporting_order initialization after that.

Thanks for David=E2=80=99s explanation. I will initialize page_reporting_=
order to 0
and fix the commit message.

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_87B91D44-3DB8-422F-A980-8FFF8CFC8204_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmERRNkPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKQrEP/AnAmI+JCoUUOoMVMeaE70FuDLr+mjUfgwRs
8kmEGlOW6kIn05977UX3/3gO0iuxMuECD7txZD3q0QVoh/SWiPrLbywyLIH4c9jQ
68MKVWU4QQ43Uad8e5jtjqX4vCWm4abHK2Gwee9JkUCHQ98ITTevgJaKwQuDBiSD
J2mUa6myYBQeq+aY9L0TBQQS2uYLZQOiEA6ULEWjRgFGO/KTmt5PGsjQUslD2Gif
oy1rHzMVzcGdGG2YCK/dpeTpLxvSbOnEfLSsNQD/SoNGx0pNCUKbR1l9O+UEu5Fq
lLXkvabtej9Z+XDHuizbACnoAZhHC/L5jYSIgXtObjP89QckhmROE+Z16/XM7TVP
8FCBHV9Llp3qabcbrGdHHkXwoyjaMV6Pdl41folzrwbpwcHh76SRk11ItLgLVis2
l74061HWz4R7Nuwk9zuHnk3ro5hA5C/nqBS3Hp/hzxng9itRrHMBM8fXiUvWwLej
Kabun6e0Kq59S0jVf0I0ilzOwbH0JkF2frF6jntMNj1mfove+riO6xH4J2Z/4+so
1ufj5aESjUww3Z3aoWtQuFa0A+0/eD6/pLfybyGemv/yK2fgcKZ9iZbo6edkDTiq
F2A2NvB2Y6pEORloFomJ7u+uAFH5EWYTsBW8hUHLtgdjjV6eePj3r2ybI4OLBtNw
HQJ+88bA
=S/Or
-----END PGP SIGNATURE-----

--=_MailMate_87B91D44-3DB8-422F-A980-8FFF8CFC8204_=--
