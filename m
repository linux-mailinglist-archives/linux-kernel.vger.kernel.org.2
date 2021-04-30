Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EE3370381
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 00:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhD3Wbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 18:31:47 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:59617
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231308AbhD3Wbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 18:31:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAVsaNUkt1eotNajSHR7mA2wZ2N4xunI6ZEK4IS+eMPTgurYQWkgihtH8lY6gRLQh+vFhw+lqHSEkmXOkdBhD2PMlK7+ERB+XcvvqiNy/tDoSN2/gkKSf/sLZM6VlA2HIkORYBdcGYjdnxnh0Z1Ul32IsXyzid8cs8MlD4t6HRHuMU5x4CeK8I58jEvAje5T4rpDuDaIgdKRuP5ta+WBl9ApGMd56RSM6YC21NbvLSEquN5YE9fwFuYQvjTOi98GtYLJlKPoznc1Fpm48OdCWtX0mb6qcbaefmGj4XN6BBSS4qR7hUj6fnBEjom5/U3hB4aCvQv6/yti6AsqgQ2sCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZHUybR17K9C85NLbX7uRMAb3hVBx7pp9Pg40jS0Rks=;
 b=AFcf5koi8ABGbwfEb8zFOi53uVa8KbpAZpAAr32NgWn2ZpZbO197zRM59hdWCrV8qgLRmTxxPaKih8l/7UaRY2+2ooOfETIVosHNNEKu0Skt6H7WKHUF2ETw0u+7sn6CjiTWg7pHNjcuTB0TyAu5kOIKc3AQ8CFiVWqbBS/zud3pixAcz/BY56ZW2rG8zBZ+6cWHV+3ynvXUnGdUxkTUwiK301yBssJYJljAtaRHRSguRU02wgWWCEm+Qtw1JrUArapRC1rJ+125nEMbGi8Uycvjx5DFRhhHRggnX7sGk4N570XJm+npRNR+karQ0E0iWj3j7Q0RjoCGT+aw7SRYyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZHUybR17K9C85NLbX7uRMAb3hVBx7pp9Pg40jS0Rks=;
 b=nxh0ddGK1Fsbxx80C2lx02nbDV65/LUshudqd3Y/AeA7pRWhHRfbImD5r+epJQHpLWLRSUiuiEYnXb2BLRhLvwkdrdH62wfpt5cPZ6rY2EVoVgueQ53ttdmMYH/4XqdV8sWkN10ETD7MeY1GGgsJm8bkED4B4ccwTjGnx7kFCCT/93zxuURQh9QHzmiMfu2sVL8zvMYazQS2LhRLLt05glsk8qZi7u0NCPKfeKP/Hvj7E+joRKNhU9SX30oqRZtqj+XRxV9Obokuh/l6bPyH5ZOFV5ah/el6+rcVn3yly+eWsKvpJiq+VwJtRnFQK/z0AcJei2740DpYGYaAyUSWOQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB4996.namprd12.prod.outlook.com (2603:10b6:208:1c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Fri, 30 Apr
 2021 22:30:56 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2%7]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 22:30:56 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Yang Shi" <shy828301@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Wang Yugui" <wangyugui@e16-tech.com>,
        "Hugh Dickins" <hughd@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Linux MM" <linux-mm@kvack.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: thp: check total_mapcount instead of page_mapcount
