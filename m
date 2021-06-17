Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694393AB6B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhFQPAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhFQPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:00:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42250C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 07:58:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a11so7135357wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZpkJ+MYgphvbo+BSBH3Zpu7neLYi4f02rnh8CEAedOQ=;
        b=ulwjGky6X26LXPC1yb3zn8bl0jSp6um6+lphjLL4AtnI3F7fKbqCto97dg/wZLIELG
         geqk0K+MYYWf5Rk9tgpAiNJRol3WZCza4miVvbqXhr7l5U3cqLcwvdHLcbUDCjU2La6H
         P1RLtnXU8fNWQ+omJ90vSDOJ+kFmgwLpCcLTKuo/gouam2wEp8JKCr+jP2qUmZ2R2ATK
         JXY7nNt6fy/sCIznCrjtvg+w1addU7qkpeO0W0ahJPgwxXTvm+UdeZWZtA0BClDd7tMx
         668UoML4dcwzxBW1yQBEBeNWa9L3RDElz3baBNgocfo8tiW9KFF4RTEAq9En5LAElA9Y
         getg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZpkJ+MYgphvbo+BSBH3Zpu7neLYi4f02rnh8CEAedOQ=;
        b=rbVBkhwcD7hrHuHUKx/Chy5wjErl61sl4FWo8mIJ0Dkdv2Sk8f67nKHU1NE/REr6wk
         0f0GbjwT5d9beQd6Hgj8NvMsAZBjcZpmpU4QGdZTzMRNTcztne7o+a5SsIEaA4AW76Hy
         y13CVu1eXhrb9faH4ayzB1bWwKxFR9KDjSR5g628Vx5VyVVPRNavH0lc3ZranTY3KxtS
         D765DuUqGL53PJpngwh9ra/DzKbrPZVPXMGqLob6Bleb+J2Qcvyb50I9EyIpKLp8uo+O
         3SVKRTigyW1kipXzTOvZL9SsueyvSFywakaOjcP8rgzYxVqrq9mIzDRa9CPzqKmdIPkp
         dMDw==
X-Gm-Message-State: AOAM531REhO4SvCl0B/J6arGC3gRex9lz8L9qI6lCGxR1BnTI4Qtyj2e
        nIMMkoF/1+/tS5OOPGNVo4iH+EYFrNZq8Q==
X-Google-Smtp-Source: ABdhPJyMYMaw4LO059nv3tFrQ3aLA9CMlV1w5nxei3W97dLFTJEiJJYci7iGLUD1oVqxmgJBv+OY7Q==
X-Received: by 2002:a5d:48ce:: with SMTP id p14mr6356429wrs.170.1623941901303;
        Thu, 17 Jun 2021 07:58:21 -0700 (PDT)
Received: from [10.1.3.24] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x18sm5580002wrw.19.2021.06.17.07.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 07:58:20 -0700 (PDT)
Subject: Re: [PATCH] drm/meson: fix potential NULL pointer exception in
 meson_drv_unbind()
To:     Jiajun Cao <jjcao20@fudan.edu.cn>
Cc:     yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210617070737.50171-1-jjcao20@fudan.edu.cn>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <0c367cae-9bad-d53a-01db-3d2dd801965b@baylibre.com>
Date:   Thu, 17 Jun 2021 16:58:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210617070737.50171-1-jjcao20@fudan.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/06/2021 09:07, Jiajun Cao wrote:
> Fix a potential NULL pointer exception when meson_drv_unbind()
> attempts to operate on the driver_data priv which may be NULL.
> Add a null pointer check on the priv struct to avoid the NULL
> pointer dereference after calling dev_get_drvdata(), just like
> the null pointer checks done on the struct priv in the function
> meson_drv_shutdown(), meson_drv_pm_suspend() and meson_drv_pm_resume().
> 
> Signed-off-by: Jiajun Cao <jjcao20@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 07fcd12dca16..adea6a2b28f5 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -380,6 +380,8 @@ static int meson_drv_bind(struct device *dev)
>  static void meson_drv_unbind(struct device *dev)
>  {
>  	struct meson_drm *priv = dev_get_drvdata(dev);
> +	if (!priv)
> +		return;
>  	struct drm_device *drm = priv->drm;

Please move struct drm_device before the if like :

struct meson_drm *priv = dev_get_drvdata(dev);
struct drm_device *drm;

if (!priv)
	return;
drm = priv->drm;


>  
>  	if (priv->canvas) {
> 

Thanks,
Neil
