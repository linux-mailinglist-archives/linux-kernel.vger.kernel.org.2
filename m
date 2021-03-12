Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C463339386
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhCLQhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:37:20 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:44584 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231789AbhCLQhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:37:01 -0500
Received: from cpc79921-stkp12-2-0-cust288.10-2.cable.virginm.net ([86.16.139.33] helo=[192.168.0.18])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1lKkmR-0002cL-MC; Fri, 12 Mar 2021 16:36:51 +0000
Subject: Re: [syzbot] BUG: unable to handle kernel access to user memory in
 schedule_tail
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Benjamin Segall <bsegall@google.com>, dietmar.eggemann@arm.com,
        Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <000000000000b74f1b05bd316729@google.com>
 <CACT4Y+ZHMYijYAkeLMX=p9jx6pBivJz06h_1rGt-k9=AgfkWQg@mail.gmail.com>
 <84b0471d-42c1-175f-ae1d-a18c310c7f77@codethink.co.uk>
 <CACT4Y+ZsSRdQ5LzYMsgjrBAukgP-Vv8WSQsSoxguYjWvB1QnrA@mail.gmail.com>
 <aa801bc7-cf6f-b77a-bbb0-28b0ff36e8ba@codethink.co.uk>
 <816870e9-9354-ffbd-936b-40e38e4276a4@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <4ce57c7e-6e5d-d136-0a81-395a4207ba44@codethink.co.uk>
Date:   Fri, 12 Mar 2021 16:36:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <816870e9-9354-ffbd-936b-40e38e4276a4@codethink.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2021 16:34, Ben Dooks wrote:
> On 12/03/2021 16:30, Ben Dooks wrote:
>> On 12/03/2021 15:12, Dmitry Vyukov wrote:
>>> On Fri, Mar 12, 2021 at 2:50 PM Ben Dooks <ben.dooks@codethink.co.uk> 
>>> wrote:
>>>>
>>>> On 10/03/2021 17:16, Dmitry Vyukov wrote:
>>>>> On Wed, Mar 10, 2021 at 5:46 PM syzbot
>>>>> <syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com> wrote:
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> syzbot found the following issue on:
>>>>>>
>>>>>> HEAD commit:    0d7588ab riscv: process: Fix no prototype for 
>>>>>> arch_dup_tas..
>>>>>> git tree: 
>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
>>>>>> console output: 
>>>>>> https://syzkaller.appspot.com/x/log.txt?x=1212c6e6d00000
>>>>>> kernel config: 
>>>>>> https://syzkaller.appspot.com/x/.config?x=e3c595255fb2d136
>>>>>> dashboard link: 
>>>>>> https://syzkaller.appspot.com/bug?extid=e74b94fe601ab9552d69
>>>>>> userspace arch: riscv64
>>>>>>
>>>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>>>>
>>>>>> IMPORTANT: if you fix the issue, please add the following tag to 
>>>>>> the commit:
>>>>>> Reported-by: syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com
>>>>>
>>>>> +riscv maintainers
>>>>>
>>>>> This is riscv64-specific.
>>>>> I've seen similar crashes in put_user in other places. It looks like
>>>>> put_user crashes in the user address is not mapped/protected (?).
>>>>
>>>> I've been having a look, and this seems to be down to access of the
>>>> tsk->set_child_tid variable. I assume the fuzzing here is to pass a
>>>> bad address to clone?
>>>>
>>>>   From looking at the code, the put_user() code should have set the
>>>> relevant SR_SUM bit (the value for this, which is 1<<18 is in the
>>>> s2 register in the crash report) and from looking at the compiler
>>>> output from my gcc-10, the code looks to be dong the relevant csrs
>>>> and then csrc around the put_user
>>>>
>>>> So currently I do not understand how the above could have happened
>>>> over than something re-tried the code seqeunce and ended up retrying
>>>> the faulting instruction without the SR_SUM bit set.
>>>
>>> I would maybe blame qemu for randomly resetting SR_SUM, but it's
>>> strange that 99% of these crashes are in schedule_tail. If it would be
>>> qemu, then they would be more evenly distributed...
>>>
>>> Another observation: looking at a dozen of crash logs, in none of
>>> these cases fuzzer was actually trying to fuzz clone with some insane
>>> arguments. So it looks like completely normal clone's (e..g coming
>>> from pthread_create) result in this crash.
>>>
>>> I also wonder why there is ret_from_exception, is it normal? I see
>>> handle_exception disables SR_SUM:
>>> https://elixir.bootlin.com/linux/v5.12-rc2/source/arch/riscv/kernel/entry.S#L73 
>>>
>>
>> So I think if SR_SUM is set, then it faults the access to user memory
>> which the _user() routines clear to allow them access.
>>
>> I'm thinking there is at least one issue here:
>>
>> - the test in fault is the wrong way around for die kernel
>> - the handler only catches this if the page has yet to be mapped.
>>
>> So I think the test should be:
>>
>>          if (!user_mode(regs) && addr < TASK_SIZE &&
>>                          unlikely(regs->status & SR_SUM)
>>
>> This then should continue on and allow the rest of the handler to
>> complete mapping the page if it is not there.
>>
>> I have been trying to create a very simple clone test, but so far it
>> has yet to actually trigger anything.
> 
> I should have added there doesn't seem to be a good way to use mmap()
> to allocate memory but not insert a vm-mapping post the mmap().
> 
> 

How difficult is it to try building a branch with the above test
modified?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
