Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCDC33D024
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbhCPIxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbhCPIxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:53:10 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB75C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 01:53:09 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id 94so11090333qtc.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 01:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HKbSarGgbfX8hj+ii99HysCuZO3715fP6jdqMmZf3jc=;
        b=cf+eKxGcxGmwL30yn/dlyMD1I3zGadZ7NwVYNnvXqAShdiUM5Enp8El9uD5aIoaYhs
         F/v48lAGCDsb73GPerfD9YcmtzS7f1TnVa5Xz09umQHpBHh3CKH9yN4Mzyx0dsAd7wvR
         r6wzNMFbUj/KxwZjv2scgU3AsjK0w4ztLKKkzwXDMfhzrlc/AmWWJpWb/STjP/6cvmcT
         YMT2hFsB/SO1oEIPUqxAs7ZWNxohAftWuemrMKMkE6+tj3vI4IaOJo6jja9VGKmWIE/9
         Eyldj3/ydK/7fVzCIFcEt0VHEzV/WgtK4AUeeK8uQY+SjEtCa9YW2YMSjnh3yqJO6WmT
         T9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HKbSarGgbfX8hj+ii99HysCuZO3715fP6jdqMmZf3jc=;
        b=asrGt3WTlktxe5iVOLqr1BjWMGvFHHULt4WFxq3Oe9iCw8YpMQwOtC9aDhWs9aFq3x
         X4uffHpRF2THR362ICOLz2EMGAcigLj8VkPVTeqvccPcVa0nMyOywuJvVmC6V3LRRNnI
         jfmcZQhQDpFBXPi2A1vBPV4eo3zO9Abw8nlZXCLM9yuS+HnMfDNVFtCq7if5HSVUwRRJ
         BVtV725nUEed+vVy173YnOgoRpb/Rhyu3ctvqi+FVB7Djo2UxbkyKbzT9vBOgoJxw3F9
         diga2OOpe8Z4vGLEa0np0z6UCVUWZumDoa3nA7DCvsqIatf+FNjV56gnSVzI/MpaLgA9
         PYPw==
X-Gm-Message-State: AOAM533y5b3tvCk0okM7VKlE7QgCse6cdTAkVsCl7vz6ydgkOthDA9Kf
        tmilifeDHOoJ6s+qywmFesq1uv2BXnf3BESnACKXrw==
X-Google-Smtp-Source: ABdhPJzDpLlyJ0Cz5ptXBqO8zWFU1DW7UX34+An3Zee3jIAoNNR+Mch8xRu1PK085//2d5TG5L2yMpuEoQky7DAStYc=
X-Received: by 2002:ac8:4558:: with SMTP id z24mr15262004qtn.66.1615884788308;
 Tue, 16 Mar 2021 01:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b74f1b05bd316729@google.com> <CACT4Y+ZHMYijYAkeLMX=p9jx6pBivJz06h_1rGt-k9=AgfkWQg@mail.gmail.com>
 <84b0471d-42c1-175f-ae1d-a18c310c7f77@codethink.co.uk> <CACT4Y+ZsSRdQ5LzYMsgjrBAukgP-Vv8WSQsSoxguYjWvB1QnrA@mail.gmail.com>
 <795597a1-ec87-e09e-d073-3daf10422abb@ghiti.fr> <f9318e58-5d3f-f548-3dbf-a5cb87406a94@codethink.co.uk>
 <CACT4Y+bYDU-4MYotLfqgkGpz487aC8xQ0dqaNLwf76d1yyF-Vw@mail.gmail.com> <12d4137e-6c14-bc41-4bbc-955ce46198d2@codethink.co.uk>