Date:   Fri, 30 Apr 2021 18:30:50 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <07E637C5-3FCD-4D78-936F-186FD051D6A9@nvidia.com>
In-Reply-To: <CAHbLzkqC8bdWtCMigmef4n0KwxKo4UuWoP1xphJiQgYChBB62Q@mail.gmail.com>
References: <20210430210744.216095-1-shy828301@gmail.com>
 <F8189ACA-DE85-45F0-8C9B-A6F9D2099777@nvidia.com>
 <CAHbLzkqC8bdWtCMigmef4n0KwxKo4UuWoP1xphJiQgYChBB62Q@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2C43F591-DD11-458B-B32F-348BCA6364E5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BL1PR13CA0346.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::21) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.55.67] (216.228.112.22) by BL1PR13CA0346.namprd13.prod.outlook.com (2603:10b6:208:2c6::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend Transport; Fri, 30 Apr 2021 22:30:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3b450ce-2818-4c64-06d2-08d90c279eba
X-MS-TrafficTypeDiagnostic: BL0PR12MB4996:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4996FBDCF531B368C2C2B1E6C25E9@BL0PR12MB4996.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MfNIAa5iicPYpfT9CbkVMvtCnFb1cUxVXCzqP48GkiOj+4/9OiIyEtJ9QXXBrh2jVtHdUPfwZeZpsEjHXWGq5OjLSrFTlmymG+vyPnZraH8yA8Kk46MN+rQY6lbcFUjLWb54Dh2ygllR4S4zu9kIGuhrIJ7KA5kboZ2peoJlCn8JiuaiSh/Pa7tbr2f/w8Wi6pWHda2o0AAgLdoz87204P6uT/DB/BOO8uvxwyoPnYChORF7S9Hn2yPDedsW5Ci26f8vo88OOv+YsNg8qWONXCXCaifqftjiDY9kH4dr3PWaG9bkICE6tEjJn19B9/lIp5StLnXgnT2Te21m3kK/HQIfJGc/5YFy6VhMMsWSjYMM8jWo1Aypz0yUS1Dyc4tw0R6/TF+Or66qZ9TaFXlNeUbk3zdMvu/xyNlDvNONthBsCgk1SKKMALIDAeTHh5Gfsq6DHP9wYfGbQXvC93P1koM45j1bp/tqifsG9tYorrW2ygA9fRMoXJFXx5QtuhJM6X0zcb2Ypc+v/F1by9QTQUEPhiM6knh2F7x08zP3+dd5wx9yDgmntYwX9LUc5XHUVaVeB6IPhGbZfW0chbSiCnzHAJuXVg0EhPGf8XUzJmHKL3WWUgOXt9qPiCKE/PZS3hwDtrXLWyWXG9u3AzwHY+5JjNlEkrMmz5HAhwn12wWyXmSUTuZonAGFsNLz1kBfirt4SPF6eMYzNSZG7HJZfg1tw1cG+NlR/QBaLS8pOjXCKWeI6sJ6f8SoAxjEeZ07
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(83380400001)(5660300002)(38100700002)(2906002)(6486002)(33964004)(8936002)(4326008)(26005)(235185007)(966005)(33656002)(53546011)(36756003)(16526019)(16576012)(6916009)(66476007)(8676002)(956004)(2616005)(86362001)(66946007)(186003)(54906003)(478600001)(316002)(66556008)(72826003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MHVWSnpnQVQxUE4wdlBmVUpxcExLSGZremw4bVJValIybkF6WktEYk4zYWlR?=
 =?utf-8?B?L1d3ajRmZmpBajhjZkNJSS9oZnFlOUJxU3JNa1N4Y0pvUnk3UTdXMVdkSEZ6?=
 =?utf-8?B?NUVwVUF1YThacVZ2SS9Xc2ZHbUZTTXhqWEp4L3dvU1ZBNmtYV3RGNjFBQ2Ro?=
 =?utf-8?B?WEhubXdUYzdxdDgzQTdDbEthK2gzdjBrNjFPK0Z0OFVNaGZSbXR3Q2paUnpx?=
 =?utf-8?B?R2JBWkNrR1psRlgrZGZWdm44Vm0yS2UyaUZ0dzRpUktIVTlrV2hKUHA1V0Mr?=
 =?utf-8?B?dFhabXAxNjR1QjJyVHdWbUc5L3hqVjllRmZVY1JCdDVSY1NNTWl6QzNuMTJC?=
 =?utf-8?B?VC9CZ3dJemZET25DWU9YUkY1TGpoQmVRUGN3ZEFwbEk3Uk05WjJ1SkVYcEdm?=
 =?utf-8?B?M2V4Ti94QVFWY0NRREFXWkk0bkFQMyt3TDFuRjMwWVVxNmJhby8yZG5NYzR0?=
 =?utf-8?B?OWFWYWhqaXdDdG9GNytXSXVSYjBlZ2h4aEJWU0pYODNMcENBWktOQTQyWDh6?=
 =?utf-8?B?QXlFRGpJU0VjOGJCU1l5SHNCUnFnWitMTGp3d1RRb0FiVnN4cEFiZlhOTXk2?=
 =?utf-8?B?VDRFZ0xxTjRKUVBMWUlObkhkNlhIb3FBT1hkVHNsY253ZXpaU01OMERITGJp?=
 =?utf-8?B?U1pBSEU3QVZVd3lzVGRrQmRxNkwyNHZ2bE1ac281S3dPa1VPT09WeWlUQW9D?=
 =?utf-8?B?NktDWE1qQmJUZ09Nc1FlNUY5OHZwdjUvRTROZUV0Yi91ZnZJdUhGYm5aQlFS?=
 =?utf-8?B?ZlV5RHdoQi9sVGdFYk5ncXViNVFWS3NGekJINWR6YlB4R0RDUE1wZU1TTlhC?=
 =?utf-8?B?WWVvNCtvM1RZajJ6dFhTSVd6NkN0NkdCdFltZmpXZWpNTUJUa1RROUF0bStT?=
 =?utf-8?B?eHVsOGFDak42VnUybnV1MGYrQzFPdTFTTDdiL2dIalZoNCtrcTBraG1XeHYv?=
 =?utf-8?B?NTZKdjk4QUQ0K1NCVitheTlXUXlCUFlvY0pSMVRWd3pxNTk3dTBSQ0U3SGpu?=
 =?utf-8?B?bU5wUytwdjArVlhyd21QVzdBUC9vZTd5ZkVMcnNwYXJBWm1na0JUa1IyQndl?=
 =?utf-8?B?MmovYTdFR21jb1pqSHJzMTN3eEZIclluKzFzQVF2Ykt2REpkL3loZG9NQWZu?=
 =?utf-8?B?eHlsSDlEYXEwdkNsZWFwcURmdW9ieWRkcUUveVNBNWxKWTFHRGpzZW9RUEVp?=
 =?utf-8?B?S1RmM1BYMFZnVnRqOXBRMFBpMi8wTDNtQVQwN09Hckg3REFxN2p2MUlmeUZX?=
 =?utf-8?B?S1VXTkVkQVhubnZCVW1td2FBTTIzVW0xUGtoVjhQQ0lJMmllU042UHVFMmUz?=
 =?utf-8?B?VXJUQnlnay95bUlBenlhM2VoU0RQWS9kYWZXUmFqMDJiQ2E2eWZER0NSYmdU?=
 =?utf-8?B?YlFwMUdEQTRHUlRISStZWkRhS1VHZEpiYjhTMC9xTVRjR0N2ckpQeEdLSHJE?=
 =?utf-8?B?Y0N4OGlLeTFFOGU3dGoray94UXRrOVlyaGd4M0xHOGVzQk1nY1RnenU1WnVW?=
 =?utf-8?B?U0k5NmVMa2FnSm9jMnk5ZVFZUFV0WkljbCtRTzdmZk9kRFVPalpvaGl6U2l3?=
 =?utf-8?B?ekZUeTRiUXZibWEyTFNDaVJKbjFUK1VjdC9ubDhyTTd1NVo5ZkJDZVV2UTV0?=
 =?utf-8?B?dFF6RDJwanFlNCswTXJ4M2NYWGZrTmdnRDExNS9SQzQzak9aeTZlUklVRE9w?=
 =?utf-8?B?MHJ6WmhUanFPTHRscEFtaThLRU9yRTlBK0RyOStwSk00VmFvNGprK0R0eTFS?=
 =?utf-8?Q?FBc4WKj2NORAN3+UgrXmggW4i8GZUKDFp8lPNNF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b450ce-2818-4c64-06d2-08d90c279eba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 22:30:55.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgpSz+nEGmxqPXjX+D4ySSNNxIcVgVO1OYdeEqVSPPG9aOouNhXwvUsJc9/oANKB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4996
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_2C43F591-DD11-458B-B32F-348BCA6364E5_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 30 Apr 2021, at 17:56, Yang Shi wrote:

> On Fri, Apr 30, 2021 at 2:30 PM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 30 Apr 2021, at 17:07, Yang Shi wrote:
>>
>>> When debugging the bug reported by Wang Yugui [1], try_to_unmap() may=

>>> return false positive for PTE-mapped THP since page_mapcount() is use=
d
>>> to check if the THP is unmapped, but it just checks compound mapount =
and
>>> head page's mapcount.  If the THP is PTE-mapped and head page is not
>>> mapped, it may return false positive.
>>>
>>> Use total_mapcount() instead of page_mapcount() and do so for the
>>> VM_BUG_ON_PAGE in split_huge_page_to_list as well.
>>>
>>> [1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16=
-tech.com/
>>>
>>> Signed-off-by: Yang Shi <shy828301@gmail.com>
>>> ---
>>>  mm/huge_memory.c | 2 +-
>>>  mm/rmap.c        | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 63ed6b25deaa..2122c3e853b9 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -2718,7 +2718,7 @@ int split_huge_page_to_list(struct page *page, =
struct list_head *list)
>>>       }
>>>
>>>       unmap_page(head);
>>> -     VM_BUG_ON_PAGE(compound_mapcount(head), head);
>>> +     VM_BUG_ON_PAGE(total_mapcount(head), head);
>>
>> I am not sure about this change. The code below also checks total_mapc=
ount(head)
>> and returns EBUSY if the count is non-zero. This change makes the code=
 dead.
>
> It is actually dead if CONFIG_DEBUG_VM is enabled and total_mapcount
> is not 0 regardless of this change due to the below code, right?
>
> if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
>                         pr_alert("total_mapcount: %u, page_count(): %u\=
n",
>                                         mapcount, count);
>                         if (PageTail(page))
>                                 dump_page(head, NULL);
>                         dump_page(page, "total_mapcount(head) > 0");
>                         BUG();
>                 }

Right. But with this change, mapcount will never be non-zero. The code ab=
ove
will be useless and can be removed.

>> On the other hand, the change will force all mappings to the page have=
 to be
>> successfully unmapped all the time. I am not sure if we want to do tha=
t.
>> Maybe it is better to just check total_mapcount() and fail the split.
>> The same situation happens with the code change below.
>
> IIUC, the code did force all mappings to the page to be unmapped in
> order to split it.
>>
>>>
>>>       /* block interrupt reentry in xa_lock and spinlock */
>>>       local_irq_disable();
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 693a610e181d..2e547378ab5f 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1777,7 +1777,7 @@ bool try_to_unmap(struct page *page, enum ttu_f=
lags flags)
>>>       else
>>>               rmap_walk(page, &rwc);
>>>
>>> -     return !page_mapcount(page) ? true : false;
>>> +     return !total_mapcount(page) ? true : false;
>>>  }
>>
>> In unmap_page(), VM_BUG_ON_PAGE(!unmap_success, page) will force all m=
appings
>> to the page have to be all unmapped, which might not be the case we wa=
nt.
>
> AFAICT, I don't see such a case from all the callers of
> try_to_unmap(). Imay miss something, but I do have a hard time
> thinking of a usecase which can proceed safely with "not fully
> unmapped" page.

