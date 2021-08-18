Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8713A3F0DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 23:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbhHRVwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 17:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbhHRVwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 17:52:23 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE4CC061764;
        Wed, 18 Aug 2021 14:51:48 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u10so5534320oiw.4;
        Wed, 18 Aug 2021 14:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrbViX0wQKvaWuCri+CZMKvsdsPMmbuJGU6REqdEujk=;
        b=gRJochQghrev713LVE7XNVqpfWWXVIyAf41WsqX4eUKV1pbw8wDGju2iA+oUaIo3ix
         ConEdxYiBmm4dBGFFVOiAA7xxs96VAsznRjW2hwZdQSAn/cegC16eU4NjwLtgN7vR/CT
         WsV3YQxSZn0cKR9dC5AyZzA8473gIaN7KXVrMErJrFSm1a52JXXcP3QBiXJWdDXAmdQr
         cLNfP4CX2Ec0VzQhh66J9XTaT5sJ6D7lgRjT0x41RqPuh6txxUCO8qZSj7j4cXc2NY2+
         YKQfFXarxLig+iT4qeGm9clvf3Z10R/gd36BP6Z1Fg/D298mW9ZnqEGAkJDd3E7MqhbT
         NX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrbViX0wQKvaWuCri+CZMKvsdsPMmbuJGU6REqdEujk=;
        b=gPxltkbNmmtnMpdyAgW/iWxhTxl3ntGHudi8JwxUfLHqdkwzKcZlFLv2qoSKA6k/gR
         Ea+FQkmQ+oIwS9h4NyYVao8GN7cBpMGYfRy1+oKY6SsNkrMBWhigOA6ZXWor1oHCl7ng
         yw41UHWSGHKcTx+N72IrSVo/4KncWn2qj7Tb/ssSxslZMW0DnUgBGUgF5pgDwt9mmLpR
         0xwl7x3UThxb81n5k5YXsFtJmlwEcFIyIhCeMdN06IgSeCy/j6EUoceG1toILE02l778
         nOFUzC/x52XW8v/EFx7upHTyriAGKDoTUrqdraHXQUGw1/qPw+iS2Wi79rl350o4hoek
         JTpw==
X-Gm-Message-State: AOAM5318GYHloc2CcUf8i9CCv9iZxpYYahiRq7DCjk2h3vrZunINNPvU
        LJuq2jy2L9uR4HOfqhXnBDt9xUJ/t65jxob+HIw=
X-Google-Smtp-Source: ABdhPJyb/T3+O4GXm462bouKYg/m2oSAgVUac1M9v28NUTBTso2dAhydO9+ec4Xvzly/53MqwkSj1Nat/NIzcxop9vE=
X-Received: by 2002:a05:6808:1390:: with SMTP id c16mr216682oiw.123.1629323508125;
 Wed, 18 Aug 2021 14:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210818124114.28545-1-lukas.bulwahn@gmail.com> <20210818124114.28545-3-lukas.bulwahn@gmail.com>
In-Reply-To: <20210818124114.28545-3-lukas.bulwahn@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 18 Aug 2021 17:51:36 -0400
Message-ID: <CADnq5_MiTXcAu1kK3-9m=nFoT+SxF9SBv9wYgm2-WNVt_85RQA@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm: amdgpu: remove obsolete reference to config CHASH
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Emma Anholt <emma@anholt.net>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Aug 18, 2021 at 8:41 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 04ed8459f334 ("drm/amdgpu: remove chash") removes the chash
> architecture and its corresponding config CHASH.
>
> There is still a reference to CHASH in the config DRM_AMDGPU in
> ./drivers/gpu/drm/Kconfig.
>
> Remove this obsolete reference to config CHASH.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/gpu/drm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index f3bc90baca61..8fc40317f2b7 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -257,7 +257,6 @@ config DRM_AMDGPU
>         select HWMON
>         select BACKLIGHT_CLASS_DEVICE
>         select INTERVAL_TREE
> -       select CHASH
>         help
>           Choose this option if you have a recent AMD Radeon graphics card.
>
> --
> 2.26.2
>
