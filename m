Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193F63E0C75
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 04:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbhHECam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 22:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhHECal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 22:30:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17611C061765
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 19:30:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l19so5931528pjz.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 19:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vdygkbgOoifQ2P3uS173U/W4DkZaZSva1QHWbIr+JoI=;
        b=eYBCE9AHR3MLbexOdgpJeNUt8ue0DcQvnep8V2CdXekpSbK750mX5sv5aI7XlzcNmf
         ASxatPjlZ+xL8whJR888VZR30wYLyRHho8Tutpvv33YwC0VnTWYOnIs6sH+X0orilpS3
         y+FKwls2Kvsn3hBENrdbuQrGCE1AhqFVkEtqkEq4H/VF1j0U0mDsHtrFknYVZu2i/Nxe
         +8RfjhVvsQen/8b9D0D2JeI0nXqg9Ue9AfOYQ/7Yljd1REYtyY58HrNvtR2/0PU0PUul
         3gLW0emPdallHJ8f8BDhgm6gN35aQRHNKVPN3Hi8prUBgytdQuM/MZ3Xf2MVLdErReY7
         quVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vdygkbgOoifQ2P3uS173U/W4DkZaZSva1QHWbIr+JoI=;
        b=AF9MSo2PVLahxSQriIyyHIuUB90lWzhejWV27e8d2Rs2ub9hmi9J9L9mdMwHbkded+
         8YcXNk4R6jsNNxVhS13TvmIk17EQdG81u+5tBs35pX9ROYYZtvG6OcmT26eie0uelomJ
         O5gg8hfKWFlBUv4+tHt66bfG1mxtzzW4u3c1fOp2KU1QteSKwmtd5kVZuRi9VWTYsIda
         LyrYVBkP+xdPkJZNND3IxXP73vcGbOtlSb/DWr1h7j77G788/VZY9IhZzZ+bOocMWoVj
         b2q+4ja1HanVQZwNiNPDOoOMd8wvXjSLZsfXlR3Qe2q5qAPATf8hQ/Rox0/U6+/YzdFd
         kAKQ==
X-Gm-Message-State: AOAM532rfFAdkipDHTMiMCDL6q2L4PaSuFtsTGxEcZxPDD7EtEIJlDlR
        shNBm5PrkrpRl0FmS+cYf9mRHQ==
X-Google-Smtp-Source: ABdhPJySAd8vmVVvU3tqw0td5HWMMUYoY9S1Qy9OO1Zx+ygWd4e1FtwfDUEhJSRER70AzJoDJ01r5w==
X-Received: by 2002:a63:1621:: with SMTP id w33mr539976pgl.291.1628130627580;
        Wed, 04 Aug 2021 19:30:27 -0700 (PDT)
Received: from x1 ([174.127.163.79])
        by smtp.gmail.com with ESMTPSA id 22sm1918868pgn.88.2021.08.04.19.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 19:30:27 -0700 (PDT)
Date:   Wed, 4 Aug 2021 19:30:24 -0700
From:   Drew Fustini <drew@pdp7.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     atishp@atishpatra.org, drew@beagleboard.org, bmeng.cn@gmail.com,
        robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        michael.zhu@starfivetech.com, tekkamanninja@gmail.com,
        jack.zhu@starfivetech.com, leyfoon.tan@starfivetech.com,
        geert@linux-m68k.org, kernel@esmil.dk, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: riscv: add starfive jh7100 bindings
Message-ID: <20210805023024.GA12312@x1>
References: <CAOnJCUL9uU5G1LOgfYPz9Ny77yFYaP5sgtdxG3_w=Zcsi+f96Q@mail.gmail.com>
 <mhng-c9300c9e-6877-492f-a290-7c51066d3920@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-c9300c9e-6877-492f-a290-7c51066d3920@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 02:13:47PM -0700, Palmer Dabbelt wrote:
