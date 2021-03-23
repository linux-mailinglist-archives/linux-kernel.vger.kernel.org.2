Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2BC345D82
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhCWL6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:58:17 -0400
Received: from mail-co1nam11on2060.outbound.protection.outlook.com ([40.107.220.60]:41185
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230096AbhCWL5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:57:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcLyL/kNtbZiD+Vxtk1zjfpLgIKKFTwvJtYtNivunLDB19RN9Se698Hm5nxFbkkn014kX3YNwz47wot2PQCcNqCTCYSTa8a6nu4dxPJxdt5S0P42J2NNvd5/C/Qwe1ztQxaUukxrBiiscCGy5E8y6N5t2/axg0uxFnrJ2nw3uRYYOxeRFBHmPFADeYlOesdQurElR1t997j7g7zwVt9UWFGh8NbL0pKJU3AKB2o8xfR3KnlZFcUBrv+flXkYnk+ad02L9koMpV41i0eboEcS9rHpckVccnL8hpclc8HIC8or5/OwY+WTTfJL92+9E7Pn1tFZkGYkj4Cg+lJUt9P/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CA2DEnaPJmbB1TnMSD9kDwnsj2GwfhMVZ97DjK0zetY=;
 b=UwZ8bshzAkn9RqmByH0JRBjpa4Ge0h4wTbQ2ayrb2t9MiuUSLtrdRVqZpxL09RUu5rouD5H+FQJSXIdBgpBXAQoqgDEOOAl952C5Th0oazdbcbtNj6Fd29SPKy5LD/Hpl9TPW1j6Z6+dm7Tg1t6aJ5c8eB5MRJ+4jN0dqylAEUzS2qQZcrtFNRrVhIQ7lkbx7qy16JHirMzkwtHMsQwa7xZg6n9L5N/w79OJbnL3fAIfUjTvX6Ix9sGv3Gy5JEOqI81LWgDrx1NjAPg1RJlpb+eVSJPXEjIUM4emaABrTtWtH4Hns2qNtEufTFgnejMxGdDxg8l3lXPFlwe6YOAt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CA2DEnaPJmbB1TnMSD9kDwnsj2GwfhMVZ97DjK0zetY=;
 b=ikqyfrIvxud5/xXPH5H61ZOtv5pT+xejQAB4VJzxUiZ2Hjxk2KH2JZE4uC2F5zIMVClOnPI3dW+4RvUD8RgKL8jdSwxby+evgFioEkJo7e2AAA6JgLPW57rc/o2equw+Pk+s/TCPDEBlpAS8Rf2uSJQiEF8Jm7QZjdPQNL7d/b8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4784.namprd12.prod.outlook.com (2603:10b6:208:39::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 11:57:48 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 11:57:48 +0000
Subject: Re: [RFC PATCH 2/2] mm,drm/ttm: Use VM_PFNMAP for TTM vmas
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-3-thomas_os@shipmail.org>
 <d49fad17-f515-d4f2-cef2-4108c8375747@amd.com>
 <5578ccaa-9751-3a01-1846-330c09bf9ce7@shipmail.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <34263084-8fb8-7eb1-4ab8-a4c7695c2bf8@amd.com>
Date:   Tue, 23 Mar 2021 12:57:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <5578ccaa-9751-3a01-1846-330c09bf9ce7@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:fdcd:4dd1:a1af:a7ec]
X-ClientProxiedBy: AM8P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::28) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:fdcd:4dd1:a1af:a7ec] (2a02:908:1252:fb60:fdcd:4dd1:a1af:a7ec) by AM8P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 11:57:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38e71a4e-d323-44e0-e986-08d8edf2e07d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4784:
X-Microsoft-Antispam-PRVS: <MN2PR12MB478457921A0D08E8C31199C383649@MN2PR12MB4784.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tjHBvQOB8Eo4QC1MOWTf+WCFgfC3oOiyKFqlidzj+unyEF7NXAK9KVCvpP1BUM0CJT4ZrlMkYKvVylC9dx25HHGkh16X9hRwlNj6xXc305/8LfSXMqV2725uhIIrqd3Q8fs9cezWdIIBXWQIterhobjcxv1DjKqTCZCXrAWE6k4D4aDIvsX7o3pxktB12gSGHktTRIUE65gWrh5j+Cv/qFZQPpQv2b/1TNuS2sKCw8/eP/aMnNX43dd01vs3B5uXU3OccHdQraRnWTvfd6T7fueLv4JbbLaVlRPzxzwczcGMxyGTw1lg1tKiSiDasr/SLqredet+A77uZDCIVIxZp6wXq9bVDsoHXI8aD+M1rLBHUAvDOr7SutyNfJqC3WJbHocJz5PazhCZFkJ1A10RobLBPvfYyW5WQ9IvuNmqtZhBYA8HvSAmyJQgp3fg9cCHbdyyzRtTAUbUfk8ehs8FkNjmcoWxiZipalGFVoMibKvW5f5EHSDdJWGUlZ+/ToMO4+Qtg1Ed0MXu1j3KOqBurmeT+dIHmSwmC3BBfAUrQbwaGN5Uy/KNIVs/dnLOEBWqMeZJiTpZi8+CLGgJqVCaZxHheXmjFHE5mdwfEDsisHT6oaWag6xXexcJUjvmr7HCJThKLTN5R2a//Pp+hRQVPouWUEeSn0cQkLlym1iyzgsoqboumO2tV/7sTyV+HRWma39JsG+MKOhbgKDtizF0nGktv4aM48RNqOYAOZVNLcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(8936002)(2616005)(5660300002)(4326008)(83380400001)(478600001)(6486002)(66574015)(31686004)(86362001)(54906003)(16526019)(31696002)(36756003)(2906002)(8676002)(52116002)(53546011)(66556008)(6666004)(316002)(66946007)(38100700001)(66476007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NC9Xc1RMTXg5TVFJMWdjM2NOM0N6MWg4N3MyUzFuSmpIVEp4TGw0UWl1SFRQ?=
 =?utf-8?B?cnRyM0FMOTJ5cGRJcEdsZlRvSkZWRmVzQmlNa29ydGI2Snp0cUpweDVoRE1L?=
 =?utf-8?B?bXBZNDhSdEV3K3ZqdjR5KzFsMGZOWHlDKzFFRFRJZ2R4OTVQcUZBTzVBd3Ro?=
 =?utf-8?B?Z2Y3dnB4cnJKUzJwV2ZiK0NBeUR1WFVwM3FxS3Q3V043djdGR1FvUk5jQnVw?=
 =?utf-8?B?U3M3TzhLa1Q4bWhFaUQzRDI2ZWZyWGNoV3Q0QjV4RDRIU25qNFpSazhJb2tr?=
 =?utf-8?B?NnBSM0FIZ1lwalpsOGNTZlFtTzVJNnZtLzduVDZ3dXVpY3l0OXpOaFJhVEEv?=
 =?utf-8?B?SHR5dW92cGxuSHRrQ3ZpOFgvRitleWVGSmVodmhUYXIyT0JGcWRFQ1ZORUl6?=
 =?utf-8?B?UndyUmczK1hSZ2R5c0ovZjZ0cTZad25YaDNtNnpuN1pKdFpXN3dlZ0xQZUxz?=
 =?utf-8?B?TGlmT3F6THB1ZVRDMThFV2l6MlZvbjFBME03RnhXa3kzcHYzT0JnTFdEbENn?=
 =?utf-8?B?cUgvYzNoRThDMjJOWGVqMzN6czhqS2ljakFqTGxDRFhQM05hTDJWZHpZa3Zq?=
 =?utf-8?B?RWZScUZRbDZnUnBVbjliZnZyN2QySjNXVVVqSnpKaHRQanBwYmcvVE9VOGY2?=
 =?utf-8?B?NDd2VEhPK2pkR2k3VmdRUkFYN2dDV2w5bTlYb0F5MEZsUEtOZEpJaEdUM2pl?=
 =?utf-8?B?SEVuNzBaNDQzaElleVdHTnNzWVZqTjlCdktoNURBM2kyOURGRkRJSHdLS3E1?=
 =?utf-8?B?ci9nSDhWNllkMmJLUkYvSVVsbDVrY2U2dEJ6YnhqM1Y5cm1lZnVrVFdDWFRJ?=
 =?utf-8?B?ZWNOYkZyN1F5TlA5NlRpNmFRaWlOSUpjRkhoQU5BM2UrVXdIb1prYXE0S3RR?=
 =?utf-8?B?NDlFaDdjK2JrbENLN0N0bXE3ZlJzVkFCTTFMWFBTVzNSL1dBTFZLV0wzdnlD?=
 =?utf-8?B?b1JJcnlBU1RPQ2g3MlBxcGdPNmJBWlFsOXNZZmMycldIeXNQQ2x0YUMrRjdQ?=
 =?utf-8?B?ZkFiTUZCNkpjeWZROEh5NEZ3TUNsaVhKcXZUV1NtdEJ3R1N0SGhFUGo0SEhR?=
 =?utf-8?B?QStucjlINU52ZjVHSWQxNG5WY2l2VjJYdjdMRkwveDIxcmFaNHgyZ0lRcmlW?=
 =?utf-8?B?dnFkMkJZY0lpMWw1akRwa0FQa3ZSWCt2Q3ZNN05lRHF2UGl0NDRNVDd1Tysz?=
 =?utf-8?B?YVJXTjN1TWtmbHl3NENvVmRkbi9FaHlrWDJZbkVCNEdvV29WSEVpRnRPb1dJ?=
 =?utf-8?B?YnlsQ2ZXcVU5ZG00b3RydHhSUUtpTk9aRGxKb2NLNHU2bUdmYTljSFFsc3Fy?=
 =?utf-8?B?MVZ5NXdwQmZtVFdPeGhMNlBtNTFQWG5hTFV0OXVzNVE0c1VzcEZORjJTRmJ3?=
 =?utf-8?B?RHMvNHFzYnYyQkpPbmFvOHhNb0dqd3ZqL2FPc1ozSDhoRjFWWW04UE9QeUQ4?=
 =?utf-8?B?UmZJbUdWS2RqYk9LOGtxT2pXcTVibmRQK1d2NVRiL3BLQ1A5WC9LdGFReXRP?=
 =?utf-8?B?V0VYRk5hUlNaY0NWQU45MHhCaVlnWThJR0tDT0VadTVCR2xiTVZBeUY1NlNJ?=
 =?utf-8?B?V2ljYndxWGdmeUFld1p0WkRGcnVBU2Y3VFBYMU04Q1p5Zno0QzhNUm0vR3Vy?=
 =?utf-8?B?K28zc3krMWFkQndtYjRLUlZrc0dOQnkxSk8rb0pUcitjYXZhMGVqNngyZmRF?=
 =?utf-8?B?UEUvaDJMYjZNaitkSzZ4UnpnS2hOc2Q4WFJESDN3Z2FpNzN6bERKYUpCRzFU?=
 =?utf-8?B?dVJZK3lqU0RKSjY2Z1ZGK041RVVKakdtQThTcGdSNTFjb0sxRnRmWGRXd2g1?=
 =?utf-8?B?NXpXRlEzajM3N1ArSFgyOVVGY0UraXJyNk5KdFdZZ2pKTEFhU2NHbFN1Q0E3?=
 =?utf-8?Q?yy/BqBKwFBZQ6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e71a4e-d323-44e0-e986-08d8edf2e07d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 11:57:48.0529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEn2hqz4dLmTM/GRnzJvRZyh01f/kxVRwyMxGGNANaGYPfR+Bkukd1Yc5YMTit08
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4784
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 22.03.21 um 09:13 schrieb Thomas Hellström (Intel):
> Hi!
>
> On 3/22/21 8:47 AM, Christian König wrote:
>> Am 21.03.21 um 19:45 schrieb Thomas Hellström (Intel):
>>> To block fast gup we need to make sure TTM ptes are always special.
>>> With MIXEDMAP we, on architectures that don't support pte_special,
>>> insert normal ptes, but OTOH on those architectures, fast is not
>>> supported.
>>> At the same time, the function documentation to vm_normal_page() 
>>> suggests
>>> that ptes pointing to system memory pages of MIXEDMAP vmas are always
>>> normal, but that doesn't seem consistent with what's implemented in
>>> vmf_insert_mixed(). I'm thus not entirely sure this patch is actually
>>> needed.
>>>
>>> But to make sure and to avoid also normal (non-fast) gup, make all
>>> TTM vmas PFNMAP. With PFNMAP we can't allow COW mappings
>>> anymore so make is_cow_mapping() available and use it to reject
>>> COW mappigs at mmap time.
>>
>> I would separate the disallowing of COW mapping from the PFN change. 
>> I'm pretty sure that COW mappings never worked on TTM BOs in the 
>> first place.
>
> COW doesn't work with PFNMAP together with non-linear maps, so as a 
> consequence from moving from MIXEDMAP to PFNMAP we must disallow COW, 
> so it seems logical to me to do it in one patch.
>
> And working COW was one of the tests I used for huge PMDs/PUDs, so it 
> has indeed been working, but I can't think of any relevant use-cases.

