Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E6F4346A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJTIR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:17:56 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:35000 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229972AbhJTIRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:17:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Ut1BFcd_1634717731;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Ut1BFcd_1634717731)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Oct 2021 16:15:32 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH v3 2/2] mm/damon/dbgfs: Add adaptive_targets list check
 before enable monitor_on
To:     SeongJae Park <sj@kernel.org>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211020081233.28363-1-sj@kernel.org>
Message-ID: <666ac057-8382-d671-124a-cf34b1dad417@linux.alibaba.com>
Date:   Wed, 20 Oct 2021 16:15:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211020081233.28363-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/10/20 下午4:12, SeongJae Park wrote:
> On Wed, 20 Oct 2021 07:21:21 +0000 SeongJae Park <sj@kernel.org> wrote:
>
>> On Wed, 20 Oct 2021 09:42:33 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>>
>>> When the ctx->adaptive_targets list is empty,
>>> I did some test on monitor_on interface like this.
>>>
>>>      # echo > /sys/kernel/debug/damon/target_ids
>> Thanks for the change, but you missed writing 'on' to 'monitor_on' in the above
>> example.
Sorry.
>>
>>> Though the ctx->adaptive_targets list is empty, but the
>>> kthread_run still be called, and the kdamond.x thread still
>>> be created, this is meaningless.
>>>
>>> So there adds a judgment in 'dbgfs_monitor_on_write',
>>> if the ctx->adaptive_targets list is empty, return -EINVAL.
>>>
>>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> Other parts looks good to me.  However, seems this commit conflicts with a
>> patch[1] which already merged in -mm tree.  Could you please rebase this on it?
>> FYI, all DAMON patches that merged in -mm tree are also applied on DAMON
>> development tree.  So, you could get the patch applied tree by:
>>
>>      $ git remote add sj git://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git
>>      $ git fetch sj
>>      $ git checkout 0fa378d04b12
>>
>> [1] https://lore.kernel.org/linux-mm/20211014073014.35754-1-sj@kernel.org/
Ok, i will correct it.
>>
>>
>> Thanks,
>> SJ
>>
>>> ---
>>>   include/linux/damon.h |  1 +
>>>   mm/damon/core.c       |  5 +++++
>>>   mm/damon/dbgfs.c      | 13 ++++++++++---
>>>   3 files changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>>> index 715dadd21f7c..4fce5f1f6dad 100644
>>> --- a/include/linux/damon.h
>>> +++ b/include/linux/damon.h
>>> @@ -316,6 +316,7 @@ void damon_destroy_scheme(struct damos *s);
>>>
>>>   struct damon_target *damon_new_target(unsigned long id);
>>>   void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
>>> +bool damon_targets_empty(struct damon_ctx *ctx);
>>>   void damon_free_target(struct damon_target *t);
>>>   void damon_destroy_target(struct damon_target *t);
>>>   unsigned int damon_nr_regions(struct damon_target *t);
>>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>>> index 2f6785737902..c3a1374dbe0b 100644
>>> --- a/mm/damon/core.c
>>> +++ b/mm/damon/core.c
>>> @@ -156,6 +156,11 @@ void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
>>>   	list_add_tail(&t->list, &ctx->adaptive_targets);
>>>   }
>>>
>>> +bool damon_targets_empty(struct damon_ctx *ctx)
>>> +{
>>> +	return list_empty(&ctx->adaptive_targets);
>>> +}
>>> +
>>>   static void damon_del_target(struct damon_target *t)
>>>   {
>>>   	list_del(&t->list);
>>> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
>>> index 38188347d8ab..9dee29f7d103 100644
>>> --- a/mm/damon/dbgfs.c
>>> +++ b/mm/damon/dbgfs.c
>>> @@ -865,12 +865,19 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
>>>   		return -EINVAL;
>>>   	}
>>>
>>> -	if (!strncmp(kbuf, "on", count))
>>> +	if (!strncmp(kbuf, "on", count)) {
>>> +		int i;
>>> +
>>> +		for (i = 0; i < dbgfs_nr_ctxs; i++) {
>>> +			if (damon_targets_empty(dbgfs_ctxs[i]))
>>> +				return -EINVAL;
> Oops, I forgot that you should 'kfree(kbuf)' before returning here.  Please do
> that.
Okay,  i will correct it, thank you.
>
> Thanks,
> SJ
>
>>> +		}
>>>   		err = damon_start(dbgfs_ctxs, dbgfs_nr_ctxs);
>>> -	else if (!strncmp(kbuf, "off", count))
>>> +	} else if (!strncmp(kbuf, "off", count)) {
>>>   		err = damon_stop(dbgfs_ctxs, dbgfs_nr_ctxs);
>>> -	else
>>> +	} else {
>>>   		err = -EINVAL;
>>> +	}
>>>
>>>   	if (err)
>>>   		ret = err;
>>> --
>>> 2.31.0
>>
-- 
Best Regards!
Xin Hao

