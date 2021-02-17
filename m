Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D79531D4AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 05:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhBQEnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 23:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBQEnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 23:43:09 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C63AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 20:42:29 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id q8so5722459qvx.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 20:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8m8v3N1mfBy+Rw2JWENvO+sd3wm4zI7IbdM3+bR1i2o=;
        b=CQp+0wMx4TvKt6+vvq9D4g27VNgYWGQn/cvb0q4cw2sVCD4eGVC4O5mLyF03jZvWWP
         /IiFu06UsjaLcG9CcWqPnOfCPC2rxpsuW+dWB6+VA4hx+fP6VvKu3f3DPlyGb27WmERW
         VTj8G1cM1PKAja4VA92N6age/9SPnCs/AIitEQPYsbdnYAMhL4al1gCw/yP89X+8oOsT
         sgQOBhyw+ln41OQq75An2d5ArH9wn2SYxUNQgE5jthTal3puZPHOJGyhputUC5zuwqt3
         OJSgY72FSh9SUeEs7MFnb41hF6CimKxRn8Oq7ejnMO7Mv+L7SfOTC0Bja2Ru+wUBa+Wm
         0glQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8m8v3N1mfBy+Rw2JWENvO+sd3wm4zI7IbdM3+bR1i2o=;
        b=edeMSpIGBEGM9wFKTLvVmQe5uqA8FYfZr1ME3yeQT13ZlkrIt3tYp8VicY5LeYMBH3
         ezUi3grg/18qvC6uF1aIMZTQz/3X/GDemfBYQ014UJqZr4qfD7rXaQsui7Zs9FpIG+Lv
         IB1JcADBdZWaszpJqNQgu5R6os6npF9nDkFAK6l/Rq/GkKdt2tYrPLGHOpJSZSt+mqGx
         WYPDVeu1Urq8m/nqWnjYFkdxjWQg6q6rIzcicEhJb3DiVxDsbF+RXPa9sXXhKAH80Lvp
         L/Pewy/PaRLeW8THRtaC8eaCLa7YRYYfybwvk9fuq1LpJoNHiIStxp2BFzVgjhKIx4ux
         PZMQ==
X-Gm-Message-State: AOAM533mfyMF5yl+AApovI2kO3P+YDy2CvInRcGoRfsdgp4TCfaalsO0
        zupS+L8URni/FCFkYtCNjwmieC66tC1hWUfO/lfahw==
X-Google-Smtp-Source: ABdhPJx2GVCvp/9jJ/birRkl0knj9cHuNGGEP3gyhozzsxMkM+zgM1luK2AyPGqjunfEoPFdjB9dKBKsv3y3Yp8aTKs=
X-Received: by 2002:a0c:a5e2:: with SMTP id z89mr23006257qvz.37.1613536947982;
 Tue, 16 Feb 2021 20:42:27 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+bDqMiC+ou5ghb=XB3Oyjw3p-GTDvNw4NkkQqQthw1yuQ@mail.gmail.com>
 <mhng-02b88d43-ede8-48f9-82f1-c84201acb7a8@palmerdabbelt-glaptop>
 <CACT4Y+aN3LvgaBc_zmW=t=D7ChU-jrWYnjt5sZ2GEDQhg_BC9A@mail.gmail.com>
 <CACT4Y+aC19DaNOm87EO3cER2=MEmO9pmtUxzVmRtg9YhZKuMVA@mail.gmail.com>
 <20210118145310.crnqnh6kax5jqicj@distanz.ch> <CACT4Y+bFV6m1LCYb1nO7ioKJK99916D76sJ+H-LgBjWx6biF5w@mail.gmail.com>
 <CACT4Y+bmDKNnykeTP9yKjje3XZjbXY3De+_e3fMFOMoe0dnARw@mail.gmail.com>
 <6e9ee3a1-0e16-b1fc-a690-f1ca8e9823a5@ghiti.fr> <CACT4Y+adSjve7bXRPh5UybCQx6ubOUu5RbwuT620wdcxHzVYJg@mail.gmail.com>
 <CACT4Y+ZNJBnkKHXUf=tm_yuowvZvHwN=0rmJ=7J+xFd+9r_6pQ@mail.gmail.com>
 <CACT4Y+awHrJfFo+g33AiAnCj3vq6t6PqbL-3=Qbciy6dAJfVWg@mail.gmail.com> <24857bfc-c557-f141-8ae7-2e3da24f67f5@ghiti.fr>
In-Reply-To: <24857bfc-c557-f141-8ae7-2e3da24f67f5@ghiti.fr>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 17 Feb 2021 05:42:16 +0100
Message-ID: <CACT4Y+bmuhR=2u=1bGK+W8ttOn+=bkKrqCRM8_SiDSW1iAX60A@mail.gmail.com>
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

