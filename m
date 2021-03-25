Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA313348A75
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhCYHu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:50:28 -0400
Received: from mail-mw2nam12on2047.outbound.protection.outlook.com ([40.107.244.47]:39840
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229873AbhCYHuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:50:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nagzsmoe2C6klV55CGPKNwV6fTFT3SqcGzZS4Ke7Ue2RuE985E+KQp9Y/1biHIANVdHdA0koT/q6LykJxULGRw3TzA4DqTlNJ/WrLCalrZwyi4UwiASNr3YLKNor5wunxDGWG/YjGxSpUzoNj47tjncYtyeu/veV/kltc91+g2IvVSWHklUUreGRQexiiexYNcor78SyJ7o0GJC2PrImToVtdYi2oCDH77GuWoXs9gSISLD3gs9EEVDUhPIEZG6Iryzp1QLFo00RsETohFwJNsfnDc65vb4L7xss2hJeLx8c4ahkKBHtTHX8njNvSs5Vt2mENM0xXJNl4nkAwZjG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9r9bKOhYFHV99IZFfP6g+saOadHEJB6bOK1K1YNqzg=;
 b=jpuW+E1VINhD2jZDocVUFHA3f6MqLeq+EFtSxzazMr9Jx9wSmXAmyEVVUAFbsF2b6UF2fFY8pv2mkn81WATtvx6zdOPLYCHHpoPU0XPBRbMHZ8vKmihRNn/H/0O/9r2XbqIhwdXSpyXG+vaqYMPSdRVi0JuaPRGLbpW2iVEY95oIGCQCLqZqSVeyBVFzh9T7Nei1By5REravhBbFXo0gvmY36siTr/8+Dm+4q7Q4AfmE1PvxwxFYwCf07SR9PUaifI5eS9OpwbQi+9LGCpiJsmPpfJ7uHVXWdefsH8p8UygSr8Hz2hrbM2Oi2rA/LSGuTExCJZroBiYs5wphsrhZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9r9bKOhYFHV99IZFfP6g+saOadHEJB6bOK1K1YNqzg=;
 b=KuPxE881spDoX9lr266hQrtyEMpa7arM3tAMOjj9VANwcWWYYDNjmntJgG9rnAn7VO+P92oZCUxwaORtZZumIZ7Qc21vTmv0up45OFWDj9D2PdpTTMK/LwmMxygFKB6bFGeiVRYjtq++bsRNwoeqrsJUU4hRVn9aKKdmqFt4Pn4=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 07:50:05 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 07:50:05 +0000
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     Jason Gunthorpe <jgg@nvidia.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
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
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d7aaf556-2f0c-f5b5-659f-f99496cede1e@amd.com>
Date:   Thu, 25 Mar 2021 08:49:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210324231419.GR2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:a792:596e:3412:8626]
X-ClientProxiedBy: AM8P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::10) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:a792:596e:3412:8626] (2a02:908:1252:fb60:a792:596e:3412:8626) by AM8P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.28 via Frontend Transport; Thu, 25 Mar 2021 07:50:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 312753a1-717a-43b2-2ef8-08d8ef629a88
X-MS-TrafficTypeDiagnostic: MN2PR12MB4333:
X-Microsoft-Antispam-PRVS: <MN2PR12MB433360DFF43093E16589AE3A83629@MN2PR12MB4333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBu9a8UYCmGNP6F++xWDrHM0umHuJWSFldiUcCDHWRQ9ZdSvBwawAcAGHjbOYZxshckwLUr1R9z6ESJ1NPz+hMNZLZuNQNzpxeMytKVpalHAU4Fc7hQ2SsSe/gIYB7vnLNlTcRoTaFO3XwOLxOqStkVqerTTYkcF5XmYx8vF7dtsj7HUEg7juywZIo0lqIsO0DUA/pWSQYJ6DCy/1MFfDO1kIuiaXcIDwN7BJF0NN2Q9Ec9bfzuWZpxDhnwkdAQ8VzrGroEkxKt2VhxorshN8a/+8FyiU6HR+kyAO9MVBbbb15jYZXIxAQoPR0rwGRk8gyhWgihafH+JMfMo2Vp++dagNVjSFj6jJ1A7cr+z1e15UuqQaVvJLb15ZWAZ4UQ/BVZzMach9csWU8JXlmb1skLhdq0HwANsIGk1XusaerxXIMj0crKPs2neR1DDcN2kbDlKPC8dpJd/Kj8mifefbRmRRKo2m/1fe/dXAspxpD+RA++8rADvWghDrvBRPSiNiHtVhA3LUqVSZMbr/Kb60DEUEqyw3p/6oJ0oD4N9epYI4fqm/17oVzJsxwXxHS+LMHV4yw+VdQ70LXz8TrIDb8bQgUdNvIYsKXe5nJExXdgWyUX/grkEnAuIuwCYkRpnCnXTKqqqMg5he7d4HhQufnSXZKYfY9UdZG/auwAwxqZvz/bg9tBzGkhkam7Wk5TT7Ta1/pZnbcAs6s7eTX71kgb9QDf29x2Goz1oRxUyLlo+LqbdKWUxmw5sOwL0cnJyT0PScU9OwMZCjdT5lVlqWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(53546011)(5660300002)(8936002)(52116002)(6666004)(6486002)(38100700001)(66476007)(36756003)(2906002)(66556008)(8676002)(66946007)(2616005)(66574015)(83380400001)(186003)(54906003)(478600001)(16526019)(31696002)(4326008)(31686004)(316002)(110136005)(86362001)(14583001)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aS9XR1dNNkJvNXhoYm5OdFJTMDVMM2dEcEVDTmZWMWZnNmtTLzMzSkU4TERS?=
 =?utf-8?B?UE9GNEV1NEh3QWFFRnN1Ujlvbm90VGdqOFRwUzE4MXBpUzlOdzFNUnUxQ3h5?=
 =?utf-8?B?bVZzQUJQbXlYSGR2cVFhZVJZMmNYaU5WejVlTWxqUGwxd1ppVDFraGdsc20w?=
 =?utf-8?B?NjFFRTNjU1hoM2lOWjVqeFdBU2lMNjQ1MnhoQjZDb1M0OFlBVSszMGQ4VEJO?=
 =?utf-8?B?cTVkeXZaWkZkT3FnL2tqZStXdm9EdVd6WW8rbmJJcnlndkVuWHZJSWZWeDNJ?=
 =?utf-8?B?cEpFOWNtb2tyL3N2Nm43ZW55WUpwS2lwN2JmbUd0dVorSHNScXp2UmJac25Y?=
 =?utf-8?B?MVVkM3B1RUxyYUF4MS9IUThBNnZ2KzdiWTVYK1hlUmRYeUJIVDFyaGNETERR?=
 =?utf-8?B?OWprSDVGbnNJbTVVRlVlUXlGSHVFdE9qTEhmVnFXQ3Z0Y3hoK0I2Rm9qU0dJ?=
 =?utf-8?B?ZlRyd0ZDcjlucDR1TFpzZmpLVjJRRmZSVGFZL2k5bnlNRWdZZXRFUHBsTnFv?=
 =?utf-8?B?TlFpOWErLytiK3UrVHUwdHZiT1FrbStxOVRHQUxjKytjdzFVa2Jwd085TGc4?=
 =?utf-8?B?dVNRMDNqeG1ja2FqcWFBK3ZUSW8xZTJkdXBCV1hvZ3hRNFZyWkM2d0w1TG5i?=
 =?utf-8?B?YlU2VEw1N2ZnQU5rTTk4bHN5TzhReTkxVFgrZW1yK1NBODB4dllXcUw0Unk1?=
 =?utf-8?B?VHRaUXordUxVRnVrWlZxVzE4ZGJmR3k2Sm80UEkzOE5HNCtpUGR3RThEaWk5?=
 =?utf-8?B?dlVyUVd0UHFmOGQzQjFJUitCUDZsM0p6NGlQYWVqMENuNkJHbys4NG84RE02?=
 =?utf-8?B?dXE4MEIzU1JxK29SVEFicytrcUFZK29scmN1U2lQdkY5YzBCQ3pxRkIrQThu?=
 =?utf-8?B?OUVBS0h5S2dFd1o5SFFLMy9sdGtCdVcrOHdobEcyZjRuVzRMNnpiaWRQZjhy?=
 =?utf-8?B?R3FGeEw4U0k5UHlzM1NGdHlRT0xocEdhamE3T0lLdjIzdE01VkxqT2ZzMXVK?=
 =?utf-8?B?dnVmNmROSDRiTGM1MG1UdzlJdXRoZjlrSzZ4Q3pneWxFWTR3RTU3YWxVb3Rs?=
 =?utf-8?B?UnU4NnB5T2U1WkJWZ2x2MnZkL0owQmlodFlFYmUvc3dLdTluYitSSHJyNGVL?=
 =?utf-8?B?Z0NaQjNSazJ5alNZL3VKeGhtaDNTd1JaWVkvYlM2WkpUYzRIaGFSZFFYVEdD?=
 =?utf-8?B?Nk9QaG1GOGRzZE5wWUZ3eXZWVXZTL2xoY24vUWZxVkprZ3RCV3k5bDg1OWw5?=
 =?utf-8?B?MkdGL2ZqbjB6K1cvYlJzS1diWFRCbzVUdmpkS2lQUXB0MkpRN1k0azBqWUI1?=
 =?utf-8?B?dDFETTJtZExkaVZCQkpUTU5JLzBrTVFBQlJuVnl2cXR2dVcxc2hjOGMxQUw0?=
 =?utf-8?B?a1l3NmZTOGlmZ3h4RWl6a1lCZGQvTzBJc2x0WEtzZlhpMjUrbHlQNGRRMzZx?=
 =?utf-8?B?ejlrdDJJMDM5bSt0NC9WSXc1Y1ZvVGh1MlM1ZEVyWGlUQUkrbllLdTNKUWRI?=
 =?utf-8?B?djAxc2oyYnhqRldkUm0yMDE4RlVGbVluaVJQVEpnRFU3dW9DdHBrSzh6SE5J?=
 =?utf-8?B?NEJwL1d4THU2OE1VNC9aa1lvTlBtQ25vVjhwTHhCZk10NDgxSmkvNW1sMVdQ?=
 =?utf-8?B?aStoSlNsKzBkeXBPNnlmQlBhVDlOQ0xHMmt2Sndjb0FtalZudjNnalVCUVlG?=
 =?utf-8?B?ckFvMUYvanFXQlVQZjRVajNsY0hPM1RKVTBJd1FOOHJrcXdqTkJUNERGb2RO?=
 =?utf-8?B?ZkpkYjZrV1JLV0xHZFpDTEdsRVVCVGk3MjdoN1MvQmVaY0VVOHhlVnZBWnoy?=
 =?utf-8?B?ZVZJamJsTS83MXhBQkRBcHpUaTNTbjlvNnBTUlc1ekVPMUIyMGg5bFdXbENw?=
 =?utf-8?Q?o1qtYahb4HT+N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312753a1-717a-43b2-2ef8-08d8ef629a88
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 07:50:05.2614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vnhZjyAsYjfb+pC7O72zagz9KBnxpiqH1TSOuqrzZQ0JXMdJJ3WTcheODCL4piT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.03.21 um 00:14 schrieb Jason Gunthorpe:
> On Wed, Mar 24, 2021 at 09:07:53PM +0100, Thomas Hellström (Intel) wrote:
>> On 3/24/21 7:31 PM, Christian König wrote:
>>>
>>> Am 24.03.21 um 17:38 schrieb Jason Gunthorpe:
>>>> On Wed, Mar 24, 2021 at 04:50:14PM +0100, Thomas Hellström (Intel)
>>>> wrote:
>>>>> On 3/24/21 2:48 PM, Jason Gunthorpe wrote:
>>>>>> On Wed, Mar 24, 2021 at 02:35:38PM +0100, Thomas Hellström
>>>>>> (Intel) wrote:
>>>>>>
>>>>>>>> In an ideal world the creation/destruction of page
>>>>>>>> table levels would
>>>>>>>> by dynamic at this point, like THP.
>>>>>>> Hmm, but I'm not sure what problem we're trying to solve
>>>>>>> by changing the
>>>>>>> interface in this way?
>>>>>> We are trying to make a sensible driver API to deal with huge pages.
>>>>>>> Currently if the core vm requests a huge pud, we give it
>>>>>>> one, and if we
>>>>>>> can't or don't want to (because of dirty-tracking, for
>>>>>>> example, which is
>>>>>>> always done on 4K page-level) we just return
>>>>>>> VM_FAULT_FALLBACK, and the
>>>>>>> fault is retried at a lower level.
>>>>>> Well, my thought would be to move the pte related stuff into
>>>>>> vmf_insert_range instead of recursing back via VM_FAULT_FALLBACK.
>>>>>>
>>>>>> I don't know if the locking works out, but it feels cleaner that the
>>>>>> driver tells the vmf how big a page it can stuff in, not the vm
>>>>>> telling the driver to stuff in a certain size page which it might not
>>>>>> want to do.
>>>>>>
>>>>>> Some devices want to work on a in-between page size like 64k so they
>>>>>> can't form 2M pages but they can stuff 64k of 4K pages in a batch on
>>>>>> every fault.
>>>>> Hmm, yes, but we would in that case be limited anyway to insert ranges
>>>>> smaller than and equal to the fault size to avoid extensive and
>>>>> possibly
>>>>> unnecessary checks for contigous memory.
>>>> Why? The insert function is walking the page tables, it just updates
>>>> things as they are. It learns the arragement for free while doing the
>>>> walk.
>>>>
>>>> The device has to always provide consistent data, if it overlaps into
>>>> pages that are already populated that is fine so long as it isn't
>>>> changing their addresses.
>>>>
>>>>> And then if we can't support the full fault size, we'd need to
>>>>> either presume a size and alignment of the next level or search for
>>>>> contigous memory in both directions around the fault address,
>>>>> perhaps unnecessarily as well.
>>>> You don't really need to care about levels, the device should be
>>>> faulting in the largest memory regions it can within its efficiency.
>>>>
>>>> If it works on 4M pages then it should be faulting 4M pages. The page
>>>> size of the underlying CPU doesn't really matter much other than some
>>>> tuning to impact how the device's allocator works.
>> Yes, but then we'd be adding a lot of complexity into this function that is
>> already provided by the current interface for DAX, for little or no gain, at
>> least in the drm/ttm setting. Please think of the following situation: You
>> get a fault, you do an extensive time-consuming scan of your VRAM buffer
>> object into which the fault goes and determine you can fault 1GB. Now you
>> hand it to vmf_insert_range() and because the user-space address is
>> misaligned, or already partly populated because of a previous eviction, you
>> can only fault single pages, and you end up faulting a full GB of single
>> pages perhaps for a one-time small update.
> Why would "you can only fault single pages" ever be true? If you have
> 1GB of pages then the vmf_insert_range should allocate enough page
> table entries to consume it, regardless of alignment.

