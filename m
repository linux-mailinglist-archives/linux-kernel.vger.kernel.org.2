Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D747D332CF3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhCIRMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhCIRL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:11:59 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A73DC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 09:11:59 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id o1so10729710qta.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 09:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KwGtnz1AD/0q7YuUdh1xulZHOiAj/WnKCHjCQomSHvc=;
        b=tLEBsAmNnjgzVhY0oxay44sVNnLiLyTAPDPmVhAX3I4HJkk5IJqSHFSoHIxsYr1al6
         tJqMIDSIs/CagZ0l4Pm9iArBET4dxejsjH7G3eiKhacUBtq+V+9I8n2c71I5wMSsowqG
         aAVyTJ8WWSIU7BWn5npyeCbz3vdgD8UNUJ77Eb9dpRIGF/wn85UhHtlJsj/T4EqhBnMj
         jWOFhGTtE4PlXYz3PPGt8yxol4C1/b59DmooGooSO9hFoCTTsSLDWG5jFdfNbXjABHkS
         e7jzzn7LLhH7mTmocqZnvbXNG/fUPEz+C24JnEpacBbGBHWcIdYQjlvd1KP+bplxuklj
         6O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KwGtnz1AD/0q7YuUdh1xulZHOiAj/WnKCHjCQomSHvc=;
        b=WM+Gfo2DrOv9gBW40nDQwsPbhYL/0ly51XALl/4tZJjOxGxkZleGna2gZEtt/nk9PA
         fKypGCBfA5vKj5NsjErlVXAfDXpMv8efuvU9Br8AL1isbFxSZNiq8tbyMu/PqyEaQX57
         NQejtTb0Ts9gH38Ftjr2PjxHyvWs0I75WuAY4e4N+jmc8JaUHsZbTWszZ6Atb/fBsG4B
         Ja1xW3FmXYnX2VjOtClRkUyze4lAbOMqxCr09OxI4qMJJRSGb3WKr8YvebSJdGpYq8ba
         lnSMdFrZ+2l5fEbvraRqsG8XNUAzu8WJ4t43E11RyOEJZRQ72R1Qo+tTydo+Q7UUcHav
         jCPQ==
X-Gm-Message-State: AOAM5320Yorkiioe58EdIVAGPoAneSpRS3r02lqZr78h7B2QCk2jADAF
        4G0BR3eKKxPoj4kDyCY03zYEmbV63A6BIIkmXRvoQSqYwNQWrQ==
X-Google-Smtp-Source: ABdhPJz9DrS2jcaLWcp6f1ZOZEs5IQzb5sKGPo5b8Wk9TUHxJNGz70X9hQL8jHUcVDeQpHrHs3hEwQco0AE2fbACG/A=
X-Received: by 2002:ac8:5908:: with SMTP id 8mr25939727qty.66.1615309917967;
 Tue, 09 Mar 2021 09:11:57 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+bNzJtwwrHsOa7Ftnaj7B+TPd35=QRLKDE-UuaPJoaDkw@mail.gmail.com>
 <mhng-4c96338e-14e4-4583-8b9d-a99aa6c03eaf@palmerdabbelt-glaptop>
In-Reply-To: <mhng-4c96338e-14e4-4583-8b9d-a99aa6c03eaf@palmerdabbelt-glaptop>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 9 Mar 2021 18:11:46 +0100
Message-ID: <CACT4Y+Z+8hUWaBp7h5YGiGFBJ2Lm3Py_tG=CrdKuUfJfEdPBCw@mail.gmail.com>
Subject: Re: riscv+KASAN does not boot
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Alex Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
        Bjorn Topel <bjorn.topel@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, nylon7@andestech.com,
        syzkaller <syzkaller@googlegroups.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:26 PM 'Palmer Dabbelt' via syzkaller