In-Reply-To: <12d4137e-6c14-bc41-4bbc-955ce46198d2@codethink.co.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 16 Mar 2021 09:52:56 +0100
Message-ID: <CACT4Y+ZnPS8e5c7HHMbRCDQSi+y1z0Rm3a89ev7NvLWcRKzu9A@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel access to user memory in schedule_tail
To:     Ben Dooks <ben.dooks@codethink.co.uk>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 10:38 PM Ben Dooks <ben.dooks@codethink.co.uk> wrot=
e:
>
> On 13/03/2021 07:20, Dmitry Vyukov wrote:
> > On Fri, Mar 12, 2021 at 9:12 PM Ben Dooks <ben.dooks@codethink.co.uk> w=
rote:
> >>
> >> On 12/03/2021 16:25, Alex Ghiti wrote:
> >>>
> >>>
> >>> Le 3/12/21 =C3=A0 10:12 AM, Dmitry Vyukov a =C3=A9crit :
> >>>> On Fri, Mar 12, 2021 at 2:50 PM Ben Dooks <ben.dooks@codethink.co.uk=
>
> >>>> wrote:
> >>>>>
> >>>>> On 10/03/2021 17:16, Dmitry Vyukov wrote:
> >>>>>> On Wed, Mar 10, 2021 at 5:46 PM syzbot
> >>>>>> <syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com> wrote:
> >>>>>>>
> >>>>>>> Hello,
> >>>>>>>
> >>>>>>> syzbot found the following issue on:
> >>>>>>>
> >>>>>>> HEAD commit:    0d7588ab riscv: process: Fix no prototype for
> >>>>>>> arch_dup_tas..
> >>>>>>> git tree:
> >>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fix=
es
> >>>>>>> console output:
> >>>>>>> https://syzkaller.appspot.com/x/log.txt?x=3D1212c6e6d00000
> >>>>>>> kernel config:
> >>>>>>> https://syzkaller.appspot.com/x/.config?x=3De3c595255fb2d136
> >>>>>>> dashboard link:
> >>>>>>> https://syzkaller.appspot.com/bug?extid=3De74b94fe601ab9552d69
> >>>>>>> userspace arch: riscv64
> >>>>>>>
> >>>>>>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>>>>>
> >>>>>>> IMPORTANT: if you fix the issue, please add the following tag to
> >>>>>>> the commit:
> >>>>>>> Reported-by: syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.co=
m
> >>>>>>
> >>>>>> +riscv maintainers
> >>>>>>
> >>>>>> This is riscv64-specific.
> >>>>>> I've seen similar crashes in put_user in other places. It looks li=
ke
> >>>>>> put_user crashes in the user address is not mapped/protected (?).
> >>>>>
> >>>>> I've been having a look, and this seems to be down to access of the
> >>>>> tsk->set_child_tid variable. I assume the fuzzing here is to pass a
> >>>>> bad address to clone?
> >>>>>
> >>>>>    From looking at the code, the put_user() code should have set th=
e
> >>>>> relevant SR_SUM bit (the value for this, which is 1<<18 is in the
> >>>>> s2 register in the crash report) and from looking at the compiler
> >>>>> output from my gcc-10, the code looks to be dong the relevant csrs
> >>>>> and then csrc around the put_user
> >>>>>
> >>>>> So currently I do not understand how the above could have happened
> >>>>> over than something re-tried the code seqeunce and ended up retryin=
g
> >>>>> the faulting instruction without the SR_SUM bit set.
> >>>>
> >>>> I would maybe blame qemu for randomly resetting SR_SUM, but it's
> >>>> strange that 99% of these crashes are in schedule_tail. If it would =
be
> >>>> qemu, then they would be more evenly distributed...
> >>>>
> >>>> Another observation: looking at a dozen of crash logs, in none of
> >>>> these cases fuzzer was actually trying to fuzz clone with some insan=
e
> >>>> arguments. So it looks like completely normal clone's (e..g coming
> >>>> from pthread_create) result in this crash.
> >>>>
> >>>> I also wonder why there is ret_from_exception, is it normal? I see
> >>>> handle_exception disables SR_SUM:
> >>>
> >>> csrrc does the right thing: it cleans SR_SUM bit in status but saves =
the
> >>> previous value that will get correctly restored.
> >>>
> >>> ("The CSRRC (Atomic Read and Clear Bits in CSR) instruction reads the
> >>> value of the CSR, zero-extends the value to XLEN bits, and writes it =
to
> >>> integer registerrd.  The initial value in integerregisterrs1is treate=
d
> >>> as a bit mask that specifies bit positions to be cleared in the CSR. =
Any
> >>> bitthat is high inrs1will cause the corresponding bit to be cleared i=
n
> >>> the CSR, if that CSR bit iswritable.  Other bits in the CSR are
> >>> unaffected.")
> >>
> >> I think there may also be an understanding issue on what the SR_SUM
> >> bit does. I thought if it is set, M->U accesses would fault, which is
> >> why it gets set early on. But from reading the uaccess code it looks
> >> like the uaccess code sets it on entry and then clears on exit.
> >>
> >> I am very confused. Is there a master reference for rv64?
> >>
> >> https://people.eecs.berkeley.edu/~krste/papers/riscv-privileged-v1.9.p=
df
> >> seems to state PUM is the SR_SUM bit, and that (if set) disabled
> >>
> >> Quote:
> >>    The PUM (Protect User Memory) bit modifies the privilege with which
> >> S-mode loads, stores, and instruction fetches access virtual memory.
> >> When PUM=3D0, translation and protection behave as normal. When PUM=3D=
1,
> >> S-mode memory accesses to pages that are accessible by U-mode (U=3D1 i=
n
> >> Figure 4.19) will fault. PUM has no effect when executing in U-mode
> >>
> >>
> >>>> https://elixir.bootlin.com/linux/v5.12-rc2/source/arch/riscv/kernel/=
entry.S#L73
> >>>>
> >>>
> >>> Still no luck for the moment, can't reproduce it locally, my test is
> >>> maybe not that good (I created threads all day long in order to trigg=
er
> >>> the put_user of schedule_tail).
> >>
> >> It may of course depend on memory and other stuff. I did try to see if
> >> it was possible to clone() with the child_tid address being a valid bu=
t
> >> not mapped page...
> >>
> >>> Given that the path you mention works most of the time, and that the
> >>> status register in the stack trace shows the SUM bit is not set where=
as
> >>> it is set in put_user, I'm leaning toward some race condition (maybe =
an
> >>> interrupt that arrives at the "wrong" time) or a qemu issue as you
> >>> mentioned.
> >>
> >> I suppose this is possible. From what I read it should get to the
> >> point of being there with the SUM flag cleared, so either something
> >> went wrong in trying to fix the instruction up or there's some other
> >> error we're missing.
> >>
> >>> To eliminate qemu issues, do you have access to some HW ? Or to
> >>> different qemu versions ?
> >>
> >> I do have access to a Microchip Polarfire board. I just need the
> >> instructions on how to setup the test-code to make it work on the
> >> hardware.
> >
> > For full syzkaller support, it would need to know how to reboot these
> > boards and get access to the console.
> > syzkaller has a stop-gap VM backend which just uses ssh to a physical
> > machine and expects the kernel to reboot on its own after any crashes.
> >
> > But I actually managed to reproduce it in an even simpler setup.
> > Assuming you have Go 1.15 and riscv64 cross-compiler gcc installed
> >
> > $ go get -u -d github.com/google/syzkaller/...
> > $ cd $GOPATH/src/github.com/google/syzkaller
> > $ make stress executor TARGETARCH=3Driscv64
> > $ scp bin/linux_riscv64/syz-execprog bin/linux_riscv64/syz-executor
> > your_machine:/
> >
> > Then run ./syz-stress on the machine.
> > On the first run it crashed it with some other bug, on the second run
> > I got the crash in schedule_tail.
> > With qemu tcg I also added -slowdown=3D10 flag to syz-stress to scale
> > all timeouts, if native execution is faster, then you don't need it.
>
> Ok, not sure what's going on. I get a lot of errors similar to:
> >
> > 2021/03/15 21:35:20 transitively unsupported: ioctl$SNAPSHOT_CREATE_IMA=
GE: no syscalls can create resource fd_snapshot, enable some syscalls that =
can create it [openat$snapshot]

This is not an error, just a notification that some syscalls are not
enabled in the kernel and won't be fuzzed.

> Followed by:
>
> > 2021/03/15 21:35:48 executed 0 programs
> > 2021/03/15 21:35:48 failed to create execution environment: failed to m=
map shm file: invalid argument
>
> The qemu is 5.2.0 and root is Debian/unstable riscv64 (same as chroot
> used to build the syz tools)

This is an error. But I see it the first time ever.
It comes from here:
https://github.com/google/syzkaller/blob/fdb2bb2c23ee709880407f56307e2800ad=
27e9ae/pkg/osutil/osutil_unix.go#L119-L121
There should be pretty simple logic inside of syscall.Mmap. Perhaps
you are using some older Go toolchain with incomplete riscv support?
I think I've used 1.14 and 1.15. But there is already 1.16. You can
always download a toolchain here:
https://golang.org/dl/
