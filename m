Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23A3392D77
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhE0MEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbhE0MEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:04:22 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168D3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:02:49 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id q67so414024pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xE6in5hhsnp6u5Cu3tkemYP5oUutyvqnXG55EoeXM+A=;
        b=oEg4OpkN79QCfx6I3fhWoOaz8izmcbQ8iUTQXQ9y5hps/jcvkEkL/wGMvyGtSxPdKZ
         jsPRtftTu8E+5XA2wO2KN1KFGI51nu1cruiuv/YNrcuVhFOBgcL42BNgUEP3QqlpUftn
         4TSNHuNgW1w5wKZO4TSF/JceE3aYNrfzXGSRjJOg1ppr2GHxLl0BMgzN+gnlaX0EpXHL
         223lY8Ji00BDu0zk/ry7r3yPXaEQHw/0PXs4zDu+50Re8hfuW/l5P4Yj/8eZsZ16s764
         9iv6ihbqi4Rh//EmyxNn7rd8po7Ihd/jlqc4nbW4wE0O9iYNwXU6ffbANYPfRUtHV0LI
         wtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xE6in5hhsnp6u5Cu3tkemYP5oUutyvqnXG55EoeXM+A=;
        b=pTGC/xAviEjPUDAtCC5E7rrVh/MwcsR7QxPrvnN6lutbPQTQUSPN+GB0yZwswhwfUE
         v6L3ZrrPNjv0zunmLyuAChI+mlItLL5RwfrsazptvNrq+AEgpuDOlqieSUwRZHNPt4Xf
         aoKOzuT1vCiqSoRP4tYkRSf7WFHDdNdmGv9duyk9TINoL7u73elllCwlTpofu9ajIBxI
         IyqGqJmkwUSHVu0pQzdnEsgvS9g7WngBUorxmFAK/MVZnFwQAiPi4gnN6O5gRseNqZXu
         VnLk0fnmq16mlykq4pf+uBgMRvTjGGZLeF8Oz4p43GXbcs2lrS6lovlb7V3FbQqyMSPS
         UOog==
X-Gm-Message-State: AOAM533sJAk0SLfIrPIuXxRXWM7CPLKBFKXj+WsihQzfMknaTnnC2Zde
        0VcqRtuCUVFVVqaOUWPW5aK6qornn2pcU+tBN+n89g==
X-Google-Smtp-Source: ABdhPJz14LtgueALHp9Qs/WHGKbTcvnAZEyrOujiZ5w3ccVqpJCAgCHK5ddSJKZd2xVd9JgcEJKXoYvzHfu9YPp925Q=
X-Received: by 2002:a63:7703:: with SMTP id s3mr3421133pgc.339.1622116968501;
 Thu, 27 May 2021 05:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <1621852953-51325-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1621852953-51325-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 27 May 2021 14:02:37 +0200
Message-ID: <CAG3jFytM9tOQ6tW7_GQhBNsk33BwyvjNSGiXeOn5mrB5GT_yVw@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: cdns-mhdp8546: Fix inconsistent indenting
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed & pushed to drm-misc-next.

On Mon, 24 May 2021 at 12:43, Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Eliminate the follow smatch warning:
>
> drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c:2143
> cdns_mhdp_bridge_atomic_reset() warn: inconsistent indenting.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 0cd8f40..82619db 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -2140,7 +2140,7 @@ static void cdns_mhdp_detach(struct drm_bridge *bridge)
>         if (!cdns_mhdp_state)
>                 return NULL;
>
> -        __drm_atomic_helper_bridge_reset(bridge, &cdns_mhdp_state->base);
> +       __drm_atomic_helper_bridge_reset(bridge, &cdns_mhdp_state->base);
>
>         return &cdns_mhdp_state->base;
>  }
> --
> 1.8.3.1
>
