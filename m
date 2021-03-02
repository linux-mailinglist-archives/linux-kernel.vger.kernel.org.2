Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4F132A13F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347524AbhCBFdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 00:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574318AbhCBDcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 22:32:47 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEB2C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 19:29:54 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id a7so20207747iok.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 19:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/oSnREyYrWKG+GDU2KGVslzs3LByzyb9v1lKNygr+Ko=;
        b=JgGhZOXgftXhq7TXErJ6G7/K05dkAsj2JjgJ7Z2eH18cGA1VybdJtjzKhT3ileBuUg
         HbJXD6MXYmPzayWk6SjpXW6ExGatWy4Nbq4FzXqASbFngTOuIN0BzuJy8o8EaMJxu0BT
         4U/ZTA34TexqinD3bmlvBFByIAts6DM56SLcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/oSnREyYrWKG+GDU2KGVslzs3LByzyb9v1lKNygr+Ko=;
        b=nPhyHSbdvUhnvOzOAAvgBzOHAutlWykpWpfXaLuz1S9c4SkLNlkE3xmXv2DVF15yAu
         lmSj1yiGWdyDiwn22fYZWiou6VCpvmWTAuWxrObwHOMYcJr+EvtKGnz3OyKZrr1rKus8
         hiK/YSGw6buWzD1X1pzWgDHWtW3TXUaxhRLh5VZk4W1s1VV5SdhCZkXFpoZgeZX37nrj
         CkzIAeRkG0QYSaNmxfEv9n42S38vQ7L1Q9FtcYiq6Up6gX5CIN+4u2cFfSuc0fHrAMSh
         brgjVRfxEDFB9LAL7ZHSb+PU1LPvCVGrnF+dWKAd8ANJ3G/EFWE4bp+Ws7ZvxzA0EqA6
         lyag==
X-Gm-Message-State: AOAM533e+3izAwHWpctJ41U4VmK/dgqxIY/gqzIBfSw1HTyVDPbNP/DP
        CwvIm4cH6P/fsXvtr1Gcii/bO3Kaj/d9NLF6C+eEvQ==
X-Google-Smtp-Source: ABdhPJxzr57zJCc25ckeIBrGxo++RkaMAkrRqjbXM5OOdHjCr4Tm/07WtOIE1wlUN3i/7yo1ecJgqD82Qv2G31tg9lc=
X-Received: by 2002:a02:2a4a:: with SMTP id w71mr18725045jaw.43.1614655793569;
 Mon, 01 Mar 2021 19:29:53 -0800 (PST)
