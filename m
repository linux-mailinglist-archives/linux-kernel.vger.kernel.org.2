Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EAE39D57B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhFGHAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 03:00:47 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:45032 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGHAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:00:46 -0400
Received: by mail-vs1-f48.google.com with SMTP id h14so1953661vsh.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 23:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+b/qgU/xjmCf3iqp6d/+T4y8Bk4XAmWjEdEG1RU2s3Y=;
        b=PUB8GEOePhCKMrTIQjnRhUavBGDCOHNwPYOOYDJ3uTxHCiytrs2t7Lkdwb/+7EBAvU
         0YbLmoZURIVk5PInquK3LaBhErEqxF1y9xYJ/ZJtVsabRMvbb2L8VqgNWDXuVyKEUEc9
         4cdTeyrJXp4CTrEFZMF6wpMItN6PMRWTBOhkw8fepteFLLI+DkumAROqQeRupWxyhklv
         1ccmee0eonbcRpDB/1DH5Ttq6YOMKGPL8cuqN2nlQNn7mqPbxF4rl80FlYb3bOScrOOP
         +fnUoZczs6BYFEiXBO7uNDdwZaXykRhydiT/YGI10wY+MyTAp+Xr7SELHKtXtk5Seu+v
         Zf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+b/qgU/xjmCf3iqp6d/+T4y8Bk4XAmWjEdEG1RU2s3Y=;
        b=gxIJrr5Vpc7zgvmrN/nZZ1tXsckHM1aHeQZDnE3WwuqBHaAD/qEasqcY426eNo0r40
         eudNUVgPiO5aGS8H3esmbxOZxjbBXLS0nbn0eFmKYR80bYIsbz2BKZIvJCUzp8jYxjbk
         leiVcbmiI3k7W2ph6fK7APInVZRiJ+Bxu9mN8kvHoFX1x1bIxygkjaq9HiAkDNFlezea
         n8mHgigiEHD52ESHqMRcXTqdB5fdHJBZdpHYYPnoFOl2qyxhVaqJ8hTl4H8Z2pfYs3m+
         epgbnQuCoZLSyGLrEe4+Bt5LdG7yREsW4O9zPIaP9sH0naf9ai9SJGmUYj2Jry4l+ngX
         EUpw==
X-Gm-Message-State: AOAM531UOmbq4fwsLv2JhUPAP0MQ/DZGSRGI7pTzU48q5JUrZSKuJve1
        ZUdj0s13qYWaKhZeeQUj6XUZPKr+yYWJ/Fbe+PbwOZ0v680=
X-Google-Smtp-Source: ABdhPJy70YBG8kZHmxKIbBvCjRC0dhSUQf86Cc7B3nOnbl3qJRe/PcR+aPcxCSGHjS7txoOd86P45V3nzVWo0GeH/G8=
X-Received: by 2002:a67:ed81:: with SMTP id d1mr7789915vsp.29.1623049062495;
 Sun, 06 Jun 2021 23:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210605122415.8621-1-bernard@vivo.com>
In-Reply-To: <20210605122415.8621-1-bernard@vivo.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 7 Jun 2021 08:57:37 +0200
Message-ID: <CAH9NwWcTDV70Nb_e_rs9egsQqmAo91_HM+DoO_woC_ZqnHCVNw@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: remove no need NULL check
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sa., 5. Juni 2021 um 14:24 Uhr schrieb Bernard Zhao <bernard@vivo.com>:
>
> NULL check before kvfree functions is not needed.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
> index d05c35994579..bd0d66ebf314 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
> @@ -612,14 +612,10 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
>  err_submit_cmds:
>         if (ret && (out_fence_fd >= 0))
>                 put_unused_fd(out_fence_fd);
> -       if (stream)
> -               kvfree(stream);
> -       if (bos)
> -               kvfree(bos);
> -       if (relocs)
> -               kvfree(relocs);
> -       if (pmrs)
> -               kvfree(pmrs);
> +       kvfree(stream);
> +       kvfree(bos);
> +       kvfree(relocs);
> +       kvfree(pmrs);
>
>         return ret;
>  }
> --
> 2.31.0
>

Thanks for the patch, but there is an other one queued up in
etnaviv/next that fixes the same issue:
https://git.pengutronix.de/cgit/lst/linux/commit/?h=etnaviv/next&id=bdf622e0fade2cec72c948c708763378b656c01d

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
