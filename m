Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEBA3407CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhCROZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 10:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhCROZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:25:10 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850EDC06174A;
        Thu, 18 Mar 2021 07:25:06 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id l79so1272403oib.1;
        Thu, 18 Mar 2021 07:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x3gm3O0zGV8d6mrkbGdIstufDDjuTEV+EDN8sx1MHFs=;
        b=uFGGOC4Ywk38a7fsMuK1d25rlsW5/SVNRmMEVbRSofSkKCpYoAXsTUGK+c7MQ4/U6C
         8UY6cdQqic8CUKPdi9K2n91vOnIC5JEQuI12KQOx2Oa7CYg47pS87oja4fKSFERHAVD5
         zO5EONSGDbeCfXVYSF2iLtlnICXpnJbGDvBj+8nuMlFeOXNKP/4mhMBp4VYLfIukY3ZZ
         G6V7bWXvj03TMheyPLxxdsG2NuyEZlfpr5z5VdhKuKA3PGhElNJkqdCCdyO8K6k5EupI
         2OetHceDyWe72SgbsvqmHdLXO56YJBetfboxUqGsPH6tHlm+ZDdvP2Hg14RdEcsQPcSR
         F4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x3gm3O0zGV8d6mrkbGdIstufDDjuTEV+EDN8sx1MHFs=;
        b=lT9XAGNKVfhb1ZvgX38xqTjBMPJBtvlt62NsyHuFvojE4FTzOkh/BEjjRW+fugZFB8
         QMPRyBO1psdqfRVGPU38PWt1Wwq/JwRXRxTK2mO0OtVgacg6WBwUWYPQHFjV5I+zbPxi
         Z3Qny9VVfDi8zy8vwhdMt2ZUF6+u49mJueIUAsXqqHlAijVNWLQBjNg7EyHv925hr1in
         Hu2LzmFVm8uhrONDa8Dan2ZpLOuU+Y6dDHnYVSaD/H1880oczANTQPFh7eWknMjt+5Z1
         oY2z25YN6uBfcPTliN8zlvk539cqTT/sZjXxI3JwAoLEbjgXR9cE0p42L6tB8WGX8wTb
         cuDg==
X-Gm-Message-State: AOAM531hOEV9FOlj556a5HUbB+6Tv0QSKZyza+8I2gGaqRWAfYo5WU6J
        yf5Pc7XqpwZUFiHB2zDsvGjzYyLxBRgUQ/FH3MY=
X-Google-Smtp-Source: ABdhPJxczSmp9JhNjJ3jMbWiFTuzUjg10FCu/S5NMdSOgtYKIeIzaQfwZ8OYrjih3HhdHbZ5ZkhHFhjjpP2iIqIh8Io=
X-Received: by 2002:a05:6808:14cf:: with SMTP id f15mr3233685oiw.39.1616077505936;
 Thu, 18 Mar 2021 07:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <1616046056-29068-1-git-send-email-rex-bc.chen@mediatek.com> <1616046056-29068-2-git-send-email-rex-bc.chen@mediatek.com>
In-Reply-To: <1616046056-29068-2-git-send-email-rex-bc.chen@mediatek.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 18 Mar 2021 15:24:54 +0100
Message-ID: <CAFqH_51qkjtRRS8yjiRXQhN7Hvn-rG34ieKxKnKmreJrOJVUow@mail.gmail.com>
Subject: Re: [v5, 1/2] drm/mediatek: mtk_dpi: Add check for max clock rate in mode_valid
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rex-BC Chen,

Thank you for your patch.

Missatge de Rex-BC Chen <rex-bc.chen@mediatek.com> del dia dj., 18 de
mar=C3=A7 2021 a les 6:42:
>
> Add per-platform max clock rate check in mtk_dpi_bridge_mode_valid.
>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index b05f900d9322..0b427ad0cd9b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -120,6 +120,7 @@ struct mtk_dpi_yc_limit {
>  struct mtk_dpi_conf {
>         unsigned int (*cal_factor)(int clock);
>         u32 reg_h_fre_con;
> +       u32 max_clock_khz;
>         bool edge_sel_en;
>  };
>
> @@ -557,9 +558,23 @@ static void mtk_dpi_bridge_enable(struct drm_bridge =
*bridge)
>         mtk_dpi_set_display_mode(dpi, &dpi->mode);
>  }
>
> +static enum drm_mode_status
> +mtk_dpi_bridge_mode_valid(struct drm_bridge *bridge,
> +                         const struct drm_display_info *info,
> +                         const struct drm_display_mode *mode)
> +{
> +       struct mtk_dpi *dpi =3D bridge_to_dpi(bridge);
> +
> +       if (dpi->conf->max_clock_khz && mode->clock > dpi->conf->max_cloc=
k_khz)

Maybe I read this patch too fast, but why the &&? Shouldn't be more
simple and readable

          if (mode->clock > max_clock)

Thanks,
  Enric


> +               return MODE_CLOCK_HIGH;
> +
> +       return MODE_OK;
> +}
> +
>  static const struct drm_bridge_funcs mtk_dpi_bridge_funcs =3D {
>         .attach =3D mtk_dpi_bridge_attach,
>         .mode_set =3D mtk_dpi_bridge_mode_set,
> +       .mode_valid =3D mtk_dpi_bridge_mode_valid,
>         .disable =3D mtk_dpi_bridge_disable,
>         .enable =3D mtk_dpi_bridge_enable,
>  };
> @@ -668,17 +683,20 @@ static unsigned int mt8183_calculate_factor(int clo=
ck)
>  static const struct mtk_dpi_conf mt8173_conf =3D {
>         .cal_factor =3D mt8173_calculate_factor,
>         .reg_h_fre_con =3D 0xe0,
> +       .max_clock_khz =3D 300000,
>  };
>
>  static const struct mtk_dpi_conf mt2701_conf =3D {
>         .cal_factor =3D mt2701_calculate_factor,
>         .reg_h_fre_con =3D 0xb0,
>         .edge_sel_en =3D true,
> +       .max_clock_khz =3D 150000,
>  };
>
>  static const struct mtk_dpi_conf mt8183_conf =3D {
>         .cal_factor =3D mt8183_calculate_factor,
>         .reg_h_fre_con =3D 0xe0,
> +       .max_clock_khz =3D 100000,
>  };
>
>  static int mtk_dpi_probe(struct platform_device *pdev)
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
