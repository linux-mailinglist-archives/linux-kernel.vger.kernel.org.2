Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047B3337047
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhCKKmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:42:10 -0500
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:57496 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbhCKKmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:42:01 -0500
Received: from cpc79921-stkp12-2-0-cust288.10-2.cable.virginm.net ([86.16.139.33] helo=[192.168.0.18])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1lKIlH-0006rS-9X; Thu, 11 Mar 2021 10:41:47 +0000
Subject: Re: [syzbot] BUG: unable to handle kernel access to user memory in
 schedule_tail
To:     Dmitry Vyukov <dvyukov@google.com>, Alex Ghiti <alex@ghiti.fr>
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
 <dbdca868-7ef2-47b3-ac26-12fe61f3156a@codethink.co.uk>
 <9a0823f4-de19-c2a2-5333-41c6caadbc11@ghiti.fr>
 <CACT4Y+bP0znswS3hFrNsF0L00s35J55Vj_JTC=DJsd0d3iDKpA@mail.gmail.com>
 <CACT4Y+Z=6OJWa--b6M6j5rbJ4VPi=f_ftBNVdYyRErja1pH37A@mail.gmail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <384bb562-dd57-c6c7-03d7-8e222da7c368@codethink.co.uk>
Date:   Thu, 11 Mar 2021 10:41:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z=6OJWa--b6M6j5rbJ4VPi=f_ftBNVdYyRErja1pH37A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2021 06:52, Dmitry Vyukov wrote:
> On Thu, Mar 11, 2021 at 7:50 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> On Thu, Mar 11, 2021 at 7:40 AM Alex Ghiti <alex@ghiti.fr> wrote:
>>>
>>> Hi Ben,
>>>
>>> Le 3/10/21 à 5:24 PM, Ben Dooks a écrit :
>>>> On 10/03/2021 17:16, Dmitry Vyukov wrote:
>>>>> On Wed, Mar 10, 2021 at 5:46 PM syzbot
>>>>> <syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com> wrote:
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> syzbot found the following issue on:
>>>>>>
>>>>>> HEAD commit:    0d7588ab riscv: process: Fix no prototype for
>>>>>> arch_dup_tas..
>>>>>> git tree:
>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1212c6e6d00000
>>>>>> kernel config:
>>>>>> https://syzkaller.appspot.com/x/.config?x=e3c595255fb2d136
>>>>>> dashboard link:
>>>>>> https://syzkaller.appspot.com/bug?extid=e74b94fe601ab9552d69
>>>>>> userspace arch: riscv64
>>>>>>
>>>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>>>>
>>>>>> IMPORTANT: if you fix the issue, please add the following tag to the
>>>>>> commit:
>>>>>> Reported-by: syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com
>>>>>
>>>>> +riscv maintainers
>>>>>
>>>>> This is riscv64-specific.
>>>>> I've seen similar crashes in put_user in other places. It looks like
>>>>> put_user crashes in the user address is not mapped/protected (?).
>>>>
>>>> The unmapped case should have been handled.
>>>>
>>>> I think this issue is that the check for user-mode access added. From
>>>> what I read the code may be wrong in
>>>>
>>>> +    if (!user_mode(regs) && addr < TASK_SIZE &&
>>>> +            unlikely(!(regs->status & SR_SUM)))
>>>> +        die_kernel_fault("access to user memory without uaccess routines",
>>>> +                addr, regs);
>>>>
>>>> I think the SR_SUM check might be wrong, as I read the standard the
>>>> SR_SUM should be set to disable user-space access. So the check
>>>> should be unlikely(regs->status & SR_SUM) to say access without
>>>> having disabled the protection.
>>>
>>> The check that is done seems correct to me: "The SUM (permit Supervisor
>>> User Memory access) bit modifies the privilege with which S-mode loads
>>> and stores access virtual memory.  *When SUM=0, S-mode memory accesses
>>> to pages that are accessible by U-mode (U=1 in Figure 4.15) will fault*.
>>>    When SUM=1, these accesses are permitted.SUM  has  no  effect  when
>>> page-based  virtual  memory  is  not  in  effect".
>>>
>>> I will try to reproduce the problem locally.
>>
>> Weird. It crashes with this all the time:
>> https://syzkaller.appspot.com/bug?extid=e74b94fe601ab9552d69
>>
>> Even on trivial programs that almost don't do anything.
>> Maybe it's qemu bug? Do registers look sane in the dump? That SR_SUM, etc.
>>
>>
>> 00:13:27 executing program 1:
>> openat$drirender128(0xffffffffffffff9c,
>> &(0x7f0000000040)='/dev/dri/renderD128\x00', 0x0, 0x0)
>>
>> [  812.318182][ T4833] Unable to handle kernel access to user memory
>> without uaccess routines at virtual address 00000000250b60d0
>> [  812.322304][ T4833] Oops [#1]
>> [  812.323196][ T4833] Modules linked in:
>> [  812.324110][ T4833] CPU: 1 PID: 4833 Comm: syz-executor.1 Not
>> tainted 5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
>> [  812.325862][ T4833] Hardware name: riscv-virtio,qemu (DT)
>> [  812.327561][ T4833] epc : schedule_tail+0x72/0xb2
>> [  812.328640][ T4833]  ra : schedule_tail+0x70/0xb2
>> [  812.330088][ T4833] epc : ffffffe00008c8b0 ra : ffffffe00008c8ae sp
>> : ffffffe0238bbec0
>> [  812.331312][ T4833]  gp : ffffffe005d25378 tp : ffffffe00a275b00 t0
>> : 0000000000000000
>> [  812.333014][ T4833]  t1 : 0000000000000001 t2 : 00000000000f4240 s0
>> : ffffffe0238bbee0
>> [  812.334137][ T4833]  s1 : 00000000250b60d0 a0 : 0000000000000036 a1
>> : 0000000000000003
>> [  812.336063][ T4833]  a2 : 1ffffffc0cfa8b00 a3 : ffffffe0000c80cc a4
>> : 7f467e72c6adf800
>> [  812.337398][ T4833]  a5 : 0000000000000000 a6 : 0000000000f00000 a7
>> : ffffffe0000f8c84
>> [  812.339287][ T4833]  s2 : 0000000000040000 s3 : ffffffe0077a96c0 s4
>> : ffffffe020e67fe0
>> [  812.340658][ T4833]  s5 : 0000000000004020 s6 : ffffffe0077a9b58 s7
>> : ffffffe067d74850
>> [  812.342492][ T4833]  s8 : ffffffe067d73e18 s9 : 0000000000000000
>> s10: ffffffe00bd72280
>> [  812.343668][ T4833]  s11: 000000bd067bf638 t3 : 7f467e72c6adf800 t4
>> : ffffffc403ee7fb2
>> [  812.345510][ T4833]  t5 : ffffffc403ee7fba t6 : 0000000000040000
>> [  812.347004][ T4833] status: 0000000000000120 badaddr:
>> 00000000250b60d0 cause: 000000000000000f
>> [  812.348091][ T4833] Call Trace:
>> [  812.349291][ T4833] [<ffffffe00008c8b0>] schedule_tail+0x72/0xb2
>> [  812.350796][ T4833] [<ffffffe000005570>] ret_from_exception+0x0/0x14
>> [  812.352799][ T4833] Dumping ftrace buffer:
>> [  812.354328][ T4833]    (ftrace buffer empty)
>> [  812.428145][ T4833] ---[ end trace 94b077e4d677ee73 ]---
>>
>>
>> 00:10:42 executing program 1:
>> bpf$ENABLE_STATS(0x20, 0x0, 0x0)
>> bpf$ENABLE_STATS(0x20, 0x0, 0x0)
>>
>> [  646.536862][ T5163] loop0: detected capacity change from 0 to 1
>> [  646.566730][ T5165] Unable to handle kernel access to user memory
>> without uaccess routines at virtual address 00000000032f80d0
>> [  646.586024][ T5165] Oops [#1]
>> [  646.586640][ T5165] Modules linked in:
>> [  646.587350][ T5165] CPU: 1 PID: 5165 Comm: syz-executor.1 Not
>> tainted 5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
>> [  646.588209][ T5165] Hardware name: riscv-virtio,qemu (DT)
>> [  646.589019][ T5165] epc : schedule_tail+0x72/0xb2
>> [  646.589811][ T5165]  ra : schedule_tail+0x70/0xb2
>> [  646.590435][ T5165] epc : ffffffe00008c8b0 ra : ffffffe00008c8ae sp
>> : ffffffe008013ec0
>> [  646.591142][ T5165]  gp : ffffffe005d25378 tp : ffffffe007634440 t0
>> : 0000000000000000
>> [  646.591836][ T5165]  t1 : 0000000000000001 t2 : 0000000000000008 s0
>> : ffffffe008013ee0
>> [  646.592509][ T5165]  s1 : 00000000032f80d0 a0 : 0000000000000004 a1
>> : 0000000000000003
>> [  646.593188][ T5165]  a2 : 1ffffffc0cfac500 a3 : ffffffe0000c80cc a4
>> : 8d229faaffda9500
>> [  646.593878][ T5165]  a5 : 0000000000000000 a6 : 0000000000f00000 a7
>> : ffffffe000082eba
>> [  646.594552][ T5165]  s2 : 0000000000040000 s3 : ffffffe00c82c440 s4
>> : ffffffe00e61ffe0
>> [  646.595253][ T5165]  s5 : 0000000000004000 s6 : ffffffe067d57e00 s7
>> : ffffffe067d57850
>> [  646.595938][ T5165]  s8 : ffffffe067d56e18 s9 : ffffffe067d57e00
>> s10: ffffffe00c82c878
>> [  646.596627][ T5165]  s11: 000000967ba7a1cc t3 : 8d229faaffda9500 t4
>> : ffffffc4011bc79b
>> [  646.597319][ T5165]  t5 : ffffffc4011bc79d t6 : ffffffe008de3ce8
>> [  646.597909][ T5165] status: 0000000000000120 badaddr:
>> 00000000032f80d0 cause: 000000000000000f
>> [  646.598682][ T5165] Call Trace:
>> [  646.599294][ T5165] [<ffffffe00008c8b0>] schedule_tail+0x72/0xb2
>> [  646.600115][ T5165] [<ffffffe000005570>] ret_from_exception+0x0/0x14
>> [  646.601333][ T5165] Dumping ftrace buffer:
>> [  646.602322][ T5165]    (ftrace buffer empty)
>> [  646.663691][ T5165] ---[ end trace e7b7847ce74cdfca ]---
> 
> Is it reasonable that schedule_tail is called from ret_from_exception?
> Maybe the issue is in ret_from_exception? I see it does something with
> registers.

I'd not noticed this with an earlier kernel (5.10 and the user-fault
check patches) but this may be an qemu issue?


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
