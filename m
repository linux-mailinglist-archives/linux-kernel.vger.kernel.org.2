Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31A432A141
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347586AbhCBFdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 00:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574438AbhCBDfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 22:35:51 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427DAC06178C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 19:31:05 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id n132so8405413iod.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 19:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBOxEfv6278yvseUKPxhXaovmz5fmbYaJegMD+mzGcc=;
        b=NVi1PAqo8H18cNR4mvatM4ZWDOArYfp818zLm+r4YpiXSt3pM4Dz1uIntWaLQmOFo3
         iDv9m16+fcvXUFf6J37hmwavL4scyxTBTBs4sexJb7nRoTDhRQRgdxMzi2LeyA4XRq3D
         lG9tWK88l6HDPF5o5627veKfK7x3jwuWnOCp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBOxEfv6278yvseUKPxhXaovmz5fmbYaJegMD+mzGcc=;
        b=SQ6uQTyCHyTfkvgkFc/zp15zc3f0XEnlRvscJ+xiC1BjFSAawoJ3dGimgKVTKZuGhi
         ui/qXCcxmS0CJGFIJ+mby1En/5IgAkHJ6miPC6dbhIeIxneKg1DEh7Za8m36CVMeEbZY
         rt1jJbkoacX/Heaibk0h2kN32es5nCYvI78OTKdnXELIenbFqzi1tgv83lIsfEZNVaTo
         l3S8/ZO/6Npw/0y/sy6D2Nbu2MMfT0jDVs9T+tceG7rE3o1GrhDD0wpklZgBj+1DE44x
         4NN8c+Apje4px1U3ljQwp8PlVnm/RL4WoQImBdKTQrk8n2IMvo1dR4J46rW+fsepZgtz
         trkQ==
X-Gm-Message-State: AOAM530KQgoFJ+fyvEo1dRol5zxRixTHjC39zKHW3pATNGje0DrZ0jbP
        q7LZyGB9PNbYP9jl5AmGO+0UyTsNOb+04zH8FlXVFg==
X-Google-Smtp-Source: ABdhPJzTK9I8n6u6kduFOGVuL/KvBOB/tB/VdAiM8b2HzM/XScC3ekjFe4AceZrrWZ35aljPWFT3RHxsxmUA4HLtBdE=
X-Received: by 2002:a6b:7319:: with SMTP id e25mr15613358ioh.0.1614655864631;
 Mon, 01 Mar 2021 19:31:04 -0800 (PST)
MIME-Version: 1.0
References: <20210225175000.824661-1-enric.balletbo@collabora.com> <20210225175000.824661-4-enric.balletbo@collabora.com>
In-Reply-To: <20210225175000.824661-4-enric.balletbo@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 2 Mar 2021 11:30:38 +0800
Message-ID: <CAJMQK-gT0+OC_KgBMzRzcPAZFHdNWyhzG2v2q9fX9-hc2-8oGQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] soc: mediatek: pm-domains: Add a power domain names
 for mt8167
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
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
> Add the power domains names for the mt8167 SoC.
>
> Fixes: 207f13b419a6 ("soc: mediatek: pm-domains: Add support for mt8167")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>
>  drivers/soc/mediatek/mt8167-pm-domains.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mt8167-pm-domains.h b/drivers/soc/mediatek/mt8167-pm-domains.h
> index ad0b8dfa0527..15559ddf26e4 100644
> --- a/drivers/soc/mediatek/mt8167-pm-domains.h
> +++ b/drivers/soc/mediatek/mt8167-pm-domains.h
> @@ -15,6 +15,7 @@
>
>  static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
>         [MT8167_POWER_DOMAIN_MM] = {
> +               .name = "mm",
>                 .sta_mask = PWR_STATUS_DISP,
>                 .ctl_offs = SPM_DIS_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
> @@ -26,6 +27,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT8167_POWER_DOMAIN_VDEC] = {
> +               .name = "vdec",
>                 .sta_mask = PWR_STATUS_VDEC,
>                 .ctl_offs = SPM_VDE_PWR_CON,
>                 .sram_pdn_bits = GENMASK(8, 8),
> @@ -33,6 +35,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT8167_POWER_DOMAIN_ISP] = {
> +               .name = "isp",
>                 .sta_mask = PWR_STATUS_ISP,
>                 .ctl_offs = SPM_ISP_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
> @@ -40,6 +43,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT8167_POWER_DOMAIN_MFG_ASYNC] = {
> +               .name = "mfg_async",
>                 .sta_mask = MT8167_PWR_STATUS_MFG_ASYNC,
>                 .ctl_offs = SPM_MFG_ASYNC_PWR_CON,
>                 .sram_pdn_bits = 0,
> @@ -50,18 +54,21 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
>                 },
>         },
>         [MT8167_POWER_DOMAIN_MFG_2D] = {
> +               .name = "mfg_2d",
>                 .sta_mask = MT8167_PWR_STATUS_MFG_2D,
>                 .ctl_offs = SPM_MFG_2D_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
>         },
>         [MT8167_POWER_DOMAIN_MFG] = {
> +               .name = "mfg",
>                 .sta_mask = PWR_STATUS_MFG,
>                 .ctl_offs = SPM_MFG_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
>         },
>         [MT8167_POWER_DOMAIN_CONN] = {
> +               .name = "conn",
>                 .sta_mask = PWR_STATUS_CONN,
>                 .ctl_offs = SPM_CONN_PWR_CON,
>                 .sram_pdn_bits = GENMASK(8, 8),
> --
> 2.30.0
>
