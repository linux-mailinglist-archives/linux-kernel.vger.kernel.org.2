Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0396348B84
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 09:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhCYI2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 04:28:03 -0400
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com ([40.107.237.63]:39136
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229788AbhCYI1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:27:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Durq3iq/RRV7rOS4Q01LXdrsnoWsH2E4toAKnhWQi+xQikjmpMQTzZ9kZumu4QcoI9shDkc6anTyuUzZba2XssIdxrmjHObWqsW5yuOkqYoSx0Yysdu1w+cfRaa4QLK0Y5yTvCtzxIXi0WMesvyGHK8GPP0SWxleHGNGgTsbARHovCXOcH67l+mzfMw9PBwq4xmzIwBBRgjEGDfBQzqJr5kJTYqfU/XMl6W5uZNR3OddR5fXj5CBlI9g9xc0CpE1Wp8vXPMnWyBQq+uZrvXvwK6tk1071Ae1s67rqH/SlQAf0WkCavs2u/vYGJl/WUiU+J4GZKTWo1QNLVdFXGXMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg3g7k5O8kKW3yVApdgohccey7Ue/UJDEPWNoaGtb2o=;
 b=GaSS9pBWSOvRvqokR0qqHa3L2dHwJnPuyelqaFV7vgo2R2hG00lRPs0yvFWfEdSJz8YQY7z/5Z2Iu57jjQQTCl7AvRmJUsfcVaYtCArvRIh9qMEGEMHZTU+joUJ7mGuf4KCoDV0UQufxrEgoX05sJpftRs7CRgR0wfwVDMez9vwsMciAa+uaYtOlKKWA9GgDUibWMHpMXAZMsPNSVggDUbIl5CSA2JPJVwuURODTd4SMY55cYlNH3pkkpHhWgG08sENtJiJ3fQ5acaXoHZthkxlv0HxoFPTtzhEhDP8kscHUzcosmLIHLxawWOXKCjPoGOfZ7s+aPbWr6iCx4qYJ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg3g7k5O8kKW3yVApdgohccey7Ue/UJDEPWNoaGtb2o=;
 b=fLhKunWtavMBlwXPANZiiQlCgTSGD54zGfSZXpEY6RqK7LkA4Tii/KLY5+9dm8cpWyDSr2a4jpM0enyZXU6RJK0Tr/oP1jk6tkqyzeK++CRopPeNxjGZnH93pTlF9sywr38uiCuQHMsBj7nh0cVzhSWX1/DqcCy/kN6ISaDYuuE=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Thu, 25 Mar
 2021 08:27:39 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 08:27:39 +0000
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <YFsM23t2niJwhpM/@phenom.ffwll.local>
 <20210324122430.GW2356281@nvidia.com>
 <e12e2c49-afaf-dbac-b18c-272c93c83e06@shipmail.org>
 <20210324124127.GY2356281@nvidia.com>
 <6c9acb90-8e91-d8af-7abd-e762d9a901aa@shipmail.org>
 <20210324134833.GE2356281@nvidia.com>
 <0b984f96-00fb-5410-bb16-02e12b2cc024@shipmail.org>
 <20210324163812.GJ2356281@nvidia.com>
 <08f19e80-d6cb-8858-0c5d-67d2e2723f72@amd.com>
 <730eb2ff-ba98-2393-6d42-61735e3c6b83@shipmail.org>
 <20210324231419.GR2356281@nvidia.com>
 <607ecbeb-e8a5-66e9-6fe2-9a8d22f12bc2@shipmail.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <fb74efd9-55be-9a8d-95b0-6103e263aab8@amd.com>
Date:   Thu, 25 Mar 2021 09:27:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <607ecbeb-e8a5-66e9-6fe2-9a8d22f12bc2@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:a792:596e:3412:8626]
X-ClientProxiedBy: AM0PR02CA0147.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::14) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:a792:596e:3412:8626] (2a02:908:1252:fb60:a792:596e:3412:8626) by AM0PR02CA0147.eurprd02.prod.outlook.com (2603:10a6:20b:28d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 08:27:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3566ec28-4740-492e-95db-08d8ef67d9ff
X-MS-TrafficTypeDiagnostic: MN2PR12MB4157:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4157AE2BA16579094ABBB21B83629@MN2PR12MB4157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXdp3kGXUgKrpGmV2TTwmTyLm4LURZup+CmdJWLhdKYCrwk8eQhqADA3+dKlUmDbSKJQDcKo92LOJ3i/pnSB4MyJv/qh0tcZx9+eL6/6KoQy/+8Hh0xgEhXZFmSPFvXP2CpYOZaYY/Rl8U7OpGoYw76FYmIEtxuQtrQKK7+tqIWzF/3wd6OBxGtglBv0pBIPz67j7CV+jvB6RtIIxNWONTayoTTKUekh+4K9vZRW079JHDZBGLS8UTfRwlP6fUJ0+t70pmRLtiX8v8D8EW8nm1vLaI1PuYKABDSMzqkbjztMmluVIlxa0vkXgeAlbM/cXKO52sBIaKV8Jag9Cbigs/TIYTaabGSVnUs1fuVMxTZS6zjGZzf9c6uWVQR/9AWlFVy/ZKbm5hIWaypmxBSysb5kAum1GhMITcHvX1T1q7nSyeOhfIlR5mC9Sxm4ehyEq0kp20/m9Mmt2po+upZaXoHEPyRitukuitTpoNxE7lvzJ5Wvbyw2KG5p9mUnpxY1fVIvD8mFVi+O8YjaHqHuDA4rjPggYZxL44B4CBc8XMZGUsRWh+sveeQi20SLPGBQqQz1pM/zvh3kMcZ7hMa+OfWfhsIfGB9lLrZh9ld3+PAclKbzwzrQSnJBPq4QhCW8LvNOi1Pus+o83A8YYM+CpaZY39sgC+N70PKpTk4e9zREqWXlUkwftj3VIgdhPCHCNSszbTWMANBwOa+KjxKuzkS6hJpSJ1czNwwkSq6yU9ZbG9xPBaPJAnLUj72/xcuXns2Mu6ASDEZGal0PmrrQGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(31696002)(53546011)(38100700001)(52116002)(6486002)(86362001)(316002)(66574015)(110136005)(36756003)(54906003)(8676002)(478600001)(83380400001)(31686004)(8936002)(2616005)(186003)(66476007)(6666004)(16526019)(66946007)(5660300002)(66556008)(2906002)(4326008)(21314003)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QmxaMWdnZkYrMzRicWcxY1doSzJ4djlJZ0lrVEliak0zZkhLVmozWnF4NjJj?=
 =?utf-8?B?MFdoMUxzS3pTUUpPdVNub2QyNFNkRmxoMnV0NWdvY1RqdVBKSjRlZnhZSHgw?=
 =?utf-8?B?aDRJRER4SmU2b0VZSTJnWmtWeG1WT28rRDJBdS9XNHIrdjdGRS9HSGdqM3NK?=
 =?utf-8?B?blhRclIxalBmeFhVcXUrUnRNYXU0T1cwMFVub0daWXl2V0RtQVpxOHU0OExK?=
 =?utf-8?B?emdrV3FGcGpEQm5NUkNTbGR4SHQzU3gzUVF0c0cyNndzc3hBMjlHYW9GbGRL?=
 =?utf-8?B?a0J1OUk5bjJPMWRBL2NxNllHbGY3ZjZseTZHRUd0eHpuckcxTXB2MTh4bEsy?=
 =?utf-8?B?WGlNb0JVRmgyblN0dWJuTzhvZDRLNHZMRlpPVEw2SVZvOHVjcXA4YVU2dDBl?=
 =?utf-8?B?VlBFNCs1eEN3YUpja3gzYlhsTE84Y1NENTk4NnNpTm9HK1dpa2VXSnBSdTNE?=
 =?utf-8?B?V01qUDV5eGp1RWVickRBNFJpVm9PbkRrR3RmRlRtcEU2K1BuaTk4ejJGdG1D?=
 =?utf-8?B?VkY3VmN0TTZ4dFFraGtkZ3ZHbGdkdnR2akx1NnhUMStxaTV6WFk1ZW9nYnM1?=
 =?utf-8?B?L3JtcjIzK3VOMDc4aThDMk9DSmoyQ3Awb2hvVXJlaWFBRTl6NXJOS3htYmF3?=
 =?utf-8?B?THhrRDVBWW1OVXR2LysxUEtRUTY5WHluSGZVcStiM3o1MWxCbDFzdDFzaFBu?=
 =?utf-8?B?blVsdFliZmt1bVJYT2dleHh1MGR1MjlqKzFod2tyVWtFUEtkNWw1a0FtTFNS?=
 =?utf-8?B?bml3Mm04Wmd4SFp0R0V4eVVabU9hM2pXNUhSQW5FZFZFM2F2b25jZWd1ZTVJ?=
 =?utf-8?B?cHNseXl0SXc2Z0wrWmQrUVJjN2pHMDFJZld4aXBKeHZWMFhWNXdudFBOOW5o?=
 =?utf-8?B?OEVHMlY4elR4NUNKOHROMThBVTA3YjFQWXJXUlRuSE1NWGxYS2E3cGo0c05H?=
 =?utf-8?B?c0lhWEZQUlErTkhhZzdySWhWbWVaWjVlOU5WeU1lUUNkbkFmUG90c2JjMUtR?=
 =?utf-8?B?eXlXcGZCT2g2TmRaZlJCbFlwQlZwc0JhVmhoRThGSTE1YlUwNW1XVDRmOHVF?=
 =?utf-8?B?RG81eXBKcWlEeFdFUndrTjlLMXZQNVM2Vm5zOGEyMktCVnpIdVI0d1VJRUsw?=
 =?utf-8?B?L3dNeEZpcWdrTVk4V0NiSDIvNXlSVW9neHBzK2NyKzFzNUdlMlhtWnVmRitI?=
 =?utf-8?B?VldNcWI1MjZRVTExeWVMQ3djeUkzc0R4SDNpQW5tRURXTlNmRTA1NVd2YTZR?=
 =?utf-8?B?cFJnNkpLaDcydUowMVo5NjZCNkVmOGNHTUpOTmtacWtHS3hLc1gxUXVZTkM0?=
 =?utf-8?B?b3JNeFM4QjkxZzZnNHM1RUxqU002UklmZHk1dFBibFkyTmR2ZjhmZUc2cExM?=
 =?utf-8?B?WnBJUXVpeXhiaE1VQWVETDUzZ3ZYVGhZTGVkVWJMVE9xMEJuTXRuRytUOHFj?=
 =?utf-8?B?RUJ0NXJRbmRsWDJKN3c0a1lyYnBsMU5tYWF1SmNWS3NDU24vTlRBT3V1QTJB?=
 =?utf-8?B?NzVYajJHbnRzUG1YSWJ4N24zMkJSMVpiRTFlcGVJY1FjVXgweDdmam44aVBC?=
 =?utf-8?B?Mzg1YTYyZTN5N0U2LzZtUUI2WEgvTXFmR1pPUXZzWDVUNlBsbE5XaWZ4Q1Vj?=
 =?utf-8?B?QUplV1RFYmtod3RPdUJQTUo5RVkzdXZlRFlFcXNwNVNsUjJyL3Qxd1pmWWw1?=
 =?utf-8?B?UkZNK1dUYldJbWRVTWcyY3Z6Q29aeUFVdGRqa2dUZUk3bkFocWJLcnFMQ2c3?=
 =?utf-8?B?R3RVT292YVQvVktaWVFjOVE2aFE5R1dJdStnZUp6cUh3RGora1RQMGM0RzFJ?=
 =?utf-8?B?TUxIM01YcDgySjlSOEppbEhvRXcvZFBTdzR2cXFjZVVEUzlxVThaQjBhbFJP?=
 =?utf-8?Q?CePBA4GYhINoM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3566ec28-4740-492e-95db-08d8ef67d9ff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 08:27:39.2999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apRbpqep3YrV7z7cBHh9VCS06bBYsEk2RxGWBTcRLcuG0KaN1tUkfi4qXAu1+SbD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.03.21 um 08:48 schrieb Thomas Hellström (Intel):
>
> On 3/25/21 12:14 AM, Jason Gunthorpe wrote:
>> On Wed, Mar 24, 2021 at 09:07:53PM +0100, Thomas Hellström (Intel) 
>> wrote:
>>> On 3/24/21 7:31 PM, Christian König wrote:
>>>>
>>>> Am 24.03.21 um 17:38 schrieb Jason Gunthorpe:
>>>>> On Wed, Mar 24, 2021 at 04:50:14PM +0100, Thomas Hellström (Intel)
>>>>> wrote:
>>>>>> On 3/24/21 2:48 PM, Jason Gunthorpe wrote:
>>>>>>> On Wed, Mar 24, 2021 at 02:35:38PM +0100, Thomas Hellström
>>>>>>> (Intel) wrote:
>>>>>>>
>>>>>>>>> In an ideal world the creation/destruction of page
>>>>>>>>> table levels would
>>>>>>>>> by dynamic at this point, like THP.
>>>>>>>> Hmm, but I'm not sure what problem we're trying to solve
>>>>>>>> by changing the
>>>>>>>> interface in this way?
>>>>>>> We are trying to make a sensible driver API to deal with huge 
>>>>>>> pages.
>>>>>>>> Currently if the core vm requests a huge pud, we give it
>>>>>>>> one, and if we
>>>>>>>> can't or don't want to (because of dirty-tracking, for
>>>>>>>> example, which is
>>>>>>>> always done on 4K page-level) we just return
>>>>>>>> VM_FAULT_FALLBACK, and the
>>>>>>>> fault is retried at a lower level.
>>>>>>> Well, my thought would be to move the pte related stuff into
>>>>>>> vmf_insert_range instead of recursing back via VM_FAULT_FALLBACK.
>>>>>>>
>>>>>>> I don't know if the locking works out, but it feels cleaner that 
>>>>>>> the
>>>>>>> driver tells the vmf how big a page it can stuff in, not the vm
>>>>>>> telling the driver to stuff in a certain size page which it 
>>>>>>> might not
>>>>>>> want to do.
>>>>>>>
>>>>>>> Some devices want to work on a in-between page size like 64k so 
>>>>>>> they
>>>>>>> can't form 2M pages but they can stuff 64k of 4K pages in a 
>>>>>>> batch on
>>>>>>> every fault.
>>>>>> Hmm, yes, but we would in that case be limited anyway to insert 
>>>>>> ranges
>>>>>> smaller than and equal to the fault size to avoid extensive and
>>>>>> possibly
>>>>>> unnecessary checks for contigous memory.
>>>>> Why? The insert function is walking the page tables, it just updates
>>>>> things as they are. It learns the arragement for free while doing the
>>>>> walk.
>>>>>
>>>>> The device has to always provide consistent data, if it overlaps into
>>>>> pages that are already populated that is fine so long as it isn't
>>>>> changing their addresses.
>>>>>
>>>>>> And then if we can't support the full fault size, we'd need to
>>>>>> either presume a size and alignment of the next level or search for
>>>>>> contigous memory in both directions around the fault address,
>>>>>> perhaps unnecessarily as well.
>>>>> You don't really need to care about levels, the device should be
>>>>> faulting in the largest memory regions it can within its efficiency.
>>>>>
>>>>> If it works on 4M pages then it should be faulting 4M pages. The page
>>>>> size of the underlying CPU doesn't really matter much other than some
>>>>> tuning to impact how the device's allocator works.
>>> Yes, but then we'd be adding a lot of complexity into this function 
>>> that is
>>> already provided by the current interface for DAX, for little or no 
>>> gain, at
>>> least in the drm/ttm setting. Please think of the following 
>>> situation: You
>>> get a fault, you do an extensive time-consuming scan of your VRAM 
>>> buffer
>>> object into which the fault goes and determine you can fault 1GB. 
>>> Now you
>>> hand it to vmf_insert_range() and because the user-space address is
>>> misaligned, or already partly populated because of a previous 
>>> eviction, you
>>> can only fault single pages, and you end up faulting a full GB of 
>>> single
>>> pages perhaps for a one-time small update.
>> Why would "you can only fault single pages" ever be true? If you have
>> 1GB of pages then the vmf_insert_range should allocate enough page
>> table entries to consume it, regardless of alignment.
>
> Ah yes, What I meant was you can only insert PTE size entries, either 
> because of misalignment or because the page-table is alredy 
> pre-populated with pmd size page directories, which you can't remove 
> with only the read side of the mmap lock held.

Please explain that further. Why do we need the mmap lock to insert PMDs 
but not when insert PTEs?

>> And why shouldn't DAX switch to this kind of interface anyhow? It is
>> basically exactly the same problem. The underlying filesystem block
>> size is *not* necessarily aligned to the CPU page table sizes and DAX
>> would benefit from better handling of this mismatch.
>
> First, I think we must sort out what "better handling" means. This is 
> my takeout of the discussion so far:
>
> Claimed Pros: of vmf_insert_range()
> * We get an interface that doesn't require knowledge of CPU page table 
> entry level sizes.
> * We get the best efficiency when we look at what the GPU driver 
> provides. (I disagree on this one).
>
> Claimed Cons:
> * A new implementation that may get complicated particularly if it 
> involves modifying all of the DAX code
> * The driver would have to know about those sizes anyway to get 
> alignment right (Applies to DRM, because we mmap buffer objects, not 
> physical address ranges. But not to DAX AFAICT),

I don't think so. We could just align all buffers to their next power of 
two in size. Since we have plenty of offset space that shouldn't matter 
much.

Apart from that I still don't fully get why we need this in the first place.

> * We loose efficiency, because we are prepared to spend an extra 
> effort for alignment- and continuity checks when we know we can insert 
> a huge page table entry, but not if we know we can't

I don't think so either. See with don't need any extra effort for the 
alignment nor the handling, it actually becomes much cheaper as far as I 
can see.

In other words when you have a fault you don't care about the faulting 
address that much, you only use it to determine the memory segment to map.

Then this whole memory segment is mapped into the address space of the 
user application.

If can of course happen that we need to fiddle with addresses and sizes 
because userspace only mmap a fraction of the underlying buffer, but in 
reality we never do this.

> * We loose efficiency because we might unnecessarily prefault a number 
> of PTE size page-table entries (really a special case of the above one).

I really don't see that either. When a buffer is accessed by the CPU it 
is in > 90% of all cases completely accessed. Not faulting in full 
ranges is just optimizing for a really unlikely case here.

>
> Now in the context of quickly fixing a critical bug, the choice IMHO 
> becomes easy.

Well for quick fixing this I would rather disable huge pages for now.

Regards,
Christian.

>
>>
>>> On top of this, unless we want to do the walk trying increasingly 
>>> smaller
>>> sizes of vmf_insert_xxx(), we'd have to use apply_to_page_range() 
>>> and teach
>>> it about transhuge page table entries, because pagewalk.c can't be 
>>> used (It
>>> can't populate page tables). That also means apply_to_page_range() 
>>> needs to
>>> be complicated with page table locks since transhuge pages aren't 
>>> stable and
>>> can be zapped and refaulted under us while we do the walk.
>> I didn't say it would be simple :) But we also need to stop hacking
>> around the sides of all this huge page stuff and come up with sensible
>> APIs that drivers can actually implement correctly. Exposing drivers
>> to specific kinds of page levels really feels like the wrong level of
>> abstraction.
>
> I generally agree. But for the last sentence I think the potential 
> gain must be carefully weighed against the efficiency arguments.
>
>>
>> Once we start doing this we should do it everywhere, the io_remap_pfn
>> stuff should be able to create huge special IO pages as well, for
>> instance.
>
> I agree here as well. Here we can be more agressive as the contigous 
> range is already known and we IIRC hold the mmap lock in write mode.
>
>>> On top of this, the user-space address allocator needs to know how 
>>> large gpu
>>> pages are aligned in buffer objects to have a reasonable chance of 
>>> aligning
>>> with CPU huge page boundaries which is a requirement to be able to 
>>> insert a
>>> huge CPU page table entry, so the driver would basically need the 
>>> drm helper
>>> that can do this alignment anyway.
>> Don't you have this problem anyhow?
>
> Yes, but it sort of defeats the simplicity argument of the proposed 
> interface change.
>
> /Thomas
>
>

