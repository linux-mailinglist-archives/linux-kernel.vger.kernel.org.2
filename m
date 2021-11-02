Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DF74433A3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhKBQtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhKBQtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:49:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266CDC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:47:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v127so16084135wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MM4U8OxTTBsC+CGULK+tfZc2fJWm7ZzFiLqrtjhGXgw=;
        b=UM0Z8w3309IL/SgU+FerRT6mAyqaQW5t5HBwCU63gZ/t3BIfWdF8MINXIYscqnxkYR
         5+O42gH7bi8X58hP/k0RGIhypkn9PQRbukbtR3vJwQHK9OyB7SoQIFu6K/mDQTXPrZaW
         skYch/0SwgMOrxu5LREURfwxtzvsKecaRj+Kk4ao5hw6uHcia0F1xuNNHVx5A+DbQPfQ
         29PomrEWSL8iwTOxczG2/39ulYRnpY5z9kmYwMsLH1pKjNYDY3Ur6QuvbqmR73w7o5hE
         X/+DbWuBsXctme/i8GDLbxFIqEEKocbqWpK2fHFh6BGvmxETaZlh4Ua4W0xq6GyQsWJr
         ky2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MM4U8OxTTBsC+CGULK+tfZc2fJWm7ZzFiLqrtjhGXgw=;
        b=iGB9NCqiySOWJMSvynYyNOjz1eAfqV56mw78cWSU5WxIVtT8ur0zVHWvRUpSBnYJhk
         pa5+6tbUy1XkfDSssav1wKP/kN0gu8vmzxIXpjB+ge0h/J2nqwksXFhO1S/Q2kMAy7m2
         JW1plLoUQVWd4XDedonFY8wgw4LtJ55s3iSJno3jJLPlQ2eL7C7rwMBCedisYTE8XLmH
         kMcmbsgTjYhp5N8+degrfad+aZzoGROjx23y9NHw4kg5XFtMb6BJIu3VoTh8yiqaTQcU
         K6LIy5anRJgk7h7oLNRGQ+ELKtIFC/Q0FsDdydP5guSB3K9fAgkJjnITinywkHlZzCeF
         pS7Q==
X-Gm-Message-State: AOAM531Dbk/gHiwy9r1gqHWuMsPcghepmXBMOu54o5cUAp5n3t+r+HZZ
        1wEoPvklwTiY5CTISmr9dUMwWsn5lfo6dKCXIIDBjg==
X-Google-Smtp-Source: ABdhPJwqiBEu7rQEr0yiHdHLzzx0ECjHopvd+OCLX7p+1tHVBu7iZ4acoz0A0s0BKq/Z3MdmzPBhH4TBAXbzHK4c+sA=
X-Received: by 2002:a1c:1f06:: with SMTP id f6mr8330799wmf.55.1635871634688;
 Tue, 02 Nov 2021 09:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211025152903.1088803-1-maxime@cerno.tech> <20211025152903.1088803-8-maxime@cerno.tech>
