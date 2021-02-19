Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8493B31FF00
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 19:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhBSSyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 13:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhBSSyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 13:54:36 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7EAC061756
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 10:53:55 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 81so6545217qkf.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 10:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y2ldnUb4nw3qm3loSiner0qi237zYJGyc/9RsX2NuUQ=;
        b=u+XYV0cbX09MEuP7UgTx9MPpmBzHSAF0r+Anbg4Wmz44sTPbPVavuyisA3LAmRQMPs
         dmyO8OV4A6WMzbHsVeYkGEB40gCl4YzCTP9ul/k+EOR+/yPuCkIMhhwJuqWV/m0LKYIF
         2ddcRT5mBYSMaJLoTdzCPZKDepdVGYl/dvivKzP73hGYJaUOXAazRVsfRoUOrS/LrLey
         cQ+WKWc16h6aQI0mdhSuoM+Jqum75tWxs0M3dpGfk9D+OtAByc/7WF+FYOpeAGg7KOT6
         2NsWgimkA/zl/jMGTHsm4Y/b34q/AZxgjOE6ASQTsXgPrmbqYBS5cisthzsYnSfLtIaG
         gZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y2ldnUb4nw3qm3loSiner0qi237zYJGyc/9RsX2NuUQ=;
        b=BMOLJ8xQBqIuRYZh41XF8ixSXa042eDzxaFsHszjP6R9l4QtsOMSoXnZKU8w1dS6Oy
         jGOCsPMT5eMzV/MpdKbvHanVpDFYqSb/Hdhz6t8+9+PMM9E4X2q1GqZrYn1y2CVSy/FR
         h0QtvRR1AVU5QAk3wcRC96SuZW1zWkD90lDwRtpUDgWSuTIz4sQCNn7tuo7hGN86Z3EL
         qepk3RkweV69Nm5Q/fs1PzPfd1ki5jiMeNpKq1TYiL/91O77+QUggIi2xWkiOGvamlL/
         HjbGbmCKMpGufaeRXYSX8Nc8y6XQpZBfBTkuoPgg4156YWyTm7/f682w4mo0JVSi1I/5
         L1Ig==
X-Gm-Message-State: AOAM533MF+KYoC9HhKfKK8dV9BzGGUZqO5R4yAk8Zmz2Gj9x9PdjxLOm
        kDRIc8dKyLmj56+UIc5Ikzp0x0Q0lNO3MZO5nJrpzQ==
X-Google-Smtp-Source: ABdhPJxiltfL9a/F8qzqd1yIqTolah1trITzPV/4LTTKfwHzCRS/D0xADfgJPvBgmVj8DjdDbyFECVDHK3QzSMxSJJc=
X-Received: by 2002:a05:620a:410f:: with SMTP id j15mr11057203qko.424.1613760834343;
 Fri, 19 Feb 2021 10:53:54 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+bDqMiC+ou5ghb=XB3Oyjw3p-GTDvNw4NkkQqQthw1yuQ@mail.gmail.com>
 <CACT4Y+aC19DaNOm87EO3cER2=MEmO9pmtUxzVmRtg9YhZKuMVA@mail.gmail.com>
 <20210118145310.crnqnh6kax5jqicj@distanz.ch> <CACT4Y+bFV6m1LCYb1nO7ioKJK99916D76sJ+H-LgBjWx6biF5w@mail.gmail.com>
 <CACT4Y+bmDKNnykeTP9yKjje3XZjbXY3De+_e3fMFOMoe0dnARw@mail.gmail.com>
 <6e9ee3a1-0e16-b1fc-a690-f1ca8e9823a5@ghiti.fr> <CACT4Y+adSjve7bXRPh5UybCQx6ubOUu5RbwuT620wdcxHzVYJg@mail.gmail.com>
 <CACT4Y+ZNJBnkKHXUf=tm_yuowvZvHwN=0rmJ=7J+xFd+9r_6pQ@mail.gmail.com>
 <CACT4Y+awHrJfFo+g33AiAnCj3vq6t6PqbL-3=Qbciy6dAJfVWg@mail.gmail.com>
 <24857bfc-c557-f141-8ae7-2e3da24f67f5@ghiti.fr> <CACT4Y+bmuhR=2u=1bGK+W8ttOn+=bkKrqCRM8_SiDSW1iAX60A@mail.gmail.com>
 <957f09fb-84f4-2e0a-13ab-f7e4831ee7d0@ghiti.fr> <CACT4Y+ZmuOpyf_0vHTT4t3wkmJuW8Ezvcg7v6yDVd8YOViS=GA@mail.gmail.com>
 <c8f072b8-0b8c-fa78-da6c-cac8b6711603@ghiti.fr> <CACT4Y+agHHFsq1fA5dwESf+oZerC3NBM+2kFAFxyHVd+Xu6crQ@mail.gmail.com>
 <31dfbbbf-79ff-1204-2e9d-dc62630acd36@ghiti.fr>
