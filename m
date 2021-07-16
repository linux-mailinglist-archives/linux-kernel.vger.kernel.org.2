Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586BF3CB7AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 15:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbhGPNHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbhGPNG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:06:56 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFD90C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 06:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=PWw4hK0cXSC8fe2icAs8ZJRU7ppP5otO7G
        /VcmZBdKY=; b=nxA3M2ZjRaxl7wkglFuEBxfK84S1MxWl4R5ZpGwc5VpzuPELqn
        IjMOWkTl6uc5Cyw9RJZNFLmi6hpJD6r6uOfyigB3bds9L0ftcJkmURbWBlQxedBL
        YpPGYzACK+H1J2c0ZtdrKQp7yHdaIOTq+Rpwsks5KPPBkxAg9x9877QlU=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDHM+izg_Fg9Y57AA--.56756S2;
        Fri, 16 Jul 2021 21:03:47 +0800 (CST)
Date:   Fri, 16 Jul 2021 20:57:57 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jisheng Zhang <jszhang@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] RISC-V Patches for the 5.14 Merge Window, Part 1
Message-ID: <20210716205758.05620241@xhacker>
In-Reply-To: <cb401208-8774-9653-e780-6e9d4d3a41c0@ghiti.fr>
References: <mhng-90f1c895-95b6-4480-937d-ee859a4542c3@palmerdabbelt-glaptop>
        <cb401208-8774-9653-e780-6e9d4d3a41c0@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: LkAmygDHM+izg_Fg9Y57AA--.56756S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JrW8Zw1fAr45GryrXFy7Jrb_yoW7uF4Dpr
        n3tFW3GrW5XF1kJr4Ut34UZFWjqry8Ja1UXr18JFy8Ars0yryjgr1jgr1v9ryUJrWrJr1U
        Gr1rJry7Zr1UJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        W3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
        JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5IksPUUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021 09:11:14 +0200
Alex Ghiti <alex@ghiti.fr> wrote:

> Hi Palmer,
>=20
> Le 11/07/2021 =C3=A0 20:45, Palmer Dabbelt a =C3=A9crit=C2=A0:
> > On Fri, 09 Jul 2021 12:58:10 PDT (-0700), alex@ghiti.fr wrote: =20
> >>
> >>
> >> Le 9/07/2021 =C3=A0 16:53, Palmer Dabbelt a =C3=A9crit=C2=A0: =20
> >>> The following changes since commit=20
> >>> 8a4102a0cf07cc76a18f373f6b49485258cc6af4:
> >>>
> >>> =C2=A0=C2=A0 riscv: mm: Fix W+X mappings at boot (2021-06-01 21:15:09=
 -0700)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>> =C2=A0=C2=A0 git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linu=