On Tue, Feb 16, 2021 at 9:42 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi Dmitry,
>
> Le 2/16/21 =C3=A0 6:25 AM, Dmitry Vyukov a =C3=A9crit :
> > On Tue, Feb 16, 2021 at 12:17 PM Dmitry Vyukov <dvyukov@google.com> wro=
te:
> >>
> >> On Fri, Jan 29, 2021 at 9:11 AM Dmitry Vyukov <dvyukov@google.com> wro=
te:
> >>>> I was fixing KASAN support for my sv48 patchset so I took a look at =
your
> >>>> issue: I built a kernel on top of the branch riscv/fixes using
> >>>> https://github.com/google/syzkaller/blob/269d24e857a757d09a898086a2f=
a6fa5d827c3e1/dashboard/config/linux/upstream-riscv64-kasan.config
> >>>> and Buildroot 2020.11. I have the warnings regarding the use of
> >>>> __virt_to_phys on wrong addresses (but that's normal since this func=
tion
> >>>> is used in virt_addr_valid) but not the segfaults you describe.
> >>>
> >>> Hi Alex,
> >>>
> >>> Let me try to rebuild buildroot image. Maybe there was something wron=
g
> >>> with my build, though, I did 'make clean' before doing. But at the
> >>> same time it worked back in June...
> >>>
> >>> Re WARNINGs, they indicate kernel bugs. I am working on setting up a
> >>> syzbot instance on riscv. If there a WARNING during boot then the
> >>> kernel will be marked as broken. No further testing will happen.
> >>> Is it a mis-use of WARN_ON? If so, could anybody please remove it or
> >>> replace it with pr_err.
> >>
> >>
> >> Hi,
> >>
> >> I've localized one issue with riscv/KASAN:
> >> KASAN breaks VDSO and that's I think the root cause of weird faults I
> >> saw earlier. The following patch fixes it.
> >> Could somebody please upstream this fix? I don't know how to add/run
> >> tests for this.
> >> Thanks
> >>
> >> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/=
Makefile
> >> index 0cfd6da784f84..cf3a383c1799d 100644
> >> --- a/arch/riscv/kernel/vdso/Makefile
> >> +++ b/arch/riscv/kernel/vdso/Makefile
> >> @@ -35,6 +35,7 @@ CFLAGS_REMOVE_vgettimeofday.o =3D $(CC_FLAGS_FTRACE)=
 -Os
> >>   # Disable gcov profiling for VDSO code
> >>   GCOV_PROFILE :=3D n
> >>   KCOV_INSTRUMENT :=3D n
> >> +KASAN_SANITIZE :=3D n
> >>
> >>   # Force dependency
> >>   $(obj)/vdso.o: $(obj)/vdso.so
>
> What's weird is that I don't have any issue without this patch with the
> following config whereas it indeed seems required for KASAN. But when
> looking at the segfaults you got earlier, the segfault address is 0xbb0
> and the cause is an instruction page fault: this address is the PLT base
> address in vdso.so and an instruction page fault would mean that someone
> tried to jump at this address, which is weird. At first sight, that does
> not seem related to your patch above, but clearly I may be wrong.
>
> Tobias, did you observe the same segfaults as Dmitry ?


I noticed that not all buildroot images use VDSO, it seems to be
dependent on libc settings (at least I think I changed it in the
past).
I also booted an image completely successfully including dhcpd/sshd
start, but then my executable crashed in clock_gettime. The executable
was build on linux/amd64 host with "riscv64-linux-gnu-gcc -static"
(10.2.1).


> > Second issue I am seeing seems to be related to text segment size.
> > I check out v5.11 and use this config:
> > https://gist.github.com/dvyukov/6af25474d455437577a84213b0cc9178
>
> This config gave my laptop a hard time ! Finally I was able to boot
> correctly to userspace, but I realized I used my sv48 branch...Either I
> fixed your issue along the way or I can't reproduce it, I'll give it a
> try tomorrow.

Where is your branch? I could also test in my setup on your branch.


> > Then trying to boot it using:
> > QEMU emulator version 5.2.0 (Debian 1:5.2+dfsg-3)
> > $ qemu-system-riscv64 -machine virt -smp 2 -m 4G ...
> >
> > It shows no output from the kernel whatsoever, even though I have
> > earlycon and output shows very early with other configs.
> > Kernel boots fine with defconfig and other smaller configs.
> >
> > If I enable KASAN_OUTLINE and CC_OPTIMIZE_FOR_SIZE, then this config
> > also boots fine. Both of these options significantly reduce kernel
> > size. However, I can also boot the kernel without these 2 configs, if
> > I disable a whole lot of subsystem configs. This makes me think that
> > there is an issue related to kernel size somewhere in
> > qemu/bootloader/kernel bootstrap code.
> > Does it make sense to you? Can somebody reproduce what I am seeing? >
>
> I did not bring any answer to your question, but at least you know I'm
> working on it, I'll keep you posted.
>
> Thanks for taking the time to setup syzkaller.
>
> Alex
>
> > Thanks
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
