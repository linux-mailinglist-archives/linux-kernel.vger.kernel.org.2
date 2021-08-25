Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A4B3F7249
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbhHYJuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbhHYJt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:49:58 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E60AC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:49:12 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y6so42584337lje.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5cuOQSj7FEmEiodbWnKOyd6RMZP8iRN6RZOahPYho1k=;
        b=Mfumi4T6qskHuWjVy485evQdd/k+wJYzt876fJs9sikByTDOvTsYfpWmxt3D/iamnz
         yV0RikZabpUIXqeSxzw8sBz+iYKFJy4aku+vek+krbzBhe32ZfEVcqTeNuxYaCD7hAtu
         lyUL2M2e2bWwkPcsBDUOdmjwzZCCk0WRzbGJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5cuOQSj7FEmEiodbWnKOyd6RMZP8iRN6RZOahPYho1k=;
        b=f6mPdJHukhvvYavxbrVS8xyv1Hr9GJ/0Iw+hte4N8YE2pchrYdQ/agHXkAnpi7px0/
         X8byVoj2ywEXm7Lf+VzS2eO8RwZTDwFK80tC6x8rgKkMH+p4MrW6RoPQUk9Nzkdc/dAQ
         V09432nt8npMtMdUTpF2cO665QdWhvzznrF7yclErDrrR+2iEdWxSGA0R1+Bxv2+j5H0
         54VhVB8xRD9/+0IZSdgDkTzg4WgqBGVntVKqXPghdBF6bk8C0ivFcpiZfwkGYx3gKI0J
         d9by+1JHue2+InFnMha5kH77bQMXRnluaAQIEpWY6KIyc+FkfxggkNx64QEh4KhAOdRS
         ++qQ==
X-Gm-Message-State: AOAM530BKZ+9Id+omQTidZmiVjPoFCUCpqkfD5alXAovTJyQwqplC3iU
        NsMIUfLZjE4V2FhZYM5OE7+U1zdPZ+ouIPc3GsMBLg==
X-Google-Smtp-Source: ABdhPJznl7uEULmdH6hxgqbJqNZesw+jY2fw+pcKfOxaN8esofuUiQ5BawDdvJ1OXzvZPUBtc8p26oTmI8I9zp/sGKE=
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr35406017ljc.251.1629884950515;
 Wed, 25 Aug 2021 02:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210823092353.3502-1-chun-jie.chen@mediatek.com> <20210823092353.3502-5-chun-jie.chen@mediatek.com>
In-Reply-To: <20210823092353.3502-5-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 25 Aug 2021 17:48:58 +0800
Message-ID: <CAGXv+5Fe6tCaYgn7MUY9g1niyFPx1VwNEidpy3BL0o0a9eoq=A@mail.gmail.com>
Subject: Re: [v4 4/5] soc: mediatek: pm-domains: Move power status offset to
 power domain data
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 23, 2021 at 5:25 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> MT8195 has more than 32 power domains so it needs
> two set of pwr_sta and pwr_sta2nd registers,
> so move the register offset from soc data into power domain data.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/soc/mediatek/mt8167-pm-domains.h | 16 +++++++--
>  drivers/soc/mediatek/mt8173-pm-domains.h | 22 ++++++++++--
>  drivers/soc/mediatek/mt8183-pm-domains.h | 32 +++++++++++++++--
>  drivers/soc/mediatek/mt8192-pm-domains.h | 44 ++++++++++++++++++++++--
>  drivers/soc/mediatek/mtk-pm-domains.c    |  4 +--
>  drivers/soc/mediatek/mtk-pm-domains.h    |  4 +--
>  6 files changed, 110 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mt8167-pm-domains.h b/drivers/soc/mediatek/mt8167-pm-domains.h
> index 15559ddf26e4..4d6c32759606 100644
> --- a/drivers/soc/mediatek/mt8167-pm-domains.h
> +++ b/drivers/soc/mediatek/mt8167-pm-domains.h

[...]

> @@ -69,6 +83,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
>                 .name = "mfg_async",
>                 .sta_mask = PWR_STATUS_MFG_ASYNC,
>                 .ctl_offs = SPM_MFG_ASYNC_PWR_CON,
> +               .pwr_sta_offs = SPM_PWR_STATUS,
> +               .pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = 0,
>         },

This hunk no longer applies due to

    http://git.kernel.org/matthias.bgg/c/114956518c85f4e93c298749b35b46b2e78a2ec9

ChenYu
