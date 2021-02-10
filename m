Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B353169F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhBJPTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:19:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:52420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231984AbhBJPTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:19:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85C93AB98;
        Wed, 10 Feb 2021 15:18:50 +0000 (UTC)
To:     Milan Broz <gmazyland@gmail.com>, Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
References: <70885d37-62b7-748b-29df-9e94f3291736@gmail.com>
 <20210108134140.GA9883@dhcp22.suse.cz>
 <abb752ce-4447-74cb-dfbc-03af1b38edfc@gmail.com>
 <9474cd07-676a-56ed-1942-5090e0b9a82f@suse.cz>
 <e6f84b27-ed29-0fa4-e466-536b529c5720@gmail.com>
 <6eebb858-d517-b70d-9202-f4e84221ed89@suse.cz>
 <dfc3fe66-07ac-6aba-e10b-c940cdb01ec1@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Very slow unlockall()
Message-ID: <273db3a6-28b1-6605-1743-ef86e7eb2b72@suse.cz>
Date:   Wed, 10 Feb 2021 16:18:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <dfc3fe66-07ac-6aba-e10b-c940cdb01ec1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 8:19 PM, Milan Broz wrote:
> On 01/02/2021 19:55, Vlastimil Babka wrote:
>> On 2/1/21 7:00 PM, Milan Broz wrote:
>>> On 01/02/2021 14:08, Vlastimil Babka wrote:
>>>> On 1/8/21 3:39 PM, Milan Broz wrote:
>>>>> On 08/01/2021 14:41, Michal Hocko wrote:
>>>>>> On Wed 06-01-21 16:20:15, Milan Broz wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> we use mlockall(MCL_CURRENT | MCL_FUTURE) / munlockall() in cryptsetup code
>>>>>>> and someone tried to use it with hardened memory allocator library.
>>>>>>>
>>>>>>> Execution time was increased to extreme (minutes) and as we found, the problem
>>>>>>> is in munlockall().
>>>>>>>
>>>>>>> Here is a plain reproducer for the core without any external code - it takes
>>>>>>> unlocking on Fedora rawhide kernel more than 30 seconds!
>>>>>>> I can reproduce it on 5.10 kernels and Linus' git.
>>>>>>>
>>>>>>> The reproducer below tries to mmap large amount memory with PROT_NONE (later never used).
>>>>>>> The real code of course does something more useful but the problem is the same.
>>>>>>>
>>>>>>> #include <stdio.h>
>>>>>>> #include <stdlib.h>
>>>>>>> #include <fcntl.h>
>>>>>>> #include <sys/mman.h>
>>>>>>>
>>>>>>> int main (int argc, char *argv[])
>>>>>>> {
>>>>>>>         void *p  = mmap(NULL, 1UL << 41, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> 
>> So, this is 2TB memory area, but PROT_NONE means it's never actually populated,
>> although mlockall(MCL_CURRENT) should do that. Once you put PROT_READ |
>> PROT_WRITE there, the mlockall() starts taking ages.
>> 
>> So does that reflect your use case? munlockall() with large PROT_NONE areas? If
>> so, munlock_vma_pages_range() is indeed not optimized for that, but I would
>> expect such scenario to be uncommon, so better clarify first.
> 
> It is just a simple reproducer of the underlying problem, as suggested here 
> https://gitlab.com/cryptsetup/cryptsetup/-/issues/617#note_478342301
> 
> We use mlockall() in cryptsetup and with hardened malloc it slows down unlock significantly.
> (For the real case problem please read the whole issue report above.)

OK, finally read through the bug report, and learned two things:

1) the PROT_NONE is indeed intentional part of the reproducer
2) Linux mailing lists still have a bad reputation and people avoid them. That's
sad :( Well, thanks for overcoming that :)

Daniel there says "I think the Linux kernel implementation of mlockall is quite
broken and tries to lock all the reserved PROT_NONE regions in advance which
doesn't make any sense."

From my testing this doesn't seem to be the case, as the mlockall() part is very
fast, so I don't think it faults in and mlocks PROT_NONE areas. It only starts
to be slow when changed to PROT_READ|PROT_WRITE. But the munlockall() part is
slow even with PROT_NONE as we don't skip the PROT_NONE areas there. We probably
can't just skip them, as they might actually contain mlocked pages if those were
faulted first with PROT_READ/PROT_WRITE and only then changed to PROT_NONE.

And the munlock (munlock_vma_pages_range()) is slow, because it uses
follow_page_mask() in a loop incrementing addresses by PAGE_SIZE, so that's
always traversing all levels of page tables from scratch. Funnily enough,
speeding this up was my first linux-mm series years ago. But the speedup only
works if pte's are present, which is not the case for unpopulated PROT_NONE
areas. That use case was unexpected back then. We should probably convert this
code to a proper page table walk. If there are large areas with unpopulated pmd
entries (or even higher levels) we would traverse them very quickly.

