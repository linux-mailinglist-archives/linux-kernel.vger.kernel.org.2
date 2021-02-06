Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8EF311C9A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 11:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBFK2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 05:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhBFK2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 05:28:33 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154B3C06174A;
        Sat,  6 Feb 2021 02:27:53 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id y17so8184500ili.12;
        Sat, 06 Feb 2021 02:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DVNmJAoeq9wlQbsr8Q3rhhYVpPsGp6lqUj0p5GBijlc=;
        b=s+5gSUt+0UpRLwHFTDFQq1G9os7t1BvxRSvC/Mjk03zHgmil5eNmMTP28O17wREEON
         0ODxo7e/KAUFyY9McZc+XA5TebyiCL7+gtn3emZoEEJ1XrufjEY8BJ469hfrDIDd5vsE
         nOgkW7Sn0XHeo6VC7dffMDdOlrJwZmkxosh1SKp17dVEyzrVkaJOusO8owK0bJjle7uq
         cZk8hnf9dD2UCJUvpWL9IM6F/AVuiDqejGiTyAXZ0SAiCu2jZKuqpUjobw+II2TlOzou
         aun649mY2g9A9FFtLuE6/f8ZI3tfmTFQmNZlFoy1hQSepm09lKRqMC1bFt1YSEquwC1U
         nhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVNmJAoeq9wlQbsr8Q3rhhYVpPsGp6lqUj0p5GBijlc=;
        b=KracAz3Ddk34XSlmdh8zmYvJJROv0+rULaxF74lF2Z7kg1+KWwZO6AfWx+cgdHmyQo
         fnwJHAUyxrrzPWt5XAaGHEZstlZB2JxF3iQgy3tltwfRhEkUeHwiwcmAD60FoFmfQZAF
         HKh41SwN2Xed5K1j859gfFrFTdb5hOPgndo+YTdjJAsbHXJhz8HhLrVeyPU0ixY6Ky/j
         hgBivGnwZ68PsvgJvK/r727+d9vFXhGZWtCrpymQxVAT7804NfIZQg9Fmyu2z3bSIGK0
         sEM2ZvdsXs5Swzxc594qbWGvvp24rnd3dikZVC0JXFVpPIIQkp2EjKfWClqYLF7Fk+6e
         ooGg==
X-Gm-Message-State: AOAM530x/REGB2dNGBOXSYhzAJnQPRgrJCTxMHZKWo+QZPUFih3HBKlD
        Q4EUFeF7t1PW6YIipqkLYS36mNXWvoQyq6eCph16QMxKIvc=
X-Google-Smtp-Source: ABdhPJy+i1itBLCmYeachXx42HuBJD1HPhrm9+h9SkQvlzzIako81v26SyTpg40C6wIESyXd1kRYkvovuEJ6VYDVEQM=
X-Received: by 2002:a05:6e02:1bad:: with SMTP id n13mr7333713ili.260.1612607272469;
 Sat, 06 Feb 2021 02:27:52 -0800 (PST)
