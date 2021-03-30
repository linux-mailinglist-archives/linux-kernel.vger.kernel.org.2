Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D5334DF13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhC3DQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:16:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15034 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhC3DPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:15:55 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8ZJr117bzPmZW;
        Tue, 30 Mar 2021 11:13:16 +0800 (CST)
Received: from [10.174.179.86] (10.174.179.86) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 11:15:52 +0800
Subject: Re: [Question] Is there a race window between swapoff vs synchronous
 swap_readpage
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        "Shakeel Butt" <shakeelb@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        "Minchan Kim" <minchan@kernel.org>
References: <364d7ce9-ccb7-fa04-7067-44a96be87060@huawei.com>
 <8735wdbdy4.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0cb765aa-1783-cd62-c4a4-b3fbc620532d@huawei.com>
Date:   Tue, 30 Mar 2021 11:15:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <8735wdbdy4.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.86]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/30 9:57, Huang, Ying wrote:
> Hi, Miaohe,
> 
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> Hi all,
>> I am investigating the swap code, and I found the below possible race window:
>>
>> CPU 1							CPU 2
>> -----							-----
>> do_swap_page
>>   skip swapcache case (synchronous swap_readpage)
>>     alloc_page_vma
>> 							swapoff
>> 							  release swap_file, bdev, or ...
>>       swap_readpage
>> 	check sis->flags is ok
>> 	  access swap_file, bdev or ...[oops!]
>> 							    si->flags = 0
>>
>> The swapcache case is ok because swapoff will wait on the page_lock of swapcache page.
>> Is this will really happen or Am I miss something ?
>> Any reply would be really grateful. Thanks! :)
> 
> This appears possible.  Even for swapcache case, we can't guarantee the

Many thanks for reply!

> swap entry gotten from the page table is always valid too.  The

The page table may change at any time. And we may thus do some useless work.
But the pte_same() check could handle these races correctly if these do not
result in oops.

> underlying swap device can be swapped off at the same time.  So we use
> get/put_swap_device() for that.  Maybe we need similar stuff here.

Using get/put_swap_device() to guard against swapoff for swap_readpage() sounds
really bad as swap_readpage() may take really long time. Also such race may not be
really hurtful because swapoff is usually done when system shutdown only.
I can not figure some simple and stable stuff out to fix this. Any suggestions or
could anyone help get rid of such race?

Anyway, thanks again!

> 
> Best Regards,
> Huang, Ying
> .
> 

