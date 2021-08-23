Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16393F4312
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 03:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhHWB3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 21:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhHWB3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 21:29:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FF0C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 18:29:02 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id n12so23670533edx.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 18:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0BtvawLEnJf8O5cokIhNT5nFsov3wP2QeJLoIv+uSf4=;
        b=K1nkmuGKqLA0aGjTbz07dhlbn7RWVJq4WBXLQX2JCuT9rsK9BTLOrAiTkDQ5oFa8H/
         uPelwFv6eEpsgr1bTGCjE70zNekrDAQgijV/ZCh2gb5REGok0hQ01OvBRHzUoielnT4m
         nW2yquEyQMPWjmFJZU4+PQt13zOW1jdrHtq2wE+dYIro1LlNEjsqQAbA+DU7L8V+mARg
         0+K+57oie//uSvJcKFvNQFJxMzIWG5erO97hOaOIBMf7WC2wZixPblkYzSFsu+fkEPX9
         /pVAw0vm1sVLHejh3r1Zf5qMfUCL5Iz6nBvY+BRhjgd7+mhqJiWg3d5nO6KIsyALlzUH
         4eZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0BtvawLEnJf8O5cokIhNT5nFsov3wP2QeJLoIv+uSf4=;
        b=f75ds/swY3xCjLwVdxVo6O8g3v2/dtGJ3htCzLh8f2xx+5u+X+siTMzaJjW+dYlS8w
         CCHqRHVm206RFp0QAcL65atfeKa1mBP30p6f5jNaTnmc5NhriSLMHnu0gaE/hL4ZXjiQ
         H7/I0ZclXMbT4upJhvYzsl5RKWjar0huOslUL/EaK4YKsScUiAsfltw1N9PV3pg+yScM
         7DcRVq7eGeLCqZ4GSpg/zRWVFTKgQ8v0hYMgWWxRGhxruq6wrO6S8/yFXO7ZlMOUev3T
         tPRtAYYDBe8rJyXqJ1FrGs2TZRobIAvZ6gp4rRbY9xLFhREgTgYJ925/XeM7yr8f0lXO
         5K3A==
X-Gm-Message-State: AOAM533tvCoRVYJ7wPktN87hL9jlQvR6/Ib9RMgYSGBNrwWMkuRosDU1
        IMnPakMn2MHVVXZcaTky9/RIdBd479zpJQ0eaEKVCg==
X-Google-Smtp-Source: ABdhPJz07adYOV4gu6aRGlpnuW6jXKZWFcHQ9cxUUHnNNMaXPpLkqLvWStXZRcuB70kgNSPxEjdlRwGkZUO+5RGMy+Y=
X-Received: by 2002:a05:6402:254b:: with SMTP id l11mr35021340edb.268.1629682141082;
 Sun, 22 Aug 2021 18:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-6-brad@pensando.io>
 <CAPDyKFpg1qJD0r54sBC3hCoFey_+gwAL1n2o-aGwnAzAan5p7w@mail.gmail.com>
In-Reply-To: <CAPDyKFpg1qJD0r54sBC3hCoFey_+gwAL1n2o-aGwnAzAan5p7w@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:28:50 -0700
Message-ID: <CAK9rFnwBGV=J+duhoFkX4Npr+fbf-EyP0UnhzMVGfJr77f=KFw@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] mmc: sdhci-cadence: Add Pensando Elba SoC support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uffe,

On Tue, Mar 30, 2021 at 3:31 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> + Masahiro Yamada (main author of the driver)
>
> On Mon, 29 Mar 2021 at 03:59, Brad Larson <brad@pensando.io> wrote:
> >
> > Add support for Pensando Elba SoC which explicitly controls
> > byte-lane enables on writes.  Refactor to allow platform
> > specific write ops.
> >
> > Signed-off-by: Brad Larson <brad@pensando.io>
> > ---
> >  drivers/mmc/host/Kconfig              |  15 +++
> >  drivers/mmc/host/Makefile             |   1 +
> >  drivers/mmc/host/sdhci-cadence-elba.c | 137 ++++++++++++++++++++++++++
>
> By looking at the amount of code changes that seem to be needed to
> support the Pensando Elba variant, I don't think it's necessary to
> split this into a separate file.
>
> Unless Yamada-san has a different opinion, I would rather just stick
> with using sdhci-cadence.c.

