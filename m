Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140F5366439
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 06:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhDUEBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 00:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhDUEBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 00:01:14 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A300AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 21:00:42 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id s184so10106891vss.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 21:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xt+GQvk7UCjysn06gj5L/SQBPrigIvE1NOz7WEy+AKw=;
        b=VgyYsPvlKTLCdXiNCI1aub4fGEWqdkN23cKPeOzsX+dG28L8FX+/LiDEbJVpS/LRYr
         aB4g7gVd3K63q01YAYXFBarfY7cAe89HoHGF8io6yuPolR+YLTpkODOc7T8T5eSzxNbN
         a2sF3SDLXGHkMlZU8mBkZF2xAhghXgR7K2X4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xt+GQvk7UCjysn06gj5L/SQBPrigIvE1NOz7WEy+AKw=;
        b=Rhz0x2TMKt+CTjIskthFwIM3Gsc8nSrINQCBQBRFZoePi0mv3H78R/We7g15mao+FM
         oJS0KgV4vs1bJapViEAzJBEXov71IXMVfqRBCX0PeI0hl0DWbtqmkUVSI6xyYs84cE3n
         rf8J0FwyGQwYdJpVMeocCkXIhdIvX8XuCEIJEHOgLPH5xHVIb/wu/jUJaFZcAbtcWQ5x
         rmi0v1RwTJuI3QTDwJyRZa8aqZkfg7wir1NpSdzEqplQB5CGanaAbIzmpRcM6d4G60wj
         GdOpkua8nziRn8SOted098i+ttqK5Ro4hXdVibDMK4YfXea4dxYKX+9igqexj46TZinL
         B4VQ==
X-Gm-Message-State: AOAM530vFLi8L0Q0BtmCNk9N72NjotnmzHWjXzYZRk4qQph1T/KMDEEN
        qoREAoRd2HaSJwXhgBt+RfwPIeLm3Q8J/aYR2h9csA==
X-Google-Smtp-Source: ABdhPJx8sqi7yyCbZtsqWkPAetpn+zmApPCR4F96SUihvi7LBsId0jAdkje9hdf8VwGHUya1KDTYm2FJ2kYtrRm/mtE=
X-Received: by 2002:a67:efd1:: with SMTP id s17mr10253276vsp.16.1618977635719;
 Tue, 20 Apr 2021 21:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210421001908.813625-1-drinkcat@chromium.org> <20210421081831.v12.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid>
In-Reply-To: <20210421081831.v12.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 21 Apr 2021 12:00:24 +0800
Message-ID: <CANMq1KBfg1SKM1iC+EUXjCiA-f9p=JSBvkp3h3eygH2aZfCAng@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] drm/panfrost: devfreq: Disable devfreq when
 num_supplies > 1
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Fei Shao <fshao@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kristian Kristensen <hoegsberg@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Argh sorry I messed up the rebase and this doesn't even build...

I'll send v13.

On Wed, Apr 21, 2021 at 8:19 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> GPUs with more than a single regulator (e.g. G72 on MT8183) will
> require platform-specific handling for devfreq, for 2 reasons:
>  1. The opp core (drivers/opp/core.c:_generic_set_opp_regulator)
>     does not support multiple regulators, so we'll need custom
>     handlers.
>  2. Generally, platforms with 2 regulators have platform-specific
>     constraints on how the voltages should be set (e.g.
>     minimum/maximum voltage difference between them), so we
>     should not just create generic handlers that simply
>     change the voltages without taking care of those constraints.
>
> Disable devfreq for now on those GPUs.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> ---
>
> (no changes since v9)
>
> Changes in v9:
>  - Explain why devfreq needs to be disabled for GPUs with >1
>    regulators.
>
> Changes in v8:
>  - Use DRM_DEV_INFO instead of ERROR
>
> Changes in v7:
>  - Fix GPU ID in commit message
>
> Changes in v6:
>  - devfreq: New change
>
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 47d27e54a34f..aca3bb9a12e4 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -92,9 +92,19 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>         struct thermal_cooling_device *cooling;
>         struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
>
> -       ret = devm_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
> -                                        pfdev->comp->num_supplies);
> -       if (ret) {
> +       if (pfdev->comp->num_supplies > 1) {
> +               /*
> +                * GPUs with more than 1 supply require platform-specific handling:
> +                * continue without devfreq
> +                */
> +               DRM_DEV_INFO(dev, "More than 1 supply is not supported yet\n");
> +               return 0;
> +       }
> +
> +       opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
> +                                             pfdev->comp->num_supplies);
> +       if (IS_ERR(opp_table)) {
> +               ret = PTR_ERR(opp_table);
>                 /* Continue if the optional regulator is missing */
>                 if (ret != -ENODEV) {
>                         DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n");
> --
> 2.31.1.368.gbe11c130af-goog
>
