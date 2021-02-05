Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7217031037E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 04:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhBEDWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 22:22:19 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:34445 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhBEDWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 22:22:17 -0500
Received: by mail-lj1-f177.google.com with SMTP id r23so4162421ljh.1;
        Thu, 04 Feb 2021 19:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3pb9e/xdQGDLFkoDNDeMMQMJFh8zeB5fbZnoZcPjiLU=;
        b=HNF4U/3jJpJEvbUXSkwVO2nVEDCVX/xjyfXt52EKcMpDrJwpr/OJ0Z6QwyrntuRf5f
         Hu8Az71hL9wKH1/rCX4Gf7xfDgjP+EkX6dmr3JxMGMXZF8c0Es5owKPd1UU28YnkNT66
         JAjXkJB/jffSh9/mxxM7g3b9t0xAEB8Aoci1u5Eewop5sX/a6cszRbNMvLLeU3zaMGOb
         m75b0g0t2ypg9wyxlDhsGaAicuUs/ZrhvC7O29pemXgTLPPAFZWb9CmOtdG7N8PpfgAb
         nkksGGZpAAtrCUs2RwU9EuprGdvqgC8Pckb7aEY7YHfbJ0SDVZB5bv/nfZujLL41vAFa
         90CQ==
X-Gm-Message-State: AOAM532vN2Ky/U0S2/liHhYaWWUZxDedIjcW6sBCrG1MixaddnnmzqoH
        JwNwlOSwA7wOAvLLOOjBh/aVRBZw4W12oQ==
X-Google-Smtp-Source: ABdhPJxIUiSXSPPUGK+SL9OT+ggBm3BU/XF3cJkBvDmI6NNBgUGx3AZDH6JB/7r3SOHEnl4yJMV/og==
X-Received: by 2002:a2e:980a:: with SMTP id a10mr1461010ljj.280.1612495294185;
        Thu, 04 Feb 2021 19:21:34 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id l9sm828446lfk.76.2021.02.04.19.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 19:21:33 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id e18so6006805lja.12;
        Thu, 04 Feb 2021 19:21:33 -0800 (PST)
X-Received: by 2002:a2e:9d04:: with SMTP id t4mr1458674lji.56.1612495293179;
 Thu, 04 Feb 2021 19:21:33 -0800 (PST)
MIME-Version: 1.0
References: <20210204184710.1880895-1-jernej.skrabec@siol.net> <20210204184710.1880895-3-jernej.skrabec@siol.net>
In-Reply-To: <20210204184710.1880895-3-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 5 Feb 2021 11:21:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v64qww4pFwMVrY5UpHOQtM43Q0VPx=3PwJGbB5Oh0qnx=w@mail.gmail.com>
Message-ID: <CAGb2v64qww4pFwMVrY5UpHOQtM43Q0VPx=3PwJGbB5Oh0qnx=w@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/sun4i: tcon: set sync polarity for tcon1 channel
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Andre Heider <a.heider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 2:48 AM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> Channel 1 has polarity bits for vsync and hsync signals but driver never
> sets them. It turns out that with pre-HDMI2 controllers seemingly there
> is no issue if polarity is not set. However, with HDMI2 controllers
> (H6) there often comes to de-synchronization due to phase shift. This
> causes flickering screen. It's safe to assume that similar issues might
> happen also with pre-HDMI2 controllers.
>
> Solve issue with setting vsync and hsync polarity. Note that display
> stacks with tcon top have polarity bits actually in tcon0 polarity
> register.
>
> Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
> Tested-by: Andre Heider <a.heider@gmail.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun4i_tcon.h |  5 +++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 6b9af4c08cd6..0d132dae58c0 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -672,6 +672,29 @@ static void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
>                      SUN4I_TCON1_BASIC5_V_SYNC(vsync) |
>                      SUN4I_TCON1_BASIC5_H_SYNC(hsync));
>
> +       /* Setup the polarity of sync signals */
> +       if (tcon->quirks->polarity_in_ch0) {
> +               val = 0;
> +
> +               if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> +                       val |= SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;
> +
> +               if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> +                       val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
> +
> +               regmap_write(tcon->regs, SUN4I_TCON0_IO_POL_REG, val);
> +       } else {
> +               val = SUN4I_TCON1_IO_POL_UNKNOWN;

I think a comment for the origin of this is warranted.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> +
> +               if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> +                       val |= SUN4I_TCON1_IO_POL_HSYNC_POSITIVE;
> +
> +               if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> +                       val |= SUN4I_TCON1_IO_POL_VSYNC_POSITIVE;
> +
> +               regmap_write(tcon->regs, SUN4I_TCON1_IO_POL_REG, val);
> +       }
> +
>         /* Map output pins to channel 1 */
>         regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
>                            SUN4I_TCON_GCTL_IOMAP_MASK,
> @@ -1500,6 +1523,7 @@ static const struct sun4i_tcon_quirks sun8i_a83t_tv_quirks = {
>
>  static const struct sun4i_tcon_quirks sun8i_r40_tv_quirks = {
>         .has_channel_1          = true,
> +       .polarity_in_ch0        = true,
>         .set_mux                = sun8i_r40_tcon_tv_set_mux,
>  };
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
> index c5ac1b02482c..b504fb2d3de5 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
> @@ -154,6 +154,10 @@
>  #define SUN4I_TCON1_BASIC5_V_SYNC(height)              (((height) - 1) & 0x3ff)
>
>  #define SUN4I_TCON1_IO_POL_REG                 0xf0
> +#define SUN4I_TCON1_IO_POL_UNKNOWN                     BIT(26)
> +#define SUN4I_TCON1_IO_POL_HSYNC_POSITIVE              BIT(25)
> +#define SUN4I_TCON1_IO_POL_VSYNC_POSITIVE              BIT(24)
> +
>  #define SUN4I_TCON1_IO_TRI_REG                 0xf4
>
>  #define SUN4I_TCON_ECC_FIFO_REG                        0xf8
> @@ -236,6 +240,7 @@ struct sun4i_tcon_quirks {
>         bool    needs_de_be_mux; /* sun6i needs mux to select backend */
>         bool    needs_edp_reset; /* a80 edp reset needed for tcon0 access */
>         bool    supports_lvds;   /* Does the TCON support an LVDS output? */
> +       bool    polarity_in_ch0; /* some tcon1 channels have polarity bits in tcon0 pol register */
>         u8      dclk_min_div;   /* minimum divider for TCON0 DCLK */
>
>         /* callback to handle tcon muxing options */
> --
> 2.30.0
>
