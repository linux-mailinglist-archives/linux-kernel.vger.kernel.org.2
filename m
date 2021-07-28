Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD623D8C62
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 13:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbhG1LCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 07:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhG1LBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 07:01:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB06C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 04:01:52 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l11-20020a7bc34b0000b029021f84fcaf75so3993141wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 04:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bocNcom+XM+jt/yaZntODE+ELWnSFxGY5QcrB5KsPUU=;
        b=EjbJeqOzTBHIOqmnkwnMCJkPUrOgbI1IDfEFz0L1gPOlX423R3Bt2ocdidAT+VWmPT
         Pi2Lel7fGN3o97T/7SLFfgO62PvpQElzqmVC4VVxfc90ZviBK8Y3b/znKbdkyoGwVkbY
         Acy9oYj8foz98GCWHzd0y4h+ToiiarJv0Z2h39nBAHAoPvbL68UNSEonqmvb573waTm4
         iX+1WpMTiOYXtCbdZ84DWQMpKEpnhXwhnStBidT7VjDBA4a4b73r8yFAavmn8jUAprpg
         Akkru7Qq9ywvQ3Hw4jcr5wJU+cCGnPBQ1PfAHxSvywxq5HkeHTxwvX30gf+Gc1umRfTa
         ELxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bocNcom+XM+jt/yaZntODE+ELWnSFxGY5QcrB5KsPUU=;
        b=IfwPv7jD9M6ZpEkix0+tl/OYOlHc8GegYWarm+6YTm8vvXWkOFsT6PDl0L+9W2Ser6
         RJwhKeZJMiHe5MNzZIWK2l8AYJK3GWx5H3gOBmRsVxnvxUCguowGfJsuKjCukwMSQE1q
         pLSNfBjDOEPsPw6l38PkigFiYcj0B7eYW8SbecEAh95IHBGHWsZLYrZ8Vmi1rWBy4dc7
         9drv8l8qi69qkxv1zYf/9AyWqSfM3bk5pQtHsaRFvIKqxOjXAAiz9LcpX/KxLPN6WPOV
         7g2f0oIcDDIcG9WNHQp1xnDrsYuGmIqOvjCHBfZQfu3OmKZ4Wo5o3XXKx1QOGsHxNHAq
         7W+w==
X-Gm-Message-State: AOAM530mQaW3PEKnvg6Uxk8/LgFZxn0st+6gyJyJW5GfOLbuOU9/T4dy
        FyAWNWUig5GJznqhYA8n4QOL3wWTdfX/8wDExsL+jQ==
X-Google-Smtp-Source: ABdhPJyna0vcoiKE/wYRcEVB8vIZ5PlgxSOy1HdpZLPd4BVX7GO8vBxp7RFPT0UZjP63w4uRBWo3MPTdKXzHObWSVC0=
X-Received: by 2002:a05:600c:154a:: with SMTP id f10mr26212334wmg.183.1627470110734;
 Wed, 28 Jul 2021 04:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210707093632.1468127-1-maxime@cerno.tech> <20210707093632.1468127-2-maxime@cerno.tech>
In-Reply-To: <20210707093632.1468127-2-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Wed, 28 Jul 2021 12:01:34 +0100
Message-ID: <CAPY8ntAAE+N79T7Q15URHRkGf+N6f2DKNjtyp+74AFjNdb3Prg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/vc4: hdmi: Remove unused struct
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Daniel Vetter <daniel@ffwll.ch>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Emma Anholt <emma@anholt.net>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2021 at 10:36, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Commit 91e99e113929 ("drm/vc4: hdmi: Register HDMI codec") removed the
> references to the vc4_hdmi_audio_component_drv structure, but not the
> structure itself resulting in a warning. Remove it.
>
> Fixes: 91e99e113929 ("drm/vc4: hdmi: Register HDMI codec")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 3165f39a4557..1bb06c872175 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1403,18 +1403,6 @@ static const struct snd_soc_dapm_route vc4_hdmi_audio_routes[] = {
>         { "TX", NULL, "Playback" },
>  };
>
> -static const struct snd_soc_component_driver vc4_hdmi_audio_component_drv = {
> -       .name                   = "vc4-hdmi-codec-dai-component",
> -       .dapm_widgets           = vc4_hdmi_audio_widgets,
> -       .num_dapm_widgets       = ARRAY_SIZE(vc4_hdmi_audio_widgets),
> -       .dapm_routes            = vc4_hdmi_audio_routes,
> -       .num_dapm_routes        = ARRAY_SIZE(vc4_hdmi_audio_routes),
> -       .idle_bias_on           = 1,
> -       .use_pmdown_time        = 1,
> -       .endianness             = 1,
> -       .non_legacy_dai_naming  = 1,
> -};
> -
>  static const struct snd_soc_component_driver vc4_hdmi_audio_cpu_dai_comp = {
>         .name = "vc4-hdmi-cpu-dai-component",
>  };
> --
> 2.31.1
>
