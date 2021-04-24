Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DB6369DC9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244144AbhDXAZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232742AbhDXAZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:25:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BECF61477
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 00:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619223897;
        bh=JUtYUFPq9g527zehS3r3trQprwKqTKRWX2ZmF5KthfI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AXIRmdEEXTTTcqBDHEPz1I1nmt8HMK1D2iAXTYn2nwINJpOvTJnFJxd3aPfpCjRym
         wRYr/iZ9HqdNPRslb2DKYUfnoY57wuZDG2BiCzSywUDACGi/yows4t3dKfD/8WdKN0
         TybE6+JBuZqHJwoiRRcCxbBEOmGWoFaJSJhfdSXKoWbzBwz4I+xZMUAmWXhmDEAMKr
         c9wXyBqjLUodk3/krfZdRmb0AZolokR1MTx7xSSTqfgSGqrKClzLBJVae5mQzlCSHm
         sMCdSeVFphtUA1iGX3FgJEQ/HuMwQh9gWHHRTqvY/oedqgG9bj+BUgImEEaEf6DIOL
         oJ8n9bODCW3Fw==
Received: by mail-ed1-f54.google.com with SMTP id y3so22961215eds.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:24:57 -0700 (PDT)
X-Gm-Message-State: AOAM533bMCO1o0x5v1xmWmlUlpDJZgc8r+KLMcoEiS+apTJsx8ynvmND
        3vUg6up0zFJYQIb9nlZCcbzzydJlVhmY/eaaEg==
X-Google-Smtp-Source: ABdhPJyFg/YGdVA+cnxdfhz7C/WrfEW6PAyHJGolTksIoWi6zl62XnlcHbtRzFYYVuxL2wWnJJTuCSRLpqM2wLP13MY=
X-Received: by 2002:a05:6402:8d4:: with SMTP id d20mr7402937edz.49.1619223895851;
 Fri, 23 Apr 2021 17:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210419073244.2678688-1-narmstrong@baylibre.com> <20210419073244.2678688-5-narmstrong@baylibre.com>
In-Reply-To: <20210419073244.2678688-5-narmstrong@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 24 Apr 2021 08:24:45 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-N4D2PJR0-YG3r+tLg0kcFZh8zyN=7kBNJsghpZG4nDA@mail.gmail.com>
Message-ID: <CAAOTY_-N4D2PJR0-YG3r+tLg0kcFZh8zyN=7kBNJsghpZG4nDA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] gpu/drm: mediatek: hdmi: add optional limit on
 maximal HDMI mode clock
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
> Some SoCs like the MT8167 have a hard limit on the maximal supported HDMI=
 TMDS
> clock, so add a configuration value to filter out those modes.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index 0539262e69d3..bc50d97f2553 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -149,6 +149,7 @@ struct hdmi_audio_param {
>  struct mtk_hdmi_conf {
>         bool tz_disabled;
>         bool cea_modes_only;
> +       unsigned long max_mode_clock;
>  };
>
>  struct mtk_hdmi {
> @@ -1226,6 +1227,10 @@ static int mtk_hdmi_bridge_mode_valid(struct drm_b=
ridge *bridge,
>         if (hdmi->conf->cea_modes_only && !drm_match_cea_mode(mode))
>                 return MODE_BAD;
>
> +       if (hdmi->conf->max_mode_clock &&
> +           mode->clock > hdmi->conf->max_mode_clock)
> +               return MODE_CLOCK_HIGH;
> +
>         if (mode->clock < 27000)
>                 return MODE_CLOCK_LOW;
>         if (mode->clock > 297000)
> --
> 2.25.1
>
