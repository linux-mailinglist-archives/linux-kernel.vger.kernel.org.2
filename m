Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6DB32AC15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 22:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449115AbhCBVIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347505AbhCBSIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:08:14 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0D2C06178C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:07:22 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id m11so24277889lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qXf1QCeaqPODJtKzvT9hSjaHg77HtgmbxkYdMN/DgyU=;
        b=mU8RjPBLyFQIGxUcK6vcL4mRM2BYAokOv8WskoDGyU7QT8/ZLUtlR07A/ptpHObYGP
         PEu3zZzRDhF/Knfq1l3/bhwO4oGjBsISv4l8UvBSOvZGTg4M2I1EpTJv1Ujr/wEYoGTY
         buGEVeRa+uuxhm2IN6x5PS4GlGKGC+C6D0pDpaKbQgpuD4PfAK4fFltjOPhwUD887Omh
         s9Brl8G4Nxd23RXMz8rG5zyz2tc+zrn7+tIKflhfuBjSip0+3C8P0W+jqdq2iUGE7fS6
         66T7aV5A7+F4ymA/IDIoMDNAZJ4n0O4FSu4rc4O+ObSvz8/54euNSLJEdMlDGXpugRgA
         aLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXf1QCeaqPODJtKzvT9hSjaHg77HtgmbxkYdMN/DgyU=;
        b=lugb+x9amBIxL2fQfbAniIR/4G90kY45cV9CHKirybKRGMrmUTSv8ImGn7Z0jwVwph
         UHU6nglTX1gwqusjnQqDKtNev8vPgMkSW4SH11Dw2PJGFksZI+pVufCo4wrNlKcA5/Je
         2mq3ub/JXrEWcyQSHh2AG63Sd4dcPvH406oXCx4klHWu9ofdeYio34LaeHj44P7eDH1E
         6Ufk2gabVLjxTnV1f8sewWOlzd81xO8XHtj7l7/cgsMvdzOT05aR8hLAojns8jqnIGkA
         nhUZKFImExml4pKAzQ20F3kz20KSKSwc8WWqjSvXTPHlLLqubF+0stDPsHcp12RvqIfk
         FflQ==
X-Gm-Message-State: AOAM531Gf2yssppn5dsLUycrNwyR+loOAVu7lE8nEiBPYx3IM+l1ygq8
        7hezSNuTiJb9DeQmEHT5wiG2NPOcsKP1gvFB2f2Kuw==
X-Google-Smtp-Source: ABdhPJwrILWfLOPIAOV+r1w4WCz4FzdXvXzNc0FumVq17NybsSklFBpcNruyMUTUvFfdcmUgYzB4p8CF2lWi1kI0Jeg=
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr11110215ljc.0.1614708440144;
 Tue, 02 Mar 2021 10:07:20 -0800 (PST)
MIME-Version: 1.0
References: <202103021826.7KKJWxQ2-lkp@intel.com> <CAKwvOdnCq7S68chEwSjFBPv5vsKDuzumOX19peOFDCSBCUm0jg@mail.gmail.com>
 <2e40a84f-15c6-2764-dcfd-9f5aa368b400@gmx.de>
In-Reply-To: <2e40a84f-15c6-2764-dcfd-9f5aa368b400@gmx.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Mar 2021 10:07:08 -0800
Message-ID: <CAKwvOdkXUAfYv415U9aE+ycLKT1rzujrBFfFHmvX47V5xHz1sA@mail.gmail.com>
Subject: Re: hppa64-linux-ld: kernel/sched/core.o(.init.text+0x90): cannot
 reach printk
To:     Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@kernel.org>
Cc:     linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        John David Anglin <dave.anglin@bell.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Arnd

On Tue, Mar 2, 2021 at 10:03 AM Helge Deller <deller@gmx.de> wrote:
>
> On 3/2/21 6:29 PM, Nick Desaulniers wrote:
> > + pa-risc folks
>
> Thanks for looking into this, Nick!
>
> > On Tue, Mar 2, 2021 at 2:59 AM kernel test robot <lkp@intel.com> wrote:
> >>
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> head:   7a7fd0de4a9804299793e564a555a49c1fc924cb
> >> commit: eff8728fe69880d3f7983bec3fb6cea4c306261f vmlinux.lds.h: Add PGO and AutoFDO input sections
> >
> > This commit added sections explicitly to the kernel's linker script.
>
> Yes, but even when reverting this patch it does not prevent
> the linking problems.
>
>
> >> date:   6 months ago
> >> config: parisc-randconfig-s031-20210228 (attached as .config)
> >
> > ^ randconfig (always find something curious)
>
> Yes :-)
>
>
> >> compiler: hppa64-linux-gcc (GCC) 9.3.0
> >> reproduce:
> >>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>          chmod +x ~/bin/make.cross
> >>          # apt-get install sparse
> >>          # sparse version: v0.6.3-241-geaceeafa-dirty
> >>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eff8728fe69880d3f7983bec3fb6cea4c306261f
> >>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>          git fetch --no-tags linus master
> >>          git checkout eff8728fe69880d3f7983bec3fb6cea4c306261f
> >>          # save the attached .config to linux build tree
> >>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=parisc
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> All errors (new ones prefixed by >>):
> >>
> >>     hppa64-linux-ld: init/main.o(.init.text+0x294): cannot reach printk
> >>     init/main.o: in function `do_early_param':
> >>     (.init.text+0x294): relocation truncated to fit: R_PARISC_PCREL22F against symbol `printk' defined in .text.unlikely section in kernel/printk/printk.o
> >
> > ^ so we can't encode a jump to printk from do_early_param.
>
> Right.
>
> > If the linker is warning that printk is in the .text.unlikely
> > section, I'm curious why printk is marked cold?
>
> printk is always marked cold, see include/linux/printk.h:
> asmlinkage __printf(1, 2) __cold
> int printk(const char *fmt, ...);
>
> > Likely the randconfig produces a large TEXT_MAIN;
>
> Yes.
>
> > I'm guessing that .init.text is on one side of TEXT_MAIN, and
> > .text.unlikely is on the other.  Though there are many different
> > instances below.
> Yes. But even the large TEXT_MAIN by itself can become a problem.
>
> > I'm more familiar with ARM; it's common for the linker to insert
> > trampolines/thunks to bridge jumps too large to encode in a given
> > instruction.  I don't know if BFD has arch agnostic machinery for
> > that, but might be seeing if there's anything reuseable there.
>
> Dave mentioned in another mail, that long branch stub support is
> still missing in the 64-bit parisc linker.
>
> My question still remains:
> Is there any possibility to detect that we build/configure a
> 0-day kernel? If so, auto-enabling CONFIG_MLONGCALLS kernel option
> would solve it (temporarily).

