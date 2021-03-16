Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7336033D32C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbhCPLgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:36:39 -0400
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:33810 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbhCPLgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:36:20 -0400
Received: from [167.98.27.226] (helo=[10.35.5.170])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1lM7zG-0007TI-U9; Tue, 16 Mar 2021 11:35:46 +0000
Subject: Re: [syzbot] BUG: unable to handle kernel access to user memory in
 schedule_tail
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alex Ghiti <alex@ghiti.fr>,
        syzbot <syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com>,
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
 <795597a1-ec87-e09e-d073-3daf10422abb@ghiti.fr>
 <f9318e58-5d3f-f548-3dbf-a5cb87406a94@codethink.co.uk>
 <CACT4Y+bYDU-4MYotLfqgkGpz487aC8xQ0dqaNLwf76d1yyF-Vw@mail.gmail.com>
 <12d4137e-6c14-bc41-4bbc-955ce46198d2@codethink.co.uk>
 <CACT4Y+ZnPS8e5c7HHMbRCDQSi+y1z0Rm3a89ev7NvLWcRKzu9A@mail.gmail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <8ebea51d-b03c-e6de-fa1c-d47091c54e45@codethink.co.uk>
Date:   Tue, 16 Mar 2021 11:35:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZnPS8e5c7HHMbRCDQSi+y1z0Rm3a89ev7NvLWcRKzu9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2021 08:52, Dmitry Vyukov wrote:
> On Mon, Mar 15, 2021 at 10:38 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>
>> On 13/03/2021 07:20, Dmitry Vyukov wrote:
>>> On Fri, Mar 12, 2021 at 9:12 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>>>
>>>> On 12/03/2021 16:25, Alex Ghiti wrote:
>>>>>
>>>>>
>>>>> Le 3/12/21 à 10:12 AM, Dmitry Vyukov a écrit :
>>>>>> On Fri, Mar 12, 2021 at 2:50 PM Ben Dooks <ben.dooks@codethink.co.uk>
>>>>>> wrote:
>>>>>>>
>>>>>>> On 10/03/2021 17:16, Dmitry Vyukov wrote:
>>>>>>>> On Wed, Mar 10, 2021 at 5:46 PM syzbot
>>>>>>>> <syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com> wrote:
>>>>>>>>>
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>> syzbot found the following issue on:
>>>>>>>>>
>>>>>>>>> HEAD commit:    0d7588ab riscv: process: Fix no prototype for
>>>>>>>>> arch_dup_tas..
>>>>>>>>> git tree:
>>>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
>>>>>>>>> console output:
>>>>>>>>> https://syzkaller.appspot.com/x/log.txt?x=1212c6e6d00000
>>>>>>>>> kernel config:
>>>>>>>>> https://syzkaller.appspot.com/x/.config?x=e3c595255fb2d136
>>>>>>>>> dashboard link:
>>>>>>>>> https://syzkaller.appspot.com/bug?extid=e74b94fe601ab9552d69
>>>>>>>>> userspace arch: riscv64
>>>>>>>>>
>>>>>>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>>>>>>>
>>>>>>>>> IMPORTANT: if you fix the issue, please add the following tag to
>>>>>>>>> the commit:
>>>>>>>>> Reported-by: syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com
>>>>>>>>
>>>>>>>> +riscv maintainers
>>>>>>>>
>>>>>>>> This is riscv64-specific.
>>>>>>>> I've seen similar crashes in put_user in other places. It looks like
>>>>>>>> put_user crashes in the user address is not mapped/protected (?).
>>>>>>>
>>>>>>> I've been having a look, and this seems to be down to access of the
>>>>>>> tsk->set_child_tid variable. I assume the fuzzing here is to pass a
>>>>>>> bad address to clone?
>>>>>>>
>>>>>>>     From looking at the code, the put_user() code should have set the
>>>>>>> relevant SR_SUM bit (the value for this, which is 1<<18 is in the
>>>>>>> s2 register in the crash report) and from looking at the compiler
>>>>>>> output from my gcc-10, the code looks to be dong the relevant csrs
>>>>>>> and then csrc around the put_user
>>>>>>>
>>>>>>> So currently I do not understand how the above could have happened
>>>>>>> over than something re-tried the code seqeunce and ended up retrying
>>>>>>> the faulting instruction without the SR_SUM bit set.
>>>>>>
>>>>>> I would maybe blame qemu for randomly resetting SR_SUM, but it's
>>>>>> strange that 99% of these crashes are in schedule_tail. If it would be
>>>>>> qemu, then they would be more evenly distributed...
>>>>>>
>>>>>> Another observation: looking at a dozen of crash logs, in none of
>>>>>> these cases fuzzer was actually trying to fuzz clone with some insane
>>>>>> arguments. So it looks like completely normal clone's (e..g coming
>>>>>> from pthread_create) result in this crash.
>>>>>>
>>>>>> I also wonder why there is ret_from_exception, is it normal? I see
>>>>>> handle_exception disables SR_SUM:
>>>>>
>>>>> csrrc does the right thing: it cleans SR_SUM bit in status but saves the
>>>>> previous value that will get correctly restored.
>>>>>
>>>>> ("The CSRRC (Atomic Read and Clear Bits in CSR) instruction reads the
>>>>> value of the CSR, zero-extends the value to XLEN bits, and writes it to
>>>>> integer registerrd.  The initial value in integerregisterrs1is treated
>>>>> as a bit mask that specifies bit positions to be cleared in the CSR. Any
>>>>> bitthat is high inrs1will cause the corresponding bit to be cleared in
>>>>> the CSR, if that CSR bit iswritable.  Other bits in the CSR are
>>>>> unaffected.")
>>>>
>>>> I think there may also be an understanding issue on what the SR_SUM
>>>> bit does. I thought if it is set, M->U accesses would fault, which is
>>>> why it gets set early on. But from reading the uaccess code it looks
>>>> like the uaccess code sets it on entry and then clears on exit.
>>>>
>>>> I am very confused. Is there a master reference for rv64?
>>>>
>>>> https://people.eecs.berkeley.edu/~krste/papers/riscv-privileged-v1.9.pdf
>>>> seems to state PUM is the SR_SUM bit, and that (if set) disabled
>>>>
>>>> Quote:
>>>>     The PUM (Protect User Memory) bit modifies the privilege with which
>>>> S-mode loads, stores, and instruction fetches access virtual memory.
>>>> When PUM=0, translation and protection behave as normal. When PUM=1,
>>>> S-mode memory accesses to pages that are accessible by U-mode (U=1 in
>>>> Figure 4.19) will fault. PUM has no effect when executing in U-mode
>>>>
>>>>
>>>>>> https://elixir.bootlin.com/linux/v5.12-rc2/source/arch/riscv/kernel/entry.S#L73
>>>>>>
>>>>>
>>>>> Still no luck for the moment, can't reproduce it locally, my test is
>>>>> maybe not that good (I created threads all day long in order to trigger
>>>>> the put_user of schedule_tail).
>>>>
>>>> It may of course depend on memory and other stuff. I did try to see if
>>>> it was possible to clone() with the child_tid address being a valid but
>>>> not mapped page...
>>>>
>>>>> Given that the path you mention works most of the time, and that the
>>>>> status register in the stack trace shows the SUM bit is not set whereas
>>>>> it is set in put_user, I'm leaning toward some race condition (maybe an
>>>>> interrupt that arrives at the "wrong" time) or a qemu issue as you
>>>>> mentioned.
>>>>
>>>> I suppose this is possible. From what I read it should get to the
>>>> point of being there with the SUM flag cleared, so either something
>>>> went wrong in trying to fix the instruction up or there's some other
>>>> error we're missing.
>>>>
>>>>> To eliminate qemu issues, do you have access to some HW ? Or to
>>>>> different qemu versions ?
>>>>
>>>> I do have access to a Microchip Polarfire board. I just need the
>>>> instructions on how to setup the test-code to make it work on the
>>>> hardware.
>>>
>>> For full syzkaller support, it would need to know how to reboot these
>>> boards and get access to the console.
>>> syzkaller has a stop-gap VM backend which just uses ssh to a physical
>>> machine and expects the kernel to reboot on its own after any crashes.
>>>
>>> But I actually managed to reproduce it in an even simpler setup.
>>> Assuming you have Go 1.15 and riscv64 cross-compiler gcc installed
>>>
>>> $ go get -u -d github.com/google/syzkaller/...
>>> $ cd $GOPATH/src/github.com/google/syzkaller
>>> $ make stress executor TARGETARCH=riscv64
>>> $ scp bin/linux_riscv64/syz-execprog bin/linux_riscv64/syz-executor
>>> your_machine:/
>>>
>>> Then run ./syz-stress on the machine.
>>> On the first run it crashed it with some other bug, on the second run
>>> I got the crash in schedule_tail.
>>> With qemu tcg I also added -slowdown=10 flag to syz-stress to scale
>>> all timeouts, if native execution is faster, then you don't need it.
>>
>> Ok, not sure what's going on. I get a lot of errors similar to:
>>>
>>> 2021/03/15 21:35:20 transitively unsupported: ioctl$SNAPSHOT_CREATE_IMAGE: no syscalls can create resource fd_snapshot, enable some syscalls that can create it [openat$snapshot]
> 
> This is not an error, just a notification that some syscalls are not
> enabled in the kernel and won't be fuzzed.
> 
>> Followed by:
>>
>>> 2021/03/15 21:35:48 executed 0 programs
>>> 2021/03/15 21:35:48 failed to create execution environment: failed to mmap shm file: invalid argument
>>
>> The qemu is 5.2.0 and root is Debian/unstable riscv64 (same as chroot
>> used to build the syz tools)
> 
> This is an error. But I see it the first time ever.
> It comes from here:
> https://github.com/google/syzkaller/blob/fdb2bb2c23ee709880407f56307e2800ad27e9ae/pkg/osutil/osutil_unix.go#L119-L121
> There should be pretty simple logic inside of syscall.Mmap. Perhaps
> you are using some older Go toolchain with incomplete riscv support?
> I think I've used 1.14 and 1.15. But there is already 1.16. You can
> always download a toolchain here:
> https://golang.org/dl/

Hmm it would have been useful to print out what file it failed to map.

I've got go 1.15 from the debian/unstable riscv64 chroot.
I'll have a look at this in a bit to see if it throws the same issue on 
a real system.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
