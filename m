Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80BA451D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244731AbhKPA3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243771AbhKPA0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 19:26:34 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6258C06BABA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 14:56:30 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b11so15661310pld.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 14:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcf3se7dyjsLzXA0To/0PfvJUa1TCjgRaGYziSCdAjQ=;
        b=b5jiTdFgq7uQFKutKbb4oOxkjB1hX3rS6pAVG5AsD1RF22dLMdJfU5YxK7/uwByX3O
         krX9FoJpM0IR6Rln6IBwaHX2lX9ovSZqYMXlGhYcTWon4/v2olTBjZ6ewjkpCyQe7EWz
         y/SsMfVsSemDG4X0hgkfA8KWXopizQmmiPDRGe1N3VrghHkDa42W0raayKdutqklgB2P
         ZnkRYAE+qtCc3Z/vobiUMbsIvi/9l63G7r4JFoOvuU0Wv8rYOEB+UDnjDhEXYoe659Su
         hjLoTepa6g2jDQhL/BwaCptocqNCFI91owYCDwjNFqdRKT7nF2RRw+puCZEZybvCXpNx
         ymbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcf3se7dyjsLzXA0To/0PfvJUa1TCjgRaGYziSCdAjQ=;
        b=5HaTnbaHJRIi8YyzYwz4nw9Mg0bQSjm6gJ2EoXnJniB5AFayIMDKBEzT0UG7Q6asvy
         yHy69x+IQaoZfttMxno15D7RZKV36IG+aT5yiPCgksw+VU37+dUcq/kK15PHIwrVOTgP
         IjPnQID12cn4ocz8dmPJbTJ8W7nyn90DcTM+g7tQmMNIaqjpgten9PfEsWP6MdwQVHH9
         kETOp2GgSEnWEovNK7G8dVQZSHblXo4vlR1ag36nKqfsnQqNSF+LckGGaG2BT4I1HSB+
         FyxvbS2bcdQ/tfplxD0SIscPM5vI6RPkLKJhpKysSUHpBScaER5giUddGIe5wloB/5Fg
         xlUQ==
X-Gm-Message-State: AOAM5310GaklxUaoVr/hq31hllg1zkl5WVrtcFXYROiiDJoLj1sHFGyW
        sOPkuNsTZrmNKoLmAMrAxVIo2Mym0d03kE2P9LWfOCGHESVxlA==
X-Google-Smtp-Source: ABdhPJxqdIqPtf9DYqUiWP7+UcNNXzPI5APnlVpOeVYFLWVT5MJPlOrodfCH2bTWwX01v8EIVQTHEhgkn7MIvJVCwCE=
X-Received: by 2002:a17:90b:1b06:: with SMTP id nu6mr2717814pjb.155.1637016990367;
 Mon, 15 Nov 2021 14:56:30 -0800 (PST)
MIME-Version: 1.0
References: <1635820355-27009-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1635820355-27009-1-git-send-email-hongxing.zhu@nxp.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 15 Nov 2021 14:56:19 -0800
Message-ID: <CAJ+vNU3r0aC8GrTQ2z5BqsCFCAXP+BWt2ntqsNy8DBd--nxdvQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Add the imx8m pcie phy driver and imx8mm pcie support
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Kishon Vijay Abraham I <kishon@ti.com>, vkoul@kernel.org,
        Rob Herring <robh@kernel.org>, galak@kernel.crashing.org,
        Shawn Guo <shawnguo@kernel.org>, linux-phy@lists.infradead.org,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 7:58 PM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> Refer to the discussion [1] when try to enable i.MX8MM PCIe support,
> one standalone PCIe PHY driver should be seperated from i.MX PCIe
> driver when enable i.MX8MM PCIe support.
>
> This patch-set adds the standalone PCIe PHY driver suport[1-5], and i.MX8MM
> PCIe support[6-8] to have whole view to review this patch-set.
>
> The PCIe works on i.MX8MM EVK board based the the blkctrl power driver
> [2] and this patch-set. And tested by Tim and Marcel on the different
> reference clock modes boards.
>
> [1] https://patchwork.ozlabs.org/project/linux-pci/patch/20210510141509.929120-3-l.stach@pengutronix.de/
> [2] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210910202640.980366-1-l.stach@pengutronix.de/
>
> Main changes v4 --> v5:
> - Set the AUX_EN always 1b'1, thus it can fix the regression introduced in v4
>   series on Marcel's board.
> - Use the lower-case letter in the devicetreee refer to Marcel's comments.
> - Since the default value of the deemphasis parameters are zero, only set
>   the deemphasis registers when the input paramters are none zero.
>
> Main changes v3 --> v4:
> - Update the yaml to fix syntax error, add maxitems and drop description of phy
> - Correct the clock name in PHY DT node.
> - Squash the EVK board relalted dts changes into one patch, and drop the
>   useless dummy clock and gpio suffix in DT nodes.
> - Add board specific de-emphasis parameters as DT properties. Thus each board
>   can specify its actual de-emphasis values.
> - Update the commit log of PHY driver.
> - Remove the useless codes from PCIe driver, since they are moved to PHY driver
> - After the discussion and verification of the CLKREQ# configurations with Tim,
>   agree to add an optional boolean property "fsl,clkreq-unsupported", indicates
>   the CLKREQ# signal is hooked or not in HW designs.
> - Add "Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>" tag, since
>   Marcel help to test the v3 patch-set.
>
> Main changes v2 --> v3:
> - Regarding Lucas' comments.
>  - to have a whole view to review the patches, send out the i.MX8MM PCIe support too.
>  - move the PHY related bits manipulations of the GPR/SRC to standalone PHY driver.
>  - split the dts changes to SOC and board DT, and use the enum instead of raw value.
>  - update the license of the dt-binding header file.
>
> Changes v1 --> v2:
> - Update the license of the dt-binding header file to make the license
>   compatible with dts files.
> - Fix the dt_binding_check errors.
>
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   6 +++
> Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  95 ++++++++++++++++++++++++++++++++
> arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi                |  55 +++++++++++++++++++
> arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |  46 +++++++++++++++-
> drivers/pci/controller/dwc/pci-imx6.c                        |  73 ++++++++++++++++++++++---
> drivers/phy/freescale/Kconfig                                |   9 ++++
> drivers/phy/freescale/Makefile                               |   1 +
> drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 237 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> include/dt-bindings/phy/phy-imx8-pcie.h                      |  14 +++++
> 9 files changed, 528 insertions(+), 8 deletions(-)
>
> [PATCH v5 1/8] dt-bindings: phy: phy-imx8-pcie: Add binding for the
> [PATCH v5 2/8] dt-bindings: phy: Add imx8 pcie phy driver support
> [PATCH v5 3/8] dt-bindings: imx6q-pcie: Add PHY phandles and name
> [PATCH v5 4/8] arm64: dts: imx8mm: Add the pcie phy support
> [PATCH v5 5/8] phy: freescale: pcie: Initialize the imx8 pcie
> [PATCH v5 6/8] arm64: dts: imx8mm: Add the pcie support
> [PATCH v5 7/8] arm64: dts: imx8mm-evk: Add the pcie support on imx8mm
> [PATCH v5 8/8] PCI: imx: Add the imx8mm pcie support

Richard,

Are you posting a v6 of this series or have we already missed the
window for 5.16?

Best regards,

Tim
