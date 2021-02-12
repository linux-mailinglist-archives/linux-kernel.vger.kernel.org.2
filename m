Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F7131A037
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhBLOAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:00:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230336AbhBLOAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:00:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8DF764E77
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613138381;
        bh=EP2CAHVuzyRMG/PUKnUl+jY0zn7rp2M0QTID3TQCH40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SShzO+dG8ltMJpUaXev4p59HSQlluU7bRNr94cRICkioaCPO+zzm7n4moRXjSF1ud
         n/lEVjkw/f0Iawgra3RRLRT+p0wMuKwrZu065Ug9uxnwkyYnD9mfcVO/6zgEzuOJ+3
         MVvAW3qTqnEv7e6obiKS1DFfhXbTqG1ko+KoPe2JuT+t4jEd6tRAgy6f8zFl9g8pJ0
         7PDSMWBF0QPleCoh5ghng7z4+dvnxzDgJP6QwU5bywOcHCFja123nfiQA6R9peH+1G
         WN13Ve19f7h+xFCVtIcZm5UE3f2qNmNCaBPTeAbbqG1AU087lRijEkVSFmFGp8nkkm
         v9urxGLl5B4sA==
Received: by mail-oi1-f180.google.com with SMTP id u66so10022360oig.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:59:40 -0800 (PST)
X-Gm-Message-State: AOAM5316nlqt/g+mMYYbO4clrkbojoCGzTfHamHvybdSQdj7dPElmAle
        /hpQ4h/hDpsi2jeIAjCv15HboCdaQkqI0G2ruoE=
X-Google-Smtp-Source: ABdhPJyCXDdL6PXL3t5jXk6NfNgAOpzgcr0LS1EFcA/cMyDFz+G2r8F+sD2aTd1ObyAzLWQUcTySqixHio14ptPsLlE=
X-Received: by 2002:aca:2117:: with SMTP id 23mr1849245oiz.4.1613138380166;
 Fri, 12 Feb 2021 05:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20210211202208.31555-1-Sonicadvance1@gmail.com> <58b03e17-3729-99ea-8691-0d735a53b9bc@arm.com>
In-Reply-To: <58b03e17-3729-99ea-8691-0d735a53b9bc@arm.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 12 Feb 2021 14:59:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3A0u2SWjuk2QNKye-=0Z5DE8yZZbHMPhMaMAy9yVpK+Q@mail.gmail.com>
Message-ID: <CAK8P3a3A0u2SWjuk2QNKye-=0Z5DE8yZZbHMPhMaMAy9yVpK+Q@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH v2] arm64: Exposes support for 32-bit syscalls
To:     Steven Price <steven.price@arm.com>
Cc:     Ryan Houdek <sonicadvance1@gmail.com>,
        "Amanieu d'Antras" <amanieu@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Martin <Dave.Martin@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gavin Shan <gshan@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kevin Hao <haokexin@gmail.com>,
        Jason Yan <yanaijie@huawei.com>, Andrey Ignatov <rdna@fb.com>,
        Peter Collingbourne <pcc@google.com>,
        Julien Grall <julien.grall@arm.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 12:33 PM Steven Price <steven.price@arm.com> wrote:
> On 11/02/2021 20:21, sonicadvance1@gmail.com wrote:

> > The problem:
> > We need to support 32-bit processes running under a userspace
> > compatibility layer. The compatibility layer is a AArch64 process.
> > This means exposing the 32bit compatibility syscalls to userspace.
>
> I'm not sure how you come to this conclusion. Running 32-bit processes
> under a compatibility layer is a fine goal, but it's not clear why the
> entire 32-bit compat syscall layer is needed for this.
>
> As a case in point QEMU's user mode emulation already achieves this in
> many cases without any changes to the kernel.

I think it's a quantitative difference, not a qualitative one:

qemu does a nice job at translating the interfaces for many combinations
of host and target architectures at a decent speed, and is improving
at both the compatibility and the performance over time.

What both Tango and FEX promise is to be much faster by focusing
on one target architecture each, and to have better compatibility than
what qemu can do.

> > Who does this matter to?
> > Any user that has a specific need to run legacy 32-bit software under a
> > compatibility layer.
> > Not all software is open source or easy to convert to 64bit, it's
> > something we need to live with.
> > Professional software and the gaming ecosystem is rife with this.
> >
> > What applications have tried to work around this problem?
> > FEX emulator (1) - Userspace x86 to AArch64 compatibility layer
> > Tango binary translator (2) - AArch32 to AArch64 compatibility layer
> > QEmu (3) - Not really but they do some userspace ioctl emulation
>
> Can you expand on "not really"? Clearly there are limitations, but in
> general I can happily "chroot" into a distro filesystem using an
> otherwise incompatible architecture using a qemu-xxx-static binary.

The ioctl emulation in qemu is limited in multiple ways:
 - it needs to duplicate the kernel's compat emulation for
   every single command it wants to handle, and will always
   lag behind what gets merged into the kernel and what
   drivers a particular distro ships.
 - some ioctl commands cannot be emulated in user space
   because the compat code relies on tracking device state
   in the kernel.
 - In some cases, emulation can be expensive, both for
   runtime overhead and for code complexity

> > What problems did they hit?
> > FEX and Tango hit problems with emulating memory related syscalls.
> > - Emulating 32-bit mmap, mremap, shmat in userspace changes behaviour
> > All three hit issues with ioctl emulation
> > - ioctls are free to do what they want including allocating memory and
> > returning opaque structures with pointers.
>
> Now I think we're getting to what the actual problems are:
>
>   * mmap and friends have no (easy) way of forcing a mapping into a 32
> bit region.
>   * ioctls are a mess
>
> The first seems like a reasonable goal - I've seen examples of MAP_32BIT
> being (ab)used to do this, but it actually restricts to 31 bits and it's
> not even available on arm64. Here I think you'd be better off focusing
> on coming up with a new (generic) way of restricting the addresses that
> the kernel will pick.

I think that would be useful for other projects as well.

> ioctls are going to be a problem whatever you do, and I don't think
> there is much option other than having a list of known ioctls and
> translating them in user space - see below.

In particular for the arm32-on-arm64 ioctl case, we have a known-working
implementation in the kernel, I don't see why we wouldn't want to use it.

the x86-32-on-anything case for FEX is trickier because it does
require handling the ia32 alignment case, and the proposed patch
does not handle that correctly for all commands. I think this would
be fixable in the kernel, but it requires a little more work.

> > This is now exposing the compat syscalls to userspace, but for the sake
> > of userspace compatibility it is a necessary evil.
>
> You've yet to convince me that it's "necessary" - I agree on the "evil"
> part ;)

I think it's much easier to argue in favor of exposing the kernel's
ioctl() emulation and a get_unmapped_area() limit to a process
specific address than for doing the entire syscalls emulation.

The emulation for any of the other syscalls should be manageable
once ioctl can be called directly, though there are a couple that
could fall into the same category (setsockopt, sendmsg/recvmsg,
fcntl).

       Arnd