MIME-Version: 1.0
References: <20210225175000.824661-1-enric.balletbo@collabora.com>
In-Reply-To: <20210225175000.824661-1-enric.balletbo@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 2 Mar 2021 11:29:27 +0800
Message-ID: <CAJMQK-gcGY+i2CrUDK49_b4dNY9zbwxcMyW3E94aSz8dzV-3fg@mail.gmail.com>
Subject: Re: [PATCH 1/4] soc: mediatek: pm-domains: Add a meaningful power
 domain name
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 1:50 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Add the power domains names to the power domain struct so we
> have meaningful name for every power domain. This also removes the
> following debugfs error message.
>
>   [    2.242068] debugfs: Directory 'power-domain' with parent 'pm_genpd' already present!
>   [    2.249949] debugfs: Directory 'power-domain' with parent 'pm_genpd' already present!
>   [    2.257784] debugfs: Directory 'power-domain' with parent 'pm_genpd' already present!
>   ...
>
> Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>
>  drivers/soc/mediatek/mt8173-pm-domains.h | 10 ++++++++++
>  drivers/soc/mediatek/mtk-pm-domains.c    |  6 +++++-
>  drivers/soc/mediatek/mtk-pm-domains.h    |  2 ++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/mediatek/mt8173-pm-domains.h b/drivers/soc/mediatek/mt8173-pm-domains.h
> index 3e8ee5dabb43..654c717e5467 100644
> --- a/drivers/soc/mediatek/mt8173-pm-domains.h
> +++ b/drivers/soc/mediatek/mt8173-pm-domains.h
> @@ -12,24 +12,28 @@
>
>  static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
>         [MT8173_POWER_DOMAIN_VDEC] = {
> +               .name = "vdec",
>                 .sta_mask = PWR_STATUS_VDEC,
>                 .ctl_offs = SPM_VDE_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
>         },
>         [MT8173_POWER_DOMAIN_VENC] = {
> +               .name = "venc",
>                 .sta_mask = PWR_STATUS_VENC,
>                 .ctl_offs = SPM_VEN_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
>         },
>         [MT8173_POWER_DOMAIN_ISP] = {
> +               .name = "isp",
>                 .sta_mask = PWR_STATUS_ISP,
>                 .ctl_offs = SPM_ISP_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(13, 12),
>         },
>         [MT8173_POWER_DOMAIN_MM] = {
> +               .name = "mm",
>                 .sta_mask = PWR_STATUS_DISP,
>                 .ctl_offs = SPM_DIS_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
> @@ -40,18 +44,21 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
>                 },
>         },
>         [MT8173_POWER_DOMAIN_VENC_LT] = {
> +               .name = "venc_lt",
>                 .sta_mask = PWR_STATUS_VENC_LT,
>                 .ctl_offs = SPM_VEN2_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
>         },
>         [MT8173_POWER_DOMAIN_AUDIO] = {
> +               .name = "audio",
>                 .sta_mask = PWR_STATUS_AUDIO,
>                 .ctl_offs = SPM_AUDIO_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
>         },
>         [MT8173_POWER_DOMAIN_USB] = {
> +               .name = "usb",
>                 .sta_mask = PWR_STATUS_USB,
>                 .ctl_offs = SPM_USB_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
> @@ -59,18 +66,21 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT8173_POWER_DOMAIN_MFG_ASYNC] = {
> +               .name = "mfg_async",
>                 .sta_mask = PWR_STATUS_MFG_ASYNC,
>                 .ctl_offs = SPM_MFG_ASYNC_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = 0,
>         },
>         [MT8173_POWER_DOMAIN_MFG_2D] = {
> +               .name = "mfg_2d",
>                 .sta_mask = PWR_STATUS_MFG_2D,
>                 .ctl_offs = SPM_MFG_2D_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(13, 12),
>         },
>         [MT8173_POWER_DOMAIN_MFG] = {
> +               .name = "mfg",
>                 .sta_mask = PWR_STATUS_MFG,
>                 .ctl_offs = SPM_MFG_PWR_CON,
>                 .sram_pdn_bits = GENMASK(13, 8),
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index b7f697666bdd..694d6ea6de1d 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -438,7 +438,11 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>                 goto err_unprepare_subsys_clocks;
>         }
>
> -       pd->genpd.name = node->name;
> +       if (!pd->data->name)
> +               pd->genpd.name = node->name;
> +       else
> +               pd->genpd.name = pd->data->name;
> +
>         pd->genpd.power_off = scpsys_power_off;
>         pd->genpd.power_on = scpsys_power_on;
>
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index 141dc76054e6..21a4e113bbec 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -76,6 +76,7 @@ struct scpsys_bus_prot_data {
>
>  /**
>   * struct scpsys_domain_data - scp domain data for power on/off flow
> + * @name: The name of the power domain.
>   * @sta_mask: The mask for power on/off status bit.
>   * @ctl_offs: The offset for main power control register.
>   * @sram_pdn_bits: The mask for sram power control bits.
> @@ -85,6 +86,7 @@ struct scpsys_bus_prot_data {
>   * @bp_smi: bus protection for smi subsystem
>   */
>  struct scpsys_domain_data {
> +       const char *name;
>         u32 sta_mask;
>         int ctl_offs;
>         u32 sram_pdn_bits;
> --
> 2.30.0
>
