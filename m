Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A7A3C77A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 22:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhGMUFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 16:05:22 -0400
Received: from mail-mw2nam12on2056.outbound.protection.outlook.com ([40.107.244.56]:50625
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229944AbhGMUFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 16:05:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiVcmG+KrV0WRhVmHZwHmkOF+cXTW+e6YLlfd0H8RfNHQ7yTF7Tx17bljcQ+NEp5j5sHWexAH+MuM9YlVcY3yWCVkUkY1apwY0PiVW2fIj+P6mjotJKzmD/J07FL0exUhOfXNapko20+ty1hUZ/3H8Hqo6IN/mZivs5wgzq0izmRt4kowGRWdw172e2Mfp6POah94W6FiDopgnNY4H6DcSqbjMoQ+SHoNGEoFE4LQCi4zgJpTKCozwR8s6jHIPcY6FAiJkev8XD9myYbasHdfsXWZbrxDIWApfnr/dpqQJ18bOC4II8rw1hPdZbKMCi6/JBbxjOKaPFhQ6wcULDTSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LleEvXtrVzZoUD1MG1/F3uRAUgHl6OdAD5slzk47pGU=;
 b=eiDYa4rXzFfc93kRBBsIDxTGDUJLVfyDr3na3EoQC0UoWWHv6HGBMkCLl0ASyTj4+Sg5d0vz3A6XpS8vaR6vrmRlkUiwSasCAizFa2A660xuHZfgkt0uNOz0mLdoUxqjQAr9gThPPvysBbrUmPA3p/QeXi4Fv585Te2a7eHxs7jtj0dDV+6RdS/TcwL9ewpiLNwL9Eop6mzkRFhKcyXpAgLAewtbU5UrwHYnig6jvYpK5U5B7w88HsDpT+1/hw3T3MrpTwI4cefkkTSOZ5vJBJvFmeyd3gRq1Ix6ZjA6YJeRwrJmDtUHCnNSeoZhTp7/qjt8O16qLuF7MQ15fj7IcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LleEvXtrVzZoUD1MG1/F3uRAUgHl6OdAD5slzk47pGU=;
 b=QAub/CrjDWny5toy1ua5dNe8Ck3V3ttSTEzpwzUtCUdlzARcI98jr721Zc1oo85sb67m6mpRAKAVcvKvqzq6mJ4vm2BvZ7rihxfkVdaCignB9jlappis7wj/WU73clAlLM49aQvysE0BemvPXSHhJp7TnwrMruqz0+kJitBs0VLop8ZyNkBL8jRpRfAgnpoZ8rSgESBepUQ7lyD1dCDNStZR+bzDwG91yMOpGOuguHNDfykINegxAHtpBCyOUeLCVAoQ4x2ujbE0i2vPmgY2/F2WECgY25hamKX1RoyvjeBY3/J/L/3NBkRycypYGRFEldTIkNBecoX33/clfFfT9g==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.25; Tue, 13 Jul
 2021 20:02:29 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 20:02:29 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: remove pfn_valid_within() and CONFIG_HOLES_IN_ZONE
Date:   Tue, 13 Jul 2021 16:02:24 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <CE216FEB-1C75-45E1-8175-3DFA72411E3A@nvidia.com>
In-Reply-To: <4367d5e4-4f03-6d99-f19b-9d32b71f227d@redhat.com>
References: <20210713080035.7464-1-rppt@kernel.org>
 <20210713080035.7464-2-rppt@kernel.org>
 <7300dfe1-0c6a-ae2e-2c48-c885248ec263@redhat.com>
 <YO1pT1bjMfldbQKg@kernel.org>
 <4367d5e4-4f03-6d99-f19b-9d32b71f227d@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_FCB63158-3073-4C78-8D1C-78967766365E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:208:2be::26) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [169.254.198.0] (216.228.112.22) by BL1PR13CA0201.namprd13.prod.outlook.com (2603:10b6:208:2be::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.12 via Frontend Transport; Tue, 13 Jul 2021 20:02:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d74f70f-80f1-4ce8-1c40-08d9463924d1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4240:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4240B4F0891D8919C7B14175C2149@MN2PR12MB4240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgVvw7oTClasDKA8KLic30Gfh3YzmVTEAYivFlzBARC8UoI3Tyva2qi9WdrFsBN2z5n0kmTH8mV0lOTVLh+yJ8Ur1YeRLgG+rUA0f+yzuZI78K0mGDmmSJQS5zluEGkv1DKPyoWs236bea6k2QK7v0nACfmN5LNHIF67DTI5MTD6EOkOs4l9H3ZCTi1WcsSsfFtPQ7Fjgls/3jh7d5kCcQI0fHn2e3NYGLuyLkDEj0zdLrjsaaNjQXE/2LiinuyMLjx3FRx3Ur48TgZiXiAsRw8o3qfbvyZZAk9DeTjQISywwEuxdnT1Yj2v7LDFS7Nzr3NZQ2F8kEMSn0fJOhwhO3PF8PL/alcMRR9YSFivXw3rVt97BZCrR4k50daWxie29QrezDyvqomXHithZjht0Sa2acKsTQsy/+QbbI+vIdRO/bDIN4Ye0LBoq2azaqPSikqGWXYFB5stH2WQxPlIwimBRyoJn2wFqv0ns1p82Gn6gapJ/GNUMcE3EKHCrnGuxVKQ84XtmjyYqLgEteO6V23YvQ88uIJF7+7RV/28/FY+7oGWZTcp0rC1HkPEUzqcWEeTcNWNEA41uCyQIclemWKboTAVXDsmAWn+t8BYbMnMCWbzZPh31KCy78wWnXB9y2AG7vAk3tBNXQyPLe9LBXSVh2SDN71Z0gWUXgY4kZs26cJN0IH2MsmoBTPDEmDu8MZo+Zn0fpwB1Yxiw9tE5BQqqQl2tBtpYoVei/I7VeLdvwcUPSxdXckZdE1lpcSY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(33964004)(6486002)(16576012)(6916009)(2906002)(8936002)(21480400003)(26005)(8676002)(66946007)(186003)(86362001)(6666004)(5660300002)(235185007)(66476007)(956004)(2616005)(66556008)(478600001)(4326008)(36756003)(54906003)(83380400001)(53546011)(38100700002)(316002)(33656002)(78286007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVovZ0M3cHlOU0F3cm1Jb0g3K2ZyenE1eWExbytpR3dEMGFTa0NwWFNkU3Ji?=
 =?utf-8?B?Qm5SV29wMFRqMDM4TWF3RFhHdGNpNEUyMGY1L0ZEbStSREZOSkxJakM2eHk1?=
 =?utf-8?B?TUllV2RxWWdOL3J4UFIwVTAxTWVxUWlpS1BkemJxSS8xQXg2WnM0UDNuT2tW?=
 =?utf-8?B?KzlGS0xJZnFVdVc0MGpTN3RDYVpUUnlvcitZY2lhRzlwelZwSzlpS0pwZ21U?=
 =?utf-8?B?eUtJSXJWK2lFNjVCaXpvcEtVUjd1dnhoWE5NZVB6SU51RzZteStwTHdSTGF6?=
 =?utf-8?B?OXlCOVRpQndiaE4vbVoydUhvdjJFRXYxb09DRmN6aFJsVnJzVkhtMDJKZGF2?=
 =?utf-8?B?WVNHQTU2aVgwUTBrY3RuY3FXZ0x3eDMzVjNJSWRoWDNDNktYdlJlbi9samM0?=
 =?utf-8?B?UW9DR3hJQUFVNVp1TVNHRmdHTFZOKysva2Ewb3U0ZUYzSnRtVi9VU0xIUllr?=
 =?utf-8?B?MVkyUlB4blBLaEZaYWNKV0FacmNLcnBuS0dra2w4aDBUT3JyTW9yek8vVDFK?=
 =?utf-8?B?RERXM08zTUg1S3p4ZFpJeDVWNjdvUUhHcHAzRksvYTl5Q2VQNFU5UDF3OVFO?=
 =?utf-8?B?WXVpMDk0ektmM1ppa2lZN3BwUVlXWVp0QkU3ZEtaRExXYTNNWng2RG85VzRL?=
 =?utf-8?B?VnNJQTBiYnlHbkFpenBLREJ1QjNxVHMzNUozdndpTGVUMENGS2gzYmlHUDZU?=
 =?utf-8?B?akJUNUNOUUdvMmw0a2Z5VEY0cVJLZXBkZi9BWVJpcEFhOUxqdkgyRGZVRkh4?=
 =?utf-8?B?UDJDczBYdGlFYkV3a25qQW1MQmJwOVlyck42MmNOS0hESU53REZRanNTSmZ1?=
 =?utf-8?B?Wk9JT1NDb3pwR25OZnE3cFN0WEU0c2lqeTRyQnlWN3E3KzByNlZiM2NaOFdw?=
 =?utf-8?B?UXlTd1VJMzkyOFFXOXNDaG9rVVhzSXFkRXpacnVSdytobVhYWXlKZ0xXK2M5?=
 =?utf-8?B?YUpxMzJiaUppSXc1S1licVRONjVqTi8yMW9IMmVIbXBKWnh5bitxNWhleEpx?=
 =?utf-8?B?dFpVTlZLZTZsR0dCNnFxRURSZy9rUGlUN24xRFAvdWJKVlpvY0xiN2V5a2dW?=
 =?utf-8?B?NEhDdTFNaXVqQWhQTkgxV3hYRkFZYW5POEExTzBDeTJOQVVCcU93RDQ4Um00?=
 =?utf-8?B?MUlzbzB2UFVza1JadzFvTTMrK0h2SmdENWs2RU40ZldMTlFPcUNSRUpuTXdF?=
 =?utf-8?B?NVYxYUtXTjd0NFhvQnQ3eC9wSzZtZFRuYW9sK0FjTUhXdFhPbVJMYXFkL05w?=
 =?utf-8?B?MDhtZ2kvS3BTWVk1ZFBlZnhRWGtEb2V6KzdMVWUrTGVWZmF2ZHpISHI0Qk9D?=
 =?utf-8?B?cmRJZjE3TWFNVHdaOVZmVmFMWCtPVHIzMnRDSzJjSk5KbitQWFF4eWVqYm9Y?=
 =?utf-8?B?U1ptTUdmWXJnOXRZZ2hQM1N0YVdJWGptMGZiWWVLTHZXTjIwSEpJMDhTa0JJ?=
 =?utf-8?B?cUNiVVR5c05Zem5CTjhFV3kxelZncGZ1L0tQZ04zUWVUV3h1QkNwNWUyUWRa?=
 =?utf-8?B?SnF1ZllodkFUT3J2TzUwWis5SHpWTGtpV3hGdi8zUm92TVBJaTdpbmRXWTVo?=
 =?utf-8?B?dnZKakRRQ3RsdVVuVVdNSFZrR1AzbXIzS01jYlpvTFZuRThGNDBPTC8zdmxH?=
 =?utf-8?B?QmpmUkVlTWoxdkI5TjAzNFEwUVMrQjRZeUVhaGtDczgyOGtOOTJBRzlVVlp1?=
 =?utf-8?B?MWdHbW9ueDhCRHRzKy9adGFsYkVkSnEzOXR4L1NVdW9PbCtuMWIrck9oS0p2?=
 =?utf-8?Q?N2DrveJkW6Fbx2MUHLXphQMkLIW9NBDoC4BtScP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d74f70f-80f1-4ce8-1c40-08d9463924d1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 20:02:29.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4TbxW9GmYjEEqtfACWnPoZ7XpxppHWZj1fQWBL6HATHKInrUiA2XcUdsKOpeGbA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_FCB63158-3073-4C78-8D1C-78967766365E_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 13 Jul 2021, at 6:24, David Hildenbrand wrote:

> On 13.07.21 12:22, Mike Rapoport wrote:
>> On Tue, Jul 13, 2021 at 11:51:46AM +0200, David Hildenbrand wrote:
>>> On 13.07.21 10:00, Mike Rapoport wrote:
>>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>>
>>>> After recent changes in freeing of the unused parts of the memory ma=
p and
>>>> rework of pfn_valid() in arm and arm64 there are no architectures th=
at can
>>>> have holes in the memory map within a pageblock and so nothing can e=
nable
>>>> CONFIG_HOLES_IN_ZONE which guards non trivial implementation of
>>>> pfn_valid_within().
>>>>
>>>> With that, pfn_valid_within() is always hardwired to 1 and can be
>>>> completely removed.
>>>>
>>>> Remove calls to pfn_valid_within() and CONFIG_HOLES_IN_ZONE.
>>>>
>>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> There is currently the discussion to increase MAX_ORDER, for example,=
 to
>>> cover 1GiB instead of 4MiB on x86-64. This would mean that we could
>>> suddenly, again, have holes insides MAX_ORDER - 1 pages.
>>>
>>> So I assume if we ever go down that path, we'll need something like t=
his
>>> again.
>>
>> It depends whether pageblock_order will be also increased. PFN walkers=
 rely
>> on continuity of pageblocks rather than MAX_ORDER chunks, so if
>> pageblock_order won't change, there won't be need to check for pfn_val=
id()
>> inside a pageblock.
>
> I'm pushing for letting pageblocks stay untouched, so good to know!
>
> (we still have this crazy special case of pageblocks > MAX_ORDER - 1 ri=
ght now, which I think we should just eliminate)

I am working on this right now. After I increase MAX_ORDER above SECTION_=
SIZE_BITS,
holes can appear in a zone even on x86_64 and pfn_valid_within(), which i=
s currently
set to 1, is needed to be pfn_valid(). That seems to be sufficient to mak=
e increasing
MAX_ORDER work.

For my use case, I might revive pfn_valid_within() if MAX_ORDER is config=
ured to be
above SECTION_SIZE_BITS. Let me know if there is any better alternative. =
Thanks.

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_FCB63158-3073-4C78-8D1C-78967766365E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmDt8VAPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKTZMP/0jC8l//gLncCGHixOLa6/K7kKkiKkVRyRhL
Msa7zcNncdpAkyxjCUm/IfJ/uCwiKHhaXnTb7w2QRvbOX7SZIEYOH3yaHB9gK8vX
BSTQc+36X5vbnspUf9JEoZDJT862vKk+Dl78GYKZTV9R1el1wj5HHMDlcrzTf/2E
lPThrluqhy4zSxJUcbmpK0rJTDSFK9jA0IUNzfYlIPhN8y8jBd1xkW5782WpdBHH
2Lnzbwfl5CvWT0cxCNF71mSYR8T6CIgKHSeaam+RawFhi3duRVJ2KHxK1wzJKXDQ
3stRgsvJWYP7maJT2Ogtrwtj2M3i4Gm7mgGUj/sC5VmcxAZlpqd9lo9dn6X5sVTc
14x8+u71Kairu22fMC6GR3pGy0bve3Sj2XbNo0rgApt0Ij+/0PgzbwKESKSWT0X4
irdWdx342dlqWN5LD+doS0RAlmTX2FooEqAeKmnLmVKAuTFPLHNxUcGEjAUwPJTp
H6L1GCjy7z928PIV4gEfuR/mYrK1dJbN4B2n9z4f9k6XTmYX9OzeSVRk4yNTWLjh
fQl+zVjQYfODMQ21bwkBM3gCoLZD4z3k7WAFuc7+HIgszbzJW4ABZMUP35FBu52J
Eii9qOEgtzC8JABAKf8b/ujYqG2zvf5rLYa7HHzPfPr3E70o2qgp03X/6TIoxwq5
l9qNxz4n
=Fm5I
-----END PGP SIGNATURE-----

--=_MailMate_FCB63158-3073-4C78-8D1C-78967766365E_=--
