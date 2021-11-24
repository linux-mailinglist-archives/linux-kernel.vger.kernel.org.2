Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7103C45B46E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 07:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbhKXGpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 01:45:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbhKXGpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 01:45:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDC5E60FE6;
        Wed, 24 Nov 2021 06:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637736149;
        bh=EUZz/irRHK/K5cWidrRrSLI5RdyDjoqd/i2pUIYgwxk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sa61kDt/xcJph+Zgh4EZ1Dcutn9HW3EzhO/vhv5IQOuebf3nYMD49T7ESjLcuyesX
         r6OabXx7cICY5Q+P5nc1PSgNpm0X+2MfwRYshlrgp789tn8WGp+nuUbCRdcdx2viqZ
         0fzCuNiGKjlJSSTqPHQMC1KKIwz/s6lZ9/Rl0I5907M3d0fFaBRwvCYZruW+UJkM4/
         qVvbCMfYkJAVhnUB6tuPl+1WAAXzxSLFky5OFJyD4lQqoEnbrs5TcP5IM/lYqzk9lf
         xfZXvbWlH60+onwdKH8sawZCx1bNCIfovhdkY8A0jdXywwOi/2CKlz80DV+Tu9o0no
         7fb7Jg8T8ALyg==
Received: by mail-ua1-f47.google.com with SMTP id a14so3077591uak.0;
        Tue, 23 Nov 2021 22:42:28 -0800 (PST)
X-Gm-Message-State: AOAM531eG81FY0tIlsXWVSezs7HX/lYkrCdFfSwStsHzdd4SUoC3BZLv
        qHLwx4PM2YL2pJ/q821NW8JIvgih/j24ledaA/8=
X-Google-Smtp-Source: ABdhPJygpTPIjs1D0SU6N20VeUeK3Lsie8ae7u5P3VPLnPjeBp6n3aFVYUkYgeHtNDY54LHL3QnDVrRSG9ZreujYxGg=
X-Received: by 2002:ab0:6883:: with SMTP id t3mr6453103uar.66.1637736148026;
 Tue, 23 Nov 2021 22:42:28 -0800 (PST)
MIME-Version: 1.0
References: <20211123015717.542631-1-guoren@kernel.org> <1913356.JkcO0Xq8vV@diego>
In-Reply-To: <1913356.JkcO0Xq8vV@diego>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 24 Nov 2021 14:42:17 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSwousS4DHWuqprkkckbRa-J=M_a5vSVJ5CiAjDvqGh9w@mail.gmail.com>
Message-ID: <CAJF2gTSwousS4DHWuqprkkckbRa-J=M_a5vSVJ5CiAjDvqGh9w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] riscv: Add riscv.fwsz kernel parameter to save memory
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, atishp@rivosinc.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 3:33 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Guo,
>
> Am Dienstag, 23. November 2021, 02:57:14 CET schrieb guoren@kernel.org:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The firmware of riscv (such as opensbi) occupy 2MB(64bit) /
> > 4MB(32bit) in Linux. It's very wasteful to small memory footprint
> > soc chip such as Allwinner D1s/F133. The kernel parameter gives a
> > chance to users to set the proper size of the firmware and get
> > more than 1.5MB of memory.
>
> is this kernel parameter approach a result of the T-Head Ice-SoC
> currently loading its openSBI from inside the main u-boot via extfs-load,
> directly before the kernel itself [0] ?
The patch is not related to that issue. The patch just helps users who
put opensbi at 0~2MB paddr to save memory.

>
> Because that approach in general looks not ideal.
>
> Normally you want the main u-boot already running with less privileges
> so firmware like openSBI should've been already loaded before that.
> Even more true when you're employing methods to protect memory regions
> from less privileged access.
>
> A lot of socs set u-boot as opensbi payload, but for the example the D1
> mainline approach uses the Allwinner TOC1 image format to load both
> opensbi and the main uboot into memory from its 1st stage loader.
>
>
> Of course the best way would be to just mimic what a number of
> arm64 and also riscv socs do and use already existing u-boot utilities.
>
> U-Boot can create a FIT image containing both main u-boot, dtb and
> firmware images that all get loaded from SPL and placed at the correct
> addresses before having the SPL jump into opensbi and from there
> into u-boot [1] .
>
> And as Anup was writing, reserved-memory should then be the way
> to go to tell the kernel what regions to omit.
>
> And mainline u-boot has already the means to even take the reserved-memor=
y
> from the devicetree used by opensbi and copy it to a new devicetree,
> if the second one is different.
>
>
> Heiko
>
>
> [0] https://github.com/T-head-Semi/u-boot/blob/main/include/configs/ice-c=
910.h#L46
> [1] see spl_invoke_opensbi() in common/spl/spl_opensbi.c
> [2] see riscv_board_reserved_mem_fixup() in arch/riscv/lib/fdt_fixup.c
>
> >
> > Guo Ren (3):
> >   riscv: Remove 2MB offset in the mm layout
> >   riscv: Add early_param to decrease firmware region
> >   riscv: Add riscv.fwsz kernel parameter
> >
> >  .../admin-guide/kernel-parameters.txt         |  3 +++
> >  arch/riscv/include/asm/page.h                 |  8 +++++++
> >  arch/riscv/kernel/head.S                      | 10 +++-----
> >  arch/riscv/kernel/vmlinux.lds.S               |  5 ++--
> >  arch/riscv/mm/init.c                          | 23 ++++++++++++++++---
> >  5 files changed, 36 insertions(+), 13 deletions(-)
> >
> >
>
>
>
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