In-Reply-To: <20211025152903.1088803-8-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 2 Nov 2021 16:46:58 +0000
Message-ID: <CAPY8ntBo+xpeRSmOGLJNw_Kd2F-Azz-P244mxtvqyWM7ugZFZA@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] drm/vc4: Leverage the load tracker on the BCM2711
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
> The load tracker was initially designed to report and warn about a load
> too high for the HVS. To do so, it computes for each plane the impact
> it's going to have on the HVS, and will warn (if it's enabled) if we go
> over what the hardware can process.
>
> While the limits being used are a bit irrelevant to the BCM2711, the
> algorithm to compute the HVS load will be one component used in order to
> compute the core clock rate on the BCM2711.
>
> Let's remove the hooks to prevent the load tracker to do its
> computation, but since we don't have the same limits, don't check them
> against them, and prevent the debugfs file to enable it from being
> created.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_debugfs.c |  7 +++++--
>  drivers/gpu/drm/vc4/vc4_drv.h     |  3 ---
>  drivers/gpu/drm/vc4/vc4_kms.c     | 16 +++++-----------
>  drivers/gpu/drm/vc4/vc4_plane.c   |  5 -----
>  4 files changed, 10 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_debugfs.c b/drivers/gpu/drm/vc4/vc4_debugfs.c
> index 6da22af4ee91..ba2d8ea562af 100644
> --- a/drivers/gpu/drm/vc4/vc4_debugfs.c
> +++ b/drivers/gpu/drm/vc4/vc4_debugfs.c
> @@ -7,6 +7,7 @@
>  #include <linux/circ_buf.h>
>  #include <linux/ctype.h>
>  #include <linux/debugfs.h>
> +#include <linux/platform_device.h>
>
>  #include "vc4_drv.h"
>  #include "vc4_regs.h"
> @@ -26,8 +27,10 @@ vc4_debugfs_init(struct drm_minor *minor)
>         struct vc4_dev *vc4 = to_vc4_dev(minor->dev);
>         struct vc4_debugfs_info_entry *entry;
>
> -       debugfs_create_bool("hvs_load_tracker", S_IRUGO | S_IWUSR,
> -                           minor->debugfs_root, &vc4->load_tracker_enabled);
> +       if (!of_device_is_compatible(vc4->hvs->pdev->dev.of_node,
> +                                    "brcm,bcm2711-vc5"))
> +               debugfs_create_bool("hvs_load_tracker", S_IRUGO | S_IWUSR,
> +                                   minor->debugfs_root, &vc4->load_tracker_enabled);
>
>         list_for_each_entry(entry, &vc4->debugfs_list, link) {
>                 drm_debugfs_create_files(&entry->info, 1,
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index 60826aca9e5b..813c5d0ea98e 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -202,9 +202,6 @@ struct vc4_dev {
>
>         int power_refcount;
>
> -       /* Set to true when the load tracker is supported. */
> -       bool load_tracker_available;
> -
>         /* Set to true when the load tracker is active. */
>         bool load_tracker_enabled;
>
> diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
> index 028f19f7a5f8..41cb4869da50 100644
> --- a/drivers/gpu/drm/vc4/vc4_kms.c
> +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> @@ -552,9 +552,6 @@ static int vc4_load_tracker_atomic_check(struct drm_atomic_state *state)
>         struct drm_plane *plane;
>         int i;
>
> -       if (!vc4->load_tracker_available)
> -               return 0;
> -
>         priv_state = drm_atomic_get_private_obj_state(state,
>                                                       &vc4->load_tracker);
>         if (IS_ERR(priv_state))
> @@ -629,9 +626,6 @@ static void vc4_load_tracker_obj_fini(struct drm_device *dev, void *unused)
>  {
>         struct vc4_dev *vc4 = to_vc4_dev(dev);
>
> -       if (!vc4->load_tracker_available)
> -               return;
> -
>         drm_atomic_private_obj_fini(&vc4->load_tracker);
>  }
>
> @@ -639,9 +633,6 @@ static int vc4_load_tracker_obj_init(struct vc4_dev *vc4)
>  {
>         struct vc4_load_tracker_state *load_state;
>
> -       if (!vc4->load_tracker_available)
> -               return 0;
> -
>         load_state = kzalloc(sizeof(*load_state), GFP_KERNEL);
>         if (!load_state)
>                 return -ENOMEM;
> @@ -869,9 +860,12 @@ int vc4_kms_load(struct drm_device *dev)
>                                               "brcm,bcm2711-vc5");
>         int ret;
>
> +       /*
> +        * The limits enforced by the load tracker aren't relevant for
> +        * the BCM2711, but the load tracker computations are used for
> +        * the core clock rate calculation.
> +        */
>         if (!is_vc5) {
> -               vc4->load_tracker_available = true;
> -
>                 /* Start with the load tracker enabled. Can be
>                  * disabled through the debugfs load_tracker file.
>                  */
> diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
> index 19161b6ab27f..ac761c683663 100644
> --- a/drivers/gpu/drm/vc4/vc4_plane.c
> +++ b/drivers/gpu/drm/vc4/vc4_plane.c
> @@ -529,11 +529,6 @@ static void vc4_plane_calc_load(struct drm_plane_state *state)
>         struct vc4_plane_state *vc4_state;
>         struct drm_crtc_state *crtc_state;
>         unsigned int vscale_factor;
> -       struct vc4_dev *vc4;
> -
> -       vc4 = to_vc4_dev(state->plane->dev);
> -       if (!vc4->load_tracker_available)
> -               return;
>
>         vc4_state = to_vc4_plane_state(state);
>         crtc_state = drm_atomic_get_existing_crtc_state(state->state,
> --
> 2.31.1
>
