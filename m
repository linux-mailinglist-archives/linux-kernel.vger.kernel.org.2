Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3D43608B9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 14:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhDOMDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 08:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbhDOMDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:03:36 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DA8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 05:03:13 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id z23so6248044uan.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hyWS15qqYPq25mldI8XVE5ZMH/QV/WXZP1xn4X0ooIg=;
        b=b9KeIVNWXdyk0MYvW3lH/pszngqEs0JXSiXMdVsXgHbUrSTkkuij0voFL+lQzwt9Mi
         xZ40/JOvT+MeuCT7aqKkOHmdaGeDqObgrrubuz3gXs8nzlnMEzhIfU0VSOAOWKwOwm93
         6P1zl9SA0himRSzoryGekmycd8o1NsMKI8MzQtSKPJuTPhAh1qlnkLKeds2XCe5Q8DfV
         6n2RhKImzcsIw+qvoxtOeu+re6ayH0hQRZT2jS8tvpm8X3/ek2YQDvH3WxU0iY1FiyKx
         WT3iMajBr4VJxm0IdBZtGLLkb3qTplj8y/4omnKdrXpiCQcRd6UfGxfewtjNQz/48R3d
         aAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyWS15qqYPq25mldI8XVE5ZMH/QV/WXZP1xn4X0ooIg=;
        b=Qc1IKn0kbL8U8unZwMVU7LOFk+QC77BSguL4XDJVUYZBwnMJDGRB0BN2nxNLisfywW
         4x2ll8YRLXbHj0lE0IcXDCk4QsSq8d5XtKdCn1krTS0rlaJArc4V64E63r9a+RnPIZJL
         4qwU721SQ7jNpq2HJjdiQSsp3/N59XZ3jOCdeVH80p/GmddN1NC3q0IU9euIJnwGv+3n
         S1aMcIYamdLF6BSeIQo7PcZG7zjTVwHDOE2UCeDpRdR7dOMEGmHCi8FPt1NHEOaidQ8/
         gP7dOAXf4/3nnbg60BLSsb8tb+PG3OGRvS97TYD29XFZzz6+qNSRXLcliZLxfCwEbXxc
         2ryQ==
X-Gm-Message-State: AOAM531JM3qu36gaPhMvIcccgO8+f2dRa0m4o4W3ZI3eOCg8K8XAV3ey
        J4E6nzoZFe961F28jM3fEkEY2Kc2+p+HpXKb6rXE2A==
X-Google-Smtp-Source: ABdhPJxEfJCcnwEzl4ksTx5+3ToYflHaWAwnldJV4BYXUjAxrfxhORrNDOb8TGG55HvfxkoAvUsUAwW7gVYDC7sQ2lk=
X-Received: by 2002:ab0:2c16:: with SMTP id l22mr1431867uar.100.1618488191187;
 Thu, 15 Apr 2021 05:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210415032637.5219-1-benchuanggli@gmail.com>
In-Reply-To: <20210415032637.5219-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Apr 2021 14:02:33 +0200
Message-ID: <CAPDyKFqHs6eOqq0m==R1EQBMaYhf2pVOzvxXsgEO7uMYWa=zYw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Enlarge ASPM L1 entry delay of GL975x
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeanHY.Chen@genesyslogic.com.tw,
        =?UTF-8?B?UmVuaXVzQ2hlblvpmbPlu7rlro9d?= 
        <Renius.Chen@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 at 05:23, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> GL975x enters ASPM L1 state after a short idle in default.
> Enlarge the idle period to 7.9us for improving the R/W performance.
>
> Signed-off-by: Ben Chuang <benchuanggli@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index eb1ebb67e113..592d79082f58 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -22,6 +22,10 @@
>  #define   GLI_9750_WT_EN_ON        0x1
>  #define   GLI_9750_WT_EN_OFF       0x0
>
> +#define SDHCI_GLI_9750_CFG2          0x848
> +#define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> +#define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> +
>  #define SDHCI_GLI_9750_DRIVING      0x860
>  #define   SDHCI_GLI_9750_DRIVING_1    GENMASK(11, 0)
>  #define   SDHCI_GLI_9750_DRIVING_2    GENMASK(27, 26)
> @@ -113,6 +117,10 @@
>  #define   PCI_GLI_9755_LFCLK    GENMASK(14, 12)
>  #define   PCI_GLI_9755_DMACLK   BIT(29)
>
> +#define PCI_GLI_9755_CFG2          0x48
> +#define   PCI_GLI_9755_CFG2_L1DLY    GENMASK(28, 24)
> +#define   GLI_9755_CFG2_L1DLY_VALUE  0x1F
> +
>  #define PCI_GLI_9755_PLL            0x64
>  #define   PCI_GLI_9755_PLL_LDIV       GENMASK(9, 0)
>  #define   PCI_GLI_9755_PLL_PDIV       GENMASK(14, 12)
> @@ -408,6 +416,22 @@ static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
>         sdhci_enable_clk(host, clk);
>  }
>
> +static void gl9750_hw_setting(struct sdhci_host *host)
> +{
> +       u32 value;
> +
> +       gl9750_wt_on(host);
> +
> +       value = sdhci_readl(host, SDHCI_GLI_9750_CFG2);
> +       value &= ~SDHCI_GLI_9750_CFG2_L1DLY;
> +       /* set ASPM L1 entry delay to 7.9us */
> +       value |= FIELD_PREP(SDHCI_GLI_9750_CFG2_L1DLY,
> +                           GLI_9750_CFG2_L1DLY_VALUE);
> +       sdhci_writel(host, value, SDHCI_GLI_9750_CFG2);
> +
> +       gl9750_wt_off(host);
> +}
> +
>  static void gli_pcie_enable_msi(struct sdhci_pci_slot *slot)
>  {
>         int ret;
> @@ -555,6 +579,13 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
>         value &= ~PCI_GLI_9755_SCP_DIS;
>         pci_write_config_dword(pdev, PCI_GLI_9755_SerDes, value);
>
> +       pci_read_config_dword(pdev, PCI_GLI_9755_CFG2, &value);
> +       value &= ~PCI_GLI_9755_CFG2_L1DLY;
> +       /* set ASPM L1 entry delay to 7.9us */
> +       value |= FIELD_PREP(PCI_GLI_9755_CFG2_L1DLY,
> +                           GLI_9755_CFG2_L1DLY_VALUE);
> +       pci_write_config_dword(pdev, PCI_GLI_9755_CFG2, value);
> +
>         gl9755_wt_off(pdev);
>  }
>
> @@ -562,6 +593,7 @@ static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
>  {
>         struct sdhci_host *host = slot->host;
>
> +       gl9750_hw_setting(host);
>         gli_pcie_enable_msi(slot);
>         slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
>         sdhci_enable_v4_mode(host);
> --
> 2.30.0
>
