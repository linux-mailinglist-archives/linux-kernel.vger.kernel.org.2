Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE9233D34D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbhCPLpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbhCPLoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:44:32 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90230C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 04:44:31 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id t16so9311351qvr.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 04:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NTsYJCryBLJmBTqd/Py0Dz+f5uiVV4FtLBaghBowCOY=;
        b=TBnl/KM9TU9p3coDdCDbo4TpBTM+I6Lu4+vfs0NooyhGrAknmu42FsT84Ix0sGuAPt
         Lng68vrtJgMiw4W9CmAOvLdv3JoK+52MrGC0LFf4EkPb0xm5cCTzSz7g5xW+EqEYV/6S
         WMNY+pXa3zNE8eMcjELxJzryDHFWzXAeKlmSNWWt2xEas8Fv7dfXt4nkwnWgGPNwhwo4
         lxMLXOSyYZZ5KDMD06BaYUNWDasIuZ7tEf1MsgK8NTj4enGU1PTYc+uJiqdZWoXeum8v
         jHqTLJ0IO2DhGJ9bpb2lBAjJisQyIxy351+bwq1wx/CbyLgbmKXCJSh7QnInr/GaP8uF
         uofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NTsYJCryBLJmBTqd/Py0Dz+f5uiVV4FtLBaghBowCOY=;
        b=RRY6ZkNkk0dEJ1etpXHfedpXRDckfkNu++M9eYuMr/R4oaQzr8YNGs7sKllzWragpW
         KgUMCsGKjmUqmM3jlzlcYgZLEA/lrtMU1G8JlfggK6E2WYnszEvZJ02ZrKXYSdJGPB5i
         GbITultnQS1bbHIZGQvcA1Wj+C5xzNNgPmOU4qfvWeBODYgbtV9Cb3cR/BpZDTKVe7HA
         ooDvPW56VfiiNaehjKCiMi6VRCRDIpJHjhNmB8dKWXm26jAYoByqF906Qx+Cz1MjBLW0
         NBgeGKOBw96uKVLZmsN4fqNG/3y3mcPcNmEda07HZwwbxdCVaSuejrRWvd9oxesO5HGJ
         2YkA==
X-Gm-Message-State: AOAM530fn5Z6U0FZ89lD1iGsr9RjwXxvFTPxgLMCMx6odFwLkcKVXKhh
        5pnMkRg/eX0LU7wqk+cLGOKM1uv9QPdcs2wlKE3T8A==
X-Google-Smtp-Source: ABdhPJyLRD4J+HqEmUtaqMButRCVbSTrKpNp4w0KfbKrtVqm1s3EXPUUKtGMxrNEt0zw7/mWKpAol9HqLdnV+mDLyTg=
X-Received: by 2002:ad4:50d0:: with SMTP id e16mr29583746qvq.37.1615895070392;
 Tue, 16 Mar 2021 04:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b74f1b05bd316729@google.com> <CACT4Y+ZHMYijYAkeLMX=p9jx6pBivJz06h_1rGt-k9=AgfkWQg@mail.gmail.com>
 <84b0471d-42c1-175f-ae1d-a18c310c7f77@codethink.co.uk> <CACT4Y+ZsSRdQ5LzYMsgjrBAukgP-Vv8WSQsSoxguYjWvB1QnrA@mail.gmail.com>
 <795597a1-ec87-e09e-d073-3daf10422abb@ghiti.fr> <f9318e58-5d3f-f548-3dbf-a5cb87406a94@codethink.co.uk>
 <CACT4Y+bYDU-4MYotLfqgkGpz487aC8xQ0dqaNLwf76d1yyF-Vw@mail.gmail.com>
 <12d4137e-6c14-bc41-4bbc-955ce46198d2@codethink.co.uk> <CACT4Y+ZnPS8e5c7HHMbRCDQSi+y1z0Rm3a89ev7NvLWcRKzu9A@mail.gmail.com>
 <8ebea51d-b03c-e6de-fa1c-d47091c54e45@codethink.co.uk>
In-Reply-To: <8ebea51d-b03c-e6de-fa1c-d47091c54e45@codethink.co.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 16 Mar 2021 12:44:18 +0100
Message-ID: <CACT4Y+bU7-bX0SC6vQUDUBXYgQF0vz4jH-_tCb0e8ThB6fiHUA@mail.gmail.com>
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

