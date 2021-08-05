Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819513E1B4B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbhHES3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241302AbhHES2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:28:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D33BC06179F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 11:28:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so11630282pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YGCouswH2GHW8Pe9yNUK7G9pYNQGrUoLBPY+7PuOUPI=;
        b=XXVigsKYi2Ekgg4sTYHse/ofeYfpERaqCu3m9dcXsH/n+THel7lVyPzavfSXYdJ4sQ
         WBQ9acW8B4ZCGjZuaB/if3rcAcACxCF43psx966LrPSVE3rrXJjr7hhdTEACLlH/KDxl
         BC1hpzQxh6xcLPrj3vyAzPlu126jya2VB1B9Dn/zqSumtG9Y6FjU9XyPVYw38ehQ6pM6
         VwMGViUWcqZOx/sW2iNyQ+gJQijCIo7hg0d+mNpuFStqbTt1Z1iItm9zkaN6qwi1KulM
         VhBRGFpT6P3P6wxe9GI6Yab/v4E7fLUBlMjEHpp+MfyzATG7BuEG9Qz4nEaLwz6WlrRY
         WSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YGCouswH2GHW8Pe9yNUK7G9pYNQGrUoLBPY+7PuOUPI=;
        b=WIb63UmVgqIh9jLOegAb0ZuwhOm/dcatEKskICWDuyvSaxRWzHJoFByklUtS2LFU2Z
         XPj1Bwh9Pq+o8vGhjoekwkaaFyufK5/sax2ku2K56PvbeyMpbhkM6srKhqL4bw0qmzhl
         2wQ9YYjzA2twZVBdcyquvgYD3421D7RJsaWJsq2WRoqTu4kZ7ZX6UDldTfd4D0VftQCe
         jFndiDl2clbF6E+u62Kx9FlLIqK5hL9EHexeGXMmQUW7FTP4/85zzB/AGZ1V/oQU4DR0
         T2sK8kg8BwZUEfV+xdIDVr2uLzFWOUfeac1aqRO6ggXiQ3USba4OD5NyzDMTqgaF4OM2
         KVDQ==
X-Gm-Message-State: AOAM532gfM+VeaTJDbvxkG/UCavPdZD60MX97Zw1baW9y7aGQhOegUdO
        F+rWp6I1NeB6ycCWHqeR0nH7Bg==
X-Google-Smtp-Source: ABdhPJwhAh8lgT+1ZMJecUd5olFPxP6rXJaigXlazVzjp7zvAweU5icsVR5dL9NjXJRvm7U1xXh7aA==
X-Received: by 2002:aa7:83d0:0:b029:3c6:7261:ecb with SMTP id j16-20020aa783d00000b02903c672610ecbmr6507212pfn.61.1628188117531;
        Thu, 05 Aug 2021 11:28:37 -0700 (PDT)
Received: from x1 ([174.127.163.79])
        by smtp.gmail.com with ESMTPSA id z24sm6696956pfn.150.2021.08.05.11.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 11:28:36 -0700 (PDT)
Date:   Thu, 5 Aug 2021 11:28:35 -0700
From:   Drew Fustini <drew@pdp7.com>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Palmer Dabbelt <palmer@dabbelt.com>,
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
Subject: Re: [PATCH v4] dt-bindings: riscv: add starfive jh7100 bindings
Message-ID: <20210805182835.GA52068@x1>
References: <CAOnJCUL9uU5G1LOgfYPz9Ny77yFYaP5sgtdxG3_w=Zcsi+f96Q@mail.gmail.com>
 <mhng-c9300c9e-6877-492f-a290-7c51066d3920@palmerdabbelt-glaptop>
 <20210805023024.GA12312@x1>
 <CANBLGcwczBsc-mfU2t9=7No7KhHfBFHFzGy=5hdyEE+4VN8ksg@mail.gmail.com>
 <CAOnJCU+-orqjP5dND0QNh+08UhXitS=LPpg1VpnBcp=6YJU7EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOnJCU+-orqjP5dND0QNh+08UhXitS=LPpg1VpnBcp=6YJU7EQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 11:09:36AM -0700, Atish Patra wrote:
