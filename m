Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F33D32BDA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445178AbhCCQS0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Mar 2021 11:18:26 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3460 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbhCCLpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:45:30 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Dr7bp3qh5z5YCd;
        Wed,  3 Mar 2021 17:14:14 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 3 Mar 2021 17:15:56 +0800
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 3 Mar 2021 17:15:55 +0800
Received: from dggeme755-chm.china.huawei.com ([10.7.64.71]) by
 dggeme755-chm.china.huawei.com ([10.7.64.71]) with mapi id 15.01.2106.006;
 Wed, 3 Mar 2021 17:15:55 +0800
From:   "Zhouguanghui (OS Kernel)" <zhouguanghui1@huawei.com>
To:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
CC:     Hugh Dickins <hughd@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Dingtianhong <dingtianhong@huawei.com>,
        Chenweilong <chenweilong@huawei.com>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH] mm/memcg: set memcg when split pages
Thread-Topic: [PATCH] mm/memcg: set memcg when split pages
Thread-Index: AQHXD0TOPfGiAC+zfUG9IaYiC6n5KA==
Date:   Wed, 3 Mar 2021 09:15:55 +0000
Message-ID: <afd198dbac71474f8f02c710feaf8c5e@huawei.com>
References: <20210302013451.118701-1-zhouguanghui1@huawei.com>
 <YD4CciUX0/eXFLM0@dhcp22.suse.cz>
 <alpine.LSU.2.11.2103021157160.8450@eggly.anvils>
 <YD7Ch/8QebzmneCR@cmpxchg.org> <YD8+2P6J9+NhLZoX@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.106]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/3/3 15:46, Michal Hocko 写道:
> On Tue 02-03-21 17:56:07, Johannes Weiner wrote:
>> On Tue, Mar 02, 2021 at 12:24:41PM -0800, Hugh Dickins wrote:
>>> On Tue, 2 Mar 2021, Michal Hocko wrote:
>>>> [Cc Johannes for awareness and fixup Nick's email]
>>>>
>>>> On Tue 02-03-21 01:34:51, Zhou Guanghui wrote:
>>>>> When split page, the memory cgroup info recorded in first page is
>>>>> not copied to tail pages. In this case, when the tail pages are
>>>>> freed, the uncharge operation is not performed. As a result, the
>>>>> usage of this memcg keeps increasing, and the OOM may occur.
>>>>>
>>>>> So, the copying of first page's memory cgroup info to tail pages
>>>>> is needed when split page.
>>>>
>>>> I was not aware that alloc_pages_exact is used for accounted allocations
>>>> but git grep told me otherwise so this is not a theoretical one. Both
>>>> users (arm64 and s390 kvm) are quite recent AFAICS. split_page is also
>>>> used in dma allocator but I got lost in indirection so I have no idea
>>>> whether there are any users there.
>>>
>>> Yes, it's a bit worrying that such a low-level thing as split_page()
>>> can now get caught up in memcg accounting, but I suppose that's okay.
>>>
>>> I feel rather strongly that whichever way it is done, THP splitting
>>> and split_page() should use the same interface to memcg.
>>>
>>> And a look at mem_cgroup_split_huge_fixup() suggests that nowadays
>>> there need to be css_get()s too - or better, a css_get_many().
>>>
>>> Its #ifdef CONFIG_TRANSPARENT_HUGEPAGE should be removed, rename
>>> it mem_cgroup_split_page_fixup(), and take order from caller.
>>
>> +1
>>
>> There is already a split_page_owner() in both these places as well
>> which does a similar thing. Mabye we can match that by calling it
>> split_page_memcg() and having it take a nr of pages?
> 
> Sounds good to me.
> 
  Hi, Michal, Johannes, Hugh, and Zi Yan, thank you for taking time for 
this.

I agree, and will send v2 patches for taking these.

Thanks
