Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138F0369DC2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbhDXAZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232501AbhDXAY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:24:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35AE461476
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 00:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619223862;
        bh=wRZ97aExQGMljYinJjx9Cgnv5qDIbGXWDbTgklJB4Mk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZjXRx4dnOx0OSXtmerXzW7K9oIl5SDba/icm4FTlwwLIz1J4ULaGYJm7moi+6tAbn
         Omiov5p8waK59kVjX689Bwg+Tv8BjnwYBq3wVr3yesUrptBWS1jLerGbO4jthOr2yF
         cmdRgvOCK4rxaGlQH6BLv4uHA/iYFO4ddgSejxbFWsK7eWAjFC3veeN634Nw+cu/9J
         AqUuWvEfgGhqaFlbM8EjcXHTLnzAjnX/Z698MCMKiYr1bLYm1o9gUK/kV6frwn9U1M
         fBt7M0HNCSrEqrAQkjWnZrPbiMEqd3uUpwbSL2qDmXyn9/xNHq+tEclTb/EcYYcNQP
         Oy0tK5kg55OuA==
Received: by mail-ej1-f47.google.com with SMTP id g5so69485219ejx.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:24:22 -0700 (PDT)
X-Gm-Message-State: AOAM5307vDvuqxP6Cp/mjKeejLCC37iMW6GXcX9EgUUeTjlD0DsYJbMQ
        B7Hvdj6rLGbrEx+/NEHWcA9abe+4ow3OpKBAfA==
X-Google-Smtp-Source: ABdhPJwQgBu332eS8r8LCjd2EB6/UqPbtWe9kyT/JTkGqbYDpWNQ9/R+U3T9w831o7oRhYXepsheJyUkpMaP6CCmw7U=
X-Received: by 2002:a17:907:9485:: with SMTP id dm5mr6893874ejc.194.1619223860799;
 Fri, 23 Apr 2021 17:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210419073244.2678688-1-narmstrong@baylibre.com> <20210419073244.2678688-4-narmstrong@baylibre.com>
In-Reply-To: <20210419073244.2678688-4-narmstrong@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 24 Apr 2021 08:24:10 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8g0voFQb22RrvMdYst7U0SZOUE+U5oab5bGJXD0nJsJQ@mail.gmail.com>
Message-ID: <CAAOTY_8g0voFQb22RrvMdYst7U0SZOUE+U5oab5bGJXD0nJsJQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] gpu/drm: mediatek: hdmi: add check for CEA modes only
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Neil:

Neil Armstrong <narmstrong@baylibre.com> =E6=96=BC 2021=E5=B9=B44=E6=9C=881=
9=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:33=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Some SoCs like the MT8167 are not validated and supported for HDMI modes
> out of HDMI CEA modes, so add a configuration boolean to filter out
> non-CEA modes.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index dea46d66e712..0539262e69d3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -148,6 +148,7 @@ struct hdmi_audio_param {
>
>  struct mtk_hdmi_conf {
>         bool tz_disabled;
> +       bool cea_modes_only;
>  };
>
>  struct mtk_hdmi {
> @@ -1222,6 +1223,9 @@ static int mtk_hdmi_bridge_mode_valid(struct drm_br=
idge *bridge,
>                         return MODE_BAD;
>         }
>
> +       if (hdmi->conf->cea_modes_only && !drm_match_cea_mode(mode))
> +               return MODE_BAD;
> +
>         if (mode->clock < 27000)
>                 return MODE_CLOCK_LOW;
>         if (mode->clock > 297000)
> --
> 2.25.1
>
