Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0EC3703E3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 01:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhD3XDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 19:03:31 -0400
Received: from mail-mw2nam12on2061.outbound.protection.outlook.com ([40.107.244.61]:9214
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230508AbhD3XDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 19:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmdnXRFu2M/G3SaqzX7IGCar+aKxU9VYQpQ0J2RrroxGSVTAfYFKd2wMIPJwBN5wrYZ73T4LDpmtaZqO7URU7zB24ea576dLvfEH6obv3tFybdgbq0OvarFZam/FEs7lmVekWqcuOx6XI1iidbRZqxDrmDw7Cf8EbXJjnxLbanRFwY/LxEdGAJ3DSdGPo8+GuGgVAOynebxKHCjXQwAJ2APoeaWVxALA5aH4Fvagv3b9aOU+a84O1+lhVaGkzvJ35Y8St1mnPZxxBBeqzrbNfUo5n8CDbhf6I6Zb7arocYK/wwxidafWSNYPRUygSEVZwuzTeTga1GETfxw4nEQSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EmnDPyTTJmfb0EvBBF8KZafJpIc/JVGPH6fHOFoqz8=;
 b=hkc3rTKQCWheUiQuxs40gv4hzfCqMAzzKdFkasn4xHefy81TZBK8pRkEMct6AmrTeGA+lykOHHovDLlnYmuw3DfoT+DTtKmPr/x94WJoyyCrL7O++ks821zYD+nMNv1s26RXbch8sJeDgARYQs7gUlhQOayijlFs4kdPPQfobrixGxB1/cValxCBMRE05uZ6zeu0hnYDtTyPjS540I+a1Fezu9IbzYRAIL+ARPhI0zznsUMF+MS9+bqOyPt3N4289sAqzhyy+qUygex0gPnJSBl2884hgxoI8SHYPJnSkaVqjBDQVgsx/fsXiMvgBycl1+r4CDfmZMaafWr43VS2gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EmnDPyTTJmfb0EvBBF8KZafJpIc/JVGPH6fHOFoqz8=;
 b=ZncwC/bDmu/4b+IpvbZzRAjIxMdkYjjWbFJmOUlfqtHqYA7ECnMpigAGuBFQZllJ8dZki4xNvBa6moiwjer4wOb1qlE2CiN+gnxNPPb5/ptesQ+cIl9MSgzkbfBoumhJADHVCfbpZbbgHeEVj0JTOX8h/TdHURmjB4ZGig7+Wqvyz1sg6eh2RZnptqnFx5Vg2rP5fIuJFeJ0IRXy6OiUMtODWN+XaH+qE5vwdR6sVyxKzorOsWSPaiffBi5HEXQuBpODZoQpImeF8YxFXlkBw1JREU28xU7KSB9eWFU7Ad1STrGqD0FGH/u7mr5kb7SNOpbFnj/ZSSdlg7CZQTQ2dA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB2562.namprd12.prod.outlook.com (2603:10b6:207:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 23:02:38 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2%7]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 23:02:38 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Yang Shi" <shy828301@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Wang Yugui" <wangyugui@e16-tech.com>,
        "Hugh Dickins" <hughd@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Linux MM" <linux-mm@kvack.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: thp: check total_mapcount instead of page_mapcount
Date:   Fri, 30 Apr 2021 19:02:32 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <B1466CC0-C9EE-4396-A255-158A9DF37A73@nvidia.com>
In-Reply-To: <CAHbLzkqAM-2Dg-JSy8Yqq99ch39BeSEnxPkmRg2BrhTF1M1N2A@mail.gmail.com>
References: <20210430210744.216095-1-shy828301@gmail.com>
 <F8189ACA-DE85-45F0-8C9B-A6F9D2099777@nvidia.com>
 <CAHbLzkqC8bdWtCMigmef4n0KwxKo4UuWoP1xphJiQgYChBB62Q@mail.gmail.com>
 <07E637C5-3FCD-4D78-936F-186FD051D6A9@nvidia.com>
 <CAHbLzkqAM-2Dg-JSy8Yqq99ch39BeSEnxPkmRg2BrhTF1M1N2A@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_134D0041-A156-42E8-9F89-ED20895396DE_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BL0PR02CA0080.namprd02.prod.outlook.com
 (2603:10b6:208:51::21) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.55.67] (216.228.112.22) by BL0PR02CA0080.namprd02.prod.outlook.com (2603:10b6:208:51::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 23:02:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03685c7d-1844-45c7-7d0b-08d90c2c0c74
X-MS-TrafficTypeDiagnostic: BL0PR12MB2562:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB25623E71BBCBE9B90B46372AC25E9@BL0PR12MB2562.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXDs3Nk+mBq5kc4GTePvw/Z4oq9lXFHRkcSadR6iUbze9FfkED43PzaFVLp9DvFl6RL0AYhTcgvox6EM6eMpxULrHLJGmoEw2Hjit3fnqFyiT0lXKHEm3+EjeS/wWgy+G/kH672h3tjFx7uciMLjNKLoEYQjRBiTwoIov3/zzULtZiI/dR9e0NAsuy5nndlAmoXFbHDJr+IM3XdKBl5Kxy01/iAc8qXv35fqflLZwYWpqYJL0isjc4I9W2CMzrJw+a5qUlt7IUCH6GoBSyzc006dgNxiu6M3WgC9zJe7rR1S3VzBRPrvaHgfImUm6X2fCJ9qRyPnAWx/2KiFyF9KFRezRAKXCVe4OjW095uTSLl7nGFBULk/0UEvYNwxu5fbIUEpZ0ezjI6BLY7avkFPPZj/Jjf59PlJEvrQiG7hNJFdTCoGvpa/F1O/fLSeD9/qx02wzE6IBnm3vxBS6FKFMY9i8O+F13FbUDuEz/9ITlGI8Q1CE6k16o5BGxxd8l34Bu4MOyIaZtO5JKs8afe8lo6hUPUltMcEXKqGaO9xInwbQ/zA2hb7mv5t8/iWUbdBbUoazU9uFdi+A2pTgK8GTHKCoLhtUCUxfaUCtXowu6eXLHvOJbSfT3d0lTwzK2LtXe3p2rerYrccFoFFpiIPl9PwwQx4asWL8T77c50kJbhB7NyT0mTIjeyINmyM2FbmGssk4Vi2OmjOEmiIWc54czba41Z+XebheLDVuzvJqf/Ll2xDfaoZ15WEdluOwGJl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(5660300002)(956004)(66946007)(26005)(2906002)(186003)(86362001)(66556008)(83380400001)(66476007)(16526019)(2616005)(33964004)(235185007)(36756003)(16576012)(6666004)(4326008)(53546011)(8936002)(6486002)(33656002)(478600001)(8676002)(38100700002)(316002)(54906003)(966005)(6916009)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Zm9WdE9XMlByNHpubzE4cm9KTTdJc2dxRHpoZDB0NjRpZ2ROakp2YUlGQVpx?=
 =?utf-8?B?K2U5blZsbHJ6OTNCOUpjRkQwVDVkU2Nja0JLaXBKS2tFZ1BDNkdCODFKc0pi?=
 =?utf-8?B?TmVEaWlsamxsZTJnWnJSUzh3SzErcHM3VUxtOUgzWm9adVQreTFpcEdkd3Vj?=
 =?utf-8?B?UmJZVTRDTWlabE9xMU12aHJodEU0SnBjN1hJL3NoRmJRR1dmQ0d2NzdvSjRY?=
 =?utf-8?B?WTcvS1B1cXhPVFN5Wld4VUF2REhRNE8ybExEdm5UWFg3QVZNVXM4VEoxRUwz?=
 =?utf-8?B?c0pJck1ZZ08rNWZUVU9NMWdNTkEyamdVMGk1WXpkSitSWHp6YkhUN2FMbGJ2?=
 =?utf-8?B?TGp1UjlydStxOFNaRzJPT3N2dlExeGdYSm9uaXNLUXF3TGFUSHAyc3JhZnJv?=
 =?utf-8?B?MEo2bElJc2pLc0VKd29YWmhKajY0aytRd1kraVA4ZlA5VHJ1eEJDMHRoR2Zj?=
 =?utf-8?B?QjNXU0xMNm15aXVxWlNIRmdtK2dZU2w0L0pQQlhLbVMrVWtJNDkyQTAxa0Zv?=
 =?utf-8?B?SGVOTkk0SWZTbFVqUng1N3l6OUFKaVp1VDhTcDNKNU02Yks5NWE3NnhkT09X?=
 =?utf-8?B?OU9WempUU2JJcVlJNVlHcWdUL29FcWo1Zld2NENQa3c5TjBqZFFxUEtWczk1?=
 =?utf-8?B?SnlBSm9sOTN6anJxUXVhZVBKNk5UQnpMelpsbmY0RXBmSGIvM1dvWElYWXpx?=
 =?utf-8?B?N3FMOStYTDBNY25lQ2U2SVkwMUNacE82L0NjcldpS3Jwckp2TWJyclFBTGti?=
 =?utf-8?B?ZnNyOFE5VzNWdTV5elE1YnFCQUk3c1hWQllOTGtRSzFBbXpvbEVaNEl5emhx?=
 =?utf-8?B?NEJKcVU0NDBBaGdkQjMrSEs2MGxwdHFFczk5dU5XZ1FNTzcremIvK2Q1LzBX?=
 =?utf-8?B?ckU1RGdFRkRvRHozZjhNVzY1d2VqcTZRVjV1em5CemFrWEo2ZGlWTy92WmFJ?=
 =?utf-8?B?R2tNbzNCYlEycEhkMFk3ZzgvV1hXK2hPNHA0Zjh2RjBPa0ttanh4VGYyeUw1?=
 =?utf-8?B?eTRjb01ka01VSjJEZE9veXBFV1ZyaXpCd2dxeWlNUHFpaFZ0M0MvZlNPL3Nr?=
 =?utf-8?B?TWd3ek9HN0ZWMUY2bWhTSXIxV0F2OEwvMGdVbFpjSm1CNzV0YmtLUVFqWFBK?=
 =?utf-8?B?MkVHZVBZWWgrczAyTUlhbFZ2blJBOFZuNGhjdk84UzcxQUZuM0d5YlBmcm16?=
 =?utf-8?B?Znp6eDhxYWxEUG1uYU9DcEVPUXBvb3lMV0FaR1FxT29LOERRR3NBYzhncFl2?=
 =?utf-8?B?bkxIeHlubDJCSVoxRk5EdERMQTI2d1J4MTQ3QkpaMEpicGZDZ2xTQXVxdWRq?=
 =?utf-8?B?NHNMRWhWaUc5QXZBSFBKZmMxRy9taEJWeHo5TitoSmpveGhHczNXWTZuNktP?=
 =?utf-8?B?TjFLOTVuajIzS3pOUWV0TEJYNmRBUURjMkZiaHQ4dWxFOHp0OU44L3czanZW?=
 =?utf-8?B?VTNBTEk0MGJuTzVqbVVjdWJ5SmlYSFhxUUY5cVJnMElKV0tNbU1xUkRqaCtz?=
 =?utf-8?B?K215MjdEb1l4Q0hSR2xscmNURklFNXd1NmZMK1A3NUV5TzJLeVdNdUF3Qncr?=
 =?utf-8?B?K2ZobkFNVkNuM1k5UG50U3pPQWdMdFBVaEgrckdqR0pPY1BLZXNVajhMaDZF?=
 =?utf-8?B?MDIrb1lPbktSQTF4MnUwRU9weU1VNzBaTjJxZGVoUEdCajl4MnI0TEpXUU1u?=
 =?utf-8?B?aFBDcEE3V2RlSG16eVdQU1JVS25RNzBIc0k0RDZDaFNpNXlBU2VlSkQrQXVL?=
 =?utf-8?Q?NUKDIUSSnHF5QXzFn6nCpxssJZEwwbyZmh6Z0rV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03685c7d-1844-45c7-7d0b-08d90c2c0c74
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 23:02:37.8729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySyI8TmsB/Buk9QS2MKLP7udKVbvujP1KxGwqg4tkA4W9SwyUFgBKlkrdFXWxDjq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2562
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_134D0041-A156-42E8-9F89-ED20895396DE_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 30 Apr 2021, at 18:55, Yang Shi wrote:

> On Fri, Apr 30, 2021 at 3:30 PM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 30 Apr 2021, at 17:56, Yang Shi wrote:
>>
>>> On Fri, Apr 30, 2021 at 2:30 PM Zi Yan <ziy@nvidia.com> wrote:
>>>>
>>>> On 30 Apr 2021, at 17:07, Yang Shi wrote:
>>>>
>>>>> When debugging the bug reported by Wang Yugui [1], try_to_unmap() m=
ay
>>>>> return false positive for PTE-mapped THP since page_mapcount() is u=
sed
>>>>> to check if the THP is unmapped, but it just checks compound mapoun=
t and
>>>>> head page's mapcount.  If the THP is PTE-mapped and head page is no=
t
>>>>> mapped, it may return false positive.
>>>>>
>>>>> Use total_mapcount() instead of page_mapcount() and do so for the
>>>>> VM_BUG_ON_PAGE in split_huge_page_to_list as well.
>>>>>
>>>>> [1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e=
16-tech.com/
>>>>>
>>>>> Signed-off-by: Yang Shi <shy828301@gmail.com>
>>>>> ---
>>>>>  mm/huge_memory.c | 2 +-
>>>>>  mm/rmap.c        | 2 +-
>>>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>> index 63ed6b25deaa..2122c3e853b9 100644
>>>>> --- a/mm/huge_memory.c
>>>>> +++ b/mm/huge_memory.c
>>>>> @@ -2718,7 +2718,7 @@ int split_huge_page_to_list(struct page *page=
, struct list_head *list)
>>>>>       }
>>>>>
>>>>>       unmap_page(head);
>>>>> -     VM_BUG_ON_PAGE(compound_mapcount(head), head);
>>>>> +     VM_BUG_ON_PAGE(total_mapcount(head), head);
>>>>
>>>> I am not sure about this change. The code below also checks total_ma=
pcount(head)
>>>> and returns EBUSY if the count is non-zero. This change makes the co=
de dead.
>>>
>>> It is actually dead if CONFIG_DEBUG_VM is enabled and total_mapcount
>>> is not 0 regardless of this change due to the below code, right?
>>>
>>> if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
>>>                         pr_alert("total_mapcount: %u, page_count(): %=
u\n",
>>>                                         mapcount, count);
>>>                         if (PageTail(page))
>>>                                 dump_page(head, NULL);
>>>                         dump_page(page, "total_mapcount(head) > 0");
>>>                         BUG();
>>>                 }
>>
>> Right. But with this change, mapcount will never be non-zero. The code=
 above