<syzkaller@googlegroups.com> wrote:
>
> On Fri, 19 Feb 2021 10:53:43 PST (-0800), dvyukov@google.com wrote:
> > On Fri, Feb 19, 2021 at 6:01 PM Alex Ghiti <alex@ghiti.fr> wrote:
> >>
> >> Hi Dmitry,
> >>
> >> Le 2/18/21 =C3=A0 6:36 AM, Dmitry Vyukov a =C3=A9crit :
> >> > On Thu, Feb 18, 2021 at 8:54 AM Alex Ghiti <alex@ghiti.fr> wrote:
> >> >>
> >> >> Hi Dmitry,
> >> >>
> >> >>> On Wed, Feb 17, 2021 at 5:36 PM Alex Ghiti <alex@ghiti.fr> wrote:
> >> >>>>
> >> >>>> Le 2/16/21 =C3=A0 11:42 PM, Dmitry Vyukov a =C3=A9crit :
> >> >>>>> On Tue, Feb 16, 2021 at 9:42 PM Alex Ghiti <alex@ghiti.fr> wrote=
:
> >> >>>>>>
> >> >>>>>> Hi Dmitry,
> >> >>>>>>
> >> >>>>>> Le 2/16/21 =C3=A0 6:25 AM, Dmitry Vyukov a =C3=A9crit :
> >> >>>>>>> On Tue, Feb 16, 2021 at 12:17 PM Dmitry Vyukov <dvyukov@google=
.com> wrote:
> >> >>>>>>>>
> >> >>>>>>>> On Fri, Jan 29, 2021 at 9:11 AM Dmitry Vyukov <dvyukov@google=
.com> wrote:
> >> >>>>>>>>>> I was fixing KASAN support for my sv48 patchset so I took a=
 look at your
> >> >>>>>>>>>> issue: I built a kernel on top of the branch riscv/fixes us=
ing
> >> >>>>>>>>>> https://github.com/google/syzkaller/blob/269d24e857a757d09a=
898086a2fa6fa5d827c3e1/dashboard/config/linux/upstream-riscv64-kasan.config
> >> >>>>>>>>>> and Buildroot 2020.11. I have the warnings regarding the us=
e of
> >> >>>>>>>>>> __virt_to_phys on wrong addresses (but that's normal since =
this function
> >> >>>>>>>>>> is used in virt_addr_valid) but not the segfaults you descr=
ibe.
> >> >>>>>>>>>
> >> >>>>>>>>> Hi Alex,
> >> >>>>>>>>>
> >> >>>>>>>>> Let me try to rebuild buildroot image. Maybe there was somet=
hing wrong
> >> >>>>>>>>> with my build, though, I did 'make clean' before doing. But =
at the
> >> >>>>>>>>> same time it worked back in June...
> >> >>>>>>>>>
> >> >>>>>>>>> Re WARNINGs, they indicate kernel bugs. I am working on sett=
ing up a
> >> >>>>>>>>> syzbot instance on riscv. If there a WARNING during boot the=
n the
> >> >>>>>>>>> kernel will be marked as broken. No further testing will hap=
pen.
> >> >>>>>>>>> Is it a mis-use of WARN_ON? If so, could anybody please remo=
ve it or
> >> >>>>>>>>> replace it with pr_err.
> >> >>>>>>>>
> >> >>>>>>>>
> >> >>>>>>>> Hi,
> >> >>>>>>>>
> >> >>>>>>>> I've localized one issue with riscv/KASAN:
> >> >>>>>>>> KASAN breaks VDSO and that's I think the root cause of weird =
faults I
> >> >>>>>>>> saw earlier. The following patch fixes it.
> >> >>>>>>>> Could somebody please upstream this fix? I don't know how to =
add/run
> >> >>>>>>>> tests for this.
> >> >>>>>>>> Thanks
> >> >>>>>>>>
> >> >>>>>>>> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/ker=
nel/vdso/Makefile
> >> >>>>>>>> index 0cfd6da784f84..cf3a383c1799d 100644
> >> >>>>>>>> --- a/arch/riscv/kernel/vdso/Makefile
> >> >>>>>>>> +++ b/arch/riscv/kernel/vdso/Makefile
> >> >>>>>>>> @@ -35,6 +35,7 @@ CFLAGS_REMOVE_vgettimeofday.o =3D $(CC_FLAG=
S_FTRACE) -Os
> >> >>>>>>>>      # Disable gcov profiling for VDSO code
> >> >>>>>>>>      GCOV_PROFILE :=3D n
> >> >>>>>>>>      KCOV_INSTRUMENT :=3D n
> >> >>>>>>>> +KASAN_SANITIZE :=3D n
> >> >>>>>>>>
> >> >>>>>>>>      # Force dependency
> >> >>>>>>>>      $(obj)/vdso.o: $(obj)/vdso.so
> >> >>>>>>
> >> >>>>>> What's weird is that I don't have any issue without this patch =
with the
> >> >>>>>> following config whereas it indeed seems required for KASAN. Bu=
t when
> >> >>>>>> looking at the segfaults you got earlier, the segfault address =
is 0xbb0
> >> >>>>>> and the cause is an instruction page fault: this address is the=
 PLT base
