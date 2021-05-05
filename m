Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C13A37346A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 06:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhEEE2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 00:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhEEE2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 00:28:30 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35362C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 21:26:44 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id q136so411790qka.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 21:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MWSpjxBHV1vRQCEcIIgUFYsW0arewhxrx2qqTW/rPlY=;
        b=eG4DO5aZCjdAptZWJyANSIWrnjQfoI+YnXphlXLmQkVHW2OlYy15msNEav3uhLMHv+
         9MC/49Ilp4ZUGHTZ91k1Ztq8VXZ2uQSVkHGeyblBNhtAfJ/YyYKFdWPXBjBocTAWnRIM
         xNsyfLfBo83J+sPbjEojQCHGGi8NYXE4aDpKBLoaqOjgQDifZaLk5OyDBgE2i0d3vGh8
         SK9AnSO5usHR4SWn950rRy8EzLZraCq90VeDCdzstYUKx4Yh0W1qka2UuaQlmaLu7agB
         IvNIuhwuWm/QYlxp+BzrW6JNQs30u2smfSWsYf4m6c8GnnrGfiAFwEHjRcHArXFI6tsu
         XDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MWSpjxBHV1vRQCEcIIgUFYsW0arewhxrx2qqTW/rPlY=;
        b=llSF0NoLOFmY2WTE2KZqMk3XA8gevRoP8ZQynx+uHwmxVXAY/pPaM6DOE2PMLD0XoA
         pAVfhFmoee8U0jFTnWj75wH2WUR7X1cIZESNwOG8ONNHECB7Xs5tl3z2UmcwE+isk/TY
         m80QpzBbuPkGhI/yg8IdFgM3wK1hQwo2b+Y1uRIT096zHgDznRKp7iWMVOhKkQ0KLn78
         rzgjmxClhFP9Tv1eXk8z1wnZSdAgojeFrXDfoAed4q1gX808HhVHtkLs7yMtk6V8nnT6
         JaOPP+kdL8PycDr4Z19W1yPtHQgo01/ukIYmT8P56aXL3ky6ST/RIgqhJIgs4NB6mP3V
         3kUw==
X-Gm-Message-State: AOAM530A5XvdQCuWF8vZW2ndR1pnbFEczShVMyI8AUt0FCZpVSN1++KN
        a6mocphtLgv87qv+blV2kECu6FWIUgA/wtzv2nazgA==
X-Google-Smtp-Source: ABdhPJyyjim3sI4ReEhGXSHiHPSliwht/DIqCZWGZeFpAExlyKtWwB5fVEGkkFBLw60H7cFK5hOmWGBArsLX6P7qFAk=
X-Received: by 2002:a05:620a:29c4:: with SMTP id s4mr25568588qkp.401.1620188803215;
 Tue, 04 May 2021 21:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210504105940.100004-6-greentime.hu@sifive.com> <20210504134632.GA1088165@bjorn-Precision-5520>
In-Reply-To: <20210504134632.GA1088165@bjorn-Precision-5520>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Wed, 5 May 2021 12:26:31 +0800
Message-ID: <CAHCEehL21cFLp+JWMhKP8rAVtGunMv2fmfo6C6tbTGpgL9q2RA@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] PCI: fu740: Add SiFive FU740 PCIe host controller driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, hes@sifive.com,
        Erik Danie <erik.danie@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>, robh+dt@kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> =E6=96=BC 2021=E5=B9=B45=E6=9C=884=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:46=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, May 04, 2021 at 06:59:39PM +0800, Greentime Hu wrote:
