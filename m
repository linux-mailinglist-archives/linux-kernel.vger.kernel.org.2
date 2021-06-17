Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC95F3AADE2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFQHpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhFQHpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:45:03 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDA6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 00:42:55 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e22so4243719pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 00:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dlhQI9LBeuWWY/YA418crEQCoirxo4ehIW0nOzSjBfg=;
        b=DJulBmuYSBO4muKdi/8Vu2KF3vGVxZhvjkz55/4WjZHKA29UUH/SnFs1qfTuoS6Uwz
         vH2+PxKJCLFFFIdmU1z2SV/hlmCdNyhSbogDeVK9badYGnI9ZaMJB1HawmbSEp2n/8Ry
         G5NaXyhPWe1Ngso956j8A7KeVG0zSoeAdLQwAGG4m/0egx5f2SBjzLjrpX8G7WxLdaqC
         3J+TZxXbO+41tuQDFFuEfikFYL2HJl3hOpQa4QqBCbyDyQWsuAcZbyPvs3ExaH4fEfMM
         8N1FWDkTjISZ7ZZXP4v+XzvIUCpY/5Ie/9y99xfD7x5rBb8cAIX1+b4NKIUGCg0DW1kw
         h+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dlhQI9LBeuWWY/YA418crEQCoirxo4ehIW0nOzSjBfg=;
        b=OtjvB0pKvk3/GV2TNwq2/wOGyI43l31BDgvfCdCyGILVj6XP+qYPJvsFbyWai0Fb3C
         dw28CCmTsC5NVvnGy07U84lCdb0vEGv1eeA7NP8rsIo4W7mCo9eMAi/ZeIo0QjiH5Xqz
         hKk5YXa1gGBrQhF+Lar4H/mJi5EU59Vbd2FClAYMa7qS5rvYM4hCRp9g1PFZtLplSZAH
         qMOeDI91HNHscyJracEhF/IbSEGINv78iS/o3bZ0DDwwjbNTzAwoAaKtWU9UL9VTcIA9
         zGmoro3FYF/wD6csIjhPBI2ilvmGuxsGCpXeh/nxJIgZfXvXeJwSJMOZB2oQ37GemplD
         eX8g==
X-Gm-Message-State: AOAM531uFllFGZFOSHt/uuvl4FvvJVrCndQTnKKsShFbM7/82n5anw9e
        EiJmZgmF01j6RS78YUP6doKKMSaVwzf4lMcNRw==
X-Google-Smtp-Source: ABdhPJzFltPZJW+CLlqPO3ZDNVm8FYuMgndfCGkTH+NIbNsyzO3D2zxHKHJ6V972BF7TsmpoZxJ49mG+/NuxsZWcpdU=
X-Received: by 2002:a63:dc4e:: with SMTP id f14mr3735400pgj.378.1623915775013;
 Thu, 17 Jun 2021 00:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210615130326.2044-1-fengzheng923@gmail.com> <20210615132207.GG5149@sirena.org.uk>
In-Reply-To: <20210615132207.GG5149@sirena.org.uk>
From:   =?UTF-8?B?54+t5rab?= <fengzheng923@gmail.com>
Date:   Thu, 17 Jun 2021 15:42:43 +0800
Message-ID: <CAE=m61-kHPeKNvEEc08w8DeUwssGPWNf5UaYojRPNZRJ0v=arw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: sunxi: Add Allwinner H6 Digital MIC driver
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mripard@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        p.zabel@pengutronix.de, Samuel Holland <samuel@sholland.org>,
        krzk@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mark Brown <broonie@kernel.org> =E4=BA=8E2021=E5=B9=B46=E6=9C=8815=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 15, 2021 at 09:03:26PM +0800, Ban Tao wrote:
>
> Other than a few small things this looks good:
>
> > +M:   Ban Tao <fengzheng923@gmail.com>
> > +L:   alsa-devel@alsa-project.org (moderated for non-subscribers)
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.=
yaml
> > +F:   sound/soc/sunxi/sun50i-dmic.c
>
> Not the binding document?
>
> > @@ -0,0 +1,408 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * ALSA SoC DMIC Audio Layer
> > + *
> > + * Copyright 2021 Ban Tao <fengzheng923@gmail.com>
> > + *
>
> Please make the entire comment a C++ one so things look more
> intentional.
>
For example;
// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * This driver supports the DMIC in Allwinner's H6 SoCs.
 *
 * Copyright 2021 Ban Tao <fengzheng923@gmail.com>
 *
 */
is this OK?


> > +static void sun50i_snd_rxctrl_enable(struct snd_pcm_substream *substre=
am,
> > +                                 struct sun50i_dmic_dev *host, bool en=
able)
> > +{
> > +     if (enable) {
>
> > +     } else {
>
> > +static int sun50i_dmic_trigger(struct snd_pcm_substream *substream, in=
t cmd,
> > +                            struct snd_soc_dai *dai)
> > +{
> > +     int ret =3D 0;
> > +     struct sun50i_dmic_dev *host =3D snd_soc_dai_get_drvdata(dai);
> > +
> > +     if (substream->stream !=3D SNDRV_PCM_STREAM_CAPTURE)
> > +             return -EINVAL;
> > +
> > +     switch (cmd) {
> > +     case SNDRV_PCM_TRIGGER_START:
> > +     case SNDRV_PCM_TRIGGER_RESUME:
> > +     case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > +             sun50i_snd_rxctrl_enable(substream, host, true);
> > +             break;
> > +
> > +     case SNDRV_PCM_TRIGGER_STOP:
> > +     case SNDRV_PCM_TRIGGER_SUSPEND:
> > +     case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> > +             sun50i_snd_rxctrl_enable(substream, host, false);
> > +             break;
>
> This is the only caller of _rxctrl_enable() and _rxctrl_enable() shares
> no code between the two cases - just inline _rxctrl_enable() here, it's
> clearer what's going on.
>
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     base =3D devm_ioremap_resource(&pdev->dev, res);
>
> devm_platform_ioremap_resource()

But I need to get the register base address of DMIC. E.g res->start.
host->dma_params_rx.addr =3D res->start + SUN50I_DMIC_DATA;
