Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6705F4530F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhKPLkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:40:23 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:55589 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbhKPLjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:39:36 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HtkY06qRJz4xbs;
        Tue, 16 Nov 2021 22:36:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1637062597;
        bh=3gmnuVR0ZDq3D/dsvwVVxyiduZCANCdj3Im+ow/dMhg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VDcbNkoppC73dGW7O6ycB2VPmmVLUSst4ueBOa8n5kNTkZ9Kys0nOkTGys0xdwAf4
         LTqC0DG1yFY75x3BhzzoRsXTMQOnmsPc/ST3vVhhQSTjmNlgLXWfzBgvJhC7+RYy3U
         VqeUVMhyk15ZGcHPozwl+nnyqv3fi4kpcC+EU/4Fs4cUL612ns/7aQPRioaQmRIgwB
         GHTlvxJ1UJ+1ljLccRTaOfJFwMSllZGyuZCcjoT5hVieoAi/IeOgMUvGKTC4xMRIMa
         fHtkDU0wi8gkdCstyDT2EWyA1iqSaqRp/6z9ugHkDXWg1Hyn3P0JyWihdjmg6KMf+/
         djuIfFBFkqVfA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.16-rc1
In-Reply-To: <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net>
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net>
 <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
 <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net>
Date:   Tue, 16 Nov 2021 22:36:33 +1100
Message-ID: <87a6i4miwu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:
> On 11/14/21 9:21 PM, Linus Torvalds wrote:
>> On Sun, Nov 14, 2021 at 8:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> With gcc 5.4, mips:mapta_defconfig
>>> mips-linux-gcc.br_real: error: unrecognized command line option =E2=80=
=98-Wimplicit-fallthrough=3D5=E2=80=99
>>=20
>> This (and the gcc-6.x ones for sh4eb/sparc/xtensa) are already fixed
>> in my tree. They're all "old gcc didn't support that flag" things with
>> a trivial one-liner fix.
>>=20
>> I was hoping you didn't have older gcc versions, but you clearly do ;^p
>>=20
>
> Top of tree is a bit better:
>
> Build results:
> 	total: 153 pass: 141 fail: 12
> Failed builds:
> 	arm:allmodconfig
> 	arm64:allmodconfig
> 	csky:defconfig
> 	csky:allmodconfig
> 	mips:allmodconfig
> 	parisc:allmodconfig
> 	powerpc:allmodconfig
> 	powerpc:ppc6xx_defconfig
> 	riscv32:allmodconfig
> 	riscv:allmodconfig
> 	s390:allmodconfig
> 	sparc64:allmodconfig
> Qemu test results:
> 	total: 482 pass: 476 fail: 6
> Failed tests:
> 	ppc64:mac99:ppc64_book3s_defconfig:smp:net,ne2k_pci:initrd
> 	ppc64:mac99:ppc64_book3s_defconfig:smp:net,pcnet:ide:rootfs
> 	ppc64:mac99:ppc64_book3s_defconfig:smp:net,e1000:sdhci:mmc:rootfs
> 	ppc64:mac99:ppc64_book3s_defconfig:smp:net,e1000e:nvme:rootfs
> 	ppc64:mac99:ppc64_book3s_defconfig:smp:net,virtio-net:scsi[DC395]:rootfs


My qemu mac99 test is passing, but I guess your tests are enabling more
devices or something to trigger that breakage?

> powerpc:allmodconfig
>
> fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
> fs/ntfs/aops.c:1311:1: error: the frame size of 2240 bytes is larger than=
 2048 bytes
>
> Bisect points to commit f22969a6604 ("powerpc/64s: Default to 64K pages f=
or
> 64 bit book3s"), and reverting that commit does fix the problem.
> The problem is
> 	ntfs_inode *locked_nis[PAGE_SIZE / NTFS_BLOCK_SIZE];
>
> I don't see the problem in next-20211115, but I don't immediately see how=
 it was fixed there.

I still see it in next.

I don't know what to do about it though. The NTFS folks presumably don't
want to rewrite their code to avoid a warning on powerpc, we have no
real interest in NTFS, and definitely no expertise in the NTFS code. We
don't want to revert the 64K change, and even if we did the warning
would still be there for other 64K page configs.

I guess we need to bump CONFIG_FRAME_WARN a bit when 64K pages is
enabled? But even that is a bit gross because the stack size doesn't
increase based on the page size.

> powerpc:ppc6xx_defconfig
>
> arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c: In function 'mcu_remove':
> arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c:189:13: error: unused vari=
able 'ret'
>
> Caused by commit 5d354dc35ebb ("powerpc/83xx/mpc8349emitx: Make mcu_gpioc=
hip_remove()
> return void"). Still seen in -next.

I have a fix queued for that, will hit -next tomorrow.

> powerpc:qemu_ppc64_book3s_defconfig:
>
> arch/powerpc/mm/slice.c: In function =E2=80=98slice_get_unmapped_area=E2=
=80=99:
> arch/powerpc/mm/slice.c:639:1: error: the frame size of 1056 bytes is lar=
ger than 1024 bytes
>
> Bisect again points to commit f22969a6604 ("powerpc/64s: Default to 64K p=
ages
> for 64 bit book3s"), and reverting that commit does fix the problem.

I'm not sure what qemu_ppc64_book3s_defconfig is, it's not an upstream
defconfig, and I couldn't quite see how it's generated in your scripts.

But if it's a 64-bit config it should be using 2048 bytes, from
lib/Kconfig.debug:

config FRAME_WARN
	int "Warn for stack frames larger than"
	range 0 8192
	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
	default 1536 if (!64BIT && (PARISC || XTENSA))
	default 1024 if (!64BIT && !PARISC)
	default 2048 if 64BIT


cheers