This code change is correct, but after the change unmap_page() will fire =
VM_BUG_ON
when not all mappings are unmapped. Along with the change above, we will =
have
two identical VM_BUG_ONs happen one after another. We might want to remov=
e one
of them.

Also, this changes the semantics of try_to_unmap. The comment for try_to_=
unmap
might need to be updated.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_2C43F591-DD11-458B-B32F-348BCA6364E5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmCMhRoPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKbNIQAK7jN3eKvdKXfw2WNMIpiwAyUEnPFQlhAgYI
zUTWLMtS7pK0nJjrEEdnrSsG602yXoD6kjW840OZCWk0VRMnEpyFja26jH+fHkqr
dowkP/GrlQgLIq2OcfD2ruRycUJHIg3NcjM0Su554/VB4s5hbjhvsBRAe87pw6eb
eK2qIgtjMRxUiaYRE5/5HTkHKAOogZHICfx3LVVgEzrvNJPLp+A/uZPElRnLGmzc
NQa5/0THXtl6PGjyT/rUqS4R/WxPjV0yTfEC664dcaTJc0Sx+Y5iSJnhW7WxFTxe
PvwK0yvIem6W9saVBoib+WKTgyvZ0XwNy/77gsD0OsKANwcMoJd33Q1nZlb2XweX
tfiN2/gf2HCVIh9a3JOIlflaYPAIoYPYvudJDai3kmFjX0Bec0hKLs42yGlseims
01fr+g3M7cMTzJSxUyGpmi5UhbcwBP34c7MUfNmoTTwwJiHoBmwS5IpAe15//js0
48GclG3/GR93U7wWxjEsz8a40Cj5188v+r4tpiMlzvJ9+y3XdrJnCVdwzAxp+KeA
HVM/mxcIV45ka9eW7tgDlVvPizN+0GgNimPbn44ptxW43suQ4z/NjybZrUAScRV7
WRpsMDc4UR4u3gfS4fW0CyL3UfFmTIbpll7uds8vR+tw/JfaRQnjXXPMeINCuDj/
j9QByTQS
=731u
-----END PGP SIGNATURE-----

--=_MailMate_2C43F591-DD11-458B-B32F-348BCA6364E5_=--
