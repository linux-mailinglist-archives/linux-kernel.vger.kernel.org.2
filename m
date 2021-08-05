Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0EB3E1AFA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbhHESKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240942AbhHESKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:10:03 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5A7C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 11:09:47 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id a93so10518075ybi.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 11:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8HsCzGiYHCZBDfypa8N82te7eUp4Bk6shNFm27b7NU=;
        b=qp80yKWHYgvCk7Z/Cx/rUSLn80PPXquMnWUxPFG7j5q68E79Fs4N4Z8q5L0km8sqWh
         +yXPaSPw3HA9dyjXFvYqNuNhui4G+MyGHmuwIcKd2mrLQY0+UuO+IzwuQD/hs/HOvUaf
         PNb7i5anWuNHNbuuxvkfhvpYx7Z4UM4K2O4aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8HsCzGiYHCZBDfypa8N82te7eUp4Bk6shNFm27b7NU=;
        b=uO/408ZMt4sw/Z7I+3vTNLOFlziBNKPr8+LV02ZWvFNbTp7kmDqK4g5AbLHdYyT6aQ
         lXgO/4g/uAc70Vn5jzYutB1Jq5YylCBPVSXDgjquwcUOaRlNqn82Qdj2BYKiPQY+5l6I
         kTiyjxrAwEy5EZuGskSFqVdIibLZN2h6NmlnTSwZYEHBrB1dDSWgOGcv4/hJqCG22IKf
         71cS0GOYSnf8dI/y8q4b7We/lph1VdFgoqGyHjN/X5xZvc70YFjfsvVgiiK1qEz8qT5l
         7RcVb6WApI8/zdczvVTPF6PXUClMbZtY8xqYjpDCCaqVKbzep4GTytNBjTh0aHHDvXNp
         u1bQ==
X-Gm-Message-State: AOAM530btdipOdP+IeAwuYZ61Xhws94bppeFrvZzJg1LMfg6Z6WytQuS
        F8mAxlCsmUOo9Fs/rXr9LKiGknQkGw/xrS3yxriE
X-Google-Smtp-Source: ABdhPJzOJ3LNizTbKDigKKWFg+6t1R1Utwh0pqRKavYrB9YN400Yh0NfZj/2noUPVsnFCijHcD83n2PccSv8FNwPPjk=
X-Received: by 2002:a25:3bcb:: with SMTP id i194mr7335693yba.442.1628186986830;
 Thu, 05 Aug 2021 11:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAOnJCUL9uU5G1LOgfYPz9Ny77yFYaP5sgtdxG3_w=Zcsi+f96Q@mail.gmail.com>
 <mhng-c9300c9e-6877-492f-a290-7c51066d3920@palmerdabbelt-glaptop>
 <20210805023024.GA12312@x1> <CANBLGcwczBsc-mfU2t9=7No7KhHfBFHFzGy=5hdyEE+4VN8ksg@mail.gmail.com>
In-Reply-To: <CANBLGcwczBsc-mfU2t9=7No7KhHfBFHFzGy=5hdyEE+4VN8ksg@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 5 Aug 2021 11:09:36 -0700
Message-ID: <CAOnJCU+-orqjP5dND0QNh+08UhXitS=LPpg1VpnBcp=6YJU7EQ@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: riscv: add starfive jh7100 bindings
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Drew Fustini <drew@pdp7.com>, Palmer Dabbelt <palmer@dabbelt.com>,
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