x.git=20
> >>> tags/riscv-for-linus-5.14-mw0
> >>>
> >>> for you to fetch changes up to 1958e5aef5098e28b7d6e6a2972649901ebeca=
ce:
> >>>
> >>> =C2=A0=C2=A0 riscv: xip: Fix duplicate included asm/pgtable.h (2021-0=
7-06=20
> >>> 16:17:40 -0700)
> >>>
> >>> ----------------------------------------------------------------
> >>> RISC-V Patches for the 5.14 Merge Window, Part 1
> >>>
> >>> In addition to We have a handful of new features for 5.14:
> >>>
> >>> * Support for transparent huge pages.
> >>> * Support for generic PCI resources mapping.
> >>> * Support for the mem=3D kernel parameter.
> >>> * Support for KFENCE.
> >>> * A handful of fixes to avoid W+X mappings in the kernel.
> >>> * Support for VMAP_STACK based overflow detection.
> >>> * An optimized copy_{to,from}_user.
> >>> ----------------------------------------------------------------
> >>> There are some Kconfig merge conflicts.=C2=A0 They should be pretty
> >>> straight-forward, but we do have a symbol out of order -- I thought I=
=20
> >>> had a
> >>> script to check for that, but I guess it doesn't work.=C2=A0 I just s=
ent=20
> >>> out a patch
> >>> to fix it up.
> >>>
> >>> diff --cc arch/riscv/Kconfig
> >>> index 3590eb76000e,469a70bd8da6..d36f3c5029fd
> >>> --- a/arch/riscv/Kconfig
> >>> +++ b/arch/riscv/Kconfig
> >>> @@@ -60,12 -61,11 +61,12 @@@ config RISC
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select GENERIC_TIME_=
VSYSCALL if MMU && 64BIT
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HANDLE_DOMAIN=
_IRQ
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_ARCH_AUD=
ITSYSCALL
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_ARCH_JUMP_LABEL
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_ARCH_JUMP_LABEL_REL=
ATIVE
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_ARCH_JUMP_LABEL if =
!XIP_KERNEL
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_ARCH_JUMP_LABEL_REL=
ATIVE if !XIP_KERNEL
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_ARCH_KAS=
AN if MMU && 64BIT
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_ARCH_KAS=
AN_VMALLOC if MMU && 64BIT
> >>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_ARCH_KFENCE if MMU=
 && 64BIT
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_ARCH_KGDB
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_ARCH_KGDB if !XIP_K=
ERNEL
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_ARCH_KGD=
B_QXFER_PKT
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_ARCH_MMA=
P_RND_BITS if MMU
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_ARCH_SEC=
COMP_FILTER
> >>> @@@ -81,11 -80,9 +82,14 @@@
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_GCC_PLUG=
INS
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_GENERIC_=
VDSO if MMU && 64BIT
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_IRQ_TIME=
_ACCOUNTING
> >>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_KPROBES
> >>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_KPROBES_ON_FTRACE
> >>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_KRETPROBES
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_KPROBES if !XIP_KER=
NEL
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_KPROBES_ON_FTRACE i=
f !XIP_KERNEL
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_KRETPROBES if !XIP_=
KERNEL
> >>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_MOVE_PMD
> >>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_MOVE_PUD
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_PCI
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_PERF_EVE=
NTS
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_PERF_REGS
> >>> @@@ -108,7 -104,7 +112,8 @@@
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SYSCTL_EXCEPT=
ION_TRACE
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select THREAD_INFO_I=
N_TASK
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select UACCESS_MEMCP=
Y if !MMU
> >>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAVE_ARCH_TRANSPARENT_H=
UGEPAGE if 64BIT && MMU
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ZONE_DMA32 if 64BIT
> >>>
> >>> =C2=A0=C2=A0 config ARCH_MMAP_RND_BITS_MIN
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default 18 if 64BIT
> >>> ----------------------------------------------------------------
> >>> Akira Tsukamoto (1):
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv: __asm_copy_to-from_user: =
Optimize unaligned memory=20
> >>> access and pipeline stall
> >>>
> >>> Alexandre Ghiti (6):
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv: Remove CONFIG_PHYS_RAM_BA=
SE_FIXED
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv: Simplify xip and !xip ker=
nel address conversion macros =20
> >>
> >> @Palmer: As said in the thread of this patchset multiple times, those 2
> >> patches should not be merged as it assumes that the base DRAM address =
is
> >> always 0x8000_0000 for all rv64 platforms: I don't think it is true,=20
> >> is it? =20
> >=20
> > Sorry, I remember saying something about that but must have missed the=
=20
> > resposeses.=C2=A0 Do you have a pointer to the discussion?=C2=A0 If thi=
s break=20
> > stuff I'm happy to revert it, which can be done post-rc1.=C2=A0 I just =
need=20
> > to see what's actually broken first, because IIUC this was de-facto how=
=20
> > things worked already.
> >  =20
>=20
> Really sorry about my response delay.
>=20
> The thing is that removing CONFIG_PHYS_RAM_BASE_FIXED defines=20
> CONFIG_PHYS_RAM_BASE to 0x8000_0000 for all rv64 chips, but I believe=20
> this is implementation specific: for now, this base address was passed=20
> into the device tree, and here it makes this value static.
>=20
> This issue with my patch was originally pointed by Jisheng, Geert and Arn=
d.
>=20
> If this is not a problem and you have a pointer to a document that=20
> specifies this, I would be very happy to have the link :)
>=20
> Thanks and again sorry about my response delay,
>=20

Hi Alex,

Since the PR has been merged into linux-5.14-rc1, directly reverting seems
not a good idea. IMHO, it's better to send patch(es) against current 5.14-r=
c1
tree. what do you think?

Thanks

