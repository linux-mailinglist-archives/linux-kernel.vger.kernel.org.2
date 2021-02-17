Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F5131DE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 18:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhBQRkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 12:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbhBQRfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 12:35:30 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56090C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 09:34:44 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d3so10108877qtr.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 09:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MgKsBgrGyhwtzE/6qlT5wngkdOMFLt8gJJdt2mK9ZGk=;
        b=DiGe+QN5Uo/tmIiCKHYF9lEMom0CiBL8O13EQa8qIom9BM3iKtBmlLkHwvfJFxW6qJ
         FzpStLRJPny+/AEme7l+RRMjy/IVN3jsnUEQITJoD0R4D0yb5B6kCf3dMcJa/E94gUh0
         /p+doTVzkX0BCfaFE6ajPveUo5EKe65mxYoZdJqtC2ryuMMWOhz9x/sZgMhOM/vVN/7Z
         hB4UloCfXh4Dsx4DkBFe6ZhYwwQa+8+jsKN6c+9zWbmP/p2aEpIbk4+nKrnXhw/pfO/j
         VaMzLU6v0URB1gy1ePmbzEL9nie60q4GpfYQw6cH1yB7J5zYIeP6PRm3gTsE8yj+BMnk
         XBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MgKsBgrGyhwtzE/6qlT5wngkdOMFLt8gJJdt2mK9ZGk=;
        b=KyyKIX0anK8XU36sXWebkNbFQPYaARpVP5c6bdauAuel7X/rtiesomG2hXLHd2BhW5
         KiFYxzMuIIcFp3YsfldgLc78MkEHRvI80OktkJ3IU/5dUHlKJi7AVZ1s8kJMjhUmop7b
         yQ2r4cN1URZLJGLahjgfWAyPouh13TUx1czihti0fAu5GgTd21Bq/gxH7KgRuJ12Q7Xh
         mjinkzpg10f+rag6io1haxmTTli5PEhrAi89yppQXgc7GFR4XzNUHWJRQL5E1Ud6C8t2
         1VRO8Zqq7gaVr9iPCAKliAfWV2/cWU5ym17ncR0VaB+iyxmd5XOQ5V4INH+jyv0pRiqr
         VPQg==
X-Gm-Message-State: AOAM5335MSJZNn79QxEjj+PP9Qmnj2bQpPl4tIKCnkpE8V4KrzbQ44bR
        z64+DaL6Vj0kBLPHqSCU7XGPkFs+4YgcI/zIxRPfbw==
X-Google-Smtp-Source: ABdhPJzC41zreNDsOlI8EGj6IJV4jWHImMOCeVrFkM6lq1I/rHVmwRbEiBD7mryrNHYAwIvw2IMPsO2t1JHGif4x6Kc=
X-Received: by 2002:aed:3647:: with SMTP id e65mr333567qtb.43.1613583283082;
 Wed, 17 Feb 2021 09:34:43 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+bDqMiC+ou5ghb=XB3Oyjw3p-GTDvNw4NkkQqQthw1yuQ@mail.gmail.com>
 <mhng-02b88d43-ede8-48f9-82f1-c84201acb7a8@palmerdabbelt-glaptop>
 <CACT4Y+aN3LvgaBc_zmW=t=D7ChU-jrWYnjt5sZ2GEDQhg_BC9A@mail.gmail.com>
 <CACT4Y+aC19DaNOm87EO3cER2=MEmO9pmtUxzVmRtg9YhZKuMVA@mail.gmail.com>
 <20210118145310.crnqnh6kax5jqicj@distanz.ch> <CACT4Y+bFV6m1LCYb1nO7ioKJK99916D76sJ+H-LgBjWx6biF5w@mail.gmail.com>
 <CACT4Y+bmDKNnykeTP9yKjje3XZjbXY3De+_e3fMFOMoe0dnARw@mail.gmail.com>
 <6e9ee3a1-0e16-b1fc-a690-f1ca8e9823a5@ghiti.fr> <CACT4Y+adSjve7bXRPh5UybCQx6ubOUu5RbwuT620wdcxHzVYJg@mail.gmail.com>
 <CACT4Y+ZNJBnkKHXUf=tm_yuowvZvHwN=0rmJ=7J+xFd+9r_6pQ@mail.gmail.com>
 <CACT4Y+awHrJfFo+g33AiAnCj3vq6t6PqbL-3=Qbciy6dAJfVWg@mail.gmail.com>
 <24857bfc-c557-f141-8ae7-2e3da24f67f5@ghiti.fr> <CACT4Y+bmuhR=2u=1bGK+W8ttOn+=bkKrqCRM8_SiDSW1iAX60A@mail.gmail.com>
 <957f09fb-84f4-2e0a-13ab-f7e4831ee7d0@ghiti.fr>
