Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17F83E2F39
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 20:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbhHFSYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 14:24:44 -0400
Received: from mail-sn1anam02on2082.outbound.protection.outlook.com ([40.107.96.82]:17345
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236916AbhHFSYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 14:24:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0M9VJSYOss0OqfgfG+o68N+7ng0LnD/i7E0fwmYjdORwAQQVyGvLE2kAHIRAMaIEmjl4X+mndB5yFFPJnt5If5gSPxMhzW9YN5xc11mgbrVbIb3ql0Rjx6vtKaGZw4M0oDVgXtQXvP+qbvH+b3Kfbae6DZMhYiq+vThctwyvCBKu/cht9duuOh4xzaWBptCpnCbGLwLh4zz5C3hM5UB/t+70YDVP/hVkL5O6PBnPaTLn9OFG+3gJQlsgRlWsrxl0Ye5xi77qazjoa7quO9IKxmHtggmigNo4OusFfr6jRJnNaT/fvx3S1QcC62HNVL7Z85jDEYU5/eita7aAuu1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79tsBjsFvWdvnZxIpwnsUfQ/eJSRYeTscXhQCpFlOsE=;
 b=TI0+EiRw2N3xqWBhxsWHmjcxqCv2u32Ta/YnkLXc9Ns8JH/qNV7RbLPxoXx57yd0+Ev5ht6neA1r6PXgtAPcC5BzZ1X+6vKZHJN9GlxCI7o/s3DuKuvRyH4YniCcb8Qbo2cs+ZPdfsMUjkO/cZh2pe5mtqQtAmlwr7aanGZYcwVzu6z6WCsmZBtX1o8ayM4fPdXqEBgn1CP6LxHPLQpc8T6ajqDs9IdWSF7SgoPbB1VSrMoK4OYdU+tz9BZ/Q5vG+7qtBHhTPk4foIpq+iF/JAfgZPJ3sPdDmObgLTOvR9P1ZpJpxOog+TJR9EROGeNK2zPyoT9XXvdMMlbYwU9ZVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79tsBjsFvWdvnZxIpwnsUfQ/eJSRYeTscXhQCpFlOsE=;
 b=lNdjLOvGbSIzs0lqO1VK9okOaNslaU0TcHZCSqCQ8Uj0jj7TZ0P72aKLKBr90yydAjGysB/DQHBX+5EiWuFbv5eEI+8szHzTuktT4lFJY7CYlwD13RfVT6zzsHXOmH3fcdxWhgYS5p71r9GDd54ozXbAegv3lVyyAaXB2C7LOM0worU6yBRXd5i/e3JKxeI5mT+Zp8jkY/93nibXZfHW4/mTab6X9Cr+7eCSTTqe/PPme30jPK+kT8Lx8A5Ff9fy3y/S/GWsh51dKUPQ9TQsJyu1fy8vySyZaPnqH+enIt5yB2CyZ+zy4djPbzUvA7D+B9g/083FLuH1pyu1BzsWsg==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.18; Fri, 6 Aug
 2021 18:24:25 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4394.017; Fri, 6 Aug 2021
 18:24:25 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [RFC PATCH 00/15] Make MAX_ORDER adjustable as a kernel boot time parameter.
Date:   Fri, 06 Aug 2021 14:24:19 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <83221D29-5ABE-40F1-8FF3-3B901E494C33@nvidia.com>
In-Reply-To: <59c59a77-cf93-40a8-2ad5-b72d87b8815a@redhat.com>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <40982106-0eee-4e62-7ce0-c4787b0afac4@suse.cz>
 <72b317e5-c78a-f0bc-fe69-f82261ec252e@redhat.com>
 <3417eb98-36c8-5459-c83e-52f90e42a146@suse.cz>
 <59c59a77-cf93-40a8-2ad5-b72d87b8815a@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_0CD14531-8911-4D77-85DC-817A7185342E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:208:32e::14) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.50.235] (216.228.112.22) by BLAPR03CA0129.namprd03.prod.outlook.com (2603:10b6:208:32e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Fri, 6 Aug 2021 18:24:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a98b017-03d1-4570-774c-08d959076b97
X-MS-TrafficTypeDiagnostic: MN2PR12MB4344:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB434440BFD60609EB860BF022C2F39@MN2PR12MB4344.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZGznIEvD08gfZIOG0t295wCY7Is0ZBhCq1rSQ8eUAZ4w4iwOE+i+JtLiGFQjYn5NsVrMqz1T3C1y0Mq+JhxobVQqoFlckErgEqZFYHcM6/9FCtOtVfO1BDZ2F1Qo7KdkryjEdV8608iufajsG6oOgxhxPJZ9Pwp+OPpMRjAakCqNIPz6Ca/ovaXtoJuCtHdw52pcVzQBZ3fYohKJ8d0jaPGyXT/scIropyvZmJ08lMgrEpFk0cSpz6nHrQXijajCgGAkGbcTr+FzeDeM0e7E3oanONivxZhSye/YRcdS/aFxCpLihhNCzip2GJoHd08XJDSBrOSlkfi1vCT4OAIJo2Rcu3WpJj6/YsP+0NR5btEWkmrn9TSVMYDY6srffvTN95aZYWz3hVFQN8fuoxrTCxhJK6bAGb/07ArmqW7NV2/y6r9b9TUwLPcYo0Wr3Zezvf69aui1EQcARYk2S/vKIOdLNRaAPHANLNtdRtYlUkQEIX2Jmu9+fBdEcZojejIY3MEZ0W7yM1GzgztfhiKXowSUZC35bnhIPIhNRfeROOECVdCKUFhkJNHKnc30YY1AS4usRy2klktjlPfWbUPbA895xRFdtqGDJuLWSPnjYtuVLAIrEXMsNauhapYtYcLkss/zB8JEuZBiFwZRJlTNlOM3iwMxbY0jYhptd89L/ajNBh6SbRZ2q0JJFW3JxPWx3rkzESZJPO/wV28Y6PHvq2u7QBSW36GqfwnsYrVKUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(186003)(26005)(8936002)(53546011)(33656002)(8676002)(5660300002)(235185007)(6486002)(21480400003)(36756003)(508600001)(6666004)(38100700002)(4326008)(2616005)(956004)(6916009)(316002)(33964004)(66556008)(54906003)(16576012)(66476007)(66946007)(86362001)(2906002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3RzS216bS91Z29lNFRKZWNQTERRTVhwbGNzSmw4RlRqWTZuOVFlcWJwZmlq?=
 =?utf-8?B?VnlLRU9HVDh1MnFGT1ErUFhLRlZ2R0ZYK2pwVUYvVXh5ZE5PSDdRYUJPZTdt?=
 =?utf-8?B?T25jU21jdUFEQ2M4WWRqaFFPeG44NmUvbjJjNXVUVjBkWVRTdWFrMGRFV2VD?=
 =?utf-8?B?RGppZGlpYVlEZ1NYNDgrOCt4R2c0Uzd4Z1ZpUlZwZlF2MXVXNVU2dmswNjVs?=
 =?utf-8?B?dE9SbmdWS3BISGwydTZHZmlqaW96WVRETGN5eDBOZUlKb2dDdGovcStWYmFL?=
 =?utf-8?B?c1FieTNncWhERVc4M0RUaWI4MUR0RmJOZ1N1QUZ0b09VMGltQjJ0bXlkYTJi?=
 =?utf-8?B?RzhPM1d4NUpuQ09mMHhEVnk3OE9jSXoxT1VxTWYrRXEweGsvempqTnZFYkhJ?=
 =?utf-8?B?dlc1VXhyZVJEWHppVlVieXBtT1VmUkFoWlhIZWpwL09mZlJRUVhOdEdOeHNp?=
 =?utf-8?B?SUJOaHJiUjN5K3hTQmQ0U0s0Q2RqRnJwaSs2U1czNVkzdXhDdTZMQ2RZYTRS?=
 =?utf-8?B?UUtMZEVBcU9KWXN1WGVlaXpETk1ndVVxWVd2UlJqdFRKUkhRSDVOcE9Hc0kx?=
 =?utf-8?B?MmNrY3lwd2QrcjRsMjZpTTU0MC9DczFZSytrTHUybW1KZTV3UmhUUVViYWRq?=
 =?utf-8?B?VHU3SnE1QnpIRGFJU0Rrb1ZUNjZMZGlUaFNnVWJOZFlaV0hxY1Z1UFMxYzhy?=
 =?utf-8?B?K1J4cEI2L1UvSGRHS3NXOHdCVHRxUVZRTjljK3VzVmwyNkVtbjhUbjY1ZUcr?=
 =?utf-8?B?aDZ4SXBFcjU2YWNJMlh1bm1zMVpDSHNBbWRJc3poR2pYY0QxbldtWUZxaWZW?=
 =?utf-8?B?V1NsQllPaW96amptdDF6SytRek9jMXlDVWh5d1J1SnoxejYzSHd2ajNyQ0E3?=
 =?utf-8?B?dHdCSnhERTgyN2xodm5hTXNsc3R4UjcrQ05aY0pqZDBicVhsSmZpbnJ1bnhp?=
 =?utf-8?B?M2RpMW9ad2UwOFhPZk4xbHAxT3JCMTZZT1pSZmVoMTVBMGFRSXM1MkUweDNN?=
 =?utf-8?B?NlNuSmJmSnJMaUpCMy9nZEo4ckhzMnk3aXVZeHFFM3NvZm8zQ29ZYTNxRCtS?=
 =?utf-8?B?UHFDeTF5cXI4eXo0MlNaVHhVaUp0OHA1V01xMlI1VW9Ia2ZnSi8yelpzVTV2?=
 =?utf-8?B?VFYybElzekZuNXlzWEkwL3RZZkk1dEFLOHBPUFhKY1UyeDlRdDkwcUUzdXl5?=
 =?utf-8?B?dW1iS1NDQ2FBMHRCZTJ6SGFoZkQyVlNWWUR3cG52QjJPOVNMVVFvdFNGMzZy?=
 =?utf-8?B?am9hSURPV0tKZEE4Sm5sT1ZoUUk5ZTdJUUdkRG5aSWlJWFhySWtlK0pSb0xF?=
 =?utf-8?B?YUczSHRTcExCbnZ1VkYybXpFZTllVFZ3TnEzWS93czdhVC9wakNBTWp1dGta?=
 =?utf-8?B?MzlaWFVOdDFDQ3MwTzZvT1B0SmlJcDFlb2NRUFpYaW9aYTFMNkFRdGRJOGFn?=
 =?utf-8?B?OW5naW9MaTExaFVwZEVjaXRuY0xlZVFuM09aSmF4NkJqRmxybVgzODZtUFEw?=
 =?utf-8?B?RzFLdHVIQWw1dDg4YytvZXdRUC9QdGVvbzI5Qk5kS1d4ZXRwOU9EU29PcTJH?=
 =?utf-8?B?OTVZM0tMRmZmbDZNNDhmc3liS2tyaWdsSkVXK1l4SVprY3I3SGVBRW84ajRQ?=
 =?utf-8?B?aEVkanp3RUswc08xcmZycHZkM2tiazlOL0xPU2xRaEZld0lzUWtZL29QY2xT?=
 =?utf-8?B?QUgyZnpWYk5JYTVNcUlBUWdQT1p2aERBbGVWelg4c3haUTN2djZrS3B3Vm1t?=
 =?utf-8?Q?opbWMcqvN9pkQaonjQzDK1Z1Y5rUysd8yP8qxET?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a98b017-03d1-4570-774c-08d959076b97
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 18:24:25.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0M2SJM4VzgBv5kWCuzoF/4XrCWytBuS4zM8iP4Rv03PL1loiLMdI8KOsAAm8Z4O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0CD14531-8911-4D77-85DC-817A7185342E_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 6 Aug 2021, at 13:08, David Hildenbrand wrote:

> On 06.08.21 18:54, Vlastimil Babka wrote:
>> On 8/6/21 6:16 PM, David Hildenbrand wrote:
>>> On 06.08.21 17:36, Vlastimil Babka wrote:
>>>> On 8/5/21 9:02 PM, Zi Yan wrote:
>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>>> Patch 3 restores the pfn_valid_within() check when buddy allocator =
can merge
>>>>> pages across memory sections. The check was removed when ARM64 gets=
 rid of holes
>>>>> in zones, but holes can appear in zones again after this patchset.
>>>>
>>>> To me that's most unwelcome resurrection. I kinda missed it was goin=
g away and
>>>> now I can't even rejoice? I assume the systems that will be bumping =
max_order
>>>> have a lot of memory. Are they going to have many holes? What if we =
just
>>>> sacrificed the memory that would have a hole and don't add it to bud=
dy at all?
>>>
>>> I think the old implementation was just horrible and the description =
we have
>>> here still suffers from that old crap: "but holes can appear in zones=
 again".
>>> No, it's not related to holes in zones at all. We can have MAX_ORDER =
-1 pages
>>> that are partially a hole.
>>>
>>> And to be precise, "hole" here means "there is no memmap" and not "th=
ere is a
>>> hole but it has a valid memmap".
>>
>> Yes.
>>
>>> But IIRC, we now have under SPARSEMEM always a complete memmap for a =
complete
>>> memory sections (when talking about system RAM, ZONE_DEVICE is differ=
ent but we
>>> don't really care for now I think).
>>>
>>> So instead of introducing what we had before, I think we should look =
into
>>> something that doesn't confuse each person that stumbles over it out =
there. What
>>> does pfn_valid_within() even mean in the new context? pfn_valid() is =
most
>>> probably no longer what we really want, as we're dealing with multipl=
e sections
>>> that might be online or offline; in the old world, this was different=
, as a
>>> MAX_ORDER -1 page was completely contained in a memory section that w=
as either
>>> online or offline.
>>>
>>> I'd imagine something that expresses something different in the conte=
xt of
>>> sparsemem:
>>>
>>> "Some page orders, such as MAX_ORDER -1, might span multiple memory s=
ections.
>>> Each memory section has a completely valid memmap if online. Memory s=
ections
>>> might either be completely online or completely offline. pfn_to_onlin=
e_page()
>>> might succeed on one part of a MAX_ORDER - 1 page, but not on another=
 part. But
>>> it will certainly be consistent within one memory section."
>>>
>>> Further, as we know that MAX_ORDER -1 and memory sections are a power=
 of two, we
>>> can actually do a binary search to identify boundaries, instead of ha=
ving to
>>> check each and every page in the range.
>>>
>>> Is what I describe the actual reason why we introduce pfn_valid_withi=
n() ? (and
>>> might better introduce something new, with a better fitting name?)
>>
>> What I don't like is mainly the re-addition of pfn_valid_within() (or =
whatever
>> we'd call it) into __free_one_page() for performance reasons, and also=
 to
>> various pfn scanners (compaction) for performance and "I must not forg=
et to
>> check this, or do I?" confusion reasons. It would be really great if w=
e could
>> keep a guarantee that memmap exists for MAX_ORDER blocks. I see two wa=
ys to
>> achieve that:
>>
>> 1. we create memmap for MAX_ORDER blocks, pages in sections not online=
 are
>> marked as reserved or some other state that allows us to do checks suc=
h as "is
>> there a buddy? no" without accessing a missing memmap
>> 2. smaller blocks than MAX_ORDER are not released to buddy allocator
>>
>> I think 1 would be more work, but less wasteful in the end?
>
> It will end up seriously messing with memory hot(un)plug. It's not suff=
icient if there is a memmap (pfn_valid()), it has to be online (pfn_to_on=
line_page()) to actually have a meaning.
>
> So you'd have to  allocate a memmap for all such memory sections, initi=
alize it to all PG_Reserved ("memory hole") and mark these memory section=
s online. Further, you need memory block devices that are initialized and=
 online.
>
> So far so good, although wasteful. What happens if someone hotplugs a m=
emory block that doesn't span a complete MAX_ORDER -1 page? Broken.
>
>
> The only "workaround" would be requiring that MAX_ORDER - 1 cannot be b=
igger than memory blocks (memory_block_size_bytes()). The memory block si=
ze determines our hot(un)plug granularity and can (on some archs already)=
 be determined at runtime. As both (MAX_ORDER and memory_block_size_bytes=
) would be determined at runtime, for example, by an admin explicitly req=
uesting it, this might be feasible.
>
>
> Memory hot(un)plug / onlining / offlining would most probably work natu=
rally (although the hot(un)plug granularity is then limited to e.g., 1GiB=
 memory blocks). But if that's what an admin requests on the command line=
, so be it.
>
> What might need some thought, though, is having overlapping sections/su=
ch memory blocks with devmem. Sub-section hotadd has to continue working =
unless we want to break some PMEM devices seriously.

Thanks a lot for your valuable inputs!

Yes, this might work. But it seems to also defeat the purpose of sparse m=
emory, which allow only memmapping present PFNs, right? Also it requires =
a lot more intrusive changes, which might not be accepted easily.

I will look into the cost of the added pfn checks and try to optimize it.=
 One thing I can think of is that these non-present PFNs should only appe=
ar at the beginning and at the end of a zone, since HOLES_IN_ZONE is gone=
, maybe I just need to store and check PFN range of a zone instead of che=
cking memory section validity and modify the zone PFN range during memory=
 hot(un)plug. For offline pages in the middle of a zone, struct page stil=
l exists and PageBuddy() returns false, since PG_offline is set, right?


=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_0CD14531-8911-4D77-85DC-817A7185342E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmENflMPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKwtcP/2J1qnXIw1CCtJtI33OumNoiUG5HumtgjiP2
8wCPa2vO3s1v0goADFzr5W7gaj1oPGeMyqenfG7Yq2AqMwMX6iYyoSHHtpaM+Zag
wkuIKmBwDfIrkKsv+RShvmNWVfrvfTWXJzwc7gfEIrt40hpwK864pRONJTIEIV4e
D1KALTohCn3gbss4gAzq3nPz4EyVAMKix8HAz26YPOQmvSayiTmW40sSnC3fdUuQ
HzNZaY4Uwu6gSogdSsLgj9tIf5B/lZYWLNM2DImWfIqMhTZ87zsFXJ9IdZQK3BEl
85QJGLprV53hdnU3dUW8g24GQ78yNdQFFHfO1ErQRLWdBJNeg01iNIvDGXh8FOAG
x/Qk/lnljmSLyYf7azDBFwip3HvJf4FHLtcQc1f9sNndG9z/sFtENu/3gna2VUO7
Nzi4GYlZl1dSg1wXUYp+eY69BtBJ2wpc3N4fnMTl2w1TxD9SwJVyiBsOLtAFyh9v
KCtKyWzTyj3Uby/b4CqaqrCjIRbbISKhwbIKHBfytJqDBiiAwd1VOmQWuW53gpOV
7iZcJzBkDPAiJitN1YeS6NIdGcbXct7sAeXUz+88K6z/4OwRzwR9HRtgXBjDH/fk
q2KmPJZFA2diNI+0i2pE0nX+okrXZsvGOD9bCW3cX7DG5wP0QcEGk4UAdH6JsS1X
nIM4YrEY
=Zcuo
-----END PGP SIGNATURE-----

--=_MailMate_0CD14531-8911-4D77-85DC-817A7185342E_=--