In-Reply-To: <31dfbbbf-79ff-1204-2e9d-dc62630acd36@ghiti.fr>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 19 Feb 2021 19:53:43 +0100
Message-ID: <CACT4Y+bNzJtwwrHsOa7Ftnaj7B+TPd35=QRLKDE-UuaPJoaDkw@mail.gmail.com>
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

On Fri, Feb 19, 2021 at 6:01 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi Dmitry,
>
> Le 2/18/21 =C3=A0 6:36 AM, Dmitry Vyukov a =C3=A9crit :
> > On Thu, Feb 18, 2021 at 8:54 AM Alex Ghiti <alex@ghiti.fr> wrote:
> >>
> >> Hi Dmitry,
> >>
> >>> On Wed, Feb 17, 2021 at 5:36 PM Alex Ghiti <alex@ghiti.fr> wrote:
> >>>>
> >>>> Le 2/16/21 =C3=A0 11:42 PM, Dmitry Vyukov a =C3=A9crit :
> >>>>> On Tue, Feb 16, 2021 at 9:42 PM Alex Ghiti <alex@ghiti.fr> wrote:
> >>>>>>
> >>>>>> Hi Dmitry,
> >>>>>>
> >>>>>> Le 2/16/21 =C3=A0 6:25 AM, Dmitry Vyukov a =C3=A9crit :
> >>>>>>> On Tue, Feb 16, 2021 at 12:17 PM Dmitry Vyukov <dvyukov@google.co=
m> wrote:
> >>>>>>>>
> >>>>>>>> On Fri, Jan 29, 2021 at 9:11 AM Dmitry Vyukov <dvyukov@google.co=
m> wrote:
> >>>>>>>>>> I was fixing KASAN support for my sv48 patchset so I took a lo=
ok at your
> >>>>>>>>>> issue: I built a kernel on top of the branch riscv/fixes using
> >>>>>>>>>> https://github.com/google/syzkaller/blob/269d24e857a757d09a898=
086a2fa6fa5d827c3e1/dashboard/config/linux/upstream-riscv64-kasan.config
> >>>>>>>>>> and Buildroot 2020.11. I have the warnings regarding the use o=
f
> >>>>>>>>>> __virt_to_phys on wrong addresses (but that's normal since thi=
s function
> >>>>>>>>>> is used in virt_addr_valid) but not the segfaults you describe=
.
> >>>>>>>>>
> >>>>>>>>> Hi Alex,
> >>>>>>>>>
> >>>>>>>>> Let me try to rebuild buildroot image. Maybe there was somethin=
g wrong
> >>>>>>>>> with my build, though, I did 'make clean' before doing. But at =
the
> >>>>>>>>> same time it worked back in June...
> >>>>>>>>>
> >>>>>>>>> Re WARNINGs, they indicate kernel bugs. I am working on setting=
 up a
