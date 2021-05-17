Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BF8383385
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 17:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241950AbhEQO7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 10:59:03 -0400
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:7649
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242086AbhEQOtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:49:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B79gfWrTwlc+XZyPt8Qa5URcbScxNsKZ6BmCNdRBbD6J2PBSZ4F1E5sOlvLDLgzc0SEvQVMiaONUnontEM50MpuJrSz+KROLgTDkl8x2qU1rKIeHsoFrw86zpDK/9UnjUa2BC1rdITMzrM/8/szqYTvdBTuZBlI6fhLnvnJmX91VdN1wsA3ePze7zfxvSuM4Aft9p113t9xcP4HNgT3Mn4PRJQ43rjfclIAK3YmbTW31bn24yWt4wmRgd386UXZF6zsJLlHYjZg5gYwruuQwPoXFs4/yrMTRxbSgj8wXAWIYnM8anTC/j+GZu/8YSzLzlJLesmf14mOe8Ypvk2I2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwHXhQogqnqSrPfPUJzt2y7S+Keuj3JT+Aiw19kAyPQ=;
 b=ZGvl5vEoTjbzZbMQG9YkL7+CRJu76NYGyqwI6JgpKtNaX9n2cF8WCv1vVaTxQSTtbXZto039IZ2ksduD2kbZUBYeGQLNWuyWJJyOGLxHR1EZIX2Q5r1L3hfSSxVQMdqk6cg8csTe5/CogeK/r7cYuBa+FKK4A1wpJXXFymVw74G+RrKEXFJk/IJP8hVvtsRCvrHi0ETN6Tdth44Mij8vph1XRJFXvNr0+R6jtkIrl7+qMhNmC39MXVH+ll/sQDkrLZrA6dJ1MMMXLEFvvu1mkvHIiEYh+l97nmJ0bNVuw+nPc828GPlx64LNBUJl0Z3bHCrShF9JjMQSHa3+i6Zj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwHXhQogqnqSrPfPUJzt2y7S+Keuj3JT+Aiw19kAyPQ=;
 b=Ym0vJXbhp9fRWHejm6iPw4fngKrUMaF4qCOwjlkQfCgvsApGevNJWA/cL6h+qPSq/Hop24sgfErZX9vD8f4LrauPVU1nC71kTCK7+GtUseBVAUEK1zbTaCfmZN3BQ8XCY2nc6h7kuUqG4Am1O4Jy0YTYV3HYCxTn0BF1MgMQdoQrDaMXqz3FWj8Q2NJvRUEnhbpNhHQchb8NgTFhmjjfZ/yAOUno5I1sNgs3z5twMz/Kpszzr37hwPuyT6nUQ2uqMNrhhkdbxtYeYR84c5vN4lBbecz8Aaz6cM8uCDqM4/1mrgjlxuvViCYDuN+RdgxpI1GvZkW1yLSalCel7d93Sw==
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4519.namprd12.prod.outlook.com (2603:10b6:208:262::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 14:48:29 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2%7]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 14:48:29 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm/thp: Update mm's MM_ANONPAGES stat in set_huge_zero_page()
Date:   Mon, 17 May 2021 10:48:25 -0400
X-Mailer: MailMate (1.14r5805)
Message-ID: <5C1D3AA7-DADD-4C74-8D18-136CB592A2D2@nvidia.com>
In-Reply-To: <d63a9067-258b-16ec-c5cd-d90d14793090@arm.com>
References: <1620890438-9127-1-git-send-email-anshuman.khandual@arm.com>
 <1B37E0D8-2F69-45A3-9384-DC5BCE9F67A8@nvidia.com>
 <d63a9067-258b-16ec-c5cd-d90d14793090@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_CB05EE62-E5AC-458C-84C5-C70DA2575911_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: BL1PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::33) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.60.96] (216.228.112.21) by BL1PR13CA0178.namprd13.prod.outlook.com (2603:10b6:208:2bd::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Mon, 17 May 2021 14:48:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20f873d9-effd-4936-5b41-08d91942d5aa
X-MS-TrafficTypeDiagnostic: MN2PR12MB4519:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4519062E2211BF2BCF5AEBD5C22D9@MN2PR12MB4519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fVbX0bOfxQT4sxpk++kBnOMOKMWA322V8ymX+fS32z7WjtDZc/OLr75AGE/o/CbxkTsV4TYCsw0OY8Y8qhhyj1jI1Nd3uC87CL8DNfMaaI8Jg/E+/0NvJh4eLgSsqUq9lTq1AI9RjQVR+h9rtJNTFBWUBCMJXgjm+pu2Tu3cY7G5kGrU1G4OVx1sBFsXR+CMlQbXYgId+0chRBcyJwDUrGi3m0T593HHb5d2TO5rqnGttiVwGX+7p9MLKDAke0UUrYdlAeM5Br+IxRY+XMVssdg0VGadvGCTsS91Od7Pllxf/2dwD1ebMB64eHJmZb5aFB4Ne+DHcST8uDGar7+u6YBolB/3jHe+3A9y1R3X+KRulCas9sAm5+73xJY7OSpcU6UHBZvwhWJfcawBJBze/bSBvU7caBWbV7gpdSERhn4YsWe0UjsmmNSOETajcxMbUhS7oKGy2JW2PTtkZ5yhceht6ACGjDMBuhKsydt1FCRtpOk1nXm7v5FSRettdxYH9ZamRZl3CNVstepuqIcQ/58+sxzXVib1hvkryhHyxtUL1kPVyAG0+GFWoiLnyR5f83oqB/I88w56sjPl6Avb38RD7AIK+1irKz14meVWNmPv0TPafIfORHzBw6XMIF6RlKw6Go619nu7zvUgHv92siM0IiGFRlkFUq+aSM69+V0mCeqNUW5YIB8q5irjieVJZdrqNpqPjY0bsdN/Hb06Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(36756003)(2616005)(83380400001)(956004)(2906002)(33656002)(478600001)(53546011)(86362001)(6486002)(16576012)(16526019)(316002)(5660300002)(38100700002)(21480400003)(6916009)(186003)(235185007)(66556008)(8676002)(4326008)(66946007)(15650500001)(26005)(8936002)(66476007)(33964004)(14583001)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R1RxSG91dC95aU5nTnRwRlhucVpOYldBQ0JYa0o3SXZFSFg1cVJBcUlpNDhi?=
 =?utf-8?B?ZFRyb05WU0VJcVlSdFd1THYxaVV2K3FtT09meXJDTnVJZHhEMlpQNHh2RDdF?=
 =?utf-8?B?QTNReVlQTVAzN3BPMWZOeXpDYXhXb3dKaUIrLzNrYUpUZzRYRDlSTGNnM1dI?=
 =?utf-8?B?TWpMWjFXZjBDMUJWN0V2VHpqTitvTkdBMjVVdndoV2lYTzdCOHRXdVJhMFJr?=
 =?utf-8?B?YUR5YXhBL3A3YVRMVjZFY1ZxdDBHWjhhQVVuMlVaSGcyWjY0RCt5M2JGTGc3?=
 =?utf-8?B?K1phWHQ1Q2N4S0dkVUtQWnlkUG5EREZLUTZmZUJIN3N0a1ZRSnRaQ1k1L0pW?=
 =?utf-8?B?YndvYWNVTEdDVWVQZHJnZ21yVlNVb3BVYmZzb21MbFJCSzlJUWlhbnF2eURo?=
 =?utf-8?B?WDVhZFIwL0ZQQktFNmlseldvZFNNRWNtQUVVOG0yWXlJaDNLb1NhN1h4SWty?=
 =?utf-8?B?aGxGcjUxOXpOclNqaDlEeFIyMzRob1ltdGZHaVpaRDE3bmVpZGtEVDBBZDJU?=
 =?utf-8?B?TWdyZnAxS2ZTVW4vNC9lN1I4WmZQaG5lTElSK3lYTnlreXhWeVhaQ3NwaHpB?=
 =?utf-8?B?bzIyKy9jODAveDByS3dZTkFybUFBb28xZ0ZVbWVRWFhPNFlFWGE1aU5uUDkz?=
 =?utf-8?B?endXM3BTZnd2UmZ5bC9HVjFTU1VEeTA0WXJzWENQNW9Ba0lIV3Y2NW96UG9y?=
 =?utf-8?B?ZnVUTGpGS215aDA3RnN3Y0NWV29qUkFjL1V3YnRVeDR0Z1pWRFA1ZEhhTTMw?=
 =?utf-8?B?WVQvd3dWOUN4TmZuaE41SllOVkxwN3dEUmw2RFRaWm1qQ0R4RTlueU55NlQr?=
 =?utf-8?B?LzBlNithOEEyOWpxU2o3S2NuUGpvcTBTODcxRE5CMEpFMXhuRmpiM2xLdnpJ?=
 =?utf-8?B?clFUdHpCVy8yc2tXdXM5a05nd2R6YUw2RW41WkFQMHpIZW5BOE01TFkzZjJl?=
 =?utf-8?B?TVJyeDA5YVhROTJFNnJIY3ZrVU1sREZXSW9SQWJRV3ZZSEpqc2lmSlh4eGIv?=
 =?utf-8?B?bkN5VXBybUJoNjg0WWRGa29UN3RnelhkWkZ2dUZROFc5Rkp6MFo0K1g3UnFG?=
 =?utf-8?B?eE1DS1VudWIwVWRmanNtbU4zdVg4d1J4d1NPUlR1My93Ky8yME9uRTlCWFFz?=
 =?utf-8?B?TmpxeElBd0JxNVd4dkFBSXV6MnNqMnAzZlRRcUVrSU1qOFZaMm5zWmowRjIw?=
 =?utf-8?B?R0JkblU3Tnl1OXJ5WTlEeHNjZ3ora2tCcFBoMDBHR2tpNzZtMkNKL05ZYWU1?=
 =?utf-8?B?bEpuanNkdUcydXVLajM3OHhJem82MENjYWE0Y3VHNTdIbnNtVTNKOG9qSUN3?=
 =?utf-8?B?N0JMQlBUUjh0ZkRoVUJGaXdEMTRuWEx4MjlucjBZc0MvbTRBSmV6eXhKRGtC?=
 =?utf-8?B?RTlMcGd6eWR4YXZSNHg4UWFFT05oeWh3RkpsME5FNVFmZ3V4UDd2WlhYUzJE?=
 =?utf-8?B?YytVK2FiYTdSOG9PYzlTWit5UnUyRnVIeXZYOTdnMlowZEliVlRYa3h0ZlBV?=
 =?utf-8?B?WjY3WmhEUVd4NEt3RXBGUzBhSDIvMHc2ZnQ3Ym5OSmRCTXZEWFhGYjVHS3NN?=
 =?utf-8?B?OXJmdjNOVUFaSTFXL2ViaVR5SExGQlBIVno3enNxQTh2TC9zUEl2NnBmSG9S?=
 =?utf-8?B?aVEyTGpkTVEyWDdTR3FQdFNrd0lvcUZTeUpWWC9XNUN4N3RHdzl3YjBqSUFW?=
 =?utf-8?B?Q1FuZ0RZV1ZHRXJzbW5ibEVPUjk0Z243Z1hmdmxlZ29rWXFOWnJhT2E4SmJF?=
 =?utf-8?Q?rWVIAa17Xbq7zn5qUoyeIJQ8wWhlZEitk1RJyV2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f873d9-effd-4936-5b41-08d91942d5aa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:48:29.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zECl5CN9JBy6ohN3Lv2QSWC7u6B1VaDHwyWz2DpqlqqmzsSRQbxjOd6N/yhWwVlS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4519
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_CB05EE62-E5AC-458C-84C5-C70DA2575911_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 16 May 2021, at 23:51, Anshuman Khandual wrote:

> On 5/13/21 7:42 PM, Zi Yan wrote:
>> On 13 May 2021, at 3:20, Anshuman Khandual wrote:
>>
>>> Although the zero huge page is being shared across various processes,=
 each
>>> mapping needs to update its mm's MM_ANONPAGES stat by HPAGE_PMD_NR in=
 order
>>> to be consistent. This just updates the stats in set_huge_zero_page()=
 after
>>> the mapping gets created.
>>
>> In addition, MM_ANONPAGES stats should be decreased at zap_huge_pmd() =
and
>
> Right, would something like this work ?
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 63ed6b2..776984d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1678,6 +1678,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct v=
m_area_struct *vma,
>                         tlb_remove_page_size(tlb, pmd_page(orig_pmd), H=
PAGE_PMD_SIZE);
>         } else if (is_huge_zero_pmd(orig_pmd)) {
>                 zap_deposited_table(tlb->mm, pmd);
> +               add_mm_counter(tlb->mm, MM_ANONPAGES, -HPAGE_PMD_NR);
>                 spin_unlock(ptl);
>                 tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD=
_SIZE);
>         } else {
>

LGTM.

>> __split_huge_pmd_locked() when the zero huge page mapping is removed f=
rom
>> a process, right?
>
> __split_huge_pmd_locked() calls __split_huge_zero_page_pmd() which will=

> replace a zero huge page with multiple (HPAGE_PMD_NR) zero small pages.=

> Why should MM_ANONPAGES stats change for the MM when the mapping is sti=
ll
> out there but in normal pages now.

Ah, you are right. I missed this part. No need to change __split_huge_pmd=
_locked().

>>
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> Should it update MM_SHMEM_PAGES instead ? Applies on latest mainline.=

>>
>> zero huge page is added via do_huge_pmd_anonymous_page(), I think MM_A=
NONPAGES
>> is appropriate.
>
> Okay, sure.
>
>>
>>>
>>>  mm/huge_memory.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 63ed6b25deaa..262703304807 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -706,6 +706,7 @@ static void set_huge_zero_page(pgtable_t pgtable,=
 struct mm_struct *mm,
>>>  	if (pgtable)
>>>  		pgtable_trans_huge_deposit(mm, pmd, pgtable);
>>>  	set_pmd_at(mm, haddr, pmd, entry);
>>> +	add_mm_counter(mm, MM_ANONPAGES, HPAGE_PMD_NR);
>>>  	mm_inc_nr_ptes(mm);
>>>  }
>>>
>>> -- =

>>> 2.20.1
>>
>>
>> =E2=80=94
>> Best Regards,
>> Yan Zi
>>


=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_CB05EE62-E5AC-458C-84C5-C70DA2575911_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmCigjkPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKpFQP/398jeyVhdGrKPLnCDam7N3N3ekygMwXVn5K
vi1HUJE5nn73uKa/Nv15E5/mp7GDvrOp4+XBqXwbNNGPvBFgZjToxHOYVQiP5Li1
QFgTSOCRIbQcbk3hd5zW/yD5sKXFONpid9xFLv0N0yDNKu/ns2yizmtV76G5RRuo
MjHfqpW+qRoB0SAA99mbCvwbQCivPeryb9ZcFX8nn6+jdgDrY7LnpkpJZJs+dcWL
P/Maf6auulF7QJ0dtJ9qi0fwyizk8ExjaK6iSK9xXtHO11ps5qe+LaqdjD7v2J8W
83+A+NU3V+2e6Zc5hm5BkU7nXikek2g+m1D7CfFduuTMGvMK0dWFqjrQkrFGeKhA
MLqV8g7bWuHGdQbd7EbqTnX4tiOcCN5sMZckKXR8IsSEv3B7tHS3Xrqf6hxTDlxS
cJgR23z9W0zGaqXRwaqDzH7lsi85O8RqtfNBtxWkHhvloQMebK9xHFbN6aO0An+C
SXdlvaG3qNNQOFzhgDzQqsaIcl0J3HchAvjCd7r54/TaZ2KZ0wCWkuHUbzF3Ky+b
ENlgUb0HaIU+2uBfHEK1L/3LyYGbXleBYAIB5bB64i+DN8LTOOVW7lX20cSwafLu
3TG5ymX1HXHa/Bkcqit12vcZH1Z4gNByeyRaP/xgBHdO93vZfSoRI9rHVysNPyOV
oLoPzEfJ
=gfwY
-----END PGP SIGNATURE-----

--=_MailMate_CB05EE62-E5AC-458C-84C5-C70DA2575911_=--
