Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A4136890A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 00:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbhDVWe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 18:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhDVWe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 18:34:27 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED407C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 15:33:50 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id l9so3435412ilh.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 15:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcnNcy3xEzSBfglTcOYjFIN3PxQZlBAWD1DKw9DY21M=;
        b=K0kdLys4ozVg1KxW2mM79QNCe1oDKQG1Lf40Pyu7KkT5gP6tVLsF8Z92X6TTxaPiiU
         1lxo1GoQTQPK9n5ks+2otp9uE2QITAUscik37LBQRgX5ZGn3QqXWi41/LAV5tKRQAKeL
         wGjQrh8FSyP+rY5Lh8X3oeZ9cNJ7fZ9iafDhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcnNcy3xEzSBfglTcOYjFIN3PxQZlBAWD1DKw9DY21M=;
        b=Xh9k7c6J70sRpMIO7CsrD6QbH4Jcg4YB6WP6EGpkk/KwRY9/9qzDGY1Zvqf+fK5Q/D
         +7lVRwtKSfF9hY5WaKkDWgmtpU9awlcVUhFNj6+Fm8yufc1YRfO90ypDN1o/Elz4GEdV
         voPe1am0wsn4i9Z82AijI0mNqVAJH7EVcxvGlZhYJ/eNZ2sLdZQYozElQW0d66wBNIGP
         rkBJ2U9bYKGOaZmkoshLd8ePuEbFPw/4Rx8q8WI/yQXIFhtPUXqPfvQcgQiA9tn3RWJQ
         uZULGlXTrUz+5DzIY7MiKnVZlGqhSIJohMly9FewSqffrWTu7CbiUuIoZYqNX+M/Kr73
         ORqQ==
X-Gm-Message-State: AOAM532FpvDWG5f0/WSA4a3yfgn0LXvhy34VX5AF0Kxdd7ivOQI0Tqsj
        LoSoPxY3IA7HlHfuLHwwZPDdpygD3WwhaPjf+JB6
X-Google-Smtp-Source: ABdhPJwtRG38ji/buQ1uGL0nlGipaF8+BvqUnB6p4XjEXGNFBHm4wLKN7FtAIzgH/UuiZTO7zEgDCEsJjX0Y6wGBGTQ=
X-Received: by 2002:a92:1304:: with SMTP id 4mr591258ilt.126.1619130830378;
 Thu, 22 Apr 2021 15:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210303200253.1827553-1-atish.patra@wdc.com> <mhng-13c067eb-0011-408d-83f4-2950c1e791fa@palmerdabbelt-glaptop>
 <CAOnJCUKtt3LF0zh6dKAAUtbCKsYCMby5TasA59fY2hpODX3vnQ@mail.gmail.com>
In-Reply-To: <CAOnJCUKtt3LF0zh6dKAAUtbCKsYCMby5TasA59fY2hpODX3vnQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 22 Apr 2021 15:33:39 -0700
Message-ID: <CAOnJCUKvyDPO55QtPXDhCMKYBb70WpR01jM1F=ddA=pmFJo5_Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Add Microchip PolarFire Soc Support
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, Conor.Dooley@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Ivan.Griffin@microchip.com, Lewis.Hanly@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 8:26 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Mon, Mar 29, 2021 at 9:17 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > On Wed, 03 Mar 2021 12:02:48 PST (-0800), Atish Patra wrote:
> > > This series adds minimal support for Microchip Polar Fire Soc Icicle kit.
> > > It is rebased on v5.12-rc1 and depends on clock support.
> > > Only MMC and ethernet drivers are enabled via this series.
> > > The idea here is to add the foundational patches so that other drivers
> > > can be added to on top of this. The device tree may change based on
> > > feedback on bindings of individual driver support patches.
> > >
> > > This series has been tested on Qemu and Polar Fire Soc Icicle kit.
> > > It depends on the updated clock-series[2] and macb fix[3].
> > > The series is also tested by Lewis from Microchip.
> > >
> > > The series can also be found at.
> > > https://github.com/atishp04/linux/tree/polarfire_support_upstream_v4
> > >
> > > [1] https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg08582.html
> > > [2] https://www.spinics.net/lists/linux-clk/msg54579.html
> > >
> > > Changes from v3->v4:
> > > 1. Fixed few DT specific issues.
> > > 2. Rebased on top of new clock driver.
> > > 3. SD card functionality is verified.
> > >
> > > Changes from v2->v3:
> > > 1. Fixed a typo in dt binding.
> > > 2. Included MAINTAINERS entry for PolarFire SoC.
> > > 3. Improved the dts file by using lowercase clock names and keeping phy
> > >    details in board specific dts file.
> > >
> > > Changes from v1->v2:
> > > 1. Modified the DT to match the device tree in U-Boot.
> > > 2. Added both eMMC & SDcard entries in DT. However, SD card is only enabled
> > >    as it allows larger storage option for linux distros.
> > >
> > > Atish Patra (4):
> > > RISC-V: Add Microchip PolarFire SoC kconfig option
> > > dt-bindings: riscv: microchip: Add YAML documentation for the
> > > PolarFire SoC
> > > RISC-V: Initial DTS for Microchip ICICLE board
> > > RISC-V: Enable Microchip PolarFire ICICLE SoC
> > >
> > > Conor Dooley (1):
> > > MAINTAINERS: add microchip polarfire soc support
> > >
> > > .../devicetree/bindings/riscv/microchip.yaml  |  27 ++
> > > MAINTAINERS                                   |   8 +
> > > arch/riscv/Kconfig.socs                       |   7 +
> > > arch/riscv/boot/dts/Makefile                  |   1 +
> > > arch/riscv/boot/dts/microchip/Makefile        |   2 +
> > > .../microchip/microchip-mpfs-icicle-kit.dts   |  72 ++++
> > > .../boot/dts/microchip/microchip-mpfs.dtsi    | 329 ++++++++++++++++++
> > > arch/riscv/configs/defconfig                  |   4 +
> > > 8 files changed, 450 insertions(+)
> > > create mode 100644 Documentation/devicetree/bindings/riscv/microchip.yaml
> > > create mode 100644 arch/riscv/boot/dts/microchip/Makefile
> > > create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> > > create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> >
> > I had this left in my inbox waiting for either some reviews to come in or a v2,
> > but I don't see any.  Did I miss something?
> >
> Sorry for the late reply. I am on vacation until May. I think I saw
> all the patches have already been reviewed.
> Let me know if it is not the case.
>
I cross checked and all the patches are reviewed-by.
@palmer: Is it possible to take this series for 5.13 MW ?

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



-- 
Regards,
Atish
