Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3240C32A140
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347583AbhCBFdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 00:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574330AbhCBDc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 22:32:57 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D0DC06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 19:30:14 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id g9so16776533ilc.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 19:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1310LhAR6MnrT/O/Yt5UUeWi1HhYafBrd4+nArNlgw=;
        b=oORDN8kwGDDkD57JEXaaNO17XicuCBiPIIlXjj85mcPUgFF4xqOAgvvAe4REOXlN7B
         pZb+ycb4Qhu45Izk0I/3QT8EkJmLYiICwNi40x/C1/rbAmbQPgNQ1LzP198fQ5yP+LQi
         JVoAfZzmhwpqc9t7J9Rp+95nQvmwVd0ZvTxm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1310LhAR6MnrT/O/Yt5UUeWi1HhYafBrd4+nArNlgw=;
        b=e9aKCjtAxnOEKuoJqE8etxAMsIsPGGdLeJiY+9QKRdwwCBopKjbvE+7+GY2bSLLMb4
         a1q/6jhxepImhj2SyLu4eehzotEUUUfesBA6k7aZU67qW30MUx8/HORf2TG5ot14U+pz
         S8REpvvuwMInKGMoCGqmd+q0Xhpdh86LZg5qLH9vdiSh3groSF8AXJkNLRQJFQ3Ye2dI
         y3KaKla341PusyDCzyvQXSW4QplQ5wMqE2/crZC7MyWm2mRUvO5tePZVo6vZbnA70Whn
         GhfUMChNfIvYAavTey2IvFIKuZnCH2+l+uVbjxBQhzEMTtV/sBqrQ/gyq9JDZF6MldE+
         1q1A==
X-Gm-Message-State: AOAM530fcVIkbSG0+MjggUKwGbnyM49bkszFQfGXgI5KXe1ObOIQd1P5
        oVNeN95IO9P49zuTJmJIRjUo3/L6LNEeS5k/2nYJaQ==
X-Google-Smtp-Source: ABdhPJx98KwGY9AJYov4lSqnUWaDs/8YnCgc9IFwmj/NEJWhQ+0qs/fvogkdIMFspPacbO2hy+ISRn6XKiL6p1Vt0F8=
X-Received: by 2002:a92:3f06:: with SMTP id m6mr15392709ila.283.1614655813987;
 Mon, 01 Mar 2021 19:30:13 -0800 (PST)
