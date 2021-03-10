Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A1D334516
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhCJRZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhCJRZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:25:38 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FFBC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:25:37 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id n26so4396841qtv.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K5dZhID2vTTt8FDHGwXQHgQRxOXlmk8uS9WHKvMScP8=;
        b=KpqLPUAAA6BIEQ28Q0jg3t6A4PAthTd6vCsmKp7VrvKyNurflYqGjtK5Qcw5arfkpa
         w+ubE/6Vs5jsokhzwAJjOsur732t9XHHawBgnpvgBqyrm9U5xGT9numI3NrIw76vl6GC
         Z4uO1O6XT7AGGX/XenRpNp1qHfgFvImyGACehkx8Hr+wcXwxtojAmDSMXDZKBP5/0ewL
         I0o6irhC7imuyeSmFzZXLB3zQxcaQ25wRZLPlLqc889MiHrA+h0N80gK1H4ox/QrpDAb
         4QatUzg6GgsLFLwrrCG8NgZ8qXcxFRDuYfQlf2Xk7Tf8AXENBp8OV4GQSQxIDa4OLlgd
         D3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K5dZhID2vTTt8FDHGwXQHgQRxOXlmk8uS9WHKvMScP8=;
        b=teiRlT7FLLzOMu+7g+NQRV60MemHQKPbqM0Rmuf008qrRQGmrfW8rCFWk7EebNG367
         St+mgzYvunJMu/IWhFPrqQe+aRErXO1RyCMeCG94c/v76fOB2p+0UBdzXyGfWRNR14mm
         Va1TDZF8TLIVqrkgLMuXPUHm7jNt4N4AWP8w6idrpHXWkIYgpI4c6j5hg/UkLxP+tb46
         RZ25v+tFNpSC6KCnPk+2umnvcNQEpcLSZQ1coG/u+0WYuVLA66Kx7Fr1csgFBYQj6GJ3
         5Ryntx/ngtfPxcf517zht9J0V5duAAumwxqqwTDtF3BGpAFCDUjMvZNSRJspkCZadT4U
         UWmw==
X-Gm-Message-State: AOAM531z4XPXqxAE199OZYTNz5c6Cd+pwTpPr2NGFewHLuCY77upg2hw
        M+Zsrg/ByZ3VUTTtJq+XlJ6whshVvFA9UaZ2ybmpAw==
X-Google-Smtp-Source: ABdhPJyJMUXFIHpXY2vvKUJxBsuDWLqgtjt3vURweOjLYojJvt3HLXMnQzzZzkgRKUdykfQKQufHIeNG27tvCT3TMMc=
X-Received: by 2002:ac8:5847:: with SMTP id h7mr3575786qth.43.1615397136747;
 Wed, 10 Mar 2021 09:25:36 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+bNzJtwwrHsOa7Ftnaj7B+TPd35=QRLKDE-UuaPJoaDkw@mail.gmail.com>
 <mhng-4c96338e-14e4-4583-8b9d-a99aa6c03eaf@palmerdabbelt-glaptop>
 <CACT4Y+Z+8hUWaBp7h5YGiGFBJ2Lm3Py_tG=CrdKuUfJfEdPBCw@mail.gmail.com> <a0a949aa-457e-73a8-1ece-9b8e0573d664@ghiti.fr>
In-Reply-To: <a0a949aa-457e-73a8-1ece-9b8e0573d664@ghiti.fr>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Mar 2021 18:25:25 +0100
Message-ID: <CACT4Y+a9Jckuoq5H8WwoN9_rha-UHsK88YPpouQf0Y7EDYu=Ng@mail.gmail.com>
Subject: Re: riscv+KASAN does not boot
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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