MIME-Version: 1.0
References: <87a6skw31l.fsf@igel.home> <mhng-5072e618-a4fa-4982-a3ba-e395cde8a145@palmerdabbelt-glaptop>
In-Reply-To: <mhng-5072e618-a4fa-4982-a3ba-e395cde8a145@palmerdabbelt-glaptop>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Sat, 6 Feb 2021 12:27:16 +0200
Message-ID: <CAEn-LTpcO_mX-w_nbLKtf-0AszYPpQ=ren7Tk90OuLSZBiBhRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] fix macb phy probe failure if phy-reset is not handled
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, devicetree@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>, kernel@esmil.dk,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Yash Shah <yash.shah@sifive.com>, robh+dt@kernel.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        sagar.kadam@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 5:42 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Thu, 04 Feb 2021 02:16:54 PST (-0800), schwab@linux-m68k.org wrote:
> > On Jan 13 2021, Palmer Dabbelt wrote:
> >
> >> On Tue, 10 Nov 2020 07:22:09 PST (-0800), sagar.kadam@sifive.com wrote:
> >>> HiFive Unleashed is having VSC8541-01 ethernet phy device and requires a
> >>> specific reset sequence of 0-1-0-1 in order to use it in unmanaged mode.
> >>> This series addresses a corner case where phy reset is not handled by boot
> >>> stages prior to linux.
> >>> Somewhat similar unreliable phy probe failure was reported and discussed
> >>> here [1].
> >>> The macb driver fails to detect the ethernet phy device if the bootloader
> >>> doesn't provide a proper reset sequence to the phy device or the phy itself
> >>> is in some invalid state. Currently, the FSBL or u-boot-spl is resetting
> >>> the phy device, and so there is no issue observed in the linux network
> >>> setup.
> >>>
> >>> The series is based on linux-5.10-rc5.
> >>> Patch 1: Add the OUI to the phy dt node to fix issue of missing mdio device
> >>> Patch 2 and 3:
> >>>     Resetting phy needs GPIO support so add to dt and defconfig.
> >>>
> >>> [1] https://lkml.org/lkml/2018/11/29/154
> >>>
> >>> To reproduce the issue:
> >>> Using FSBL:
> >>> 1. Comment out VSC8541 reset sequence in fsbl/main.c
> >>>    from within the freedom-u540-c000-bootloader.
> >>> 2. Build and flash fsbl.bin to micro sdcard.
> >>>
> >>> Using u-boot:
> >>> 1. Comment out VSC8541 reset sequence in board/sifive/fu540/spl.c
> >>>    from mainline u-boot source code.
> >>> 2. Build and flash u-boot binaries to micro sdcard.
> >>>
> >>> Boot the board and bootlog will show network setup failure messages as:
> >>>
> >>> [  1.069474] libphy: MACB_mii_bus: probed
> >>> [  1.073092] mdio_bus 10090000.ethernet-ffffffff: MDIO device at address 0
> >>>            is missing
> >>> .....
> >>> [  1.979252] macb 10090000.ethernet eth0: Could not attach PHY (-19)
> >>>
> >>> 3. Now apply the series build, and boot kernel.
> >>> 4. MACB and VSC8541 driver get successfully probed and the network is set
> >>>    without any failure.
> >>>
> >>>
> >>> So irrespective of whether the prior stages handle the phy reset sequence,
> >>> the probing is successful in both the cases of cold boot and warm boot.
> >>>
> >>> Change History:
> >>> ===============================
> >>> V2:
> >>> -Rebased v1 on linux kernel v5.10-rc3.
> >>>
> >>> V1:
> >>> -Ignore 4th patch as suggested and so removed it from the series.
> >>> -Verified this series on 5.7-rc5.
> >>>
> >>> V0: Base RFC patch. Verified on 5.7-rc2
> >>>
> >>> Sagar Shrikant Kadam (3):
> >>>   dts: phy: fix missing mdio device and probe failure of vsc8541-01
> >>>     device
> >>>   dts: phy: add GPIO number and active state used for phy reset
> >>>   riscv: defconfig: enable gpio support for HiFive Unleashed
> >>>
> >>>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 2 ++
> >>>  arch/riscv/configs/defconfig                        | 2 ++
> >>>  2 files changed, 4 insertions(+)
> >>
> >> David pointed out I missed these, they're on fixes.  Thanks!
> >
> > This is now on 5.10.12, and breaks ethernet on the Hifive Unleashed:
> >
> > [   12.777976] macb 10090000.ethernet: Registered clk switch 'sifive-gemgxl-mgmt'
> > [   12.784559] macb 10090000.ethernet: GEM doesn't support hardware ptp.
> > [   12.791629] libphy: MACB_mii_bus: probed
> > [   12.919728] MACsec IEEE 802.1AE
> > [   12.984676] macb 10090000.ethernet eth0: Cadence GEM rev 0x10070109 at 0x10090000 irq 16 (70:b3:d5:92:f1:07)
> > [   14.030319] Microsemi VSC8541 SyncE 10090000.ethernet-ffffffff:00: phy_poll_reset failed: -110
> > [   14.038986] macb 10090000.ethernet eth0: Could not attach PHY (-110)
>
> Sorry about that.  Looks like we forgot to add the special reset sequence to
> the VSC8541, which the driver doesn't yet support (there's a thread about it,
> but I guess I forgot to clean up the patch).  IIUC this should manifest on
> master as well, so my guess is that nobody is testing the HiFive Unleashed any
> more (probably a bad sign).

BayLibre has Unleashed connected to KernelCI. I did notice:

[..]
08:24:37.572482  <3>[    2.022855] Microsemi VSC8541 SyncE
10090000.ethernet-ffffffff:00: phy_poll_reset failed: -110
08:24:37.574273  <3>[    2.031882] macb 10090000.ethernet eth0: Could
not attach PHY (-110)
08:24:37.575304  <3>[    2.037772] IP-Config: Failed to open eth0
08:24:37.576087  <3>[    2.042087] IP-Config: No network devices available
08:24:37.576863  <6>[    2.053662] Freeing unused kernel memory: 2144K
08:24:37.577412  <6>[    2.057794] Run /init as init process
[..]

in KCIDB.

I don't use KernelCI extensively, but today at FOSDEM I was told that
KernelCI also incl. "including maintainer ones".

I guess the idea would be to check and ensure that all relevant trees
are tested in KernelCI.


>
> I'll send out a revert.  I looked at the GPIO driver and can't tell if it's
> twiddling GPIO lines when probed, in which case just enabling the GPIO would
> break the ethernet.  Hopefully we're OK with the GPIO driver enabled.
>
> Thanks for testing this.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