Yamada-san agreed with the recommendation.  This is a summary of the
changes for the updated patchset based upon all the review comments.

- Add Elba support into sdhci-cadence.c
- Removes new files sdhci-cadence-elba.c and sdhci-cadence.h.
- Remove Kconfig option MMC_SDHCI_CADENCE_ELBA
- Use the existing SDHCI_CDNS_* register defines
- Prefixed the remaining Elba SoC specific functions with elba_
- Use C Comment syntax
- The Elba specific phy init code is removed and the existing
sdhci_cdns_phy_init() is used for these Elba properties set in the DT

cdns,phy-input-delay-sd-highspeed = <0x4>;
cdns,phy-input-delay-legacy = <0x4>;
cdns,phy-input-delay-sd-uhs-sdr50 = <0x6>;
cdns,phy-input-delay-sd-uhs-ddr50 = <0x16>;

> > +config MMC_SDHCI_CADENCE_ELBA
> > +       tristate "SDHCI support for the Pensando/Cadence SD/SDIO/eMMC controller"
> > +       depends on ARCH_PENSANDO_ELBA_SOC
> > +       depends on MMC_SDHCI
> > +       depends on OF
> > +       depends on MMC_SDHCI_CADENCE
> > +       depends on MMC_SDHCI_PLTFM
> > +       select MMC_SDHCI_IO_ACCESSORS
>
> According to the comment above - then you should probably just extend
> the conditions for when building MMC_SDHCI_CADENCE, rather than having
> to add a new Kconfig for "*_ELBA".

Yes, config MMC_SDHCI_CADENCE_ELBA is removed.  Elba support is
enabled with CONFIG_MMC_SDHCI_CADENCE.

> > +// delay regs address
>
> Please don't use "//" when adding comments, but instead "/* ... */".
> This applies to several more places of the patch.
>

Only C syntax is now used for comments.

> > +static void sd4_set_dlyvr(struct sdhci_host *host,
> > +                         unsigned char addr, unsigned char data)
>
> Please, try to think of a better function name that's more
> descriptive. Moreover, please use a common prefix for functions that
> is used on elba.

The Elba specific functions such as sd4_set_dlyvr() are deleted and
the existing sdhci_cdns_phy_init() with DT properties are used for PHY
init.  The remaining Elba specific functions have the prefix elba_

> > +{
> > +       unsigned long dlyrv_reg;
> > +
> > +       dlyrv_reg = ((unsigned long)data << 8);
> > +       dlyrv_reg |= addr;
> > +
> > +       // set data and address
> > +       writel(dlyrv_reg, host->ioaddr + SDIO_REG_HRS4);
> > +       dlyrv_reg |= (1uL << 24uL);
> > +       // send write request
> > +       writel(dlyrv_reg, host->ioaddr + SDIO_REG_HRS4);
> > +       dlyrv_reg &= ~(1uL << 24);
> > +       // clear write request
> > +       writel(dlyrv_reg, host->ioaddr + SDIO_REG_HRS4);
> > +}
> > +
> > +static void phy_config(struct sdhci_host *host)
>
> Ditto.

Yes, C syntax only.  Refactored to use existing sdhci_cdns_phy_init()
and removed phy_config().

> > @@ -453,8 +444,14 @@ static const struct dev_pm_ops sdhci_cdns_pm_ops = {
> >  static const struct of_device_id sdhci_cdns_match[] = {
> >         {
> >                 .compatible = "socionext,uniphier-sd4hc",
> > -               .data = &sdhci_cdns_uniphier_pltfm_data,
> > +               .data = &sdhci_cdns_uniphier_drv_data,
> >         },
> > +#ifdef CONFIG_MMC_SDHCI_CADENCE_ELBA
>
> No need to hide this minor piece of code behind ifdefs.

No longer hidden by an ifdef, the config option
CONFIG_MMC_SDHCI_CADENCE_ELBA is gone.

> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-cadence.h
>
> This new header file can go away too, if you fold in all the code in
> the common c-file.

Exactly, the added file sdhci-cadence.h is gone.

Regards,
Brad