On Tue, Mar 9, 2021 at 8:49 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Le 3/9/21 =C3=A0 12:11 PM, Dmitry Vyukov a =C3=A9crit :
> > On Fri, Feb 19, 2021 at 11:26 PM 'Palmer Dabbelt' via syzkaller
> > <syzkaller@googlegroups.com> wrote:
> >>
> >> On Fri, 19 Feb 2021 10:53:43 PST (-0800), dvyukov@google.com wrote:
> >>> On Fri, Feb 19, 2021 at 6:01 PM Alex Ghiti <alex@ghiti.fr> wrote:
> >>>>
> >>>> Hi Dmitry,
> >>>>
> >>>> Le 2/18/21 =C3=A0 6:36 AM, Dmitry Vyukov a =C3=A9crit :
> >>>>> On Thu, Feb 18, 2021 at 8:54 AM Alex Ghiti <alex@ghiti.fr> wrote:
> >>>>>>
> >>>>>> Hi Dmitry,
> >>>>>>
> >>>>>>> On Wed, Feb 17, 2021 at 5:36 PM Alex Ghiti <alex@ghiti.fr> wrote:
> >>>>>>>>
> >>>>>>>> Le 2/16/21 =C3=A0 11:42 PM, Dmitry Vyukov a =C3=A9crit :
> >>>>>>>>> On Tue, Feb 16, 2021 at 9:42 PM Alex Ghiti <alex@ghiti.fr> wrot=
e:
> >>>>>>>>>>
> >>>>>>>>>> Hi Dmitry,
> >>>>>>>>>>
> >>>>>>>>>> Le 2/16/21 =C3=A0 6:25 AM, Dmitry Vyukov a =C3=A9crit :
> >>>>>>>>>>> On Tue, Feb 16, 2021 at 12:17 PM Dmitry Vyukov <dvyukov@googl=
e.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On Fri, Jan 29, 2021 at 9:11 AM Dmitry Vyukov <dvyukov@googl=
e.com> wrote:
> >>>>>>>>>>>>>> I was fixing KASAN support for my sv48 patchset so I took =
a look at your
> >>>>>>>>>>>>>> issue: I built a kernel on top of the branch riscv/fixes u=
sing
> >>>>>>>>>>>>>> https://github.com/google/syzkaller/blob/269d24e857a757d09=
a898086a2fa6fa5d827c3e1/dashboard/config/linux/upstream-riscv64-kasan.confi=
g
> >>>>>>>>>>>>>> and Buildroot 2020.11. I have the warnings regarding the u=
se of
> >>>>>>>>>>>>>> __virt_to_phys on wrong addresses (but that's normal since=
 this function
> >>>>>>>>>>>>>> is used in virt_addr_valid) but not the segfaults you desc=
ribe.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Hi Alex,
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Let me try to rebuild buildroot image. Maybe there was some=
thing wrong
> >>>>>>>>>>>>> with my build, though, I did 'make clean' before doing. But=
 at the
> >>>>>>>>>>>>> same time it worked back in June...
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Re WARNINGs, they indicate kernel bugs. I am working on set=
ting up a
> >>>>>>>>>>>>> syzbot instance on riscv. If there a WARNING during boot th=
en the
> >>>>>>>>>>>>> kernel will be marked as broken. No further testing will ha=
ppen.
> >>>>>>>>>>>>> Is it a mis-use of WARN_ON? If so, could anybody please rem=
ove it or
> >>>>>>>>>>>>> replace it with pr_err.
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Hi,
> >>>>>>>>>>>>
> >>>>>>>>>>>> I've localized one issue with riscv/KASAN:
> >>>>>>>>>>>> KASAN breaks VDSO and that's I think the root cause of weird=
 faults I
> >>>>>>>>>>>> saw earlier. The following patch fixes it.
> >>>>>>>>>>>> Could somebody please upstream this fix? I don't know how to=
 add/run
> >>>>>>>>>>>> tests for this.
> >>>>>>>>>>>> Thanks
> >>>>>>>>>>>>
> >>>>>>>>>>>> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/ke=
rnel/vdso/Makefile
> >>>>>>>>>>>> index 0cfd6da784f84..cf3a383c1799d 100644
> >>>>>>>>>>>> --- a/arch/riscv/kernel/vdso/Makefile
> >>>>>>>>>>>> +++ b/arch/riscv/kernel/vdso/Makefile
> >>>>>>>>>>>> @@ -35,6 +35,7 @@ CFLAGS_REMOVE_vgettimeofday.o =3D $(CC_FLA=
GS_FTRACE) -Os
> >>>>>>>>>>>>       # Disable gcov profiling for VDSO code
> >>>>>>>>>>>>       GCOV_PROFILE :=3D n
> >>>>>>>>>>>>       KCOV_INSTRUMENT :=3D n
> >>>>>>>>>>>> +KASAN_SANITIZE :=3D n
> >>>>>>>>>>>>
> >>>>>>>>>>>>       # Force dependency
> >>>>>>>>>>>>       $(obj)/vdso.o: $(obj)/vdso.so
> >>>>>>>>>>
> >>>>>>>>>> What's weird is that I don't have any issue without this patch=
 with the
> >>>>>>>>>> following config whereas it indeed seems required for KASAN. B=
ut when
> >>>>>>>>>> looking at the segfaults you got earlier, the segfault address=
 is 0xbb0
> >>>>>>>>>> and the cause is an instruction page fault: this address is th=
e PLT base
> >>>>>>>>>> address in vdso.so and an instruction page fault would mean th=
at someone
> >>>>>>>>>> tried to jump at this address, which is weird. At first sight,=
 that does
