Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810A33E1005
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbhHEIOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:14:14 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:46038 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhHEION (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:14:13 -0400
Received: by mail-yb1-f171.google.com with SMTP id a201so7723421ybg.12;
        Thu, 05 Aug 2021 01:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4JiRs4SLIpq2z7YmzfETWqM01LASuIHNJhpMEvug1s=;
        b=TtYk/EqiIApQ9bRPERgr545zgVSjiHshrg/b8FqhaTv4nMpXBG0UevejO/n9l3o30O
         k/DcN0J4kSf2NFPf6syFBMwDfMKMPlt5vnEEi5O3W1C7pSakhGtGvCZBt5F8l5fLZ25P
         kfmsNGKVPHON5iaXZk1BKbwqasqDo2BciPjDwzCGhFceXp3AvT/vtutsk8du7h9CfyD1
         QF8+FaeMTCwn5MrDG1IP4zxnaVqV09g7v8jePCQJDKjAT1Skpik0/KssthNoigDofgvE
         kp76REqgDs/L/UfUZKApoKfX1VJjY7Vb7NB4JydxIQaxC5iYlCH9MhJxkL6xXXU9PVHE
         5cag==
X-Gm-Message-State: AOAM532+XH9etElBdQbquSq0I/mIbtDpPf8DSxG4Uwxf7BUW5M61JwqO
        Mkmmiwvh6h2ylOrJB4Lxgf3KurSVpsCWY+HckkE=
X-Google-Smtp-Source: ABdhPJzsnmXBTwXVtAmKIPdr1xZOgPa9wWKTWsAgJUABTvuNi+iyrHPRqfp+0uiX1JT7I9tADwhB7lUvW81pL2PsVQk=
X-Received: by 2002:a25:4907:: with SMTP id w7mr4420162yba.393.1628151237954;
 Thu, 05 Aug 2021 01:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAOnJCUL9uU5G1LOgfYPz9Ny77yFYaP5sgtdxG3_w=Zcsi+f96Q@mail.gmail.com>
 <mhng-c9300c9e-6877-492f-a290-7c51066d3920@palmerdabbelt-glaptop> <20210805023024.GA12312@x1>
In-Reply-To: <20210805023024.GA12312@x1>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Thu, 5 Aug 2021 10:13:46 +0200
Message-ID: <CANBLGcwczBsc-mfU2t9=7No7KhHfBFHFzGy=5hdyEE+4VN8ksg@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: riscv: add starfive jh7100 bindings
To:     Drew Fustini <drew@pdp7.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Fu Wei <tekkamanninja@gmail.com>, jack.zhu@starfivetech.com,
        leyfoon.tan@starfivetech.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021 at 04:30, Drew Fustini <drew@pdp7.com> wrote:
> On Wed, Aug 04, 2021 at 02:13:47PM -0700, Palmer Dabbelt wrote:
> > On Wed, 04 Aug 2021 13:54:16 PDT (-0700), atishp@atishpatra.org wrote:
> > > On Wed, Aug 4, 2021 at 1:33 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > > >
> > > > On Thu, 15 Jul 2021 19:17:23 PDT (-0700), bmeng.cn@gmail.com wrote:
> > > > > On Tue, Jul 13, 2021 at 2:34 PM Drew Fustini <drew@beagleboard.org> wrote:
> > > > >>
> > > > >> Add DT binding documentation for the StarFive JH7100 Soc [1] and the
> > > > >> BeagleV Starlight JH7100 board [2].
> > > > >>
> > > > >> [1] https://github.com/starfive-tech/beaglev_doc
> > > > >> [2] https://github.com/beagleboard/beaglev-starlight
> > > > >>
> > > > >> Signed-off-by: Drew Fustini <drew@beagleboard.org>
> > > > >> ---
> > > > >> v4 changes:
> > > > >> - removed JH7100 SoC revision number after discussion with Geert
> > > > >>
> > > > >> v3 changes:
> > > > >> - added revision number for the board and soc after question from Palmer
> > > > >>
> > > > >> v2 changes:
> > > > >> - removed "items:" entry that only had "const: starfive,jh7100"
> > > > >> - correct typo in Description:
> > > > >>
> > > > >> Results of running checks:
> > > > >>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dt_binding_check \
> > > > >>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
> > > > >>     CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> > > > >>     DTEX    Documentation/devicetree/bindings/riscv/starfive.example.dts
> > > > >>     SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> > > > >>     DTC     Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
> > > > >>     CHECK   Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
> > > > >>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dtbs_check \
> > > > >>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
> > > > >>     SYNC    include/config/auto.conf.cmd
> > > > >>     UPD     include/config/kernel.release
> > > > >>     SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > > > >>     DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dtb
> > > > >>     DTC     arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
> > > > >>     DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
> > > > >>     DTC     arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
> > > > >>     CHECK   arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
> > > > >>     CHECK   arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
> > > > >>     CHECK   arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
> > > > >>
> > > > >> The dts file is from vendor repo and is being cleaned up right now in
> > > > >> preperation for submitting to the mailing list:
> > > > >> https://github.com/starfive-tech/linux/tree/beaglev/arch/riscv/boot/dts/starfive
> > > > >>
> > > > >>  .../devicetree/bindings/riscv/starfive.yaml   | 27 +++++++++++++++++++
> > > > >>  1 file changed, 27 insertions(+)
> > > > >>  create mode 100644 Documentation/devicetree/bindings/riscv/starfive.yaml
> > > > >>
> > > > >
> > > > > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > > >
> > > > Thanks.  This is on for-next, as Rob suggested taking it via the RISC-V
> > > > tree.
> > > >
> > > Given that beagleV starlight mass production is cancelled [1], are we
> > > still upstreaming the support for this ?
> >
> > I'm not sure, but I wasn't quite sure where to have that discussion.  I
> > figured that the boards exist so there's no reason to shoot this down, given
> > that it's just the vendor DT list.  At a bare minimum there's out of tree
> > support for this, so having the DT strings defined seems sane as that's a
> > defacto interface with bootloaders.
> >
> > Maybe this is more of a question for Drew: I think we were all OK working
> > through the issues with the first-run chip when there was going to be a lot
> > of them, but with such a small number produced I'm not sure if there's going
> > to be enough interested to take on all that effort.
> >
> > I'm not quite sure where we stand on support for this: at some point there
> > were some ideas floating around as to a way to support it without major
> > software changes (allocating into the non-caching regions).  If that pans
> > out then I'm fine handling this, at least from the RISC-V side, but if we're
> > going to have to go through all the ISA/SBI stuff then it's probably not
> > worth it.  Also not sure if there are a bunch of starfive-specific drivers
> > that would be needed to make this boot, in which case it's probably best to
> > wait for whatever comes next.
>
> I think that the discontinued beta prototype could be useful as a native
> build host for those of you that have it and don't have an Unmatched.

Also according to this statement [1], they're still planning on
producing new boards with the JH7100 (same chip as on the BeagleV
prototype) at the end of Q3 and the JH7110 further in the future, so I
still think it'd make sense to support those.

[1]: https://www.design-reuse.com/news/50402/starfive-open-source-single-board-platform-q3-2021.html

> The arch_sync_dma RFC from Atish [1] is key to the board running
> mainline. Most of the peripherals (USB, SD card, ethernet) are already
> supported by upstream Cadence and Synopsys drivers. However, the vendor
> kernel used ifdef's to flush the L2 cache at several points in those
> drivers and subsystem cores because the peripherals are on a non-cache
> coherent interconnect.
>
> Without the proposed solution from Atish that uses the non-cached DDR
> alias, then only serial console would work on mainline (assuming the
> system is running from a ramdisk that the vendor uboot loaded).
>
> Thanks,
> Drew
>
> [1] https://lore.kernel.org/linux-riscv/CAOnJCU+ip1ccc9CrREi3c+15ue4Grcq+ENbQ+z_gh3CH249aAg@mail.gmail.com/T/#md422e9de172a179f8625c5bb595cf40e5942db67
