Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0334230AFDD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhBAS4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:56:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:53786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232025AbhBAS4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:56:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61363ABD6;
        Mon,  1 Feb 2021 18:55:24 +0000 (UTC)
To:     Milan Broz <gmazyland@gmail.com>, Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
References: <70885d37-62b7-748b-29df-9e94f3291736@gmail.com>
 <20210108134140.GA9883@dhcp22.suse.cz>
 <abb752ce-4447-74cb-dfbc-03af1b38edfc@gmail.com>
 <9474cd07-676a-56ed-1942-5090e0b9a82f@suse.cz>
 <e6f84b27-ed29-0fa4-e466-536b529c5720@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Very slow unlockall()
Message-ID: <6eebb858-d517-b70d-9202-f4e84221ed89@suse.cz>
Date:   Mon, 1 Feb 2021 19:55:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <e6f84b27-ed29-0fa4-e466-536b529c5720@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 7:00 PM, Milan Broz wrote:
> On 01/02/2021 14:08, Vlastimil Babka wrote:
>> On 1/8/21 3:39 PM, Milan Broz wrote:
>>> On 08/01/2021 14:41, Michal Hocko wrote:
>>>> On Wed 06-01-21 16:20:15, Milan Broz wrote:
>>>>> Hi,
>>>>>
>>>>> we use mlockall(MCL_CURRENT | MCL_FUTURE) / munlockall() in cryptsetup code
>>>>> and someone tried to use it with hardened memory allocator library.
>>>>>
>>>>> Execution time was increased to extreme (minutes) and as we found, the problem
>>>>> is in munlockall().
>>>>>
>>>>> Here is a plain reproducer for the core without any external code - it takes
>>>>> unlocking on Fedora rawhide kernel more than 30 seconds!
>>>>> I can reproduce it on 5.10 kernels and Linus' git.
>>>>>
>>>>> The reproducer below tries to mmap large amount memory with PROT_NONE (later never used).
>>>>> The real code of course does something more useful but the problem is the same.
>>>>>
>>>>> #include <stdio.h>
>>>>> #include <stdlib.h>
>>>>> #include <fcntl.h>
>>>>> #include <sys/mman.h>
>>>>>
>>>>> int main (int argc, char *argv[])
>>>>> {
>>>>>         void *p  = mmap(NULL, 1UL << 41, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

So, this is 2TB memory area, but PROT_NONE means it's never actually populated,
although mlockall(MCL_CURRENT) should do that. Once you put PROT_READ |
PROT_WRITE there, the mlockall() starts taking ages.

So does that reflect your use case? munlockall() with large PROT_NONE areas? If
so, munlock_vma_pages_range() is indeed not optimized for that, but I would
expect such scenario to be uncommon, so better clarify first.

>>>>>
>>>>>         if (p == MAP_FAILED) return 1;
>>>>>
>>>>>         if (mlockall(MCL_CURRENT | MCL_FUTURE)) return 1;
>>>>>         printf("locked\n");
>>>>>
>>>>>         if (munlockall()) return 1;
>>>>>         printf("unlocked\n");
>>>>>
>>>>>         return 0;
>>>>> }
> 
> ...
> 
>>> Today's Linus git - 5.11.0-rc2+ in my testing x86_64 VM (no extensive kernel debug options):
>>>
>>> # time ./lock
>>> locked
>>> unlocked
>>>
>>> real    0m4.172s
>>> user    0m0.000s
>>> sys     0m4.172s
>> 
>> The perf report would be more interesting from this configuration.
> 
> ok, I cannot run perf on that particular VM but tried the latest Fedora stable
> kernel without debug options  - 5.10.12-200.fc33.x86_64
> 
> This is the report running reproducer above:
> 
> time:
> real    0m6.123s
> user    0m0.099s
> sys     0m5.310s
> 
> perf:
> 
> # Total Lost Samples: 0
> #
> # Samples: 20K of event 'cycles'
> # Event count (approx.): 20397603279
> #
> # Overhead  Command  Shared Object      Symbol                      
> # ........  .......  .................  ............................
> #
>     47.26%  lock     [kernel.kallsyms]  [k] follow_page_mask
>     20.43%  lock     [kernel.kallsyms]  [k] munlock_vma_pages_range
>     15.92%  lock     [kernel.kallsyms]  [k] follow_page
>      7.40%  lock     [kernel.kallsyms]  [k] rcu_all_qs
>      5.87%  lock     [kernel.kallsyms]  [k] _cond_resched
>      3.08%  lock     [kernel.kallsyms]  [k] follow_huge_addr
>      0.01%  lock     [kernel.kallsyms]  [k] __update_load_avg_cfs_rq
>      0.01%  lock     [kernel.kallsyms]  [k] ____fput
>      0.01%  lock     [kernel.kallsyms]  [k] rmap_walk_file
>      0.00%  lock     [kernel.kallsyms]  [k] page_mapped
>      0.00%  lock     [kernel.kallsyms]  [k] native_irq_return_iret
>      0.00%  lock     [kernel.kallsyms]  [k] _raw_spin_lock_irq
>      0.00%  lock     [kernel.kallsyms]  [k] perf_iterate_ctx
>      0.00%  lock     [kernel.kallsyms]  [k] finish_task_switch
>      0.00%  perf     [kernel.kallsyms]  [k] native_sched_clock
>      0.00%  lock     [kernel.kallsyms]  [k] native_write_msr
>      0.00%  perf     [kernel.kallsyms]  [k] native_write_msr
> 
> 
> m.
> 

