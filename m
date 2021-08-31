Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB4D3FC50A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhHaJgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:36:01 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:54154 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229652AbhHaJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:35:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Umk8iQZ_1630402501;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Umk8iQZ_1630402501)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 Aug 2021 17:35:01 +0800
Subject: Re: [PATCH] mm: fix panic caused by __page_handle_poison()
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:HWPOISON MEMORY FAILURE HANDLING" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
References: <58b6b733-b021-7eb8-4226-1b98d50c8c82@linux.alibaba.com>
 <20210831091134.GA1075738@hori.linux.bs1.fc.nec.co.jp>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <4bb8b27e-2926-82db-0da2-dbead13c9b69@linux.alibaba.com>
Date:   Tue, 31 Aug 2021 17:35:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210831091134.GA1075738@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/31 下午5:11, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, Aug 30, 2021 at 06:07:56PM +0800, 王贇 wrote:
>> By commit 510d25c92ec4 ("mm/hwpoison: disable pcp for
>> page_handle_poison()"), __page_handle_poison() was
>> introduced, and if we mark:
>>
>> RET_A = dissolve_free_huge_page();
>> RET_B = take_page_off_buddy();
>>
>> then __page_handle_poison was supposed to return TRUE When
>> RET_A == 0 && RET_B == TRUE
>>
>> But since it failed to take care the case when RET_A is
>> -EBUSY or -ENOMEM, and just return the ret as a bool which
>> actually become TRUE, it break the original logical.
> 
> s/logical/logic/ ?

Will Fix it in v2.

> 
>>
>> The following result is a huge page in freelist but was
>> referenced as poisoned, and lead into the final panic:
>>
>>   kernel BUG at mm/internal.h:95!
>>   invalid opcode: 0000 [#1] SMP PTI
>>   skip...
>>   RIP: 0010:set_page_refcounted mm/internal.h:95 [inline]
>>   RIP: 0010:remove_hugetlb_page+0x23c/0x240 mm/hugetlb.c:1371
>>   skip...
>>   Call Trace:
>>    remove_pool_huge_page+0xe4/0x110 mm/hugetlb.c:1892
>>    return_unused_surplus_pages+0x8d/0x150 mm/hugetlb.c:2272
>>    hugetlb_acct_memory.part.91+0x524/0x690 mm/hugetlb.c:4017
>>
>> This patch replace 'bool' with 'int' to handle RET_A correctly.
>>
>> Reported-by: Abaci <abaci@linux.alibaba.com>
>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> 
> Thank you very much, this fix is totally right.
> 
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Could you add the following tags, too?
> 
> Fixes: 510d25c92ec4 ("mm/hwpoison: disable pcp for page_handle_poison()")
> Cc: <stable@vger.kernel.org> # 5.14

Thanks for the review, will add in v2 and send out soon.

Regards,
Michael Wang

> 
> Thanks,
> Naoya Horiguchi
> 
