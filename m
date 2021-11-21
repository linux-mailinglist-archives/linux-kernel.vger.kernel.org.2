Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608BD4583C9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 14:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbhKUNXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 08:23:06 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:35138 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236405AbhKUNXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 08:23:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UxW0YE6_1637500797;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UxW0YE6_1637500797)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 21 Nov 2021 21:19:58 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH V1 1/2] mm/damon/dbgfs: Modify Damon dbfs interface
 dependency in Kconfig
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211121112417.33255-1-sj@kernel.org>
Message-ID: <32a90a3d-5cf6-66cc-fa3b-19753a057052@linux.alibaba.com>
Date:   Sun, 21 Nov 2021 21:19:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211121112417.33255-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Park,

On 11/21/21 7:24 PM, SeongJae Park wrote:
> Hi Xin,
>
> On Sun, 21 Nov 2021 01:27:53 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> If you want to support "DAMON_DBGFS" in config file, it only depends on
>> any one of "DAMON_VADDR" and "DAMON_PADDR".
> This is not true.  DAMON_DBGFS really depends on both.
>
> This patch even makes the build fails with some configs.
>
>        CC      mm/damon/dbgfs.o
>      linux/mm/damon/dbgfs.c: In function ‘dbgfs_target_ids_write’:
>      linux/mm/damon/dbgfs.c:409:3: error: implicit declaration of function ‘damon_pa_set_primitives’; did you mean ‘damon_va_set_primitives’? [-Werror=implicit-function-declaration]
>         damon_pa_set_primitives(ctx);
>         ^~~~~~~~~~~~~~~~~~~~~~~
>         damon_va_set_primitives
>      cc1: some warnings being treated as errors

That is my fault,  i have found a solution, and i will send a v2 patch 
to solve it,  i I think DAMON_VADDR and DAMON_PADDR

must be decoupled，the kconfig must support it, becasue sometimes i don't 
want to use damon paddr function, just only need to include

DAMON_VADDR, therefore, it is not necessary to include damon/paddr.c 
during compile time.

>
>
> Thanks,
> SJ
>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   mm/damon/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
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
>>   	help
>>   	  This builds the debugfs interface for DAMON.  The user space admins
>>   	  can use the interface for arbitrary data access monitoring.
>> -- 
>> 2.31.0
>>
>>
-- 
Best Regards!
Xin Hao