>> will be useless and can be removed.
>
> Yes, you are correct.
>
>>
>>>> On the other hand, the change will force all mappings to the page ha=
ve to be
>>>> successfully unmapped all the time. I am not sure if we want to do t=
hat.
>>>> Maybe it is better to just check total_mapcount() and fail the split=
=2E
>>>> The same situation happens with the code change below.
>>>
>>> IIUC, the code did force all mappings to the page to be unmapped in
>>> order to split it.
>>>>
>>>>>
>>>>>       /* block interrupt reentry in xa_lock and spinlock */
>>>>>       local_irq_disable();
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index 693a610e181d..2e547378ab5f 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -1777,7 +1777,7 @@ bool try_to_unmap(struct page *page, enum ttu=
_flags flags)
>>>>>       else
>>>>>               rmap_walk(page, &rwc);
>>>>>
>>>>> -     return !page_mapcount(page) ? true : false;
>>>>> +     return !total_mapcount(page) ? true : false;
>>>>>  }
>>>>
>>>> In unmap_page(), VM_BUG_ON_PAGE(!unmap_success, page) will force all=
 mappings
>>>> to the page have to be all unmapped, which might not be the case we =
want.
>>>
>>> AFAICT, I don't see such a case from all the callers of
>>> try_to_unmap(). Imay miss something, but I do have a hard time
>>> thinking of a usecase which can proceed safely with "not fully
>>> unmapped" page.
>>
>> This code change is correct, but after the change unmap_page() will fi=
re VM_BUG_ON
>> when not all mappings are unmapped. Along with the change above, we wi=
ll have
>> two identical VM_BUG_ONs happen one after another. We might want to re=
move one
>> of them.
>
> Yes. I'd prefer keep the one after unmap_page() since it seems more
> obvious. Any objection?