> >>>>>>>>> syzbot instance on riscv. If there a WARNING during boot then t=
he
> >>>>>>>>> kernel will be marked as broken. No further testing will happen=
.
> >>>>>>>>> Is it a mis-use of WARN_ON? If so, could anybody please remove =
it or
> >>>>>>>>> replace it with pr_err.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> I've localized one issue with riscv/KASAN:
> >>>>>>>> KASAN breaks VDSO and that's I think the root cause of weird fau=
lts I
> >>>>>>>> saw earlier. The following patch fixes it.
> >>>>>>>> Could somebody please upstream this fix? I don't know how to add=
/run
> >>>>>>>> tests for this.
> >>>>>>>> Thanks
> >>>>>>>>
> >>>>>>>> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel=
/vdso/Makefile
> >>>>>>>> index 0cfd6da784f84..cf3a383c1799d 100644
> >>>>>>>> --- a/arch/riscv/kernel/vdso/Makefile
> >>>>>>>> +++ b/arch/riscv/kernel/vdso/Makefile
> >>>>>>>> @@ -35,6 +35,7 @@ CFLAGS_REMOVE_vgettimeofday.o =3D $(CC_FLAGS_F=
TRACE) -Os
> >>>>>>>>      # Disable gcov profiling for VDSO code
> >>>>>>>>      GCOV_PROFILE :=3D n
> >>>>>>>>      KCOV_INSTRUMENT :=3D n
> >>>>>>>> +KASAN_SANITIZE :=3D n
> >>>>>>>>
> >>>>>>>>      # Force dependency
> >>>>>>>>      $(obj)/vdso.o: $(obj)/vdso.so
> >>>>>>
> >>>>>> What's weird is that I don't have any issue without this patch wit=
h the
> >>>>>> following config whereas it indeed seems required for KASAN. But w=
hen
> >>>>>> looking at the segfaults you got earlier, the segfault address is =
0xbb0
> >>>>>> and the cause is an instruction page fault: this address is the PL=
T base
> >>>>>> address in vdso.so and an instruction page fault would mean that s=
omeone
> >>>>>> tried to jump at this address, which is weird. At first sight, tha=
t does
> >>>>>> not seem related to your patch above, but clearly I may be wrong.
> >>>>>>
> >>>>>> Tobias, did you observe the same segfaults as Dmitry ?
> >>>>>
> >>>>>
> >>>>> I noticed that not all buildroot images use VDSO, it seems to be
> >>>>> dependent on libc settings (at least I think I changed it in the
> >>>>> past).
> >>>>
> >>>> Ok, I used uClibc but then when using glibc, I have the same segfaul=
ts,
> >>>> only when KASAN is enabled. And your patch fixes the problem. I will=
 try
