Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48EA447F50
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 13:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239420AbhKHMM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:12:28 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14726 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238155AbhKHMM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:12:26 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HnqcH1PwQzZcsj;
        Mon,  8 Nov 2021 20:07:27 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 8 Nov 2021 20:09:38 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 8 Nov
 2021 20:09:38 +0800
Subject: Re: DAMON: problems when running DAMON on ARM64 with
 'transparent_hugepage' enabled
To:     SeongJae Park <sj@kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211105135748.32729-1-sj@kernel.org>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <a2fb10bd-b44a-350e-f693-82ecfa6f54a8@huawei.com>
Date:   Mon, 8 Nov 2021 20:09:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20211105135748.32729-1-sj@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SeongJae,

Thanks for your reply !

On 2021/11/5 21:57, SeongJae Park wrote:
> Hi Xiongfeng,
> 
> On Wed, 27 Oct 2021 08:06:36 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
>> Hello Xiongfeng,
>>
>> On Wed, 27 Oct 2021 14:14:57 +0800 Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
>>
>>> Sorry, I forgot to Cc the maillist. Cc it in this mail.
>>>
>>> On 2021/10/27 10:19, Xiongfeng Wang wrote:
>>>> Hi SeongJae,
>>>>
>>>> Sorry to disturb you. It's just that I came across some problems when running
>>>> DAMON, but still didn't find the solution after several days.
>>
>> You're not disturbing but helping me!  Please don't say so! :)
>>
>>>>
>>>> A short description is that the result of DAMON is not as expected when running
>>>> on ARM64 with 'transparent_hugepage' enabled. But the result is correct when
>>>> 'transparent_hugepage' is disabled.
>>>>
>>>> The following are the steps I came across the problems.
>>>> 1. Firstly, I use 'damo record' to sample the 'stairs' demo.
>>>>   damo record "./masim ./configs/stairs.cfg"
>>>> 2. Then I use 'damo report' to show the results.
>>>>   damo report heats --address_range xxx  xxx  --time_range xxx xxx    --heatmap
>>>> stdout    --stdout_heatmap_color emotion
>>>> The result doesn't show like a stair. I wrote a userspace demo to access a
>>>> certain address range in loop and use DAMON to sample the demo. I added
>>>> trace_print in 'damon_va_check_access()' and found out the pages in the address
>>>> range are not always detected as accessed, which is not expected. When I disable
>>>> transparent_hugepage by chance, the pages are marked as accessed. Then I test
>>>> the 'stairs' demo again, the result is correct. It seems that, only when
>>>> transparent_hugepage' is disabled, the access check works. I don't know where
>>>> the bug is, the software or the hardware ? Appreciate it if you have time to
>>>> reply. Thanks !
>>
>> Thank you for this report!  I have a theory, but would like to test first.
>> Will check and get back to you soon.
> 
> Sorry for late response.  I also confirmed the issue is reproducible on my
> ARM64 test machine.  My theory is, enabling THP reduced page table walks, and
> therefore the PTE Accessed bits are not frequently updated.  To verify this, I
> made below experimental change.  After applying the change on my test machine,
> I was able to show the expected access pattern regardless of THP enablement.
> 
>     --- a/mm/damon/vaddr.c
>     +++ b/mm/damon/vaddr.c
>     @@ -429,6 +429,7 @@ void damon_va_prepare_access_checks(struct damon_ctx *ctx)
>                             continue;
>                     damon_for_each_region(r, t)
>                             damon_va_prepare_access_check(ctx, mm, r);
>     +               flush_tlb_mm(mm);
>                     mmput(mm);
>             }
>      }
> 
> Could you please test this on your machine and let me know the result?

Yes, it works. After I add 'flush_tlb_mm()' as above, the result is as expected.

> 
> Again, please note that this change is only for proof of the theory, rather
> than the complete fix.

Thanks for let me know. I will wait for the official version.

Thanks,
Xiongfeng

> 
> 
> Thanks,
> SJ
> 
>>
>>
>> Thanks,
>> SJ
>>
>>>>
>>>> Thanks,
>>>> Xiongfeng
> .
> 
