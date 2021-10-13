Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CB742C660
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbhJMQ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:29:22 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:59368 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236782AbhJMQ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:29:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uri79JY_1634142428;
Received: from 30.30.71.190(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0Uri79JY_1634142428)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Oct 2021 00:27:09 +0800
Message-ID: <b503abb8-90dc-fe38-909b-5a4156c170d9@linux.alibaba.com>
Date:   Thu, 14 Oct 2021 00:27:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:93.0)
 Gecko/20100101 Thunderbird/93.0
Subject: Re: [PATCH] mm/damon/dbgfs: remove unnecessary variables
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <20211013150413.23027-1-sj@kernel.org>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <20211013150413.23027-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/21 11:04 PM, SeongJae Park wrote:
> Hi Rongwei,
> 
> 
> Thank you for this patch!  Looks good to me overall.  I left a couple of
> nitpicks below, though.
> 
> On Wed, 13 Oct 2021 21:09:01 +0800 Rongwei Wang <rongwei.wang@linux.alibaba.com> wrote:
> 
> [...]
>> @@ -352,7 +350,7 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
>>   
>>   	nrs = kbuf;
>>   
>> -	targets = str_to_target_ids(nrs, ret, &nr_targets);
>> +	targets = str_to_target_ids(nrs, count, &nr_targets);
>>   	if (!targets) {
>>   		ret = -ENOMEM;
>>   		goto out;
>> @@ -378,12 +376,12 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
>>   		goto unlock_out;
>>   	}
>>   
>> -	err = damon_set_targets(ctx, targets, nr_targets);
>> -	if (err) {
>> +	ret = damon_set_targets(ctx, targets, nr_targets);
>> +	if (ret < 0) {
> 
> I'd prefer 'if (ret) {', to be consistent with other part.
Hi

In fact, explicit style, such as 'if (ret < 0)', may be more 
understandable. But I agree with your advice that to be consistent
with other part. And I will update it like your said.
> 
>>   		if (targetid_is_pid(ctx))
>>   			dbgfs_put_pids(targets, nr_targets);
>> -		ret = err;
>> -	}
>> +	} else
>> +		ret = count;
> 
> I'd prefer this to have braces:
> https://docs.kernel.org/process/coding-style.html#placing-braces-and-spaces
Agree! I will update here.

Thanks!
> 
>>   
>>   unlock_out:
>>   	mutex_unlock(&ctx->kdamond_lock);
>> @@ -548,8 +546,7 @@ static ssize_t dbgfs_mk_context_write(struct file *file,
> [...]
> 
> 
> Thanks,
> SJ
> 
