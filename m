Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A88C30A857
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhBANJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:09:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:56618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231197AbhBANJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:09:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5EC34B115;
        Mon,  1 Feb 2021 13:08:47 +0000 (UTC)
Subject: Re: Very slow unlockall()
To:     Milan Broz <gmazyland@gmail.com>, Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
References: <70885d37-62b7-748b-29df-9e94f3291736@gmail.com>
 <20210108134140.GA9883@dhcp22.suse.cz>
 <abb752ce-4447-74cb-dfbc-03af1b38edfc@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9474cd07-676a-56ed-1942-5090e0b9a82f@suse.cz>
Date:   Mon, 1 Feb 2021 14:08:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <abb752ce-4447-74cb-dfbc-03af1b38edfc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/21 3:39 PM, Milan Broz wrote:
> On 08/01/2021 14:41, Michal Hocko wrote:
>> On Wed 06-01-21 16:20:15, Milan Broz wrote:
>>> Hi,
>>>
>>> we use mlockall(MCL_CURRENT | MCL_FUTURE) / munlockall() in cryptsetup code
>>> and someone tried to use it with hardened memory allocator library.
>>>
>>> Execution time was increased to extreme (minutes) and as we found, the problem
>>> is in munlockall().
>>>
>>> Here is a plain reproducer for the core without any external code - it takes
>>> unlocking on Fedora rawhide kernel more than 30 seconds!
>>> I can reproduce it on 5.10 kernels and Linus' git.
>>>
>>> The reproducer below tries to mmap large amount memory with PROT_NONE (later never used).
>>> The real code of course does something more useful but the problem is the same.
>>>
>>> #include <stdio.h>
>>> #include <stdlib.h>
>>> #include <fcntl.h>
>>> #include <sys/mman.h>
>>>
>>> int main (int argc, char *argv[])
>>> {
>>>         void *p  = mmap(NULL, 1UL << 41, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>>
>>>         if (p == MAP_FAILED) return 1;
>>>
>>>         if (mlockall(MCL_CURRENT | MCL_FUTURE)) return 1;
>>>         printf("locked\n");
>>>
>>>         if (munlockall()) return 1;
>>>         printf("unlocked\n");
>>>
>>>         return 0;
>>> }
>>>
>>> In traceback I see that time is spent in munlock_vma_pages_range.
>>>
>>> [ 2962.006813] Call Trace:
>>> [ 2962.006814]  ? munlock_vma_pages_range+0xe7/0x4b0
>>> [ 2962.006814]  ? vma_merge+0xf3/0x3c0
>>> [ 2962.006815]  ? mlock_fixup+0x111/0x190
>>> [ 2962.006815]  ? apply_mlockall_flags+0xa7/0x110
>>> [ 2962.006816]  ? __do_sys_munlockall+0x2e/0x60
>>> [ 2962.006816]  ? do_syscall_64+0x33/0x40
>>> ...
>>>
>>> Or with perf, I see
>>>
>>> # Overhead  Command  Shared Object      Symbol                               
>>> # ........  .......  .................  .....................................
>>> #
>>>     48.18%  lock     [kernel.kallsyms]  [k] lock_is_held_type
>>>     11.67%  lock     [kernel.kallsyms]  [k] ___might_sleep
>>>     10.65%  lock     [kernel.kallsyms]  [k] follow_page_mask
>>>      9.17%  lock     [kernel.kallsyms]  [k] debug_lockdep_rcu_enabled
>>>      6.73%  lock     [kernel.kallsyms]  [k] munlock_vma_pages_range
>>> ...

This seems to be from the debug kernel, as there's lockdep enabled. That's
expected to be very slow.

>>>
>>> Could please anyone check what's wrong here with the memory locking code?
>>> Running it on my notebook I can effectively DoS the system :)
>>>
>>> Original report is https://gitlab.com/cryptsetup/cryptsetup/-/issues/617
>>> but this is apparently a kernel issue, just amplified by usage of munlockall().
>> 
>> Which kernel version do you see this with? Have older releases worked
>> better?
> 
> Hi,
> 
> I tried 5.10 stable and randomly few kernels I have built on testing VM (5.3 was the oldest),
> it seems to be very similar run time, so the problem is apparently old...(I can test some specific kernel version if it make any sense).
> 
> For mainline (reproducer above):
> 
> With 5.11.0-0.rc2.20210106git36bbbd0e234d.117.fc34.x86_64 (latest Fedora rawhide kernel build - many debug options are on)

From that, the amount of debugging seems to be rather excessive in the Fedora
rawhide kernel. Is that a special debug flavour?

> # time ./lock 
> locked
> unlocked
> 
> real    0m32.287s
> user    0m0.001s
> sys     0m32.126s
> 
> 
> Today's Linus git - 5.11.0-rc2+ in my testing x86_64 VM (no extensive kernel debug options):
> 
> # time ./lock
> locked
> unlocked
> 
> real    0m4.172s
> user    0m0.000s
> sys     0m4.172s

The perf report would be more interesting from this configuration.

> m.
> 

