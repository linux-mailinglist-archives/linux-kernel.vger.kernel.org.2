Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB4C3372B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbhCKMdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:33:47 -0500
Received: from foss.arm.com ([217.140.110.172]:34830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233293AbhCKMdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:33:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6499A31B;
        Thu, 11 Mar 2021 04:33:20 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.54.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C4EC3F793;
        Thu, 11 Mar 2021 04:33:18 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:33:15 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     maz@kernel.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: arm64 syzbot instances
Message-ID: <20210311123315.GF37303@C02TD0UTHF1T.local>
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 12:38:21PM +0100, 'Dmitry Vyukov' via syzkaller wrote:
> Hi arm64 maintainers,

Hi Dmitry,

> We now have some syzbot instances testing arm64 (woohoo!) using qemu
> emulation. I wanted to write up the current status.

Nice!

> There are 3 instances, first uses KASAN:
> https://syzkaller.appspot.com/upstream?manager=ci-qemu2-arm64
> second KASAN and 32-bit userspace test load (compat):
> https://syzkaller.appspot.com/upstream?manager=ci-qemu2-arm64-compat
> third uses MTE/KASAN_HWTAGS:
> https://syzkaller.appspot.com/upstream?manager=ci-qemu2-arm64-mte
> 
> Kernel configs:
> https://github.com/google/syzkaller/blob/master/dashboard/config/linux/upstream-arm64-kasan.config
> https://github.com/google/syzkaller/blob/master/dashboard/config/linux/upstream-arm64-mte.config

FWIW, I keep my fuzzing config fragment in my fuzzing/* branches on
git.kernel.org, and for comparison my fragment for v5.12-rc1 is:

https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=fuzzing/5.12-rc1&id=6d9f7f8a2514fe882823fadbe7478228f71d7ab1

... I'm not sure whether there's anything in that which is novel to you.

> The instances have KCOV disabled because it slows down execution too
> much (KASAN in qemu emulation is already extremely slow), so no
> coverage guidance and coverage reports for now :(
> 
> The instances found few arm64-specific issues that we have not
> observed on other instances:
> https://syzkaller.appspot.com/bug?id=1d22a2cc3521d5cf6b41bd6b825793c2015f861f
> https://syzkaller.appspot.com/bug?id=bb2c16b0e13b4de4bbf22cf6a4b9b16fb0c20eea
> https://syzkaller.appspot.com/bug?id=b75386f45318ec181b7f49260d619fac9877d456
> https://syzkaller.appspot.com/bug?id=5a1bc29bca656159f95c7c8bb30e3776ca860332
> but mostly re-discovering known bugs we already found on x86.

Likewise, my general experience these days (fuzzing under KVM on a
ThunderX2 host) is that we mostly hit issues in core code or drivers
rather than anything strictly specific to arm64. As my host is ARMv8.1
that might just be by virtue of not exercising many of the new
architectural features.

> The instances use qemu emulation and lots of debug configs, so they
> are quite slow and it makes sense to target them at arm64-specific
> parts of the kernel as much as possible (rather
> than stress generic subsystems that are already stressed on x86).
> So the question is: what arm64-specific parts are there that we can reach
> in qemu?
> Can you think of any qemu flags (cpu features, device emulation, etc)?

Generally, `-cpu max` will expose the more interesting CPU features, and
you already seem to have that, so I think you're mostly there on that
front.

Devices vary a lot between SoCs (and most aren't even emulated), so
unless you have particular platforms in mind I'd suggest it might be
better to just use PV devices and try to focus fuzzing on arch code and
common code like mm rather than drivers.

> Any kernel subsystems with heavy arm-specific parts that we may be missing?

It looks like your configs already have BPF, which is probably one of
the more interesting subsystems with architecture-specific bits, so I
don't have further suggestions on that front.

> Testing some of the arm64 drivers that qemu can emulate may be the
> most profitable thing.
> Currently the instances use the following flags:
> -machine virt,virtualization=on,graphics=on,usb=on -cpu cortex-a57
> -machine virt,virtualization=on,mte=on,graphics=on,usb=on -cpu max

With `-cpu max`, QEMU will use a relatively expensive SW implementation
of pointer authentication (which I found significantly magnified the
cost of implementation like kcov), so depending on your priorities you
might want to disable that or (assuming you have a recent enough build
of QEMU) you might wantto force the use of a cheaper algorithm by
passing `-cpu max,pauth-impef`.

The relevant QEMU commit is:

eb94284d0812b4e7 ("arget/arm: Add cpu properties to control pauth")

... but it looks like that might not yet be in a tagged release yet.

Thanks,
Mark.

> mte=on + virtualization=on is broken in the kernel on in the qemu:
> https://lore.kernel.org/lkml/CAAeHK+wDz8aSLyjq1b=q3+HG9aJXxwYR6+gN_fTttMN5osM5gg@mail.gmail.com/
> 
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/CACT4Y%2BbeyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g%40mail.gmail.com.