> On Thu, Aug 5, 2021 at 1:13 AM Emil Renner Berthing <kernel@esmil.dk> wrote:
> >
> > On Thu, 5 Aug 2021 at 04:30, Drew Fustini <drew@pdp7.com> wrote:
> > > On Wed, Aug 04, 2021 at 02:13:47PM -0700, Palmer Dabbelt wrote:
> > > > On Wed, 04 Aug 2021 13:54:16 PDT (-0700), atishp@atishpatra.org wrote:
> > > > > On Wed, Aug 4, 2021 at 1:33 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > > > > >
> > > > > > On Thu, 15 Jul 2021 19:17:23 PDT (-0700), bmeng.cn@gmail.com wrote:
> > > > > > > On Tue, Jul 13, 2021 at 2:34 PM Drew Fustini <drew@beagleboard.org> wrote:
> > > > > > >>
> > > > > > >> Add DT binding documentation for the StarFive JH7100 Soc [1] and the
> > > > > > >> BeagleV Starlight JH7100 board [2].
> > > > > > >>
> > > > > > >> [1] https://github.com/starfive-tech/beaglev_doc
> > > > > > >> [2] https://github.com/beagleboard/beaglev-starlight
> > > > > > >>
> > > > > > >> Signed-off-by: Drew Fustini <drew@beagleboard.org>
> > > > > > >> ---
> > > > > > >> v4 changes:
> > > > > > >> - removed JH7100 SoC revision number after discussion with Geert
> > > > > > >>
> > > > > > >> v3 changes:
> > > > > > >> - added revision number for the board and soc after question from Palmer
> > > > > > >>
> > > > > > >> v2 changes:
> > > > > > >> - removed "items:" entry that only had "const: starfive,jh7100"
> > > > > > >> - correct typo in Description:
> > > > > > >>
> > > > > > >> Results of running checks:
> > > > > > >>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dt_binding_check \
> > > > > > >>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
> > > > > > >>     CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> > > > > > >>     DTEX    Documentation/devicetree/bindings/riscv/starfive.example.dts
> > > > > > >>     SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> > > > > > >>     DTC     Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
> > > > > > >>     CHECK   Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
> > > > > > >>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dtbs_check \
> > > > > > >>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
> > > > > > >>     SYNC    include/config/auto.conf.cmd
> > > > > > >>     UPD     include/config/kernel.release
> > > > > > >>     SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > > > > > >>     DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dtb
> > > > > > >>     DTC     arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
> > > > > > >>     DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
> > > > > > >>     DTC     arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
> > > > > > >>     CHECK   arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
> > > > > > >>     CHECK   arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
> > > > > > >>     CHECK   arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
> > > > > > >>
> > > > > > >> The dts file is from vendor repo and is being cleaned up right now in
> > > > > > >> preperation for submitting to the mailing list:
> > > > > > >> https://github.com/starfive-tech/linux/tree/beaglev/arch/riscv/boot/dts/starfive
> > > > > > >>
> > > > > > >>  .../devicetree/bindings/riscv/starfive.yaml   | 27 +++++++++++++++++++
> > > > > > >>  1 file changed, 27 insertions(+)
> > > > > > >>  create mode 100644 Documentation/devicetree/bindings/riscv/starfive.yaml
> > > > > > >>
> > > > > > >
> > > > > > > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > >
> > > > > > Thanks.  This is on for-next, as Rob suggested taking it via the RISC-V
> > > > > > tree.
> > > > > >
> > > > > Given that beagleV starlight mass production is cancelled [1], are we
> > > > > still upstreaming the support for this ?
> > > >
> > > > I'm not sure, but I wasn't quite sure where to have that discussion.  I
> > > > figured that the boards exist so there's no reason to shoot this down, given
> > > > that it's just the vendor DT list.  At a bare minimum there's out of tree
> > > > support for this, so having the DT strings defined seems sane as that's a
> > > > defacto interface with bootloaders.
> > > >
> > > > Maybe this is more of a question for Drew: I think we were all OK working
> > > > through the issues with the first-run chip when there was going to be a lot
> > > > of them, but with such a small number produced I'm not sure if there's going
> > > > to be enough interested to take on all that effort.
> > > >
> > > > I'm not quite sure where we stand on support for this: at some point there
> > > > were some ideas floating around as to a way to support it without major
> > > > software changes (allocating into the non-caching regions).  If that pans
> > > > out then I'm fine handling this, at least from the RISC-V side, but if we're
> > > > going to have to go through all the ISA/SBI stuff then it's probably not
> > > > worth it.  Also not sure if there are a bunch of starfive-specific drivers
> > > > that would be needed to make this boot, in which case it's probably best to
> > > > wait for whatever comes next.
> > >
> > > I think that the discontinued beta prototype could be useful as a native
> > > build host for those of you that have it and don't have an Unmatched.
> >
> > Also according to this statement [1], they're still planning on
> > producing new boards with the JH7100 (same chip as on the BeagleV
> > prototype) at the end of Q3 and the JH7110 further in the future, so I
> > still think it'd make sense to support those.
> >
> > [1]: https://www.design-reuse.com/news/50402/starfive-open-source-single-board-platform-q3-2021.html
> >
> 
> 
> 
> > > The arch_sync_dma RFC from Atish [1] is key to the board running
> > > mainline. Most of the peripherals (USB, SD card, ethernet) are already
> > > supported by upstream Cadence and Synopsys drivers. However, the vendor
> > > kernel used ifdef's to flush the L2 cache at several points in those
> > > drivers and subsystem cores because the peripherals are on a non-cache
> > > coherent interconnect.
> > >
> > > Without the proposed solution from Atish that uses the non-cached DDR
> > > alias, then only serial console would work on mainline (assuming the
> > > system is running from a ramdisk that the vendor uboot loaded).
> > >
> 
> We need the clock patches as well. If there is an agreed effort to
> upstream the clock patches
> and other bare minimum patches, I am happy to revise the DMA patches as well.
> 
> However, I am not sure all the patches should be beagleV or
> starfive/starlight given the new announcement
> from StarFive. Does anybody know if they are going to mass produce the
> exact same SBC (JH7100) or some variant of it ?
> 
> Maybe we should defer upstreaming until we see the new board ? We
> probably don't want two different versions of upstreaming support
> for the same board!

The JH7100 was produced through MPW (multi-project wafer) runs and not
as a full mask set for mass production. I don't know what quantity will
exist beyond the 300 used on the beaglev starlight beta prototypes.

Thanks,
Drew