> >>>>>>>>>> not seem related to your patch above, but clearly I may be wro=
ng.
> >>>>>>>>>>
> >>>>>>>>>> Tobias, did you observe the same segfaults as Dmitry ?
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> I noticed that not all buildroot images use VDSO, it seems to b=
e
> >>>>>>>>> dependent on libc settings (at least I think I changed it in th=
e
> >>>>>>>>> past).
> >>>>>>>>
> >>>>>>>> Ok, I used uClibc but then when using glibc, I have the same seg=
faults,
> >>>>>>>> only when KASAN is enabled. And your patch fixes the problem. I =
will try
> >>>>>>>> to take a look later to better understand the problem.
> >>>>>>>>
> >>>>>>>>> I also booted an image completely successfully including dhcpd/=
sshd
> >>>>>>>>> start, but then my executable crashed in clock_gettime. The exe=
cutable
> >>>>>>>>> was build on linux/amd64 host with "riscv64-linux-gnu-gcc -stat=
ic"
> >>>>>>>>> (10.2.1).
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>> Second issue I am seeing seems to be related to text segment =
size.
> >>>>>>>>>>> I check out v5.11 and use this config:
> >>>>>>>>>>> https://gist.github.com/dvyukov/6af25474d455437577a84213b0cc9=
178
> >>>>>>>>>>
> >>>>>>>>>> This config gave my laptop a hard time ! Finally I was able to=
 boot