> > From: Paul Walmsley <paul.walmsley@sifive.com>
> >
> > Add driver for the SiFive FU740 PCIe host controller.
> > This controller is based on the DesignWare PCIe core.
> >
> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > Co-developed-by: Henry Styles <hes@sifive.com>
> > Signed-off-by: Henry Styles <hes@sifive.com>
> > Co-developed-by: Erik Danie <erik.danie@sifive.com>
> > Signed-off-by: Erik Danie <erik.danie@sifive.com>
> > Co-developed-by: Greentime Hu <greentime.hu@sifive.com>
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig      |  10 +
> >  drivers/pci/controller/dwc/Makefile     |   1 +
> >  drivers/pci/controller/dwc/pcie-fu740.c | 309 ++++++++++++++++++++++++
> >  3 files changed, 320 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-fu740.c
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controlle=
r/dwc/Kconfig
> > index 22c5529e9a65..255d43b1661b 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -318,4 +318,14 @@ config PCIE_AL
> >         required only for DT-based platforms. ACPI platforms with the
> >         Annapurna Labs PCIe controller don't need to enable this.
> >
> > +config PCIE_FU740
> > +     bool "SiFive FU740 PCIe host controller"
> > +     depends on PCI_MSI_IRQ_DOMAIN
> > +     depends on SOC_SIFIVE || COMPILE_TEST
> > +     depends on GPIOLIB
>
> 1) I'm a little disappointed that I reported the build issue 6 days
>    ago when we were already in the merge window, and it's taken until
>    now to make some progress.
>
> 2) I would prefer not to depend on GPIOLIB because it reduces
>    compile-test coverage.  For example, the x86_64 defconfig does not
>    enable GPIOLIB, so one must manually enable it to even be able to
>    enable PCIE_FU740.
>
>    Many other PCI controller drivers use GPIO, but no others depend on
>    GPIOLIB, so I infer that in the !GPIOLIB case, gpio/consumer.h
>    provides the stubs required for compile testing.
>
>    We could have a conversation about whether it's better to
>    explicitly depend on GPIOLIB here, or whether building a working
>    FU740 driver implicitly depends on GPIOLIB being selected
>    elsewhere.  That implicit dependency *is* a little obscure, but I
>    think that's what other drivers currently do, and I'd like to do
>    this consistently unless there's a good reason otherwise.
>
>    Here are some examples of other drivers:
>
>    dwc/pci-dra7xx.c:
>      config PCI_DRA7XX_HOST
>        depends on SOC_DRA7XX || COMPILE_TEST
>
>      config SOC_DRA7XX
>        select ARCH_OMAP2PLUS
>
>      config ARCH_OMAP2PLUS
>        select GPIOLIB
>
>    dwc/pci-meson.c:
>      config PCI_MESON
>        # doesn't, but probably *should* depend on "ARCH_MESON || COMPILE_=
TEST"
>
>      menuconfig ARCH_MESON
>        select GPIOLIB
>
>    dwc/pcie-qcom.c:
>      config PCIE_QCOM
>        depends on OF && (ARCH_QCOM || COMPILE_TEST)
>
>      config ARCH_QCOM
>        select GPIOLIB
>
>    pcie-rockchip.c:
>      config PCIE_ROCKCHIP_HOST
>        depends on ARCH_ROCKCHIP || COMPILE_TEST
>
>      config ARCH_ROCKCHIP
>        select GPIOLIB
>
> > +     select PCIE_DW_HOST
> > +     help
> > +       Say Y here if you want PCIe controller support for the SiFive
> > +       FU740.
> > +
> >  endmenu

Hi,

Sorry for late to debug this case. I was working on other works and
just missed the email.
How about this?

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index e1b2690b6e45..66f57f2db49d 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -7,6 +7,7 @@ config SOC_SIFIVE
        select CLK_SIFIVE
        select CLK_SIFIVE_PRCI
        select SIFIVE_PLIC
+       select GPIOLIB if PCIE_FU740
        help
          This enables support for SiFive SoC platform hardware.

diff --git a/drivers/pci/controller/dwc/Kconfig
b/drivers/pci/controller/dwc/Kconfig
index 255d43b1661b..0a37d21ed64e 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -322,7 +322,6 @@ config PCIE_FU740
        bool "SiFive FU740 PCIe host controller"
        depends on PCI_MSI_IRQ_DOMAIN
        depends on SOC_SIFIVE || COMPILE_TEST
-       depends on GPIOLIB
        select PCIE_DW_HOST
        help
          Say Y here if you want PCIe controller support for the SiFive
