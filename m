Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C715B44DB2D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 18:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhKKRk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 12:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhKKRk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 12:40:26 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B022C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:37:37 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g14so27162917edz.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+ZJEqbVYDhnqE4pMom/t6gw6PM/6jv0KKovGR7Ekao=;
        b=A5d1ihbiusJNh6zNPpY4lUyUdBV4oOr1xPFRGqNGiXFGbhUp1V6y9sPDVmZo4KKkSI
         zJ+E01LBDAYzUMkGtbQy4aypNpWUhc9j1LLdP1pj4K8Pc6JnOXAuhqA+Qy4iAzUHl+6X
         lEKsNz3rnXPJj/IVFAC+z8NxKWo8IIcwyfhRhoijILomQD1eSTbo7EfAhh+0Is09Zp7T
         Q+7bolKHyAgFdHBNBTsi1f0IEue1Xuv+S1eaiENOyvkakPo9Ttwlk77CMzo5n70kGUmn
         Frc5zhW0L2rD96hW4bQFK+kRe576hk0KXuF142wf9DLC40eQ8O8KMYSVlETHhBgXN5aH
         D2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+ZJEqbVYDhnqE4pMom/t6gw6PM/6jv0KKovGR7Ekao=;
        b=2Art6DVaSV7bLR/Zh2NQ2hR7zkXxGI6Yjr3CLJ4PaIU6Vjr4XktZNKKTklzFBohj4F
         EBpi2HA3I+iWwT/JmvnrZi0NIcl1NMHZ34Ktpfxa51E5zxN6HH0PcQJshfbHRLt0U7XW
         7pX6pRNjQ083bgB6QvPmlwmOgpXLf+uEoqfgj0TZWk7vGaaCBoqy3Zfx43XZ9XFPxWkK
         6w4ciS1UHq9pLQ1EdYMpkkYLlbCPAqYZxzeUvrkSIiZ4HQXnYgCRGikvjXJCln5BiVX6
         rEoQ//BQiJrBq7umlX5zqAUEJGnW46P+DSTD1ceWa2EW9vnLys62pVXJCaV6OkctNbvy
         413g==
X-Gm-Message-State: AOAM532yd3UrtWPQ8D2MAvfhs+bdp+MGm/GDkBHdhqVPqq+MdcOzBYat
        UeM9lIOIZaUDLAjw0cBgsXrhxskZby1zdcB0CYRZuA==
X-Google-Smtp-Source: ABdhPJykkUaHqnz4xMTSyp9RWx6aaMKE9pdSBsYIE3Wl93JoX8VhLzhXAHlc3HOfRJiKNBB5oov25tCdNio7+cNksBk=
X-Received: by 2002:a17:906:6a0a:: with SMTP id qw10mr11056196ejc.547.1636652254715;
 Thu, 11 Nov 2021 09:37:34 -0800 (PST)
MIME-Version: 1.0
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
 <20210715140718.8513-2-laurentiu.tudor@nxp.com> <20211111172340.fpn4pou2xwm654g5@maple.lan>