On Tue, Mar 16, 2021 at 12:35 PM Ben Dooks <ben.dooks@codethink.co.uk> wrot=
e:
> >>>> On 12/03/2021 16:25, Alex Ghiti wrote:
> >>>>>
> >>>>>
> >>>>> Le 3/12/21 =C3=A0 10:12 AM, Dmitry Vyukov a =C3=A9crit :
> >>>>>> On Fri, Mar 12, 2021 at 2:50 PM Ben Dooks <ben.dooks@codethink.co.=
uk>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>> On 10/03/2021 17:16, Dmitry Vyukov wrote:
> >>>>>>>> On Wed, Mar 10, 2021 at 5:46 PM syzbot
> >>>>>>>> <syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com> wrote:
> >>>>>>>>>
> >>>>>>>>> Hello,
> >>>>>>>>>
> >>>>>>>>> syzbot found the following issue on:
> >>>>>>>>>
> >>>>>>>>> HEAD commit:    0d7588ab riscv: process: Fix no prototype for
> >>>>>>>>> arch_dup_tas..
> >>>>>>>>> git tree:
> >>>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git f=
ixes
> >>>>>>>>> console output:
> >>>>>>>>> https://syzkaller.appspot.com/x/log.txt?x=3D1212c6e6d00000
> >>>>>>>>> kernel config:
> >>>>>>>>> https://syzkaller.appspot.com/x/.config?x=3De3c595255fb2d136
> >>>>>>>>> dashboard link:
> >>>>>>>>> https://syzkaller.appspot.com/bug?extid=3De74b94fe601ab9552d69
> >>>>>>>>> userspace arch: riscv64
> >>>>>>>>>
> >>>>>>>>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>>>>>>>
> >>>>>>>>> IMPORTANT: if you fix the issue, please add the following tag t=
o
> >>>>>>>>> the commit:
> >>>>>>>>> Reported-by: syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.=
com
> >>>>>>>>
> >>>>>>>> +riscv maintainers
> >>>>>>>>
> >>>>>>>> This is riscv64-specific.
> >>>>>>>> I've seen similar crashes in put_user in other places. It looks =
like
> >>>>>>>> put_user crashes in the user address is not mapped/protected (?)=
.
> >>>>>>>
> >>>>>>> I've been having a look, and this seems to be down to access of t=
he
> >>>>>>> tsk->set_child_tid variable. I assume the fuzzing here is to pass=
 a
> >>>>>>> bad address to clone?
> >>>>>>>
> >>>>>>>     From looking at the code, the put_user() code should have set=
 the
> >>>>>>> relevant SR_SUM bit (the value for this, which is 1<<18 is in the
> >>>>>>> s2 register in the crash report) and from looking at the compiler
> >>>>>>> output from my gcc-10, the code looks to be dong the relevant csr=
s
> >>>>>>> and then csrc around the put_user
> >>>>>>>
> >>>>>>> So currently I do not understand how the above could have happene=
d
> >>>>>>> over than something re-tried the code seqeunce and ended up retry=
ing
> >>>>>>> the faulting instruction without the SR_SUM bit set.
> >>>>>>
> >>>>>> I would maybe blame qemu for randomly resetting SR_SUM, but it's
> >>>>>> strange that 99% of these crashes are in schedule_tail. If it woul=
d be
> >>>>>> qemu, then they would be more evenly distributed...
> >>>>>>
> >>>>>> Another observation: looking at a dozen of crash logs, in none of
> >>>>>> these cases fuzzer was actually trying to fuzz clone with some ins=
ane
> >>>>>> arguments. So it looks like completely normal clone's (e..g coming
> >>>>>> from pthread_create) result in this crash.
> >>>>>>
> >>>>>> I also wonder why there is ret_from_exception, is it normal? I see
> >>>>>> handle_exception disables SR_SUM:
> >>>>>
> >>>>> csrrc does the right thing: it cleans SR_SUM bit in status but save=
s the
> >>>>> previous value that will get correctly restored.
> >>>>>
> >>>>> ("The CSRRC (Atomic Read and Clear Bits in CSR) instruction reads t=
he
> >>>>> value of the CSR, zero-extends the value to XLEN bits, and writes i=
t to
> >>>>> integer registerrd.  The initial value in integerregisterrs1is trea=
ted
> >>>>> as a bit mask that specifies bit positions to be cleared in the CSR=
. Any
> >>>>> bitthat is high inrs1will cause the corresponding bit to be cleared=
 in
> >>>>> the CSR, if that CSR bit iswritable.  Other bits in the CSR are
> >>>>> unaffected.")
> >>>>
> >>>> I think there may also be an understanding issue on what the SR_SUM
> >>>> bit does. I thought if it is set, M->U accesses would fault, which i=
s
> >>>> why it gets set early on. But from reading the uaccess code it looks
> >>>> like the uaccess code sets it on entry and then clears on exit.
> >>>>
> >>>> I am very confused. Is there a master reference for rv64?
> >>>>
> >>>> https://people.eecs.berkeley.edu/~krste/papers/riscv-privileged-v1.9=
.pdf
> >>>> seems to state PUM is the SR_SUM bit, and that (if set) disabled
> >>>>
> >>>> Quote:
> >>>>     The PUM (Protect User Memory) bit modifies the privilege with wh=
ich
> >>>> S-mode loads, stores, and instruction fetches access virtual memory.
> >>>> When PUM=3D0, translation and protection behave as normal. When PUM=
=3D1,
> >>>> S-mode memory accesses to pages that are accessible by U-mode (U=3D1=
 in
> >>>> Figure 4.19) will fault. PUM has no effect when executing in U-mode
> >>>>
> >>>>
> >>>>>> https://elixir.bootlin.com/linux/v5.12-rc2/source/arch/riscv/kerne=
l/entry.S#L73
> >>>>>>
> >>>>>
> >>>>> Still no luck for the moment, can't reproduce it locally, my test i=
s
> >>>>> maybe not that good (I created threads all day long in order to tri=
gger
> >>>>> the put_user of schedule_tail).
> >>>>
> >>>> It may of course depend on memory and other stuff. I did try to see =
if
> >>>> it was possible to clone() with the child_tid address being a valid =
but
> >>>> not mapped page...
> >>>>
> >>>>> Given that the path you mention works most of the time, and that th=
e
> >>>>> status register in the stack trace shows the SUM bit is not set whe=
reas
> >>>>> it is set in put_user, I'm leaning toward some race condition (mayb=
e an
> >>>>> interrupt that arrives at the "wrong" time) or a qemu issue as you
> >>>>> mentioned.
> >>>>
> >>>> I suppose this is possible. From what I read it should get to the
> >>>> point of being there with the SUM flag cleared, so either something
> >>>> went wrong in trying to fix the instruction up or there's some other
> >>>> error we're missing.
> >>>>
> >>>>> To eliminate qemu issues, do you have access to some HW ? Or to
> >>>>> different qemu versions ?
> >>>>
> >>>> I do have access to a Microchip Polarfire board. I just need the
> >>>> instructions on how to setup the test-code to make it work on the
> >>>> hardware.
> >>>
> >>> For full syzkaller support, it would need to know how to reboot these
> >>> boards and get access to the console.
> >>> syzkaller has a stop-gap VM backend which just uses ssh to a physical
> >>> machine and expects the kernel to reboot on its own after any crashes=
.
> >>>
> >>> But I actually managed to reproduce it in an even simpler setup.
> >>> Assuming you have Go 1.15 and riscv64 cross-compiler gcc installed
> >>>
> >>> $ go get -u -d github.com/google/syzkaller/...
> >>> $ cd $GOPATH/src/github.com/google/syzkaller
> >>> $ make stress executor TARGETARCH=3Driscv64
> >>> $ scp bin/linux_riscv64/syz-execprog bin/linux_riscv64/syz-executor
> >>> your_machine:/
> >>>
> >>> Then run ./syz-stress on the machine.
> >>> On the first run it crashed it with some other bug, on the second run
> >>> I got the crash in schedule_tail.
> >>> With qemu tcg I also added -slowdown=3D10 flag to syz-stress to scale
> >>> all timeouts, if native execution is faster, then you don't need it.
> >>
> >> Ok, not sure what's going on. I get a lot of errors similar to:
> >>>
> >>> 2021/03/15 21:35:20 transitively unsupported: ioctl$SNAPSHOT_CREATE_I=
MAGE: no syscalls can create resource fd_snapshot, enable some syscalls tha=
t can create it [openat$snapshot]
> >
> > This is not an error, just a notification that some syscalls are not
> > enabled in the kernel and won't be fuzzed.
> >
> >> Followed by:
> >>
> >>> 2021/03/15 21:35:48 executed 0 programs
> >>> 2021/03/15 21:35:48 failed to create execution environment: failed to=
 mmap shm file: invalid argument