> >>>>>>>>>> correctly to userspace, but I realized I used my sv48 branch..=
.Either I
> >>>>>>>>>> fixed your issue along the way or I can't reproduce it, I'll g=
ive it a
> >>>>>>>>>> try tomorrow.
> >>>>>>>>>
> >>>>>>>>> Where is your branch? I could also test in my setup on your bra=
nch.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> You can find my branch int/alex/riscv_kernel_end_of_address_spac=
e_v2
> >>>>>>>> here: https://github.com/AlexGhiti/riscv-linux.git
> >>>>>>>
> >>>>>>> No, it does not work for me.
> >>>>>>>
> >>>>>>> Source is on b61ab6c98de021398cd7734ea5fc3655e51e70f2 (HEAD,
> >>>>>>> int/alex/riscv_kernel_end_of_address_space_v2)
> >>>>>>> Config is https://gist.githubusercontent.com/dvyukov/6af25474d455=
437577a84213b0cc9178/raw/55b116522c14a8a98a7626d76df740d54f648ce5/gistfile1=
.txt
> >>>>>>>
> >>>>>>> riscv64-linux-gnu-gcc -v
> >>>>>>> gcc version 10.2.1 20210110 (Debian 10.2.1-6+build1)
> >>>>>>>
> >>>>>>> qemu-system-riscv64 --version
> >>>>>>> QEMU emulator version 5.2.0 (Debian 1:5.2+dfsg-3)
> >>>>>>>
> >>>>>>> qemu-system-riscv64 \
> >>>>>>> -machine virt -smp 2 -m 2G \
> >>>>>>> -device virtio-blk-device,drive=3Dhd0 \
> >>>>>>> -drive file=3Dimage-riscv64,if=3Dnone,format=3Draw,id=3Dhd0 \
> >>>>>>> -kernel arch/riscv/boot/Image \
> >>>>>>> -nographic \
> >>>>>>> -device virtio-rng-device,rng=3Drng0 -object
> >>>>>>> rng-random,filename=3D/dev/urandom,id=3Drng0 \
> >>>>>>> -netdev user,id=3Dnet0,host=3D10.0.2.10,hostfwd=3Dtcp::10022-:22 =
-device
> >>>>>>> virtio-net-device,netdev=3Dnet0 \
> >>>>>>> -append "root=3D/dev/vda earlyprintk=3Dserial console=3DttyS0 oop=
s=3Dpanic
> >>>>>>> panic_on_warn=3D1 panic=3D86400 earlycon"
> >>>>>>
> >>>>>> It still works for me but I had to disable CONFIG_DEBUG_INFO_BTF (=
I
> >>>>>> don't think that changes anything at runtime). But your above comm=
and
> >>>>>> line does not work for me as it appears you do not load any firmwa=
re, if
> >>>>>> I add -bios images/fw_jump.elf, it works. But then I don't know wh=
ere
> >>>>>> your opensbi output below comes from...
> >>>>>>
> >>>>>> And regarding your issue with calling clock_gettime 'directly' com=
pared
> >>>>>> to using the syscall, I have the same consistent output from both =
calls.
> >>>>>>
> >>>>>> I have an older gcc (9.3.0) and the same qemu. I think what is mis=
sing
> >>>>>> here is your buildroot config, so that we have the exact same
> >>>>>> environment: could you post your buildroot config as well ?
> >>>>>
> >>>>> I don't think the image is relevant because I don't even get to ker=
nel
> >>>>> code. If the kernel will complain about no init later, that's fine.
> >>>>> Re bios, this version of qemu already has OpenSBI bios builtin, you
> >>>>> can pass -bios default, but that's, well, the default :)
> >>>>> Here are more reproducible repro instructions that capture gcc and
> >>>>> qemu. I think gcc version may be potentially relevant as I suspect
> >>>>> code size.
> >>>>>
> >>>>>
> >>>>> curl https://gist.githubusercontent.com/dvyukov/6af25474d455437577a=
84213b0cc9178/raw/55b116522c14a8a98a7626d76df740d54f648ce5/gistfile1.txt
> >>>>>> $KERNEL_SRC/.config
> >>>>> docker pull gcr.io/syzkaller/syzbot
> >>>>> docker run -it -v $KERNEL_SRC:/kernel gcr.io/syzkaller/syzbot
> >>>>> cd /kernel
> >>>>> make -j72 ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- olddefcon=
fig
> >>>>> make -j72 ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu-
> >>>>> qemu-system-riscv64 -machine virt -smp 2 -m 4G -kernel
> >>>>> arch/riscv/boot/Image -nographic -append "earlycon earlyprintk=3Dse=
rial
> >>>>> console=3DttyS0"
> >>>>> [this does not, only OpenSBI output]
> >>>>>
> >>>>
> >>>> Indeed the issue was code size, please find the fix below. I will se=
nd a
> >>>> proper patch once I made sure the fix is the right one, but I'm pret=
ty
> >>>> confident, there's no reason to limit the mapping size to 128MB wher=
eas
> >>>> we have a whole pgdir.
> >>>
> >>> Great you get to the bottom of this!
> >>> Riscv kernels are going to be YUGE!
> >>
> >> IIRC I tried that a while ago and it didn't work.  It's possible I was=
 just
> >> running into some other bug, but I'm just build testing allyesconfig a=
s opposed
> >> to boot testing it.
> >>
> >> If you've got a setup that does boot I'm happy to take a patch, though=
.  It'll
> >> at least be one step forward.
> >
> >
> >
> > OK, it's getting better.
>
> Nice :)
>
> > The next issue is called "512 bytes should be enough for everyone!" :)
> > https://elixir.bootlin.com/linux/v5.12-rc2/source/include/uapi/asm-gene=
ric/setup.h#L5
> > Most other arches redefine it to something bigger:
> > https://elixir.bootlin.com/linux/v5.12-rc2/source/arch/s390/include/uap=
i/asm/setup.h#L10
> > even arm32 redefines it.
> > I am not sure the default is even reasonable anymore.
>
> Some archs override this value to 256, but git blame shows this is
> (very) old. I agree that 512 as default seems low.
>
> > Failure mode is
> > also not nice (silent truncation).
>
> Agreed, maybe we could still have the default value and checks the
> terminating null character is somewhere and bugs if not, I'll take a look=
.
>
> > We are trying to pass this:
> >
> > earlyprintk=3Dserial oops=3Dpanic nmi_watchdog=3Dpanic panic=3D86400
> > net.ifnames=3D0 sysctl.kernel.hung_task_all_cpu_backtrace=3D1
> > ima_policy=3Dtcb kvm-intel.nested=3D1 nf-conntrack-ftp.ports=3D20000
> > nf-conntrack-tftp.ports=3D20000 nf-conntrack-sip.ports=3D20000
> > nf-conntrack-irc.ports=3D20000 nf-conntrack-sane.ports=3D20000
> > vivid.n_devs=3D16 vivid.multiplanar=3D1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2
> > netrom.nr_ndevs=3D16 rose.rose_ndevs=3D16 spec_store_bypass_disable=3Dp=
rctl
> > numa=3Dfake=3D2 nopcid dummy_hcd.num=3D8 binder.debug_mask=3D0
> > rcupdate.rcu_expedited=3D1 watchdog_thresh=3D165
> > workqueue.watchdog_thresh=3D420 panic_on_warn=3D1
> >
> > The last part gets truncated and we are getting false workqueue watchdo=
g stalls.
> >
> > Could you please increase it?
>
> I will propose a patchset that increases the default value and cleans
> archs up accordingly too.

I've worked around the command line length for now by reducing command
line size.
The syzbot instance is alive and kicking now:
https://syzkaller.appspot.com/upstream?manager=3Dci-qemu2-riscv64

with the first issue found:
https://syzkaller.appspot.com/bug?extid=3De74b94fe601ab9552d69
https://lore.kernel.org/lkml/000000000000b74f1b05bd316729@google.com/T/#u

in my local testing it was happening very frequently, so until it's
fixed, the instance probably won't find lots of other issues.

FTR, the instance config is stored here:
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/upst=
ream-riscv64-kasan.config

The instance uses qemu emulation and heavy debug configs, so it's
quite slow and it makes sense to target it at riscv-specific parts of
the kernel (rather than stress generic subsystems that are already
stressed on x86).
So the question is: what riscv-specific parts are there that we reach?
Can you think of any qemu flags (cpu features, device emulation,
pstore, etc)? Any kernel parts that we may be missing?

Thanks
