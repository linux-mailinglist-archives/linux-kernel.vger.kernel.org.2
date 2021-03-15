Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FC133C2A3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhCOQ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:56:04 -0400
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:57672 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhCOQzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:55:40 -0400
Received: from cpc79921-stkp12-2-0-cust288.10-2.cable.virginm.net ([86.16.139.33] helo=[192.168.0.18])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1lLqV7-0007HK-4n; Mon, 15 Mar 2021 16:55:29 +0000
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
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <a0449f4a-4d54-6f38-1bc3-7c5170d24b86@codethink.co.uk>
Date:   Mon, 15 Mar 2021 16:55:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bYDU-4MYotLfqgkGpz487aC8xQ0dqaNLwf76d1yyF-Vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2021 07:20, Dmitry Vyukov wrote:
> On Fri, Mar 12, 2021 at 9:12 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:

>>> Still no luck for the moment, can't reproduce it locally, my test is
>>> maybe not that good (I created threads all day long in order to trigger
>>> the put_user of schedule_tail).
>>
>> It may of course depend on memory and other stuff. I did try to see if
>> it was possible to clone() with the child_tid address being a valid but
>> not mapped page...
>>
>>> Given that the path you mention works most of the time, and that the
>>> status register in the stack trace shows the SUM bit is not set whereas
>>> it is set in put_user, I'm leaning toward some race condition (maybe an
>>> interrupt that arrives at the "wrong" time) or a qemu issue as you
>>> mentioned.
>>
>> I suppose this is possible. From what I read it should get to the
>> point of being there with the SUM flag cleared, so either something
>> went wrong in trying to fix the instruction up or there's some other
>> error we're missing.
>>
>>> To eliminate qemu issues, do you have access to some HW ? Or to
>>> different qemu versions ?
>>
>> I do have access to a Microchip Polarfire board. I just need the
>> instructions on how to setup the test-code to make it work on the
>> hardware.
> 
> For full syzkaller support, it would need to know how to reboot these
> boards and get access to the console.
> syzkaller has a stop-gap VM backend which just uses ssh to a physical
> machine and expects the kernel to reboot on its own after any crashes.
> 
> But I actually managed to reproduce it in an even simpler setup.
> Assuming you have Go 1.15 and riscv64 cross-compiler gcc installed
> 
> $ go get -u -d github.com/google/syzkaller/...
> $ cd $GOPATH/src/github.com/google/syzkaller
> $ make stress executor TARGETARCH=riscv64
> $ scp bin/linux_riscv64/syz-execprog bin/linux_riscv64/syz-executor
> your_machine:/
> 
> Then run ./syz-stress on the machine.
> On the first run it crashed it with some other bug, on the second run
> I got the crash in schedule_tail.
> With qemu tcg I also added -slowdown=10 flag to syz-stress to scale
> all timeouts, if native execution is faster, then you don't need it.

I have built the tools and got it to start.

It would be helpful for the dashboard to give the qemu version and
how it was launched (memory, cpus etc)

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