In-Reply-To: <957f09fb-84f4-2e0a-13ab-f7e4831ee7d0@ghiti.fr>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 17 Feb 2021 18:34:31 +0100
Message-ID: <CACT4Y+ZmuOpyf_0vHTT4t3wkmJuW8Ezvcg7v6yDVd8YOViS=GA@mail.gmail.com>
Subject: Re: riscv+KASAN does not boot
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Bjorn Topel <bjorn.topel@gmail.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
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

On Wed, Feb 17, 2021 at 5:36 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Le 2/16/21 =C3=A0 11:42 PM, Dmitry Vyukov a =C3=A9crit :
> > On Tue, Feb 16, 2021 at 9:42 PM Alex Ghiti <alex@ghiti.fr> wrote:
> >>
> >> Hi Dmitry,
> >>
> >> Le 2/16/21 =C3=A0 6:25 AM, Dmitry Vyukov a =C3=A9crit :
> >>> On Tue, Feb 16, 2021 at 12:17 PM Dmitry Vyukov <dvyukov@google.com> w=
rote:
> >>>>
> >>>> On Fri, Jan 29, 2021 at 9:11 AM Dmitry Vyukov <dvyukov@google.com> w=
rote:
> >>>>>> I was fixing KASAN support for my sv48 patchset so I took a look a=
t your
> >>>>>> issue: I built a kernel on top of the branch riscv/fixes using
> >>>>>> https://github.com/google/syzkaller/blob/269d24e857a757d09a898086a=
2fa6fa5d827c3e1/dashboard/config/linux/upstream-riscv64-kasan.config
> >>>>>> and Buildroot 2020.11. I have the warnings regarding the use of
> >>>>>> __virt_to_phys on wrong addresses (but that's normal since this fu=
nction
> >>>>>> is used in virt_addr_valid) but not the segfaults you describe.
> >>>>>
> >>>>> Hi Alex,
> >>>>>
> >>>>> Let me try to rebuild buildroot image. Maybe there was something wr=
ong
> >>>>> with my build, though, I did 'make clean' before doing. But at the
> >>>>> same time it worked back in June...
> >>>>>
> >>>>> Re WARNINGs, they indicate kernel bugs. I am working on setting up =
a
> >>>>> syzbot instance on riscv. If there a WARNING during boot then the
> >>>>> kernel will be marked as broken. No further testing will happen.
> >>>>> Is it a mis-use of WARN_ON? If so, could anybody please remove it o=
r
> >>>>> replace it with pr_err.
> >>>>
> >>>>
> >>>> Hi,
> >>>>
> >>>> I've localized one issue with riscv/KASAN:
> >>>> KASAN breaks VDSO and that's I think the root cause of weird faults =
I
> >>>> saw earlier. The following patch fixes it.
> >>>> Could somebody please upstream this fix? I don't know how to add/run
> >>>> tests for this.
> >>>> Thanks
> >>>>
> >>>> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vds=
o/Makefile
> >>>> index 0cfd6da784f84..cf3a383c1799d 100644
> >>>> --- a/arch/riscv/kernel/vdso/Makefile
> >>>> +++ b/arch/riscv/kernel/vdso/Makefile
> >>>> @@ -35,6 +35,7 @@ CFLAGS_REMOVE_vgettimeofday.o =3D $(CC_FLAGS_FTRAC=
E) -Os
> >>>>    # Disable gcov profiling for VDSO code
> >>>>    GCOV_PROFILE :=3D n
> >>>>    KCOV_INSTRUMENT :=3D n
> >>>> +KASAN_SANITIZE :=3D n
> >>>>
> >>>>    # Force dependency
> >>>>    $(obj)/vdso.o: $(obj)/vdso.so
> >>
> >> What's weird is that I don't have any issue without this patch with th=
e
> >> following config whereas it indeed seems required for KASAN. But when
> >> looking at the segfaults you got earlier, the segfault address is 0xbb=
0
> >> and the cause is an instruction page fault: this address is the PLT ba=
se
> >> address in vdso.so and an instruction page fault would mean that someo=
ne
> >> tried to jump at this address, which is weird. At first sight, that do=
es
> >> not seem related to your patch above, but clearly I may be wrong.
> >>
> >> Tobias, did you observe the same segfaults as Dmitry ?
> >
> >
> > I noticed that not all buildroot images use VDSO, it seems to be
> > dependent on libc settings (at least I think I changed it in the
> > past).
>
> Ok, I used uClibc but then when using glibc, I have the same segfaults,
> only when KASAN is enabled. And your patch fixes the problem. I will try
> to take a look later to better understand the problem.
>
> > I also booted an image completely successfully including dhcpd/sshd
> > start, but then my executable crashed in clock_gettime. The executable
> > was build on linux/amd64 host with "riscv64-linux-gnu-gcc -static"
> > (10.2.1).
> >
> >
> >>> Second issue I am seeing seems to be related to text segment size.
> >>> I check out v5.11 and use this config:
> >>> https://gist.github.com/dvyukov/6af25474d455437577a84213b0cc9178
> >>
> >> This config gave my laptop a hard time ! Finally I was able to boot
> >> correctly to userspace, but I realized I used my sv48 branch...Either =
I
> >> fixed your issue along the way or I can't reproduce it, I'll give it a
> >> try tomorrow.
> >
> > Where is your branch? I could also test in my setup on your branch.
> >
>
> You can find my branch int/alex/riscv_kernel_end_of_address_space_v2
> here: https://github.com/AlexGhiti/riscv-linux.git

