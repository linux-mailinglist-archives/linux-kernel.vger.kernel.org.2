Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2E945B482
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 07:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbhKXGws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 01:52:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:55314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233351AbhKXGwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 01:52:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BA4360FDC;
        Wed, 24 Nov 2021 06:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637736578;
        bh=Ebcw5RundFBpl8/xrGQfFKAmVAYDZlcyTj6seHP0/04=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CLTlJ/6eLy9WR3MM7Rh7Rxq7KIgTY0n18ugDU1PqxzOX5b0gIbXMoi8wDYElHWxKP
         9TJKjbY3aCgAxk3mMlhyL2g/iNIessGut8CNajnrJ/65jZ7yBDbcSL/PkckwzuwyeL
         S/neydtIpBNE0sMA/xoxwhQoxO4JKd4LYeHCRiNpWhpQKJ2vGevLHEdKQh5c6JAkvE
         l/Q6XebNOqM0/aUV9XZYb1aTMHwrSptncPbeb2gbFzYD2t3BBOq08L+h6GA/P9HZph
         JOD+ZyXwEMY51wY6BB6kswz0OExfK94++He2bLFBd4TyzSMP17oIr1ngcbfbKgz6FS
         775y/YDRoNHGQ==
Received: by mail-ua1-f42.google.com with SMTP id p37so2957513uae.8;
        Tue, 23 Nov 2021 22:49:38 -0800 (PST)
X-Gm-Message-State: AOAM531MxqT4ZGJIh6/AAdnH3cHkx9oeiW7OtD+5l2hpUVOyfmqVof7J
        ODGABCoIcM4zXnYetqFa4pDbrXz3mZIMIAd4UYY=
X-Google-Smtp-Source: ABdhPJygth1IGuwaFZgZO0p+p4TD2LPWUK8dsPPSI+Kuc0gZwg7fzZv9JR35/p2I5qVJ1zJnh3ZoPUsE0dyb8dJqiek=
X-Received: by 2002:a05:6102:3a11:: with SMTP id b17mr19909721vsu.28.1637736577183;
 Tue, 23 Nov 2021 22:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20211123015717.542631-1-guoren@kernel.org> <1913356.JkcO0Xq8vV@diego>
 <CAOnJCU+-WCHA9vgrbcMFsLMaimwJNEXOpqMLS_0Gq_JRM5QNWQ@mail.gmail.com>
In-Reply-To: <CAOnJCU+-WCHA9vgrbcMFsLMaimwJNEXOpqMLS_0Gq_JRM5QNWQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 24 Nov 2021 14:49:26 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQAypx=5+a84zZpj7ofs-aPpPMNZyaB+HEgD8Dfyt6TiA@mail.gmail.com>
Message-ID: <CAJF2gTQAypx=5+a84zZpj7ofs-aPpPMNZyaB+HEgD8Dfyt6TiA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] riscv: Add riscv.fwsz kernel parameter to save memory
To:     Atish Patra <atishp@atishpatra.org>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, atishp@rivosinc.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 4:01 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Tue, Nov 23, 2021 at 11:33 AM Heiko St=C3=BCbner <heiko@sntech.de> wro=
te:
> >
> > Hi Guo,
> >
> > Am Dienstag, 23. November 2021, 02:57:14 CET schrieb guoren@kernel.org:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > The firmware of riscv (such as opensbi) occupy 2MB(64bit) /
> > > 4MB(32bit) in Linux. It's very wasteful to small memory footprint
> > > soc chip such as Allwinner D1s/F133. The kernel parameter gives a
> > > chance to users to set the proper size of the firmware and get
> > > more than 1.5MB of memory.
> >
> > is this kernel parameter approach a result of the T-Head Ice-SoC
> > currently loading its openSBI from inside the main u-boot via extfs-loa=
d,
> > directly before the kernel itself [0] ?
>
> Looking at the defconfig[1], it may be U-Boot SPL not U-Boot proper. I
> may be looking at the wrong config though.
> If U-Boot SPL is actually used, you don't even need to manually load
> OpenSBI "fw_jump" binary.
>
> As Heiko pointed, you should just follow how U-Boot SPL works on
> hifive unmatched (creating the FIT image)
> The standard U-Boot SPL uses with fw_dynamic which provides all the
> flexibility you want.
I've no right to force users' flavor of boot flow.

1) SPL -> opensbi M-mode -> u-boot S-mode -> Linux
2) SPL -> u-boot M-mode -> opensbi M-mode -> Linux

All are okay for me. I think the most straightforward reason for
people choosing 2) is that they want to try the newest OpenSBI & Linux
and 2) is more convenient for replacing.

>
> [1] https://github.com/T-head-Semi/u-boot/blob/main/configs/ice_evb_c910_=
defconfig
> >
> > Because that approach in general looks not ideal.
> >
> > Normally you want the main u-boot already running with less privileges
> > so firmware like openSBI should've been already loaded before that.
> > Even more true when you're employing methods to protect memory regions
> > from less privileged access.
> >
> > A lot of socs set u-boot as opensbi payload, but for the example the D1
> > mainline approach uses the Allwinner TOC1 image format to load both
> > opensbi and the main uboot into memory from its 1st stage loader.
> >
> >
> > Of course the best way would be to just mimic what a number of
> > arm64 and also riscv socs do and use already existing u-boot utilities.
> >
> > U-Boot can create a FIT image containing both main u-boot, dtb and
> > firmware images that all get loaded from SPL and placed at the correct
> > addresses before having the SPL jump into opensbi and from there
> > into u-boot [1] .
> >
> > And as Anup was writing, reserved-memory should then be the way
> > to go to tell the kernel what regions to omit.
> >
> > And mainline u-boot has already the means to even take the reserved-mem=
ory
> > from the devicetree used by opensbi and copy it to a new devicetree,
> > if the second one is different.
> >
> >
> > Heiko
> >
> >
> > [0] https://github.com/T-head-Semi/u-boot/blob/main/include/configs/ice=
-c910.h#L46
> > [1] see spl_invoke_opensbi() in common/spl/spl_opensbi.c
> > [2] see riscv_board_reserved_mem_fixup() in arch/riscv/lib/fdt_fixup.c
> >
> > >
> > > Guo Ren (3):
> > >   riscv: Remove 2MB offset in the mm layout
> > >   riscv: Add early_param to decrease firmware region
> > >   riscv: Add riscv.fwsz kernel parameter
> > >
> > >  .../admin-guide/kernel-parameters.txt         |  3 +++
> > >  arch/riscv/include/asm/page.h                 |  8 +++++++
> > >  arch/riscv/kernel/head.S                      | 10 +++-----
> > >  arch/riscv/kernel/vmlinux.lds.S               |  5 ++--
> > >  arch/riscv/mm/init.c                          | 23 ++++++++++++++++-=
--
> > >  5 files changed, 36 insertions(+), 13 deletions(-)
> > >
> > >
> >
> >
> >
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
> --
> Regards,
> Atish



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
