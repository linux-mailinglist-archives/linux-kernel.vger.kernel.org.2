Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691624342CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 03:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJTBXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 21:23:48 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:43384 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229639AbhJTBXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 21:23:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Ut-kjiw_1634692891;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Ut-kjiw_1634692891)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Oct 2021 09:21:32 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH v2 2/2] mm/damon/dbgfs: Add adaptive_targets list check
 before enable monitor_on
To:     SeongJae Park <sj@kernel.org>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211019154243.17474-1-sj@kernel.org>
Message-ID: <7376a28e-ac8d-06d0-fa05-81656cd3a994@linux.alibaba.com>
Date:   Wed, 20 Oct 2021 09:21:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211019154243.17474-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/10/19 下午11:42, SeongJae Park wrote:
> Hello Xin,
>
> On Tue, 19 Oct 2021 22:26:04 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> When the ctx->adaptive_targets list is empty,
>> i did some test on monitor_on interface like this.
> s/i/I/
thanks
>> echo on > /sys/kernel/debug/damon/monitor_on
>> [  851.988307] damon: kdamond (5390) starts
> Could you please add four spaces in the beginning of this example terminal
> outputs?  Also, I think confirming targets are empty like below before writing
> 'on' could make this example better.
>
>      # cat /sys/kernel/debug/damon/target_ids
>      #
>
> or, like below.
>
>      # echo > /sys/kernel/debug/damon/target_ids
Oh! thank you so much, i will fix it.
>
>> Though the ctx->adaptive_targets list is empty, but the
>> kthread_run still be called, and the kdamond.x thread still
>> be created, this is meaningless.
>>
>> So there adds a judgment in 'dbgfs_monitor_on_write',
>> if the ctx->adaptive_targets list is empty, return -EINVAL.
>>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   include/linux/damon.h |  1 +
>>   mm/damon/core.c       |  5 +++++
>>   mm/damon/dbgfs.c      | 10 ++++++++--
>>   3 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index 715dadd21f7c..06acf73fe9db 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -316,6 +316,7 @@ void damon_destroy_scheme(struct damos *s);
>>
>>   struct damon_target *damon_new_target(unsigned long id);
>>   void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
>> +int damon_target_empty(struct damon_ctx *ctx);
> Seems 'bool' would be better for the return type?
ok!
>
>>   void damon_free_target(struct damon_target *t);
>>   void damon_destroy_target(struct damon_target *t);
>>   unsigned int damon_nr_regions(struct damon_target *t);
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index 2f6785737902..c651b49249e5 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -156,6 +156,11 @@ void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
>>   	list_add_tail(&t->list, &ctx->adaptive_targets);
>>   }
>>
>> +int damon_target_empty(struct damon_ctx *ctx)
>> +{
>> +	return list_empty(&ctx->adaptive_targets);
>> +}
>> +
>>   static void damon_del_target(struct damon_target *t)
>>   {
>>   	list_del(&t->list);
>> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
>> index 38188347d8ab..bac42dd358d1 100644
>> --- a/mm/damon/dbgfs.c
>> +++ b/mm/damon/dbgfs.c
>> @@ -865,9 +865,15 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
>>   		return -EINVAL;
>>   	}
>>
>> -	if (!strncmp(kbuf, "on", count))
>> +	if (!strncmp(kbuf, "on", count)) {
>> +		int i;
>> +
>> +		for (i = 0; i < dbgfs_nr_ctxs; i++) {
>> +			if (damon_target_empty(dbgfs_ctxs[i]))
>> +				return -EINVAL;
>> +		}
>>   		err = damon_start(dbgfs_ctxs, dbgfs_nr_ctxs);
>> -	else if (!strncmp(kbuf, "off", count))
>> +	} else if (!strncmp(kbuf, "off", count))
>>   		err = damon_stop(dbgfs_ctxs, dbgfs_nr_ctxs);
>>   	else
>>   		err = -EINVAL;
> Please use braces for all above branches:
Ok，i will correct it.
>
> https://docs.kernel.org/process/coding-style.html#placing-braces-and-spaces
>
>
> Thanks,
> SJ
>
>> --
>> 2.31.0

-- 
Best Regards!
Xin Hao

