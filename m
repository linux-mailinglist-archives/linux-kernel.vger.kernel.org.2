Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A6B45A170
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhKWL3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:29:05 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:33264 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236111AbhKWL3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:29:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UxwD6l6_1637666752;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UxwD6l6_1637666752)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Nov 2021 19:25:53 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH V2 1/2] mm/damon/dbgfs: Modify Damon dbfs interface
 dependency in Kconfig
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211123103855.12592-1-sj@kernel.org>
Message-ID: <b6bd0063-efb2-62ce-53ee-0193f63262d8@linux.alibaba.com>
Date:   Tue, 23 Nov 2021 19:25:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123103855.12592-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Park:

On 11/23/21 6:38 PM, SeongJae Park wrote:
> On Sun, 21 Nov 2021 22:07:04 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> If you want to support "DAMON_DBGFS" in config file, it only depends on
>> any one of "DAMON_VADDR" and "DAMON_PADDR", and sometimes we just want to
>> use damon virtual address function, but it is unreasonable to include "DAMON_PADDR"
>> in config file which cause the damon/paddr.c be compiled, so there fix it.
> Seems the above lines are not well wrapped[1].
>
> [1] https://docs.kernel.org/process/submitting-patches.html?highlight=75#the-canonical-patch-format
>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   include/linux/damon.h | 12 ++++++++++++
>>   mm/damon/Kconfig      |  2 +-
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index 8a73e825e0d5..00ad96f2ec10 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -463,11 +463,23 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
>>   #ifdef CONFIG_DAMON_VADDR
>>   void damon_va_set_primitives(struct damon_ctx *ctx);
>>   bool damon_va_target_valid(void *t);
>> +#else
>> +static inline void damon_va_set_primitives(struct damon_ctx *ctx) {}
>> +static inline bool damon_va_target_valid(void *t)
>> +{
>> +	return false;
>> +}
>>   #endif	/* CONFIG_DAMON_VADDR */
>>   
>>   #ifdef CONFIG_DAMON_PADDR
>>   void damon_pa_set_primitives(struct damon_ctx *ctx);
>>   bool damon_pa_target_valid(void *t);
>> +#else
>> +static inline void damon_pa_set_primitives(struct damon_ctx *ctx) {}
>> +static inline bool damon_pa_target_valid(void *t)
>> +{
>> +	return false;
>> +}
>>   #endif	/* CONFIG_DAMON_PADDR */
>>   
>>   #endif	/* _DAMON_H */
>> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
>> index 5bcf05851ad0..971ffc496596 100644
>> --- a/mm/damon/Kconfig
>> +++ b/mm/damon/Kconfig
>> @@ -54,7 +54,7 @@ config DAMON_VADDR_KUNIT_TEST
>>   
>>   config DAMON_DBGFS
>>   	bool "DAMON debugfs interface"
>> -	depends on DAMON_VADDR && DAMON_PADDR && DEBUG_FS
>> +	depends on DAMON_VADDR || DAMON_PADDR && DEBUG_FS
> Due to the lack of parentheses, this allows enabling DAMON_DBGFS while DEBUG_FS
> is disabled.
>
> Sorry to say this but this makes me unsure if this patch is sufficiently
> tested.  I am also unsure if this patch is carefully handling all possible
> corner cases in appropriate ways.  For example, on kernels that doesn't having
> 'CONFIG_DAMON_PADDR=y', this patch would still make
> 'echo paddr > $debugfs/damon/target_ids' success.  Is that what you are
> intending?

Yes, you are all right, I have not tested as above, sorry, i did not 
fully consider the impact on the code after doing this,

Please ignore this patch.

> And, have you confirmed that will never make any issue, both in
> kernel space and the user space?  Could the behavioral change make the user
> space confused?
>
> Basically, reducing the dependency is a good idea.  But, IMHO, the benefit
> seems not so big.  After all, efficiency was not a first goal of DAMON debugfs
> interface.  That's why it is implemented on debugfs rather than its own
> specialized/optimized file system.  Better way for the efficiency of the user
> space interface might be inventing such DAMON's own efficient file system, like
> tracepoints had its interface on debugfs but now uses its own file system,
> tracefs.
>
> So, unless you make me believe the benefit is big enough and all possible
> corner cases are well handled and sufficiently tested, I'm sorry but I would
> not be convinced with this change.

I think it makes sense to separate PADDR & VADDR, users can freely 
choose dbfs + vaddr or dbfs + paddr;

Doing this can make the code look like it doesn’t mix together，i will 
continue to try to separate this part

of the code later.

>
>
> Thanks,
> SJ
>
>>   	help
>>   	  This builds the debugfs interface for DAMON.  The user space admins
>>   	  can use the interface for arbitrary data access monitoring.
>> -- 
>> 2.31.0

-- 
Best Regards!
Xin Hao

