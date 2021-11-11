Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8EF44D337
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhKKIcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:32:17 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:35886 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231675AbhKKIcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:32:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uw0LiUY_1636619363;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Uw0LiUY_1636619363)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Nov 2021 16:29:24 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH V1 2/2] mm/damon: Add 'age' of region tracepoint support
To:     SeongJae Park <sj@kernel.org>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211111082034.13323-1-sj@kernel.org>
Message-ID: <929062d1-7e6f-4426-9ffc-b5d2b124f1ad@linux.alibaba.com>
Date:   Thu, 11 Nov 2021 16:29:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211111082034.13323-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Park:

On 2021/11/11 下午4:20, SeongJae Park wrote:
> On Thu, 11 Nov 2021 10:04:38 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> [-- Attachment #1: Type: text/plain, Size: 8070 bytes --]
>>
>> Hi Park:
>>
>> On 2021/11/10 下午9:16, SeongJae Park wrote:
>>> On Wed, 10 Nov 2021 20:13:14 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>>>
>>>> In patch "mm/damon: add a tracepoint", it adds a
>>>> tracepoint for DAMON, it can monitor each region
>>>> for each aggregation interval, Now the region add
>>>> a new 'age' variable, some primitive would calculate
>>>> the priority of each region as a weight, there put it
>>>> into tracepoint, so we can easily track the change of
>>>> its value through perf or damon-tools.
>>> DAMON calculates the age using the address range and nr_accesses of the region,
>>> which are already in the tracepoint.  In other words, user space can calculate
>>> the age on their own.  Therefore I thought putting age in the tracepoint as
>>> adding unnecessary information, at the moment of the implementation.
>>>
>>> Of course, I would missing some use cases that need this information in the
>>> tracepoint.  Furthermore, adding just one more value in the tracepoint wouldn't
>>> incur a real issue.  But, I'd like to know why this is necessary and how much
>>> benefit it provides.  Xin, could you please share that?
>> I think these two variables nr_access &  age have different meanings,
>> the nr_access only reflect the
>>
>> period of  sample_interval,  We may be able to get the change of age
>> through continuous long-term sampling,
>>
>> But I think this is not very convenient.
>>
>> We only need to observe the change of age value a small number of times
>> to replace the continue sampling of the region.
>>
>> For example, age has been increasing to 141, but nr_access shows a value
>> of 0 at a certain time. Through this，we can
>>
>> conclude that the region has a very low nr_access value for a long time.
> I understand that you don't want to record all the traces and then process the
> huge trace data in user space in order to get the age information, because you
> want to save disk space and CPU cycles.  Is that correct?  If so, I think that
> makes sense, and it would be better to put that in the commit message.

Yes, What you said is absolutely correct, that's how I thought about it, 
I will add this part of the

information to the commit，thanks!

>
>
> Thanks,
> SJ
>
> [...]

-- 
Best Regards!
Xin Hao

