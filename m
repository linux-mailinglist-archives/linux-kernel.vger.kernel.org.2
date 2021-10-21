Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA59E436835
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhJUQpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:45:11 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60978 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230072AbhJUQpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:45:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UtABIP-_1634834571;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UtABIP-_1634834571)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Oct 2021 00:42:52 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH] mm/damon/dbgfs: Optimize target_ids interface write
 operation
To:     SeongJae Park <sj@kernel.org>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211021094543.1846-1-sj@kernel.org>
Message-ID: <3fecc78c-44ed-368a-d64f-6e809020bd77@linux.alibaba.com>
Date:   Fri, 22 Oct 2021 00:42:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211021094543.1846-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/10/21 下午5:45, SeongJae Park wrote:
> Hello Xin,
>
> On Thu, 21 Oct 2021 16:56:11 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> When writing some pids to target_ids interface, calling scanf()
>> to get 'id' may be failed. If the value of '*nr_ids' is 0 at this time,
>> there is no need to return 'ids' here, we just need to release it and
>> return NULL pointer to improve related code operation efficiency.
> Thank you for the patch!  But, I don't think this patch makes sense, because
> the case (*nr_ids == 0) means not error but an ask to remove previously set
> target ids.  For example, it works as below now:
>
>      # echo 42 > target_ids
>      # cat target_ids
>      42
>      # echo > target_ids
>      # cat target_ids
>
>      #
>
> But, with your patch, the behavior will be changed as below:
>
>      # echo 42 > target_ids
>      # cat target_ids
>      42
>      # echo > target_ids
>      bash: echo: write error: Cannot allocate memory
>      # cat target_ids
>      42
>      #

Hi Park:

     I did not use the lastest code to test, so I ignored that it calls 
'damon_set_targets'

to clear previously set target ids, Sorry.

     I think if we want only want to clear the previously set target 
ids, this codes are all no need to execute, except call

'damon_set_targets(ctx, NULL, 0);'

----------------------------------------------------------

         if (id_is_pid) {
                 for (i = 0; i < nr_targets; i++) {
                         targets[i] = (unsigned long)find_get_pid(
                                         (int)targets[i]);
                         if (!targets[i]) {
                                 dbgfs_put_pids(targets, i);
                                 ret = -EINVAL;
                                 goto free_targets_out;
                         }
                 }
         }

         mutex_lock(&ctx->kdamond_lock);
         if (ctx->kdamond) {
                 if (id_is_pid)
                         dbgfs_put_pids(targets, nr_targets);
                 ret = -EBUSY;
                 goto unlock_out;
         }

       . . .

         /* Configure the context for the address space type */
         if (id_is_pid)
                 damon_va_set_primitives(ctx);
         else
                 damon_pa_set_primitives(ctx);

         ret = damon_set_targets(ctx, targets, nr_targets);
         if (ret) {
                 if (id_is_pid)
                         dbgfs_put_pids(targets, nr_targets);
         } else {
                 ret = count;

>
> Also, this patch makes the DAMON selftest fails as below:
>
>      $ sudo make -C tools/testing/selftests/damon run_tests
>      make: Entering directory '/home/sjpark/linux/tools/testing/selftests/damon'
>      TAP version 13
>      1..2
>      # selftests: damon: debugfs_attrs.sh
>      # ./debugfs_attrs.sh: line 11: echo: write error: Invalid argument
>      # ./debugfs_attrs.sh: line 11: echo: write error: Invalid argument
>      # ./debugfs_attrs.sh: line 11: echo: write error: Invalid argument
>      # ./debugfs_attrs.sh: line 11: echo: write error: Invalid argument
>      # ./debugfs_attrs.sh: line 11: echo: write error: Invalid argument
>      # ./debugfs_attrs.sh: line 11: echo: write error: Cannot allocate memory
>      # writing abc 2 3 to /sys/kernel/debug/damon/target_ids doesn't return 0
>      # expected because: the file allows wrong input
>      not ok 1 selftests: damon: debugfs_attrs.sh # exit=1
>
> If I'm missing something, please let me know.
I will post a new patch to fix the problems you encountered in the above 
test, thank you so much!
>
>
> Thanks,
> SJ
>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   mm/damon/dbgfs.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
>> index a02cf6bee8e8..2d77bf579ffb 100644
>> --- a/mm/damon/dbgfs.c
>> +++ b/mm/damon/dbgfs.c
>> @@ -308,21 +308,25 @@ static unsigned long *str_to_target_ids(const char *str, ssize_t len,
>>   	unsigned long *ids;
>>   	const int max_nr_ids = 32;
>>   	unsigned long id;
>> -	int pos = 0, parsed, ret;
>> +	int pos = 0, parsed;
>>   
>>   	*nr_ids = 0;
>>   	ids = kmalloc_array(max_nr_ids, sizeof(id), GFP_KERNEL);
>>   	if (!ids)
>>   		return NULL;
>>   	while (*nr_ids < max_nr_ids && pos < len) {
>> -		ret = sscanf(&str[pos], "%lu%n", &id, &parsed);
>> -		pos += parsed;
>> -		if (ret != 1)
>> +		if (sscanf(&str[pos], "%lu%n", &id, &parsed) != 1)
>>   			break;
>> +		pos += parsed;
>>   		ids[*nr_ids] = id;
>>   		*nr_ids += 1;
>>   	}
>>   
>> +	if (!*nr_ids) {
>> +		kfree(ids);
>> +		return NULL;
>> +	}
>> +
>>   	return ids;
>>   }
>>   
>> -- 
>> 2.31.0

-- 
Best Regards!
Xin Hao