Arnd, is this kind of case what CONFIG_COMPILE_TEST is usually used for?

>
> The better long-term solution is to add long branch stub support
> to the linker.

Agreed.

>
> Helge
>
> > The commit in question (eff8728fe69880d3f7983bec3fb6cea4c306261f)
> > doesn't reorder existing sections, but does add .text.hot.* before
> > TEXT_MAIN.  Existing sections could have been placed as "orphan
> > sections."
> >
> >>     hppa64-linux-ld: init/main.o(.init.text+0x56c): cannot reach printk
> >>     init/main.o: in function `unknown_bootoption':
> >>     (.init.text+0x56c): relocation truncated to fit: R_PARISC_PCREL22F against symbol `printk' defined in .text.unlikely section in kernel/printk/printk.o
> >>     hppa64-linux-ld: init/main.o(.init.text+0xa68): cannot reach printk
> >>     init/main.o: in function `xbc_make_cmdline':
> >>     (.init.text+0xa68): relocation truncated to fit: R_PARISC_PCREL22F against symbol `printk' defined in .text.unlikely section in kernel/printk/printk.o
> >>     hppa64-linux-ld: init/main.o(.init.text+0xaac): cannot reach printk
> >>     (.init.text+0xaac): relocation truncated to fit: R_PARISC_PCREL22F against symbol `printk' defined in .text.unlikely section in kernel/printk/printk.o
> >>     hppa64-linux-ld: init/main.o(.init.text+0xb68): cannot reach printk
> >>     init/main.o: in function `initcall_blacklist':
> >>     (.init.text+0xb68): relocation truncated to fit: R_PARISC_PCREL22F against symbol `printk' defined in .text.unlikely section in kernel/printk/printk.o
> >>     hppa64-linux-ld: init/main.o(.init.text+0xbf8): cannot reach panic
> >>     (.init.text+0xbf8): relocation truncated to fit: R_PARISC_PCREL22F against symbol `panic' defined in .text.unlikely section in kernel/panic.o
> >>     hppa64-linux-ld: init/main.o(.init.text+0xda0): cannot reach rest_init
> >>     init/main.o: in function `arch_call_rest_init':
> >>     (.init.text+0xda0): relocation truncated to fit: R_PARISC_PCREL22F against symbol `rest_init' defined in .ref.text section in init/main.o
> >>     hppa64-linux-ld: init/main.o(.init.text+0xef4): cannot reach printk
> >>     init/main.o: in function `start_kernel':
> >>     (.init.text+0xef4): relocation truncated to fit: R_PARISC_PCREL22F against symbol `printk' defined in .text.unlikely section in kernel/printk/printk.o
> >>     hppa64-linux-ld: init/main.o(.init.text+0xf84): cannot reach printk
> >>     (.init.text+0xf84): relocation truncated to fit: R_PARISC_PCREL22F against symbol `printk' defined in .text.unlikely section in kernel/printk/printk.o
> >>     hppa64-linux-ld: init/main.o(.init.text+0x1068): cannot reach printk
> >>     (.init.text+0x1068): relocation truncated to fit: R_PARISC_PCREL22F against symbol `printk' defined in .text.unlikely section in kernel/printk/printk.o
> >>     hppa64-linux-ld: init/main.o(.init.text+0x10c4): cannot reach printk
> >>     (.init.text+0x10c4): additional relocation overflows omitted from the output
> >>     hppa64-linux-ld: init/main.o(.init.text+0x1138): cannot reach printk
> >>     hppa64-linux-ld: init/main.o(.init.text+0x1154): cannot reach printk
> >>     hppa64-linux-ld: init/main.o(.init.text+0x1174): cannot reach printk
> >>     hppa64-linux-ld: init/main.o(.init.text+0x12a4): cannot reach panic
> >>     hppa64-linux-ld: init/main.o(.init.text+0x13bc): cannot reach build_all_zonelists
> >>     hppa64-linux-ld: init/main.o(.init.text+0x13e8): cannot reach printk
> >>     hppa64-linux-ld: init/main.o(.init.text+0x156c): cannot reach unknown
> >>     hppa64-linux-ld: init/main.o(.init.text+0x159c): cannot reach printk
> >>     hppa64-linux-ld: init/main.o(.init.text+0x15ac): cannot reach unknown
> >>     hppa64-linux-ld: init/main.o(.init.text+0x15c8): cannot reach printk
> >>     hppa64-linux-ld: init/main.o(.init.text+0x1648): cannot reach __warn_printk
> >>     hppa64-linux-ld: init/main.o(.init.text+0x1750): cannot reach profile_init
> >>     hppa64-linux-ld: init/main.o(.init.text+0x1770): cannot reach __warn_printk
> >>     hppa64-linux-ld: init/main.o(.init.text+0x1818): cannot reach unknown
> >>     hppa64-linux-ld: init/main.o(.init.text+0x1840): cannot reach unknown
> >>     hppa64-linux-ld: init/main.o(.init.text+0x1878): cannot reach printk
> >>     hppa64-linux-ld: init/main.o(.init.text+0x1ab0): cannot reach printk
> >>     hppa64-linux-ld: init/main.o(.init.text+0x1b68): cannot reach wait_for_completion
> >>     hppa64-linux-ld: init/main.o(.init.text+0x1ce4): cannot reach panic
> >>     hppa64-linux-ld: init/main.o(.ref.text+0x1c): cannot reach rcu_scheduler_starting
> >>     hppa64-linux-ld: init/main.o(.ref.text+0x17c): cannot reach unknown
> >>     hppa64-linux-ld: init/do_mounts.o(.init.text+0x128): cannot reach printk
> >>     hppa64-linux-ld: init/do_mounts.o(.init.text+0x2e0): cannot reach unknown
> >>     hppa64-linux-ld: init/do_mounts.o(.init.text+0x484): cannot reach unknown
> >>     hppa64-linux-ld: init/do_mounts.o(.init.text+0x57c): cannot reach printk
> >>     hppa64-linux-ld: init/do_mounts.o(.init.text+0x594): cannot reach unknown
> >>     hppa64-linux-ld: init/do_mounts.o(.init.text+0x5d4): cannot reach unknown
> >>     hppa64-linux-ld: init/do_mounts.o(.init.text+0x668): cannot reach printk
> >>     hppa64-linux-ld: init/do_mounts.o(.init.text+0x680): cannot reach printk
> >>     hppa64-linux-ld: init/do_mounts.o(.init.text+0x6d4): cannot reach printk
> >>     hppa64-linux-ld: init/do_mounts.o(.init.text+0x6fc): cannot reach printk
> >>     hppa64-linux-ld: init/do_mounts.o(.init.text+0x720): cannot reach printk
> >>     hppa64-linux-ld: init/do_mounts.o(.init.text+0x75c): cannot reach printk
> >>     hppa64-linux-ld: init/do_mounts.o(.init.text+0x774): cannot reach panic
> >>     hppa64-linux-ld: init/do_mounts.o(.init.text+0x810): cannot reach printk
> >>     hppa64-linux-ld: init/do_mounts.o(.init.text+0x890): cannot reach printk
> >>     hppa64-linux-ld: init/do_mounts.o(.init.text+0x9ec): cannot reach printk
> >>     hppa64-linux-ld: init/do_mounts.o(.init.text+0xa1c): cannot reach driver_probe_done
> >>     hppa64-linux-ld: init/initramfs.o(.init.text+0x830): cannot reach panic
> >>     hppa64-linux-ld: init/initramfs.o(.init.text+0xe50): cannot reach panic
> >>     hppa64-linux-ld: init/initramfs.o(.init.text+0x1660): cannot reach panic
> >>     hppa64-linux-ld: init/initramfs.o(.init.text+0x183c): cannot reach panic
> >>     hppa64-linux-ld: init/initramfs.o(.init.text+0x1868): cannot reach printk
> >>     hppa64-linux-ld: init/initramfs.o(.init.text+0x18a4): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x104): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x180): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x2d8): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x340): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x438): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x48c): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x7a0): cannot reach panic
> >>     hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0xaa8): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0xb20): cannot reach panic
> >>     hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0x78): cannot reach unknown
> >>     hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0xa0): cannot reach unknown
> >>     hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0xc4): cannot reach unknown
> >>     hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x19c): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x28c): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x404): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x420): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x440): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x458): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x488): cannot reach panic
> >>     hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x4b8): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x624): cannot reach panic
> >>     hppa64-linux-ld: arch/parisc/kernel/hardware.o(.init.text+0x13c): cannot reach panic
> >>     hppa64-linux-ld: kernel/extable.o(.init.text+0x50): cannot reach printk
> >>>> hppa64-linux-ld: kernel/sched/core.o(.init.text+0x90): cannot reach printk
> >>     hppa64-linux-ld: kernel/printk/printk.o(.init.text+0xf0): cannot reach printk
> >>     hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x254): cannot reach printk
> >>     hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x2a4): cannot reach printk
> >>     hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x5b0): cannot reach printk
> >>     hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x5c4): cannot reach unregister_console
> >>     hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x734): cannot reach printk
> >>     hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x768): cannot reach _raw_spin_lock
> >>     hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x7c4): cannot reach _raw_spin_unlock
> >>     hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x7f4): cannot reach printk
> >>     hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x818): cannot reach printk
> >>     hppa64-linux-ld: kernel/crash_core.o(.init.text+0x408): cannot reach printk
> >>     hppa64-linux-ld: kernel/crash_core.o(.init.text+0x44c): cannot reach printk
> >>     hppa64-linux-ld: kernel/crash_core.o(.init.text+0x4a8): cannot reach printk
> >>     hppa64-linux-ld: kernel/crash_core.o(.init.text+0x670): cannot reach printk
> >>     hppa64-linux-ld: kernel/crash_core.o(.init.text+0x778): cannot reach printk
> >>     hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x228): cannot reach mutex_lock
> >>     hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x440): cannot reach mutex_unlock
> >>     hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x5a8): cannot reach __warn_printk
> >>     hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x5e0): cannot reach __warn_printk
> >>     hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x7a0): cannot reach mutex_lock
> >>     hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x878): cannot reach mutex_unlock
> >>     hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x97c): cannot reach printk
> >>     hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x9b4): cannot reach printk
> >>     hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0xad4): cannot reach mutex_lock
> >>     hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0xafc): cannot reach mutex_unlock
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x524): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x56c): cannot reach __muldi3
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x590): cannot reach __udivdi3
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x5c0): cannot reach __muldi3
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x5e4): cannot reach __udivdi3
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x658): cannot reach __udivdi3
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x7d8): cannot reach _raw_spin_lock
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x804): cannot reach _raw_spin_unlock
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x820): cannot reach unknown
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0xe34): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x10cc): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1250): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1274): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x12a8): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x135c): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x179c): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x17e4): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x180c): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1830): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1864): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1894): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x18c8): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1940): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1aa8): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1d04): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1ecc): cannot reach __muldi3
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1eec): cannot reach __udivdi3
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1f38): cannot reach __udivdi3
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x2088): cannot reach panic
> >>     hppa64-linux-ld: mm/page_alloc.o(.init.text+0x20e4): cannot reach printk
> >>     hppa64-linux-ld: mm/page_alloc.o(.ref.text+0x34): cannot reach unknown
> >>     hppa64-linux-ld: mm/memblock.o(.init.text+0x100): cannot reach __warn_printk
> >>     hppa64-linux-ld: mm/memblock.o(.init.text+0x118): cannot reach dump_stack
> >>     hppa64-linux-ld: mm/memblock.o(.init.text+0x228): cannot reach printk
> >>     hppa64-linux-ld: mm/memblock.o(.init.text+0x488): cannot reach printk
> >>     hppa64-linux-ld: mm/memblock.o(.init.text+0x550): cannot reach printk
> >>     hppa64-linux-ld: mm/memblock.o(.init.text+0x618): cannot reach printk
> >>     hppa64-linux-ld: mm/memblock.o(.init.text+0x700): cannot reach printk
> >>     hppa64-linux-ld: mm/memblock.o(.init.text+0x73c): cannot reach unknown
> >>     hppa64-linux-ld: mm/memblock.o(.init.text+0xe00): cannot reach unknown
> >>     hppa64-linux-ld: mm/hugetlb.o(.init.text+0x248): cannot reach printk
> >>     hppa64-linux-ld: mm/hugetlb.o(.init.text+0x26c): cannot reach printk
> >>     hppa64-linux-ld: mm/hugetlb.o(.init.text+0x2b8): cannot reach _cond_resched
> >>     hppa64-linux-ld: mm/hugetlb.o(.init.text+0x38c): cannot reach printk
> >>     hppa64-linux-ld: mm/hugetlb.o(.init.text+0x3ec): cannot reach printk
> >>     hppa64-linux-ld: mm/hugetlb.o(.init.text+0x738): cannot reach printk
> >>     hppa64-linux-ld: mm/hugetlb.o(.init.text+0x754): cannot reach printk
> >>     hppa64-linux-ld: mm/hugetlb.o(.init.text+0x8b8): cannot reach _raw_spin_lock
> >>     hppa64-linux-ld: mm/hugetlb.o(.init.text+0x8e4): cannot reach _raw_spin_unlock
> >>     hppa64-linux-ld: mm/hugetlb.o(.init.text+0x94c): cannot reach _cond_resched
> >>     hppa64-linux-ld: mm/hugetlb.o(.init.text+0x9c4): cannot reach printk
> >>     hppa64-linux-ld: mm/hugetlb.o(.init.text+0xb24): cannot reach printk
> >>     hppa64-linux-ld: mm/hugetlb.o(.init.text+0xce0): cannot reach printk
> >>     hppa64-linux-ld: mm/hugetlb.o(.init.text+0xd04): cannot reach unknown
> >>     hppa64-linux-ld: mm/hugetlb.o(.init.text+0xddc): cannot reach printk
> >>     hppa64-linux-ld: mm/hugetlb.o(.init.text+0xdf4): cannot reach unknown
> >>>> hppa64-linux-ld: mm/slab.o(.init.text+0x1c8): cannot reach unknown
> >>     hppa64-linux-ld: mm/slab.o(.init.text+0x1ec): cannot reach unknown
> >>     hppa64-linux-ld: mm/slab.o(.init.text+0x20c): cannot reach unknown
> >>     hppa64-linux-ld: mm/slab.o(.init.text+0x438): cannot reach mutex_lock
> >>     hppa64-linux-ld: mm/slab.o(.init.text+0x490): cannot reach mutex_unlock
> >>     hppa64-linux-ld: fs/namespace.o(.init.text+0x214): cannot reach printk
> >>     hppa64-linux-ld: fs/namespace.o(.init.text+0x260): cannot reach printk
> >>     hppa64-linux-ld: fs/namespace.o(.init.text+0x2cc): cannot reach panic
> >>     hppa64-linux-ld: lib/dynamic_debug.o(.init.text+0x40): cannot reach printk
> >>     hppa64-linux-ld: lib/dynamic_debug.o(.init.text+0x1c4): cannot reach printk
> >>     hppa64-linux-ld: lib/dynamic_debug.o(.init.text+0x2d0): cannot reach printk
> >>     hppa64-linux-ld: lib/dynamic_debug.o(.init.text+0x2fc): cannot reach printk
> >>     hppa64-linux-ld: lib/dynamic_debug.o(.init.text+0x338): cannot reach printk
> >>     hppa64-linux-ld: lib/dynamic_debug.o(.init.text+0x354): cannot reach printk
> >>     hppa64-linux-ld: lib/dynamic_debug.o(.init.text+0x3e4): cannot reach mutex_lock
> >>     hppa64-linux-ld: lib/dynamic_debug.o(.init.text+0x454): cannot reach mutex_unlock
> >>     hppa64-linux-ld: lib/bootconfig.o(.init.text+0xdc): cannot reach unknown
> >>     hppa64-linux-ld: lib/bootconfig.o(.init.text+0x2a0): cannot reach unknown
> >>     hppa64-linux-ld: lib/bootconfig.o(.init.text+0x1660): cannot reach unknown
> >>>> hppa64-linux-ld: lib/plist.o(.init.text+0x144): cannot reach printk
> >>     hppa64-linux-ld: lib/plist.o(.init.text+0x450): cannot reach printk
> >>     hppa64-linux-ld: drivers/clk/clk.o(.init.text+0x250): cannot reach mutex_lock
> >>     hppa64-linux-ld: drivers/clk/clk.o(.init.text+0x2b4): cannot reach mutex_unlock
> >>>> hppa64-linux-ld: drivers/clk/renesas/rcar-gen2-cpg.o(.init.text+0x154): cannot reach unknown
> >>     hppa64-linux-ld: drivers/clk/renesas/rcar-gen2-cpg.o(.init.text+0x204): cannot reach unknown
> >>     hppa64-linux-ld: drivers/clk/renesas/rcar-gen2-cpg.o(.init.text+0x248): cannot reach unknown
> >>     hppa64-linux-ld: drivers/clk/renesas/rcar-gen2-cpg.o(.init.text+0x390): cannot reach unknown
> >>     hppa64-linux-ld: drivers/clk/renesas/rcar-gen2-cpg.o(.init.text+0x3b8): cannot reach unknown
> >>     hppa64-linux-ld: drivers/clk/renesas/rcar-gen3-cpg.o(.init.text+0x188): cannot reach unknown
> >>     hppa64-linux-ld: drivers/clk/renesas/rcar-gen3-cpg.o(.init.text+0x2b4): cannot reach unknown
> >>     hppa64-linux-ld: drivers/clk/renesas/rcar-gen3-cpg.o(.init.text+0x3ec): cannot reach unknown
> >>     hppa64-linux-ld: drivers/clk/renesas/rcar-gen3-cpg.o(.init.text+0x568): cannot reach unknown
> >>     hppa64-linux-ld: drivers/clk/renesas/rcar-gen3-cpg.o(.init.text+0x65c): cannot reach unknown
> >>     hppa64-linux-ld: drivers/base/devtmpfs.o(.init.text+0x25c): cannot reach wait_for_completion
> >>     hppa64-linux-ld: drivers/base/devtmpfs.o(.ref.text+0x60): cannot reach init_mount
> >>     hppa64-linux-ld: drivers/base/devtmpfs.o(.ref.text+0x80): cannot reach init_chdir
> >>     hppa64-linux-ld: drivers/base/devtmpfs.o(.ref.text+0x98): cannot reach init_chroot
> >>     hppa64-linux-ld: mm/mm_init.o(.init.text+0x160): cannot reach printk
> >>     hppa64-linux-ld: mm/mm_init.o(.init.text+0x1ac): cannot reach printk
> >>     hppa64-linux-ld: mm/mm_init.o(.init.text+0x1f4): cannot reach printk
> >>     hppa64-linux-ld: mm/mm_init.o(.init.text+0x2a0): cannot reach printk
> >>     hppa64-linux-ld: mm/mm_init.o(.init.text+0x2d4): cannot reach printk
> >>     hppa64-linux-ld: mm/mm_init.o(.init.text+0x308): cannot reach printk
> >>     hppa64-linux-ld: mm/mm_init.o(.init.text+0x330): cannot reach printk
> >>     hppa64-linux-ld: mm/mm_init.o(.init.text+0x364): cannot reach printk
> >>     hppa64-linux-ld: mm/sparse.o(.ref.text+0x60): cannot reach memblock_alloc_try_nid
> >>     hppa64-linux-ld: mm/sparse.o(.init.text+0x9c): cannot reach panic
> >>     hppa64-linux-ld: mm/sparse.o(.init.text+0x1b8): cannot reach unknown
> >>     hppa64-linux-ld: mm/sparse.o(.init.text+0x224): cannot reach printk
> >>     hppa64-linux-ld: mm/sparse.o(.init.text+0x280): cannot reach unknown
> >>     hppa64-linux-ld: mm/sparse.o(.init.text+0x2d8): cannot reach unknown
> >>     hppa64-linux-ld: mm/sparse.o(.init.text+0x310): cannot reach unknown
> >>     hppa64-linux-ld: mm/sparse.o(.init.text+0x474): cannot reach panic
> >>     hppa64-linux-ld: mm/sparse.o(.init.text+0x4c0): cannot reach unknown
> >>     hppa64-linux-ld: mm/sparse.o(.init.text+0x564): cannot reach unknown
> >>     hppa64-linux-ld: mm/sparse.o(.init.text+0x5ac): cannot reach unknown
> >>     hppa64-linux-ld: mm/sparse.o(.init.text+0x620): cannot reach unknown
> >>     hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x6c): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0xc8): cannot reach panic
> >>     hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x180): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x2cc): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x31c): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x370): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x3bc): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x3f0): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x4cc): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x600): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x620): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x660): cannot reach panic
> >>     hppa64-linux-ld: arch/parisc/kernel/pdc_chassis.o(.init.text+0x80): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/pdc_chassis.o(.init.text+0xa4): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/pdc_chassis.o(.init.text+0x14c): cannot reach printk
> >>     hppa64-linux-ld: kernel/panic.o(.init.text+0x1a8): cannot reach printk
> >>     hppa64-linux-ld: kernel/cpu.o(.init.text+0xb8): cannot reach printk
> >>     hppa64-linux-ld: kernel/cpu.o(.init.text+0x11c): cannot reach unknown
> >>     hppa64-linux-ld: kernel/cpu.o(.init.text+0x138): cannot reach unknown
> >>     hppa64-linux-ld: kernel/cpu.o(.init.text+0x150): cannot reach unknown
> >>     hppa64-linux-ld: kernel/resource.o(.init.text+0x32c): cannot reach _raw_write_lock
> >>     hppa64-linux-ld: kernel/resource.o(.init.text+0x364): cannot reach printk
> >>     hppa64-linux-ld: kernel/resource.o(.init.text+0x3ac): cannot reach printk
> >>     hppa64-linux-ld: kernel/resource.o(.init.text+0x3bc): cannot reach dump_stack
> >>     hppa64-linux-ld: kernel/resource.o(.init.text+0x4f8): cannot reach _raw_write_unlock
> >>     hppa64-linux-ld: kernel/sched/fair.o(.init.text+0x40): cannot reach printk
> >>     hppa64-linux-ld: kernel/irq/spurious.o(.init.text+0x30): cannot reach printk
> >>     hppa64-linux-ld: kernel/irq/spurious.o(.init.text+0x48): cannot reach printk
> >>     hppa64-linux-ld: kernel/irq/spurious.o(.init.text+0x98): cannot reach printk
> >>     hppa64-linux-ld: kernel/irq/spurious.o(.init.text+0xb0): cannot reach printk
> >>     hppa64-linux-ld: kernel/dma/debug.o(.init.text+0x50): cannot reach printk
> >>     hppa64-linux-ld: kernel/dma/debug.o(.init.text+0xec): cannot reach printk
> >>     hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x90): cannot reach mutex_lock
> >>     hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0xc4): cannot reach mutex_unlock
> >>     hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x134): cannot reach printk
> >>     hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x158): cannot reach printk
> >>     hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x1b8): cannot reach mutex_lock
> >>     hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x208): cannot reach mutex_unlock
> >>     hppa64-linux-ld: kernel/gcov/fs.o(.init.text+0x44): cannot reach printk
> >>     hppa64-linux-ld: kernel/gcov/fs.o(.init.text+0x70): cannot reach printk
> >>>> hppa64-linux-ld: kernel/debug/debug_core.o(.init.text+0xfc): cannot reach printk
> >>     hppa64-linux-ld: mm/slab_common.o(.init.text+0x148): cannot reach panic
> >>     hppa64-linux-ld: mm/slab_common.o(.init.text+0x1fc): cannot reach panic
> >>     hppa64-linux-ld: mm/page_owner.o(.init.text+0xbc): cannot reach printk
> >>     hppa64-linux-ld: crypto/asymmetric_keys/restrict.o(.init.text+0xa4): cannot reach printk
> >>>> hppa64-linux-ld: block/elevator.o(.init.text+0x20): cannot reach printk
> >>>> hppa64-linux-ld: lib/crypto/curve25519-selftest.o(.init.text+0x120): cannot reach printk
> >>     hppa64-linux-ld: lib/crypto/curve25519-selftest.o(.init.text+0x2fc): cannot reach printk
> >>     hppa64-linux-ld: lib/crypto/curve25519-selftest.o(.init.text+0x318): cannot reach printk
> >>     hppa64-linux-ld: lib/crypto/curve25519-selftest.o(.init.text+0x338): cannot reach printk
> >>     hppa64-linux-ld: lib/vsprintf.o(.init.text+0x2c): cannot reach printk
> >>>> hppa64-linux-ld: drivers/phy/broadcom/phy-bcm63xx-usbh.o(.init.text+0x12c): cannot reach _dev_err
> >>     hppa64-linux-ld: drivers/phy/broadcom/phy-bcm63xx-usbh.o(.init.text+0x214): cannot reach _dev_err
> >>     hppa64-linux-ld: drivers/video/console/sticore.o(.init.text+0x88): cannot reach unknown
> >>     hppa64-linux-ld: drivers/video/console/sticore.o(.init.text+0xb8): cannot reach unknown
> >>     hppa64-linux-ld: drivers/video/console/sticore.o(.init.text+0xe0): cannot reach unknown
> >>     hppa64-linux-ld: drivers/tty/serial/8250/8250_early.o(.init.text+0x16c): cannot reach $$divU
> >>     hppa64-linux-ld: drivers/tty/serial/altera_uart.o(.init.text+0x200): cannot reach $$divU
> >>     hppa64-linux-ld: drivers/tty/serial/arc_uart.o(.init.text+0x2c): cannot reach $$divU
> >>>> hppa64-linux-ld: kernel/kprobes.o(.init.text+0x258): cannot reach printk
> >>     hppa64-linux-ld: kernel/kprobes.o(.init.text+0x270): cannot reach printk
> >>     hppa64-linux-ld: kernel/workqueue.o(.init.text+0xa8): cannot reach mutex_lock
> >>     hppa64-linux-ld: kernel/workqueue.o(.init.text+0x100): cannot reach __warn_printk
> >>     hppa64-linux-ld: kernel/workqueue.o(.init.text+0x128): cannot reach mutex_unlock
> >>     hppa64-linux-ld: kernel/workqueue.o(.init.text+0x354): cannot reach mutex_lock
> >>     hppa64-linux-ld: kernel/workqueue.o(.init.text+0x388): cannot reach mutex_unlock
> >>     hppa64-linux-ld: kernel/rcu/update.o(.init.text+0xb4): cannot reach __warn_printk
> >>     hppa64-linux-ld: fs/configfs/mount.o(.init.text+0xbc): cannot reach printk
> >>>> hppa64-linux-ld: lib/random32.o(.init.text+0xd0): cannot reach unknown
> >>>> hppa64-linux-ld: lib/random32.o(.init.text+0x138): cannot reach printk
> >>     hppa64-linux-ld: lib/random32.o(.init.text+0x174): cannot reach unknown
> >>     hppa64-linux-ld: lib/random32.o(.init.text+0x204): cannot reach _cond_resched
> >>     hppa64-linux-ld: lib/random32.o(.init.text+0x234): cannot reach printk
> >>     hppa64-linux-ld: lib/random32.o(.init.text+0x254): cannot reach printk
> >>     hppa64-linux-ld: lib/random32.o(.init.text+0x284): cannot reach unknown
> >>     hppa64-linux-ld: drivers/pinctrl/core.o(.init.text+0x28): cannot reach printk
> >>     hppa64-linux-ld: drivers/pinctrl/core.o(.init.text+0x100): cannot reach printk
> >>     hppa64-linux-ld: drivers/gpio/gpiolib.o(.init.text+0xb8): cannot reach printk
> >>     hppa64-linux-ld: drivers/gpio/gpiolib.o(.init.text+0x108): cannot reach printk
> >>>> hppa64-linux-ld: drivers/gpio/gpiolib.o(.init.text+0x118): cannot reach bus_unregister
> >>>> hppa64-linux-ld: drivers/gpio/gpiolib.o(.init.text+0x198): cannot reach _dev_err
> >>>> hppa64-linux-ld: drivers/regulator/core.o(.init.text+0x80): cannot reach __class_register
> >>     hppa64-linux-ld: drivers/i2c/i2c-core-base.o(.init.text+0x34): cannot reach down_write
> >>>> hppa64-linux-ld: drivers/dma/dmaengine.o(.init.text+0x198): cannot reach __class_register
> >>     hppa64-linux-ld: kernel/user.o(.init.text+0x80): cannot reach _raw_spin_lock_irq
> >>     hppa64-linux-ld: kernel/user.o(.init.text+0xb8): cannot reach _raw_spin_unlock_irq
> >>     hppa64-linux-ld: kernel/params.o(.init.text+0x108): cannot reach printk
> >>     hppa64-linux-ld: kernel/params.o(.init.text+0x1c8): cannot reach printk
> >>>> hppa64-linux-ld: kernel/params.o(.init.text+0x250): cannot reach kobject_uevent
> >>     hppa64-linux-ld: kernel/params.o(.init.text+0x3a0): cannot reach kobject_uevent
> >>>> hppa64-linux-ld: kernel/kexec_core.o(.init.text+0x50): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0xa4): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0xc4): cannot reach __muldi3
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0xdc): cannot reach unknown
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x100): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x234): cannot reach panic
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x4a8): cannot reach __muldi3
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x610): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x634): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x64c): cannot reach unknown
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x678): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x69c): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x6b4): cannot reach unknown
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x6d8): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x6fc): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x714): cannot reach unknown
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x75c): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x780): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x798): cannot reach unknown
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x7c4): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x7e8): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x800): cannot reach unknown
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x82c): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x850): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x868): cannot reach unknown
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x894): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x8b8): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x8d0): cannot reach unknown
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x8fc): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x920): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x938): cannot reach unknown
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x970): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x994): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x9ac): cannot reach unknown
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0xad8): cannot reach __muldi3
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0xb3c): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0xb60): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0xb78): cannot reach unknown
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0xbc8): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0xbec): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0xc04): cannot reach unknown
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0xc24): cannot reach __muldi3
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0xce0): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0xd04): cannot reach printk
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0xd1c): cannot reach unknown
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0xd3c): cannot reach unknown
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0xe88): cannot reach panic
> >>     hppa64-linux-ld: mm/percpu.o(.init.text+0x1078): cannot reach panic
> >>>> hppa64-linux-ld: mm/compaction.o(.init.text+0x60): cannot reach printk
> >>     hppa64-linux-ld: mm/page_idle.o(.init.text+0x50): cannot reach printk
> >>>> hppa64-linux-ld: crypto/cryptd.o(.init.text+0xe0): cannot reach printk
> >>>> hppa64-linux-ld: crypto/cryptd.o(.init.text+0x114): cannot reach unknown
> >>     hppa64-linux-ld: block/bio.o(.init.text+0x13c): cannot reach panic
> >>     hppa64-linux-ld: block/genhd.o(.init.text+0x3c): cannot reach __class_register
> >>     hppa64-linux-ld: block/genhd.o(.init.text+0x354): cannot reach printk
> >>     hppa64-linux-ld: block/genhd.o(.init.text+0x384): cannot reach printk
> >>     hppa64-linux-ld: block/genhd.o(.init.text+0x3ac): cannot reach printk
> >>     hppa64-linux-ld: block/blk-crypto.o(.init.text+0x94): cannot reach panic
> >>     hppa64-linux-ld: drivers/pwm/sysfs.o(.init.text+0x28): cannot reach __class_register
> >>     hppa64-linux-ld: drivers/clk/renesas/renesas-cpg-mssr.o(.init.text+0x1a8): cannot reach _dev_err
> >>     hppa64-linux-ld: drivers/clk/renesas/renesas-cpg-mssr.o(.init.text+0x1f0): cannot reach _dev_err
> >>     hppa64-linux-ld: drivers/clk/renesas/renesas-cpg-mssr.o(.init.text+0x2bc): cannot reach unknown
> >>     hppa64-linux-ld: drivers/clk/renesas/renesas-cpg-mssr.o(.init.text+0x3dc): cannot reach unknown
> >>     hppa64-linux-ld: drivers/clk/renesas/renesas-cpg-mssr.o(.init.text+0x51c): cannot reach _dev_err
> >>     hppa64-linux-ld: drivers/dma/mxs-dma.o(.init.text+0x98): cannot reach _dev_err
> >>     hppa64-linux-ld: drivers/watchdog/watchdog_core.o(.init.text+0x54): cannot reach mutex_lock
> >>     hppa64-linux-ld: drivers/watchdog/watchdog_core.o(.init.text+0xe0): cannot reach mutex_unlock
> >>     hppa64-linux-ld: kernel/locking/lock_events.o(.init.text+0x104): cannot reach printk
> >>     hppa64-linux-ld: fs/eventpoll.o(.init.text+0x3c): cannot reach __udivdi3
> >>     hppa64-linux-ld: fs/eventpoll.o(.init.text+0x54): cannot reach __udivdi3
> >>     hppa64-linux-ld: fs/anon_inodes.o(.init.text+0x88): cannot reach panic
> >>     hppa64-linux-ld: fs/proc/bootconfig.o(.init.text+0x70): cannot reach unknown
> >>     hppa64-linux-ld: fs/proc/bootconfig.o(.init.text+0x308): cannot reach unknown
> >>     hppa64-linux-ld: fs/hugetlbfs/inode.o(.init.text+0xa8): cannot reach printk
> >>     hppa64-linux-ld: block/scsi_ioctl.o(.init.text+0x18): cannot reach unknown
> >>     hppa64-linux-ld: arch/parisc/kernel/pdc_cons.o(.init.text+0x7c): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/pdc_cons.o(.init.text+0x98): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/pdc_cons.o(.init.text+0x1d0): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/pdc_cons.o(.init.text+0x240): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/perf.o(.init.text+0x8c): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/perf.o(.init.text+0xc8): cannot reach printk
> >>     hppa64-linux-ld: arch/parisc/kernel/perf.o(.init.text+0xfc): cannot reach printk
> >>     hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0xec): cannot reach printk
> >>     hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x114): cannot reach printk
> >>     hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x214): cannot reach unknown
> >>     hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x28c): cannot reach unknown
> >>     hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x308): cannot reach unknown
> >>     hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x340): cannot reach printk
> >>     hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x4ac): cannot reach unknown
> >>     hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x4e8): cannot reach printk
> >>     hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x574): cannot reach unknown
> >>     hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x5b0): cannot reach printk
> >>     hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x748): cannot reach printk
> >>     hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x760): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0xe4): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0x104): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0x134): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0x1b4): cannot reach unknown
> >>     hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0x3c4): cannot reach unknown
> >>     hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0x3f8): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0x464): cannot reach unknown
> >>     hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0x8b0): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0x8f4): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0xa20): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0xa3c): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0xa84): cannot reach unknown
> >>     hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0xaac): cannot reach unknown
> >>     hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0xc7c): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0xcd8): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0xcf0): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0xe0): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x100): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x19c): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x228): cannot reach schedule_timeout_uninterruptible
> >>     hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x29c): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x2c8): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x434): cannot reach printk
> >>     hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x44c): cannot reach printk
> >>     hppa64-linux-ld: kernel/time/timekeeping.o(.init.text+0x188): cannot reach printk
> >>     hppa64-linux-ld: kernel/time/timekeeping.o(.init.text+0x228): cannot reach _raw_spin_lock_irqsave
> >>     hppa64-linux-ld: kernel/time/timekeeping.o(.init.text+0x320): cannot reach _raw_spin_unlock_irqrestore
> >>     hppa64-linux-ld: kernel/time/sched_clock.o(.init.text+0x170): cannot reach __muldi3
> >>     hppa64-linux-ld: kernel/time/sched_clock.o(.init.text+0x214): cannot reach __udivdi3
> >>     hppa64-linux-ld: kernel/time/sched_clock.o(.init.text+0x240): cannot reach __udivdi3
> >>     hppa64-linux-ld: kernel/time/sched_clock.o(.init.text+0x278): cannot reach printk
> >>     hppa64-linux-ld: kernel/seccomp.o(.init.text+0x44): cannot reach printk
> >>     hppa64-linux-ld: certs/system_keyring.o(.init.text+0x20): cannot reach printk
> >>     hppa64-linux-ld: certs/system_keyring.o(.init.text+0x8c): cannot reach panic
> >>     hppa64-linux-ld: certs/system_keyring.o(.init.text+0x118): cannot reach printk
> >>     hppa64-linux-ld: certs/system_keyring.o(.init.text+0x1d4): cannot reach printk
> >>     hppa64-linux-ld: certs/system_keyring.o(.init.text+0x1f8): cannot reach printk
> >>     hppa64-linux-ld: certs/system_keyring.o(.init.text+0x238): cannot reach printk
> >>     hppa64-linux-ld: mm/workingset.o(.init.text+0xfc): cannot reach printk
> >>     hppa64-linux-ld: fs/filesystems.o(.init.text+0xb0): cannot reach _raw_read_lock
> >>     hppa64-linux-ld: fs/filesystems.o(.init.text+0x130): cannot reach _raw_read_unlock
> >>     hppa64-linux-ld: fs/block_dev.o(.init.text+0xf0): cannot reach panic
> >>     hppa64-linux-ld: fs/aio.o(.init.text+0x50): cannot reach panic
> >>     hppa64-linux-ld: fs/ext4/super.o(.init.text+0x1e4): cannot reach printk
> >>     hppa64-linux-ld: fs/ext4/super.o(.init.text+0x220): cannot reach printk
> >>     hppa64-linux-ld: fs/jbd2/journal.o(.init.text+0x164): cannot reach printk
> >>     hppa64-linux-ld: fs/jbd2/journal.o(.init.text+0x1a4): cannot reach unknown
> >>     hppa64-linux-ld: fs/xfs/xfs_super.o(.init.text+0x6ec): cannot reach printk
> >>     hppa64-linux-ld: fs/xfs/xfs_super.o(.init.text+0x8ac): cannot reach wait_for_completion
> >>     hppa64-linux-ld: fs/xfs/xfs_super.o(.init.text+0x934): cannot reach unknown
> >>     hppa64-linux-ld: fs/xfs/xfs_super.o(.init.text+0x944): cannot reach unknown
> >>     hppa64-linux-ld: security/keys/proc.o(.init.text+0x94): cannot reach panic
> >>     hppa64-linux-ld: crypto/jitterentropy-kcapi.o(.init.text+0x38): cannot reach printk
> >>     hppa64-linux-ld: block/bsg.o(.init.text+0x150): cannot reach printk
> >>     hppa64-linux-ld: lib/sg_pool.o(.init.text+0xa4): cannot reach printk
> >>     hppa64-linux-ld: drivers/phy/phy-core.o(.init.text+0x64): cannot reach printk
> >>     hppa64-linux-ld: drivers/gpio/gpio-mockup.o(.init.text+0x2f4): cannot reach unknown
> >>     hppa64-linux-ld: drivers/char/ipmi/ipmi_msghandler.o(.init.text+0x4c): cannot reach mutex_lock
> >>
> >> ---
> >> 0-DAY CI Kernel Test Service, Intel Corporation
> >> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
> >
> >
>


-- 
Thanks,
~Nick Desaulniers