No, it does not work for me.

Source is on b61ab6c98de021398cd7734ea5fc3655e51e70f2 (HEAD,
int/alex/riscv_kernel_end_of_address_space_v2)
Config is https://gist.githubusercontent.com/dvyukov/6af25474d455437577a842=
13b0cc9178/raw/55b116522c14a8a98a7626d76df740d54f648ce5/gistfile1.txt

riscv64-linux-gnu-gcc -v
gcc version 10.2.1 20210110 (Debian 10.2.1-6+build1)

qemu-system-riscv64 --version
QEMU emulator version 5.2.0 (Debian 1:5.2+dfsg-3)

qemu-system-riscv64 \
-machine virt -smp 2 -m 2G \
-device virtio-blk-device,drive=3Dhd0 \
-drive file=3Dimage-riscv64,if=3Dnone,format=3Draw,id=3Dhd0 \
-kernel arch/riscv/boot/Image \
-nographic \
-device virtio-rng-device,rng=3Drng0 -object
rng-random,filename=3D/dev/urandom,id=3Drng0 \
-netdev user,id=3Dnet0,host=3D10.0.2.10,hostfwd=3Dtcp::10022-:22 -device
virtio-net-device,netdev=3Dnet0 \
-append "root=3D/dev/vda earlyprintk=3Dserial console=3DttyS0 oops=3Dpanic
panic_on_warn=3D1 panic=3D86400 earlycon"

OpenSBI v0.8
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name       : riscv-virtio,qemu
Platform Features   : timer,mfdeleg
Platform HART Count : 2
Boot HART ID        : 1
Boot HART ISA       : rv64imafdcsu
BOOT HART Features  : pmp,scounteren,mcounteren,time
BOOT HART PMP Count : 16
Firmware Base       : 0x80000000
Firmware Size       : 104 KB
Runtime SBI Version : 0.2

MIDELEG : 0x0000000000000222
MEDELEG : 0x000000000000b109
PMP0    : 0x0000000080000000-0x000000008001ffff (A)


no output after this
PMP1    : 0x0000000000000000-0xffffffffffffffff (A,R,W,X)



> Thanks,
>
> >
> >>> Then trying to boot it using:
> >>> QEMU emulator version 5.2.0 (Debian 1:5.2+dfsg-3)
> >>> $ qemu-system-riscv64 -machine virt -smp 2 -m 4G ...
> >>>
> >>> It shows no output from the kernel whatsoever, even though I have
> >>> earlycon and output shows very early with other configs.
> >>> Kernel boots fine with defconfig and other smaller configs.
> >>>
> >>> If I enable KASAN_OUTLINE and CC_OPTIMIZE_FOR_SIZE, then this config
> >>> also boots fine. Both of these options significantly reduce kernel
> >>> size. However, I can also boot the kernel without these 2 configs, if
> >>> I disable a whole lot of subsystem configs. This makes me think that
> >>> there is an issue related to kernel size somewhere in
> >>> qemu/bootloader/kernel bootstrap code.
> >>> Does it make sense to you? Can somebody reproduce what I am seeing? >
> >>
> >> I did not bring any answer to your question, but at least you know I'm
> >> working on it, I'll keep you posted.
> >>
> >> Thanks for taking the time to setup syzkaller.
> >>
> >> Alex
> >>
> >>> Thanks
> >>>
> >>> _______________________________________________
> >>> linux-riscv mailing list
> >>> linux-riscv@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >>>
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
