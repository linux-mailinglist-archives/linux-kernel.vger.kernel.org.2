Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A423F883B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242511AbhHZNBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242494AbhHZNA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:00:57 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344CFC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:00:10 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id g18so818801vkq.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ocFFaMnpP/NK5k6jGasl64HMse3t1Sh2zr+zn0SwV+M=;
        b=MKdgsD3skHusjl9BNP/Q3G/9e20/iXnmW0VTMNm31s2zKx3/EqdUj3fwoNAsi/G3s+
         yKi3kFV4DzuNUImg5s8PfOD6inHbj/5N00EC1fy4Ri6GislaYs0uFkucQ4RH8VIiiYX7
         DhHWuH0bIeXdXtcPSDoXHWP0Sqpk5xbyYnbp0APV85I9EAwb+vVk96FFMvafuntQtd2v
         vwLei9S9sMdtlIe4yedOC4NjT04WjNkCCs6sEtGd+NYhjFioLxLnHVPSUNJwSi0R7163
         YGqpBuy1DSNxcFHZTUk9K32tkPegiVCF6ojaIaIoiEFsu8Atywmy06oBOEA4u3P7EnCW
         9Asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocFFaMnpP/NK5k6jGasl64HMse3t1Sh2zr+zn0SwV+M=;
        b=PzWJQIzFx1Ecbc963n+iLstm2qQmHKpkm6flwBKRNbvq+ZNOSOWMrrpegMwxWBn0He
         6WS7ZJ3TSi93s1AVJlPO2OeH+xI+sQM0tbtEsk01bsAD/nij0hty05c3LKljEbxkMNBV
         9JL/O17qay+XNdGJzb58KfqzZZ5t0ifO6w8sIw9XIySqWiJ9zfJ9px9Ixn44d3IGfG+g
         TnubPFiJDkpEGjyYhy0BPQFtdrFgTff089pEr3mUWoOXvER2TIok97Nz/PUDL7CE9+iM
         yrBYmQcvVbQsSwZF1B2Aw9OmhV2gsbaIXE5SfWWvvxAnSwEJo4aE+7anRHDkuFagJIS4
         TaHA==
X-Gm-Message-State: AOAM532nX/cHXV/PZeZsSV/t4Yhl+sCMHp7ZhrbKMQe16fBL/RhptsLx
        UWpQS/xcrqBfdcC6IKi7HuN4sxVd6gyBho4W4OU=
X-Google-Smtp-Source: ABdhPJw3aw85jut73xut5Y2i6V/6gxTcFzKq2kOS6bgJFbpSwBicdQkFyh7ayj+OYPNpfBvqMtHwF512RYxlTaGstBI=
X-Received: by 2002:a1f:90cd:: with SMTP id s196mr1638807vkd.5.1629982808785;
 Thu, 26 Aug 2021 06:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210826121006.685257-1-michael@walle.cc> <20210826121006.685257-2-michael@walle.cc>
In-Reply-To: <20210826121006.685257-2-michael@walle.cc>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Thu, 26 Aug 2021 14:59:57 +0200
Message-ID: <CAH9NwWcFdt=C=aEp48462wXA6Q47CvTVoRQawyZMuPwwgVzzUA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/etnaviv: use PLATFORM_DEVID_NONE
To:     Michael Walle <michael@walle.cc>
Cc:     The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Lukas F . Hartmann" <lukas@mntre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do., 26. Aug. 2021 um 14:10 Uhr schrieb Michael Walle <michael@walle.cc>:
>
> There is already a macro for the magic value. Use it.
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>

I will wait for v2 for the rest of the changes to review.

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 7dcc6392792d..2509b3e85709 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -653,7 +653,7 @@ static int __init etnaviv_init(void)
>                 if (!of_device_is_available(np))
>                         continue;
>
> -               pdev = platform_device_alloc("etnaviv", -1);
> +               pdev = platform_device_alloc("etnaviv", PLATFORM_DEVID_NONE);
>                 if (!pdev) {
>                         ret = -ENOMEM;
>                         of_node_put(np);
> --
> 2.30.2
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