> On Wed, 04 Aug 2021 13:54:16 PDT (-0700), atishp@atishpatra.org wrote:
> > On Wed, Aug 4, 2021 at 1:33 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > > 
> > > On Thu, 15 Jul 2021 19:17:23 PDT (-0700), bmeng.cn@gmail.com wrote:
> > > > On Tue, Jul 13, 2021 at 2:34 PM Drew Fustini <drew@beagleboard.org> wrote:
> > > >>
> > > >> Add DT binding documentation for the StarFive JH7100 Soc [1] and the
> > > >> BeagleV Starlight JH7100 board [2].
> > > >>
> > > >> [1] https://github.com/starfive-tech/beaglev_doc
> > > >> [2] https://github.com/beagleboard/beaglev-starlight
> > > >>
> > > >> Signed-off-by: Drew Fustini <drew@beagleboard.org>
> > > >> ---
> > > >> v4 changes:
> > > >> - removed JH7100 SoC revision number after discussion with Geert
> > > >>
> > > >> v3 changes:
> > > >> - added revision number for the board and soc after question from Palmer
> > > >>
> > > >> v2 changes:
> > > >> - removed "items:" entry that only had "const: starfive,jh7100"
> > > >> - correct typo in Description:
> > > >>
> > > >> Results of running checks:
> > > >>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dt_binding_check \
> > > >>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
> > > >>     CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> > > >>     DTEX    Documentation/devicetree/bindings/riscv/starfive.example.dts
> > > >>     SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> > > >>     DTC     Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
> > > >>     CHECK   Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
> > > >>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dtbs_check \
> > > >>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
> > > >>     SYNC    include/config/auto.conf.cmd
> > > >>     UPD     include/config/kernel.release
> > > >>     SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > > >>     DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dtb
> > > >>     DTC     arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
> > > >>     DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
> > > >>     DTC     arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
> > > >>     CHECK   arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
> > > >>     CHECK   arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
> > > >>     CHECK   arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
> > > >>
> > > >> The dts file is from vendor repo and is being cleaned up right now in
> > > >> preperation for submitting to the mailing list:
> > > >> https://github.com/starfive-tech/linux/tree/beaglev/arch/riscv/boot/dts/starfive
> > > >>
> > > >>  .../devicetree/bindings/riscv/starfive.yaml   | 27 +++++++++++++++++++
> > > >>  1 file changed, 27 insertions(+)
> > > >>  create mode 100644 Documentation/devicetree/bindings/riscv/starfive.yaml
> > > >>
> > > >
> > > > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > > 
> > > Thanks.  This is on for-next, as Rob suggested taking it via the RISC-V
> > > tree.
> > > 
> > Given that beagleV starlight mass production is cancelled [1], are we
> > still upstreaming the support for this ?
> 
> I'm not sure, but I wasn't quite sure where to have that discussion.  I
> figured that the boards exist so there's no reason to shoot this down, given
> that it's just the vendor DT list.  At a bare minimum there's out of tree
> support for this, so having the DT strings defined seems sane as that's a
> defacto interface with bootloaders.
> 
> Maybe this is more of a question for Drew: I think we were all OK working
> through the issues with the first-run chip when there was going to be a lot
> of them, but with such a small number produced I'm not sure if there's going
> to be enough interested to take on all that effort.
> 
> I'm not quite sure where we stand on support for this: at some point there
> were some ideas floating around as to a way to support it without major
> software changes (allocating into the non-caching regions).  If that pans
> out then I'm fine handling this, at least from the RISC-V side, but if we're
> going to have to go through all the ISA/SBI stuff then it's probably not
> worth it.  Also not sure if there are a bunch of starfive-specific drivers
> that would be needed to make this boot, in which case it's probably best to
> wait for whatever comes next.

I think that the discontinued beta prototype could be useful as a native
build host for those of you that have it and don't have an Unmatched.

The arch_sync_dma RFC from Atish [1] is key to the board running
mainline. Most of the peripherals (USB, SD card, ethernet) are already
supported by upstream Cadence and Synopsys drivers. However, the vendor
kernel used ifdef's to flush the L2 cache at several points in those
drivers and subsystem cores because the peripherals are on a non-cache
coherent interconnect.

Without the proposed solution from Atish that uses the non-cached DDR
alias, then only serial console would work on mainline (assuming the 
system is running from a ramdisk that the vendor uboot loaded).

Thanks,
Drew

[1] https://lore.kernel.org/linux-riscv/CAOnJCU+ip1ccc9CrREi3c+15ue4Grcq+ENbQ+z_gh3CH249aAg@mail.gmail.com/T/#md422e9de172a179f8625c5bb595cf40e5942db67
