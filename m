Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE1232A142
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347590AbhCBFdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 00:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574439AbhCBDfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 22:35:51 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E624C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 19:30:45 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id z13so20247950iox.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 19:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmSGm0nXLfjFTCCCLeQ8emvB627JDPm5C2jL77IYa9o=;
        b=PSnZV0BTXV3W9S5Q/tI968oLIXrLBcvrR8XlxMZ5Gm6iKDCTq1F7eMDMBiNeMQXES3
         Bw9DACGzVBvAHSiusgPGtO8FmSZCUji7DrdBesYF7Q8gz1VThzMT27qIxx7Ktgj0xRZp
         7ZXWE6HN6UGRNJ7gHV1djoc2vV84YbZD7N6S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmSGm0nXLfjFTCCCLeQ8emvB627JDPm5C2jL77IYa9o=;
        b=K9ZwdWLmtznnIPWnMHWKTMMBHhDeKrBetsNk5gT7qxJGCeRj295H8M+7hHo45kmXLt
         gc9cDaodoPxp5TLgYMa3Ox2RADYZlhubvxeIyGWtgJ/MNgZItP3szBB0kmZMsQHXwswf
         lnwXbUXbDqjpkZfTNTVVVIJlBZgTirYVdFvCzELmN4DgcsnVCgTlMsp0u8bsfxFhmvp1
         7kU0P8aXvAUJ/ngxDXoNJfRhAkMCtu0O8/WPFBlvwRdNvL39H5Xr0TJOMQY9jiURC2es
         YXRUTyVIOW1ywELtWbf5dtvcE9YM7rOT4OwXAGmB96f0XxjUTckl2a2RsWM8YYZVq6Fs
         tH+Q==
X-Gm-Message-State: AOAM531YluGzOpTJa0i65IZ9FuYmGDS1+UXDrvEjtraiJt3xGneHP+6X
        nTMitI8dzth+h+EqyPwX9XD/rJ35hCK9zpnlb05gqg==
X-Google-Smtp-Source: ABdhPJxocnnKq+tbJz4i1vOu2TsIQbAwEJ+AHy0WIR800BMC4iPI+Swbk3o4wbgmrTdjmu3Acdl1+cbKbJuTpMAr1C4=
X-Received: by 2002:a5e:d61a:: with SMTP id w26mr7527304iom.40.1614655843956;
 Mon, 01 Mar 2021 19:30:43 -0800 (PST)
