Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B93E443483
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 18:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhKBR2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 13:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhKBR2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 13:28:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBFBC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 10:25:24 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t30so9622171wra.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 10:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sxYXMf5BMsZ6bcDoB6IgyyPOcUbnu1N7v5mY6qvSF18=;
        b=YW5YjiJKTFdkL4xfBdbwyJhiCgtfRio0vHn6KKEM3uQ/s2OfI04B9QaHEBp0BlhNwI
         YXVHXnC0gujQDMz7bPBRZS39Zl88vA90UGqAPS1EniZLnwQqsQP8etwjaqL/briUAU/o
         RFlVrpSaPC8P763gHCkrxXi/HIjrAfZ157aZIyfQMWqeFXelkk4eNSv75CDOHTi12EAR
         7fo5/36H8+mZNqZviuC4BVo7av/BU8b3MnJZwq2gFA4iFCDbNJ8ucmRMtYnPNSd1t3D9
         AywdgnkFMTI3riq8nDNpQc8ForBXhrJ4hgJvsS7bd0/VKxcr/BZyimLXtjffXGeHSFom
         QhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sxYXMf5BMsZ6bcDoB6IgyyPOcUbnu1N7v5mY6qvSF18=;
        b=argc6EDMnAVODTg5GT0iLCYo3OPxvXwH7b9XaL36+xv7xlaF+4b1n5OZH5Hn5k2HAZ
         f50PcwWlVFE0O0Wow9UMU1EdgET2e1OpR3lKfcBzc3t5HWzkR+gTOWYHTz1nPl6+93hW
         uQiNj+1y06KL2Ox8Gdk4aKbu+Cnt0uorHrUG22IGN52tgqqyyuq+BOJwIB3mJ1o2wKxW
         XVYbt7YWawzkzfdl04DoxP4fJYQjoRc6cTtciwSpePnQ9aAIo3P9k90YelUjrWVj8YNS
         dGQF2QbagUfRuYFy+meBj9cTukZKME+X3aQL9kVZOn990aNQU6EjFNuPGPUPapyB7F22
         17wA==
X-Gm-Message-State: AOAM533llmMrhxR0KRal3hyb3JHM7mxDp6FDIbpiVr+DlS07IAbuBAyc
        WYb10x6qxJ4JF9QUMIavcKhwdOVO5vLbXLejVTy+HA==
X-Google-Smtp-Source: ABdhPJyxhSk7CapvB3FHdUy3neyiWf4j7xsFGO4PQlz5UNPAlxPnqqj0NFdsJwnqG2+u9K83sXF4a8WfgwIB0+Rhm3A=
X-Received: by 2002:adf:a143:: with SMTP id r3mr48892885wrr.8.1635873923581;
 Tue, 02 Nov 2021 10:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211025152903.1088803-1-maxime@cerno.tech> <20211025152903.1088803-2-maxime@cerno.tech>
In-Reply-To: <20211025152903.1088803-2-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 2 Nov 2021 17:25:07 +0000
Message-ID: <CAPY8ntCOX33OYxSo87vNu2-OfAYDbJGOGhNwsA4yR+sL4kPeyQ@mail.gmail.com>
Subject: Re: [PATCH v8 01/10] drm/vc4: hdmi: Remove the DDC probing for status detection
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        linux-rpi-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Emma Anholt <emma@anholt.net>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 at 16:29, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Commit 9d44abbbb8d5 ("drm/vc4: Fall back to using an EDID probe in the
> absence of a GPIO.") added some code to read the EDID through DDC in the
> HDMI driver detect hook since the Pi3 had no HPD GPIO back then.
> However, commit b1b8f45b3130 ("ARM: dts: bcm2837: Add missing GPIOs of
> Expander") changed that a couple of years later.
>
> This causes an issue though since some TV (like the LG 55C8) when it
> comes out of standy will deassert the HPD line, but the EDID will
> remain readable.
>
> It causes an issues nn platforms without an HPD GPIO, like the Pi4,
> where the DDC probing will be our primary mean to detect a display, and
> thus we will never detect the HPD pulse. This was fine before since the
> pulse was small enough that we would never detect it, and we also didn't
> have anything (like the scrambler) that needed to be set up in the
> display.
>
> However, now that we have both, the display during the HPD pulse will
> clear its scrambler status, and since we won't detect the
> disconnect/reconnect cycle we will never enable the scrambler back.
>
> As our main reason for that DDC probing is gone, let's just remove it.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

A quick conversation with Dom does conclude that the old code was odd
in that DDC read attempt was before we checked the Pi4 HPD. If there
is a need to read the DDC, then it should be after HPD (in whatever
form it exists) has been checked.
No need for that to be reinstated at this point, so this patch is fine
as it stands.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 7b0cb08e6563..338968275724 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -193,8 +193,6 @@ vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
>         if (vc4_hdmi->hpd_gpio &&
>             gpiod_get_value_cansleep(vc4_hdmi->hpd_gpio)) {
>                 connected = true;
> -       } else if (drm_probe_ddc(vc4_hdmi->ddc)) {
> -               connected = true;
>         } else {
>                 unsigned long flags;
>                 u32 hotplug;
> --
> 2.31.1
>
