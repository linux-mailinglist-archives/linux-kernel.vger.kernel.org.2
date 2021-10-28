Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EDA43E825
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 20:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhJ1STy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 14:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhJ1STx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:19:53 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149FBC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:17:26 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 75so7246596pga.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y52ZRB3IDHBVDpr1Rvp1n50ku5ULulUN9ndY3ROh08M=;
        b=LausdrzIB92YfAhjMC2gEOkt8PB1jfiwxKz4iNKXJncNxr+1ppga8XLrjNJCCXMICc
         7+/zREZ6mp84b+kmnHzDa93pYmr3NNau9ZDirRthuxEd5XHxGXWlz9cRldSF4YEUpdxw
         z455EcbOlJzlia16aFWzneyTV/e08EiMtEG7ARyHaI/+uB1Ew1RD0XYveYWwNT8IrA5p
         GswxaQShFDBDWEKsICjizBuKi2mUwiS1UcNHeQlG6mM2Hbz1+iIwKgOJFVRhl3HHb3gV
         8f8dGXJY2wD9Lv/E8V90uCngD2pzi4CUp1/O0o/0MBflVjGLWqb7QxMemwcb2f0MKRl2
         OZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y52ZRB3IDHBVDpr1Rvp1n50ku5ULulUN9ndY3ROh08M=;
        b=6l9Q8ufv1zBLeLkOf/jIFO+FANlcaaRPkxFHtVKgBc73wDEAr9leUt9bhi0w0qhcus
         ksmXooG16/92eulGFQiY1xD6R/YqboAxl9jEw4/ggf9zD+bDUsu0co13WDSvD8ThjufZ
         CWvjXwUvRIwXc1T2KJulYu8jYk4zBXoBeEiXjEqHAnT6Bv98I/lhfFCiuKTwIO1U9R6C
         qshx7F2lnKo562DSy7z4bRyLqeXM9FPj5JVORqwulcm2xysOc4byt6yj1WIZzAImZmbd
         NRpJb6zIPO5daJwX+w2xGno43ifZnJ7I2SXqjQwYG+sEZnifBcBb6ktnahPFCePTq87e
         RQug==
X-Gm-Message-State: AOAM53112QwT0hMVmsNM4ufTInXJpeN98+cAZQv/N/VoDXGIbz0msNob
        akkQV4LoZrx0WIfqY6NcFly25pnfAkFhM84f9/FPKQ==
X-Google-Smtp-Source: ABdhPJzkfzCDcLEPGg3GSvgYlufl7PpvlwzDAMa63BZSm4XkZ3Xu0SukFC+4+ENlNKO998PsNydhzBhDFm0VEA6ANEE=
X-Received: by 2002:a63:788e:: with SMTP id t136mr4406516pgc.432.1635445045501;
 Thu, 28 Oct 2021 11:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <1635406037-20900-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1635406037-20900-1-git-send-email-hongxing.zhu@nxp.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 28 Oct 2021 11:17:14 -0700
Message-ID: <CAJ+vNU3mmv=-19U39dKovAV1zWVPHWZxweDAvhEkW_wSQH1ikA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] add the imx8m pcie phy driver and imx8mm pcie support
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

On Thu, Oct 28, 2021 at 12:52 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> Refer to the discussion [1] when try to enable i.MX8MM PCIe support,
> one standalone PCIe PHY driver should be seperated from i.MX PCIe
> driver when enable i.MX8MM PCIe support.
>
> This patch-set adds the standalone PCIe PHY driver suport[1-5], and i.MX8MM
> PCIe support[6-8] to have whole view to review this patch-set.
>
> The PCIe works on i.MX8MM EVK board based the the blkctrl power driver
> [2] and this patch-set.
>
> [1] https://patchwork.ozlabs.org/project/linux-pci/patch/20210510141509.929120-3-l.stach@pengutronix.de/
> [2] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210910202640.980366-1-l.stach@pengutronix.de/
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
> Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  95 +++++++++++++++++++++++++++++++++
> arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi                |  55 +++++++++++++++++++
> arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |  46 +++++++++++++++-
> drivers/pci/controller/dwc/pci-imx6.c                        |  73 ++++++++++++++++++++++---
> drivers/phy/freescale/Kconfig                                |   9 ++++
> drivers/phy/freescale/Makefile                               |   1 +
> drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 234 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> include/dt-bindings/phy/phy-imx8-pcie.h                      |  14 +++++
> 9 files changed, 525 insertions(+), 8 deletions(-)
>
> [PATCH v4 1/8] dt-bindings: phy: phy-imx8-pcie: Add binding for the
> [PATCH v4 2/8] dt-bindings: phy: Add imx8 pcie phy driver support
> [PATCH v4 3/8] dt-bindings: imx6q-pcie: Add PHY phandles and name
> [PATCH v4 4/8] arm64: dts: imx8mm: Add the pcie phy support
> [PATCH v4 5/8] phy: freescale: pcie: Initialize the imx8 pcie
> [PATCH v4 6/8] arm64: dts: imx8mm: Add the pcie support
> [PATCH v4 7/8] arm64: dts: imx8mm-evk: Add the pcie support on imx8mm
> [PATCH v4 8/8] PCI: imx: Add the imx8mm pcie support

Richard,

For your v4 series:

Reviewed-By: Tim Harvey <tharvey@gateworks.com>
Tested-By: Tim Harvey <tharvey@gateworks.com>

I tested this on imx8mm-venice* boards with no CLKREQ# support as well
as an imx8mm-evk board.

Thanks again for your effort on this series!

Best regards,

Tim
