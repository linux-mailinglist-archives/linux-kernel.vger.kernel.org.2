Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26367406D00
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 15:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhIJNll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 09:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhIJNlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 09:41:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94703C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 06:40:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so1078607wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YKwtRtKNyEyFl+XAEvxUUNMg7xrC4MkTfnM9O1k3TxQ=;
        b=jH27HIhR8WhZDVXGOYs9KRNebu2udlkPRXFZcpL9BbD7ozinsJxt0p1lKjSYaxIVK8
         3bY6gvm1SOJHdIH0+CPG72bgvTJiSaVI283VDLUr1pB5joB90k9WoHG3bsLxl0yvtN4Q
         nrPrejbPCqVCi0Q36dnEdVsz0BmxajGkiN0PQ6BDvYNiNRZNn1ms5HMYMUmgCZgjGuGL
         p7PbIscEPCanXrEvq/a5f6MUy9fdZC6dzTpGZBjg7Fc6Zuk8dFLiGGhein1CXJQlyOZN
         XOd7uMgaFKmrQwn7/2mx9UgUlmtIqtnVi1sysDCXj08ADAkDrNXA9ajBwcg/UR9rixvH
         mi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YKwtRtKNyEyFl+XAEvxUUNMg7xrC4MkTfnM9O1k3TxQ=;
        b=LEWukAcbMwRSTa7n+RXm9IxW16yRYVNxW9IqsIpxxb+Lq5p/SyL1UDXFDhMFzgGBM7
         3R49Xt6Ss22XtucQenExpCC3qQMsvcTN1fPkdpwBj3Ug6Q0ub/Hd2ITH0u5fjatb/yR+
         GlwrjpebYvQ8RlPppq34ZeFzHyQfHmPid9x1E9tEYISLrvZg2cVqQxog+FrNaKeozNio
         B37qatLpB6Y8Y691nCm+aTv7GIoFim2fjhPi4ak1lrFoJkpIfX7ir0TW/DKq9SpSolvs
         DqXN7UM9xxt11qvXl2Atzg7Spr7TDBtko1M/S4oWkw2dUsEL9u2+r7heg0tBuUkEcyHr
         jhiA==
X-Gm-Message-State: AOAM532CP5mUWzya39corMkuGm7fjWrbgDYNJjMRBetddFeCaAFne2XE
        GY6IC9lYjqk1A7bz5DVadpxoRc7yn+QIWhdfOzIWkw==
X-Google-Smtp-Source: ABdhPJw7NGEmYtNIhEfy2wqXmK5HfyPQZXZ26xfT+WnZ4GispoLQzC0KdaH4Yu+MVieI/6yY29CDOYiEFDAtPkcWHY8=
X-Received: by 2002:a1c:a747:: with SMTP id q68mr8504905wme.180.1631281228234;
 Fri, 10 Sep 2021 06:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210819135931.895976-1-maxime@cerno.tech> <20210819135931.895976-2-maxime@cerno.tech>
In-Reply-To: <20210819135931.895976-2-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 10 Sep 2021 14:40:12 +0100
Message-ID: <CAPY8ntAohBfUXhiQix9qd8434J0D1h66kNFJ1a=_aHYAWmo9DQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] drm/vc4: select PM
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        bcm-kernel-feedback-list@broadcom.com,
        Emma Anholt <emma@anholt.net>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 at 14:59, Maxime Ripard <maxime@cerno.tech> wrote:
>
> We already depend on runtime PM to get the power domains and clocks for
> most of the devices supported by the vc4 driver, so let's just select it
> to make sure it's there, and remove the ifdef.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/Kconfig    | 1 +
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
> index 118e8a426b1a..f774ab340863 100644
> --- a/drivers/gpu/drm/vc4/Kconfig
> +++ b/drivers/gpu/drm/vc4/Kconfig
> @@ -9,6 +9,7 @@ config DRM_VC4
>         select DRM_KMS_CMA_HELPER
>         select DRM_GEM_CMA_HELPER
>         select DRM_PANEL_BRIDGE
> +       select PM
>         select SND_PCM
>         select SND_PCM_ELD
>         select SND_SOC_GENERIC_DMAENGINE_PCM
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index c2876731ee2d..602203b2d8e1 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -2107,7 +2107,6 @@ static int vc5_hdmi_init_resources(struct vc4_hdmi *vc4_hdmi)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM
>  static int vc4_hdmi_runtime_suspend(struct device *dev)
>  {
>         struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
> @@ -2128,7 +2127,6 @@ static int vc4_hdmi_runtime_resume(struct device *dev)
>
>         return 0;
>  }
> -#endif
>
>  static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>  {
> --
> 2.31.1
>
