Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CC3437022
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhJVCpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:45:54 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:50869 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232351AbhJVCpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:45:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UtCtr96_1634870602;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UtCtr96_1634870602)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Oct 2021 10:43:23 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH V2] mm/damon/dbgfs: Optimize target_ids interface write
 operation
To:     SeongJae Park <sj@kernel.org>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211021173018.15994-1-sj@kernel.org>
Message-ID: <a23c6f23-cf6b-1833-5603-363c45df933f@linux.alibaba.com>
Date:   Fri, 22 Oct 2021 10:43:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211021173018.15994-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/10/22 上午1:30, SeongJae Park wrote:
> Hello Xin,
>
> On Fri, 22 Oct 2021 00:44:16 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> When we want to clear previously set target ids,
>> For example, it works as below now:
>>      # echo 42 > target_ids
>>      # cat target_ids
>>      42
>>      # echo > target_ids
>>      # cat target_ids
>>
>> But in 'dbgfs_target_ids_write', there is no need to
>> execute other codes, except call 'damon_set_targets'
>> to clear previously set target ids. So there adds
>> the 'nr_targets' judgment, if the value is 0, just
>> call 'damon_set_targets', and then return.
> It's true that it executes some unnecessary code.  However, I unsure if that is
> a problem, as the code that will be additionally executed in this case are
> quite simple ones, and therefore not supposed to incur viewable overhead.
> After all, this is not a performance critical path.

Thank you for your detailed explanation. I may not describe it clearly, 
making you think that i am making this

modification to improve performance，I just want to avoid irrelevant code 
execution, thank you so much.

>
> Thanks,
> SJ
>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   mm/damon/dbgfs.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
>> index a02cf6bee8e8..1d83f4138fad 100644
>> --- a/mm/damon/dbgfs.c
>> +++ b/mm/damon/dbgfs.c
>> @@ -362,6 +362,12 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
>>   		goto out;
>>   	}
>>
>> +	if (!nr_targets) {
>> +		/* remove targets with previously-set primitive */
>> +		damon_set_targets(ctx, NULL, 0);
>> +		goto free_targets_out;
>> +	}
>> +
>>   	if (id_is_pid) {
>>   		for (i = 0; i < nr_targets; i++) {
>>   			targets[i] = (unsigned long)find_get_pid(
>> --
>> 2.31.0

-- 
Best Regards!
Xin Hao