MIME-Version: 1.0
References: <20210225175000.824661-1-enric.balletbo@collabora.com> <20210225175000.824661-3-enric.balletbo@collabora.com>
In-Reply-To: <20210225175000.824661-3-enric.balletbo@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 2 Mar 2021 11:30:18 +0800
Message-ID: <CAJMQK-iPs8VXfRhq3Kt_sHfY4iyywh4QfkkNC0ABhHJDfjKKNA@mail.gmail.com>
Subject: Re: [PATCH 3/4] soc: mediatek: pm-domains: Add a power domain names
 for mt8192
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
> Add the power domains names for the mt8192 SoC.
>
> Fixes: a49d5e7a89d6 ("soc: mediatek: pm-domains: Add support for mt8192")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>
>  drivers/soc/mediatek/mt8192-pm-domains.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mt8192-pm-domains.h b/drivers/soc/mediatek/mt8192-pm-domains.h
> index 0fdf6dc6231f..543dda70de01 100644
> --- a/drivers/soc/mediatek/mt8192-pm-domains.h
> +++ b/drivers/soc/mediatek/mt8192-pm-domains.h
> @@ -12,6 +12,7 @@
>
>  static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
>         [MT8192_POWER_DOMAIN_AUDIO] = {
> +               .name = "audio",
>                 .sta_mask = BIT(21),
>                 .ctl_offs = 0x0354,
>                 .sram_pdn_bits = GENMASK(8, 8),
> @@ -24,6 +25,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
>                 },
>         },
>         [MT8192_POWER_DOMAIN_CONN] = {
> +               .name = "conn",
>                 .sta_mask = PWR_STATUS_CONN,
>                 .ctl_offs = 0x0304,
>                 .sram_pdn_bits = 0,
> @@ -45,12 +47,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
>                 .caps = MTK_SCPD_KEEP_DEFAULT_OFF,
>         },
>         [MT8192_POWER_DOMAIN_MFG0] = {
> +               .name = "mfg0",
>                 .sta_mask = BIT(2),
>                 .ctl_offs = 0x0308,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
>         },
>         [MT8192_POWER_DOMAIN_MFG1] = {
> +               .name = "mfg1",
>                 .sta_mask = BIT(3),
>                 .ctl_offs = 0x030c,
>                 .sram_pdn_bits = GENMASK(8, 8),
> @@ -75,36 +79,42 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
>                 },
>         },
>         [MT8192_POWER_DOMAIN_MFG2] = {
> +               .name = "mfg2",
>                 .sta_mask = BIT(4),
>                 .ctl_offs = 0x0310,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
>         },
>         [MT8192_POWER_DOMAIN_MFG3] = {
> +               .name = "mfg3",
>                 .sta_mask = BIT(5),
>                 .ctl_offs = 0x0314,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
>         },
>         [MT8192_POWER_DOMAIN_MFG4] = {
> +               .name = "mfg4",
>                 .sta_mask = BIT(6),
>                 .ctl_offs = 0x0318,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
>         },
>         [MT8192_POWER_DOMAIN_MFG5] = {
> +               .name = "mfg5",
>                 .sta_mask = BIT(7),
>                 .ctl_offs = 0x031c,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
>         },
>         [MT8192_POWER_DOMAIN_MFG6] = {
> +               .name = "mfg6",
>                 .sta_mask = BIT(8),
>                 .ctl_offs = 0x0320,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
>         },
>         [MT8192_POWER_DOMAIN_DISP] = {
> +               .name = "disp",
>                 .sta_mask = BIT(20),
>                 .ctl_offs = 0x0350,
>                 .sram_pdn_bits = GENMASK(8, 8),
> @@ -133,6 +143,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
>                 },
>         },
>         [MT8192_POWER_DOMAIN_IPE] = {
> +               .name = "ipe",
>                 .sta_mask = BIT(14),
>                 .ctl_offs = 0x0338,
>                 .sram_pdn_bits = GENMASK(8, 8),
> @@ -149,6 +160,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
>                 },
>         },
>         [MT8192_POWER_DOMAIN_ISP] = {
> +               .name = "isp",
>                 .sta_mask = BIT(12),
>                 .ctl_offs = 0x0330,
>                 .sram_pdn_bits = GENMASK(8, 8),
> @@ -165,6 +177,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
>                 },
>         },
>         [MT8192_POWER_DOMAIN_ISP2] = {
> +               .name = "isp2",
>                 .sta_mask = BIT(13),
>                 .ctl_offs = 0x0334,
>                 .sram_pdn_bits = GENMASK(8, 8),
> @@ -181,6 +194,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
>                 },
>         },
>         [MT8192_POWER_DOMAIN_MDP] = {
> +               .name = "mdp",
>                 .sta_mask = BIT(19),
>                 .ctl_offs = 0x034c,
>                 .sram_pdn_bits = GENMASK(8, 8),
> @@ -197,6 +211,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
>                 },
>         },
>         [MT8192_POWER_DOMAIN_VENC] = {
> +               .name = "venc",
>                 .sta_mask = BIT(17),
>                 .ctl_offs = 0x0344,
>                 .sram_pdn_bits = GENMASK(8, 8),
> @@ -213,6 +228,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
>                 },
>         },
>         [MT8192_POWER_DOMAIN_VDEC] = {
> +               .name = "vdec",
>                 .sta_mask = BIT(15),
>                 .ctl_offs = 0x033c,
>                 .sram_pdn_bits = GENMASK(8, 8),
> @@ -229,12 +245,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
>                 },
>         },
>         [MT8192_POWER_DOMAIN_VDEC2] = {
> +               .name = "vdec2",
>                 .sta_mask = BIT(16),
>                 .ctl_offs = 0x0340,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
>         },
>         [MT8192_POWER_DOMAIN_CAM] = {
> +               .name = "cam",
>                 .sta_mask = BIT(23),
>                 .ctl_offs = 0x035c,
>                 .sram_pdn_bits = GENMASK(8, 8),
> @@ -263,18 +281,21 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
>                 },
>         },
>         [MT8192_POWER_DOMAIN_CAM_RAWA] = {
> +               .name = "cam_rawa",
>                 .sta_mask = BIT(24),
>                 .ctl_offs = 0x0360,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
>         },
>         [MT8192_POWER_DOMAIN_CAM_RAWB] = {
> +               .name = "cam_rawb",
>                 .sta_mask = BIT(25),
>                 .ctl_offs = 0x0364,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
>         },
>         [MT8192_POWER_DOMAIN_CAM_RAWC] = {
> +               .name = "cam_rawc",
>                 .sta_mask = BIT(26),
>                 .ctl_offs = 0x0368,
>                 .sram_pdn_bits = GENMASK(8, 8),
> --
> 2.30.0
>