> >> >>>>>> address in vdso.so and an instruction page fault would mean tha=
t someone
> >> >>>>>> tried to jump at this address, which is weird. At first sight, =
that does
> >> >>>>>> not seem related to your patch above, but clearly I may be wron=
g.
> >> >>>>>>
> >> >>>>>> Tobias, did you observe the same segfaults as Dmitry ?
> >> >>>>>
> >> >>>>>
> >> >>>>> I noticed that not all buildroot images use VDSO, it seems to be
> >> >>>>> dependent on libc settings (at least I think I changed it in the
> >> >>>>> past).
> >> >>>>
> >> >>>> Ok, I used uClibc but then when using glibc, I have the same segf=
aults,
> >> >>>> only when KASAN is enabled. And your patch fixes the problem. I w=
ill try
> >> >>>> to take a look later to better understand the problem.
> >> >>>>
> >> >>>>> I also booted an image completely successfully including dhcpd/s=
shd
> >> >>>>> start, but then my executable crashed in clock_gettime. The exec=
utable
> >> >>>>> was build on linux/amd64 host with "riscv64-linux-gnu-gcc -stati=
c"
> >> >>>>> (10.2.1).
> >> >>>>>
> >> >>>>>
> >> >>>>>>> Second issue I am seeing seems to be related to text segment s=
ize.
> >> >>>>>>> I check out v5.11 and use this config:
> >> >>>>>>> https://gist.github.com/dvyukov/6af25474d455437577a84213b0cc91=
78
> >> >>>>>>
> >> >>>>>> This config gave my laptop a hard time ! Finally I was able to =
boot
> >> >>>>>> correctly to userspace, but I realized I used my sv48 branch...=
Either I
> >> >>>>>> fixed your issue along the way or I can't reproduce it, I'll gi=
ve it a
> >> >>>>>> try tomorrow.
> >> >>>>>
> >> >>>>> Where is your branch? I could also test in my setup on your bran=
ch.
> >> >>>>>
> >> >>>>
> >> >>>> You can find my branch int/alex/riscv_kernel_end_of_address_space=
_v2
> >> >>>> here: https://github.com/AlexGhiti/riscv-linux.git
> >> >>>
> >> >>> No, it does not work for me.
> >> >>>
> >> >>> Source is on b61ab6c98de021398cd7734ea5fc3655e51e70f2 (HEAD,
> >> >>> int/alex/riscv_kernel_end_of_address_space_v2)
> >> >>> Config is https://gist.githubusercontent.com/dvyukov/6af25474d4554=
37577a84213b0cc9178/raw/55b116522c14a8a98a7626d76df740d54f648ce5/gistfile1.=
txt
> >> >>>
> >> >>> riscv64-linux-gnu-gcc -v
> >> >>> gcc version 10.2.1 20210110 (Debian 10.2.1-6+build1)
> >> >>>
> >> >>> qemu-system-riscv64 --version
> >> >>> QEMU emulator version 5.2.0 (Debian 1:5.2+dfsg-3)
> >> >>>
> >> >>> qemu-system-riscv64 \
> >> >>> -machine virt -smp 2 -m 2G \
> >> >>> -device virtio-blk-device,drive=3Dhd0 \
> >> >>> -drive file=3Dimage-riscv64,if=3Dnone,format=3Draw,id=3Dhd0 \
> >> >>> -kernel arch/riscv/boot/Image \
> >> >>> -nographic \
> >> >>> -device virtio-rng-device,rng=3Drng0 -object
> >> >>> rng-random,filename=3D/dev/urandom,id=3Drng0 \
> >> >>> -netdev user,id=3Dnet0,host=3D10.0.2.10,hostfwd=3Dtcp::10022-:22 -=
device
> >> >>> virtio-net-device,netdev=3Dnet0 \
> >> >>> -append "root=3D/dev/vda earlyprintk=3Dserial console=3DttyS0 oops=
=3Dpanic
> >> >>> panic_on_warn=3D1 panic=3D86400 earlycon"
> >> >>
> >> >> It still works for me but I had to disable CONFIG_DEBUG_INFO_BTF (I
> >> >> don't think that changes anything at runtime). But your above comma=
nd
> >> >> line does not work for me as it appears you do not load any firmwar=
e, if
> >> >> I add -bios images/fw_jump.elf, it works. But then I don't know whe=
re
> >> >> your opensbi output below comes from...
> >> >>
> >> >> And regarding your issue with calling clock_gettime 'directly' comp=
ared
> >> >> to using the syscall, I have the same consistent output from both c=
alls.
> >> >>
> >> >> I have an older gcc (9.3.0) and the same qemu. I think what is miss=
ing
> >> >> here is your buildroot config, so that we have the exact same
> >> >> environment: could you post your buildroot config as well ?
> >> >
> >> > I don't think the image is relevant because I don't even get to kern=
el
> >> > code. If the kernel will complain about no init later, that's fine.
> >> > Re bios, this version of qemu already has OpenSBI bios builtin, you
> >> > can pass -bios default, but that's, well, the default :)
> >> > Here are more reproducible repro instructions that capture gcc and
> >> > qemu. I think gcc version may be potentially relevant as I suspect
> >> > code size.
> >> >
> >> >
> >> > curl https://gist.githubusercontent.com/dvyukov/6af25474d455437577a8=
4213b0cc9178/raw/55b116522c14a8a98a7626d76df740d54f648ce5/gistfile1.txt
> >> >> $KERNEL_SRC/.config
> >> > docker pull gcr.io/syzkaller/syzbot
> >> > docker run -it -v $KERNEL_SRC:/kernel gcr.io/syzkaller/syzbot
> >> > cd /kernel
> >> > make -j72 ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- olddefconf=
ig
> >> > make -j72 ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu-
> >> > qemu-system-riscv64 -machine virt -smp 2 -m 4G -kernel
> >> > arch/riscv/boot/Image -nographic -append "earlycon earlyprintk=3Dser=
ial
> >> > console=3DttyS0"
> >> > [this does not, only OpenSBI output]
> >> >
> >>
> >> Indeed the issue was code size, please find the fix below. I will send=
 a
> >> proper patch once I made sure the fix is the right one, but I'm pretty
> >> confident, there's no reason to limit the mapping size to 128MB wherea=
s
> >> we have a whole pgdir.
> >
> > Great you get to the bottom of this!
> > Riscv kernels are going to be YUGE!
>
> IIRC I tried that a while ago and it didn't work.  It's possible I was ju=
st
> running into some other bug, but I'm just build testing allyesconfig as o=
pposed
> to boot testing it.
>
> If you've got a setup that does boot I'm happy to take a patch, though.  =
It'll
> at least be one step forward.



OK, it's getting better.
The next issue is called "512 bytes should be enough for everyone!" :)
https://elixir.bootlin.com/linux/v5.12-rc2/source/include/uapi/asm-generic/=
setup.h#L5
Most other arches redefine it to something bigger:
https://elixir.bootlin.com/linux/v5.12-rc2/source/arch/s390/include/uapi/as=
m/setup.h#L10
even arm32 redefines it.
I am not sure the default is even reasonable anymore. Failure mode is
also not nice (silent truncation).
We are trying to pass this:

earlyprintk=3Dserial oops=3Dpanic nmi_watchdog=3Dpanic panic=3D86400
net.ifnames=3D0 sysctl.kernel.hung_task_all_cpu_backtrace=3D1
ima_policy=3Dtcb kvm-intel.nested=3D1 nf-conntrack-ftp.ports=3D20000
nf-conntrack-tftp.ports=3D20000 nf-conntrack-sip.ports=3D20000
nf-conntrack-irc.ports=3D20000 nf-conntrack-sane.ports=3D20000
vivid.n_devs=3D16 vivid.multiplanar=3D1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2
netrom.nr_ndevs=3D16 rose.rose_ndevs=3D16 spec_store_bypass_disable=3Dprctl
numa=3Dfake=3D2 nopcid dummy_hcd.num=3D8 binder.debug_mask=3D0
rcupdate.rcu_expedited=3D1 watchdog_thresh=3D165
workqueue.watchdog_thresh=3D420 panic_on_warn=3D1

The last part gets truncated and we are getting false workqueue watchdog st=
alls.

Could you please increase it?
