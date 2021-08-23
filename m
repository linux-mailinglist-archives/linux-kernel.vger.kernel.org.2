Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFF63F4730
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbhHWJPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:15:19 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14409 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbhHWJPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:15:17 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GtRKt1P9bzbdRw;
        Mon, 23 Aug 2021 17:10:42 +0800 (CST)
Received: from [10.174.177.35] (10.174.177.35) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 23 Aug 2021 17:14:30 +0800
Subject: Re: [PATCH 3/3] mm/memory_hotplug: make HWPoisoned dirty swapcache
 pages unmovable
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "cgoldswo@codeaurora.org" <cgoldswo@codeaurora.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210821094246.10149-1-linmiaohe@huawei.com>
 <20210821094246.10149-4-linmiaohe@huawei.com>
 <20210823082646.GB1452382@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <de9e587e-fcc4-11e0-19a0-22a1bbafa4b6@huawei.com>
Date:   Mon, 23 Aug 2021 17:14:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210823082646.GB1452382@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.35]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/23 16:26, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Sat, Aug 21, 2021 at 05:42:46PM +0800, Miaohe Lin wrote:
>> HWPoisoned dirty swapcache pages are kept for killing owner processes.
>> We should not offline these pages or do_swap_page() would access the
>> offline pages and lead to bad ending.
>>
> 
> Thank you for the report.  I'm not yet sure of the whole picture of this
> issue.  do_swap_page() is expected to return with fault VM_FAULT_HWPOISON
> when called via the access to the error page, so I wonder why this doesn't
> work for your situation.  And what is the "bad ending" in the description?
> 

IMO we might hotremove the page while SwapCache still have ref to it. Thus the page
struct would be accessed after offlined. The page struct should be invalid in this case
and this would make do_swap_page fragile. Or am I miss something?

> I feel that aborting memory hotremove due to a hwpoisoned dirty swapcache
> might be too hard, so I'd like to find another solution if we have.

If there is a better way, we can just drop this one.

Many thanks for your review and reply! :)

> # You may separate this patch from former two to make them merged to
> # mainline soon.
> 
> Thanks,
> Naoya Horiguchi
> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/memory_hotplug.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 9fd0be32a281..0488eed3327c 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1664,6 +1664,12 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>>  		 */
>>  		if (PageOffline(page) && page_count(page))
>>  			return -EBUSY;
>> +		/*
>> +		 * HWPoisoned dirty swapcache pages are definitely unmovable
>> +		 * because they are kept for killing owner processes.
>> +		 */
>> +		if (PageHWPoison(page) && PageSwapCache(page))
>> +			return -EBUSY;