> >>>> to take a look later to better understand the problem.
> >>>>
> >>>>> I also booted an image completely successfully including dhcpd/sshd
> >>>>> start, but then my executable crashed in clock_gettime. The executa=
ble
> >>>>> was build on linux/amd64 host with "riscv64-linux-gnu-gcc -static"
> >>>>> (10.2.1).
> >>>>>
> >>>>>
> >>>>>>> Second issue I am seeing seems to be related to text segment size=
.
> >>>>>>> I check out v5.11 and use this config:
> >>>>>>> https://gist.github.com/dvyukov/6af25474d455437577a84213b0cc9178
> >>>>>>
> >>>>>> This config gave my laptop a hard time ! Finally I was able to boo=
t
> >>>>>> correctly to userspace, but I realized I used my sv48 branch...Eit=
her I
> >>>>>> fixed your issue along the way or I can't reproduce it, I'll give =
it a
> >>>>>> try tomorrow.
> >>>>>
> >>>>> Where is your branch? I could also test in my setup on your branch.
> >>>>>
> >>>>
> >>>> You can find my branch int/alex/riscv_kernel_end_of_address_space_v2
> >>>> here: https://github.com/AlexGhiti/riscv-linux.git
> >>>
> >>> No, it does not work for me.
> >>>
> >>> Source is on b61ab6c98de021398cd7734ea5fc3655e51e70f2 (HEAD,
> >>> int/alex/riscv_kernel_end_of_address_space_v2)
> >>> Config is https://gist.githubusercontent.com/dvyukov/6af25474d4554375=
77a84213b0cc9178/raw/55b116522c14a8a98a7626d76df740d54f648ce5/gistfile1.txt
> >>>
> >>> riscv64-linux-gnu-gcc -v
> >>> gcc version 10.2.1 20210110 (Debian 10.2.1-6+build1)
> >>>
> >>> qemu-system-riscv64 --version
> >>> QEMU emulator version 5.2.0 (Debian 1:5.2+dfsg-3)
> >>>
> >>> qemu-system-riscv64 \
> >>> -machine virt -smp 2 -m 2G \
> >>> -device virtio-blk-device,drive=3Dhd0 \
> >>> -drive file=3Dimage-riscv64,if=3Dnone,format=3Draw,id=3Dhd0 \
> >>> -kernel arch/riscv/boot/Image \
> >>> -nographic \
> >>> -device virtio-rng-device,rng=3Drng0 -object
> >>> rng-random,filename=3D/dev/urandom,id=3Drng0 \
> >>> -netdev user,id=3Dnet0,host=3D10.0.2.10,hostfwd=3Dtcp::10022-:22 -dev=
ice
> >>> virtio-net-device,netdev=3Dnet0 \
> >>> -append "root=3D/dev/vda earlyprintk=3Dserial console=3DttyS0 oops=3D=
panic
> >>> panic_on_warn=3D1 panic=3D86400 earlycon"
> >>
> >> It still works for me but I had to disable CONFIG_DEBUG_INFO_BTF (I
> >> don't think that changes anything at runtime). But your above command
> >> line does not work for me as it appears you do not load any firmware, =
if
> >> I add -bios images/fw_jump.elf, it works. But then I don't know where
> >> your opensbi output below comes from...
> >>
> >> And regarding your issue with calling clock_gettime 'directly' compare=
d
> >> to using the syscall, I have the same consistent output from both call=
s.
> >>
> >> I have an older gcc (9.3.0) and the same qemu. I think what is missing
> >> here is your buildroot config, so that we have the exact same
> >> environment: could you post your buildroot config as well ?
> >
> > I don't think the image is relevant because I don't even get to kernel
> > code. If the kernel will complain about no init later, that's fine.
> > Re bios, this version of qemu already has OpenSBI bios builtin, you
> > can pass -bios default, but that's, well, the default :)
> > Here are more reproducible repro instructions that capture gcc and
> > qemu. I think gcc version may be potentially relevant as I suspect
> > code size.
> >
> >
> > curl https://gist.githubusercontent.com/dvyukov/6af25474d455437577a8421=
3b0cc9178/raw/55b116522c14a8a98a7626d76df740d54f648ce5/gistfile1.txt
> >> $KERNEL_SRC/.config
> > docker pull gcr.io/syzkaller/syzbot
> > docker run -it -v $KERNEL_SRC:/kernel gcr.io/syzkaller/syzbot
> > cd /kernel
> > make -j72 ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- olddefconfig
> > make -j72 ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu-
> > qemu-system-riscv64 -machine virt -smp 2 -m 4G -kernel
> > arch/riscv/boot/Image -nographic -append "earlycon earlyprintk=3Dserial
> > console=3DttyS0"
> > [this does not, only OpenSBI output]
> >
>
> Indeed the issue was code size, please find the fix below. I will send a
> proper patch once I made sure the fix is the right one, but I'm pretty
> confident, there's no reason to limit the mapping size to 128MB whereas
> we have a whole pgdir.

Great you get to the bottom of this!
Riscv kernels are going to be YUGE!

> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 9b0592b11a9f..ff2495707edb 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -287,7 +287,7 @@ pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss=
;
>   pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>   pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
>
> -#define MAX_EARLY_MAPPING_SIZE SZ_128M
> +#define MAX_EARLY_MAPPING_SIZE PGDIR_SIZE
>
>   pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>
> --
> 2.20.1
>
> Thanks,
>
> Alex
>
> > scripts/config -d KASAN_INLINE -e KASAN_OUTLINE -d
> > CC_OPTIMIZE_FOR_PERFORMANCE -e CC_OPTIMIZE_FOR_SIZE
> > make -j72 ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu-
> > qemu-system-riscv64 -machine virt -smp 2 -m 4G -kernel
> > arch/riscv/boot/Image -nographic -append "earlycon earlyprintk=3Dserial
> > console=3DttyS0"
> > [this boots fine, at least at to starting init process]
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
