Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BB3339350
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhCLQ0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:26:37 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48009 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhCLQ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:26:08 -0500
X-Originating-IP: 81.185.170.228
Received: from [192.168.43.237] (228.170.185.81.rev.sfr.net [81.185.170.228])
        (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 43254E0003;
        Fri, 12 Mar 2021 16:25:57 +0000 (UTC)
Subject: Re: [syzbot] BUG: unable to handle kernel access to user memory in
 schedule_tail
To:     Dmitry Vyukov <dvyukov@google.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
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
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <795597a1-ec87-e09e-d073-3daf10422abb@ghiti.fr>
Date:   Fri, 12 Mar 2021 11:25:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZsSRdQ5LzYMsgjrBAukgP-Vv8WSQsSoxguYjWvB1QnrA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 3/12/21 à 10:12 AM, Dmitry Vyukov a écrit :
> On Fri, Mar 12, 2021 at 2:50 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>
>> On 10/03/2021 17:16, Dmitry Vyukov wrote:
>>> On Wed, Mar 10, 2021 at 5:46 PM syzbot
>>> <syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    0d7588ab riscv: process: Fix no prototype for arch_dup_tas..
>>>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1212c6e6d00000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e3c595255fb2d136
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=e74b94fe601ab9552d69
>>>> userspace arch: riscv64
>>>>
>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>>
>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>> Reported-by: syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com
>>>
>>> +riscv maintainers
>>>
>>> This is riscv64-specific.
>>> I've seen similar crashes in put_user in other places. It looks like
>>> put_user crashes in the user address is not mapped/protected (?).
>>
>> I've been having a look, and this seems to be down to access of the
>> tsk->set_child_tid variable. I assume the fuzzing here is to pass a
>> bad address to clone?
>>
>>   From looking at the code, the put_user() code should have set the
>> relevant SR_SUM bit (the value for this, which is 1<<18 is in the
>> s2 register in the crash report) and from looking at the compiler
>> output from my gcc-10, the code looks to be dong the relevant csrs
>> and then csrc around the put_user
>>
>> So currently I do not understand how the above could have happened
>> over than something re-tried the code seqeunce and ended up retrying
>> the faulting instruction without the SR_SUM bit set.
> 
> I would maybe blame qemu for randomly resetting SR_SUM, but it's
> strange that 99% of these crashes are in schedule_tail. If it would be
> qemu, then they would be more evenly distributed...
> 
> Another observation: looking at a dozen of crash logs, in none of
> these cases fuzzer was actually trying to fuzz clone with some insane
> arguments. So it looks like completely normal clone's (e..g coming
> from pthread_create) result in this crash.
> 
> I also wonder why there is ret_from_exception, is it normal? I see
> handle_exception disables SR_SUM:

csrrc does the right thing: it cleans SR_SUM bit in status but saves the 
previous value that will get correctly restored.

("The CSRRC (Atomic Read and Clear Bits in CSR) instruction reads the 
value of the CSR, zero-extends the value to XLEN bits, and writes it to 
integer registerrd.  The initial value in integerregisterrs1is treated 
as a bit mask that specifies bit positions to be cleared in the CSR. Any 
bitthat is high inrs1will cause the corresponding bit to be cleared in 
the CSR, if that CSR bit iswritable.  Other bits in the CSR are 
unaffected.")

> https://elixir.bootlin.com/linux/v5.12-rc2/source/arch/riscv/kernel/entry.S#L73

Still no luck for the moment, can't reproduce it locally, my test is 
maybe not that good (I created threads all day long in order to trigger 
the put_user of schedule_tail).

Given that the path you mention works most of the time, and that the 
status register in the stack trace shows the SUM bit is not set whereas 
it is set in put_user, I'm leaning toward some race condition (maybe an 
interrupt that arrives at the "wrong" time) or a qemu issue as you 
mentioned.

To eliminate qemu issues, do you have access to some HW ? Or to 
different qemu versions ?


> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
