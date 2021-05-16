Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DF0381EC9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 14:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhEPMdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 08:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbhEPMco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 08:32:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF84AC061761
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 05:31:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lg14so5143394ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 05:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eckqMwpEIroRZE69KD3Ne9vC93wMSyCChn6bW92xB28=;
        b=qxsJ6UqPYeYNVjSUnnzbteIwHv+wmPzMifNJiXeYO5OI4nFMUE3n3jdR86k2kjPrnz
         fg+MZSaqB9EuxgLvF8mQJq9r1Mn0Vmc9P6rkI6HROgolgJY4h6+Q9BY2fT7jIY5F89Fz
         ZkEadOMmMaD57ecKFGfm6u9WItYiAswVeAmvJxrFZ8S4VxcwdwG8x6nZsz+Ct6oFChUC
         QkCvuY0fEXZQPzPZlSQypIRkkn8UE1b1YAZFnMPiSMY+UxbfiG2w71aM/OIORe6Nqwvj
         OFIqOTVhOTnzE96rSeggi3uMZWTov/SrGJ6cYZVdAur8zieb2EhM1YCNAzzVtjZqLgRO
         a96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eckqMwpEIroRZE69KD3Ne9vC93wMSyCChn6bW92xB28=;
        b=SDf1UZ2qlkS1mfVDfPnjIqAPPOHljOcPR/K0o2Cuc0QAel1BJzHSbshd2UZVppTLWf
         JRbPXfvYvY6DNnJljHs9k8hWBg4AMFxl59LAuCGVwfKUZnfB1dDp+RXVN5ahSSrK2u8M
         cXQNF1WiqTw7mmY7zq4BZNhWF2JBFpsoL/0SQEbzCNJc4PSZygilXQbn/j+6Q3vGK3Ls
         sr0MT0v+JVsTwrxM4HdqDa+AqgrQblGcKzwu+0u5zXlsm/k2rtE9sAbffHky2RsuvliA
         s2sIm5US/1rs5Iwk0hJBYUY3JNW9I4SqWqye0x7qKcIO82MCJFBnkkorRqV9cuKK3v2E
         EEhA==
X-Gm-Message-State: AOAM533dnl6lqzptnWg8D9IfLP1oR0o3XLEf50CKk/7k7hJ5Z6owcKbV
        Yp4Irho7NKXrxh1exMglc3bAwIVjc2WaBiyZwS8=
X-Google-Smtp-Source: ABdhPJyMocjUwulbuwuJTGv1j+LscDh6BLMiewFmxo7PPWGXTM8vvLThYsVj/9y2uCWKAF38AloslnRqGm2OQkvDs64=
X-Received: by 2002:a17:907:f91:: with SMTP id kb17mr56164390ejc.521.1621168287278;
 Sun, 16 May 2021 05:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210516074833.451643-1-javierm@redhat.com>
In-Reply-To: <20210516074833.451643-1-javierm@redhat.com>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Sun, 16 May 2021 13:31:16 +0100
Message-ID: <CALeDE9NsdNDf+S9kYqsJGftjj+mS8sZPexMJUvtNqbc7CTjrqA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/rockchip: remove existing generic drivers to take
 over the device
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 8:48 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> There are drivers that register framebuffer devices very early in the boot
> process and make use of the existing framebuffer as setup by the firmware.
>
> If one of those drivers has registered a fbdev, then the fallback fbdev of
> the DRM driver won't be bound to the framebuffer console. To avoid that,
> remove any existing generic driver and take over the graphics device.
>
> By doing that, the fb mapped to the console is switched correctly from the
> early fbdev to the one registered by the rockchip DRM driver:
>
>     [   40.752420] fb0: switching to rockchip-drm-fb from EFI VGA
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

Tested on Pinebook Pro (eDP), Rock960 (HDMI) and Firefly3399.

> ---
>
> Changes in v2:
> - Move drm_aperture_remove_framebuffers() call to .bind callback (tzimmermann).
> - Adapt subject line, commit message, etc accordingly.
>
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index 212bd87c0c4..b730b8d5d94 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -16,6 +16,7 @@
>  #include <linux/console.h>
>  #include <linux/iommu.h>
>
> +#include <drm/drm_aperture.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
> @@ -114,6 +115,15 @@ static int rockchip_drm_bind(struct device *dev)
>         struct rockchip_drm_private *private;
>         int ret;
>
> +       /* Remove existing drivers that may own the framebuffer memory. */
> +       ret = drm_aperture_remove_framebuffers(false, "rockchip-drm-fb");
> +       if (ret) {
> +               DRM_DEV_ERROR(dev,
> +                             "Failed to remove existing framebuffers - %d.\n",
> +                             ret);
> +               return ret;
> +       }
> +
>         drm_dev = drm_dev_alloc(&rockchip_drm_driver, dev);
>         if (IS_ERR(drm_dev))
>                 return PTR_ERR(drm_dev);
> --
> 2.31.1
>
