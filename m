Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136CD45BBBB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 13:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243432AbhKXMWt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Nov 2021 07:22:49 -0500
Received: from gloria.sntech.de ([185.11.138.130]:32852 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243495AbhKXMQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 07:16:28 -0500
Received: from ip5f5b2004.dynamic.kabel-deutschland.de ([95.91.32.4] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mpr9D-0005HW-3K; Wed, 24 Nov 2021 13:13:11 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Atish Patra <atishp@atishpatra.org>,
        linux-riscv@lists.infradead.org
Cc:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, atishp@rivosinc.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 0/3] riscv: Add riscv.fwsz kernel parameter to save memory
Date:   Wed, 24 Nov 2021 13:13:10 +0100
Message-ID: <7549655.ZlQDL8uBSY@diego>
In-Reply-To: <CAJF2gTQAypx=5+a84zZpj7ofs-aPpPMNZyaB+HEgD8Dfyt6TiA@mail.gmail.com>
References: <20211123015717.542631-1-guoren@kernel.org> <CAOnJCU+-WCHA9vgrbcMFsLMaimwJNEXOpqMLS_0Gq_JRM5QNWQ@mail.gmail.com> <CAJF2gTQAypx=5+a84zZpj7ofs-aPpPMNZyaB+HEgD8Dfyt6TiA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 24. November 2021, 07:49:26 CET schrieb Guo Ren:
> On Wed, Nov 24, 2021 at 4:01 AM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Tue, Nov 23, 2021 at 11:33 AM Heiko Stübner <heiko@sntech.de> wrote:
> > >
> > > Hi Guo,
> > >
> > > Am Dienstag, 23. November 2021, 02:57:14 CET schrieb guoren@kernel.org:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > The firmware of riscv (such as opensbi) occupy 2MB(64bit) /
> > > > 4MB(32bit) in Linux. It's very wasteful to small memory footprint
> > > > soc chip such as Allwinner D1s/F133. The kernel parameter gives a
> > > > chance to users to set the proper size of the firmware and get
> > > > more than 1.5MB of memory.
> > >
> > > is this kernel parameter approach a result of the T-Head Ice-SoC
> > > currently loading its openSBI from inside the main u-boot via extfs-load,
> > > directly before the kernel itself [0] ?
> >
> > Looking at the defconfig[1], it may be U-Boot SPL not U-Boot proper. I
> > may be looking at the wrong config though.
> > If U-Boot SPL is actually used, you don't even need to manually load
> > OpenSBI "fw_jump" binary.
> >
> > As Heiko pointed, you should just follow how U-Boot SPL works on
> > hifive unmatched (creating the FIT image)
> > The standard U-Boot SPL uses with fw_dynamic which provides all the
> > flexibility you want.
> I've no right to force users' flavor of boot flow.
> 
> 1) SPL -> opensbi M-mode -> u-boot S-mode -> Linux
> 2) SPL -> u-boot M-mode -> opensbi M-mode -> Linux
>
> All are okay for me. I think the most straightforward reason for
> people choosing 2) is that they want to try the newest OpenSBI & Linux
> and 2) is more convenient for replacing.

Though that second option is merely a hack during development.

Having u-boot run in M-mode creates an attack surface that is a lot
bigger (with it running usb, ethernet and whatnot) compared to shedding
privileges before that.

I'd consider openSBI as part of the device firmware, so that shouldn't be
a component you replace daily. Also U-Boot for example already provides
established ways to sign and verify the parts loaded by SPL, by signing
the created FIT image this would also include the openSBI image.

So in case (1) you can add more security by simply adding the necessary
key references during u-boot build, where on the other hand if you _want_
security in case (2) you're back to hand-rolling any verification
[with less review and thus more prone to have issues]

Having the _ability_ to verify the loaded firmware components can be a
requirement in projects, so I think the default should always case (1),
to not encourage insecure implementations any more than necessary ;-) .


Heiko


> >
> > [1] https://github.com/T-head-Semi/u-boot/blob/main/configs/ice_evb_c910_defconfig
> > >
> > > Because that approach in general looks not ideal.
> > >
> > > Normally you want the main u-boot already running with less privileges
> > > so firmware like openSBI should've been already loaded before that.
> > > Even more true when you're employing methods to protect memory regions
> > > from less privileged access.
> > >
> > > A lot of socs set u-boot as opensbi payload, but for the example the D1
> > > mainline approach uses the Allwinner TOC1 image format to load both
> > > opensbi and the main uboot into memory from its 1st stage loader.
> > >
> > >
> > > Of course the best way would be to just mimic what a number of
> > > arm64 and also riscv socs do and use already existing u-boot utilities.
> > >
> > > U-Boot can create a FIT image containing both main u-boot, dtb and
> > > firmware images that all get loaded from SPL and placed at the correct
> > > addresses before having the SPL jump into opensbi and from there
> > > into u-boot [1] .
> > >
> > > And as Anup was writing, reserved-memory should then be the way
> > > to go to tell the kernel what regions to omit.
> > >
> > > And mainline u-boot has already the means to even take the reserved-memory
> > > from the devicetree used by opensbi and copy it to a new devicetree,
> > > if the second one is different.
> > >
> > >
> > > Heiko
> > >
> > >
> > > [0] https://github.com/T-head-Semi/u-boot/blob/main/include/configs/ice-c910.h#L46
> > > [1] see spl_invoke_opensbi() in common/spl/spl_opensbi.c
> > > [2] see riscv_board_reserved_mem_fixup() in arch/riscv/lib/fdt_fixup.c
> > >
> > > >
> > > > Guo Ren (3):
> > > >   riscv: Remove 2MB offset in the mm layout
> > > >   riscv: Add early_param to decrease firmware region
> > > >   riscv: Add riscv.fwsz kernel parameter
> > > >
> > > >  .../admin-guide/kernel-parameters.txt         |  3 +++
> > > >  arch/riscv/include/asm/page.h                 |  8 +++++++
> > > >  arch/riscv/kernel/head.S                      | 10 +++-----
> > > >  arch/riscv/kernel/vmlinux.lds.S               |  5 ++--
> > > >  arch/riscv/mm/init.c                          | 23 ++++++++++++++++---
> > > >  5 files changed, 36 insertions(+), 13 deletions(-)
> > > >
> > > >
> > >
> > >
> > >
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
> > --
> > Regards,
> > Atish
> 
> 
> 
> 