Completely agree with Jason. Filling in the CPU page tables is 
relatively cheap if you fill in a large continuous range.

In other words filling in 1GiB of a linear range is *much* less overhead 
than filling in 1<<18 4KiB faults.

I would say that this is always preferable even if the CPU only wants to 
update a single byte.

> And why shouldn't DAX switch to this kind of interface anyhow? It is
> basically exactly the same problem. The underlying filesystem block
> size is *not* necessarily aligned to the CPU page table sizes and DAX
> would benefit from better handling of this mismatch.
>
>> On top of this, unless we want to do the walk trying increasingly smaller
>> sizes of vmf_insert_xxx(), we'd have to use apply_to_page_range() and teach
>> it about transhuge page table entries, because pagewalk.c can't be used (It
>> can't populate page tables). That also means apply_to_page_range() needs to
>> be complicated with page table locks since transhuge pages aren't stable and
>> can be zapped and refaulted under us while we do the walk.
> I didn't say it would be simple :) But we also need to stop hacking
> around the sides of all this huge page stuff and come up with sensible
> APIs that drivers can actually implement correctly. Exposing drivers
> to specific kinds of page levels really feels like the wrong level of
> abstraction.
>
> Once we start doing this we should do it everywhere, the io_remap_pfn
> stuff should be able to create huge special IO pages as well, for
> instance.

Oh, yes please!

We easily have 16GiB of VRAM which is linear mapped into the kernel 
space for each GPU instance.

Doing that with 1GiB mapping instead of 4KiB would be quite a win.

Regards,
Christian.

>   
>> On top of this, the user-space address allocator needs to know how large gpu
>> pages are aligned in buffer objects to have a reasonable chance of aligning
>> with CPU huge page boundaries which is a requirement to be able to insert a
>> huge CPU page table entry, so the driver would basically need the drm helper
>> that can do this alignment anyway.
> Don't you have this problem anyhow?
>
> Jason

