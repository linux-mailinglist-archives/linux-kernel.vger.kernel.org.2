Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B50135970B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhDIIBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:01:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16110 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhDIIBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:01:43 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGrBD65z7z1BGK1;
        Fri,  9 Apr 2021 15:59:16 +0800 (CST)
Received: from [10.174.179.9] (10.174.179.9) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 16:01:23 +0800
Subject: Re: [PATCH 0/5] close various race windows for swap
To:     riteshh <riteshh@linux.ibm.com>
CC:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>,
        <alex.shi@linux.alibaba.com>, <willy@infradead.org>,
        <minchan@kernel.org>, <richard.weiyang@gmail.com>,
        <ying.huang@intel.com>, <hughd@google.com>,
        <tim.c.chen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210408130820.48233-1-linmiaohe@huawei.com>
 <20210408145517.jqodfz6cmm4wwk7g@riteshh-domain>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <48892512-c2f7-9898-0373-a185975b456c@huawei.com>
Date:   Fri, 9 Apr 2021 16:01:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210408145517.jqodfz6cmm4wwk7g@riteshh-domain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/8 22:55, riteshh wrote:
> On 21/04/08 09:08AM, Miaohe Lin wrote:
>> Hi all,
>> When I was investigating the swap code, I found some possible race
>> windows. This series aims to fix all these races. But using current
>> get/put_swap_device() to guard against concurrent swapoff for
>> swap_readpage() looks terrible because swap_readpage() may take really
>> long time. And to reduce the performance overhead on the hot-path as
>> much as possible, it appears we can use the percpu_ref to close this
>> race window(as suggested by Huang, Ying). The patch 1 adds percpu_ref
>> support for swap and the rest of the patches use this to close various
>> race windows. More details can be found in the respective changelogs.
>> Thanks!
>>
>> Miaohe Lin (5):
>>   mm/swapfile: add percpu_ref support for swap
>>   swap: fix do_swap_page() race with swapoff
>>   mm/swap_state: fix get_shadow_from_swap_cache() race with swapoff
>>   mm/swap_state: fix potential faulted in race in swap_ra_info()
>>   mm/swap_state: fix swap_cluster_readahead() race with swapoff
> 

Many thanks for quick respond.

> Somehow I see Patch-1 and Patch-2 are missing on linux-mm[1].

I have no idea why Patch-1 and Patch-2 are missing. But they could be found at:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2542188.html

> Also I wanted to ask if you have a way to trigger this in a more controlled
> environment (consistently)?
> 

This is *theoretical* issue. The race window is very small but not impossible.
Please see the discussion:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2530094.html

> [1]: https://patchwork.kernel.org/project/linux-mm/cover/20210408130820.48233-1-linmiaohe@huawei.com/
> 

Thanks again.

> -ritesh
> 
>>
>>  include/linux/swap.h |  4 +++-
>>  mm/memory.c          | 10 +++++++++
>>  mm/swap_state.c      | 33 +++++++++++++++++++++--------
>>  mm/swapfile.c        | 50 +++++++++++++++++++++++++++-----------------
>>  4 files changed, 68 insertions(+), 29 deletions(-)
>>
>> --
>> 2.19.1
>>
>>
> .
> 

