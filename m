Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E093D4023C7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 09:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhIGHEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 03:04:22 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:36663 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbhIGHEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 03:04:11 -0400
Received: by mail-ua1-f51.google.com with SMTP id x23so5033691uav.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 00:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RnzOQ0rKdquIXLN6HTpR8yt5pLvPfBFYXKRIuAB1ab0=;
        b=cS42rNIpBjIE6tauAlUcYCFXbQpW6TPetA9uWaAqqzZl/0Le72XvWIK338tuivhxod
         nNbPdcSSUzzi4kzRS/NDcbyc4LuZ8sXkbdtxU/Fabco3kmWHZyUgaljx0VFLulo3w2mF
         Qi8W+zZyj7saDDI/r7RkX05gq2ywyQKUsNfSOTAZkwbuu2jnAjUnRnGZK9teHY+PDTD1
         LtkUbTVE+NqFfgsZZUHnr0mAVX3XLD4r+4ZvUeCBCfa48m1yZQSJuc4vqrwZmXFY+BJp
         DeXLlwCT1eOnYc9n/MAU33/JPRZz/kbIxsTqUiRoHdMdgoVtBjB5qbu+IDAl3g5EUx90
         ifng==
X-Gm-Message-State: AOAM5334lCh4N/wGuERHv9xweiNRYT63fbBGKoziSDWe+2WnR1laz3p1
        Alv4i+C0Vu/MsZru2OWMczUsWodIKxhVv5q796yXukCLJP8=
X-Google-Smtp-Source: ABdhPJw7bE6+/3En0eoolnWevATWF39/p5nYQ/eGyl8MjEBtehFgXksrlK6Bp+Q+vuDVQFYZfg/6LgZg/grUFjA7IxE=
X-Received: by 2002:a9f:35aa:: with SMTP id t39mr7415384uad.89.1630998185101;
 Tue, 07 Sep 2021 00:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210906194917.376116-1-palmer@dabbelt.com>
In-Reply-To: <20210906194917.376116-1-palmer@dabbelt.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Sep 2021 09:02:53 +0200
Message-ID: <CAMuHMdUtg1qA7hx-QGGwd6nfe_vDEzoH95732T736FPH0Jb5dA@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/rockchip: cdn-dp-core: Fix cdn_dp_resume
 unused warning
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 9:58 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
>
> cdn_dp_resume is only used under PM_SLEEP, and now that it's static an
> unused function warning is triggered undner !PM_SLEEP.  This
> conditionally enables the function to avoid the warning.
>
> Fixes: 7c49abb4c2f8 ("drm/rockchip: cdn-dp-core: Make cdn_dp_core_suspend/resume static")
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
> I sent this one out in January, but it looks like it got lost in the shuffle.
> I'm getting this on a RISC-V allmodconfig now.
> ---
>  drivers/gpu/drm/rockchip/cdn-dp-core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> index 8ab3247dbc4a..bee0f2d2a9be 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> @@ -1123,6 +1123,7 @@ static int cdn_dp_suspend(struct device *dev)
>         return ret;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
>  static int cdn_dp_resume(struct device *dev)

An alternative solution would be to tag the function with
__maybe_unused.

>  {
>         struct cdn_dp_device *dp = dev_get_drvdata(dev);
> @@ -1135,6 +1136,7 @@ static int cdn_dp_resume(struct device *dev)
>
>         return 0;
>  }
> +#endif
>
>  static int cdn_dp_probe(struct platform_device *pdev)
>  {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
