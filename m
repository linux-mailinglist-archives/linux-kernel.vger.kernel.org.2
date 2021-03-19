Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5164434207B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhCSPE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhCSPE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:04:28 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2BBC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:04:27 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 184so12356814ljf.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7UBFkI1CX111uLLNeagBjcZUDj7ZLwK/yKKbbrE7F4=;
        b=C0YjKyPTMBZyq22wQR2Ycbof9lyp6kIEFLRu6UYQ26FWP6VkAJ6/JQBmjBKV7EWBLz
         BjhEpOYdLpOCiKvWbuMlY5LnupwEyWz7qN62FzhoAFcnZvZlPW2H6oei1qkdrS261jTe
         cTHosaAiMVD2DTGxgfntMAwuKVRCxXruO/HV1d3UJlwRw1dhtmODI/VZVebt44eoVHKr
         EHdA9BGmXBh+Yh7DNRBNpPT+mBcVTSDrrHSbnYeawGFpfI+hVGmjURrSUyP+AJJB3FNJ
         ma1mfG8gPcVpjYL8ar0A97sJPbL0hYyASgAySErAa+xcVCGPXg8f0HQpRuThvNgC3aWm
         RSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7UBFkI1CX111uLLNeagBjcZUDj7ZLwK/yKKbbrE7F4=;
        b=jAC2dszrgbPL5CpGkanycgSecP7dQpeTjcNew6+MZXFashGcRtpWXSUCcLe8pR+2GY
         mKT4H4CTPugT3E0qhCbhLPplfqejz4zWmFMJE+wImdNBNPnar/5zv9crhwcuBaQlBPzH
         eX2SZJt52bru2I0WCax/y3jC9lNF9IUNzhVMNC0swk/IMqBMQA+kbCp83S217agsbkUm
         eZFj2jX3rjXxllYcmlmErQDRAYtOIVQDRFFP1x+aWVCaFk8YVSu9H8bNVMKJKYHoNR1K
         Hsro/GZEthN+K8mjcFuSIUrKtq8xOpBRhocaNDCoEs/xXLXMzUe3l2oDQa7xJHq2SuiA
         Uh/g==
X-Gm-Message-State: AOAM530oV6hrzKztslBzGUlxEjpDOhTIi57SnaNSUVsGlId9CLZTA8Fe
        w+4fZgUsY8mamII2CyvpFCRYvXGUUw9W1qQRho66mst+
X-Google-Smtp-Source: ABdhPJwiVOIxhG/0M7C/3BZhB7apooldQHeENwszsMQq5DkPOjXNNJoqtYweesGkTbY0Y1sukcc+mai7Ig7xojmKim8=
X-Received: by 2002:a2e:b5cd:: with SMTP id g13mr1222346ljn.372.1616166265911;
 Fri, 19 Mar 2021 08:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <1615969652-80225-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1615969652-80225-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Fri, 19 Mar 2021 16:04:14 +0100
Message-ID: <CAMeQTsbRo4_KfS5vpAjSUiOeL6Qn-yMfYPsWTEpmZTmgV7bfOQ@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: use NULL instead of using plain integer as pointer
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 9:27 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> This fixes the following sparse warnings:
> drivers/gpu/drm/gma500/psb_drv.c:303:56: warning: Using plain integer as
> NULL pointer
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied to drm-misc-next

Thanks
Patrik

> ---
>  drivers/gpu/drm/gma500/psb_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
> index 0bcab06..c2aab62 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -303,7 +303,7 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
>
>         ret = -ENOMEM;
>
> -       dev_priv->mmu = psb_mmu_driver_init(dev, 1, 0, 0);
> +       dev_priv->mmu = psb_mmu_driver_init(dev, 1, 0, NULL);
>         if (!dev_priv->mmu)
>                 goto out_err;
>
> --
> 1.8.3.1
>