In-Reply-To: <20211111172340.fpn4pou2xwm654g5@maple.lan>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Thu, 11 Nov 2021 18:36:58 +0100
Message-ID: <CABdtJHtDbTXLPKHQiFCAVPmJ16e1TuOtyCWU9PtUMSKhWvfa-w@mail.gmail.com>
Subject: Re: [PATCH 2/8] bus: fsl-mc: handle DMA config deferral in ACPI case
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>, leoyang.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 6:23 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Hi Laurentiu
>
> On Thu, Jul 15, 2021 at 05:07:12PM +0300, laurentiu.tudor@nxp.com wrote:
> > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >
> > ACPI DMA configure API may return a defer status code, so handle it.
> > On top of this, move the MC firmware resume after the DMA setup
> > is completed to avoid crashing due to DMA setup not being done yet or
> > being deferred.
> >
> > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> I saw regressions on my Honeycomb LX2 (NXP LX2060A) when I switched to
> v5.15. It seems like it results in so many sMMU errors that the system
> cannot function correctly (it's only about a 75% chance the system will
> boot to GUI and even if it does boot successfully the system will hang
> up soon after).
>
> Bisect took me up a couple of blind alleys (mostly due to unrelated boot
> problems in v5.14-rc2) by eventually led me to this patch as the cause.
> Applying/unapplying this patch to a v5.14-rc3 tree will provoke/fix the
> problem and reverting it against v5.15 also resolves the problem.
>
> Is there some specific firmware version required for this patch to work
> correctly?
>
>
> Daniel.
>
>
> PS: Below is the revert I applied to the v5.15 kernel (after
>     a fairly simple merge conflict fix)
>
> From 4162b64e4f361a6a773e065b592dbc5493202524 Mon Sep 17 00:00:00 2001
> From: Daniel Thompson <daniel.thompson@linaro.org>
> Date: Thu, 11 Nov 2021 16:50:25 +0000
> Subject: [PATCH] Revert "bus: fsl-mc: handle DMA config deferral in ACPI case"
>
> This reverts commit d31e7fe20a2251f87adc6ecefbdaf25e6961ce74 because
> it was causing regressions on my Honeycomb LX2 (NXP LX2060A).
>
> All kernels where the problem manifests (as either a boot hang or a desktop
> hang) issue the following messages in vast number:
>
> ~~~
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm_smmu_context_fault: 1697259 callbacks suppressed
> ~~~
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 8fd4a356a86e..429bacc7de20 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -1130,6 +1130,18 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
>         }
>
>         if (mc->fsl_mc_regs) {
> +               /*
> +                * Some bootloaders pause the MC firmware before booting the
> +                * kernel so that MC will not cause faults as soon as the
> +                * SMMU probes due to the fact that there's no configuration
> +                * in place for MC.
> +                * At this point MC should have all its SMMU setup done so make
> +                * sure it is resumed.
> +                */
> +               writel(readl(mc->fsl_mc_regs + FSL_MC_GCR1) &
> +                            (~(GCR1_P1_STOP | GCR1_P2_STOP)),
> +                      mc->fsl_mc_regs + FSL_MC_GCR1);
> +
>                 if (IS_ENABLED(CONFIG_ACPI) && !dev_of_node(&pdev->dev)) {
>                         mc_stream_id = readl(mc->fsl_mc_regs + FSL_MC_FAPR);
>                         /*
> @@ -1143,25 +1155,11 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
>                         error = acpi_dma_configure_id(&pdev->dev,
>                                                       DEV_DMA_COHERENT,
>                                                       &mc_stream_id);
> -                       if (error == -EPROBE_DEFER)
> -                               return error;
>                         if (error)
>                                 dev_warn(&pdev->dev,
>                                          "failed to configure dma: %d.\n",
>                                          error);
>                 }
> -
> -               /*
> -                * Some bootloaders pause the MC firmware before booting the
> -                * kernel so that MC will not cause faults as soon as the
> -                * SMMU probes due to the fact that there's no configuration
> -                * in place for MC.
> -                * At this point MC should have all its SMMU setup done so make
> -                * sure it is resumed.
> -                */
> -               writel(readl(mc->fsl_mc_regs + FSL_MC_GCR1) &
> -                            (~(GCR1_P1_STOP | GCR1_P2_STOP)),
> -                      mc->fsl_mc_regs + FSL_MC_GCR1);
>         }
>
>         /*
> --
> 2.33.0
>

This patch was merged as a requirement for operational on board networking.
This was merged as a prerequisite to landing the patches to support MDIO and
phy initialization in general.  The correct solution for the problem
you are seeing
is the ACPI maintainers figuring out how to land the IORT RMR patchset.  Until
that is done the only workaround is setting "arm-smmu.disable_bypass=0
iommu.passthrough=1" on the kernel commandline.  The latter option is required
since 5.15 and I haven't had time or energy to figure out why.  The
proper solution
is to just land the IORT RMR patchset and let HoneyComb run with the SMMU
enabled.

-Jon
