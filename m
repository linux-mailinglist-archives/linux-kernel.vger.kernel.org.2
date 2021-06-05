Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D8139C815
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 14:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFEMVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 08:21:23 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:35647 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFEMVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 08:21:21 -0400
Received: by mail-qk1-f172.google.com with SMTP id j189so12107755qkf.2;
        Sat, 05 Jun 2021 05:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2XU5HDbmcHnF712wVpqM6iQ1X7EhYZWOfK4vwV87prU=;
        b=FWobSpgrhp0Af/hcJqRgDfsHgRC3XmmPbsTFVx7BVZIZsbDAiAq6QmHzQc9wN6ld5l
         6OlQdRVBJ4+zJAXiNK0mBkcTt5KDuPzVbIfcnPn0aHjMdOO+fXMorjb5pGOISWE05oWS
         E+545N6/1rPXvrj+XtwR4xKiapXjMbyzDxyvv1TIezV2LtV2Gc7EJTx4sr9E4BXgjl08
         Mp/gY390Qh61pvf0wqhzTTtw4+GUeasRTiDSVrtZWD6CUES2pnc6QT+2onqSTsGLX+TT
         cKiijQcGu3QN5k2RzM47GLUs61t7zUhpLlYQC9rx9SK1AGJJTyeklrKsl9XqbPS5rlEV
         wEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XU5HDbmcHnF712wVpqM6iQ1X7EhYZWOfK4vwV87prU=;
        b=OkLlSmOX4PXeWBQBfyOUDgnm/Qa2hsOvSP8v/Bq4zPchSMvk7FBuLkVtVo2k/lhBx4
         wHRouuJQ6Bj+R6JsS/Yon8PNc4+nlfmyOvAtFGMVEqIhhZluoC9Fq6Dz+VI3PuBOcr7z
         XGDATbRRXqZssTpvCvplw/RlxXtO+Py72O/BsXugIcRGQaP0IC7GxUNtpB7podPBbhJb
         wsfnOT+HdfnjZYC3p7hOCehj7u7I1HR8qE0kVDw6YbK6sYx5CMigyduC+IMSLoKVm/4z
         OnX6VivOcy4SGFI+2vMXaVgnYPKlS0Y4pBWdikpWTqjTcgoBYLjOeQVJc9NWA+5Gh+Kj
         FgZg==
X-Gm-Message-State: AOAM532RAhUoLNUuj88TArdOyrjIUhJY99/+xanQCmpm19F8l5m3qIy0
        wYdckjIanGzCgC+CtkEVc1JFthJkqpKfbCqvQEY=
X-Google-Smtp-Source: ABdhPJz616zbzLkCG4N8pskE1XrPJz4cf9/NOusosJu2q74PjtNEUUCHcdBR5LFqOAKT12RVqIG5z0nyLpZzvcV8Bos=
X-Received: by 2002:a05:620a:119c:: with SMTP id b28mr8701321qkk.374.1622895503195;
 Sat, 05 Jun 2021 05:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210605104942.39487-1-konrad.dybcio@somainline.org> <20210605104942.39487-2-konrad.dybcio@somainline.org>
In-Reply-To: <20210605104942.39487-2-konrad.dybcio@somainline.org>
From:   Marijn Suijten <marijns95@gmail.com>
Date:   Sat, 5 Jun 2021 14:18:12 +0200
Message-ID: <CANX-K3t35412cnsWwiG=oi7MK9qYoOFCD5NBOqCwzXFA9OamsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/panel: Add support for SONY JDI Synaptics panel
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jun 2021 at 12:49, Konrad Dybcio <konrad.dybcio@somainline.org> wrote:
>
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>
> This commit adds support for Synaptics+JDI display panels
> used in SONY Xperia X, X Compact, X Performance, XZ and XZs
> smartphones.
>
> Due to the nature of phone manufacturing, it is impossible
> to retrieve the actual panel names, hence the replacement
> ones, detailing the devices they are used on.
>
> Co-developed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |  10 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-sony-synaptics-jdi.c  | 511 ++++++++++++++++++
>  3 files changed, 522 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-sony-synaptics-jdi.c
>
[..]
> diff --git a/drivers/gpu/drm/panel/panel-sony-synaptics-jdi.c b/drivers/gpu/drm/panel/panel-sony-synaptics-jdi.c
> new file mode 100644
> index 000000000000..2b1972dea58a
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-sony-synaptics-jdi.c
> @@ -0,0 +1,511 @@
[..]
> +struct synaptics_jdi_panel {
> +       struct drm_panel base;
> +       struct mipi_dsi_device *dsi;
> +
> +       struct backlight_device *backlight;

As mentioned in pre-review, don't forget to actually probe the
backlight.  It is not necessary to store the backlight (anymore), it
is already kept in base->backli  Something like this should work:

    rc = drm_panel_of_backlight(&synaptics_jdi_panel->base);
    if (rc)
            return dev_err_probe(dev, rc,
                    "cannot register of backlight\n");

> +       struct regulator_bulk_data supplies[5];
> +
> +       struct gpio_desc *pan_reset_gpio;
> +       struct gpio_desc *ts_reset_gpio;
> +
> +       bool prepared;
> +       bool enabled;
> +
> +       const struct synaptics_jdi_panel_desc *desc;
> +};

Thanks!
