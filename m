Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682DA3C85E9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbhGNOUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 10:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231892AbhGNOUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:20:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DF2C61183;
        Wed, 14 Jul 2021 14:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626272239;
        bh=uppVytZe/PF+h1BO83tiAZrIINXS8zKoOHCBNTsqSWY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c8OycKEqYChbNdGae3TpdVnjXYGHoDH/LydrE0UtAwGn+Qn6FtXlptNXvrRGfAvGI
         fszb1cqhwBgsqImzOQDET8Oh3F2aRiZpWPkwscdAr2gRTuhXvS5TAcL+F+/iO9YkkC
         xDV9ArVAm/RFrPtz+pPqBt04hfw6P+uECAINATxRUBNtLSCjn2B2V90+V904nY11aL
         SCywRZeA1/BeeAoJ6PDxtbBravCJvUJ+rjEPVBOzwKvDauJRqTutg7/tRk3oLRL+xW
         JxPSohodCsxrPWio8XEGK+Fctj4xSTorsgFvcRkpGsIR9kNZ9xa0ekbzieT5nLaFbS
         470NlD4y3B25w==
Received: by mail-ej1-f42.google.com with SMTP id c17so3531286ejk.13;
        Wed, 14 Jul 2021 07:17:19 -0700 (PDT)
X-Gm-Message-State: AOAM533DLogF4jc8N8Jcdbu5GEW+vqF9VLeHSFWOmwgWmMqerGTC6gg5
        K05INsMBsjpIq9ntTTrFIHIYYBZ2j9Vx1iyTDA==
X-Google-Smtp-Source: ABdhPJwA9SvgKi1BZBMLKChGZjsra8MvN0cP1B0B+dGmuuarbv1oS9eSOo2tgjhGPq5iEj0oCI0U2kWQ9tSDY4SZZ14=
X-Received: by 2002:a17:907:5096:: with SMTP id fv22mr12203806ejc.525.1626272238042;
 Wed, 14 Jul 2021 07:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626157454.git.mchehab+huawei@kernel.org>
 <baa7e71e13953b28a11fffdcef35195099feb7fd.1626157454.git.mchehab+huawei@kernel.org>
 <20210714022649.GA1324196@robh.at.kernel.org> <20210714091435.322d68b1@coco.lan>
In-Reply-To: <20210714091435.322d68b1@coco.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 14 Jul 2021 08:17:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJehoGakG1kXs8XC_c4UHfVE9oF2M3Ww9eizCa_Jn_TDQ@mail.gmail.com>
Message-ID: <CAL_JsqJehoGakG1kXs8XC_c4UHfVE9oF2M3Ww9eizCa_Jn_TDQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] dt-bindings: phy: Add bindings for HiKey 970 PCIe PHY
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Linuxarm <linuxarm@huawei.com>,
        mauro.chehab@huawei.com, Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 1:14 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Tue, 13 Jul 2021 20:26:49 -0600
> Rob Herring <robh@kernel.org> escreveu:
>
> > On Tue, Jul 13, 2021 at 08:28:35AM +0200, Mauro Carvalho Chehab wrote:
>
> > > +  reset-gpios:
> > > +    description: PCI PERST reset GPIOs
> > > +    maxItems: 4
> >
> > Hiding the 4 ports in the phy?
>
> Rob,
>
> I'm not trying to hide anything.
>
> There are several differences with regards to how PERST# is handled between
> HiKey 960 and HiKey 970.
>
> From hardware perspective, you can see the schematics of both boards:
>
>         https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_SoC_Reference_Manual.pdf
>         https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-docs/files/hikey970-schematics.pdf
>
> The 960 PHY has the SoC directly connected to a PCIE M.2 slot
> (model 10130616) without any external bridge chipset. It uses a single
> GPIO (GPIO 089) for the PERST# signal, connected via a voltage converter
> (from 1.8V to 3.3V).
>
>         $ lspci
>         00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3660 (rev 01)
>
> The 970 PHY has an external PCI bridge chipset (PLX Technology PEX 8606).
> Besides the bridge, the hardware comes with an Ethernet PCI adapter, a
> M.2 slot and a mini-PCIe connector. Each one with its own PERST# signal,
> mapped to different GPIO pins, and each one using its own voltage
> converter.
>
>         $ lspci
>         00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
>         01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>         02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>         02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>         02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>         02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>         02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
>         06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)
>
> On other words, there are 4 GPIOs mapped to different PERST# pins in
> the hardware:
>
> - GPIO 56 is connected to the PERST# pin at PEX 8606;
> - GPIO 25 is connected to the PERST# pin at the M.2 slot;
> - GPIO 220 is connected to the PERST# pin at the PCIe mini slot;
> - GPIO 203 is connected to the PERST# pin at the Ethernet chipset.
>
> Maybe due to different electrical requirements, the hardware design
> use different GPIOs instead of feeding them altogether.
>
> Anyway, the fact is that the PHY on 970 has 4 different GPIOs that are
> need in order for the hardware to work. and this is specific to this
> particular PHY.

This hierarchy could be done on any board. It has nothing to do with the PHY.

> Now, from software perspective, the power on sequence on Hikey 960
> finishes sending PERST# signal to the M.2 slot:
>
>         static int hi3660_pcie_phy_power_on(struct phy *generic_phy)
>         {
> ...
>                 /* perst assert Endpoint */
>                 if (!gpio_request(phy->gpio_id_reset, "pcie_perst")) {
>                         usleep_range(REF_2_PERST_MIN, REF_2_PERST_MAX);
>                         ret = gpio_direction_output(phy->gpio_id_reset, 1);
>                         if (ret)
>                                 goto disable_clks;
>                         usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
>                         return 0;
>                 }
>
>         disable_clks:
>                 kirin_pcie_clk_ctrl(phy, false);
>                 return ret;
>         }
>
> The 970 PHY, however, sends PERST# signal in the middle of the power
> on sequence, as, after sending reset, it needs to wait for the hardware
> to stabilize, in order to setup an eye diagram at the PHY:
>
>         static int hi3670_pcie_phy_power_on(struct phy *generic_phy)
>         {
> ...
>                 /* perst assert Endpoints */
>                 usleep_range(21000, 23000);
>                 for (i = 0; i < phy->n_gpio_resets; i++) {
>                         ret = gpio_direction_output(phy->gpio_id_reset[i], 1);
>                         if (ret)
>                                 return ret;
>                 }
>                 usleep_range(10000, 11000);
>
>                 ret = is_pipe_clk_stable(phy);
>                 if (!ret)
>                         goto disable_clks;
>
>                 hi3670_pcie_set_eyeparam(phy);
>
>                 ret = hi3670_pcie_noc_power(phy, false);
>                 if (ret)
>                         goto disable_clks;
>
>                 return 0;
>
>         disable_clks:
>                 kirin_pcie_clk_ctrl(phy, false);
>                 return ret;
>         }
>
> IMO, it makes a lot more sense to map this on DT as part of the
> PHY and not as part of the PCIe, but no matter how it is mapped,
> this PHY still requires 4 GPIOs for PERST#.

It does not because PERST# control is part of PCIe for every other driver.

Rob
