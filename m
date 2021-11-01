Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D1B4420DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 20:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhKATeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 15:34:20 -0400
Received: from mail-dm6nam10on2067.outbound.protection.outlook.com ([40.107.93.67]:42912
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229511AbhKATeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:34:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF3TBfc0TGZERus956n4tTqJDByg6p5UKO8lD1h07UJ89TXOueDeqAUEdLM92+OMVMpSpjbn+yUdcGfWPn/9GWbR9LbIgbbDaYhbxOGtcL2yKpelPkMP3UHbbUDOogyX87UW1IjoApzaqT9Y655T+2R1BLyyvJnjVZtWkzQ0vOfFTT55eGEUUxp3e1/3264or/c3tHrd4yVRgbwbOCC6mi4ZPWtuvfBHez3IOEfqI05QuyTuQfpSnstRh6xe7JlLgBM0rAjt8Ocpb4rzLBV4njTYP8tGKPF9n+nTcbHkTyCzk7b99Z3e8eQ8n1PPMN2ohJLGeqCLw+ZCH9TqgtuWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoNwZrsM6DNfmR7P+JatdnKrhEj0oWEYm7ktyTGNfOI=;
 b=EGf5c0gNuA2DXEVqNJB1U+Ke9qWy1w8XxA3i36wpY/9N5JugIpfPAN6GdJoHOrvU/M4rqPBbfX3qvSLBuWvBa4xA+fOq3i+ZdXjffHdJKRS04VkH01aK2/Gi0kBULuRIqEQp7+4trLVwHRmvj/8ZgDn71fL8oZr7qV5SxEWmZ7Br2RMjyRpqVgh6pIloBmcsL59en9rS7V29V2wbbMDYjWF3d28ucl7fH3Bw51hazdflxnMfTO7Hev6orGnBMPDXWlUirzWYjKk+RmROnH5YjdAM+ygSa7NwZO6jq3ErcOdoP5i+KdrEAL6AENOFjZrQLATHhcOg6swqiJSO1qotCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoNwZrsM6DNfmR7P+JatdnKrhEj0oWEYm7ktyTGNfOI=;
 b=MiGjF+Nt02JoS07I54gnozTqGrKXtR6eCe1sFDp/fe0gkhL6AnfBzJ4oszZTrhmF3yDi/EM+n3q0+EubpNoVO++ekdIT5IrsPRbn4vCYhFeWJ2bdnzepp+8SFMWrAhKHoYSt0AkXZRgKAsi49MacygrTVJl/PK59cc6Gfz3yl0tV3sXJeFlkv/1vUTVXWQxj9E7Gdf83IK9Qu075snsmJaHheC60JMuzyEfrRvBEkMfhh2bzHK9Jekg4CQ5qYX43CEXR6XoSpMgAAcAPHKSTY6yYSdy8yjnjUnd/w6UbIHm3HOOhVSyhdv75t/XOmThwthV6mXkosrCI2s851Ggudw==
Authentication-Results: soleen.com; dkim=none (message not signed)
 header.d=none;soleen.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 19:31:40 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310%4]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 19:31:40 +0000
