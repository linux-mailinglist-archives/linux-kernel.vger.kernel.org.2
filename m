Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D15A409CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242018AbhIMTYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbhIMTYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:24:54 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E62C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:23:38 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b200so13598637iof.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCfdjvRp7InTH9XjtPaz8vHnaVYBhJdaoMr7MV9qAvA=;
        b=dGo+tuevfhZCA/YeqPxtdFEN1V8llnfd0o54rTOUf0poR2gUtjWfiAKLIpNs8ETBko
         7RQh66PWNSSZTd+a0Lwe0U9L1gMHib7lbmfwVZI9a6R+sacM2f343flRrqxLjOeCMN8a
         S+kcaEXejuEf8BVC+K6MKMCHj9ZbXpBEihpuds/BBELsi909qp2oT1AaF0PMIUnTJN5+
         wC+NAt7hnv6Jh7VFnRE/N2GtDOCnYYxX8M+Utx8+4Ym3FexPh4CTif35n/nT8bvgqPEi
         9cEWiUBQITXahD1whKbEJGu4JJfqT2iYhn7z8X/6VksHTVkZyzYCDV8BzSCW1BZeIFSM
         cNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCfdjvRp7InTH9XjtPaz8vHnaVYBhJdaoMr7MV9qAvA=;
        b=PLtiehoMNK03lcEExaI0S+KN4LL442a5ow6F5A/0cHvK0VTb6GlQIFUo108vVpM4yy
         8y3a/Csx8xO9yEDWQb5DARugEK0DWHutkLo0+jlq0Y0tTSwNaq8KgAPq5V04dMxMyBRj
         4bnH9oXqQ2s0r5MRu+VN1WJIzMPEwjYc5GC6RhshxZsfWn/HP+SZInHWS5t6HH48ifl3
         PBCzfkdQ1n3Gjwx6SKwMWSmeu86DdsELutkfUHOeY8bETQuFZQ/ESCR4zSsFlvQEsulj
         wEzirwnLFcXFoDwZ+mf/uQADRDvsWcIPi+ZlSdrcj7MPvYK7S+teW/MxXSp1A5KJ8yb4
         MS+A==
X-Gm-Message-State: AOAM5337pjI6gnB5n2jh6xX2+vjF2MEZ8eFOP3PFMuRlh0eb/842aLTJ
        ep/sryJg7vtzdiIa/kSOYusqlHnz1smcG+t27nrcIw==
X-Google-Smtp-Source: ABdhPJyVuPZv27Yi2qFn/qujRstHDcU6qv3CChfab0QTyJU1ljeUyfb4M1sR4wvotkY1crUMu4lxnztMStgDzGPAhmA=
X-Received: by 2002:a5d:8b4b:: with SMTP id c11mr10576984iot.98.1631561017347;
 Mon, 13 Sep 2021 12:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210913105920.3719525-1-yangcong5@huaqin.corp-partner.google.com>
 <20210913105920.3719525-6-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20210913105920.3719525-6-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Mon, 13 Sep 2021 12:23:25 -0700
Message-ID: <CAD=FV=XFApy_RxCRzrQrQ1-xua+tBpZN60B1TzyEvDNm3LnD7Q@mail.gmail.com>
Subject: Re: [v5 5/5] drm/panel: Update BOE and INX init code to support touch function
To:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 13, 2021 at 3:59 AM yangcong
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> This is an incell IC, TDDI use time division multiplexing.
> Init code effect touch sensing.
> Support touch function we needed to handle were:
> a) Update init code for the panel driver, adjust the porch value.
> b) After update init code these two panels can support DSI HS mode.
>
> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 399 +++++-------------
>  1 file changed, 110 insertions(+), 289 deletions(-)

Please squash this with patch #3 in the series. Even though you have
landed patch #3 in the series in a Chrome OS tree it doesn't matter.
Since patch #3 hasn't landed upstream there is no reason to post the
"wrong" code and then fix it up in the same series. The Chrome OS tree
can always take a revert of the old version and a re-pick of the new
version.


> @@ -36,7 +36,6 @@ struct panel_desc {
>         const struct panel_init_cmd *init_cmds;
>         unsigned int lanes;
>         bool discharge_on_disable;
> -       bool unsupport_dsi_hs_mode;

Not that I'm complaining, but how did this suddenly get supported?


> @@ -84,6 +83,8 @@ static const struct panel_init_cmd boe_tv110c9m_init_cmd[] = {
>         _INIT_DCS_CMD(0x07, 0x78),
>         _INIT_DCS_CMD(0x08, 0x5A),
>         _INIT_DCS_CMD(0x0D, 0x63),
> +       _INIT_DCS_CMD(0x0E, 0x91),
> +       _INIT_DCS_CMD(0x0F, 0x73),

I _really_ don't like this opaque list of commands and the fact that
apparently they aren't fixed but need to change depending on how
you're configuring the panel, but I won't personally block this patch
just because of it since it matches what other panels in this driver
are doing.

If someone more familiar with MIPI panels wants to chime in though,
I'm all ears.


> @@ -1442,15 +1260,15 @@ static int boe_panel_enable(struct drm_panel *panel)
>  }
>
>  static const struct drm_display_mode boe_tv110c9m_default_mode = {
> -       .clock = 162383,
> +       .clock = 166594,
>         .hdisplay = 1200,
>         .hsync_start = 1200 + 40,
>         .hsync_end = 1200 + 40 + 8,
>         .htotal = 1200 + 40 + 8 + 28,
>         .vdisplay = 2000,
>         .vsync_start = 2000 + 26,
> -       .vsync_end = 2000 + 26 + 1,
> -       .vtotal = 2000 + 26 + 1 + 94,
> +       .vsync_end = 2000 + 26 + 2,
> +       .vtotal = 2000 + 26 + 2 + 148,
>         .type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
>  };
>
> @@ -1463,14 +1281,15 @@ static const struct panel_desc boe_tv110c9m_desc = {
>         },
>         .lanes = 4,
>         .format = MIPI_DSI_FMT_RGB888,
> -       .mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> -                     MIPI_DSI_MODE_LPM,
> +       .mode_flags = MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_VIDEO
> +                       | MIPI_DSI_MODE_VIDEO_HSE
> +                       | MIPI_DSI_CLOCK_NON_CONTINUOUS
> +                       | MIPI_DSI_MODE_VIDEO_BURST,
>         .init_cmds = boe_tv110c9m_init_cmd,
> -       .unsupport_dsi_hs_mode = true,
>  };
>
>  static const struct drm_display_mode inx_hj110iz_default_mode = {
> -       .clock = 162383,
> +       .clock = 166594,
>         .hdisplay = 1200,
>         .hsync_start = 1200 + 40,
>         .hsync_end = 1200 + 40 + 8,
> @@ -1478,7 +1297,7 @@ static const struct drm_display_mode inx_hj110iz_default_mode = {
>         .vdisplay = 2000,
>         .vsync_start = 2000 + 26,
>         .vsync_end = 2000 + 26 + 1,
> -       .vtotal = 2000 + 26 + 1 + 94,
> +       .vtotal = 2000 + 26 + 1 + 149,

It seems really odd that the two panels have _exactly_ the same timing
except that one of them now has:

.vsync_end = 2000 + 26 + 2,

...and the other:

.vsync_end = 2000 + 26 + 1,

Do they really need to be different?

-Doug