Ok, going to keep that in mind. I was assuming COW didn't worked before 
on TTM pages.

> Did you, BTW, have a chance to test this with WC mappings?

I'm going to give this a full piglit round, but currently I'm busy with 
internal testing.

Thanks,
Christian.

>
> Thanks,
> /Thomas
>
>
>
>>
>> But either way this patch is Reviewed-by: Christian König 
>> <christian.koenig@amd.com>.
>>
>> Thanks,
>> Christian.
>>
>>>
>>> There was previously a comment in the code that WC mappings together
>>> with x86 PAT + PFNMAP was bad for performance. However from looking at
>>> vmf_insert_mixed() it looks like in the current code PFNMAP and 
>>> MIXEDMAP
>>> are handled the same for architectures that support pte_special. This
>>> means there should not be a performance difference anymore, but this
>>> needs to be verified.
>>>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Cc: David Airlie <airlied@linux.ie>
>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>>> Cc: linux-mm@kvack.org
>>> Cc: dri-devel@lists.freedesktop.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Thomas Hellström (Intel) <thomas_os@shipmail.org>
>>> ---
>>>   drivers/gpu/drm/ttm/ttm_bo_vm.c | 22 ++++++++--------------
>>>   include/linux/mm.h              |  5 +++++
>>>   mm/internal.h                   |  5 -----
>>>   3 files changed, 13 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c 
>>> b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>> index 1c34983480e5..708c6fb9be81 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>> @@ -372,12 +372,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct 
>>> vm_fault *vmf,
>>>            * at arbitrary times while the data is mmap'ed.
>>>            * See vmf_insert_mixed_prot() for a discussion.
>>>            */
>>> -        if (vma->vm_flags & VM_MIXEDMAP)
>>> -            ret = vmf_insert_mixed_prot(vma, address,
>>> -                            __pfn_to_pfn_t(pfn, PFN_DEV),
>>> -                            prot);
>>> -        else
>>> -            ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
>>> +        ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
>>>             /* Never error on prefaulted PTEs */
>>>           if (unlikely((ret & VM_FAULT_ERROR))) {
>>> @@ -555,18 +550,14 @@ static void ttm_bo_mmap_vma_setup(struct 
>>> ttm_buffer_object *bo, struct vm_area_s
>>>        * Note: We're transferring the bo reference to
>>>        * vma->vm_private_data here.
>>>        */
>>> -
>>>       vma->vm_private_data = bo;
>>>         /*
>>> -     * We'd like to use VM_PFNMAP on shared mappings, where
>>> -     * (vma->vm_flags & VM_SHARED) != 0, for performance reasons,
>>> -     * but for some reason VM_PFNMAP + x86 PAT + write-combine is very
>>> -     * bad for performance. Until that has been sorted out, use
>>> -     * VM_MIXEDMAP on all mappings. See freedesktop.org bug #75719
>>> +     * PFNMAP forces us to block COW mappings in mmap(),
>>> +     * and with MIXEDMAP we would incorrectly allow fast gup
>>> +     * on TTM memory on architectures that don't have pte_special.
>>>        */
>>> -    vma->vm_flags |= VM_MIXEDMAP;
>>> -    vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
>>> +    vma->vm_flags |= VM_PFNMAP | VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
>>>   }
>>>     int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
>>> @@ -579,6 +570,9 @@ int ttm_bo_mmap(struct file *filp, struct 
>>> vm_area_struct *vma,
>>>       if (unlikely(vma->vm_pgoff < DRM_FILE_PAGE_OFFSET_START))
>>>           return -EINVAL;
>>>   +    if (unlikely(is_cow_mapping(vma->vm_flags)))
>>> +        return -EINVAL;
>>> +
>>>       bo = ttm_bo_vm_lookup(bdev, vma->vm_pgoff, vma_pages(vma));
>>>       if (unlikely(!bo))
>>>           return -EINVAL;
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 77e64e3eac80..c6ebf7f9ddbb 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -686,6 +686,11 @@ static inline bool vma_is_accessible(struct 
>>> vm_area_struct *vma)
>>>       return vma->vm_flags & VM_ACCESS_FLAGS;
>>>   }
>>>   +static inline bool is_cow_mapping(vm_flags_t flags)
>>> +{
>>> +    return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
>>> +}
>>> +
>>>   #ifdef CONFIG_SHMEM
>>>   /*
>>>    * The vma_is_shmem is not inline because it is used only by slow
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index 9902648f2206..1432feec62df 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -296,11 +296,6 @@ static inline unsigned int buddy_order(struct 
>>> page *page)
>>>    */
>>>   #define buddy_order_unsafe(page) READ_ONCE(page_private(page))
>>>   -static inline bool is_cow_mapping(vm_flags_t flags)
>>> -{
>>> -    return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
>>> -}
>>> -
>>>   /*
>>>    * These three helpers classifies VMAs for virtual memory accounting.
>>>    */

