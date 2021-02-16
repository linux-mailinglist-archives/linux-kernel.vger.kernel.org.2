Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D1631C9A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBPL0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhBPL0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:26:22 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA45C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 03:25:41 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id e11so6810242qtg.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 03:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OpdMgD15nVOmxBqHmgQp5QV05JlNNLMOu1zTK5wectk=;
        b=BJlVkeg+KiYKigJv0dLocm82YBRds4Ze0jh0m/e1C4EWOqEFjdkvw84Sy7UTocnkSP
         7JOD+hiV/AhOYlEahswG+drBrVpdQtpxC1+dlJNJxM4GLAWIVkzcn4FNpO6gfLpicS/C
         ltsSOxMyOOjQtylvk7nP1UVZyj/sTEh6vHZUpkYFV37aYfCTkpt+vy/gJS5dxcxuvqTt
         KB/tTD0d72xBCF68FnY8LslS+Vnlxl3OnQTVrVwDPMHJp1uxmg63+gfuHup/+mc2gQdi
         +tWjbjdhol1lp+S5UW5I+3ruWIP+E3U5gNtjhiqwYauzIl0h8Og4Gh+PKIJ8pEm25uOy
         9Tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OpdMgD15nVOmxBqHmgQp5QV05JlNNLMOu1zTK5wectk=;
        b=PYZosPLFEEuCya/btfofI1D9dimW1PebVSZohBtdmMsd3Z/MjygHZKnr562fenFd8Y
         +qXz5C9LFF3Cu5LK7bvh/gb9TTSHu2dbo/W5GqElB9zq3SU7I7zxBG4RzMInT0ZMrDbS
         I+56RyDilehCZy5dpdpw5q8xfLUjzy7x7Fwl8keVFLl6f7kZ4OfLUW0WoTNQyXgKG6VW
         urgi+pj+woxnosh8TKbuuCpJsIlBT/uKqoOxN/O+OPg7Bf0sgx+yYRLw7lBVDyv8tT7B
         cVqyTQY91FC+OUMt4ehjT40Fps2/9vadgMibkZ6XeB6e8vnx1jDqEKOoV2V1NR4opYBf
         Odmw==
X-Gm-Message-State: AOAM53148oZ8uLPQMKtN64gFm+6ozy9pf4ak9zpyNkpOok1N6Rxhw7n/
        kX7H851eY+HuHq9olDGXWnSywMrSit+eWxHC34g3JA==
X-Google-Smtp-Source: ABdhPJwpW1GE+h0hCdOCxpmjTvpVz2L9jJNy9DdTONweY3+hgOg8KMJs8pE5xCd0rshQ3wiZ9zidYh4Xdpp/YWRYGQg=
X-Received: by 2002:aed:3647:: with SMTP id e65mr9003272qtb.43.1613474740157;
 Tue, 16 Feb 2021 03:25:40 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+bDqMiC+ou5ghb=XB3Oyjw3p-GTDvNw4NkkQqQthw1yuQ@mail.gmail.com>
 <mhng-02b88d43-ede8-48f9-82f1-c84201acb7a8@palmerdabbelt-glaptop>
 <CACT4Y+aN3LvgaBc_zmW=t=D7ChU-jrWYnjt5sZ2GEDQhg_BC9A@mail.gmail.com>
 <CACT4Y+aC19DaNOm87EO3cER2=MEmO9pmtUxzVmRtg9YhZKuMVA@mail.gmail.com>
 <20210118145310.crnqnh6kax5jqicj@distanz.ch> <CACT4Y+bFV6m1LCYb1nO7ioKJK99916D76sJ+H-LgBjWx6biF5w@mail.gmail.com>
 <CACT4Y+bmDKNnykeTP9yKjje3XZjbXY3De+_e3fMFOMoe0dnARw@mail.gmail.com>
 <6e9ee3a1-0e16-b1fc-a690-f1ca8e9823a5@ghiti.fr> <CACT4Y+adSjve7bXRPh5UybCQx6ubOUu5RbwuT620wdcxHzVYJg@mail.gmail.com>
 <CACT4Y+ZNJBnkKHXUf=tm_yuowvZvHwN=0rmJ=7J+xFd+9r_6pQ@mail.gmail.com>
In-Reply-To: <CACT4Y+ZNJBnkKHXUf=tm_yuowvZvHwN=0rmJ=7J+xFd+9r_6pQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 16 Feb 2021 12:25:28 +0100
Message-ID: <CACT4Y+awHrJfFo+g33AiAnCj3vq6t6PqbL-3=Qbciy6dAJfVWg@mail.gmail.com>
Subject: Re: riscv+KASAN does not boot
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Tobias Klauser <tklauser@distanz.ch>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bjorn Topel <bjorn.topel@gmail.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        LKML <linux-kernel@vger.kernel.org>, nylon7@andestech.com,
        syzkaller <syzkaller@googlegroups.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:17 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Jan 29, 2021 at 9:11 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > I was fixing KASAN support for my sv48 patchset so I took a look at your
> > > issue: I built a kernel on top of the branch riscv/fixes using
> > > https://github.com/google/syzkaller/blob/269d24e857a757d09a898086a2fa6fa5d827c3e1/dashboard/config/linux/upstream-riscv64-kasan.config
> > > and Buildroot 2020.11. I have the warnings regarding the use of
> > > __virt_to_phys on wrong addresses (but that's normal since this function
> > > is used in virt_addr_valid) but not the segfaults you describe.
> >
> > Hi Alex,
> >
> > Let me try to rebuild buildroot image. Maybe there was something wrong
> > with my build, though, I did 'make clean' before doing. But at the
> > same time it worked back in June...
> >
> > Re WARNINGs, they indicate kernel bugs. I am working on setting up a
> > syzbot instance on riscv. If there a WARNING during boot then the
> > kernel will be marked as broken. No further testing will happen.
> > Is it a mis-use of WARN_ON? If so, could anybody please remove it or
> > replace it with pr_err.
>
>
> Hi,
>
> I've localized one issue with riscv/KASAN:
> KASAN breaks VDSO and that's I think the root cause of weird faults I
> saw earlier. The following patch fixes it.
> Could somebody please upstream this fix? I don't know how to add/run
> tests for this.
> Thanks
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index 0cfd6da784f84..cf3a383c1799d 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -35,6 +35,7 @@ CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
>  # Disable gcov profiling for VDSO code
>  GCOV_PROFILE := n
>  KCOV_INSTRUMENT := n
> +KASAN_SANITIZE := n
>
>  # Force dependency
>  $(obj)/vdso.o: $(obj)/vdso.so



Second issue I am seeing seems to be related to text segment size.
I check out v5.11 and use this config:
https://gist.github.com/dvyukov/6af25474d455437577a84213b0cc9178

Then trying to boot it using:
QEMU emulator version 5.2.0 (Debian 1:5.2+dfsg-3)
$ qemu-system-riscv64 -machine virt -smp 2 -m 4G ...

It shows no output from the kernel whatsoever, even though I have
earlycon and output shows very early with other configs.
Kernel boots fine with defconfig and other smaller configs.

If I enable KASAN_OUTLINE and CC_OPTIMIZE_FOR_SIZE, then this config
also boots fine. Both of these options significantly reduce kernel
size. However, I can also boot the kernel without these 2 configs, if
I disable a whole lot of subsystem configs. This makes me think that
there is an issue related to kernel size somewhere in
qemu/bootloader/kernel bootstrap code.
Does it make sense to you? Can somebody reproduce what I am seeing?

Thanks