On Thu, Aug 5, 2021 at 1:13 AM Emil Renner Berthing <kernel@esmil.dk> wrote:
>
> On Thu, 5 Aug 2021 at 04:30, Drew Fustini <drew@pdp7.com> wrote:
> > On Wed, Aug 04, 2021 at 02:13:47PM -0700, Palmer Dabbelt wrote:
> > > On Wed, 04 Aug 2021 13:54:16 PDT (-0700), atishp@atishpatra.org wrote:
> > > > On Wed, Aug 4, 2021 at 1:33 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > > > >
> > > > > On Thu, 15 Jul 2021 19:17:23 PDT (-0700), bmeng.cn@gmail.com wrote:
> > > > > > On Tue, Jul 13, 2021 at 2:34 PM Drew Fustini <drew@beagleboard.org> wrote:
> > > > > >>
> > > > > >> Add DT binding documentation for the StarFive JH7100 Soc [1] and the
> > > > > >> BeagleV Starlight JH7100 board [2].
> > > > > >>
> > > > > >> [1] https://github.com/starfive-tech/beaglev_doc
> > > > > >> [2] https://github.com/beagleboard/beaglev-starlight
> > > > > >>
> > > > > >> Signed-off-by: Drew Fustini <drew@beagleboard.org>
> > > > > >> ---
> > > > > >> v4 changes:
> > > > > >> - removed JH7100 SoC revision number after discussion with Geert
> > > > > >>
> > > > > >> v3 changes:
> > > > > >> - added revision number for the board and soc after question from Palmer
> > > > > >>
> > > > > >> v2 changes:
> > > > > >> - removed "items:" entry that only had "const: starfive,jh7100"
> > > > > >> - correct typo in Description:
> > > > > >>
> > > > > >> Results of running checks:
> > > > > >>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dt_binding_check \
> > > > > >>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
> > > > > >>     CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> > > > > >>     DTEX    Documentation/devicetree/bindings/riscv/starfive.example.dts
> > > > > >>     SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> > > > > >>     DTC     Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
> > > > > >>     CHECK   Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
> > > > > >>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dtbs_check \
> > > > > >>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
> > > > > >>     SYNC    include/config/auto.conf.cmd
> > > > > >>     UPD     include/config/kernel.release
> > > > > >>     SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > > > > >>     DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dtb
> > > > > >>     DTC     arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
> > > > > >>     DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
> > > > > >>     DTC     arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
> > > > > >>     CHECK   arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
> > > > > >>     CHECK   arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
> > > > > >>     CHECK   arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
> > > > > >>
> > > > > >> The dts file is from vendor repo and is being cleaned up right now in
> > > > > >> preperation for submitting to the mailing list:
> > > > > >> https://github.com/starfive-tech/linux/tree/beaglev/arch/riscv/boot/dts/starfive
> > > > > >>
> > > > > >>  .../devicetree/bindings/riscv/starfive.yaml   | 27 +++++++++++++++++++
> > > > > >>  1 file changed, 27 insertions(+)
> > > > > >>  create mode 100644 Documentation/devicetree/bindings/riscv/starfive.yaml
> > > > > >>
> > > > > >
> > > > > > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > > > >
> > > > > Thanks.  This is on for-next, as Rob suggested taking it via the RISC-V
> > > > > tree.
> > > > >
> > > > Given that beagleV starlight mass production is cancelled [1], are we
> > > > still upstreaming the support for this ?
> > >
> > > I'm not sure, but I wasn't quite sure where to have that discussion.  I
> > > figured that the boards exist so there's no reason to shoot this down, given
> > > that it's just the vendor DT list.  At a bare minimum there's out of tree
> > > support for this, so having the DT strings defined seems sane as that's a
> > > defacto interface with bootloaders.
> > >
> > > Maybe this is more of a question for Drew: I think we were all OK working
> > > through the issues with the first-run chip when there was going to be a lot
> > > of them, but with such a small number produced I'm not sure if there's going
> > > to be enough interested to take on all that effort.
> > >
> > > I'm not quite sure where we stand on support for this: at some point there
> > > were some ideas floating around as to a way to support it without major
> > > software changes (allocating into the non-caching regions).  If that pans
> > > out then I'm fine handling this, at least from the RISC-V side, but if we're
> > > going to have to go through all the ISA/SBI stuff then it's probably not
> > > worth it.  Also not sure if there are a bunch of starfive-specific drivers
> > > that would be needed to make this boot, in which case it's probably best to
> > > wait for whatever comes next.
> >
> > I think that the discontinued beta prototype could be useful as a native
> > build host for those of you that have it and don't have an Unmatched.
>
> Also according to this statement [1], they're still planning on
> producing new boards with the JH7100 (same chip as on the BeagleV
> prototype) at the end of Q3 and the JH7110 further in the future, so I
> still think it'd make sense to support those.
>
> [1]: https://www.design-reuse.com/news/50402/starfive-open-source-single-board-platform-q3-2021.html
>



> > The arch_sync_dma RFC from Atish [1] is key to the board running
> > mainline. Most of the peripherals (USB, SD card, ethernet) are already
> > supported by upstream Cadence and Synopsys drivers. However, the vendor
> > kernel used ifdef's to flush the L2 cache at several points in those
> > drivers and subsystem cores because the peripherals are on a non-cache
> > coherent interconnect.
> >
> > Without the proposed solution from Atish that uses the non-cached DDR
> > alias, then only serial console would work on mainline (assuming the
> > system is running from a ramdisk that the vendor uboot loaded).
> >

We need the clock patches as well. If there is an agreed effort to
upstream the clock patches
and other bare minimum patches, I am happy to revise the DMA patches as well.

However, I am not sure all the patches should be beagleV or
starfive/starlight given the new announcement
from StarFive. Does anybody know if they are going to mass produce the
exact same SBC (JH7100) or some variant of it ?

Maybe we should defer upstreaming until we see the new board ? We
probably don't want two different versions of upstreaming support
for the same board!

> > Thanks,
> > Drew
> >
> > [1] https://lore.kernel.org/linux-riscv/CAOnJCU+ip1ccc9CrREi3c+15ue4Grcq+ENbQ+z_gh3CH249aAg@mail.gmail.com/T/#md422e9de172a179f8625c5bb595cf40e5942db67



-- 
Regards,
Atish