Sounds good to me.

>
>>
>> Also, this changes the semantics of try_to_unmap. The comment for try_=
to_unmap
>> might need to be updated.
>
> What comment do you refer to?

/**
 * try_to_unmap - try to remove all page table mappings to a page

a page -> a page and the compound page it belongs to

 * @page: the page to get unmapped

the page -> the page or the subpage of a compound page

 * @flags: action and flags
 *
 * Tries to remove all the page table entries which are mapping this
 * page, used in the pageout path.  Caller must hold the page lock.

this page -> this page and the compound page it belongs to

Feel free to change the wording if you find better ones.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_134D0041-A156-42E8-9F89-ED20895396DE_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmCMjIgPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKUH0P/2UWLAkwVHxCyBcSXbcZjjfv/7w4UtjH/18/
CY+VkHh5ft/CE6WZYWNDQwCGfDr5FAl0SMFYhSxY8ocCHGIWUhGtS12AQCyFSIZR
JFtB8E7/DMZEWxFuQD5saY89Ka2v6vOYI6eSoiU6TFaywQb3Jhaup1tSiTY+04VN
7TqMfx0ITvMFgMaYdvfhNF8Pd9Bq2kkFzw1qo0KUiXBr671qGlut6+B0JmSFKclK
VESGo37Pix7D4zsBcDFj/dpeTEWMltnIlA6aMsFxMlvh7EH2fvcXp4y7RCSmo0Ma
MegUmpPq6kb4CHXpgw+8vFSm99iFYQBFqkVoa+g2ZcTmAMp+++KMk6CR8p5jVXug
Gzp4FwvRoRTqAjop4zPU4Ou3XrUcf3rLoygEytBi4Kh3evvnxs9uGxXUj4SikrSf
KPBKp8xGtin4+BI8kguAR7XBY54HQGwulSRyCjZIX+8iFfySAi3GvnOYvEtlZ1Y+
u3+HwLXBKg3M3QFFQ4IMSvRmXuqtXQfZe94qsxQ7pmXWLkaL1lVsxCJjPKyvw/Mc
ASiO+nCwePRRqIsgIET35RUL/CNRARwbDjWt4eES9xK9zb09cHKS4F79f6wmWcSR
8t6df1qwLuJ8j09/tjwWawx1qWbV9bKpyFlLe8jHoEGEXxU5bOaNqkY5zLFgmV1e
I0G9EKF1
=rm77
-----END PGP SIGNATURE-----

--=_MailMate_134D0041-A156-42E8-9F89-ED20895396DE_=--
