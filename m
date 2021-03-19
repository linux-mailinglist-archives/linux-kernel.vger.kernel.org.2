Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B9A341F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhCSO2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhCSO20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:28:26 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD6AC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:28:26 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g15so6018872pfq.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wB7XW1expiEEiA0z4q1J+zFtd6n/h701jYh9DH52x/g=;
        b=rfMY38MqhnK5WXT7hN0NFVNWJw09ySqEl6rahFHBok2eKiGSQ2SNtxC0jMRggFiFlp
         YNwZt7MGTpigDLIAQKlPZmqoBKtAhhEZfliE5yoKKwNqonCgvMFh7k/B/fMmSMvqGIKr
         5o8ELS87A24SQYN48yn1Kk4x38DeIrzUpQ1vxEuFDiJufMUpYAWSvdq2f2AhwA7AksfV
         bzKZSInC5qkZPpyyM0fxBaDgRizOcLYb/NaHoS9F2+0iegoTshz2yU6lxf5+VEoO5kuz
         hLBfKtTo5O9LWVFySPV8SYcnOJrIxqA1hBYp3/kGnJNXZaR/mMgvqz0ywTpGOA39Y6hJ
         Z+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wB7XW1expiEEiA0z4q1J+zFtd6n/h701jYh9DH52x/g=;
        b=Y/SMnvf6CLvBpjo1INKkkkvAwsIu6yDJFsIE5rtNw1NwGF3S7ekk65lWpitwS7nfsv
         1gLVG0CRUHoi+0cyLoZqSmLaGHUily04A3xr73Vi4rvyb5Q3VODWu/WJNZvabodamSJ1
         BUUvLGnxi+yteTM5q+QIRenNp7WXYEb40/DLG5VRWmYqQlw+143rqqJrNVBifqTDQgvP
         7QL2mbvq6getkTlLcGEhRnDzNKP8aR5qiDCDI77aoE4h4F55B7TbL2M98FjZuscy6O7p
         q7gFMjKCk6WIYtuk4mYaTbA/aIDvOexaI80S+Xx3apM06hhcaN9ppiduzBq8SKJ9+Z7X
         p83Q==
X-Gm-Message-State: AOAM531kTNDdveyd2r0ugnPjFFBh7IENtmCsP3pAiT7rcnKIMSF/DFU0
        L0CU1h0I76eTYbc/e3KARXNJIjY5bQX+Rc/X0/E6jw==
X-Google-Smtp-Source: ABdhPJyE0Wk9tAliN/2sKNin+z7nx+NeyBf7s/4rymph1mvk13Artsko/VpzzorcMg+3DPqfuz4cf4SD2HeAcfTrsYc=
X-Received: by 2002:a63:2321:: with SMTP id j33mr11536620pgj.120.1616164106191;
 Fri, 19 Mar 2021 07:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210219215326.2227596-1-lyude@redhat.com> <20210219215326.2227596-8-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-8-lyude@redhat.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 19 Mar 2021 15:28:15 +0100
Message-ID: <CAG3jFyt10Z_MVvvXyBfYFrN7_FQCOUywfLNXZbei2c=1DxvqhA@mail.gmail.com>
Subject: Re: [PATCH 07/30] drm/bridge/analogix/anx78xx: Add missing
 drm_dp_aux_unregister() call
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Torsten Duwe <duwe@lst.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lyude,

Thanks for the patch, it looks good to me.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 19 Feb 2021 at 22:56, Lyude Paul <lyude@redhat.com> wrote:
>
> Surprisingly, this bridge actually registers it's AUX adapter at the
> correct time already. Nice job! However, it does forget to actually
> unregister the AUX adapter, so let's add a bridge function to handle that.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> index 81debd02c169..ec4607dc01eb 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> @@ -942,6 +942,11 @@ static int anx78xx_bridge_attach(struct drm_bridge *bridge,
>         return 0;
>  }
>
> +static void anx78xx_bridge_detach(struct drm_bridge *bridge)
> +{
> +       drm_dp_aux_unregister(&bridge_to_anx78xx(bridge)->aux);
> +}
> +
>  static enum drm_mode_status
>  anx78xx_bridge_mode_valid(struct drm_bridge *bridge,
>                           const struct drm_display_info *info,
> @@ -1013,6 +1018,7 @@ static void anx78xx_bridge_enable(struct drm_bridge *bridge)
>
>  static const struct drm_bridge_funcs anx78xx_bridge_funcs = {
>         .attach = anx78xx_bridge_attach,
> +       .detach = anx78xx_bridge_detach,
>         .mode_valid = anx78xx_bridge_mode_valid,
>         .disable = anx78xx_bridge_disable,
>         .mode_set = anx78xx_bridge_mode_set,
> --
> 2.29.2
>