MIME-Version: 1.0
References: <20210225175000.824661-1-enric.balletbo@collabora.com> <20210225175000.824661-2-enric.balletbo@collabora.com>
In-Reply-To: <20210225175000.824661-2-enric.balletbo@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 2 Mar 2021 11:29:48 +0800
Message-ID: <CAJMQK-hheoKB-sYTvL+Wz-UEUJjQQDqShPOCKiJOVi6m=84zOQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] soc: mediatek: pm-domains: Add a power domain names
 for mt8183
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
> Add the power domains names for the mt8183 SoC. This removes the debugfs
> errors like the following:
>
>   debugfs: Directory 'power-domain' with parent 'pm_genpd' already present!
>
> Fixes: eb9fa767fbe1 ("soc: mediatek: pm-domains: Add support for mt8183")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>
>  drivers/soc/mediatek/mt8183-pm-domains.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mt8183-pm-domains.h b/drivers/soc/mediatek/mt8183-pm-domains.h
> index aa5230e6c12f..98a9940d05fb 100644
> --- a/drivers/soc/mediatek/mt8183-pm-domains.h
> +++ b/drivers/soc/mediatek/mt8183-pm-domains.h
> @@ -12,12 +12,14 @@
>
>  static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>         [MT8183_POWER_DOMAIN_AUDIO] = {
> +               .name = "audio",
>                 .sta_mask = PWR_STATUS_AUDIO,
>                 .ctl_offs = 0x0314,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
>         },
>         [MT8183_POWER_DOMAIN_CONN] = {
> +               .name = "conn",
>                 .sta_mask = PWR_STATUS_CONN,
>                 .ctl_offs = 0x032c,
>                 .sram_pdn_bits = 0,
> @@ -28,12 +30,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>                 },
>         },
>         [MT8183_POWER_DOMAIN_MFG_ASYNC] = {
> +               .name = "mfg_async",
>                 .sta_mask = PWR_STATUS_MFG_ASYNC,
>                 .ctl_offs = 0x0334,
>                 .sram_pdn_bits = 0,
>                 .sram_pdn_ack_bits = 0,
>         },
>         [MT8183_POWER_DOMAIN_MFG] = {
> +               .name = "mfg",
>                 .sta_mask = PWR_STATUS_MFG,
>                 .ctl_offs = 0x0338,
>                 .sram_pdn_bits = GENMASK(8, 8),
> @@ -41,18 +45,21 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>                 .caps = MTK_SCPD_DOMAIN_SUPPLY,
>         },
>         [MT8183_POWER_DOMAIN_MFG_CORE0] = {
> +               .name = "mfg_core0",
>                 .sta_mask = BIT(7),
>                 .ctl_offs = 0x034c,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
>         },
>         [MT8183_POWER_DOMAIN_MFG_CORE1] = {
> +               .name = "mfg_core1",
>                 .sta_mask = BIT(20),
>                 .ctl_offs = 0x0310,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
>         },
>         [MT8183_POWER_DOMAIN_MFG_2D] = {
> +               .name = "mfg_2d",
>                 .sta_mask = PWR_STATUS_MFG_2D,
>                 .ctl_offs = 0x0348,
>                 .sram_pdn_bits = GENMASK(8, 8),
> @@ -65,6 +72,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>                 },
>         },
>         [MT8183_POWER_DOMAIN_DISP] = {
> +               .name = "disp",
>                 .sta_mask = PWR_STATUS_DISP,
>                 .ctl_offs = 0x030c,
>                 .sram_pdn_bits = GENMASK(8, 8),
> @@ -83,6 +91,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>                 },
>         },
>         [MT8183_POWER_DOMAIN_CAM] = {
> +               .name = "cam",
>                 .sta_mask = BIT(25),
>                 .ctl_offs = 0x0344,
>                 .sram_pdn_bits = GENMASK(9, 8),
> @@ -105,6 +114,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>                 },
>         },
>         [MT8183_POWER_DOMAIN_ISP] = {
> +               .name = "isp",
>                 .sta_mask = PWR_STATUS_ISP,
>                 .ctl_offs = 0x0308,
>                 .sram_pdn_bits = GENMASK(9, 8),
> @@ -127,6 +137,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>                 },
>         },
>         [MT8183_POWER_DOMAIN_VDEC] = {
> +               .name = "vdec",
>                 .sta_mask = BIT(31),
>                 .ctl_offs = 0x0300,
>                 .sram_pdn_bits = GENMASK(8, 8),
> @@ -139,6 +150,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>                 },
>         },
>         [MT8183_POWER_DOMAIN_VENC] = {
> +               .name = "venc",
>                 .sta_mask = PWR_STATUS_VENC,
>                 .ctl_offs = 0x0304,
>                 .sram_pdn_bits = GENMASK(11, 8),
> @@ -151,6 +163,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>                 },
>         },
>         [MT8183_POWER_DOMAIN_VPU_TOP] = {
> +               .name = "vpu_top",
>                 .sta_mask = BIT(26),
>                 .ctl_offs = 0x0324,
>                 .sram_pdn_bits = GENMASK(8, 8),
> @@ -177,6 +190,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>                 },
>         },
>         [MT8183_POWER_DOMAIN_VPU_CORE0] = {
> +               .name = "vpu_core0",
>                 .sta_mask = BIT(27),
>                 .ctl_offs = 0x33c,
>                 .sram_pdn_bits = GENMASK(11, 8),
> @@ -194,6 +208,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>                 .caps = MTK_SCPD_SRAM_ISO,
>         },
>         [MT8183_POWER_DOMAIN_VPU_CORE1] = {
> +               .name = "vpu_core1",
>                 .sta_mask = BIT(28),
>                 .ctl_offs = 0x0340,
>                 .sram_pdn_bits = GENMASK(11, 8),
> --
> 2.30.0
>