Message-ID: <f883edca-42cb-9194-363c-44fbc806cfe5@nvidia.com>
Date:   Mon, 1 Nov 2021 12:31:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC 3/8] mm: Avoid using set_page_count() in
 set_page_recounted()
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <20211026173822.502506-4-pasha.tatashin@soleen.com>
 <7b131cb1-68d8-6746-f9c1-2b01d4838869@nvidia.com>
 <CA+CK2bD6x01PevPqshzYqkO3aokjP2jBbt_4e5H5U3DVEdcJ5Q@mail.gmail.com>
 <b346cafd-d8b8-57a4-c7b9-6574b256a400@nvidia.com>
 <CA+CK2bBiomTe-vOuxM_R+0CMAippyrfZ6AgpXQGqps3ZFQCtRA@mail.gmail.com>
 <19d16b40-355f-3f79-dcba-e1d8d2216d33@nvidia.com>
 <CA+CK2bBn81pz5NqCvS9jz+DvXbGG6d52Q=xTySJvJuqNRmFkkg@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CA+CK2bBn81pz5NqCvS9jz+DvXbGG6d52Q=xTySJvJuqNRmFkkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::31) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.57.12] (216.228.112.21) by BYAPR05CA0090.namprd05.prod.outlook.com (2603:10b6:a03:e0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Mon, 1 Nov 2021 19:31:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b484ec04-c84d-4537-118f-08d99d6e3a4a
X-MS-TrafficTypeDiagnostic: BY5PR12MB4307:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4307DB7DAB4A33447122B41FA88A9@BY5PR12MB4307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGOMMdlJZEfKxdhh1K0b44P9eI0HQxPl3o7ygOHTcJ1rBj9LYbKFJ4a7duvgYq3e9ggPWibkwk/8jlGoFFkdPkcaFA0H74CxcnAn3OZW9+k+ry/RwtAZ3UrxcABhrdrFrqJbwEusi5YSQp2f8IzwMsOVyMTOc+/rtBgZjD1CCQfqhNcak4kvsoZ0jxEhkzTTQ4ZYujagK9/yQZ3JygANrQZ2xPruxGgh8Qr9cVXtqpnTIp1g0ldtgxv+Sqw6usm1yrW/OOnZkyITuHIruAWpCwsLz/pcM5v24BQPzgPq7U4hmVW9FXwRvNJAXEZ5i+vPoEjmaOSxLpDuIDyjOXZiwEAllLi6iAbrJKm6r4bl1gG4r9hNDwQTaufr4Mxj73gTOGrtIx5M4VY0CLQmJXGqkNT9mObm9IVZ8NplZfwP4cOUKpU7Tpu4j28KX2sj6g5oSgKINJYynfnKfsvELDSE2JkX/63tliWgCBCR04HDGOjiwYbuO/Ct2CunwEu0qTHHtnqsL2IJbhEEaHaivA9MWyGgPiUXLkjSIbQCUk1u2jb2eXMnlS/9iqknLUuz8FbnnrmmbKKFBLEYiqAQTduRkk4gZdhPoptouSlK9zpsEZ873OX+MX/Qvwu/7ssMKiro1lja6EdA1HonHGLLmQ02oEEyfnvb/s6STgqfc9WIIcyPdbrdR6iKyI/QzrTcP+PTXvj6HDFgmL/XL0FAE1dr2TdXSmLBkliliivsZIDkAwuvEm7Oa+++XryWDtp4Bik9ihglMOkPmQExm6ce8zRfWBIC/MuRzgvmc20h3P/aryz9NmwYKPiVdtiTKapezYJ7qeKm+kwsoh3sQyXG0ftMMQy64YMPNv67ASvMuwQRgCs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(53546011)(66556008)(36756003)(966005)(66946007)(31696002)(508600001)(956004)(6916009)(66476007)(38100700002)(2616005)(31686004)(2906002)(5660300002)(54906003)(6486002)(4326008)(26005)(8676002)(16576012)(316002)(86362001)(83380400001)(7416002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUwrZTYrdmpBaG91bE90Z2gwbTFnUmxmU00xODFzWVdwenU0b3EzVVpIdkZH?=
 =?utf-8?B?VjMrZGlhWkcyaGYrMmw2RG9JWTRPTUJVclJOc3JjcTlxWWI1WGtKY0dzYk1E?=
 =?utf-8?B?UG9zaisrUnR4TkEzV1J0WVFwYlY2OVhoZkRnZ1ZNenpic3h2Q09LaDViWW9q?=
 =?utf-8?B?R29tZ2JMdkYybUh0U0hJWlRhd1JaYk81L0RPcUdBNzlyOWliZ2lUS1ErNU9Z?=
 =?utf-8?B?U2NkTWs2bHVwVFhXRHUrSzdDVnBNRGJZakRmSDlPRXVMZ2JMcEVTaUVNayty?=
 =?utf-8?B?dHRsU3JDTzEzem00RmM2M0FwOHFrUFdRd2ltZVAzVCtBbXZueVl3dFVVOVgv?=
 =?utf-8?B?bk5CTVdkaStlLzVPeE5iOWRkVHN2cnhYOE5HNDdNa0Z3R25LWFFwWVlYbTFR?=
 =?utf-8?B?ZnJvKzRJQ2Fpei9UZENPSVlTWVJBTlgvN3F6cy9rSWp0VUtnS3FhQmhEU29n?=
 =?utf-8?B?eFJKeDBHUjlHMVFHZ3k0T1B3TWppK2RVdlRTd0s0RFpIcTJ0NVU0aHNiRU8w?=
 =?utf-8?B?RFpTZjFraTZUdlZRbU1tZ2RyZVpOd2xEMkorZEZKTFRDNzdZSGNDbFgxKzZj?=
 =?utf-8?B?NzFFcVNlNTNzU21XZmlwTy9xOUxpdk5IT3pUMTZGQ3lidXFPbkpTRzhJYUND?=
 =?utf-8?B?UjVLcmU5QXpPRVR6d2t3dURya2ZNbmIzemhITDZPakllU1RmZVhPWmRZZzRn?=
 =?utf-8?B?Z29vbFg5RmVxVVRmajMzR2lGVnVIazRTY3ltV0FySnJBOUVzMzFVUzZPZVpz?=
 =?utf-8?B?UjM1VVJKbWpCc3hoeUk1b0Q5SWNNejFMc0V5WkllTDRUQXhPT2ZZSEFXUjlL?=
 =?utf-8?B?TUx3ZmwxS0NhUXBGc1pKdFNHc2JTZzdiTVVKblhYQjFsNGxsdmxjSjBQMDBF?=
 =?utf-8?B?MGFYbmYvSXh3STJReUNCbkJBMDh6OEsxcURzM2d6Um14VlRuNkJsSWpmNEhP?=
 =?utf-8?B?T1ZJTWZxQXo1TDVBYTQvQk1XVklsdUFiOGtUMS9rakp0S05xMUQ3MzlaeXFj?=
 =?utf-8?B?VmRHUXA5SUJEa0ZmNE1ZM3RLZmpoVVBVVEJUd1YwRnFSejI2YUVKaU43ZHNH?=
 =?utf-8?B?aTIvNndYZ3lrN1JBUTRMVlFmVlpDZzlsZDAzcVgxc1FvTUhseHpXSDhTMk1N?=
 =?utf-8?B?Z3U2ZUZ5OXBkMk5LMXB5QnFaM2oyeXdIZG5TeXJzOXBwazkrTS9NdXVQRWdQ?=
 =?utf-8?B?OTNHZ0MySnk2U3VRQjVpNUpCb0hRMGZlRlZ2YnM2a3d0eHYzQXRNM1Rvd21o?=
 =?utf-8?B?OERHRU5Pc1lCeEI5TVVUUm82U0I5NWxhd0FnZVFrM1Zhdk1wQnlhNVh0L1M0?=
 =?utf-8?B?eDFBdkZxSlFoMmRGdlNLVXFDK09XNlVBQ3RyWVcvS3ZPdWtld1ltb3BtWFQz?=
 =?utf-8?B?YlhHMTZPbWE3eTV4WWc5QThYRUtKS2REQW9hL28yQVUrTG5mNTVGeXhGZEdl?=
 =?utf-8?B?SUJTRHEyVVRXOGVvWEFMeXl5ZGlKRXFUOG80bGhkUFhaT0lRWXVXMXlpT2tW?=
 =?utf-8?B?OGowaHY0SGNRTlRlQ2UyMlhCQ3ZsVm5jWHFpdG0yeEZhNjkrOVFTMUVzUUM5?=
 =?utf-8?B?czdra2NYM2R1OHJpZkMwSExtRHpDS0dEU3B0NUt4Rjk5S1ViQ1NVQ1FOc1Qv?=
 =?utf-8?B?WjdXQ3FRS09OUEZZdmF1WkVuazNtKzFmOHVkekxveGp2U3VaRkFWNGVieXFy?=
 =?utf-8?B?MUcvM2Y4eXJNemlwcjdMZFBxK3Z0TEJ4TzhlSjhuVUxWVndZalFXR1U0TzVO?=
 =?utf-8?B?c21RMjljaWIzNUJCWURmOG9HTlY0ZGF2SlFtaVJvM284em5VZ3J4RDBJdzlz?=
 =?utf-8?B?OXl6dnl5S09CM0cxakFqN0xKMEdreGFzVzhsY3FxdVhCWDZreXFkZ21UYVE2?=
 =?utf-8?B?RUhTWTNnNnVnbUNoNGlVMzkyY3g3UDBVOElRRHlSVFRRbEI5ZmpMWm9pZWpW?=
 =?utf-8?B?Q3RtNTNUSjZkOSszUTRtRHNaYjRvanBOeHhpYThPKy9Yc1JvUzYvVUdmbXhT?=
 =?utf-8?B?d3FpcHpSUGIzUm9Sc2VxMERrYUQ1RTZ6aGhwU1JBZzdNdW1MdWR5dVhEZjNm?=
 =?utf-8?B?SUNidDcza2FNVldFOTQ5MVUwdkFNTUNCeTdaYlV3bDRoUEVDWU56TEZFVkYz?=
 =?utf-8?B?ZTJ2bHhLSnpLS3NnM281RVhtb2NXMmRFOUVQU2d5bFZadlMxeWJERlp2U01Q?=
 =?utf-8?Q?8FnjmZsMQcCqLLwj336h3/g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b484ec04-c84d-4537-118f-08d99d6e3a4a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 19:31:40.1264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQPfJI/OwrOY75IV+ol9F7nSAFg+nvWN1cxR17HHU/RdxpR1S1EIV0BiCMrWhZ/kFqZ8u7qCht2ZS//aGb7swA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/21 07:22, Pasha Tatashin wrote:
>>>> Yes, you are just repeating what the diffs say.
>>>>
>>>> But it's still not good to have this function name doing something completely
>>>> different than its name indicates.
>>>
>>> I see, I can rename it to: 'set_page_recounted/get_page_recounted' ?
>>>
>>
>> What? No, that's not where I was going at all. The function is already
>> named set_page_refcounted(), and one of the problems I see is that your
>> changes turn it into something that most certainly does not
>> set_page_refounted(). Instead, this patch *increments* the refcount.
>> That is not the same thing.
>>
>> And then it uses a .config-sensitive assertion to "prevent" problems.
>> And by that I mean, the wording throughout this series seems to equate
>> VM_BUG_ON_PAGE() assertions with real assertions. They are only active,
>> however, in CONFIG_DEBUG_VM configurations, and provide no protection at
>> all for normal (most distros) users. That's something that the wording,
>> comments, and even design should be tweaked to account for.
> 
> VM_BUG_ON and BUG_ON should be treated the same. Yes, they are config
> sensitive, but in both cases *BUG_ON() means that there is an
> unrecoverable problem that occured. The only difference between the
> two is that VM_BUG_ON() is not enabled when distros decide to reduce
> the size of their kernel and improve runtime performance by skipping
> some extra checking.
> 
> There is no logical separation between VM_BUG_ON and BUG_ON, there is
> been a lengthy discussion about this:
> 
> https://lore.kernel.org/lkml/CA+55aFy6a8BVWtqgeJKZuhU-CZFVZ3X90SdQ5z+NTDDsEOnpJA@mail.gmail.com/
> "so *no*. VM_BUG_ON() is no less deadly than a regular BUG_ON(). It
> just allows some people to build smaller kernels, but apparently
> distro people would rather have debugging than save a few kB of RAM."
> 
> Losing control of ref_count is an unrecoverable problem because it
> leads to security sensitive memory corruptions. It is better to crash
> the kernel when that happens instead of ending up with some pages
> mapped into the wrong address space.
> 
> The races are tricky to spot, but set_page_count() is inherently
> dangerous, so I am removing it entirely and replacing it with safer
> operations which do the same thing.
> 
> One example is this:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=7118fc29

I don't think we have any disagreement about the landscape here. But it's
much easier to describe the problem than it is to fix it--as always. And
repeating the problem doesn't make a proposed fix more (or less) appropriate. :)

> 
>>>>>> I understand where this patchset is going, but this intermediate step is
>>>>>> not a good move.
>>>>>>
>>>>>> Also, for the overall series, if you want to change from
>>>>>> "set_page_count()" to "inc_and_verify_val_equals_one()", then the way to
>>>>>> do that is *not* to depend solely on VM_BUG*() to verify. Instead,
>>>>>> return something like -EBUSY if incrementing the value results in a
>>>>>> surprise, and let the caller decide how to handle it.
> 
> In set_page_refcounted() we already have:
> 
> VM_BUG_ON_PAGE(page_ref_count(page), page);
> set_page_count(page, 1);
> 
> I am pointing out that above code is racy:
> 
> Between the check VM_BUG_ON_PAGE() check and unconditional set to 1
> the value of page->_refcount can change.
> 
> I am replacing it with an identical version of code that is not racy.

And I'm pointing out that raciness is not the real bug, or at least, not
the only bug. "Fixing" the race does not fix the code, but the patch
series seems to imply that it does.

> There is no need to complicate the code by introducing new -EBUSY
> returns here, as it would reduce the fragility of this could even
> farther.
> 
>>>>> Actually, -EBUSY would be OK if the problems were because we failed to
> 
> I am not sure -EBUSY would be OK here, it means we had a race which we
> were not aware about, and which could have led to memory corruptions.
> 
>>>>> modify refcount for some reason, but if we modified refcount and got
>>>>> an unexpected value (i.e underflow/overflow) we better report it right
>>>>> away instead of waiting for memory corruption to happen.
>>>>>
>>>>
>>>> Having the caller do the BUG() or VM_BUG*() is not a significant delay.
> 
> I agree, however, helper functions exist to remove code duplications.
> If we must verify the assumption of set_page_refcounted() that non
> counted page is turned into a counted page, it is better to do it in
> one place than at every call site. We do it today in thus helper
> function, I do not see why we would change that.
> 

Let's ignore this -EBUSY idea for now, because I'm not sure where you are
going with your next version, and maybe it won't even come up.


thanks,
-- 
John Hubbard
NVIDIA
