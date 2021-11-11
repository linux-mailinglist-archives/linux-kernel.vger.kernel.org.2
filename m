Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B79644D958
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 16:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhKKPrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 10:47:17 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:42950 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233870AbhKKPrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 10:47:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uw3iC5R_1636645462;
Received: from B-X3VXMD6M-2058.lan(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Uw3iC5R_1636645462)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Nov 2021 23:44:22 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH V2 0/4] mm/damon: Do some small changes
To:     SeongJae Park <sj@kernel.org>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211111092440.11576-1-sj@kernel.org>
Message-ID: <1a2e1816-70d1-c463-9133-eeb8108daac1@linux.alibaba.com>
Date:   Thu, 11 Nov 2021 23:44:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211111092440.11576-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Park:

On 2021/11/11 下午5:24, SeongJae Park wrote:
> Hello Xin,
>
> On Thu, 11 Nov 2021 14:07:00 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> These four patches are mainly to do some small changes.
>>
>> V1 -> V2
>> 	Add reviewed by SeongJae Park
>> 	Add two new patches
>> V1:
>> https://lore.kernel.org/linux-mm/cover.1636546262.git.xhao@linux.alibaba.com/
>>
>>
>> Xin Hao (4):
>>    mm/damon: Unified access_check function naming rules
>>    mm/damon: Add 'age' of region tracepoint support
>>    mm/damon/core: Using function abs() instead of diff_of()
>>    mm/damon: Remove some no need func definitions in damon.h file
> Overall, all patches looks good to me, though I asked[1] a trivial change in
> the commit message of the second patch.
Ok,  I will add a detail message to explain it in commit in my next 
patch, thanks.
>
> Also, I found one interesting thing.  It seems you are wrapping body of the
> commit messages at <75 columns[2]?  That's obviously neither a problem, nor
> even trivial nit.  But... I'd prefer the messages look more consistent with
> others.
Thank you very much for your careful correction,  I will fix it in my 
next patch too.
>
> [1] https://lore.kernel.org/linux-mm/20211111082034.13323-1-sj@kernel.org/
> [2] https://docs.kernel.org/process/submitting-patches.html?highlight=75#the-canonical-patch-format
>
>
> Thanks,
> SJ
>
>>   include/linux/damon.h        | 25 ++-----------------------
>>   include/trace/events/damon.h |  7 +++++--
>>   mm/damon/core.c              |  6 ++----
>>   mm/damon/vaddr.c             |  8 ++++----
>>   4 files changed, 13 insertions(+), 33 deletions(-)
>>
>> --
>> 2.31.0

-- 
Best Regards!
Xin Hao

