Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3834583CA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 14:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbhKUNXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 08:23:38 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:36553 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236405AbhKUNXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 08:23:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UxW0YGY_1637500828;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UxW0YGY_1637500828)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 21 Nov 2021 21:20:29 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH V1 2/2] mm/damon: move damon_rand definition into damon.h
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211121113312.3942-1-sj@kernel.org>
Message-ID: <bf5b24f6-88ce-0a35-4a2c-bb6a75ba97b3@linux.alibaba.com>
Date:   Sun, 21 Nov 2021 21:20:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211121113312.3942-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Park:

On 11/21/21 7:33 PM, SeongJae Park wrote:
> Hi Xin,
>
>
> On Sun, 21 Nov 2021 01:27:54 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> damon_rand() is called in three files:damon/core.c, damon/
>> paddr.c, damon/vaddr.c, i think there is no need to redefine
>> this twice, So move it to damon.h will be a good choice.
> Good finding.  Could you please append '()' after 'damon_rand' in the title
> (s/damon_rand definition/damon_rand() definition)?
Ok i will do;
>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> After doing that, you could add
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
>
>
> Thanks,
> SJ
>
>> ---
>>   include/linux/damon.h   | 4 ++++
>>   mm/damon/core.c         | 4 ----
>>   mm/damon/prmtv-common.h | 4 ----
>>   3 files changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index 8a73e825e0d5..8706b17a9acf 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -11,12 +11,16 @@
>>   #include <linux/mutex.h>
>>   #include <linux/time64.h>
>>   #include <linux/types.h>
>> +#include <linux/random.h>
>>   
>>   /* Minimal region size.  Every damon_region is aligned by this. */
>>   #define DAMON_MIN_REGION	PAGE_SIZE
>>   /* Max priority score for DAMON-based operation schemes */
>>   #define DAMOS_MAX_SCORE		(99)
>>   
>> +/* Get a random number in [l, r) */
>> +#define damon_rand(l, r) (l + prandom_u32_max(r - l))
>> +
>>   /**
>>    * struct damon_addr_range - Represents an address region of [@start, @end).
>>    * @start:	Start address of the region (inclusive).
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index 4d2c3a0c7c8a..bdec32ef78c0 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -11,7 +11,6 @@
>>   #include <linux/delay.h>
>>   #include <linux/kthread.h>
>>   #include <linux/mm.h>
>> -#include <linux/random.h>
>>   #include <linux/slab.h>
>>   #include <linux/string.h>
>>   
>> @@ -23,9 +22,6 @@
>>   #define DAMON_MIN_REGION 1
>>   #endif
>>   
>> -/* Get a random number in [l, r) */
>> -#define damon_rand(l, r) (l + prandom_u32_max(r - l))
>> -
>>   static DEFINE_MUTEX(damon_lock);
>>   static int nr_running_ctxs;
>>   
>> diff --git a/mm/damon/prmtv-common.h b/mm/damon/prmtv-common.h
>> index 61f27037603e..e790cb5f8fe0 100644
>> --- a/mm/damon/prmtv-common.h
>> +++ b/mm/damon/prmtv-common.h
>> @@ -6,10 +6,6 @@
>>    */
>>   
>>   #include <linux/damon.h>
>> -#include <linux/random.h>
>> -
>> -/* Get a random number in [l, r) */
>> -#define damon_rand(l, r) (l + prandom_u32_max(r - l))
>>   
>>   struct page *damon_get_page(unsigned long pfn);
>>   
>> -- 
>> 2.31.0
>>
>>
-- 
Best Regards!
Xin Hao