> >>
> >> The qemu is 5.2.0 and root is Debian/unstable riscv64 (same as chroot
> >> used to build the syz tools)
> >
> > This is an error. But I see it the first time ever.
> > It comes from here:
> > https://github.com/google/syzkaller/blob/fdb2bb2c23ee709880407f56307e28=
00ad27e9ae/pkg/osutil/osutil_unix.go#L119-L121
> > There should be pretty simple logic inside of syscall.Mmap. Perhaps
> > you are using some older Go toolchain with incomplete riscv support?
> > I think I've used 1.14 and 1.15. But there is already 1.16. You can
> > always download a toolchain here:
> > https://golang.org/dl/
>
> Hmm it would have been useful to print out what file it failed to map.

What do you want to do with the file name? It's not one of
pre-existing files, so the name won't tell the user much. It's just a
temp file, it won't exist afterwards and it's easy to create an
equivalent file.
It was created in that function with:

    f, err =3D ioutil.TempFile("./", "syzkaller-shm")
    if err !=3D nil {
        err =3D fmt.Errorf("failed to create temp file: %v", err)
        return
    }
    if err =3D f.Truncate(int64(size)); err !=3D nil {
        err =3D fmt.Errorf("failed to truncate shm file: %v", err)
        f.Close()
        os.Remove(f.Name())
        return
    }
    f.Close()
    fname :=3D f.Name()
    f, err =3D os.OpenFile(f.Name(), os.O_RDWR, DefaultFilePerm)
    if err !=3D nil {
        err =3D fmt.Errorf("failed to open shm file: %v", err)
        os.Remove(fname)
        return
    }

> I've got go 1.15 from the debian/unstable riscv64 chroot.
> I'll have a look at this in a bit to see if it throws the same issue on
> a real system.
>
>
> --
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
>
> https://www.codethink.co.uk/privacy.html
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/8ebea51d-b03c-e6de-fa1c-d47091c54e45%40codethink.co.uk.
